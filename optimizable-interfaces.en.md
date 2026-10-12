# Optimizable Interfaces Summary

Distilled from the full analyses in `benchmarks-conclusion.md`, keeping **only interfaces with an actionable optimization**. Grouped by verification level: landed in-tree and verified against the official harness, prototype-verified, and candidate directions (root cause located, fix not yet prototyped). Interfaces confirmed to have no optimization headroom (`binary_search`, `starts_with`, `Vec::push`, `HashMap::new`, `PeekMut::deref_mut`, `int_log`, memcmp-class paths, `<&mut [u8] as Write>::write` — its −25% on `bench_write_slice` is specific to the harness's `black_box(&wr)` shape and regresses real serialization shapes by 4–7%; `Vec` in-place collect — more than half of `bench_in_place_xxu8_*` is glibc malloc/calloc/memset, the loop is already at NEON throughput, and the 83% slower `_i0` is calloc bypassing tcache, and `u128_0100_i0` likewise is 53% `_int_malloc` with the loop at 0.31 ns/element store throughput; `VecDeque::extend(&[T])` — 77% of `bench_extend_bytes` is a 512 B memcpy, bookkeeping is 2 ns; `<dyn Any>::downcast_ref` — its 3.2 ns is one non-devirtualizable vtable call + a 128-bit compare, the compare itself costs 0.02 ns, and the only 0.2 ns of headroom is the AArch64 sret return caused by `TypeId`'s array layout, a compiler-side matter; `FilterMap::next_chunk` — already a branchless compaction loop at 2.4 cycles/element, within 10% of the scan-only floor, `Filter::next_chunk` is the same code and its 17% gap is the inherent 8 B store of `&T` items; `HashSet::difference` / `symmetric_difference` — the former's 91 ns is 10 `contains` calls at SipHash 5.9 + probe 3.7 ns each; the latter's 892 ns comes from scanning both directions, so it costs `|A|+|B|` (110) lookups rather than 10 — both are deliberate HashDoS cost plus semantics, one line of `FxHash` gives −65%; `format!` of short integers — the six `write_u*_{min,max}` benches sit at 51–63 ns, ~73% of which is the allocation chain from an empty-capacity `String` (`malloc`/`finish_grow`/`free`), the rest being fmt dispatch and conversion (same value across types differs by ≤0.8 ns; 1–3 digits by ≤0.6 ns — see the `write_u8_max` chapter); the AArch64 frontend stall is layout-sensitive by 4–5× (the old libstd's 44.8 ns `u64::MAX` is such a case; on every current libstd both types are ~52 ns); `estimated_capacity()=8` is moot now that the gap is gone; `BTreeMap::from_iter` — 65% of `from_iter_rand_10_000` is the generic driftsort at 13.8 ns/element, normal for a comparison sort, `bulk_push` is 5.7 ns/element and 3.3× faster than per-element insert; the `Enumerate`/`Map`/`sum` chain — in `bench_enumerate_ref_sum` the counter is fused into the induction variable, 35% of the 7-instruction loop is `black_box`'s stack round-trip, and ref ≡ value; `uN::deposit_bits`/`extract_bits` with a constant mask — `prepare()` is fully constant-folded, 28 NEON ops per 16 elements is at throughput, the 22% headroom needs mask-structure specialization; unused x86 BMI2 `pdep` / SVE2 `BDEP` is a platform-side lead; forward `str::char_indices().count()` — it is the SWAR `count_chars` at 11 ns, nothing to do; its `_rev` sibling's defect is in `Rev::count`, see §13; `[u8]::make_ascii_uppercase` — `ascii::*::case06_libcore` is already auto-vectorized to 0.029 ns/B, the sibling `case07/08_fake_simd` are hand-written in-bench references that are wrong (FIXME carry bug) and 57% slower, not a std interface; the medium/short tiers are 76–98% `to_vec`; `[u8]::cmp` → `memcmp` — 64% of `sort_unstable_large_strings` is memcmp's entry dispatch for comparisons decided by the first byte on average, but 8 inlined-prefix comparators each regress 5–44% on some of 6 input distributions, memcmp is the robust compromise; `<[T]>::to_vec` — `bench_from_slice_0100`'s 27 ns is malloc/free 12 + memcpy 12 + 2.6 bookkeeping, the `Copy` specialization is already one allocation and one copy; `VecDeque::Iter::try_fold` — `bench_try_fold`'s `Some(a+b)` never short-circuits and is folded into a 4-accumulator NEON reduction at 0.046 ns/element, same code as `sum`) are intentionally excluded.

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

### 12. `for` loops over `VecDeque::iter` / `iter_mut` (register rotation from the inlined swap in `next()`) — in-tree prototype verified

**Interface**: `Iter::next`/`next_back` in `library/alloc/src/collections/vec_deque/{iter,iter_mut}.rs` (`for x in &deque`, `while let Some = it.next()`, and every adapter chain driven through `next()`; `fold`/`sum`/`try_fold` have overrides and are unaffected).

**Why it is slow**: when `i1` runs dry, `next()` does `mem::swap(i1, i2)` and retries. Once inlined into a `for` loop, LLVM SROAs the two `slice::Iter`s' 4 words into registers, and the loop-header phis must merge the "not swapped" and "swapped" incoming edges — a register **permutation** that regalloc can only realize by inserting copies on the back-edge: **6 of the 10 instructions** in the hot loop are `mov`s, 2.0 cycles per element (IPC 4.96, branch-miss 0.1% — pure instruction count). `iter().sum()` on the same deque goes through the `fold` override and takes 48 ns — the `for` loop is 14× slower. A `for` over `Chain<slice::Iter, slice::Iter>` has the same disease (683 ns).

**Fix** (in-tree prototype): outline the `None` arm into `#[cold] #[inline(never)] fn next_slow()`, so only `i1`'s `ptr/end` stay live inside the loop and the back-edge carries no copies; `next_back` symmetrically. Zero change to semantics, layout or API.

**Prototype core** (`iter.rs` / `iter_mut.rs`):

```rust
fn next(&mut self) -> Option<&'a T> {
    match self.i1.next() { Some(v) => Some(v), None => self.next_slow() }
}
#[cold] #[inline(never)]
fn next_slow(&mut self) -> Option<&'a T> { mem::swap(&mut self.i1, &mut self.i2); self.i1.next() }
```

**Benchmarks** (`library/alloctests/benches/vec_deque.rs`, 3 interleaved runs; all 187 vec_deque tests pass):

| benchmark | current | prototype | change |
|---|---:|---:|---:|
| `bench_iter_1000` | 696 ns | **479–484 ns** | **−31%** (instructions 4.62G→3.29G, hot loop 10→5 insns) |
| `bench_mut_iter_1000` | 696 ns | **481 ns** | **−31%** |
| probe `.rev()` contiguous / wrapped | 894 / 907 ns | ~560 | ≈ −37% |
| `bench_try_fold` | 64–77 ns | 45–52 ns | noise (`try_fold` does not go through `next`) |
| `bench_into_iter*` (4) | — | −40%…+4% across two builds of the same patch | **pure layout noise**, unusable as a guard |
| remaining `vec_deque::*` (11) | — | ±1% | flat |

**Follow-up candidate**: represent the second segment as `Option<&[T]>` with a loop-form `next` (probe 357–478 ns, another −25…−35%), but that rewrites every `Iter` method and the `as_slices` semantics. A `for` loop can never reach `sum()`'s 48 ns — the two-segment state machine does not vectorize; use `fold`/`sum`/`as_slices` for speed. x86: same mechanism (IR-level phi permutation), not measured.

### 13. `Rev<I>::count` (missing forward `count` forwarding) — in-tree prototype verified

**Interface**: `impl Iterator for Rev<I>` in `library/core/src/iter/adapters/rev.rs` — every `.rev().count()`, most visibly on `str::Chars`/`CharIndices` (which have a SWAR forward `count`).

**Why it is slow**: `Rev` overrides `advance_by→advance_back_by`, `nth→nth_back`, `fold→rfold`, but not `count`; the default `count` goes through `fold`→`rfold` and walks backwards element by element — `Chars`' reverse decode is ~8 instructions + a poorly predicted branch per char, while forward `count_chars` is 0.23 ns/B SWAR. `count()`'s result is direction-independent.

**Fix** (in-tree prototype): `fn count(self) -> usize { self.iter.count() }`. **Landing must use an internal specialization trait**: a blanket forward changes the order of closure side effects in `Rev<Map<..>>` from reverse to forward (`count` is documented as repeated `next`); specializing for pure sources (`Chars`/`CharIndices`/`Bytes`/`slice::Iter`) keeps semantics unchanged.

**Prototype core**:

```rust
// rev.rs — prototype (blanket); land as SpecRevCount: default → rfold count, pure sources → self.iter.count()
#[inline]
fn count(self) -> usize { self.iter.count() }
```

**Benchmarks** (`library/alloctests/benches/str.rs`; coretests rev/iter 357 + alloctests 113 tests pass):

| benchmark | current | prototype | change |
|---|---:|---:|---:|
| `str::char_indicesator_rev` | 34.9 ns | **11.2 ns** | **−68%** |
| `str::char_iterator_rev` | 48.0 ns | **11.5 ns** | **−76%** |
| probe `chars().rev().count()` 4 KB | 2165 ns | 239 ns | **9.1×** (= forward) |
| `str::char_indicesator` / other 5 | 11.3 | 11.4 | flat |

### 16. Serial per-digit multiply-add chain in `from_str_radix(_, 10)` (8-digit SWAR fast path) — in-tree prototype verified

**Interface**: `library/core/src/num/mod.rs::from_ascii_bytes_radix_impl` (`str::parse::<{u32,u64,i32,i64}>()`, `from_str_radix(_, 10)`).

**Why it is slow**: one `result = result * 10 + digit` per digit, a serial dependency chain through a 3–4-cycle `mul` — ~1.3 ns/digit, 25.5 ns for a 19-digit string; perf puts 30% on the `mul`.

**Fix** (in-tree prototype): for `radix == 10`, 32/64-bit types and ≤19 digits, validate and combine 8 digits at a time with SWAR (one check + three multiplications), no per-digit overflow checks (≤19 digits cannot overflow a `u64`), one final MAX compare; >19 digits keep the checked loop.

**Prototype core**:

```rust
fn parse_8_decimal_digits(chunk: u64) -> Option<u64> {
    let v = chunk.wrapping_sub(0x3030_3030_3030_3030);
    if (v | v.wrapping_add(0x7676_7676_7676_7676)) & 0x8080_8080_8080_8080 != 0 { return None; }
    let v = (v * (1 + (10 << 8)) >> 8) & 0x00FF_00FF_00FF_00FF;
    let v = (v * (1 + (100 << 16)) >> 16) & 0x0000_FFFF_0000_FFFF;
    Some(v * (1 + (10000 << 32)) >> 32)
}
```

**Benchmarks** (12 032 cases identical to the current implementation; coretests num/parse 1697 + alloctests 34 tests pass):

| input (u64, radix 10) | current | prototype | change |
|---|---:|---:|---:|
| 9 digits `987245987` | 8.9 ns | **3.1** | **−65%** |
| 16 digits | 16.6 | **4.2** | **−75%** |
| 20 digits `u64::MAX` (original path) | 26.5 | 11.3–31.9 | layout-dependent |
| 2 / 5 digits / invalid `abc` | 2.5 / 5.0 / 1.6 | 2.2 / 4.0 / 1.3 | −11% / −21% / −18% |
| official `bench_u64/u32_from_str_radix_10` (mix averaging 2.8 digits) | 26.2 / 24.1 µs | 21.5 / 22.0 | −18% / −9% |
| the 33 official benches that never take the fast path | — | −27…+7% | **layout noise** (inlining decisions changed) |

**To do before landing**: 8/16-bit types (currently excluded), `u128/i128` accumulation, a CTFE path for `from_le_bytes` under `const fn`; the official 19-string mix averages 2.8 digits and needs long-string inputs to guard this. x86 SWAR is isomorphic.

---

### 17. BMP printable-block bitmap for `escape_debug_ext` (saves four sparse table lookups per non-ASCII char) — in-tree prototype verified

**Interface**: `library/core/src/char/methods.rs::escape_debug_ext` — reached by `Debug for str`, `Debug for char`, `str::escape_debug()` and `char::escape_debug()`; i.e. every `{:?}` of non-ASCII text.

**Why it is slow**: a non-ASCII char pays four sparse-table lookups (`skip_search`: binary search + prefix-sum scan) — `grapheme_extend` (383 ranges), `default_ignorable` (17), `cf` (21), `cn_planes_0_3` (730). **85%** of `str::debug::mostly_unicode`'s samples land in those four; a single `escape_debug().len()` costs **51.2 ns**.

**Fix** (in-tree prototype): a 128 B `[u64; 16]` bitmap, one bit per 64-codepoint BMP block meaning "every char in the block is printable", computed under the strictest `escape_grapheme_extender: true` so it is also valid for `false`. A hit short-circuits all four lookups; `impl Debug for str` additionally consults it to skip constructing an `EscapeDebug` at all.

**Prototype core**:

```rust
#[inline]
pub(crate) fn is_printable_block(self) -> bool {
    let u = self as u32;
    u <= 0xFFFF && PRINTABLE_BLOCKS_BMP[(u >> 12) as usize] >> ((u >> 6) & 63) & 1 != 0
}
```

**Benchmarks** (clean protocol: one bench per process, `--test-threads=1`, median of 3; `A` = bitmap arm, `B` = `Debug for str` skip):

| benchmark | baseline | A | A+B |
|---|---:|---:|---:|
| `str::debug::mostly_unicode` | 1806 ns | 326 (−82%) | **242 (−87%)** |
| `str::debug::mixed` | 1415 | 457 (−68%) | 401 (−72%) |
| `str::debug::some_unicode` | 293 | 200 (−32%) | 189 (−36%) |
| `fmt::write_str_macro_debug` | 82.0 µs | 23.9 (−71%) | **20.8 (−75%)** |
| `fmt::write_vec_macro_debug` | 87.9 µs | 28.1 (−68%) | 24.9 (−72%) |
| `str::debug::ascii_only` / `ascii_escapes` | 186 / 300 | flat | flat |

Per char: `escape_debug().len()` 51.2 → **2.09 ns** (Cyrillic), `format!("{:?}", c)` 92.6 → 34.2, whole-string `format!` 1737 → **209 ns**. Exhaustive check over all 63 360 non-ASCII BMP scalars under three argument combinations: **0 false positives**; coverage 74.7% (CJK/Hangul 100%, Cyrillic 77%, Devanagari 0%).

**Regression surface**: the ASCII path is untouched (the arm sits after it). `char::methods::{to_ascii_uppercase, ascii_char_to_uppercase, to_digit_radix_36}` show apparent −56%/−15%/−31% but that is a **code-layout artifact** (none of them calls this function; a `core_inert` build with the constant but not the arm reproduces baseline) — report separately, not as a gain.

**To do before landing**: generate the bitmap from `src/tools/unicode-table-generator` (precedent: `Cn_Planes_0_3` is synthesized in `load_data()` with an assertion keeping it in sync), slotting in at `main.rs:347` or as a new emitter beside `emit_bitset`; emit the matching assertion test.

### 18. `isqrt` final-division narrowing (`numerator / (2s)` → `(numerator >> 1) / s`) — in-tree prototype verified

**Interface**: `library/core/src/num/imp/int_sqrt.rs::last_stage!` (`u128::isqrt()`, `NonZeroU128::isqrt()`).

**Why it is slow**: Karatsuba's last stage computes `q = numerator / (s << 1)`, where `numerator < 2^65` (forced by `middle_stage!`'s `r < 2s < 2^33`). A 65/33 divide exceeds the hardware `udiv` width and lands in `compiler_builtins::int::specialized_div_rem::u128_div_rem`. `perf` on `u128_sqrt_uniform` puts **87%** of samples there.

