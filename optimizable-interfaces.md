# 可優化接口總結

從 `benchmarks-conclusion.md` 的全部分析中,只保留**存在可行優化**的接口。按驗證程度分三層:已落地並通過官方 harness、原型已實測驗證、候選方向(未原型化)。已確認無優化空間的接口(`binary_search`、`starts_with`、`Vec::push`、`HashMap::new`、`PeekMut::deref_mut`、`int_log`、`memcmp` 類)不在此列。

所有數據均為本機 HiSilicon aarch64(2.9 GHz,SVE-256)實測;x86 影響已在各節單獨標註。

---

## 一、已落地(樹內修改 + 官方 benchmark 驗證)

### 1. `slice::rotate_left` / `rotate_right`(`ptr_rotate`)

**接口**:`library/core/src/slice/rotate.rs::ptr_rotate` 的算法分派。

**慢的原因**:兩個獨立病理——
- 大元素(>32B)走 gcd 算法:以 `left × size_of::<T>()` 為步長大跨度掃描(72 KB/步),dTLB miss 2.16%,且 128B 臨時量經棧中轉(單條棧寫佔 45.8% 樣本);
- swap 算法縮小到 `left=2` 類子問題時退化:130 萬次 2 元素交換。

**優化方法**:
- Fix A:大元素尺寸為 `usize` 倍數且對齊足夠時,把切片重新解釋為 `MaybeUninit<usize>` 切片旋轉(旋轉是純字節置換),繞開 gcd;
- Fix B:swap 子問題的 `min(left,right)` 落入 256B 棧緩衝能力時改用 memmove 一次收尾。

```rust
// Fix A(在 ptr_rotate 三路分派前,經 const_eval_select 限運行時):
if size_of::<T>() > size_of::<[usize; 4]>()
    && size_of::<T>() % size_of::<usize>() == 0
    && align_of::<T>() >= align_of::<usize>()
{
    let ratio = size_of::<T>() / size_of::<usize>();
    return ptr_rotate(left * ratio, mid as *mut MaybeUninit<usize>, right * ratio);
}
// Fix B(在 ptr_rotate_swap 外層迴圈尾):
if left.min(right) <= size_of::<BufType>() / size_of::<T>() {
    return ptr_rotate_memmove(left, mid, right);
}
```

**Benchmarks**(`library/alloctests/benches/slice.rs`,20 項全跑無回退):

| benchmark | 提升 |
|---|---:|
| `rotate_huge_by9199_big` | **1.99×** |
| `rotate_huge_by1234577_big` | 1.32× |
| `rotate_huge_half_plus_one` | 1.32× |
| `rotate_medium_half_plus_one` | **3.52×** |
| 其餘 16 項(tiny/medium/huge 全型別) | 持平 ±2% |

x86:方向一致(gcd 的 TLB 病理在 2MB 大頁下較輕,Fix B 平臺無關)。

### 2. `char::to_uppercase` / `char::to_lowercase`(Latin-1 fast path)

**接口**:`library/core/src/unicode/unicode_data.rs::conversions::{to_upper,to_lower}`(注意:生成文件,正式 PR 應改 `src/tools/unicode-table-generator`)。

**慢的原因**:fast path 只覆蓋到 U+00B5/U+00C0,其餘 Latin-1 字符全部進 `lookup`:185 條 singles 範圍表 binary search(8 輪 `csel` 串行依賴鏈)+ miss 後 102 條 multis 表再 7 輪。**~34% 的輸入(¶·×÷ 等無映射字符)走完最貴的雙重搜索只為返回「原樣」**。

**優化方法**:Latin-1 的大小寫映射已被 Unicode 凍結且極簡,用一段 match 覆蓋 `c < 0x100`:

```rust
// to_upper,在現有 c < '\u{B5}' fast path 之後:
if c <= '\u{FF}' {
    return match c {
        '\u{B5}' => ['\u{39C}', '\0', '\0'],            // µ → Μ
        '\u{DF}' => ['S', 'S', '\0'],                   // ß → SS
        '\u{E0}'..='\u{FE}' if c != '\u{F7}' =>         // à..þ(除÷)→ −0x20
            [unsafe { char::from_u32_unchecked(c as u32 - 0x20) }, '\0', '\0'],
        '\u{FF}' => ['\u{178}', '\0', '\0'],            // ÿ → Ÿ
        _ => [c, '\0', '\0'],
    };
}
// to_lower 對稱:只有 '\u{C0}'..='\u{DE}'(除 '\u{D7}')+0x20 一個區間。
```

**Benchmarks**(`library/coretests/benches/char/methods.rs`,6 項全部受益,`char::` 測試 37+13 全過):

| benchmark | 原始 | 兩 patch 後 | 變化 |
|---|---:|---:|---:|
| `bench_non_ascii_char_to_uppercase` | ~166 µs | 28.97 µs | **-82.8%** |
| `bench_non_ascii_char_to_lowercase` | 120.98 µs | 26.47 µs | **-78.1%** |
| `bench_ascii_mix_to_uppercase` | 94.97 µs | 24.79 µs | -73.9% |
| `bench_ascii_mix_to_lowercase` | 70.64 µs | 23.83 µs | -66.3% |
| `bench_ascii_char_to_uppercase` | 24.67 µs | 21.19 µs | -14.1% |
| `bench_ascii_char_to_lowercase` | 24.67 µs | 21.19 µs | -14.1% |

x86:表結構層優化,平臺無關,收益可移植。

---

## 二、原型已實測驗證(未落地)

### 3. `BinaryHeap` sift_down 家族(sibling child choice)

**接口**:`library/alloc/src/collections/binary_heap/mod.rs` 的 `sift_down_range` 與 `sift_down_to_bottom` 中的 `child += (left <= right) as usize`;經由 `BinaryHeap::from(Vec)`、`pop`、`PeekMut::drop` 三個公開入口到達。

**慢的原因**:aarch64 上 `(cmp) as usize` 被生成為**真分支** `b.hi`(x86_64 生成 `sbb` branchless,無此問題)。隨機資料上 sibling 比較近 50% 熵,branch miss 9–21%,IPC 壓到 1.2–1.7。三個獨立 benchmark 現場證實同一病灶。

