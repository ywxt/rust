# Optimizable Interfaces Summary

Distilled from the full analyses in `benchmarks-conclusion.md`, keeping **only interfaces with an actionable optimization**. Grouped by verification level: landed in-tree and verified against the official harness, prototype-verified, and candidate directions (root cause located, fix not yet prototyped). Interfaces confirmed to have no optimization headroom (`binary_search`, `starts_with`, `Vec::push`, `HashMap::new`, `PeekMut::deref_mut`, `int_log`, memcmp-class paths) are intentionally excluded.

All numbers are native measurements on a HiSilicon aarch64 machine (2.9 GHz, SVE-256); x86 impact is noted per section.

---

## Tier 1: Landed (in-tree change + official benchmark verification)

### 1. `slice::rotate_left` / `rotate_right` (`ptr_rotate`)

**Interface**: algorithm dispatch in `library/core/src/slice/rotate.rs::ptr_rotate`.

**Why it is slow**: two independent pathologies —
- Large elements (>32B) take the gcd algorithm: it scans the array with a stride of `left × size_of::<T>()` (72 KB per step), causing a 2.16% dTLB miss rate, and the 128-byte temporary is spilled through the stack (a single stack store accounts for 45.8% of samples);
- The swap algorithm degenerates when a subproblem shrinks to `left=2`-like shapes: 1.3 million two-element swaps.

**Fix**:
- Fix A: when a large element's size is a multiple of `usize` and alignment suffices, reinterpret the slice as a `MaybeUninit<usize>` slice and rotate that (rotation is a pure byte permutation), bypassing gcd entirely;
- Fix B: once a swap subproblem's `min(left, right)` fits the 256-byte stack buffer, finish with a single memmove.

```rust
// Fix A (before the three-way dispatch in ptr_rotate, runtime-only via const_eval_select):
if size_of::<T>() > size_of::<[usize; 4]>()
    && size_of::<T>() % size_of::<usize>() == 0
    && align_of::<T>() >= align_of::<usize>()
{
    let ratio = size_of::<T>() / size_of::<usize>();
    return ptr_rotate(left * ratio, mid as *mut MaybeUninit<usize>, right * ratio);
}
// Fix B (at the tail of ptr_rotate_swap's outer loop):
if left.min(right) <= size_of::<BufType>() / size_of::<T>() {
    return ptr_rotate_memmove(left, mid, right);
}
```

**Benchmarks** (`library/alloctests/benches/slice.rs`, all 20 run, no regressions):

| benchmark | speedup |
|---|---:|
| `rotate_huge_by9199_big` | **1.99×** |
| `rotate_huge_by1234577_big` | 1.32× |
| `rotate_huge_half_plus_one` | 1.32× |
| `rotate_medium_half_plus_one` | **3.52×** |
| remaining 16 (tiny/medium/huge, all element types) | flat within ±2% |

x86: same direction (the gcd TLB pathology is milder with 2 MB huge pages; Fix B is platform-independent).

### 2. `char::to_uppercase` / `char::to_lowercase` (Latin-1 fast path)

**Interface**: `library/core/src/unicode/unicode_data.rs::conversions::{to_upper,to_lower}` (note: a generated file — a real PR must change `src/tools/unicode-table-generator` instead).

**Why it is slow**: the fast path only covers up to U+00B5/U+00C0; every other Latin-1 character goes through `lookup`: a binary search over a 185-entry `singles` range table (8 rounds of a serial `csel` dependency chain), and on miss a second search over a 102-entry `multis` table (7 more rounds). **~34% of the inputs (unmapped characters like ¶ · × ÷) pay for the most expensive double search just to return themselves.**

**Fix**: Latin-1 case mappings are frozen by Unicode and trivially simple; cover `c < 0x100` with one match:

```rust
// to_upper, after the existing c < '\u{B5}' fast path:
if c <= '\u{FF}' {
    return match c {
        '\u{B5}' => ['\u{39C}', '\0', '\0'],            // µ → Μ
        '\u{DF}' => ['S', 'S', '\0'],                   // ß → SS
        '\u{E0}'..='\u{FE}' if c != '\u{F7}' =>         // à..þ (except ÷) → −0x20
            [unsafe { char::from_u32_unchecked(c as u32 - 0x20) }, '\0', '\0'],
        '\u{FF}' => ['\u{178}', '\0', '\0'],            // ÿ → Ÿ
        _ => [c, '\0', '\0'],
    };
}
// to_lower is symmetric and simpler: a single '\u{C0}'..='\u{DE}' (except '\u{D7}') +0x20 range.
```

**Benchmarks** (`library/coretests/benches/char/methods.rs`, all 6 improved, `char::` tests 37+13 all pass):

| benchmark | baseline | after both patches | change |
|---|---:|---:|---:|
| `bench_non_ascii_char_to_uppercase` | ~166 µs | 28.97 µs | **-82.8%** |
| `bench_non_ascii_char_to_lowercase` | 120.98 µs | 26.47 µs | **-78.1%** |
| `bench_ascii_mix_to_uppercase` | 94.97 µs | 24.79 µs | -73.9% |
| `bench_ascii_mix_to_lowercase` | 70.64 µs | 23.83 µs | -66.3% |
| `bench_ascii_char_to_uppercase` | 24.67 µs | 21.19 µs | -14.1% |
| `bench_ascii_char_to_lowercase` | 24.67 µs | 21.19 µs | -14.1% |

x86: table-structure-level optimization, platform-independent, gains carry over.

---

## Tier 2: Prototype-verified (not landed)

### 3. `BinaryHeap` sift_down family (sibling child choice)

**Interface**: the `child += (left <= right) as usize` line in `sift_down_range` and `sift_down_to_bottom` in `library/alloc/src/collections/binary_heap/mod.rs`; reached via three public entry points: `BinaryHeap::from(Vec)`, `pop`, and `PeekMut::drop`.

**Why it is slow**: the aarch64 backend compiles `(cmp) as usize` into a **real branch** `b.hi` (x86_64 gets branchless `sbb` and does not have this problem). On random data the sibling comparison is near 50% entropy: 9–21% branch miss rate, IPC crushed to 1.2–1.7. Three independent benchmark sites confirm the same lesion.

**Fix**: select the child index with `hint::select_unpredictable` (generates `csel` on aarch64, `cmova` on x86 — no x86 regression):

```rust
// inside sift_down_range, replacing child += (...) as usize:
let right_is_greater = unsafe { hole.get(child) <= hole.get(child + 1) };
child = hint::select_unpredictable(right_is_greater, child + 1, child);
```

**Benchmarks** (`library/alloctests/benches/binary_heap.rs`):

| benchmark | current | select prototype | change | branch misses |
|---|---:|---:|---:|---:|
| `bench_from_vec` | 608 µs | ~390 µs | **-41%** | -74.5% |
| `bench_find_smallest_1000` | 263 µs | ~173 µs | **-37%** | -81.9% |
| `bench_pop` | 438 µs | ~281 µs | **-34%** | -97.6% |

**Regression surface** (must be evaluated before landing): ascending input regresses from_vec by +6%; gains vanish for 72-byte elements; expensive comparators untested. The `pop` workload's input is inherently high-entropy, so its regression risk is lowest.

### 4. `str::chars().count()` (NEON specialization of `count_chars`)

**Interface**: `library/core/src/str/count.rs::do_count_chars`.

**Why it is slow**: two LLVM auto-vectorization pathologies — the 4-usize unrolled loop is recognized as an interleave group and lowered to low-throughput `ld4` interleaved loads; the 256 B/iteration unroll exceeds the register budget, causing 8 stack-spill round trips inside the loop. Portable source-level rewrites do not help (same shape is regenerated) — this is a target-specific cost-model problem.

**Fix**: explicit NEON under `#[cfg(target_arch = "aarch64")]` — the continuation-byte test is exactly one `cmge`:

```rust
// 64 B/iteration, 4 u8 accumulators, drained via vaddlvq_u8 every ≤255 rounds:
let m = vcgeq_s8(chunk, vdupq_n_s8(-64));   // non-continuation byte → 0xFF
acc = vsubq_u8(acc, m);                      // −0xFF ≡ +1
```

**Benchmarks** (`library/coretests/benches/str/char_count.rs`, the case00 group × 4 languages × 5 sizes):

| size | libcore | NEON prototype | speedup |
|---|---:|---:|---:|
| huge (300–360 KB) | 15.7–16.0 GB/s | **49.3–49.6 GB/s** | **3.1×** |
| large (~5 KB) | 15.8 GB/s | 52.8 GB/s | 3.3× |
| medium (~670 B) | 14.0 GB/s | 23.2 GB/s | 1.66× |
| small/tiny | — | — | keep the current path below 64 B to zero out the regression |

x86: SSE2 auto-vectorization may not share this pathology — measure before specializing. SVE upside is <30% (bandwidth-bound); NEON already captures most of the headroom.

### 5. `Vec::dedup` (vectorized chunked prescan)

**Interface**: the read-only prescan phase of `library/alloc/src/vec/mod.rs::dedup_by`; the landable spot is `dedup()` (`T: PartialEq`) behind specialization restricted to bitwise-eq types.

**Why it is slow**: the prescan is a scalar adjacent-compare loop with per-element early exit (~7 instructions/element at IPC 5.26 — already at the scalar limit); the early-exit semantics plus an arbitrary `FnMut` closure make LLVM auto-vectorization impossible.

**Fix**: process 16-element blocks with an exit-free reduction (LLVM vectorizes it to `cmeq`), then rescan the hit block scalar-wise for the exact index. **`get_unchecked` is mandatory** — with bounds checks the loop does not vectorize at all and the gain collapses from 3× to 8%:

```rust
while i + N <= len {
    let mut any = false;
    for j in 0..N {
        any |= unsafe { v.get_unchecked(i + j) == v.get_unchecked(i + j - 1) };
    }
    if any { /* scalar rescan of the block, return exact first index */ }
    i += N;
}
```

**Benchmarks** (`library/alloctests/benches/vec.rs`):

| benchmark | scalar | chunk16 | sve2x (inline asm) |
|---|---:|---:|---:|
| `bench_dedup_none_100` | 42.3 ns | **13.0 (-69%)** | 12.6 |
| `bench_dedup_none_1000` | 427 ns | 121 (-72%) | **107** |
| `bench_dedup_none_10000` | 4.77 µs | 1.32 (-72%) | **1.14** |
| `bench_dedup_none_100000` | 59.7 µs | same ratio | — |
| `bench_dedup_all_*` / `bench_dedup_random_*` (immediate hit) | 1.4 ns | 2× regression | needs a hybrid scalar-first start |

x86: gains carry over structurally; AVX2's steady-state instruction count (9/block) beats NEON's (13/block), so expect equal or better.

---

## Tier 3: Candidate directions (root cause located, fix not prototyped)

### 6. `flt2dec` Dragon `format_exact` (digit batching)

**Interface**: `library/core/src/num/imp/flt2dec/strategy/dragon.rs::format_exact` (reached by `{}` formatting of `f64::MAX` and by high-precision `{:.N}`; `grisu::format_exact` falls back here 100% of the time at high precision).

**Why it is slow**: each decimal output digit performs one O(limbs) divide-by-10 over the whole `Big32x40` (`umulh` reciprocal multiply) — O(digits × limbs), quadratic; 32-bit limbs digest only half a word per iteration on 64-bit hardware. 1024 output digits = 42 µs.

**Fix** (two orthogonal, stackable levers):
1. Divide by 10⁹ per round, extracting 9 digits at a time — bignum operation count ÷9 (the standard ryū/dragonbox technique);
2. `Big64x20` (64-bit limbs) — halves the iteration count of every loop.