**Fix** (in-tree prototype): the nested-division identity `floor(floor(a/2)/b) == floor(a/(2b))` means halving first brings `numerator >> 1` under `2^64`, so the divide becomes one native `udiv`. **Enabled for u128 only** — u16/u32/u64 numerators already fit their type, and applying it uniformly regresses u16/u32 by 3–5%.

**Prototype core**:

```rust
// end of last_stage!; for u128 pass $narrow = true, $div_ty = u64
let q = if $narrow {
    let q = ((numerator >> 1) as $div_ty) / ($s as $div_ty);
    q as $ty
} else {
    numerator / (($s as $ty) << 1)
};
```

**Benchmarks** (interleaved A/B, one bench per process, `--test-threads=1`, median of 5):

| benchmark | current | prototype | change |
|---|---:|---:|---:|
| `u128_sqrt_uniform` | 7937 ns | 5818 | **−26.7%** |
| `u128_sqrt_predictable` | 30879 | 25074 | **−18.8%** |
| `u128_sqrt_random` | 4727 | 3855 | **−18.4%** |
| u16/u32/u64/u8, 16 benches | — | — | ±0.2% |
| controls (`int_log`/`int_bits`/`int_pow`, 3 each) | — | — | ±0.1% |

The isolated last-stage divide goes 11.117 → **4.617 ns** (2.4×). Correctness: 0 mismatches against the unmodified formula over 21M+ inputs; 0 violations of `numerator ≥ 2^65` over a 50.3M-input sweep; `./x test library/core --test-args isqrt` passes.