**分支的來源**(已定位到具體 pass,完整過程見 `benchmarks-conclusion.md`「`BinaryHeap` sift_down:aarch64 child-choice 分支的 LLVM 來源定位」):

- 中端優化完成後的 IR 是 branchless 的 `icmp ule` + `zext i1` + `add`;分支由 AArch64 後端在 `opt-level=3` 下額外運行的 IR 級 pass **`select-optimize`**(`lib/CodeGen/SelectOptimize.cpp`)插入,`-print-after-all` 顯示 `freeze i1` + `br i1` 首次出現在該 pass 之後。x86 後端不運行此 pass。
- 該 pass 把「二元運算的一個操作數是單次使用的 `zext i1`」識別為 select-like(`SelectOptimize.cpp:790–843` 的 `m_c_BinOp(m_Value(), m_OneUse(m_ZExtOrSExt(...)))`),即把 `child + zext(c)` 視為 `select c, child+1, child`。
- 啟用條件是 subtarget feature `FeatureEnableSelectOptimize`(`AArch64Features.td` 的 `enable-select-opt`)。`generic`(本機 `target-cpu=native` 的解析結果)及 Neoverse N1/N2/V1/V2、Cortex-A76/A78/X1 等 tune list 預設開啟;Cortex-A53/A55、Apple M 系列、tsv110、a64fx 不開,實測這些 CPU 下輸出即為 `cinc x13, x0, ls`。
- 判定依據(`-C remark=select-optimize`):`Profitable to convert to branch (loop analysis). BranchCost=8.5625, SelectCost=15.0`。內層迴圈成本模型用固定 25% 誤預測率(`-mispredict-default-rate`)估算分支成本,而 sibling 比較實際接近 50% 熵,分支成本被低估約一倍。
- 反向驗證:`-C llvm-args=-aarch64-select-opt=false` 或 `-C target-feature=-enable-select-opt` 後,SelectionDAG 直接生成 `cmp; cinc x13, x0, ls`,與 x86 的 `sbb` 同構。

```text
現狀(generic):                      關閉 select-optimize:
  cmp   x13, x12                       cmp   x13, x12
  b.hi  .LBB1_4                        cinc  x13, x0, ls
  add   x12, x0, #1                    ldr   x14, [x8, x13, lsl #3]
  ldr   x14, [x8, x12, lsl #3]
  ...
.LBB1_4:
  mov   x12, x0
  ldr   x14, [x8, x0, lsl #3]
```

**優化方法**:child 索引選擇改用 `hint::select_unpredictable`(aarch64 生成 `csel`,x86 生成 `cmova`,不劣化 x86):

```rust
// sift_down_range 內,替換 child += (...) as usize:
let right_is_greater = unsafe { hole.get(child) <= hole.get(child + 1) };
child = hint::select_unpredictable(right_is_greater, child + 1, child);
```

**Benchmarks**(`library/alloctests/benches/binary_heap.rs`):

| benchmark | 現狀 | select 原型 | 變化 | branch misses |
|---|---:|---:|---:|---:|
| `bench_from_vec` | 608 µs | ~390 µs | **-41%** | -74.5% |
| `bench_find_smallest_1000` | 263 µs | ~173 µs | **-37%** | -81.9% |
| `bench_pop` | 438 µs | ~281 µs | **-34%** | -97.6% |

**回退面**(落地前必須評估):ascending 輸入的 from_vec +6%;72B 大元素收益消失;昂貴 comparator 未測。`pop` 場景輸入本質高熵,回退風險最低。

**原型生效機制的脆弱性**:`select-optimize` 只在非迴圈路徑(`isConvertToBranchProfitableBase`)檢查 `!unpredictable`,內層迴圈路徑不檢查;dump 證實 `select_unpredictable` 版本同樣被轉成了分支(metadata 被搬到 `br` 上)。最終仍是 `csel` 是因為機器層 `early-ifcvt` 把 diamond 折了回去,且只以 1 cycle 餘量落在門檻內(`-C remark=early-ifcvt`:原型「condition adds 5 cycles ... under the threshold of 5」,現狀「would add 6 cycles ... exceeding the limit of 5」;差異來自原型的 true 塊為空而 `zext+add` 版多一條 `add`)。加 `-disable-early-ifcvt` 後原型同樣退化為 `b.hi`。因此落地時必須以 asm 或 remark 確認 `Hole<T>` 版本的實際輸出,不能只看 benchmark 數字;PR 說明應把原因寫為 `select-optimize` 對 `zext+add` select-like 形狀的迴圈啟發式誤判。

### 4. `str::chars().count()`(`count_chars` NEON 特化)

**接口**:`library/core/src/str/count.rs::do_count_chars`。

**慢的原因**:LLVM 自動向量化的兩個病理——把 4-usize 展開識別成 interleave group 生成低吞吐的 `ld4` 交錯載入;256B/迭代展開超出暫存器預算,迴圈內 8 次棧溢出往返。可移植源碼重構無效(生成同樣形態),是目標相關 cost model 問題。

**優化方法**:`#[cfg(target_arch = "aarch64")]` 顯式 NEON——非連續字節判定恰是一條 `cmge`:

```rust
// 64B/迭代,4 路 u8 累加器,每 ≤255 輪 vaddlvq_u8 收攏:
let m = vcgeq_s8(chunk, vdupq_n_s8(-64));   // 非連續字節 → 0xFF
acc = vsubq_u8(acc, m);                      // −0xFF ≡ +1
```

**Benchmarks**(`library/coretests/benches/str/char_count.rs`,case00 組 × 4 語言 × 5 尺寸):

| 尺寸 | libcore | NEON 原型 | 提升 |
|---|---:|---:|---:|
| huge(300–360KB) | 15.7–16.0 GB/s | **49.3–49.6 GB/s** | **3.1×** |
| large(~5KB) | 15.8 GB/s | 52.8 GB/s | 3.3× |
| medium(~670B) | 14.0 GB/s | 23.2 GB/s | 1.66× |
| small/tiny | — | — | <64B 沿用現路徑即可歸零回退 |

