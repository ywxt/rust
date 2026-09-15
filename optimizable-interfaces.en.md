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

**Why it is slow**: on aarch64, `(cmp) as usize` is compiled into a **real branch** `b.hi` (x86_64 gets branchless `sbb` and does not have this problem). On random data the sibling comparison is near 50% entropy: 9–21% branch miss rate, IPC crushed to 1.2–1.7. Three independent benchmark sites confirm the same lesion.

**Where the branch comes from** (pinned to a specific pass; full walkthrough in the `benchmarks-conclusion.md` section "`BinaryHeap` sift_down: locating the LLVM origin of the aarch64 child-choice branch"):

- The IR after the middle-end pipeline is branchless: `icmp ule` + `zext i1` + `add`. The branch is inserted by the IR-level pass **`select-optimize`** (`lib/CodeGen/SelectOptimize.cpp`), which the AArch64 backend adds on its own at `opt-level=3`; `-print-after-all` shows `freeze i1` + `br i1` first appearing right after that pass. The x86 backend never runs it.
- The pass treats "a binary operator with a single-use `zext i1` operand" as select-like (`SelectOptimize.cpp:790–843`, `m_c_BinOp(m_Value(), m_OneUse(m_ZExtOrSExt(...)))`), i.e. `child + zext(c)` becomes `select c, child+1, child`.
- It is gated by the subtarget feature `FeatureEnableSelectOptimize` (`enable-select-opt` in `AArch64Features.td`). `generic` (what `target-cpu=native` resolves to on this host) and the tune lists of Neoverse N1/N2/V1/V2, Cortex-A76/A78/X1 and others enable it; Cortex-A53/A55, Apple M-series, tsv110 and a64fx do not, and for those CPUs the output is `cinc x13, x0, ls`.
- Decision as reported by `-C remark=select-optimize`: `Profitable to convert to branch (loop analysis). BranchCost=8.5625, SelectCost=15.0`. The inner-loop cost model prices the branch with a fixed 25% mispredict rate (`-mispredict-default-rate`), while the sibling comparison is close to 50% entropy, so the branch cost is underestimated by roughly a factor of two.
- Reverse check: with `-C llvm-args=-aarch64-select-opt=false` or `-C target-feature=-enable-select-opt`, SelectionDAG emits `cmp; cinc x13, x0, ls`, the aarch64 counterpart of x86's `sbb`.

```text
current (generic):                   select-optimize disabled:
  cmp   x13, x12                       cmp   x13, x12
  b.hi  .LBB1_4                        cinc  x13, x0, ls
  add   x12, x0, #1                    ldr   x14, [x8, x13, lsl #3]
  ldr   x14, [x8, x12, lsl #3]
  ...
.LBB1_4:
  mov   x12, x0
  ldr   x14, [x8, x0, lsl #3]
```

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

**Fragility of the prototype's mechanism**: `select-optimize` checks `!unpredictable` only on its non-loop path (`isConvertToBranchProfitableBase`); the inner-loop path does not. The dump confirms the `select_unpredictable` version is converted to a branch as well (the metadata is merely moved onto the `br`). The final `csel` exists because the machine-level `early-ifcvt` folds the diamond back, and it does so with a margin of one cycle (`-C remark=early-ifcvt`: prototype "condition adds 5 cycles ... under the threshold of 5", current "would add 6 cycles ... exceeding the limit of 5"; the difference is that the prototype's true block is empty while the `zext+add` form carries an extra `add`). With `-disable-early-ifcvt` the prototype degrades to `b.hi` too. Landing therefore requires checking the asm or the remark for the real `Hole<T>` implementation rather than the benchmark numbers alone, and the PR description should name the cause as the `select-optimize` inner-loop heuristic misjudging the `zext+add` select-like shape.

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

### 10. `BTreeMap` in-node search (branchless specialization for primitive integer keys) — in-tree prototype verified

**Interface**: `library/alloc/src/collections/btree/search.rs::find_key_index` — every `get`/`insert`/`remove`/`range` and the corresponding `BTreeSet` entry points go through it.

**Why it is slow**: the early-exit linear scan inside a cap=11 node. The three-way compare itself is already if-converted (`cset/csinv`), but "exit at the first non-`Greater`" is a data-dependent branch whose exit position drifts across the node as accesses sweep through it. Measured on `clone_slim_10k_and_remove_half`: ~2.9 branch misses per `remove` (nearly one per level over 4 levels), search is 86% of `remove` cost, 8.6 ns per node visit.