**Rejected**: the f64 seed for `u64::isqrt` (`(x as f64).sqrt() as u64` is exact to ±1; 9.72 → **2.62 ns**, 3.7×) is **unusable** because `isqrt` is a `const fn` while `intrinsics::sqrtf64` is not — `error: cannot call non-const intrinsic sqrtf64 in constant functions`.


### 19. `Filter`/`FilterMap::next_chunk` compaction loop (unconditional store → conditional) — in-tree prototype verified

**Interface**: `library/core/src/iter/adapters/filter.rs::next_chunk_dropless`, `library/core/src/iter/adapters/filter_map.rs::FilterMap::next_chunk` (the `Iterator::next_chunk` overrides on these two adapters).

**Why it is slow**: the inner loop is deliberately branchless — the index advances via `cinc`/`csinc`, and **every scanned element is stored unconditionally**, even ones the predicate rejects. When matches are sparse (32 wanted out of 933 scanned) that is 901 wasted stores, a 29× overshoot; and the store address depends on the loop-carried `idx += pred` chain.

**Fix** (in-tree prototype): move the store inside `if pred { ... }` and advance the index only on a match. Semantically equivalent (0 mismatches over 1194 differential cases; panic safety verified).

**Prototype core**:

```rust
// Filter::next_chunk_dropless
self.iter.try_for_each(|element| {
    if (self.predicate)(&element) {
        let idx = initialized;
        unsafe { array.get_unchecked_mut(idx) }.write(element);
        initialized = idx + 1;
        if initialized < N { ControlFlow::Continue(()) } else { ControlFlow::Break(()) }
    } else {
        ControlFlow::Continue(())
    }
})
```

**Benchmarks** (interleaved A/B, one bench per process, `--test-threads=1`, median of 5–8):

| benchmark | current | prototype | change |
|---|---:|---:|---:|
| `filter_map_mostly_false` | 601 ns | 355 | **−41.0%** |
| `filter_mostly_false` | 640 | 398 | **−37.8%** |
| `filter_map_shuffled_12pct` (new) | 199 | 131 | **−34.3%** |
| `filter_shuffled_12pct` (new) | 194 | 158 | **−18.9%** |
| `filter_even` | 61.6 | 52.2 | **−15.3%** |
| `filter_shuffled_50pct` (new) | 68.8 | 62.3 | −9.5% |
| `filter_predictably_true` | 34.3 | 31.4 | −8.5% |
| `filter_map_even` | 49.1 | 50.7 | **+3.3%** |
| `filter_map_predictably_true` | 28.3 | 28.6 | +1.0% |
| `copied` / TRA ×2 (controls) | — | — | ±0.1% |

**Attribution**: a per-file A/B shows a clean 2×2 block (patching `filter.rs` moves only `filter::*` and vice versa), ruling out a global layout artifact. **Three new shuffled benches** cover the "unpredictable branch" case the original comment claims to favour — the prototype wins there too, so that rationale is not supported by measurement.

**Hybrid rejected**: keeping the branchless index and only conditioning the store is slower (`filter_map_even` 49.1 → 72.8).

**Open**: two small regressions, `filter_map_even` +3.3% and `filter_map_predictably_true` +1.0% (cheap predicate, 50% hit rate); the same shape in `filter_even` is −15.3%.

### 20. `[T]::cmp` / `partial_cmp` / `<` (specialization of `SliceOrd`/`SliceChain` for wide integers) — SVE prototype verified

**Interface**: `SliceOrd::compare`, `SlicePartialOrd::partial_compare` and `SliceChain::chaining_{lt,le,gt,ge}` in `library/core/src/slice/cmp.rs`; reached through `impl Ord/PartialOrd for [T]`, the comparisons inside `<[T]>::binary_search`, and `BTreeMap<Vec<u32>, _>` key lookups.

**Why it is slow**: the dispatch hook **already exists and already specializes** — `UnsignedBytewiseOrd` covers only `u8`/`bool`/`NonZero<u8>`/`Option<NonZero<u8>>`/`ascii::Char`, which take `compare_bytes` (memcmp). Integers of `u16` and wider, and `char`, do not satisfy the bytewise-equivalence requirement and fall back to the per-element early-exit loop inside `chaining_impl` (`ldr/ldr/cmp/b.ne`), at 0.36 ns/element. A loop with an early exit cannot be vectorized by LLVM.

**Fix**: compare VL/4 lanes at a time with SVE `cmpne`; on a hit, recover the **exact index of the lowest unequal lane** with `brkb`+`cntp`, then do one scalar comparison at that lane to produce the `Ordering`/boolean result. The tail block is masked automatically by `whilelo`, so there is no scalar tail loop. Semantic key: SVE `cmpne` produces an "unequal" mask independently of element width, so `u16`/`u32`/`u64`/`u128` share one kernel structure, differing only in the `ld1w`/`ld1d` load and the lane count. The hook can reuse `AlwaysApplicableOrd` (which already lists every primitive integer), or a new internal trait restricted to primitive types whose `Ord` has no side effects.

**Prototype core**:

```rust
// find the first unequal lane; on a hit brkb+cntp gives the index, then order scalar-ly
"whilelo p0.s, {i}, {n}",
"2:",
"ld1w {{z0.s}}, p0/z, [{a}, {i}, lsl #2]",
"ld1w {{z1.s}}, p0/z, [{b}, {i}, lsl #2]",
"cmpne p1.s, p0/z, z0.s, z1.s",
"b.any 4f",
"incw {i}", "whilelo p0.s, {i}, {n}", "b.any 2b",
"4:", "brkb p1.s, p0/z, p1.s", "cntp {off}, p0, p1.s", "add {i}, {i}, {off}",
```

**Benchmarks** (equal-length slices that are **fully equal**, i.e. the worst case that must scan to the end; core-pinned, ns/element, best of 4):