```rust
// today:  loop { let d = mant.div_rem_small(10); out.push(d) }
// change: loop {
//     let r = mant.div_rem_small(1_000_000_000);  // one O(limbs) pass eats 9 digits
//     out.extend(expand_9_digits(r));              // pure scalar expansion, no bignum
// }
// Note: format_exact's limit-truncation and rounding-carry logic must be reworked accordingly.
```

**Benchmarks** (`library/coretests/benches/num/flt2dec/`): `strategy::dragon::bench_{small,big}_exact_{3,12,inf}`, `strategy::dragon::bench_{small,big}_shortest`, `strategy::grisu::bench_{small,big}_exact_inf` (via fallback). Expected: several-fold for the exact_inf class (division count ÷9), ~1.5–2× for the shortest class. x86 isomorphic (`mulx/adc`), platform-independent.

### 7. `Iterator::array_chunks` (TRA fold vectorization cliff)

**Interface**: the `SpecFold` (TrustedRandomAccess specialization) in `library/core/src/iter/adapters/array_chunks.rs`.

**Why it is slow**: the `from_fn` closure accesses the iterator through `&mut self.iter` (struct fields); the accesses still have struct-memory form when the IR reaches LoopVectorizer, and vectorization is abandoned — **only when the length is not a compile-time constant** (the official bench's `vec![1u8; 1024]` inlines to a visible length, so it never sees this cliff). The same loop shape over a raw slice vectorizes fine, proving `from_fn` itself is not the culprit.

**Fix**: when the inner iterator is reducible to a contiguous slice (`slice::Iter`/`Copied`/`Cloned`), make fold take an `as_chunks`-style blockwise path; requires case-by-case equivalence arguments for non-contiguous TRA sources (`vec::IntoIter` drop responsibility, `Zip` dual buffers, `Map` side-effect ordering). Alternatively fix it in LLVM: complete iterator-struct SROA before the vectorizer runs.

```rust
// User-side workaround (usable today, 2.9× faster):
let (chunks, _) = bytes.as_chunks::<8>();
chunks.iter().map(|c| u64::from_ne_bytes(*c))...
```

**Benchmarks** (`library/coretests/benches/iter.rs`): `bench_next_chunk_trusted_random_access` (37.6 ns, healthy as-is — but the same chain at runtime length is 98.0 vs 33.4 ns, a 2.9× cliff; recommend adding a `black_box(len)` variant to guard it).

### 8. `BTreeMap::iter` / `iter_mut` (leaf-batched fold)

**Interface**: `Iter/IterMut` in `library/alloc/src/collections/btree/map.rs` (no fold/try_fold overrides).

**Why it is slow**: no microarchitectural events (miss ≈0, IPC 3.64) — pure instruction count: one `next()` state machine per element (18.6 instructions/element vs 4.0 for Vec), including length decrement, in-leaf boundary checks, and a tree climb every 11 elements.

**Fix**: implement `fold` to emit elements a leaf node at a time, amortizing the tree climb from per-element to per-node:

```rust
// Conceptual shape (real implementation lives in the navigate layer):
fn fold<B, F>(self, init: B, mut f: F) -> B {
    let mut acc = init;
    for leaf in self.leaves() {                          // tree climb: once per node
        for kv in leaf.kv_slice() { acc = f(acc, kv) }   // in-leaf: straight-line loop
    }
    acc
}
```

**Benchmarks** (`library/alloctests/benches/btree/map.rs`): `iteration_20/1000/100000`, `iteration_mut_20/1000/100000`. Estimated ceiling 20–40% (benefits only `for`/fold-style consumption); non-trivial engineering in the navigate layer.

### 9. `u8::is_ascii_*` predicate family (SWAR/bitset) — fix the benchmark first

**Interface**: `u8::is_ascii_whitespace/digit/alphanumeric/...` in bulk-scan form via `iter().all()`.

**Why it is slow**: a full scan is a 0.52 ns/B per-byte match, vs 0.018 ns/B for `is_ascii` (SWAR) — a **29× gap**. But the existing benchmarks (`ascii::{short,medium,long}::is_ascii_*`) cannot see it: the input short-circuits these predicates within the first few bytes, and the measured 190 ns is entirely the harness's `to_vec()` memcpy.

**Fix**: step one, fix the benchmark (drop `to_vec()` from the `@iter` macro arm; add all-true inputs). Only then step two: a 128-bit bitset lookup or SWAR-ized predicate body.

**Benchmarks** (`library/coretests/benches/ascii.rs`): `{short,medium,long}::is_ascii_{whitespace,digit,control,uppercase,lowercase,alphabetic,alphanumeric,hexdigit,punctuation,graphic}` (all currently invalid; only `is_ascii` measures real work).

---

## Tier 4: LLVM-side fixes (affect std interfaces, change lives in LLVM)

Summary table; each item is detailed below.

| Fix | Affected interface | Symptom | Gain |
|---|---|---|---:|
| VPlan argmax recognition of `IVOp = IV increment` | `Iterator::max_by_key` and argmax shapes | CGU/inlining context decides vectorization ("codegen lottery") | 3.4× |
| Predictability-aware if-conversion on AArch64 | BinaryHeap, binary_search, and all `(cmp) as usize` / select shapes | x86 and aarch64 backends make opposite branch-vs-select choices, both wrong on one side | 1.5–4.4× |
| Relax requiresScalarEpilogue / predicated epilogue | loops with bounds-checked indexed access | 32 scalar tail iterations forced even when length divides VF (2/3 of runtime) | ~2× |
| Iterator-struct SROA before LoopVectorizer | `array_chunks` and adapter chains | struct-field access defeats vectorization at runtime lengths | 2.9× |
| AArch64 interleave-group cost model (`ld4` + spills) | `str::chars().count()` and similar SWAR counting loops | symmetric lanes lowered to interleaved `ld4` + 8 stack spills per iteration | 3.1× |

### L1. VPlan: accept `IVOp = IV increment` in argmax recognition

**Component**: LoopVectorizer, `llvm/lib/Transforms/Vectorize/VPlanConstruction.cpp` — the FindLastIV / min-max multi-use reduction matcher. The limitation is already documented in-tree:

```cpp
// TODO: Support cases where IVOp is the IV increment.
if (!match(IVOp, m_TruncOrSelf(m_VPValue(IVOp))) ||
    !isa<VPWidenIntOrFpInductionRecipe>(IVOp))
  return false;
```

**Root cause**: the matcher requires the `select`'s candidate index to be an induction **PHI**. If earlier passes canonicalize the loop so the candidate is the PHI's **increment** (`iv + 1`), recognition fails — even though ScalarEvolution already proves `%iv.next = {1,+,1}`. Which form survives to the vectorizer depends on CGU partitioning and inlining context, hence the "codegen lottery": identical Rust source vectorizes under `-Ccodegen-units=16` and stays scalar under CGU=1.

Minimal IR evidence (all three verified with `opt -passes=loop-vectorize` and `lli` cross-checking, including last-wins tie semantics):

```llvm
; A (rejected):                          ; B (accepted):
%iv.next = add nuw i64 %iv, 1            %cand = phi i64 [ 1, %ph ], [ %cand.next, %loop ]
%idx = select i1 %ge, i64 %old,          %idx = select i1 %ge, i64 %old, i64 %cand
       i64 %iv.next                      %cand.next = add i64 %cand, 1
; C = A + one extra PHI equal to iv+1, select uses the PHI → vectorizes.
```

`-force-vector-width=4` does not rescue A — this is pattern admission, not cost modeling.

**Fix**: extend the matcher to accept the increment of a recognized induction (the value is `{start+step,+,step}`; the vector recipe only needs its splat offset adjusted). Ship the A/B/C IR triple as regression tests, asserting last-wins semantics survive.

**Verified gain**: spike-1638 input 1398 → 412 ns, random-100k 85.4 → 24.8 µs (**3.4×**) — measured by comparing the two CGU shapes of the same Rust code.

### L2. AArch64: predictability-aware branch-vs-select decisions

**Component**: AArch64 if-conversion (SelectionDAG/early-ifcvt) plus `!unpredictable` metadata handling.

**Root cause**: the two backends make **opposite** static choices on the same IR shapes, and each is wrong on one side of the data-distribution axis:

- `child += (left <= right) as usize` (BinaryHeap): x86 lowers to branchless `sbb`; AArch64 keeps a real branch `b.hi`. On random heaps the branch is ~50% entropy → 9–21% miss rate, IPC 1.2–1.7. Verified fix at the source level (`select_unpredictable` → `csel`) gives **-34% to -41%**.
- The mirror case (`manual_char_len`, UTF-8 stride loop): AArch64 aggressively if-converts to a `csel` chain, converting a 100%-predictable branch into a load-carried data dependency — **4.4× slower** than the branchy form x86 keeps on 2-byte text.

Neither backend is uniformly right; the missing input is *predictability*. The correct cost model is:

```text
branch cost = predicted_cost + P(miss) × miss_penalty      // ≈ free when P(miss) → 0
select cost = csel_latency + (cmp → csel → address → load) chain on the critical path
```

**Fix directions** (complementary, not alternatives):
1. Honor `!unpredictable` metadata (already emitted by `core::hint::select_unpredictable`) as a hard preference for select on AArch64 — today it works, but nothing pushes the *reverse* direction;
2. With PGO/branch-probability data, refuse if-conversion when the branch is highly biased **and** the select would sit on a load-address critical path (the `manual_char_len` pathology);
3. Without profile data, prefer if-conversion for flag-arithmetic shapes (`(cmp) as usize` additions — the x86 `sbb`/`adc` idiom) where the dependency chain does not feed an address.

**Affected std interfaces/benchmarks**: `binary_heap::bench_{from_vec,find_smallest_1000,pop}` (branch → select wins 34–41%), `str::char_count::case03` (select → branch wins 4.4× on predictable text), `slice::binary_search_*` (select correct for unknown distributions — must not regress).

### L3. LoopVectorizer: drop the forced scalar epilogue when the trip count divides VF

**Component**: LoopVectorizer `requiresScalarEpilogue` / epilogue policy, AArch64 tail-folding defaults.

**Root cause**: loops with a side exit (bounds-check panic) require a scalar epilogue for exactness. The current policy reserves `(n % VF == 0 ? VF : n % VF)` elements for the scalar tail — i.e. **a full VF-sized block runs scalar even when the length divides the vector width**. Measured on `vec::bench_in_place_zip_iter_mut` (256 bytes, VF=32): 7 NEON iterations + **32 forced scalar iterations + per-call alias/min guards = 2/3 of total runtime**, with 64% of samples in the scalar tail. The structure is fixed at IR level — retargeting the same IR to SSE2/AVX2 keeps it, so x86 pays the same tax.

**Fix directions**:
1. When SCEV proves `n % VF == 0` (or emit a cheap runtime check), skip the scalar epilogue entirely;
2. Prefer predicated/masked epilogues where the ISA supports them (SVE `whilelo`, AVX-512 masked ops) — the `-prefer-predicate-over-epilogue` machinery exists but is not the AArch64 default, and rustc's default `generic` CPU never enables SVE anyway.

**Affected benchmarks**: `vec::bench_in_place_zip_iter_mut` (~2× headroom), `vec::bench_in_place_zip_recycle` (same shape), any `iter_mut().enumerate()` loop with indexed side-table access.

### L4. Pipeline: complete iterator-struct SROA before the vectorizer

**Component**: pass ordering / SROA aggressiveness ahead of LoopVectorizer.

**Root cause**: `ArrayChunks<Map<slice::Iter>>::fold` accesses elements via `__iterator_get_unchecked(&mut self.iter, idx)`; the closure captures `&mut` to the iterator, so loads still have struct-field form (`slice::Iter { ptr, end }`) when the IR reaches the vectorizer, which gives up. Later passes then clean the scalar loop into tidy `ldr/ror/add` — too late. Proof of innocence for the loop shape itself: the identical `while len - i >= 8` + `from_fn(get_unchecked(i + local))` pattern over a **raw slice** vectorizes fine (34.6 ns vs 98.0 ns for the real adapter chain at runtime length; both `Map` and `Copied` outer layers reproduce it, so the closure layer is not the trigger).

**Fix**: either run/repeat SROA on the iterator alloca before LoopVectorizer so `ptr`/`end` become scalars, or teach the vectorizer to treat loop-invariant struct-field bases with affine offsets as vectorizable. The std-side alternative (blockwise specialized fold for contiguous TRA sources) is heavier and needs per-source equivalence arguments (`vec::IntoIter` drop responsibility, `Zip` dual buffers).

**Affected benchmarks**: `iter::bench_next_chunk_trusted_random_access` — healthy as written (compile-time length), 2.9× cliff at runtime length; a `black_box(len)` variant should be added to make the cliff visible to CI.

### L5. AArch64 cost model: interleave groups chosen for symmetric lanes (`ld4` + spills)

**Component**: LoopVectorizer interleave-group formation + AArch64 TTI costs; register-pressure heuristics for wide unrolls.

**Root cause**: the 4-usize SWAR counting loop in `core::str::count::do_count_chars` is recognized as an interleave group and lowered to `ld4` interleaved loads — but all four lanes compute the same reduction, so de-interleaving is pure waste, and `ld4` throughput on this core is far below plain `ldp`. The chosen 256 B/iteration unroll simultaneously blows the register budget: 8 stack-spill round trips inside the hot loop (`ldr q3, [sp]`/`str q, [sp]` ≈ 23% of samples). Portable source rewrites (independent accumulators etc.) regenerate the same shape — confirmed cost-model, not canonicalization.

**Fix directions**: penalize interleave groups whose member lanes are use-symmetric (no lane-crossing consumers); cap unroll width by live-range pressure on AArch64. Either alone removes most of the gap; the explicit-NEON prototype (one `cmge` + `vsubq_u8` byte accumulators) quantifies the ceiling.

**Verified gain**: 15.7–16.0 → 49.3–49.6 GB/s (**3.1×**) on `str::char_count::case00_libcore` huge inputs; the same pathology taxes `case01` (premature widening of mask lanes to 64-bit — a related but distinct cost-model gap worth a look in the same pass).

---

## Index: interface → benchmarks

| Interface | Benchmarks | Status |
|---|---|---|
| `slice::rotate_*` | `slice::rotate_{tiny,medium,huge}_*` (20) | **landed** |
| `char::to_{upper,lower}case` | `char::methods::bench_{non_ascii,ascii_mix,ascii}_char_to_{upper,lower}case` (6) | **landed** (must move into generator) |
| `BinaryHeap` (sift_down) | `binary_heap::bench_{from_vec,find_smallest_1000,pop}` | prototype-verified |
| `str::chars().count()` | `str::char_count::case00_libcore::*` (20) | prototype-verified |
| `Vec::dedup` | `vec::bench_dedup_{none,all,random,slice_truncate}_{100..100000}` | prototype-verified |
| `flt2dec` (Dragon) | `num::flt2dec::strategy::{dragon,grisu}::*` (exact_inf/shortest classes of 19) | candidate |
| `Iterator::array_chunks` | `iter::bench_next_chunk_trusted_random_access` (+ proposed runtime-length variant) | candidate |
| `BTreeMap::iter[_mut]` | `btree::map::iteration[_mut]_{20,1000,100000}` | candidate |
| `u8::is_ascii_*` | `ascii::{short,medium,long}::is_ascii_*` (30, harness must be fixed first) | candidate (fix bench first) |