**Fix** (in-tree prototype, measured 2026-09-07): specialize `find_key_index` through a `min_specialization` internal trait for the 12 primitive integer types — **full nodes only** take an outlined (`#[inline(never)]`, preserving the callers' inlining budget) branchless fixed-length scan (NEON 5×`cmhi`+`addp` / SSE2 `pcmpgtd`), preceded by a three-way first-key guard that keeps the O(1) exit of leftmost-biased patterns; non-full nodes keep the original early-exit loop. All three ingredients are required: an unconditional full scan costs `remove_all` +96% and `find_rand_100` +144%; an inlined body costs `insert_rand` +43% (`search_tree` loses inlining).

**Prototype core** (`search.rs`):

```rust
// search.rs: find_key_index specialized for primitive integer keys via an internal trait; partial nodes keep early-exit
if sub.len() == CAPACITY {
    return spec_full_scan(sub_as_array, key);   // #[inline(never)], preserves callers' inlining budget
}
/* original early-exit loop */

#[inline(never)]
fn spec_full_scan<T: Copy + Ord>(full: &[T; CAPACITY], key: T) -> (usize, bool) {
    if key <= full[0] { return (0, key == full[0]); }        // first-key guard: keeps the O(1) exit of leftmost-biased patterns
    let count = full.iter().filter(|&&k| k < key).count();  // branchless fixed-length count → cmhi×5 + addp
    (count, count < CAPACITY && full[count] == key)
}
```

**Benchmarks** (`./x bench library/alloctests --stage 1`, aarch64; full A/B on 2026-09-15: all 100 btree benches, each variant built separately and swapped into the same harness binary via libstd, key items re-run 3× interleaved, noise <2%; "#10 only" is an isolated build with only search.rs patched):

| benchmark | current | #10 only | #10+#11 | change (#10+#11) |
|---|---:|---:|---:|---:|
| `map::clone_slim_10k_and_remove_half` | 350 µs | 247 µs | 224 µs | **−36%** (branch-miss 3.45%→1.03%, IPC 2.46→3.27) |
| `set::clone_10k_and_remove_half` | 309 µs | 210 µs | 187 µs | **−39%** |
| `map::range_included_included` | 469 µs | 251 µs | 243 µs | **−48%** |
| `map::range_included_excluded` | 440 µs | 262 µs | 253 µs | **−43%** |
| `map::find_rand_10_000` | 61.2 ns | 58.3 ns | 58.5 ns | −4.4% |
| `map::find_{seq,rand}_100` / `insert_*` (6) | — | ±2% | ±2% | flat |
| `map::clone_slim_10k_and_remove_all` | 378 µs | 370 µs | 389 µs | +3% (layout noise) |
| `set::intersection_{pos,neg}_*` (8, absolute 6–10 ns) / `staggered_{100_vs_100,10k_vs_10k}` | 6–10 ns / 0.32–32 µs | +6…+13% | +9…+17% / +7% | **regression** (see below) |
| `set::is_subset_100_vs_10k` / `difference_staggered_*` | 1.36 / 0.78–82 µs | +17% / +12…+20% | +16% / +10…+17% | **regression** |
| `map::range_included_unbounded` | 98.3 µs | 146 µs | 146 µs | **+49%** |
| `set::difference_random_{100,10k}_vs_{100,10k}` (4) | 0.37–46 µs | +50…+82% | +49…+89% | **+89% worst** |

**Regression surface** (not previously reported; must be resolved before landing): the unconditional full scan of a full node performs 11 compares under "key absent from the node and its slot is near the front" access patterns, where the early-exit loop needs 1–2. `difference_random_*` takes `DifferenceInner::Search` (per-element `other_set.contains`, random keys almost always miss) and the lower-bound search of `range_included_unbounded` walks `find_leaf_edges`; perf shows `spec_full_scan` at 58% of samples and instruction count ×1.7–2.0 in both. The first-key guard only rescues "slot = 0", not slots 1–3. Candidate fixes: (a) widen the guard to the first 2–4 keys (cost: 4 `csel`); (b) enable the full scan only on the `remove`/`insert` path (`search_tree` under the `Mut` borrow) and keep early-exit for `Immut` lookups — `difference`/`range`/`contains` are all `Immut`, `remove_half` is `Mut`, so the main gain survives with zero regression; (c) replace popcount with `ctz(movemask)` so the full scan yields the slot directly and the trailing `full[count]` reload disappears. Remaining to-dos: miri, real x86 hardware, drop `u128`. Core micro-benchmark: `/tmp/btree_bench/probe_kernel.rs` (random exit 9.6–9.9 → 3.7–5.1 ns, 1.9–2.7×).

### 11. `BTreeMap::IntoIter` drop's per-element dying walk (`!needs_drop` node-level specialization) — in-tree prototype verified

**Interface**: `impl Drop for BTreeMap`/`IntoIter` in `library/alloc/src/collections/btree/map.rs` (map drop, `clear`, and temporary clones all go through it).

**Why it is slow**: drop calls `deallocating_next` per element (one function call each). In a small crate LLVM inlines it and can collapse the walk over drop-free elements into per-node; in a large multi-call-site crate like the official allocbenches it does not inline — **42% (5.2 ns/element) of `clone_slim_10k`'s 125 µs is this degraded path**, and the subtraction baseline of the whole `clone_slim_10k_and_*` series is inflated ~2.2×.

**Fix** (in-tree prototype, measured): for `!needs_drop::<K>() && !needs_drop::<V>()`, `BTreeMap::drop` takes a new `NodeRef<Dying,_,_,LeafOrInternal>::deallocate_subtree` (navigate.rs): postorder node-level deallocation, structurally O(nodes), no reliance on inlining luck.

**Prototype core** (`map.rs` + `navigate.rs`):

```rust
// map.rs: impl Drop for BTreeMap
if !needs_drop::<K>() && !needs_drop::<V>() {
    root.into_dying().deallocate_subtree(alloc);   // node-level postorder deallocation, no per-element walk
    return;
}

// navigate.rs: walk to the leftmost leaf → deallocate_and_ascend; if the parent edge has a subtree to its right, dive to its leftmost leaf, else keep ascending
let mut node = self.first_leaf_edge().into_node();
while let Some(parent_edge) = node.deallocate_and_ascend(alloc) {
    node = match parent_edge.right_kv() {
        Ok(kv) => kv.right_edge().descend().first_leaf_edge().into_node(),
        Err(last_edge) => last_edge.into_node(),
    };
}
```

**Benchmarks** (same A/B as above; "#11 only" is an isolated build with only map.rs + navigate.rs patched):

| benchmark | current | #11 only | change |
|---|---:|---:|---:|
| `set::clone_100` / `_and_clear` | 1.07 µs | 0.37 µs | **−66%** |
| `set::clone_10k` / `_and_clear` | 111 µs | 40 µs | **−64%** |
| `map::clone_slim_100` / `_and_clear` | 1.14 µs | 0.45 µs | **−60%** |
| `map::clone_slim_10k` / `_and_clear` | 124 µs | 53.0 µs | **−57%** |
| `map::from_iter_seq_100` / `_10_000` | 1.53 / 169 µs | 0.57 / 83 µs | **−62% / −51%** (drop of the temporary map during collection) |
| `set::clone_{100,10k}_and_drain_half` | 1.75 / 171 µs | 1.41 / 140 µs | −19% / −18% |
| `map::clone_slim_{100,10k}_and_drain_half` | 1.43 / 142 µs | 1.26 / 125 µs | −12% |
| `map::clone_fat_val_100_and_clear` | 5.41 µs | 4.72 µs | −13% |
| `*_and_into_iter` (4) | — | +0.2…+4.4% | partially consumed `IntoIter::drop` is still per-element |
| `*_and_pop_all` / `*_and_remove_all` | — | +1…+2% | layout noise |
| remaining 80 | — | ±3% | flat |

No real regressions; all 278 btree tests pass (172 unit + 100 bench-as-test + 6 doc). Residual: the +4% on `clone_*_and_into_iter` comes from a partially consumed `IntoIter` still walking the remainder through per-element `deallocating_next`; reusing `deallocate_subtree` for the remaining subtree in `IntoIter::drop` would close it.

### 6. `flt2dec` Dragon `format_exact` (9 digits per batch + single fused pass) — in-tree prototype verified

**Interface**: `library/core/src/num/imp/flt2dec/strategy/dragon.rs::format_exact` (reached by `{}` formatting of `f64::MAX` and by high-precision `{:.N}`; `grisu::format_exact` falls back to it 100% of the time at high precision).

**Why it is slow** (corrected 2026-09-15): the earlier "one divide-by-10 per digit" description was inaccurate — each decimal digit actually does 4 `mant >= scale{8,4,2,1}` compares + ~2 O(limbs) subtractions on average + one `mul_small(10)`, i.e. ~3–4 passes over 32 limbs per digit; 1024 digits = 42 µs, perf puts 99.3% in `format_exact` itself, IPC 2.4 (pure instruction count, no microarchitectural events).

**Fix** (in-tree prototype):
1. **Quotient estimation replaces per-digit compare-and-subtract**: take a 64-bit window `sdiv` from the top two limbs of `scale` and the matching 96-bit window of `mant`; `q = mant_win × 10^(m−1) / sdiv` yields m ≤ 9 digits at once (the estimate never overshoots and undershoots by a few units at most; corrected with `mant >= scale10`);
2. **Single fused pass**: new `Big32x40::mul_small_sub_mul_small(mul, other, sub)` computes `mant × 10^m − q × scale10` in one pass and trims `size` in the same pass (otherwise `size` creeps up by one limb per round and small numbers degrade 3× — the first version hit this).

Bignum passes drop from ~3.5 per digit to ~1.2 per 9 digits.

**Prototype core** (`dragon.rs` + `bignum.rs`):

```rust
// dragon.rs: the digit loop of format_exact — m ≤ 9 digits per round
let sdiv = top_64bit_window(scale) + 1;                  // computed once; +1 makes the estimate never overshoot
while i < len {
    let m = (len - i).min(9);
    let q = (top_96bit_window(mant) * 10^(m-1) / sdiv) as u32;   // scalar quotient estimate, no bignum work
    mant.mul_small_sub_mul_small(10^m, &scale10, q);     // one pass: mant = mant·10^m − q·scale10
    while mant >= scale10 { mant.sub(&scale10); q += 1; } // fix up the estimate, rare
    emit_digits(q, m); i += m;
}

// bignum.rs: new single-pass self = self·mul − other·sub, trimming size in the same pass (otherwise size grows by one per round and small numbers degrade 3×)
```

**Benchmarks** (`library/coretests/benches/num/flt2dec/`, `./x bench library/coretests --stage 1`; all 39 flt2dec tests pass):

| benchmark | current | prototype | change |
|---|---:|---:|---:|
| `dragon::bench_big_exact_inf` | 42.2 µs | **12.9 µs** | **−69%** (instructions 1.75G→1.02G) |
| `grisu::bench_big_exact_inf` (falls back to dragon) | 42.2 µs | 13.0 µs | **−69%** |
| `dragon::bench_big_exact_12` | 1822 ns | 645 ns | **−65%** |
| `dragon::bench_big_exact_3` | 822 ns | 497 ns | −40% |
| `dragon::bench_small_exact_inf` | 1013 ns | 729 ns | −28% |
| `grisu::bench_small_exact_inf` | 1064 ns | 767 ns | −28% |
| `dragon::bench_small_exact_12` | 152 ns | 82 ns | −46% |
| `dragon::bench_small_exact_3` | 86 ns | 56 ns | −34% |
| `dragon::bench_{small,big}_shortest`, `grisu::*_exact_{3,12}`, `num::flt2dec::*` (9) | — | ±2% | flat (untouched) |

**Regression surface**: none. The remaining cost of `big_exact_3` is `mul_pow10`/`scale` construction (independent of digit count). x86 is structurally identical (`mulx`/`sbb`). A `Big64x20` limb width would halve the passes again; not done.

### 7. `Iterator::array_chunks` (TRA fold loop shape) — in-tree prototype verified

**Interface**: `SpecFold` (the TrustedRandomAccess specialization) in `library/core/src/iter/adapters/array_chunks.rs`.

**Why it is slow** (root cause corrected 2026-09-15): the earlier claim that "the `from_fn` closure accessing the iterator through `&mut self.iter` as a struct field blocks vectorization" **does not hold** — destructuring `iter` into a local leaves the 98 ns unchanged. The real cause is the loop form `while inner_len - i >= N { ...; i += N }`: LLVM cannot derive a trip count (`len - i` is recomputed each iteration and the unsigned subtraction keeps SCEV from proving monotonicity), so LoopVectorizer gives up. Rewriting it as a counted `for c in 0..len / N` loop vectorizes (`ldp q6,q7` + `shl v.2d`). A second finding: **the official harness cannot observe this cliff, and the reason is now pinned to codegen-units**. The same source loop reaches LoopVectorize with one of two exit conditions: `sub len, i_next; icmp ugt _, 7` (SCEV can compute a trip count → vectorized) or `sub len, i; and _, -8; icmp eq _, 8` (a legal InstCombine rewrite that SCEV cannot analyze → scalar). Which one appears depends on the shape of the enclosing function: bootstrap compiles `corebenches` with **16 codegen units** (16 `-cgu.N` names visible in the binary); with multiple CGUs `Bencher::iter::<closure>` has `hidden` rather than `internal` linkage, LLVM does not inline it into the closure's `call_once`, the loop stays inside a standalone `Bencher::iter` function and InstCombine leaves the exit test alone. A single-file `rustc` probe is merged by the partitioner into **1 CGU**, everything inlines into one function, and InstCombine rewrites the exit test into the `and/eq` form before the vectorizer runs. Adding `-Ccodegen-units=2` to the same probe reproduces the official number (98 → 33 ns; the verbatim official bench: 38 ns). But `#[inline(never)] fn(&[u8])` — the most common real-world shape, a function taking a slice — is 98 ns at both 1 and 2 CGUs: it is independent of CGU count, it simply never lands in the lucky function shape. So the official bench is the "happened to land in a good shape" exception, not representative of user code; the counted-loop rewrite gives a uniform 32–39 ns across all shapes.

**Fix**:

**Prototype core** (`array_chunks.rs`):

```rust
// array_chunks.rs: SpecFold (TrustedRandomAccess) — only the loop form changes
- while inner_len - i >= N { ...; i += N }     // LLVM cannot derive a trip count → no vectorization
+ for c in 0..inner_len / N { let i = c * N; ... }   // counted loop → ldp q + shl v.2d
```

**Benchmarks** (probe `/tmp/btree_bench/probe7/probe2.rs`, stage1 rustc `-O`, 1024 B, `#[inline(never)]` boundary; the 9 official `bench_next_chunk_*` including the new `_runtime_len` are all flat within ±3%):

| shape (runtime length) | current | counted loop | change |
|---|---:|---:|---:|
| `map(*b).array_chunks::<8>().map(..).sum()` | 98.1 ns | **32.1 ns** | **3.06×** |
| `copied().array_chunks::<8>()...sum()` | 98.1 ns | 32.0 ns | 3.07× |
| `.array_chunks::<8>().fold(..)` / `.for_each(..)` | 98.1 ns | 32.0 ns | 3.06× |
| inlined into the timing loop (harness shape) | 99.9 ns | 33.5 ns | 2.98× |
| hand-written `as_chunks::<8>()` (ceiling) | 32.1 ns | 32.1 ns | — |
| `while let Some(c) = it.next()` (non-fold path, unaffected) | 705 ns | 705 ns | — |

All 21 array_chunks tests pass; the `try_fold`/`next` paths are untouched. Suggest landing together with the `_runtime_len` variant, noting that it was never slow in the harness so its guard value is limited.

### 8. `BTreeMap::iter` / `iter_mut` (leaf-batched fold) — in-tree prototype verified

**Interface**: `Iter/IterMut/Keys/Values` in `library/alloc/src/collections/btree/map.rs` (previously no fold override).

**Why it is slow**: no microarchitectural events (miss ≈0, IPC 3.6–4.0), pure instruction count — one `next()` state machine per element (18.6 instructions/element vs 4.0 for Vec), including the length decrement, in-leaf bounds check, and a tree climb every 11 elements.

**Fix** (in-tree prototype): `node.rs` gains `NodeRef<{Immut,ValMut}, Leaf>::into_key_val_slices_from(idx)`, borrowing the leaf's keys/vals from `idx..len` as slices; `navigate.rs` gains `LazyLeafRange::fold_unchecked(length, init, f)`: a straight-line `zip` loop within the leaf, and once the leaf is exhausted one `next_kv()` for the ancestor KV plus `next_leaf_edge()` to descend into the next leaf, so the climb cost is amortized per node instead of per element; `Iter/IterMut::fold` in `map.rs` forward to it, `Keys/Values::fold` project through the inner iterator. The `ValMut` version only borrows elements at `idx..`, so it never aliases `&mut V`s already handed out.

**Prototype core** (`navigate.rs` + `node.rs` + `map.rs`):

```rust
// navigate.rs: LazyLeafRange::fold_unchecked — straight-line loop within a leaf, one tree climb per node
let mut edge = self.init_front();
loop {
    let (keys, vals) = edge.node().key_val_slices_from(edge.idx());   // borrow as slices
    let take = keys.len().min(length);
    for (k, v) in zip(&keys[..take], &vals[..take]) { acc = f(acc, (k, v)); }
    length -= take;
    if length == 0 { return acc; }
    let kv = edge.node().last_edge().next_kv();   // leaf exhausted: one ancestor KV
    acc = f(acc, kv.into_kv()); length -= 1;
    edge = kv.next_leaf_edge();                   // descend into the next leaf
}

// map.rs: Iter / IterMut override fold → range.fold_unchecked(length, init, f); Keys / Values project through inner
```

**Benchmarks** (`library/alloctests/benches/btree/map.rs`, new `iteration[_mut]_fold_{20,1000,100000}` drive fold via `for_each`; the "current" column is the same bench on a tree without the fold override; 3 interleaved re-runs):

| benchmark | current (default fold) | prototype | change |
|---|---:|---:|---:|
| `iteration_fold_1000` | 1812 ns | **1030 ns** | **−43%** |
| `iteration_mut_fold_1000` | 1807 ns | 995 ns | **−45%** |
| `iteration_fold_20` | 22.5 ns | 17.1 ns | −24% |
| `iteration_mut_fold_20` | 24.5 ns | 17.4 ns | −29% |
| `iteration_fold_100000` | 358 µs | 329 µs | −8% (cache-bound, 3.3 ns/element) |
| `iteration_mut_fold_100000` | 355 µs | 345 µs | −3% |
| `iteration[_mut]_{20,1000,100000}` (`for` loop, goes through `next()`) | — | ±2% | flat (untouched) |

**Regression surface**: none (all 278 btree tests pass). `for entry in &map` desugars to `next()`, not fold, so the gain only reaches `for_each`/`fold`/`sum`/`count`/`map().collect()`-style consumption; `Range`/`IntoIter`/the `next_back` direction are not done.

---

## Tier 3: Candidate directions (root cause located, fix not prototyped)

(#6, #7 and #8 were prototyped on 2026-09-15 and moved up to Tier 2.)

### 9. `u8::is_ascii_*` predicate family (SWAR/bitset) — fix the benchmark first (2026-09-08 update: the whole family is invalid, including `is_ascii` itself)

**Interface**: `u8::is_ascii_whitespace/digit/alphanumeric/...` in bulk-scan form via `iter().all()`.

**Why it is slow**: a full scan is a 0.52 ns/B per-byte match, vs `<[u8]>::is_ascii` (NEON; probe ground truth 61 GB/s ≈ 0.0164 ns/B) — a **~30× gap**. But none of the existing benchmarks measure the real thing — three layers of breakage (see the `ascii::long::is_ascii` chapter of benchmarks-conclusion): (1) the outer macro's `to_vec()` sits inside the timed loop and accounts for 60–100%; (2) the constant input is partially const-evaluated by LLVM, so `long::is_ascii` scans only ~400 B of 6990 B at runtime (the "is_ascii 0.018 ns/B is valid" figure previously cited here was fabricated and has been retracted); (3) `black_box(&mut vec)` in the `is_ascii.rs` family does not stop loop folding — the n timed iterations of `case00_libcore` collapse into 1 (reports 6.38 ns, ground truth 114.5 ns, 18×).

**Fix**: step one, fix the benchmark (pass the slice *value* through `black_box`, generate inputs at runtime, drop `to_vec`). Only then step two: a 128-bit bitset lookup or SWAR-ized predicate body. `<[u8]>::is_ascii` itself already has a NEON specialization close to the issue ceiling; the only remaining position is a +30–40% from amortizing the `umaxv` reduction over 256 B.

**Benchmarks** (`library/coretests/benches/ascii.rs` + `ascii/is_ascii.rs`): `{short,medium,long}::is_ascii_*` (30) and `is_ascii::{short,medium,long,unaligned_*}::case00–04` (50) — **all currently invalid**. Ground-truth probes: `/tmp/btree_bench/probe_isascii.rs`, `probe_iterall.rs`.

---

## Tier 4: LLVM-side fixes (affect std interfaces, change lives in LLVM)

Summary table; each item is detailed below.

| Fix | Affected interface | Symptom | Gain |
|---|---|---|---:|
| VPlan argmax recognition of `IVOp = IV increment` | `Iterator::max_by_key` and argmax shapes | CGU/inlining context decides vectorization ("codegen lottery") | 3.4× |
| Predictability-aware if-conversion on AArch64 | BinaryHeap, binary_search, and all `(cmp) as usize` / select shapes | x86 and aarch64 backends make opposite branch-vs-select choices, both wrong on one side | 1.5–4.4× |
| Relax requiresScalarEpilogue / predicated epilogue | loops with bounds-checked indexed access | 32 scalar tail iterations forced even when length divides VF (2/3 of runtime) | ~2× |
| ~~Iterator-struct SROA before LoopVectorizer~~ (retracted, see L4) | `array_chunks` | real cause is the `while len-i>=N` loop shape; a one-line std rewrite fixes it (#7) | 3.06× |
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

**Component**: the inner-loop heuristic of the AArch64-only `select-optimize` pass (`lib/CodeGen/SelectOptimize.cpp`, gated by `FeatureEnableSelectOptimize`); `early-ifcvt`; `!unpredictable` metadata handling.

**Root cause**: the two backends make **opposite** static choices on the same IR shapes, and each is wrong on one side of the data-distribution axis:

- `child += (left <= right) as usize` (BinaryHeap): x86 lowers to branchless `sbb`; AArch64 emits a real branch `b.hi`. Located (section 3): the middle-end IR is branchless `zext+add`; `select-optimize` recognizes it as select-like and inserts the branch based on its inner-loop cost model (fixed 25% mispredict rate, `BranchCost=8.56 < SelectCost=15.0`); disabling the pass yields `cinc`. On random heaps the branch is ~50% entropy → 9–21% miss rate, IPC 1.2–1.7. Verified fix at the source level (`select_unpredictable` → `csel`) gives **-34% to -41%**, but that `csel` is produced by `early-ifcvt` folding the diamond back; the loop path of `select-optimize` itself does not read `!unpredictable`.
- The mirror case (`manual_char_len`, UTF-8 stride loop): AArch64 aggressively if-converts to a `csel` chain, converting a 100%-predictable branch into a load-carried data dependency — **4.4× slower** than the branchy form x86 keeps on 2-byte text.

Neither backend is uniformly right; the missing input is *predictability*. The correct cost model is:

```text
branch cost = predicted_cost + P(miss) × miss_penalty      // ≈ free when P(miss) → 0
select cost = csel_latency + (cmp → csel → address → load) chain on the critical path
```

**Fix directions** (complementary, not alternatives):
1. Make the inner-loop path of `select-optimize` (`findProfitableSIGroupsInnerLoops`) honor `!unpredictable` metadata the way the non-loop path already does. Today only `isConvertToBranchProfitableBase` checks it; a `select_unpredictable` inside a loop is still converted to a branch and only survives because `early-ifcvt` happens to fold it back. Nothing pushes the *reverse* direction (marking a branch predictable) either;
2. `MispredictDefaultRate` should not be a fixed 25%: for select-like shapes where `zext(i1)` feeds `add/or` and the result feeds an address chain, the no-profile estimate should assume higher entropy, or the "select-like rather than explicit select" origin should be discounted;
3. With PGO/branch-probability data, refuse if-conversion when the branch is highly biased **and** the select would sit on a load-address critical path (the `manual_char_len` pathology);
4. Without profile data, prefer if-conversion for flag-arithmetic shapes (`(cmp) as usize` additions — the x86 `sbb`/`adc` idiom) where the dependency chain does not feed an address.

**Affected std interfaces/benchmarks**: `binary_heap::bench_{from_vec,find_smallest_1000,pop}` (branch → select wins 34–41%), `str::char_count::case03` (select → branch wins 4.4× on predictable text), `slice::binary_search_*` (select correct for unknown distributions — must not regress).

### L3. LoopVectorizer: drop the forced scalar epilogue when the trip count divides VF

**Component**: LoopVectorizer `requiresScalarEpilogue` / epilogue policy, AArch64 tail-folding defaults.

**Root cause**: loops with a side exit (bounds-check panic) require a scalar epilogue for exactness. The current policy reserves `(n % VF == 0 ? VF : n % VF)` elements for the scalar tail — i.e. **a full VF-sized block runs scalar even when the length divides the vector width**. Measured on `vec::bench_in_place_zip_iter_mut` (256 bytes, VF=32): 7 NEON iterations + **32 forced scalar iterations + per-call alias/min guards = 2/3 of total runtime**, with 64% of samples in the scalar tail. The structure is fixed at IR level — retargeting the same IR to SSE2/AVX2 keeps it, so x86 pays the same tax.

**Fix directions**:
1. When SCEV proves `n % VF == 0` (or emit a cheap runtime check), skip the scalar epilogue entirely;
2. Prefer predicated/masked epilogues where the ISA supports them (SVE `whilelo`, AVX-512 masked ops) — the `-prefer-predicate-over-epilogue` machinery exists but is not the AArch64 default, and rustc's default `generic` CPU never enables SVE anyway.

**Affected benchmarks**: `vec::bench_in_place_zip_iter_mut` (~2× headroom), `vec::bench_in_place_zip_recycle` (same shape), any `iter_mut().enumerate()` loop with indexed side-table access.

### L4. Pipeline: complete iterator-struct SROA before the vectorizer — **retracted 2026-09-15**

**Why retracted**: the root-cause claim here was falsified by the #7 prototype. Destructuring `self.iter` in `ArrayChunks::fold` into a local (removing the struct-field access) leaves the 98 ns unchanged, while keeping the field access and merely rewriting `while len - i >= N` into a counted `for c in 0..len / N` loop vectorizes it to 32 ns. The real cause is that LoopVectorizer cannot compute a trip count for the "unsigned `len - i >= N` with `i += N`" shape, not SROA timing. The earlier "the same shape over a raw slice vectorizes fine" control experiment was flawed: that control used the counted `as_chunks` form, not the same shape.

**Still worth considering on the LLVM side**: teach SCEV/LoopVectorizer to recognize `while (len - i) >= N { i += N }` as a counted loop (`i` monotone, `len - i` decreases by N per iteration, trip count = `(len - N) / N + 1`) — this shape is common in generic iterator code. But the one-line std-side rewrite is sufficient, so this entry is downgraded to low priority.

**Affected benchmarks**: same as #7.

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
| `flt2dec` (Dragon `format_exact`) | `num::flt2dec::strategy::{dragon,grisu}::bench_{small,big}_exact_{3,12,inf}` | **prototype-verified** (big_exact_inf −69%, no regressions) |
| `Iterator::array_chunks` | `iter::bench_next_chunk_trusted_random_access[_runtime_len]` (harness cannot see it; probe 3.06×) | **prototype-verified** (root cause is loop shape, not field access) |
| `BTreeMap::iter[_mut]` fold | `btree::map::iteration[_mut]_fold_{20,1000,100000}` (new) | **prototype-verified** (fold_1000 −43%, no regressions) |
| `u8::is_ascii_*` / `[u8]::is_ascii` | `ascii::*::is_ascii_*` + `ascii::is_ascii::*` (80, **all invalid**) | fix bench first (three-layer breakage located) |
| `BTreeMap` in-node search (integer keys) | `btree::{map,set}::clone_*_and_remove_half`, `range_included_*`, `find_*`, `insert_*`; regressions: `set::difference_*`, `intersection_*`, `range_included_unbounded` | **prototype-verified** (remove_half −36%, range −48%; `difference_random` +89% to fix) |
| `BTreeMap::IntoIter` drop | `btree::{map,set}::clone_*`, `from_iter_seq_*` (baseline side) | **prototype-verified** (clone −57…−66%, no regressions) |