| n | std (`[T]::cmp`) | chunk16 (NEON autovectorized) | SVE | SVE vs std |
|---|---:|---:|---:|---:|
| 64 | 0.37 | 0.12 | **0.10** | **3.7×** |
| 1,000 | 0.36 | 0.12 | **0.10** | 3.6× |
| 10,000 | 0.36 | 0.13 | **0.11** | 3.3× |
| 100,000 | 0.38 | 0.16 | **0.15** | 2.5× |

Non-worst case (element 0 differs, the latency floor): at n=1000 std is 1.4 ns, chunk16 **2.9 ns**, SVE **1.5 ns** — the chunked version pays for a whole block when the first block already hits, while SVE's first round is masked, so there is no such regression and no hybrid startup is needed.

**Regression surface**: none measured; the only semantic risk is a user `Ord` with observable side effects (hence the specialization must be restricted to primitive integers/`char` and cannot be a blanket impl).

**Landing TODO**: `u128` needs 128-bit lanes (or two `ld1d` halves spliced); `char` needs the (true) fact that `Ord` over values below `0x110000` agrees with unsigned integer order. x86 counterpart: the same shape is `pcmpeqd`+`pmovmskb`+`tzcnt`, structurally isomorphic, not measured.

---

### 21. Floating-point slice equality `[f32]`/`[f64] ==` (specialization of `SlicePartialEq`) — SVE prototype verified

**Interface**: `SlicePartialEq::equal_same_length` in `library/core/src/slice/cmp.rs`; `[f32]==[f32]`, `[f64]==[f64]`, and `starts_with`/`ends_with`/`[T]::eq` on float slices.

**Why it is slow**: floats are **not** `BytewiseEq` (`NaN != NaN`, `-0.0 == +0.0`, and the quiet bit of a signaling NaN does not participate in the comparison), so the `compare_bytes` specialization does not apply and the code falls back to a per-element `fcmp`+`cset` early-exit loop at 0.67 ns/element — slower than the integer slice comparison, because each element adds an `fcmp`-to-`cset` latency.

**Fix**: SVE `fcmne` **is** the IEEE `!=` semantics (NaN compares true, `-0.0` equals `+0.0`), so the mask is correct with no special handling. On a hit, `brkb`+`cntp` again recover the index (here only "is anything unequal" is needed; the index enables the early exit). The hook is an `f32`/`f64` impl added to `SlicePartialEq` (float and integer `PartialEq` have different semantics, so they must stay separate).

**Prototype core**:

```rust
"whilelo p0.s, {i}, {n}",
"2:",
"ld1w {{z0.s}}, p0/z, [{a}, {i}, lsl #2]",
"ld1w {{z1.s}}, p0/z, [{b}, {i}, lsl #2]",
"fcmne p1.s, p0/z, z0.s, z1.s",   // IEEE !=: true for NaN, equal for ±0
"ptest p0, p1.b",                 // key: fcm* does not set NZCV, so b.any needs ptest first
"b.any 4f",
"incw {i}", "whilelo p0.s, {i}, {n}", "b.any 2b",
```

**Benchmarks** (equal-length, fully equal `[f32]`, ns/element):

| n | std | chunk16 (NEON) | SVE | SVE vs std |
|---|---:|---:|---:|---:|
| 64 | 0.66 | 0.12 | **0.11** | **6.0×** |
| 1,000 | 0.67 | 0.13 | **0.11** | 6.1× |
| 10,000 | 0.66 | 0.14 | **0.12** | 5.5× |
| 100,000 | 0.68 | 0.16 | **0.15** | 4.5× |

**Correctness**: fuzzed over NaN, `-0.0`/`+0.0`, and equal/unequal-length inputs containing NaN; matches std everywhere.

**Landing TODO**: `f16`/`bf16` extend isomorphically if they ever gain `PartialEq`; `f64` uses `ld1d`/`fcmne p1.d`. **Gotcha on record**: integer `cmpne` sets NZCV for `b.any` to read, but float `fcm*` does **not** — a `ptest` must be inserted before `b.any`, otherwise the branch is never taken (the first draft of this prototype failed exactly this way).

---

### 22. `VecDeque::retain` / `retain_mut` (SVE `COMPACT`) — prototype verified

**Interface**: `retain`/`retain_mut` in `library/alloc/src/collections/vec_deque/mod.rs`.

**Why it is slow**: three stages — stage 1 probes element by element, stage 2 does `self.swap(idx, cur)` for every retained element, stage 3 `truncate`s. Every element pays two ring indices (`self[cur]` and the `swap`, each with a wrap modulo) plus an `if keep` mispredict. The same lesion as `Vec::retain`, but heavier: it is **slower than the scalar `Vec::retain`** (451 µs vs 348 µs at n=100,000).

**Fix**: reuse the two-phase template from `sve_retain.rs` — phase A runs the predicate scalar-ly, in order, writing only a bool mask (preserving the exactly-once/in-order contract); phase B moves whole vectors with `COMPACT`. The **only** difference from `Vec::retain` is the ring layout, which needs two new pieces: (1) chunk by **physical segment** (`min(CHUNK, remaining length, distance to the buffer end)`) so no round straddles the wrap; (2) if the write cursor's physical position is not ahead of the read position (or this round would cross the buffer end), compact into a 64-element stack scratch first and copy back into the ring in two pieces. The panic guard is the same design.

**Prototype core**:

```rust
// per round: take a source segment that does not straddle the wrap
let phys = wrap(head + read);
let n = CHUNK.min(len - read).min(cap - phys);
for i in 0..n { mask[i] = f(&mut *base.add(phys + i)); }
let wphys = wrap(head + write);
let kept = if wphys + n <= cap && wphys <= phys {
    compact32(base.add(phys), base.add(wphys), mask.as_ptr(), n)   // in place
} else {
    let k = compact32(base.add(phys), scratch.as_mut_ptr(), mask.as_ptr(), n);
    let first = k.min(cap - wphys);                                 // straddling: two pieces
    copy_nonoverlapping(scratch.as_ptr(), base.add(wphys), first);
    copy_nonoverlapping(scratch.as_ptr().add(first), base, k - first);
    k
};
write += kept; read += n;
```

**Benchmarks** (u32, `x & 1 == 0`, input rebuild subtracted, core-pinned):

| n | std | SVE (contiguous) | SVE (wrap at 1/3) | SVE vs std |
|---|---:|---:|---:|---:|
| 64 | 60 ns | **27 ns** | 42 ns | **2.20×** / 1.43× |
| 1,000 | 906 ns | **442 ns** | 463 ns | **2.05×** / 1.96× |
| 100,000 | 451 µs | **43.3 µs** | 45.6 µs | **10.43×** / 9.91× |

**Correctness**: differential fuzz over lengths 0–400 × capacity slack × wrap position (0/1/37/130), matching `VecDeque::retain` exactly in element order and contents.

**Regression surface**: below the threshold it must fall back to the scalar path via `sve_retain.rs`'s per-width thresholds (`MIN_SVE_SIZE_*`); the wrapped layout pays one extra physical-segment computation per round, about 5% behind the contiguous layout at large sizes.

**Landing TODO**: same build prerequisite as `sve_retain.rs` (static `+sve` build or runtime dispatch); the panic guard needs its "copy the undecided tail back" step rewritten for the ring layout; `VecDeque::extract_if` is isomorphic (the same mask compacted both ways) and can be done together.

---

### 23. `Vec::extract_if(..)` fully consumed (SVE two-way compaction) — prototype verified

**Interface**: `ExtractIf::next` in `library/alloc/src/vec/extract_if.rs`; the benefiting shapes are `extract_if(.., pred).collect::<Vec<_>>()`, `extend(...)`, and `for` loops that consume it fully.

**Why it is slow**: `next()` tests `pred` per element, `ptr::read`s on a hit and `copy_nonoverlapping`s to fill the hole on a miss — one `ptr::copy` branch plus one `del > 0` check per element, and the `Vec::with_capacity` target still needs a per-element push.