x86:SSE2 自動向量化未必有同樣病理,需另測後決定是否特化。SVE 增益上限 <30%(帶寬封頂),NEON 已拿走絕大部分。

### 5. `Vec::dedup`(prescan 分塊向量化)

**接口**:`library/alloc/src/vec/mod.rs::dedup_by` 的第一段只讀 prescan;可落地位置是 `dedup()`(`T: PartialEq`)經 specialization 限定 bitwise-eq 類型。

**慢的原因**:prescan 是逐元素早退的標量相鄰比較(~7 指令/元素,IPC 5.26 已到標量極限);早退語義 + 任意 `FnMut` 閉包使 LLVM 無法自動向量化。

**優化方法**:按 16 元素塊做無早退歸約(LLVM 向量化為 `cmeq`),命中塊後標量重掃定位;**必須用 `get_unchecked`**(帶邊界檢查則完全不向量化,收益從 3× 掉到 8%):

```rust
while i + N <= len {
    let mut any = false;
    for j in 0..N {
        any |= unsafe { v.get_unchecked(i + j) == v.get_unchecked(i + j - 1) };
    }
    if any { /* 標量重掃塊內,返回精確 first index */ }
    i += N;
}
```

**Benchmarks**(`library/alloctests/benches/vec.rs`):

| benchmark | scalar | chunk16 | sve2x(inline asm) |
|---|---:|---:|---:|
| `bench_dedup_none_100` | 42.3 ns | **13.0(-69%)** | 12.6 |
| `bench_dedup_none_1000` | 427 ns | 121(-72%) | **107** |
| `bench_dedup_none_10000` | 4.77 µs | 1.32(-72%) | **1.14** |
| `bench_dedup_none_100000` | 59.7 µs | 同比例 | — |
| `bench_dedup_all_*` / `bench_dedup_random_*`(立即命中) | 1.4 ns | +2×回退 | 需 hybrid 起步消除 |

x86:同構收益可移植,AVX2 穩態指令數(9/塊)優於 NEON(13/塊),預期只高不低。

### 10. `BTreeMap` 節點內搜索(原生整數鍵無分支特化)——樹內原型已驗證

**接口**:`library/alloc/src/collections/btree/search.rs::find_key_index`——`get`/`insert`/`remove`/`range` 及 `BTreeSet` 對應接口全部經此。

**慢的原因**:cap=11 節點內的 early-exit 線性掃描,三向比較本身已被 if-conversion(`cset/csinv`),但「首個非 Greater 即退出」是數據依賴分支,退出位置隨訪問掃過節點而漂移。`clone_slim_10k_and_remove_half` 實測:每次 remove ~2.9 次分支失誤(4 層節點幾乎每層一次),搜索佔 remove 成本 86%,8.6 ns/節點訪問。

**優化方法**(樹內原型,2026-09-07 已實測):`find_key_index` 經 `min_specialization` 內部 trait 對 12 個原生整數類型特化——**僅滿節點**走外聯(`#[inline(never)]`,保調用點內聯預算)的無分支定長掃描(NEON 5×`cmhi`+`addp` / SSE2 `pcmpgtd`),掃描前一條首鍵三向守衛保住最左偏置模式的 O(1) 退出;非滿節點保持 early-exit 原形。三要素缺一不可:無條件全掃描令 `remove_all` +96%、`find_rand_100` +144%;內聯體膨脹令 `insert_rand` +43%(`search_tree` 失去內聯)。

**原型核心**(`search.rs`):

```rust
// search.rs:find_key_index 經內部 trait 對原生整數鍵特化;非滿節點沿用 early-exit
if sub.len() == CAPACITY {
    return spec_full_scan(sub_as_array, key);   // #[inline(never)],保調用點內聯預算
}
/* 原 early-exit 迴圈 */

#[inline(never)]
fn spec_full_scan<T: Copy + Ord>(full: &[T; CAPACITY], key: T) -> (usize, bool) {
    if key <= full[0] { return (0, key == full[0]); }        // 首鍵守衛:保住最左偏置的 O(1) 退出
    let count = full.iter().filter(|&&k| k < key).count();  // 無分支定長計數 → cmhi×5 + addp
    (count, count < CAPACITY && full[count] == key)
}
```