**Fix**: run `COMPACT` twice over the same bool mask — retained elements stay in place (compacted to the write cursor) and removed elements are compacted onto the end of a new `Vec`. The hook is a specialization of `Vec: Extend<T>`/`SpecFromIter` for `ExtractIf`, or a batch `next` helper on `ExtractIf` itself. **Semantic constraint**: the `pred` call timing changes from "once per `next()`" to "once per chunk (groups of 64)", which is observable for predicates with side effects; whether the docs permit that must be settled before landing.

**Benchmarks** (u32, `x % 3 == 0`, input rebuild subtracted, core-pinned):

| n | `collect()` | `into with_capacity` | SVE | vs prealloc | vs collect |
|---|---:|---:|---:|---:|---:|
| 64 | 158 ns | 67 ns | **56 ns** | 1.20× | **2.8×** |
| 1,000 | 1,268 ns | 812 ns | **736 ns** | 1.10× | 1.72× |
| 100,000 | 383 µs | 365 µs | **71.2 µs** | **5.13×** | **5.38×** |

**Regression surface**: gains are small at small sizes (1.1–1.2×, where phase A's predicate calls and the allocation/free costs dominate); the comparison must be against the `with_capacity` version and not only `collect()`, or the target `Vec`'s growth cost gets misrecorded as a gain.

---

### 24. `chunk_by()` / run-length counting (`cmpne`+`cntp`) — SVE prototype verified

**Interface**: the `count()` shape of `<[T]>::chunk_by` (equivalent to the number of adjacent runs, `1 + Σ[v[i] != v[i+1]]`); it also covers full-block scans that decide "are adjacent elements unequal".

**Why it is slow**: `ChunkBy` is a generic iterator, so `count()` walks a state machine per element. `chunk_by(|a,b| a==b).count()` is newly measured here (same family as the §5 `dedup` prescan, but returning a count rather than an index).

**Fix**: `cmpne` produces the "adjacent unequal" mask and `cntp` accumulates it; `whilelo` masks the tail block automatically. Loading `v[i..]` and `v[i+1..]` into two vectors and comparing needs no shift.

**Prototype core**:

```rust
"whilelo p0.s, {i}, {n}",
"2:",
"ld1w {{z0.s}}, p0/z, [{p}, {i}, lsl #2]",
"add {t}, {i}, #1",
"whilelo p1.s, {t}, {n}",
"ld1w {{z1.s}}, p1/z, [{p}, {t}, lsl #2]",
"cmpne p2.s, p1/z, z0.s, z1.s",
"cntp {k}, p1, p2.s", "add {tot}, {tot}, {k}",
```

**Benchmarks** (u32, value range 8, ns; std = `chunk_by(|a,b| a==b).count()`):

| n | std | SVE | change |
|---|---:|---:|---:|
| 16 | 7.2 | **2.7** | **2.69×** |
| 64 | 24.3 | **9.4** | 2.57× |
| 256 | 92.9 | **35.7** | 2.60× |
| 4,096 | 1,471 | **591** | 2.49× |
| 65,536 | 23,699 | **10,614** | 2.23× |

**Regression surface**: none (wins from 16 up). Differential fuzz over all lengths 0–400 and several run distributions matches `chunk_by().count()`.

---

### 25. ASCII closed-class counting (the `filter(pred).count()` shape, `cmphs`/`cmpls`+`cntp`) — SVE prototype verified

**Interface**: the **counting** shape of closed predicates such as `<[u8]>::is_ascii_digit`/`is_ascii_whitespace`/`is_ascii_alphanumeric` (`v.iter().filter(|b| b.is_ascii_digit()).count()`); std has no dedicated API for it, so the landing shape is a new slice helper or a specialization of an existing counting path.

**Why it is slow**: per-byte `filter().count()`, one comparison plus one branch per element. **The difference from §9**: §9 is about the **early-exit** shape of `iter().all()` (whose benchmarks are invalidated three ways); this one is the **non-early-exit counting** shape, which is already the ideal vectorization shape and whose true value is measurable without fixing any benchmark.

**Fix**: closed classes use two range comparisons, `cmphs` (>= lower bound) + `cmpls` (<= upper bound), combined with `and` and accumulated with `cntp`. Whitespace (five discrete values) instead uses five `cmpeq`s merged with `orr` — **key point**: the governing predicate of `orr p1.b, p0/z, p1.b, p2.b` must be the **loop predicate `p0`**; if it is written as the accumulation target `p1`, the `/z` zeroes every newly matched lane (the first draft of this prototype was wrong across the board exactly this way).

**Prototype core**:

```rust
"mov z1.b, #48", "cmphs p1.b, p0/z, z0.b, z1.b",   // >= '0'
"mov z1.b, #57", "cmpls p2.b, p0/z, z0.b, z1.b",   // <= '9'
"and p1.b, p0/z, p1.b, p2.b",
"cntp {k}, p0, p1.b", "add {t}, {t}, {k}",
```

**Benchmarks** (ns; std = `filter().count()`; inputs are all digits, or contain 1/3 whitespace):

| n | digit count std | digit count SVE | change | ws count std | ws count SVE | change |
|---|---:|---:|---:|---:|---:|---:|
| 8 | 4.4 | **1.7** | 2.60× | — | — | — |
| 16 | 7.1 | **1.7** | 4.20× | 6.8 | **3.5** | 1.92× |
| 24 | 10.1 | **1.7** | **6.00×** | — | — | — |
| 64 | — | — | — | 21.9 | **6.4** | **3.42×** |
| 96 | 31.6 | **4.3** | **7.31×** | — | — | — |
| 256 | 65.8 | **12.8** | 5.15× | 76.3 | **28.2** | 2.70× |
| 4,096 | 987 | **199** | 4.95× | 1,152 | **444** | 2.59× |
| 65,536 | 16,050 | **3,199** | 5.02× | 18,374 | **7,222** | 2.54× |

**Regression surface**: none (wins from 8 up); discrete-value classes (whitespace) need 4–5 `cmpeq`s to merge, so they gain less (1.9–3.4×) than range classes (4.2–7.3×).

**Landing TODO**: std has no public "count a closed class" interface today, so the smallest landing surface is to specialize the internal `[u8]` counting helpers, or propose it first as a closed API (e.g. `count_ascii_digits`); the `filter()` closure shape cannot be seen through inside std, so the generic path cannot be specialized directly.

---

### 26. `unzip` of structured data (`ld2w`/`st1w`) — SVE prototype verified

**Interface**: the `Iterator::unzip` shape over AoS slices such as `&[(u32,u32)]` (`v.iter().copied().unzip()`), producing two `Vec`s.

**Why it is slow**: generic `unzip` goes through `Extend::extend_one` per element, one `size_hint` check and two `Vec::push`es (each with a capacity branch) per element. AoS→SoA is, at the memory level, a half-width interleaved load — exactly what `ld2` is for.

**Fix**: `ld2w {z0.s, z1.s}, p0/z, [src]` fetches both lane groups in one go, and `st1w` writes them into the two targets. A separate specialization is needed for slice-source `unzip` (a generic iterator gives no such guarantee); `extend`/`collect` paths likewise. **Key detail**: the register-offset form of `ld2w` scales by the element size (`lsl #2`), so the index must be precomputed as `t = i + i`; `lsl #3` does not assemble.

**Benchmarks** (ns; std = `v.iter().copied().unzip()`):

| n | std `Iterator::unzip` | SVE `ld2w`/`st1w` | change |
|---|---:|---:|---:|
| 16 | 47.8 | **3.8** | **12.44×** |
| 64 | 50.1 | **9.1** | 5.52× |
| 256 | 85.0 | **44.5** | 1.91× |
| 1,024 | 209 | **146** | 1.43× |
| 4,096 | 623 | **601** | 1.04× |
| 65,536 | 102,767 | **10,742** | **9.57×** |

**Note**: the near-tie across 1K–4K is memory-bandwidth-bound (both versions are in steady state); the large gaps at both ends come from mid-range growth/allocation cost (of std's 102 µs at n=65,536, most is repeated reallocation). Against a "hand-written push loop + `reserve`" baseline, SVE is 3.0×/15.6×/13.4×/16.9×/15.1× at n=16/64/256/4096/65536.

**Landing TODO**: needs a new slice-source `unzip` hook; `(u64,u64)` uses `ld2d`, `(u16,u16)` uses `ld2h`/`ld2w` (16-bit needs widening); `f32`/`f64` are isomorphic.

---

### 27. `trim_ascii_start` / `trim_ascii_end` (SVE leading-whitespace scan, threshold required) — prototype verified

**Interface**: `trim_ascii_start`/`trim_ascii_end` in `library/core/src/slice/ascii.rs` (the `&[u8]` and `<str>` versions).

**Why it is slow**: a per-byte `is_ascii_whitespace` early-exit scan — purely scalar over long leading whitespace runs.

**Fix**: five `cmpeq`s merged into a whitespace mask; the complement feeds `brkb` to get the length of the leading non-whitespace position. **The key is whole-block continuation**: only when a block is entirely whitespace (`cntp(ws) == cntp(active)`) does the loop `incb` and continue; otherwise it exits immediately. The head is checked scalar-ly first (see regression surface).

**Prototype core**:

```rust
"not p2.b, p0/z, p1.b",        // p1 = whitespace mask
"brkb p3.b, p0/z, p2.b",       // BRKB = trues before the first true = leading whitespace length
"cntp {k}, p0, p3.b",
"cntp {k2}, p0, p0.b",         // active lanes in this block
"cmp {k}, {k2}", "b.ne 4f",    // not a full whitespace block -> stop
```

**Benchmarks** (ns; three input shapes):

| n | no leading ws (std/SVE) | 1/3 leading ws (std/SVE) | change (1/3 ws) | change (no ws) |
|---|---:|---:|---:|---:|
| 16 | 1.7 / 4.1 | 3.8 / 4.1 | 0.92× | **0.42×** |
| 64 | 1.7 / 4.1 | 12.6 / 4.6 | **2.77×** | 0.42× |
| 256 | 1.7 / 4.6 | 45.9 / 18.7 | 2.45× | 0.38× |
| 4,096 | 1.8 / 4.7 | 724 / 417 | 1.74× | 0.38× |
| 65,536 | 1.8 / 4.7 | 11,460 / 6,934 | 1.65× | 0.39× |

**Regression surface**: **2.4–2.6× slower when the first byte is not whitespace** (std returns after one comparison at 1.7 ns; SVE pays a fixed 4.1 ns of vector setup). This is the canonical "needs a threshold" case: landing **must** do a scalar first-byte check, returning immediately when it is not whitespace, and only enter the SVE loop when the first block is entirely whitespace. With that gate the common case (std's 1.7 ns path) is untouched while long leading-whitespace runs gain 1.65–2.77×.

**Landing TODO**: `const fn` semantics (`trim_ascii_*` are `const fn`, so CTFE must keep the scalar path, following the `const_eval_select!` pattern); `trim_ascii_end` is symmetric with `lastb`; the `<str>` version requires the result to land on a char boundary (trimming only ASCII whitespace makes this automatic).

---

### 28. The tail block and short lengths of `[T]::is_sorted` (currently NEON-chunked, scalar tail) — candidate

**Interface**: `is_sorted` in `library/core/src/slice/mod.rs` (the current `CHUNK_SIZE = 33` overlapping chunking plus `windows(2).fold` autovectorization).

**Why it is slow**: at large sizes the chunked shape vectorizes well (0.14 ns/element), but the **last 31 elements go through the scalar `windows(2).all`**; at n=64 that segment is the overwhelming majority — std 23.2 ns (0.36 ns/element), where the vector body should be 0.10–0.13 ns/element. **This is a pure shape problem and does not need SVE to fix** (make the tail the last full overlapping block).

**Fix**: either (a) fix the tail in pure Rust (overlap the last full block: no SVE, no specialization, benefits every target), or (b) SVE `cmphi` comparing `v[i..]` against `v[i+1..]`, with the tail masked by `whilelo`.

**Benchmarks** (sorted `[u32]`, ns):

| n | std (NEON chunked) | SVE | change |
|---|---:|---:|---:|
| 64 | 23.2 | **6.5** | **3.57×** |
| 1,000 | 139.3 | **114.4** | 1.22× |
| 10,000 | 1,355.7 | **1,089.0** | 1.24× |
| 100,000 | 13,729.4 | **13,015.1** | 1.05× |

**Note**: the 3.57× at n=64 comes entirely from the scalar tail segment; past n≥1000 the gain converges to 1.05–1.24× because the vector body is already near memory bandwidth. **The main payoff of this entry is therefore option (a)** (fixing the tail shape); the SVE version adds only a second-order 5–24% over the NEON chunking.

**Regression surface**: the SVE version needs `<` with side-effect-free `PartialOrd` (so the specialization is limited to primitive types); `f32`/`f64` `is_sorted` with `NaN` needs separate measurement (SVE `fcm*` NaN behavior differs from Rust `<=`).

---

### 29. The SVE mid-range window of `[u8]::is_ascii` (wins only across 16–192 B) — verified, narrow payoff window

**Interface**: `is_ascii` in `library/core/src/slice/ascii.rs` (which already has an in-tree NEON specialization: 64 B unroll + `vorrq` reduction).

**Why it is slow**: the in-tree NEON version is efficient for long inputs, but its fixed setup (loads plus the reduction tree) is heavy for small and medium lengths.

**Fix**: a single predicated block (`whilelo` + `cmplt` on the high bit) in a loop, without the 64 B unroll's fixed cost.

**Benchmarks** (all-ASCII input, ns):

| n | std (in-tree NEON) | SVE | change |
|---|---:|---:|---:|
| 8 | 1.59 | 1.72 | **0.92×** |
| 16 | 1.95 | 1.73 | 1.13× |
| 24 | 2.76 | 1.73 | **1.60×** |
| 32 | 3.10 | 1.73 | **1.80×** |
| 96 | 2.65 | 2.76 | 0.96× |
| 128 | 3.80 | 3.14 | 1.21× |
| 192 | 4.49 | 3.80 | 1.18× |
| 256 | 5.17 | 5.88 | **0.88×** |
| 1,024 | 18.32 | 26.57 | **0.69×** |
| 4,096 | 64.58 | 94.61 | **0.68×** |
| 65,536 | 1,026 | 1,483 | **0.69×** |

**Conclusion**: SVE wins only across the **16–192 B** window (1.1–1.8×, an absolute 1–1.7 ns) and loses steadily to the in-tree 64 B unroll NEON version past 256 B (0.68–0.69×). **This is the only interface in this round where SVE wins only at mid-range lengths**, so swapping it in outright would regress long inputs; if used at all, the gate must be "16 ≤ len < 192 goes SVE, everything else keeps the existing NEON". The payoff ceiling is tiny (under 2 ns absolute), so priority is low.

**Note**: this entry's std baseline independently reconfirms, outside §9, that the in-tree NEON `is_ascii` does 65 KB in 1.03 µs (≈0.016 ns/B, a 61 GB/s class figure), matching §9's probe truth value.

---

### 30. Rejected SVE shapes (measured negative, do not implement) — verified

| Interface | SVE shape | Measurement | Why rejected |
|---|---|---|---|
| `[u8]::make_ascii_uppercase` / `make_ascii_lowercase` | `cmphs`+`cmpls` range mask + `sub`/`add` of 0x20 | **0.48–0.78×** (n=16 0.78×, 256 0.52×, 4,096 0.48×, 65,536 0.48×) | LLVM already emits high-quality NEON for this loop (§9 already records `case06_libcore` at 0.029 ns/B); the SVE version pays extra setup with no width advantage |
| `Vec::dedup_by` / `dedup_by_key` (arbitrary closure) | two-phase mask + `COMPACT` (the retain template) | **0.80–0.86×** (n=64 0.81, 1,000 0.86, 100,000 0.80) | Phase A is not a pure map: `same_bucket(cur, prev)`'s `prev` is "the last retained element", a per-element serial dependency, and there is one more predicate-driven branch — together they cancel the retain template's advantage. `Vec::dedup` (`T: PartialEq`) is not in this group — §5 measured it at −50%…−94%, because it vectorizes the comparison itself |
| `String::retain` | mask widened to per-byte + `COMPACT` | **+36%…+212%** across every shape (both eager and lazy variants, all sizes × drop rates) | UTF-8 decoding plus the per-char closure call is the contractually serial part, and the scalar version writes nothing at all in the keep-all/drop-all cases; see `STRING_RETAIN_SVE_ANALYSIS.md` |
| `LinkedList::retain` / `BTreeMap::retain` / `BinaryHeap::retain` | — | — | Non-contiguous storage (`BinaryHeap::retain` is `Vec::retain` plus `rebuild`, so it picks up §22's specialization for free) |
| `[T]::partition_dedup_by` / `sort`'s `partition` | — | — | Under swap semantics both sides must be preserved and `COMPACT` produces only one; quicksort partition is already branchless Lomuto and would need dual output (SVE2 `SPLICE`) |
| `Iterator::position` (generic closure) | — | — | See the note below: the generic path cannot see through the closure and needs a new closed API |

**`Iterator::position` gap note**: `v.iter().position(|&y| y == x)` measures 0.46 ns/element while `v.contains(&x)` (which has a chunked specialization) is 0.07 ns/element — **the same operation, 6× slower** — because `position`'s predicate is an arbitrary closure that specialization cannot identify. This is an **API gap** in std (the lack of a closed lookup such as `[T]::index_of`), not a performance problem fixable inside std; if that interface is added, its SVE shape is isomorphic to §20 (`cmpeq`+`brkb`+`cntp`), measured at 0.07 ns/element.

---

### SVE landing prerequisites and this host's ISA facts (2026-10 scan)

- **Host**: HiSilicon aarch64, VL = 32 B (256-bit), the full base SVE set is available — `compact`/`tbl`/`uzp1`/`trn1`/`zip1`/`lasta`/`lastb`/`brka`/`brkb`/`ptest`/`cntp`/`whilelo`/`incb`/`incw`/`ext`/`ld1w`/`st1w`/`ld2w`/`st2w`/`cmpeq`/`cmphi`/`cmphs`/`cmpls`/`cmplt` all assemble and execute.
- **SVE2 is unavailable** (`is_aarch64_feature_detected!("sve2")` is false at runtime, and the assembler rejects `revb`/`histcnt`/`match`/`splice` with `requires sve2`). The following can only be listed as **future-hardware** candidates, unmeasurable this round: `count_bytes` histograms (`histcnt`), `split(char)`/`find`/`rfind` (`match`+`splice`), `bytes_rev`/`chars_rev` (`revb`), and dual-output sort partition (`splice`).
- **Build prerequisite**: rustc's default `generic` CPU does not include the `sve` feature, so released std builds cannot reach any SVE path; landing must follow the `sve_retain.rs` precedent of a **static `+sve` build**, or introduce runtime dispatch. Under `-Ctarget-cpu=native` LLVM emits SVE on its own for `reverse`/`unzip`/`count`/`sum`/`dot`/`fill`, but released builds do not take that path.
- **stdarch status**: it already has 5,543 `sv*` functions, but scalable vector types have no sound Rust representation in `core`/`alloc` (no provenance or uninitialized-padding semantics), so every kernel in §20–§27 is written in inline asm, consistent with `sve_retain.rs` and the `memchr` prototype.

**Two error-prone ISA details** (confirmed while debugging this round; required reading for any follow-up):

1. **`BRKB(P)` = the number of trues before the first true** (i.e. the count of leading **false** lanes); when the source is all-false it returns the full lane count. `BRKA` is symmetric (including the first true). Getting "leading whitespace length" requires `BRKB(complement-of-whitespace-mask)`; and if the mask can be all-false, that case must be handled first (all-zero returns the lane count rather than 0).
2. **The governing predicate of `orr pA.b, pB/z, ...` must be the loop predicate**, not the accumulation target itself — governing `p1` with `p1` lets `/z` zero every newly matched lane, leaving the mask permanently empty.

---

### 31. `Fuse` lacks `InPlaceIterable` (`.fuse()` silently adds an allocation to `collect`) — in-tree prototype verified

**Interface**: `library/core/src/iter/adapters/fuse.rs`; affects chains of the form `vec.into_iter()….fuse()….collect::<Vec<_>>()`.

**Why it is slow**: `Fuse` implements `SourceIter` but not `InPlaceIterable`, so the in-place collect specialization does not apply and `collect` falls back to a fresh allocation plus a copy. The impl was removed together with `SourceIter` in 2021-06 (`6f5e933adb57`, fixing #85863); in 2023-04 (`3ca6bb0b44c3`) only `SourceIter` came back, bounded by `TrustedFused`.

**Fix** (in-tree prototype): restore `InPlaceIterable`, forwarding the inner constants. Soundness rests on the existing `I: TrustedFused` bound on `SourceIter`.

**Prototype core**:

```rust
unsafe impl<I: InPlaceIterable> InPlaceIterable for Fuse<I> {
    const EXPAND_BY: Option<NonZero<usize>> = I::EXPAND_BY;
    const MERGE_BY: Option<NonZero<usize>> = I::MERGE_BY;
}
```

**Results**:

| | current | prototype |
|---|---:|---:|
| `bench_in_place_recycle` shape, allocations per iteration | 1.000 | **0.000** |
| standalone-process probe (1000 × usize) | 282–285 ns | **248 ns (−12%)** |
| official `vec::bench_in_place_recycle` | ~185 ns | indistinguishable by time (the allocation is offset by a faster copy loop) |

Tests: `coretests fuse` and `flatten`, `alloctests in_place` and `from_iter`, 92 in total, all pass.

**Open**: needs a soundness sign-off from the `inplace_iteration` maintainers. `bench_in_place_recycle` has not exercised the in-place path since 2021 and timing cannot show it, so it should assert on allocation count. `Peekable` has the same gap; not evaluated.

## Tier 3: Candidate directions (root cause located, fix not prototyped)

(#6, #7, #8, #10–#13, #16–#28 have been prototyped and moved up to Tier 2; #29–#30 are verified limits and rejections, also in Tier 2; #31 is prototyped and also in Tier 2.)

### 14. `BTreeMap` tree shape under sequential insert (`splitpoint` does not bias right-edge inserts) — candidate

**Interface**: `library/alloc/src/collections/btree/node.rs::splitpoint`; affects `get`/`range`/iteration on every tree built by sequential `insert`.

**Why it is slow**: sequential `insert` always hits the rightmost leaf; a full node splits at the centre, freezing every left node at 6/11 keys (55% fill: 1666 nodes for 10 000 keys vs 913 with `collect`), one extra level; partial nodes use the early-exit scan, so a sequential `get` mispredicts once per level (2.98 misses/get, IPC 1.90). Same data built by `collect`: `get` 116 → **59 cycles**.

**Fix** (not prototyped): bias `splitpoint` when the insertion edge is `CAPACITY` (rightmost) — keep `CAPACITY − 1` (or −2) keys in the left node and only the new key in the right, giving ~90% fill for sequential insert; keep the current rule otherwise. Needs re-validation of #74834's bidirectional-insert balance and `remove` underflow-merge frequency.

**Benchmarks** (estimated): `find_seq_10_000` 41.7 → ~22 ns (−47%); `range_*`, `iteration_*` and memory (−45% nodes) benefit alongside; `insert_seq_*` halves its splits. Ruled out alternative: branchless scan of partial nodes (+75…+270%, dominated by the copy).

### 15. `core::slice::memchr` (portable SWAR, no SIMD body) — candidate

**Interface**: `library/core/src/slice/memchr.rs::memchr`; `str::split/find/contains(char)`, `CStr::from_bytes_with_nul`, `[u8]::contains` all go through it. Since `88ac7ace569c` removed std's arch-specific versions only the portable SWAR remains.

**Why it is slow**: outside the 2×usize SWAR body, both the alignment prologue and the post-match localization are byte loops — 46% of the samples of `split_unicode_ascii`'s three memchr calls are in byte loops; on long scans the 16 B/iteration SWAR is 40% of NEON throughput.

**Fix** (probe-verified, not in-tree): first 16 B via unaligned SWAR words + `ctz` localization (short segments resolve in one step), then NEON `cmeq` at 16 B/iteration, byte-loop tail as today.

**Benchmarks / probes** (variant G, two consistent runs per input): `split_unicode_ascii` −38%, ~5 B segments −10%, **16–40 B segments +9…+19%**, 97 B segments −24%, long no-match scans −57…−58%. No single shape wins in all three regimes; landing hinges on accepting the 16–40 B regression and on std re-accepting arch-specific memchr. x86's `pcmpeqb+pmovmskb` mask extraction is shorter, so the mid-range penalty should be smaller — unmeasured.

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
| `u128::isqrt` final divide | `num::int_sqrt::u128_sqrt_{predictable,random,uniform}` | **prototype-verified** (narrowed to a native `udiv`; uniform −26.7%, predictable −18.8%, random −18.4%; u16/u32/u64/u8 ±0.2%) |
| `Filter`/`FilterMap::next_chunk` loop | `iter::bench_next_chunk_{filter,filter_map}_*` (3 new shuffled benches) | **prototype-verified** (mostly_false −38%/−41%, shuffled −19%/−34%, `filter_even` −15%; `filter_map_even` +3.3%) |
| `Fuse` lacks `InPlaceIterable` | `vec::bench_in_place_recycle` (invisible by time; allocations 1 → 0) | **prototype-verified** (standalone probe −12%; needs soundness sign-off) |
| `Iterator::array_chunks` | `iter::bench_next_chunk_trusted_random_access[_runtime_len]` (harness cannot see it; probe 3.06×) | **prototype-verified** (root cause is loop shape, not field access) |
| `BTreeMap` sequential-insert tree shape (`splitpoint`) | `btree::map::find_seq_10_000`, `range_*`, `insert_seq_*` | candidate (same query on a `collect`-built tree −50%) |
| `escape_debug_ext` BMP bitmap | `str::debug::{mostly_unicode,mixed,some_unicode}`, `fmt::write_{str,vec}_macro_debug` | **prototype-verified** (−87%/−75%; `ascii_*` flat) |
| `core::slice::memchr` | `str::split_unicode_ascii`, `split_*` (short segments); `contains`/`CStr` long scans | candidate (short −38%, long −58%; 16–40 B segments +9…19%) |
| `BTreeMap::iter[_mut]` fold | `btree::map::iteration[_mut]_fold_{20,1000,100000}` (new) | **prototype-verified** (fold_1000 −43%, no regressions) |
| `u8::is_ascii_*` / `[u8]::is_ascii` | `ascii::*::is_ascii_*` + `ascii::is_ascii::*` (80, **all invalid**) | fix bench first (three-layer breakage located) |
| `BTreeMap` in-node search (integer keys) | `btree::{map,set}::clone_*_and_remove_half`, `range_included_*`, `find_*`, `insert_*`; regressions: `set::difference_*`, `intersection_*`, `range_included_unbounded` | **prototype-verified** (remove_half −36%, range −48%; `difference_random` +89% to fix) |
| `BTreeMap::IntoIter` drop | `btree::{map,set}::clone_*`, `from_iter_seq_*` (baseline side) | **prototype-verified** (clone −57…−66%, no regressions) |
| `for` over `VecDeque::iter[_mut]` (`next()`) | `vec_deque::bench_{iter,mut_iter}_1000` (`into_iter*`/`try_fold` are layout noise) | **prototype-verified** (−31%, zero semantic change) |
| `from_str_radix(_, 10)` for 32/64-bit | `num::bench_{u32,u64,i32,i64}_from_str[_radix_10]` (mix averages 2.8 digits; single strings ≥8 digits −65…−75%) | **prototype-verified** (±27% layout noise swamps the official numbers) |
| `Rev<I>::count` | `str::char_{indicesator,iterator}_rev` | **prototype-verified** (−68…−76%; landing needs a specialization trait to preserve side-effect order) |
| `[T]::cmp`/`partial_cmp`/`<` (wide integers) | `slice` comparisons, `binary_search`, `BTreeMap<Vec<T>,_>` keys; standalone prototype (equal slices 0.36→0.10 ns/elem, 3.3–3.7×) | **SVE prototype-verified** (hook `AlwaysApplicableOrd` already exists; `u8`/`bool` already go through memcmp) |
| `[f32]`/`[f64]` slice equality | `[f32]==[f32]`, float `starts_with`/`ends_with`; standalone prototype (0.67→0.11 ns/elem, 4.5–6.1×) | **SVE prototype-verified** (`fcmne` is IEEE `!=`; `ptest` required before `b.any`) |
| `VecDeque::retain`/`retain_mut` | standalone prototype u32 (64→2.20×, 1,000→2.05×, 100,000→10.43×; 9.91× with wrap at 1/3) | **SVE prototype-verified** (ring segmented into physical chunks + scratch copy-back; panic guard follows the `sve_retain.rs` template) |
| `Vec::extract_if(..)` fully consumed | standalone prototype u32 (100,000: 5.13× vs `with_capacity`; 64: 1.20×) | **SVE prototype-verified** (same mask compacted both ways; must confirm pred timing may change from per-`next` to per-chunk) |
| `chunk_by().count()` / run counting | standalone prototype u32 (16→2.69×, 4,096→2.49×, 65,536→2.23×) | **SVE prototype-verified** (`cmpne`+`cntp`, no regressions) |
| ASCII closed-class counting (`filter(pred).count()`) | standalone prototype (digits: 24→6.00×, 96→7.31×, 65,536→5.02×; whitespace: 64→3.42×) | **SVE prototype-verified** (`cmphs`/`cmpls`+`cntp`; std has no matching public API) |
| `unzip` AoS→SoA (`&[(u32,u32)]`) | standalone prototype (16→12.44×, 64→5.52×, 65,536→9.57×; ~1.0× across 1K–4K, bandwidth-bound) | **SVE prototype-verified** (`ld2w`/`st1w`; needs a new slice-source `unzip` hook) |
| `trim_ascii_start`/`_end` | standalone prototype (1/3 leading ws: 64→2.77×, 4,096→1.74×; **0.38–0.42× regression with no whitespace**) | **SVE prototype-verified** (needs a scalar first-byte gate; `const_eval_select!` for CTFE) |
| `[T]::is_sorted` tail block | standalone prototype u32 (64→3.57×, 1,000→1.22×, 100,000→1.05×) | **SVE prototype-verified** (main payoff is fixing the scalar tail, 3.57× in pure Rust; SVE is second-order) |
| `[u8]::is_ascii` SVE mid-range | standalone prototype (16–192 B wins 1.13–1.80×; **0.68–0.69× regression past 256 B**) | **verified, narrow payoff window** (in-tree NEON 64 B unroll is stronger on long input; low priority) |
| Rejected SVE shapes | standalone prototype: `make_ascii_uppercase` 0.48–0.78×, `Vec::dedup_by` (closure) 0.80–0.86×, `String::retain` +36…+212% | **measured negative, do not implement** |
| `Iterator::position` (generic closure) | 0.46 ns/elem vs `contains` 0.07 (same operation, 6× slower) | **API gap** (no closed `[T]::index_of`; with one, the SVE shape matches §20) |