**Benchmarks**(`./x bench library/alloctests --stage 1`,aarch64;2026-09-15 完整 A/B:100 項 btree 全跑,各變體單獨構建、同一 harness 二進位互換 libstd,關鍵項 3 次交錯複測,波動 <2%;「僅 #10」列為只打 search.rs 補丁的隔離構建):

| benchmark | 現狀 | 僅 #10 | #10+#11 | 變化(#10+#11) |
|---|---:|---:|---:|---:|
| `map::clone_slim_10k_and_remove_half` | 350 µs | 247 µs | 224 µs | **−36%**(branch-miss 3.45%→1.03%,IPC 2.46→3.27) |
| `set::clone_10k_and_remove_half` | 309 µs | 210 µs | 187 µs | **−39%** |
| `map::range_included_included` | 469 µs | 251 µs | 243 µs | **−48%** |
| `map::range_included_excluded` | 440 µs | 262 µs | 253 µs | **−43%** |
| `map::find_rand_10_000` | 61.2 ns | 58.3 ns | 58.5 ns | −4.4% |
| `map::find_{seq,rand}_100` / `insert_*`(6 項) | — | ±2% | ±2% | 持平 |
| `map::clone_slim_10k_and_remove_all` | 378 µs | 370 µs | 389 µs | +3%(佈局噪聲) |
| `set::intersection_{pos,neg}_*`(8 項,絕對值 6–10 ns)/ `staggered_{100_vs_100,10k_vs_10k}` | 6–10 ns / 0.32–32 µs | +6…+13% | +9…+17% / +7% | **回退**(見下) |
| `set::is_subset_100_vs_10k` / `difference_staggered_*` | 1.36 / 0.78–82 µs | +17% / +12…+20% | +16% / +10…+17% | **回退** |
| `map::range_included_unbounded` | 98.3 µs | 146 µs | 146 µs | **+49%** |
| `set::difference_random_{100,10k}_vs_{100,10k}`(4 項) | 0.37–46 µs | +50…+82% | +49…+89% | **+89% 最差** |

**回退面**(此前未報,落地前必須解決):滿節點無條件全掃描在「鍵不在節點內且落點靠前」的訪問模式下做 11 次比較,而 early-exit 只需 1–2 次。`difference_random_*` 走 `DifferenceInner::Search`(逐元素 `other_set.contains`,隨機鍵幾乎都 miss),`range_included_unbounded` 的下界搜索遍歷 `find_leaf_edges`,兩者 perf 均顯示 `spec_full_scan` 佔 58% 樣本、指令數 ×1.7–2.0。首鍵守衛只救「落點=0」,救不了落點 1–3。可選修法:(a) 守衛擴到前 2–4 鍵(cost 4 條 `csel`);(b) 僅對 `remove`/`insert` 路徑(`search_tree` 的 `Mut` borrow)啓用全掃描,`Immut` 查找沿用 early-exit——`difference`/`range`/`contains` 全在 `Immut` 路徑,`remove_half` 在 `Mut` 路徑,可零回退保住主要收益;(c) 用 `ctz(movemask)` 取代 popcount 讓全掃描也得到落點位置後直接返回,消除掃描後的二次 `full[count]` 載入。其餘落地待辦:miri、x86 實機、u128 剔除。核心微基準:`/tmp/btree_bench/probe_kernel.rs`(隨機退出 9.6–9.9 → 3.7–5.1 ns,1.9–2.7×)。

### 11. `BTreeMap::IntoIter` drop 的逐元素 dying 走查(`!needs_drop` 節點級特化)——樹內原型已驗證

**接口**:`library/alloc/src/collections/btree/map.rs` 的 `impl Drop for BTreeMap`/`IntoIter`(map drop、`clear`、clone 臨時對象全部經此)。

**慢的原因**:drop 逐元素調用 `deallocating_next`(每元素一次函數調用)。小 crate 裡內聯後 LLVM 可將無 drop 元素的走查坍縮成逐節點;官方 allocbenches 這種多調用點的大 crate 裡不內聯——`clone_slim_10k` 的 125 µs 裡 **42%(5.2 ns/元素)是這條退化路徑**,整個 `clone_slim_10k_and_*` 系列的減法基線被放大 ~2.2×。

**優化方法**(樹內原型已實測):`BTreeMap::drop` 對 `!needs_drop::<K>() && !needs_drop::<V>()` 走新增的 `NodeRef<Dying,_,_,LeafOrInternal>::deallocate_subtree`(navigate.rs):後序節點級釋放,結構性 O(節點數),不賭內聯運氣。

**原型核心**(`map.rs` + `navigate.rs`):

```rust
// map.rs:impl Drop for BTreeMap
if !needs_drop::<K>() && !needs_drop::<V>() {
    root.into_dying().deallocate_subtree(alloc);   // 節點級後序釋放,不逐元素
    return;
}

// navigate.rs:走到最左葉 → deallocate_and_ascend;父邊右側還有子樹就下潛到其最左葉,否則繼續上升
let mut node = self.first_leaf_edge().into_node();
while let Some(parent_edge) = node.deallocate_and_ascend(alloc) {
    node = match parent_edge.right_kv() {
        Ok(kv) => kv.right_edge().descend().first_leaf_edge().into_node(),
        Err(last_edge) => last_edge.into_node(),
    };
}
```

**Benchmarks**(同上 A/B;「僅 #11」列為只打 map.rs + navigate.rs 補丁的隔離構建):

| benchmark | 現狀 | 僅 #11 | 變化 |
|---|---:|---:|---:|
| `set::clone_100` / `_and_clear` | 1.07 µs | 0.37 µs | **−66%** |
| `set::clone_10k` / `_and_clear` | 111 µs | 40 µs | **−64%** |
| `map::clone_slim_100` / `_and_clear` | 1.14 µs | 0.45 µs | **−60%** |
| `map::clone_slim_10k` / `_and_clear` | 124 µs | 53.0 µs | **−57%** |
| `map::from_iter_seq_100` / `_10_000` | 1.53 / 169 µs | 0.57 / 83 µs | **−62% / −51%**(收集期臨時 map 的 drop) |
| `set::clone_{100,10k}_and_drain_half` | 1.75 / 171 µs | 1.41 / 140 µs | −19% / −18% |
| `map::clone_slim_{100,10k}_and_drain_half` | 1.43 / 142 µs | 1.26 / 125 µs | −12% |
| `map::clone_fat_val_100_and_clear` | 5.41 µs | 4.72 µs | −13% |
| `*_and_into_iter`(4 項) | — | +0.2…+4.4% | 部分消費 `IntoIter::drop` 仍逐元素 |
| `*_and_pop_all` / `*_and_remove_all` | — | +1…+2% | 佈局噪聲 |
| 其餘 80 項 | — | ±3% | 持平 |

無真回退;btree 測試 278 項全過(172 unit + 100 bench-as-test + 6 doc)。殘餘:`clone_*_and_into_iter` 的 +4% 來自 `IntoIter` 被部分消費後仍走逐元素 `deallocating_next`,可在 `IntoIter::drop` 對剩餘子樹複用 `deallocate_subtree` 收掉。

### 6. `flt2dec` Dragon `format_exact`(9 位一批 + 單趟融合)——樹內原型已驗證

**接口**:`library/core/src/num/imp/flt2dec/strategy/dragon.rs::format_exact`(`f64::MAX` 的 `{}` 格式化與高精度 `{:.N}` 都會到達;`grisu::format_exact` 高精度時 100% fallback 到此)。

**慢的原因**(2026-09-15 修正):原描述「每位一次除 10」不準確——實際每個十進制位做 4 次 `mant >= scale{8,4,2,1}` 比較 + 平均 ~2 次 O(limbs) 減法 + 1 次 `mul_small(10)`,即每位 ~3–4 趟 32 limb 掃描;1024 位 = 42 µs,perf 99.3% 在 `format_exact` 本體,IPC 2.4(純指令數,無微架構事件)。

**優化方法**(樹內原型):
1. **商估算取代逐位比減**:從 `scale` 最高兩個 limb 取 64-bit 窗口 `sdiv`,`mant` 取對應 96-bit 窗口,`q = mant_win × 10^(m−1) / sdiv` 一次得到 m ≤ 9 位(估算只會偏小、且最多差幾個單位,再用 `mant >= scale10` 修正);
2. **單趟融合**:新增 `Big32x40::mul_small_sub_mul_small(mul, other, sub)` 一趟算出 `mant × 10^m − q × scale10`,並在該趟內順帶 trim `size`(否則 size 每輪 +1,小數會退化 3×——首版踩到)。

大數操作次數從每位 ~3.5 趟降到每 9 位 ~1.2 趟。

**原型核心**(`dragon.rs` + `bignum.rs`):

```rust
// dragon.rs:format_exact 的 digit 迴圈 —— 每輪產 m ≤ 9 位
let sdiv = top_64bit_window(scale) + 1;                  // 只算一次;+1 保證估算只偏小
while i < len {
    let m = (len - i).min(9);
    let q = (top_96bit_window(mant) * 10^(m-1) / sdiv) as u32;   // 標量估商,不碰大數
    mant.mul_small_sub_mul_small(10^m, &scale10, q);     // 單趟:mant = mant·10^m − q·scale10
    while mant >= scale10 { mant.sub(&scale10); q += 1; } // 修正估算,罕見
    emit_digits(q, m); i += m;
}

// bignum.rs:新增單趟 self = self·mul − other·sub,同趟 trim size(否則 size 每輪 +1,小數退化 3×)
```

**Benchmarks**(`library/coretests/benches/num/flt2dec/`,`./x bench library/coretests --stage 1`,flt2dec 39 項測試全過):

| benchmark | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| `dragon::bench_big_exact_inf` | 42.2 µs | **12.9 µs** | **−69%**(指令 1.75G→1.02G) |
| `grisu::bench_big_exact_inf`(fallback 到 dragon) | 42.2 µs | 13.0 µs | **−69%** |
| `dragon::bench_big_exact_12` | 1822 ns | 645 ns | **−65%** |
| `dragon::bench_big_exact_3` | 822 ns | 497 ns | −40% |
| `dragon::bench_small_exact_inf` | 1013 ns | 729 ns | −28% |
| `grisu::bench_small_exact_inf` | 1064 ns | 767 ns | −28% |
| `dragon::bench_small_exact_12` | 152 ns | 82 ns | −46% |
| `dragon::bench_small_exact_3` | 86 ns | 56 ns | −34% |
| `dragon::bench_{small,big}_shortest`、`grisu::*_exact_{3,12}`、`num::flt2dec::*`(9 項) | — | ±2% | 持平(未觸及) |

**回退面**:無。`big_exact_3` 剩餘成本在 `mul_pow10`/`scale` 建構(與位數無關)。x86 同構(`mulx`/`sbb`)。`Big64x20` 限寬可再減半趟數,未做。

### 7. `Iterator::array_chunks`(TRA fold 迴圈形態)——樹內原型已驗證

**接口**:`library/core/src/iter/adapters/array_chunks.rs` 的 `SpecFold`(TrustedRandomAccess 特化)。

**慢的原因**(2026-09-15 修正根因):原判斷「`from_fn` 閉包經 `&mut self.iter` 訪問結構體字段阻斷向量化」**不成立**——把 `iter` 解構到局部變量後 98 ns 不變。真因是 `while inner_len - i >= N { ...; i += N }` 這個迴圈形態:LLVM 算不出 trip count(`len - i` 每輪重算、無符號減法讓 SCEV 無法證明單調),LoopVectorizer 直接放棄。改寫成 `for c in 0..len / N` 計數迴圈即向量化(`ldp q6,q7` + `shl v.2d`)。另一發現:**官方 harness 測不到此懸崖,原因已定位到 codegen-units**。同一段源碼進入 LoopVectorize 時的迴圈退出條件有兩種形態:`sub len, i_next; icmp ugt _, 7`(SCEV 可算 trip count → 向量化)與 `sub len, i; and _, -8; icmp eq _, 8`(InstCombine 的合法改寫,但 SCEV 算不出 trip count → 標量)。哪一種出現取決於迴圈所在函數的形狀:bootstrap 以 **16 個 codegen unit** 編譯 `corebenches`(二進位中可見 16 個 `-cgu.N`),多 CGU 下 `Bencher::iter::<closure>` 是 `hidden` 而非 `internal` 連結性,LLVM 不把它內聯進閉包的 `call_once`,迴圈留在獨立的 `Bencher::iter` 函數裡,InstCombine 不動退出條件;單文件 `rustc` 探針被分區器合併成 **1 個 CGU**,全部內聯成一個函數後 InstCombine 在向量化前把退出條件改寫成 `and/eq` 形式。對同一探針加 `-Ccodegen-units=2` 即復現官方數字(98 → 33 ns;官方 bench 原文 38 ns)。但 `#[inline(never)] fn(&[u8])`(最常見的真實形態:接收切片的函數)在 1 或 2 CGU 下都是 98 ns——它與 CGU 數無關,只是不在那個幸運的函數形狀裡。因此官方 bench 是「碰巧落在好形狀」的例外,不代表用戶代碼;計數迴圈改寫在所有形態下一致 32–39 ns。

**優化方法**:

**原型核心**(`array_chunks.rs`):

```rust
// array_chunks.rs:SpecFold(TrustedRandomAccess)—— 只改迴圈形態
- while inner_len - i >= N { ...; i += N }     // LLVM 算不出 trip count,不向量化
+ for c in 0..inner_len / N { let i = c * N; ... }   // 計數迴圈 → ldp q + shl v.2d
```

**Benchmarks**(探針 `/tmp/btree_bench/probe7/probe2.rs`,stage1 rustc `-O`,1024 B,`#[inline(never)]` 邊界;官方 `bench_next_chunk_*` 9 項含新增 `_runtime_len` 均 ±3% 持平):

| 形態(運行時長度) | 現狀 | 計數迴圈 | 變化 |
|---|---:|---:|---:|
| `map(*b).array_chunks::<8>().map(..).sum()` | 98.1 ns | **32.1 ns** | **3.06×** |
| `copied().array_chunks::<8>()...sum()` | 98.1 ns | 32.0 ns | 3.07× |
| `.array_chunks::<8>().fold(..)` / `.for_each(..)` | 98.1 ns | 32.0 ns | 3.06× |
| 內聯進計時迴圈(harness 形態) | 99.9 ns | 33.5 ns | 2.98× |
| `as_chunks::<8>()` 手寫(上限) | 32.1 ns | 32.1 ns | — |
| `while let Some(c) = it.next()`(非 fold 路徑,不受影響) | 705 ns | 705 ns | — |

array_chunks 測試 21 項全過;`try_fold`/`next` 路徑未動。建議連同 `_runtime_len` 變體一起落地,但注意該變體在 harness 裡本來就不慢,守護價值有限。

### 8. `BTreeMap::iter` / `iter_mut`(fold 葉節點批量化)——樹內原型已驗證

**接口**:`library/alloc/src/collections/btree/map.rs` 的 `Iter/IterMut/Keys/Values`(原無 fold 覆寫)。

**慢的原因**:無微架構事件(miss ≈0、IPC 3.6–4.0),純指令數——每元素一次 `next()` 狀態機(18.6 指令/元素 vs Vec 的 4.0),含 length 遞減、葉內邊界檢查、每 11 元素一次爬樹。

**優化方法**(樹內原型):`node.rs` 新增 `NodeRef<{Immut,ValMut}, Leaf>::into_key_val_slices_from(idx)`,把葉內 `idx..len` 的 keys/vals 借成切片;`navigate.rs` 新增 `LazyLeafRange::fold_unchecked(length, init, f)`:葉內直線 `zip` 迴圈,葉耗盡後走一次 `next_kv()` 拿祖先 KV 並 `next_leaf_edge()` 下潛到下一葉,爬樹成本從每元素攤到每節點;`map.rs` 的 `Iter/IterMut::fold` 轉發,`Keys/Values::fold` 經 inner 投影。`ValMut` 版本只借 `idx..` 之後的元素,不與已發出的 `&mut V` 別名。

**原型核心**(`navigate.rs` + `node.rs` + `map.rs`):

```rust
// navigate.rs:LazyLeafRange::fold_unchecked —— 葉內直線迴圈,爬樹每節點一次
let mut edge = self.init_front();
loop {
    let (keys, vals) = edge.node().key_val_slices_from(edge.idx());   // 借成切片
    let take = keys.len().min(length);
    for (k, v) in zip(&keys[..take], &vals[..take]) { acc = f(acc, (k, v)); }
    length -= take;
    if length == 0 { return acc; }
    let kv = edge.node().last_edge().next_kv();   // 葉耗盡:祖先 KV 一次
    acc = f(acc, kv.into_kv()); length -= 1;
    edge = kv.next_leaf_edge();                   // 下潛到下一葉
}

// map.rs:Iter / IterMut 覆寫 fold → range.fold_unchecked(length, init, f);Keys / Values 經 inner 投影
```

**Benchmarks**(`library/alloctests/benches/btree/map.rs`,新增 `iteration[_mut]_fold_{20,1000,100000}` 用 `for_each` 走 fold;現狀列為同一 bench 在無 fold 覆寫的樹上的數值;3 次交錯複測):

| benchmark | 現狀(default fold) | 原型 | 變化 |
|---|---:|---:|---:|
| `iteration_fold_1000` | 1812 ns | **1030 ns** | **−43%** |
| `iteration_mut_fold_1000` | 1807 ns | 995 ns | **−45%** |
| `iteration_fold_20` | 22.5 ns | 17.1 ns | −24% |
| `iteration_mut_fold_20` | 24.5 ns | 17.4 ns | −29% |
| `iteration_fold_100000` | 358 µs | 329 µs | −8%(cache-bound,3.3 ns/元素) |
| `iteration_mut_fold_100000` | 355 µs | 345 µs | −3% |
| `iteration[_mut]_{20,1000,100000}`(`for` 迴圈,走 `next()`) | — | ±2% | 持平(未觸及) |

**回退面**:無(btree 測試 278 項全過)。`for entry in &map` 這種 `for` 迴圈語法糖不經 fold,收益僅惠及 `for_each`/`fold`/`sum`/`count`/`map().collect()` 類消費;`Range`/`IntoIter`/`next_back` 方向未做。

---

## 三、候選方向(根因已定位,修復未原型化)

(#6、#7、#8 已於 2026-09-15 原型化並上移至第二層。)

### 9. `u8::is_ascii_*` 謂詞族(SWAR/bitset 化)——前提是先修 benchmark(2026-09-08 更新:全家族無效,含 `is_ascii` 自身)

**接口**:`u8::is_ascii_whitespace/digit/alphanumeric/...` 經 `iter().all()` 的批量掃描形態。

**慢的原因**:全掃描是 0.52 ns/B 的逐字節 match,對比 `<[u8]>::is_ascii`(NEON,探針真值 61 GB/s ≈ 0.0164 ns/B)有 **~30× 差距**。但現有 benchmark 全部測不到真東西——三層失效(詳見 benchmarks-conclusion 的 `ascii::long::is_ascii` 章):(1) 外層宏 `to_vec()` 在計時迴圈內,佔 60–100%;(2) 常量輸入被 LLVM 部分編譯期求值,`long::is_ascii` 運行時只掃 ~400B/6990B(先前本條引用的「is_ascii 0.018 ns/B 有效」係虛構值,已撤回);(3) `is_ascii.rs` 家族的 `black_box(&mut vec)` 攔不住迴圈摺疊,`case00_libcore` 的 n 次計時迭代被摺疊成 1 次(報 6.38 ns,真值 114.5 ns,18×)。

**優化方法**:第一步修 benchmark(切片值過 black_box、輸入運行時生成、去 to_vec);第二步纔是 128-bit bitset 查表或 SWAR 化謂詞本體。`<[u8]>::is_ascii` 本體已有 NEON 特化且貼近發射上限,僅剩「`umaxv` 歸約攤薄到每 256B」的 +30–40% 小頭寸。

**Benchmarks**(`library/coretests/benches/ascii.rs` + `ascii/is_ascii.rs`):`{short,medium,long}::is_ascii_*`(30 項)與 `is_ascii::{short,medium,long,unaligned_*}::case00–04`(50 項)——**現狀全部無效**。真值探針:`/tmp/btree_bench/probe_isascii.rs`、`probe_iterall.rs`。

---

## 四、LLVM 側修復點(影響 std 接口但改動在 LLVM)

總表;各項詳述見下。

| 修復點 | 影響接口 | 現象 | 收益 |
|---|---|---|---:|
| VPlan argmax 識別 `IVOp = IV increment` | `Iterator::max_by_key` 等 argmax 形態 | CGU/內聯上下文決定是否向量化(「codegen 彩票」) | 3.4× |
| AArch64 可預測性感知的 if-conversion | BinaryHeap、binary_search 及所有 `(cmp) as usize`/select 形狀 | 兩後端做出相反的靜態選擇,各錯一邊 | 1.5–4.4× |
| requiresScalarEpilogue 放寬 / predicated epilogue | 帶邊界檢查索引訪問的迴圈 | 長度整除 VF 仍強制整塊標量尾(2/3 時間) | ~2× |
| ~~iterator 結構體 SROA 提前到向量化前~~(撤回,見 L4) | `array_chunks` | 真因為 `while len-i>=N` 迴圈形態,std 側一行改寫即解(#7) | 3.06× |
| AArch64 interleave-group cost model(`ld4` + spill) | `str::chars().count()` 類 SWAR 計數迴圈 | 對稱 lane 被降成交錯 `ld4` + 每迭代 8 次棧溢出 | 3.1× |

### L1. VPlan:argmax 識別接受 `IVOp = IV increment`

**組件**:LoopVectorizer,`llvm/lib/Transforms/Vectorize/VPlanConstruction.cpp` 的 FindLastIV/min-max multi-use reduction 匹配器。限制已有樹內 TODO:

```cpp
// TODO: Support cases where IVOp is the IV increment.
if (!match(IVOp, m_TruncOrSelf(m_VPValue(IVOp))) ||
    !isa<VPWidenIntOrFpInductionRecipe>(IVOp))
  return false;
```

**根因**:匹配器要求 `select` 的候選索引是 induction **PHI**;若此前 pass 把候選規範化成 PHI 的**增量**(`iv + 1`)則識別失敗——儘管 SCEV 已證明 `%iv.next = {1,+,1}`。哪種形式活到向量化器取決於 CGU 劃分與內聯上下文,故同一份 Rust 源碼 CGU=16 向量化、CGU=1 標量(「codegen 彩票」)。最小 IR 三元組 A/B/C 已驗證(含 `lli` 對拍 last-wins 平局語義);對 A 加 `-force-vector-width=4` 也不行——是模式准入問題,不是 cost model。

**修法**:讓匹配器接受已識別 induction 的 increment(值為 `{start+step,+,step}`,向量 recipe 只需調整 splat 偏移);把 A/B/C IR 作為 regression test 落庫。

**已驗證收益**:spike-1638 輸入 1398 → 412 ns,random-100k 85.4 → 24.8 µs(**3.4×**)。

### L2. AArch64:可預測性感知的 branch-vs-select 決策

**組件**:AArch64 專用的 `select-optimize` pass(`lib/CodeGen/SelectOptimize.cpp`,由 `FeatureEnableSelectOptimize` 門控)的內層迴圈啟發式;`early-ifcvt`;`!unpredictable` metadata 處理。

**根因**:兩後端對同樣 IR 形狀做出**相反**的靜態選擇,各在資料分佈軸的一側犯錯:

- `child += (left <= right) as usize`(BinaryHeap):x86 降成 branchless `sbb`;AArch64 生成真分支 `b.hi`。已定位(第 3 節):中端 IR 是 branchless 的 `zext+add`,分支由 `select-optimize` 把它識別為 select-like 後依內層迴圈成本模型(固定 25% 誤預測率,`BranchCost=8.56 < SelectCost=15.0`)主動插入;關閉該 pass 即得 `cinc`。隨機堆上 ~50% 熵 → miss 9–21%,IPC 1.2–1.7。源碼層驗證(`select_unpredictable` → `csel`)收益 **-34%~-41%**,但其 `csel` 是 `early-ifcvt` 折回的結果,`select-optimize` 的迴圈路徑本身並不讀 `!unpredictable`。
- 鏡像案例(`manual_char_len` UTF-8 步進迴圈):AArch64 激進 if-convert 成 `csel` 鏈,把 100% 可預測的分支換成穿過載入的資料依賴——2 字節文本上比 x86 保留的分支形態**慢 4.4×**。

兩後端都不是全局正確;缺的輸入是**可預測性**。正確的成本模型:

```text
branch cost = predicted_cost + P(miss) × miss_penalty      // P(miss)→0 時近乎免費
select cost = csel 延遲 + (cmp → csel → address → load) 佔據關鍵路徑的代價
```

**修法方向**(互補):
1. `select-optimize` 的內層迴圈路徑(`findProfitableSIGroupsInnerLoops`)應與非迴圈路徑一樣尊重 `!unpredictable` metadata——現狀只有 `isConvertToBranchProfitableBase` 檢查,迴圈內的 `select_unpredictable` 仍被轉成分支,只是碰巧被 `early-ifcvt` 折回;同時**反方向**(標記可預測)沒有任何推力;
2. `MispredictDefaultRate` 不應是固定 25%:對 `zext(i1)` 餵 `add/or` 且結果進入地址鏈的 select-like 形狀,無 profile 時應按更高熵估算,或把「select-like 而非顯式 select」納入折扣;
3. 有 PGO/branch-probability 時,分支高度偏斜**且** select 會落在載入地址關鍵路徑上就拒絕 if-convert(`manual_char_len` 病理);
4. 無 profile 時,對不餵地址的旗標算術形狀(`(cmp) as usize` 加法,即 x86 `sbb/adc` 慣用法)傾向 if-convert。

**影響的 std 接口/benchmark**:`binary_heap::bench_{from_vec,find_smallest_1000,pop}`(branch→select 贏 34–41%)、`str::char_count::case03`(select→branch 贏 4.4×)、`slice::binary_search_*`(未知分佈下 select 正確,不得回退)。

### L3. LoopVectorizer:trip count 整除 VF 時去掉強制標量尾

**組件**:LoopVectorizer 的 `requiresScalarEpilogue`/epilogue 策略,AArch64 tail-folding 默認值。

**根因**:帶側出口(bounds-check panic)的迴圈需要精確標量尾;現行策略保留 `(n % VF == 0 ? VF : n % VF)` 個元素——**長度整除向量寬度時仍強制整塊 VF 走標量**。實測 `vec::bench_in_place_zip_iter_mut`(256B,VF=32):7 輪 NEON + **32 輪強制標量 + 每調用 alias/min guards = 2/3 總時間**,64% 樣本在標量尾。該結構在 IR 層定形,重定目標到 SSE2/AVX2 原樣保留——x86 付同樣的稅。

**修法方向**:
1. SCEV 證明 `n % VF == 0`(或發廉價運行時檢查)時整個跳過標量尾;
2. ISA 支持時優先 predicated/masked epilogue(SVE `whilelo`、AVX-512 masked)——`-prefer-predicate-over-epilogue` 機制存在但非 AArch64 默認,且 rustc 默認 generic CPU 根本不開 SVE。

**影響的 benchmark**:`vec::bench_in_place_zip_iter_mut`(~2× 空間)、`bench_in_place_zip_recycle`(同形狀)、一切帶索引側表訪問的 `iter_mut().enumerate()` 迴圈。

### L4. Pipeline:iterator 結構體 SROA 在向量化前完成——**2026-09-15 撤回**

**撤回原因**:本條根因判斷被 #7 的原型證偽。把 `ArrayChunks::fold` 的 `self.iter` 解構到局部變量(消除結構體字段訪問)後 98 ns 分毫不變;而保留字段訪問、只把 `while len - i >= N` 改成 `for c in 0..len / N` 計數迴圈即向量化到 32 ns。真因是 LoopVectorizer 對「無符號 `len - i >= N` 且 `i += N`」形態算不出 trip count,不是 SROA 時機。原「裸 slice 上同形狀向量化正常」的對照實驗有誤:該對照用的是 `as_chunks` 計數形態,並非同形狀。

**LLVM 側仍可考慮**:讓 SCEV/LoopVectorizer 識別 `while (len - i) >= N { i += N }` 為可計數迴圈(`i` 單調、`len - i` 每輪減 N,trip count = `(len - N) / N + 1`)——這是通用型 iterator 代碼常見形態。但 std 側的一行改寫已足夠,本條降為低優先。

**影響的 benchmark**:同 #7。

### L5. AArch64 cost model:對稱 lane 被選成 interleave group(`ld4` + spill)

**組件**:LoopVectorizer interleave-group 形成 + AArch64 TTI 成本;寬展開的暫存器壓力啓發式。

**根因**:`core::str::count::do_count_chars` 的 4-usize SWAR 計數迴圈被識別成 interleave group,降成 `ld4` 交錯載入——但四個 lane 計算完全對稱,解交錯是純浪費,且 `ld4` 在本核吞吐遠低於 `ldp`;同時 256B/迭代展開超出暫存器預算,熱迴圈內 8 次棧溢出往返(≈23% 樣本)。可移植源碼重構(獨立累加器等)復現同形狀——確認是 cost model,不是規範化問題。

**修法方向**:對成員 lane 使用對稱(無跨 lane 消費者)的 interleave group 加罰;AArch64 上按活躍區間壓力約束展開寬度。任一即可消除大部分差距;顯式 NEON 原型(`cmge` + `vsubq_u8` 字節累加)給出上限。

**已驗證收益**:`str::char_count::case00_libcore` huge 輸入 15.7–16.0 → 49.3–49.6 GB/s(**3.1×**);同類病理也殃及 `case01`(掩碼過早加寬到 64-bit lane,相關但獨立的 cost model 缺口,可在同一 pass 順帶審視)。

---

## 索引:接口 → benchmark 全表

| 接口 | benchmarks | 狀態 |
|---|---|---|
| `slice::rotate_*` | `slice::rotate_{tiny,medium,huge}_*`(20 項) | **已落地** |
| `char::to_{upper,lower}case` | `char::methods::bench_{non_ascii,ascii_mix,ascii}_char_to_{upper,lower}case`(6 項) | **已落地**(需移入 generator) |
| `BinaryHeap`(sift_down) | `binary_heap::bench_{from_vec,find_smallest_1000,pop}` | 原型驗證 |
| `str::chars().count()` | `str::char_count::case00_libcore::*`(20 項) | 原型驗證 |
| `Vec::dedup` | `vec::bench_dedup_{none,all,random,slice_truncate}_{100..100000}` | 原型驗證 |
| `flt2dec`(Dragon `format_exact`) | `num::flt2dec::strategy::{dragon,grisu}::bench_{small,big}_exact_{3,12,inf}` | **原型驗證**(big_exact_inf −69%,無回退) |
| `Iterator::array_chunks` | `iter::bench_next_chunk_trusted_random_access[_runtime_len]`(harness 測不到;探針 3.06×) | **原型驗證**(根因為迴圈形態,非字段訪問) |
| `BTreeMap::iter[_mut]` fold | `btree::map::iteration[_mut]_fold_{20,1000,100000}`(新增) | **原型驗證**(fold_1000 −43%,無回退) |
| `u8::is_ascii_*` / `[u8]::is_ascii` | `ascii::*::is_ascii_*` + `ascii::is_ascii::*`(80 項,**全部無效**) | 先修 bench(三層失效已定位) |
| `BTreeMap` 節點內搜索(整數鍵) | `btree::{map,set}::clone_*_and_remove_half`、`range_included_*`、`find_*`、`insert_*`;回退:`set::difference_*`、`intersection_*`、`range_included_unbounded` | **原型驗證**(remove_half −36%、range −48%;`difference_random` +89% 待修) |
| `BTreeMap::IntoIter` drop | `btree::{map,set}::clone_*`、`from_iter_seq_*`(基線端) | **原型驗證**(clone −57…−66%,無回退) |
