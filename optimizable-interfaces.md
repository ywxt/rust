# 可優化接口總結

從 `benchmarks-conclusion.md` 的全部分析中,只保留**存在可行優化**的接口。按驗證程度分三層:已落地並通過官方 harness、原型已實測驗證、候選方向(未原型化)。已確認無優化空間的接口(`binary_search`、`starts_with`、`Vec::push`、`HashMap::new`、`PeekMut::deref_mut`、`int_log`、`memcmp` 類、`<&mut [u8] as Write>::write`——其 `bench_write_slice` 的 −25% 為 harness `black_box(&wr)` 形態特有,真實序列化形態 +4–7% 回退;`Vec` in-place collect——`bench_in_place_xxu8_*` 一半以上是 glibc malloc/calloc/memset,迴圈已在 NEON 吞吐,`_i0` 慢 83% 是 calloc 繞過 tcache,`u128_0100_i0` 同理 53% 在 `_int_malloc`、迴圈 0.31 ns/元素為 store 吞吐;`VecDeque::extend(&[T])`——`bench_extend_bytes` 77% 是 512 B memcpy,簿記僅 2 ns;`<dyn Any>::downcast_ref`——3.2 ns 即一次不可去虛化 vtable 調用 + 128-bit 比較,比較僅 0.02 ns,唯一 0.2 ns 頭寸在 `TypeId` 陣列佈局的 AArch64 sret 回傳,屬編譯器側;`FilterMap::next_chunk`——已是無分支壓縮迴圈,2.4 cycles/元素,距只掃描地板 ≤10%,`Filter::next_chunk` 同形,慢 17% 是 `&T` 元素 8 B 存儲固有;`HashSet::difference` / `symmetric_difference`——前者 91 ns 即 10 次 contains,SipHash 5.9 + probe 3.7 ns/次;後者 892 ns 因需雙向掃描,查找次數為 `|A|+|B|`(110 次)而非 10,皆為 HashDoS 防護 + 語義所必需,`FxHash` 一行 −65%;`format!` 短整數輸出——`write_u*_{min,max}` 六項落 51–63 ns,其中 ~73% 是 `String` 從空容量起步的分配鏈(`malloc`/`finish_grow`/`free`),其餘是 fmt 調度與轉換(同值不同型別差 ≤0.8 ns、1–3 位之間差 ≤0.6 ns,見 `benchmarks-conclusion.md` 的 `write_u8_max` 章);AArch64 前端停頓受佈局影響可差 4–5×(舊 libstd 上 `u64::MAX` 44.8 ns 屬此,現版四個 libstd 上兩型別同為 ~52 ns);`estimated_capacity()=8` 因差距消失而作廢;`BTreeMap::from_iter`——`from_iter_rand_10_000` 的 65% 是通用 driftsort(13.8 ns/元素,比較排序正常水準),`bulk_push` 5.7 ns/元素,比逐個 insert 快 3.3×;`Enumerate`/`Map`/`sum` 鏈——`bench_enumerate_ref_sum` 的計數器已融進歸納變量,7 條/元素中 35% 是 `black_box` 棧往返,ref ≡ value;`uN::deposit_bits`/`extract_bits` 常量掩碼——`prepare()` 已常量摺疊,28 條 NEON/16 元素達吞吐上限,22% 頭寸需掩碼結構特化;x86 BMI2 `pdep`/SVE2 `BDEP` 未用是平臺側線索;`str::char_indices().count()` forward——即 SWAR `count_chars`,11 ns 無事,其 `_rev` 病灶在 `Rev::count`,見 §13;`[u8]::make_ascii_uppercase`——`ascii::*::case06_libcore` 已自動向量化到 0.029 ns/B,同組 `case07/08_fake_simd` 是 bench 內錯誤(FIXME 進位 bug)且慢 57% 的手寫對照,非 std 接口;medium/short 檔 76–98% 是 `to_vec`;`[u8]::cmp` → `memcmp`——`sort_unstable_large_strings` 64% 在 memcmp 入口分派、平均看 1 字節即分勝負,但 8 種內聯前綴比較器在 6 種輸入分佈上各有 5–44% 回退,memcmp 是穩健折中;`<[T]>::to_vec`——`bench_from_slice_0100` 的 27 ns = malloc/free 12 + memcpy 12 + 簿記 2.6,`Copy` 特化已是一次分配一次拷貝;`VecDeque::Iter::try_fold`——`bench_try_fold` 的 `Some(a+b)` 永不短路,已摺成 4 累加器 NEON 歸約 0.046 ns/元素,與 `sum` 同碼)不在此列。

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

### 12. `VecDeque::iter` / `iter_mut` 的 `for` 迴圈(`next()` 內聯 swap 的暫存器輪轉)——樹內原型已驗證

**接口**:`library/alloc/src/collections/vec_deque/{iter,iter_mut}.rs` 的 `Iter::next`/`next_back`(`for x in &deque`、`while let Some = it.next()`、所有經 `next()` 的 adapter 鏈全部經此;`fold`/`sum`/`try_fold` 有覆寫不受影響)。

**慢的原因**:`next()` 在 `i1` 耗盡時 `mem::swap(i1, i2)` 再取——內聯進 `for` 後,LLVM 把兩個 `slice::Iter` 的 4 個字全 SROA 進暫存器,迴圈頭 phi 要合併「未 swap/已 swap」兩條入邊,這是暫存器**置換**,regalloc 只能在回邊插拷貝:熱迴圈 10 條指令裡 **6 條是 `mov`**,每元素 2.0 cycles(IPC 4.96、branch-miss 0.1%,純指令數)。同一 deque 的 `iter().sum()` 走 `fold` 覆寫只要 48 ns——`for` 比它慢 14×。`Chain<slice::Iter, slice::Iter>` 的 `for` 同病(683 ns)。

**優化方法**(樹內原型):把 None 臂外聯成 `#[cold] #[inline(never)] fn next_slow()`,迴圈體內只剩 `i1` 的 `ptr/end` 活躍,回邊無拷貝;`next_back` 對稱。語義、佈局、API 零改動。

**原型核心**(`iter.rs` / `iter_mut.rs`):

```rust
fn next(&mut self) -> Option<&'a T> {
    match self.i1.next() { Some(v) => Some(v), None => self.next_slow() }
}
#[cold] #[inline(never)]
fn next_slow(&mut self) -> Option<&'a T> { mem::swap(&mut self.i1, &mut self.i2); self.i1.next() }
```

**Benchmarks**(`library/alloctests/benches/vec_deque.rs`,3 次交錯;vec_deque 測試 187 項全過):

| benchmark | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| `bench_iter_1000` | 696 ns | **479–484 ns** | **−31%**(指令 4.62G→3.29G,熱迴圈 10→5 條) |
| `bench_mut_iter_1000` | 696 ns | **481 ns** | **−31%** |
| 探針 `.rev()` 連續/繞回 | 894 / 907 ns | ~560 級 | ≈ −37% |
| `bench_try_fold` | 64–77 ns | 45–52 ns | 噪聲(`try_fold` 不經 `next`) |
| `bench_into_iter*`(4 項) | — | 同補丁兩次構建 −40%…+4% | **純佈局噪聲**,不可作守衛 |
| 其餘 `vec_deque::*`(11 項) | — | ±1% | 持平 |

**後續候選**:第二段改成 `Option<&[T]>` + 迴圈形 `next`(探針 357–478 ns,再 −25…−35%),但要重寫 `Iter` 全部方法與 `as_slices` 語義。`for` 到不了 `sum()` 的 48 ns——雙段狀態機無法向量化,要快就用 `fold`/`sum`/`as_slices`。x86 同機理(IR 層 phi 置換),未實測。

### 13. `Rev<I>::count`(缺 forward `count` 轉發)——樹內原型已驗證

**接口**:`library/core/src/iter/adapters/rev.rs` 的 `impl Iterator for Rev<I>`——所有 `.rev().count()`,尤以 `str::Chars`/`CharIndices`(SWAR forward `count`)受益。

**慢的原因**:`Rev` 覆寫了 `advance_by→advance_back_by`、`nth→nth_back`、`fold→rfold`,唯獨沒覆寫 `count`;默認 `count` 經 `fold`→`rfold` 逐元素反向走,`Chars` 的反向解碼每字符 ~8 條 + 難預測分支,而 forward `count_chars` 是 0.23 ns/B 的 SWAR。`count()` 結果與方向無關。

**優化方法**(樹內原型):`fn count(self) -> usize { self.iter.count() }`。**落地須改為內部特化 trait**:blanket 轉發會把 `Rev<Map<..>>` 中閉包副作用的順序從反向變 forward(`count` 文檔為反覆 `next`);對 `Chars`/`CharIndices`/`Bytes`/`slice::Iter` 等純源特化即可,語義零改動。

**原型核心**:

```rust
// rev.rs — 原型(blanket);落地改為 SpecRevCount: default → rfold 計數,純源 → self.iter.count()
#[inline]
fn count(self) -> usize { self.iter.count() }
```

**Benchmarks**(`library/alloctests/benches/str.rs`;coretests rev/iter 357 項 + alloctests 113 項全過):

| benchmark | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| `str::char_indicesator_rev` | 34.9 ns | **11.2 ns** | **−68%** |
| `str::char_iterator_rev` | 48.0 ns | **11.5 ns** | **−76%** |
| 探針 `chars().rev().count()` 4 KB | 2165 ns | 239 ns | **9.1×**(= forward) |
| `str::char_indicesator` / 其餘 5 項 | 11.3 | 11.4 | 持平 |

### 16. `from_str_radix(_, 10)` 的逐位串行乘加鏈(8 位 SWAR 快路徑)——樹內原型已驗證

**接口**:`library/core/src/num/mod.rs::from_ascii_bytes_radix_impl`(`str::parse::<{u32,u64,i32,i64}>()`、`from_str_radix(_, 10)`)。

**慢的原因**:每位一次 `result = result * 10 + digit`,`mul` 3–4 cycles 的串行依賴鏈——每位 ~1.3 ns,19 位串 25.5 ns;perf 30% 在 `mul`。

**優化方法**(樹內原型):`radix == 10`、32/64 位、≤19 位時,8 位一組用 SWAR 一次驗證 + 三次乘法合併,不需逐位溢出檢查(≤19 位不可能溢出 u64),最後一次 MAX 比較;>19 位沿用 checked 迴圈。

**原型核心**:

```rust
fn parse_8_decimal_digits(chunk: u64) -> Option<u64> {
    let v = chunk.wrapping_sub(0x3030_3030_3030_3030);
    if (v | v.wrapping_add(0x7676_7676_7676_7676)) & 0x8080_8080_8080_8080 != 0 { return None; }
    let v = (v * (1 + (10 << 8)) >> 8) & 0x00FF_00FF_00FF_00FF;
    let v = (v * (1 + (100 << 16)) >> 16) & 0x0000_FFFF_0000_FFFF;
    Some(v * (1 + (10000 << 32)) >> 32)
}
```

**Benchmarks**(12 032 用例與現版逐一相等;coretests num/parse 1697 項 + alloctests 34 項全過):

| 輸入(u64,radix 10) | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| 9 位 `987245987` | 8.9 ns | **3.1** | **−65%** |
| 16 位 | 16.6 | **4.2** | **−75%** |
| 20 位 `u64::MAX`(走原路徑) | 26.5 | 11.3–31.9 | 視佈局 |
| 2 位 / 5 位 / 非法 `abc` | 2.5 / 5.0 / 1.6 | 2.2 / 4.0 / 1.3 | −11% / −21% / −18% |
| 官方 `bench_u64/u32_from_str_radix_10`(平均 2.8 位混合) | 26.2 / 24.1 µs | 21.5 / 22.0 | −18% / −9% |
| 官方未經快路徑的 33 項 | — | −27…+7% | **佈局噪聲**(內聯決策改變) |

**落地待辦**:8/16 位類型的路徑(現排除)、`u128/i128` 累加、`const fn` 下 `from_le_bytes` 的 CTFE 路徑;官方 bench 的 19 串混合平均僅 2.8 位,需加長串輸入才能守護。x86 SWAR 同構。

---

### 17. `escape_debug_ext` 的 BMP 可打印塊位圖(每個非 ASCII 字符省 4 次稀疏表查找)——樹內原型已驗證

**接口**:`library/core/src/char/methods.rs::escape_debug_ext`——`Debug for str`、`Debug for char`、`str::escape_debug()`、`char::escape_debug()` 全部經此;影響所有 `{:?}` 格式化非 ASCII 文本的路徑。

**慢的原因**:一個非 BMP-ASCII 字符要付 4 次稀疏表(`skip_search`:二分 + 前綴和掃描)——`grapheme_extend`(383 段)、`default_ignorable`(17)、`cf`(21)、`cn_planes_0_3`(730)。`str::debug::mostly_unicode` 的樣本 **85%** 落在此四者,單字符 `escape_debug().len()` **51.2 ns**。

**優化方法**(樹內原型):128 B 的 `[u64; 16]` 位圖,每位表示一個 64 碼點 BMP 塊「全體可打印」(按最嚴參數 `escape_grapheme_extender: true` 計算,故對 `false` 亦有效)。命中即短路全部四個查找;`impl Debug for str` 另加同一位測試以跳過整個 `EscapeDebug` 構造。

**原型核心**:

```rust
#[inline]
pub(crate) fn is_printable_block(self) -> bool {
    let u = self as u32;
    u <= 0xFFFF && PRINTABLE_BLOCKS_BMP[(u >> 12) as usize] >> ((u >> 6) & 63) & 1 != 0
}
```

**Benchmarks**(潔淨協議:單 bench/進程、`--test-threads=1`、3 次中位數;`A` = 位圖臂,`B` = `Debug for str` 跳過):

| benchmark | 基線 | A | A+B |
|---|---:|---:|---:|
| `str::debug::mostly_unicode` | 1806 ns | 326(−82%) | **242(−87%)** |
| `str::debug::mixed` | 1415 | 457(−68%) | 401(−72%) |
| `str::debug::some_unicode` | 293 | 200(−32%) | 189(−36%) |
| `fmt::write_str_macro_debug` | 82.0 µs | 23.9(−71%) | **20.8(−75%)** |
| `fmt::write_vec_macro_debug` | 87.9 µs | 28.1(−68%) | 24.9(−72%) |
| `str::debug::ascii_only` / `ascii_escapes` | 186 / 300 | 持平 | 持平 |

單字符:`escape_debug().len()` 51.2 → **2.09 ns**(Cyrillic)、`format!("{:?}", c)` 92.6 → 34.2、整串 `format!` 1737 → **209 ns**。遍歷式驗證 BMP 全部 63 360 非 ASCII 純量、三種參數組合,誤判 0;覆蓋 74.7%(CJK/Hangul 100%、Cyrillic 77%、Devanagari 0%)。

**回退面**:ASCII 路徑不動(該臂在 ASCII 之後);`char::methods::{to_ascii_uppercase,ascii_char_to_uppercase,to_digit_radix_36}` 表面 −56%/−15%/−31% 是**代碼佈局偽影**(三者不經此函數;常量入樹而臂不入的 `core_inert` 構建重現基線),報告時單列不計收益。

**落地待辦**:位圖必須改由 `src/tools/unicode-table-generator` 生成(先例:`Cn_Planes_0_3` 在 `load_data()` 內合成並帶斷言同步),插入點 `main.rs:347` 或 `emit_bitset` 旁新增發射器;並生成相應的斷言測試。

### 18. `isqrt` 末端除法窄化(`numerator / (2s)` → `(numerator >> 1) / s`)——樹內原型已驗證

**接口**:`library/core/src/num/imp/int_sqrt.rs::last_stage!`(`u128::isqrt()`、`NonZeroU128::isqrt()`)。

**慢的原因**:Karatsuba 末端 `q = numerator / (s << 1)`,其中 `numerator < 2^65`(由 `middle_stage!` 的 `r < 2s < 2^33` 決定)——65/33 的除法超出硬體 `udiv` 寬度,落到 `compiler_builtins::int::specialized_div_rem::u128_div_rem`。`perf` 對 `u128_sqrt_uniform` 取樣:**87%** 在此長除法。

**優化方法**(樹內原型):嵌套除法恆等式 `floor(floor(a/2)/b) == floor(a/(2b))`,折半後 `numerator >> 1 < 2^64`,落進一次原生 `udiv`。**只在 u128 開**,u16/u32/u64 的 numerator 本已 ≤ 型別寬度(對稱改寫會令 u16/u32 回退 3–5%)。

**原型核心**:

```rust
// last_stage! 末端;u128 傳 $narrow = true、$div_ty = u64
let q = if $narrow {
    let q = ((numerator >> 1) as $div_ty) / ($s as $div_ty);
    q as $ty
} else {
    numerator / (($s as $ty) << 1)
};
```

**Benchmarks**(交替 A/B,單 bench/進程、`--test-threads=1`、5 次中位數):

| benchmark | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| `u128_sqrt_uniform` | 7937 ns | 5818 | **−26.7%** |
| `u128_sqrt_predictable` | 30879 | 25074 | **−18.8%** |
| `u128_sqrt_random` | 4727 | 3855 | **−18.4%** |
| u16/u32/u64/u8 共 16 檔 | — | — | ±0.2% |
| 對照(`int_log`/`int_bits`/`int_pow` 各 3 項) | — | — | ±0.1% |

單次末端除法:11.117 → **4.617 ns**(2.4×)。正確性:21M+ 輸入對照未修改公式 0 不符;50.3M 輸入的不變量掃描 `numerator ≥ 2^65` 0 次;`./x test library/core --test-args isqrt` 通過。

**否決項**:`u64::isqrt` 的 f64 播種(`(x as f64).sqrt() as u64` 精確到 ±1,9.72 → **2.62 ns**,3.7×)因 `isqrt` 是 `const fn` 而 `intrinsics::sqrtf64` 非 const 而**不可用**——`error: cannot call non-const intrinsic sqrtf64 in constant functions`。


### 19. `Filter`/`FilterMap::next_chunk` 壓縮迴圈(無條件 store → 條件式)——樹內原型已驗證

**接口**:`library/core/src/iter/adapters/filter.rs::next_chunk_dropless`、`library/core/src/iter/adapters/filter_map.rs::FilterMap::next_chunk`(`Iterator::next_chunk` 在這兩個適配器上的覆寫)。

**慢的原因**:內層迴圈刻意無分支——索引以 `cinc`/`csinc` 前進,**每個被掃過的元素都無條件 store 一次**,即使被謂詞濾掉。當命中稀疏時(只要 32 個結果卻掃 933 個元素),多寫 901 次、多走 29× 的 store;且 store 位址依賴迴圈攜帶的 `idx += pred` 鏈。

**優化方法**(樹內原型):把 store 移進 `if pred { ... }` 內,索引僅在命中時前進。語義等價(差分測試 1194 組 0 不符、panic 安全已驗)。

**原型核心**:

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

**Benchmarks**(交錯 A/B,單 bench/進程、`--test-threads=1`、5–8 次中位數):

| benchmark | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| `filter_map_mostly_false` | 601 ns | 355 | **−41.0%** |
| `filter_mostly_false` | 640 | 398 | **−37.8%** |
| `filter_map_shuffled_12pct`(新增) | 199 | 131 | **−34.3%** |
| `filter_shuffled_12pct`(新增) | 194 | 158 | **−18.9%** |
| `filter_even` | 61.6 | 52.2 | **−15.3%** |
| `filter_shuffled_50pct`(新增) | 68.8 | 62.3 | −9.5% |
| `filter_predictably_true` | 34.3 | 31.4 | −8.5% |
| `filter_map_even` | 49.1 | 50.7 | **+3.3%** |
| `filter_map_predictably_true` | 28.3 | 28.6 | +1.0% |
| `copied` / TRA×2(對照) | — | — | ±0.1% |

**歸因**:拆檔 A/B 呈乾淨 2×2 塊狀(打 `filter.rs` 只動 `filter::*`,反之亦然),排除全域佈局偽影。**新增 3 項洗牌 bench** 覆蓋原註解聲稱有利的「分支不可預測」情形——原型在該情形同樣勝出,故原註解立論未被實測支持。

**混合形態否決**:保留無分支索引、只條件化 store 的版本更慢(`filter_map_even` 49.1 → 72.8)。

**待決**:`filter_map_even` +3.3% 與 `filter_map_predictably_true` +1.0% 兩項小幅回退(謂詞便宜且命中率 50% 的角落);同形態的 `filter_even` 反為 −15.3%。

### 20. `[T]::cmp` / `partial_cmp` / `<`(`SliceOrd`/`SliceChain` 寬整數特化)——SVE 原型已驗證

**接口**:`library/core/src/slice/cmp.rs` 的 `SliceOrd::compare`、`SlicePartialOrd::partial_compare`、`SliceChain::chaining_{lt,le,gt,ge}`;經 `impl Ord/PartialOrd for [T]`、`<[T]>::binary_search` 的比較、`BTreeMap<Vec<u32>,_>` 鍵查找到達。

**慢的原因**:掛點**已存在**且已分派——`UnsignedBytewiseOrd` 只覆蓋 `u8`/`bool`/`NonZero<u8>`/`Option<NonZero<u8>>`/`ascii::Char`,這些走 `compare_bytes`(memcmp);`u16` 及以上的整數與 `char` 不滿足「字節序等價」條件,落回 `chaining_impl` 的逐元素早退迴圈(`ldr/ldr/cmp/b.ne`),0.36 ns/元素。含早退的迴圈 LLVM 無法向量化。

**優化方法**:SVE 一次比較 VL/4 個 lane 的 `cmpne`,命中時 `brkb`+`cntp` 取**最低不相等 lane** 的精確索引,再在該 lane 做一次標量比較得出 `Ordering`/布爾結果;尾塊由 `whilelo` 自動遮罩,無標量尾迴圈。語義關鍵:SVE 的 `cmpne` 與元素寬度無關地給出「不等」遮罩,故 `u16`/`u32`/`u64`/`u128` 共用同一 kernel 結構,只需按元素寬度換 `ld1w`/`ld1d` 與 lane 計數。掛點復用 `AlwaysApplicableOrd`(其已列出全部原生整數),或新增內部 trait 限定在無 `Ord` 副作用的原生型別。

**原型核心**:

```rust
// 找首個不相等 lane;命中則 brkb+cntp 取索引,再標量定序
"whilelo p0.s, {i}, {n}",
"2:",
"ld1w {{z0.s}}, p0/z, [{a}, {i}, lsl #2]",
"ld1w {{z1.s}}, p0/z, [{b}, {i}, lsl #2]",
"cmpne p1.s, p0/z, z0.s, z1.s",
"b.any 4f",
"incw {i}", "whilelo p0.s, {i}, {n}", "b.any 2b",
"4:", "brkb p1.s, p0/z, p1.s", "cntp {off}, p0, p1.s", "add {i}, {i}, {off}",
```

**Benchmarks**(兩切片等長且**完全相等**,即必須掃到底的最壞情形;綁核,ns/元素,4 次取 best):

| n | std(`[T]::cmp`) | chunk16(NEON 自動向量化) | SVE | SVE vs std |
|---|---:|---:|---:|---:|
| 64 | 0.37 | 0.12 | **0.10** | **3.7×** |
| 1 000 | 0.36 | 0.12 | **0.10** | 3.6× |
| 10 000 | 0.36 | 0.13 | **0.11** | 3.3× |
| 100 000 | 0.38 | 0.16 | **0.15** | 2.5× |

非最壞情形(第 0 個元素即不等,延遲地板):n=1000 時 std 1.4 ns、chunk16 **2.9 ns**、SVE **1.5 ns**——chunk 版在「首塊即命中」時多付整塊比較,SVE 第一輪就是 masked,無此回退,故無需 hybrid 起步。

**回退面**:無實測回退;語義上唯一風險是 `Ord` 有可觀察副作用的自訂型別(故特化必須限定原生整數/`char`,不能 blanket)。

**落地待辦**:`u128` 的 `cmpne` 需 lane 寬度 128(或兩次 `ld1d` 拼接);`char` 需先證 `0x110000` 以下值域的 `Ord` 與無號整數序一致(成立)。x86 對照:同形狀是 `pcmpeqd`+`pmovmskb`+`tzcnt`,結構同構,未實測。

---

### 21. 浮點切片相等 `[f32]`/`[f64] ==`(`SlicePartialEq` 特化)——SVE 原型已驗證

**接口**:`library/core/src/slice/cmp.rs` 的 `SlicePartialEq::equal_same_length`;`[f32]==[f32]`、`[f64]==[f64]`,以及對浮點切片的 `starts_with`/`ends_with`/`[T]::eq`。

**慢的原因**:浮點**不是** `BytewiseEq`(`NaN != NaN`、`-0.0 == +0.0`、信號 NaN 的 quiet 位不參與比較),故 `BytewiseEq` 的 `compare_bytes` 特化不適用,落回逐元素 `fcmp`+`cset` 早退迴圈,0.67 ns/元素——比整數切片比較更慢(每元素多一條 `fcmp` 到 `cset` 的延遲)。

**優化方法**:SVE `fcmne` **就是** IEEE `!=` 語義(NaN 比較結果為真、`-0.0` 與 `+0.0` 相等),故遮罩語義天然正確,不需任何特殊處理。命中後同樣以 `brkb`+`cntp` 取索引(此處只需「有無不相等」,索引用於早退;相等情形走滿)。掛點在 `SlicePartialEq` 增一個 `f32`/`f64` 專用 impl(浮點與整數的 `PartialEq` 語義不同,必須分開)。

**原型核心**:

```rust
"whilelo p0.s, {i}, {n}",
"2:",
"ld1w {{z0.s}}, p0/z, [{a}, {i}, lsl #2]",
"ld1w {{z1.s}}, p0/z, [{b}, {i}, lsl #2]",
"fcmne p1.s, p0/z, z0.s, z1.s",   // IEEE !=:NaN 為真、±0 相等
"ptest p0, p1.b",                 // 關鍵:fcm* 不設 NZCV,b.any 前必須補 ptest
"b.any 4f",
"incw {i}", "whilelo p0.s, {i}, {n}", "b.any 2b",
```

**Benchmarks**(等長且完全相等的 `[f32]`,ns/元素):

| n | std | chunk16(NEON) | SVE | SVE vs std |
|---|---:|---:|---:|---:|
| 64 | 0.66 | 0.12 | **0.11** | **6.0×** |
| 1 000 | 0.67 | 0.13 | **0.11** | 6.1× |
| 10 000 | 0.66 | 0.14 | **0.12** | 5.5× |
| 100 000 | 0.68 | 0.16 | **0.15** | 4.5× |

**正確性**:fuzz 覆蓋 NaN、`-0.0`/`+0.0`、含 NaN 的等長與不等長輸入,與 std 逐一相符。

**落地待辦**:`f16`/`bf16` 若日後進入 `PartialEq` 可同構擴展;`f64` 用 `ld1d`/`fcmne p1.d`。**踩坑記錄**:整數的 `cmpne` 會設定 NZCV 供 `b.any` 讀取,但浮點的 `fcm*` **不設定**——`b.any` 前必須補 `ptest`,否則分支恆不採用(本輪原型第一版即因此驗證失敗)。

---

### 22. `VecDeque::retain` / `retain_mut`(SVE `COMPACT`)——原型已驗證

**接口**:`library/alloc/src/collections/vec_deque/mod.rs` 的 `retain`/`retain_mut`。

**慢的原因**:三段式——stage 1 逐元素探測、stage 2 對每個保留元素 `self.swap(idx, cur)`、stage 3 `truncate`。每元素付兩次 ring 索引(`self[cur]` 與 `swap` 各一次 wrap 取模)加一次 `if keep` 分支失誤。與 `Vec::retain` 同病,但更重:**比 `Vec::retain` 的標量版還慢**(n=100 000 時 451 µs vs 348 µs)。

**優化方法**:沿用 `sve_retain.rs` 的兩階段模板——Phase A 標量按序呼叫謂詞只寫 bool mask(保 exactly-once/in-order 契約),Phase B 用 `COMPACT` 整向量搬移。與 `Vec::retain` 的**唯一區別**是 ring 佈局,需兩處新邏輯:(1) 按**物理段**切 chunk(`min(CHUNK, 剩餘長度, 到緩衝區尾端的距離)`),使每輪讀寫都不跨越 wrap;(2) 寫游標的物理位置若在讀之前(或本輪會繞過尾端)則先 compact 到 64 元素的棧上 scratch,再分兩段 `copy_nonoverlapping` 貼回 ring。panic guard 沿用同構設計。

**原型核心**:

```rust
// 每輪:取一段不跨 wrap 的來源
let phys = wrap(head + read);
let n = CHUNK.min(len - read).min(cap - phys);
for i in 0..n { mask[i] = f(&mut *base.add(phys + i)); }
let wphys = wrap(head + write);
let kept = if wphys + n <= cap && wphys <= phys {
    compact32(base.add(phys), base.add(wphys), mask.as_ptr(), n)   // 原地
} else {
    let k = compact32(base.add(phys), scratch.as_mut_ptr(), mask.as_ptr(), n);
    let first = k.min(cap - wphys);                                 // 跨 wrap:兩段貼回
    copy_nonoverlapping(scratch.as_ptr(), base.add(wphys), first);
    copy_nonoverlapping(scratch.as_ptr().add(first), base, k - first);
    k
};
write += kept; read += n;
```

**Benchmarks**(u32、`x & 1 == 0`、扣除輸入重建開銷、綁核):

| n | std | SVE(連續) | SVE(wrap 於 1/3 處) | SVE vs std |
|---|---:|---:|---:|---:|
| 64 | 60 ns | **27 ns** | 42 ns | **2.20×** / 1.43× |
| 1 000 | 906 ns | **442 ns** | 463 ns | **2.05×** / 1.96× |
| 100 000 | 451 µs | **43.3 µs** | 45.6 µs | **10.43×** / 9.91× |

**正確性**:差分 fuzz 覆蓋長度 0–400 × 容量餘量 × wrap 位置(0/1/37/130),與 `VecDeque::retain` 逐一相符、元素順序與內容全等。

**回退面**:低於門檻需沿用 `sve_retain.rs` 的分寬度門檻(`MIN_SVE_SIZE_*`)回標量;wrap 形態每輪多一次物理段計算,大尺寸下與連續形態相差 ~5%。

**落地待辦**:與 `sve_retain.rs` 同一構建前提(`+sve` 靜態構建或 runtime dispatch);panic guard 需按 ring 佈局重寫「未決尾巴拷回」;`VecDeque::extract_if` 同構(同 mask 正反各 compact 一次),可一併做。

---

### 23. `Vec::extract_if(..)` 被完整消耗(SVE 雙向壓縮)——原型已驗證

**接口**:`library/alloc/src/vec/extract_if.rs` 的 `ExtractIf::next`;受益形態是 `extract_if(.., pred).collect::<Vec<_>>()`、`extend(...)`、`for` 全消耗。

**慢的原因**:`next()` 逐元素 `pred` 判定,命中則 `ptr::read` 取出、未命中且已有洞則 `copy_nonoverlapping` 補洞——每元素一次 `ptr::copy` 分支加一次 `del > 0` 檢查,且 `Vec::with_capacity` 的目標仍需逐元素 push。

**優化方法**:同一份 bool mask 正反各 compact 一次——保留者留原地(`COMPACT` 到寫游標),移除者 `COMPACT` 到新 `Vec` 的尾端。掛點是 `Vec: Extend<T>`/`SpecFromIter` 對 `ExtractIf` 的特化,或 `ExtractIf` 自身的批量 `next` 輔助。**語義限制**:`pred` 呼叫時序會由「每 `next()` 一次」變為「每 chunk 一次(64 次一組)」,對可觀察時序的謂詞有差異,落地前需確認文檔是否允許。

**Benchmarks**(u32、`x % 3 == 0`、扣除輸入重建、綁核):

| n | `collect()` | `into with_capacity` | SVE | vs prealloc | vs collect |
|---|---:|---:|---:|---:|---:|
| 64 | 158 ns | 67 ns | **56 ns** | 1.20× | **2.8×** |
| 1 000 | 1 268 ns | 812 ns | **736 ns** | 1.10× | 1.72× |
| 100 000 | 383 µs | 365 µs | **71.2 µs** | **5.13×** | **5.38×** |

**回退面**:小尺寸收益小(1.1–1.2×,因為 Phase A 的謂詞呼叫與配置/釋放成本主導);必須與 `with_capacity` 版而非僅 `collect()` 版比較,否則會把目標 Vec 的擴容成本誤記為收益。

---

### 24. `chunk_by()` / run-length 計數(`cmpne`+`cntp`)——SVE 原型已驗證

**接口**:`<[T]>::chunk_by` 的 `count()` 形態(等價於相鄰 run 數 `1 + Σ[v[i] != v[i+1]]`);亦覆蓋「相鄰不等判定」的整段掃描。

**慢的原因**:`ChunkBy` 是通用迭代器,`count()` 逐元素走狀態機。`chunk_by(|a,b| a==b).count()` 是本輪新測的形態(與 §5 `dedup` 的 prescan 同族但返回計數而非索引)。

**優化方法**:`cmpne` 產生「相鄰不等」遮罩,`cntp` 累加;`whilelo` 自動遮罩尾塊。載入 `v[i..]` 與 `v[i+1..]` 兩個向量做 `cmpne` 即可,無需 shift。

**原型核心**:

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

**Benchmarks**(u32、值域 8、ns;std = `chunk_by(|a,b| a==b).count()`):

| n | std | SVE | 變化 |
|---|---:|---:|---:|
| 16 | 7.2 | **2.7** | **2.69×** |
| 64 | 24.3 | **9.4** | 2.57× |
| 256 | 92.9 | **35.7** | 2.60× |
| 4 096 | 1 471 | **591** | 2.49× |
| 65 536 | 23 699 | **10 614** | 2.23× |

**回退面**:無(16 起即勝)。差分 fuzz 覆蓋 0–400 全長與多種 run 分佈,與 `chunk_by().count()` 相符。

---

### 25. ASCII 封閉類別計數(`filter(pred).count()` 形態,`cmphs`/`cmpls`+`cntp`)——SVE 原型已驗證

**接口**:`<[u8]>::is_ascii_digit`/`is_ascii_whitespace`/`is_ascii_alphanumeric` 等封閉謂詞的**批量計數**形態(`v.iter().filter(|b| b.is_ascii_digit()).count()`);std 無對應的專用 API,故落地形態是新增切片輔助或對既有計數路徑特化。

**慢的原因**:逐字節 `filter().count()`,每元素一次比較 + 分支。**與 §9 的區別**:§9 處理的是 `iter().all()` 的**早退**形態(且其 benchmark 有三層失效);本條是**無早退的計數**形態,本就是向量化的理想形狀,不需修 bench 即測得到真值。

**優化方法**:封閉類別用兩條範圍比較 `cmphs`(>= 下界)+ `cmpls`(<= 上界),`and` 後 `cntp` 累加。空白(5 個離散值)則用 `cmpeq` 五次並以 `orr` 合併——**關鍵**:`orr p1.b, p0/z, p1.b, p2.b` 的 governing predicate 必須是**迴圈謂詞 `p0`**,若誤寫成累加目標 `p1`,則 `/z` 會把新匹配的 lane 全部清零(本輪原型第一版即因此全盤錯誤)。

**原型核心**:

```rust
"mov z1.b, #48", "cmphs p1.b, p0/z, z0.b, z1.b",   // >= '0'
"mov z1.b, #57", "cmpls p2.b, p0/z, z0.b, z1.b",   // <= '9'
"and p1.b, p0/z, p1.b, p2.b",
"cntp {k}, p0, p1.b", "add {t}, {t}, {k}",
```

**Benchmarks**(ns;std = `filter().count()`,輸入為全數字/含 1/3 空白):

| n | 數字計數 std | 數字計數 SVE | 變化 | 空白計數 std | 空白計數 SVE | 變化 |
|---|---:|---:|---:|---:|---:|---:|
| 8 | 4.4 | **1.7** | 2.60× | — | — | — |
| 16 | 7.1 | **1.7** | 4.20× | 6.8 | **3.5** | 1.92× |
| 24 | 10.1 | **1.7** | **6.00×** | — | — | — |
| 64 | — | — | — | 21.9 | **6.4** | **3.42×** |
| 96 | 31.6 | **4.3** | **7.31×** | — | — | — |
| 256 | 65.8 | **12.8** | 5.15× | 76.3 | **28.2** | 2.70× |
| 4 096 | 987 | **199** | 4.95× | 1 152 | **444** | 2.59× |
| 65 536 | 16 050 | **3 199** | 5.02× | 18 374 | **7 222** | 2.54× |

**回退面**:無(8 起即勝);離散值類別(空白)因需 4–5 次 `cmpeq` 才合併,收益(1.9–3.4×)低於範圍類別(4.2–7.3×)。

**落地待辦**:std 目前無「計數封閉類別」的公開接口,最小落地面是把 `[u8]` 的內部計數輔助特化,或先以閉合 API(如 `count_ascii_digits`)形式提案;`filter()` 的閉包形態無法在 std 內部看穿,故不能直接特化 generic 路徑。

---

### 26. `unzip` 結構化資料(`ld2w`/`st1w`)——SVE 原型已驗證

**接口**:`Iterator::unzip` 在 `&[(u32,u32)]` 等 AoS 切片上的形態(`v.iter().copied().unzip()`),輸出兩個 `Vec`。

**慢的原因**:泛型 `unzip` 經 `Extend::extend_one` 逐元素 push,每元素一次 `size_hint` 檢查與兩次 `Vec::push`(含容量分支)。AoS→SoA 在記憶體層是「元素寬度減半的交錯載入」,正是 `ld2` 的目標形狀。

**優化方法**:`ld2w {z0.s, z1.s}, p0/z, [src]` 一次取出兩個 lane 組,`st1w` 分別寫入兩個目標。需單獨為 slice 來源的 `unzip` 提供特化(泛型 iterator 無此保證);`extend`/`collect` 路徑同理。**關鍵細節**:`ld2w` 的 register-offset 形式縮放固定為元素大小(`lsl #2`),故索引需先 `t = i + i`,不能寫 `lsl #3`。

**Benchmarks**(ns;std = `v.iter().copied().unzip()`):

| n | std `Iterator::unzip` | SVE `ld2w`/`st1w` | 變化 |
|---|---:|---:|---:|
| 16 | 47.8 | **3.8** | **12.44×** |
| 64 | 50.1 | **9.1** | 5.52× |
| 256 | 85.0 | **44.5** | 1.91× |
| 1 024 | 209 | **146** | 1.43× |
| 4 096 | 623 | **601** | 1.04× |
| 65 536 | 102 767 | **10 742** | **9.57×** |

**說明**:1K–4K 區間接近持平是記憶體頻寬所限(兩版都已進入 steady-state 讀寫);兩端的大差距來自中段的成長/配置開銷(n=65 536 時 std 的 `102 µs` 中絕大部分是多次擴容)。對照「手寫 push 迴圈 + `reserve`」基線,SVE 為 3.0×/15.6×/13.4×/16.9×/15.1×(n=16/64/256/4096/65536)。

**落地待辦**:需新增切片來源的 `unzip` 特化掛點;`(u64,u64)` 用 `ld2d`、`(u16,u16)` 用 `ld2h`/`ld2w`(16 位需加寬);`f32`/`f64` 同構。

---

### 27. `trim_ascii_start` / `trim_ascii_end`(SVE 前導空白掃描,需門檻)——原型已驗證

**接口**:`library/core/src/slice/ascii.rs` 的 `trim_ascii_start`/`trim_ascii_end`(`&[u8]` 與 `<str>` 版本)。

**慢的原因**:逐字節 `is_ascii_whitespace` 早退掃描;長前導空白段上是純標量。

**優化方法**:`cmpeq` ×5 合併出空白遮罩,取反後 `brkb` 得前導非空白位置的長度;**關鍵是按整塊續行**:只有當整塊全為空白(`cntp(ws) == cntp(active)`)才 `incb` 續掃,否則立即退出。頭部先做一次標量檢查(見回退面)。

**原型核心**:

```rust
"not p2.b, p0/z, p1.b",        // p1 = 空白遮罩
"brkb p3.b, p0/z, p2.b",       // BRKB = 在第一個 true 之前的 true 數 = 前導空白長度
"cntp {k}, p0, p3.b",
"cntp {k2}, p0, p0.b",         // 本塊作用 lane 數
"cmp {k}, {k2}", "b.ne 4f",    // 非整塊空白 → 停
```

**Benchmarks**(ns;三種輸入形態):

| n | 無前導空白(std/SVE) | 1/3 前導空白(std/SVE) | 變化(1/3 空白) | 變化(無空白) |
|---|---:|---:|---:|---:|
| 16 | 1.7 / 4.1 | 3.8 / 4.1 | 0.92× | **0.42×** |
| 64 | 1.7 / 4.1 | 12.6 / 4.6 | **2.77×** | 0.42× |
| 256 | 1.7 / 4.6 | 45.9 / 18.7 | 2.45× | 0.38× |
| 4 096 | 1.8 / 4.7 | 724 / 417 | 1.74× | 0.38× |
| 65 536 | 1.8 / 4.7 | 11 460 / 6 934 | 1.65× | 0.39× |

**回退面**:**首字節非空白時回退 2.4–2.6×**(std 1.7 ns 即一次比較即返回,SVE 固定付 4.1 ns 的向量 setup)。這是最典型的「需要門檻」案例:落地**必須**先做標量首字節檢查,非空白立即返回,只有第一塊全空白才進入 SVE 迴圈。加此門檻後,常用情形(std 的 1.7 ns 路徑)不受影響,長前導空白段拿到 1.65–2.77×。

**落地待辦**:`const fn` 語義(`trim_ascii_*` 是 `const fn`,CTFE 必須保留純標量路徑,沿用 `const_eval_select!`);`trim_ascii_end` 用 `lastb` 對稱;`<str>` 版本要求結果落在 char 邊界(`trim_ascii_*` 只裁 ASCII 空白,天然安全)。

---

### 28. `[T]::is_sorted` 的尾塊與短長度(現為 NEON 分塊,尾部走標量)——候選

**接口**:`library/core/src/slice/mod.rs::is_sorted`(現行 `CHUNK_SIZE = 33` 的重疊分塊 + `windows(2).fold` 自動向量化)。

**慢的原因**:大尺寸下分塊形狀已向量化得相當好(0.14 ns/元素),但**尾部 31 個元素走標量 `windows(2).all`**;n=64 時這一段佔絕對多數——std 23.2 ns(0.36 ns/元素),而向量主體本應是 0.10–0.13 ns/元素。**這是純形狀問題,不需 SVE 也能修**(把尾部改成重疊的最後一整塊即可)。

**優化方法**:二選一——(a) 純 Rust 修尾部(重疊最後一塊,免 SVE、免特化、跨平臺受益);(b) SVE `cmphi` 比較 `v[i..]` 與 `v[i+1..]`,尾塊由 `whilelo` 自動遮罩。

**Benchmarks**(已排序的 `[u32]`,ns):

| n | std(NEON 分塊) | SVE | 變化 |
|---|---:|---:|---:|
| 64 | 23.2 | **6.5** | **3.57×** |
| 1 000 | 139.3 | **114.4** | 1.22× |
| 10 000 | 1 355.7 | **1 089.0** | 1.24× |
| 100 000 | 13 729.4 | **13 015.1** | 1.05× |

**說明**:n=64 的 3.57× 完全來自尾部標量段;n≥1000 後收益收斂到 1.05–1.24×,因為向量主體已接近記憶體頻寬。**故本條的主收益在 (a) 方案**(修尾部形狀),SVE 版相對 NEON 分塊只有 5–24% 的二階增益。

**回退面**:SVE 版需驗證 `<` 有副作用的自訂 `PartialOrd`(故特化限原生型別);`f32`/`f64` 的 `is_sorted` 用 `NaN` 語義需另測(SVE `fcm*` 的 NaN 行為與 Rust `<=` 不同)。

---

### 29. `[u8]::is_ascii` 的 SVE 中段窗口(僅 16–192 B 區間勝出)——已驗證,收益窗口窄

**接口**:`library/core/src/slice/ascii.rs::is_ascii`(已有樹內 NEON 特化:64 B unroll + `vorrq` 歸約)。

**慢的原因**:樹內 NEON 版本對長輸入效率高,但固定 setup(載入 + 歸約樹)對中小長度偏重。

**優化方法**:單一 predicated block(`whilelo` + `cmplt` 判高位)迴圈,無 64 B unroll 的固定成本。

**Benchmarks**(全 ASCII 輸入,ns):

| n | std(樹內 NEON) | SVE | 變化 |
|---|---:|---:|---:|
| 8 | 1.59 | 1.72 | **0.92×** |
| 16 | 1.95 | 1.73 | 1.13× |
| 24 | 2.76 | 1.73 | **1.60×** |
| 32 | 3.10 | 1.73 | **1.80×** |
| 96 | 2.65 | 2.76 | 0.96× |
| 128 | 3.80 | 3.14 | 1.21× |
| 192 | 4.49 | 3.80 | 1.18× |
| 256 | 5.17 | 5.88 | **0.88×** |
| 1 024 | 18.32 | 26.57 | **0.69×** |
| 4 096 | 64.58 | 94.61 | **0.68×** |
| 65 536 | 1 026 | 1 483 | **0.69×** |

**結論**:SVE 只在 **16–192 B** 窗口勝出(1.1–1.8× 絕對值 1–1.7 ns),≥256 B 後穩定輸給樹內 64 B unroll 的 NEON 版(0.68–0.69×)。**這是本輪唯一「SVE 只在中段長度贏」的接口**,直接替換會造成長輸入回退;若要用,門檻須設為「16 ≤ len < 192 走 SVE,其餘走既有 NEON」。收益上限極小(絕對值 <2 ns),優先級低。

**備註**:本條的 std 基線可重現 §9 之外的獨立確認——樹內 NEON `is_ascii` 在 65 KB 上 1.03 µs(≈0.016 ns/B,61 GB/s 級),與 §9 的探針真值一致。

---

### 30. SVE 形態的否決項(實測為負,勿實作)——已驗證

| 接口 | SVE 形態 | 實測 | 否決原因 |
|---|---|---|---|
| `[u8]::make_ascii_uppercase` / `make_ascii_lowercase` | `cmphs`+`cmpls` 範圍遮罩 + `sub`/`add` 0x20 | **0.48–0.78×**(n=16 0.78×、256 0.52×、4 096 0.48×、65 536 0.48×) | LLVM 對該迴圈已給出高品質 NEON(§9 已記 `case06_libcore` 0.029 ns/B),SVE 版多付 setup 且無寬度優勢 |
| `Vec::dedup_by` / `dedup_by_key`(任意閉包) | 兩階段 mask + `COMPACT`(同 retain 模板) | **0.80–0.86×**(n=64 0.81、1 000 0.86、100 000 0.80) | Phase A 非純 map:`same_bucket(cur, prev)` 的 `prev` 是「上一個保留者」,逐元素串行依賴,且多一次謂詞結果決定的分支,抵消了 retain 模板的優勢。`Vec::dedup`(`T: PartialEq`)不在此列——§5 已證 −50%…−94%,因為它把比較本身也放進向量 |
| `String::retain` | mask 擴展到每字節 + `COMPACT` | 全部形態 **+36%…+212%**(eager/lazy 兩變體、全尺寸 × 收回率) | UTF-8 解碼 + 每字元閉包呼叫是 API 契約性的串行段,標量版本在 keep-all/drop-all 下零寫入;詳見 `STRING_RETAIN_SVE_ANALYSIS.md` |
| `LinkedList::retain` / `BTreeMap::retain` / `BinaryHeap::retain` | — | — | 非連續存儲(`BinaryHeap::retain` 是 `Vec::retain` + `rebuild`,自動吃 §22 的特化) |
| `[T]::partition_dedup_by` / `sort` 的 `partition` | — | — | swap 語意下兩側元素都必須保留,`COMPACT` 只產生一側;quicksort partition 已是無分支 Lomuto,且需雙輸出(SVE2 `SPLICE`) |
| `Iterator::position`(generic 閉包) | — | — | 見下方註:generic 路徑無法看穿閉包,需新增閉合 API |

**`Iterator::position` 的缺口註記**:`v.iter().position(|&y| y == x)` 實測 0.46 ns/元素,而 `v.contains(&x)`(已有分塊特化)是 0.07 ns/元素——**同一操作慢 6×**,因為 `position` 的謂詞是任意閉包,specialization 無法識別。這是 std 的 **API 缺口**(缺少 `[T]::index_of` 一類的閉合查找),不是可在 std 內部修的性能問題;若新增該接口,SVE 形態與 §20 同構(`cmpeq`+`brkb`+`cntp`),實測 0.07 ns/元素。

---

### SVE 落地前提與本機 ISA 事實(2026-10 掃描)

- **本機**:HiSilicon aarch64,VL = 32 B(256-bit),base SVE 全套可用——`compact`/`tbl`/`uzp1`/`trn1`/`zip1`/`lasta`/`lastb`/`brka`/`brkb`/`ptest`/`cntp`/`whilelo`/`incb`/`incw`/`ext`/`ld1w`/`st1w`/`ld2w`/`st2w`/`cmpeq`/`cmphi`/`cmphs`/`cmpls`/`cmplt` 全部組譯並執行通過。
- **SVE2 不可用**(運行時 `is_aarch64_feature_detected!("sve2")` 為 false,組譯器對 `revb`/`histcnt`/`match`/`splice` 直接報 `requires sve2`)。以下只能列為**未來硬件**候選,本期無法實測:`count_bytes` 直方圖(`histcnt`)、`split(char)`/`find`/`rfind`(`match`+`splice`)、`bytes_rev`/`chars_rev`(`revb`)、排序 partition 雙輸出(`splice`)。
- **構建前提**:rustc 默認 `generic` CPU 不含 `sve` 特性,發行版 std 拿不到 SVE 路徑;落地須走 `sve_retain.rs` 的**靜態 `+sve` 構建**先例,或引入 runtime dispatch。`-Ctarget-cpu=native` 下 LLVM 會自行為 `reverse`/`unzip`/`count`/`sum`/`dot`/`fill` 等發出 SVE,但發行版不走這條路。
- **stdarch 現狀**:已有 5 543 個 `sv*` 函數,但 scalable vector 型別在 `core`/`alloc` 沒有可靠的 Rust 表示(無 provenance/未初始化 padding 語義),故 §20–§27 的 kernel 全部以 inline asm 實作,與 `sve_retain.rs`/`memchr` 原型一致。

**兩條易錯的 ISA 細節**(本輪除錯確認,後續實作必讀):

1. **`BRKB(P)` = 在第一個 true 之前的 true 數**(即前導 **false** 個數);來源全 false 時回全部 lane 數。`BRKA` 對稱(含首個 true)。取「前導空白長度」需用 `BRKB(非空白遮罩)`;`brkb` 前若遮罩可能全 false,須先處理該情形(全零會回 lane 數而非 0)。
2. **`orr pA.b, pB/z, ...` 的 governing predicate 必須是迴圈謂詞**,不可用累加目標自身——用 `p1` 管轄 `p1` 會令 `/z` 把新匹配的 lane 清零,遮罩恆為空。

---

### 31. `Fuse` 缺 `InPlaceIterable`(`.fuse()` 讓 `collect` 悄悄多分配一次)——樹內原型已驗證

**接口**:`library/core/src/iter/adapters/fuse.rs`;影響 `vec.into_iter()….fuse()….collect::<Vec<_>>()` 一類鏈。

**慢的原因**:`Fuse` 有 `SourceIter` 而沒有 `InPlaceIterable`,in-place collect 特化不成立,退回新分配 + 複製。該 impl 於 2021-06(`6f5e933adb57`,修 #85863)與 `SourceIter` 一併被刪;2023-04(`3ca6bb0b44c3`)只把 `SourceIter` 以 `TrustedFused` 約束加回。

**優化方法**(樹內原型):補回 `InPlaceIterable`,常數轉發內層;健全性由 `SourceIter` 既有的 `I: TrustedFused` 約束保證。

**原型核心**:

```rust
unsafe impl<I: InPlaceIterable> InPlaceIterable for Fuse<I> {
    const EXPAND_BY: Option<NonZero<usize>> = I::EXPAND_BY;
    const MERGE_BY: Option<NonZero<usize>> = I::MERGE_BY;
}
```

**結果**:

| | 現狀 | 原型 |
|---|---:|---:|
| `bench_in_place_recycle` 形態,分配/輪 | 1.000 | **0.000** |
| 獨立進程探針(1000 × usize) | 282–285 ns | **248 ns(−12%)** |
| 官方 `vec::bench_in_place_recycle` | ~185 ns | 時間上無法分辨(分配成本被較快的複製迴圈抵消) |

測試:`coretests fuse`、`flatten`,`alloctests in_place`、`from_iter` 共 92 項全過。

**待辦**:需 `inplace_iteration` 維護者確認健全性;`bench_in_place_recycle` 自 2021 年起未走 in-place 路徑而時間看不出來,應加分配計數斷言。`Peekable` 有同形缺口,未評估。

## 三、候選方向(根因已定位,修復未原型化)

(#6、#7、#8、#10–#13、#16–#28 已原型化並移至第二層;#29–#30 為已驗證的限制項與否決項,亦在第二層;#31 已原型化,同在第二層。)

### 14. `BTreeMap` 順序插入的樹形(`splitpoint` 對右緣插入不偏置)——候選

**接口**:`library/alloc/src/collections/btree/node.rs::splitpoint`;影響所有用 `insert` 順序建樹後的 `get`/`range`/迭代。

**慢的原因**:順序 `insert` 永遠打在最右葉,節點滿時從中間分裂,左側節點被凍結在 6/11 鍵(裝填率 55%,10 000 鍵 1666 節點 vs `collect` 的 913),樹多一層;非滿節點走 early-exit 掃描,順序 `get` 每層一次分支失誤(2.98 次/get,IPC 1.90)。同數據 `collect` 建樹:`get` 116 → **59 cycles**。

**優化方法**(未原型):`splitpoint` 對「插入邊緣 == CAPACITY(最右)」時偏置——左節點保留 `CAPACITY − 1`(或 −2)鍵,新右節點只放新鍵,順序插入得到 ~90% 裝填;隨機插入沿用現規則。需重驗 #74834 的雙向插入均衡性與 `remove` 的下溢合併頻率。

**Benchmarks**(估):`find_seq_10_000` 41.7 → ~22 ns(−47%),`range_*`、`iteration_*`、記憶體 −45% 節點數同步受益;`insert_seq_*` 分裂次數減半。已排除的替代方案:對非滿節點做無分支掃描(+75…+270%,拷貝成本主導)。

### 15. `core::slice::memchr`(portable SWAR,無 SIMD 主體)——候選

**接口**:`library/core/src/slice/memchr.rs::memchr`;`str::split/find/contains(char)`、`CStr::from_bytes_with_nul`、`[u8]::contains` 全部經此。`88ac7ace569c` 刪除了 std 的架構特化版本後只剩 portable SWAR。

**慢的原因**:2×usize SWAR 主體之外,對齊前綴與匹配後的定位都是逐字節迴圈——`split_unicode_ascii` 三段 memchr 的 46% 樣本在字節迴圈;長掃描上 16 B/迭代 SWAR 只有 NEON 吞吐的 40%。

**優化方法**(探針已驗證,未入樹):前 16 B 用無對齊 SWAR 字 + `ctz` 定位(短段一次到位),之後 NEON `cmeq` 16 B/迭代,尾巴沿用字節迴圈。

**Benchmarks / 探針**(形態 G,每種輸入 2 次一致):`split_unicode_ascii` −38%、~5 B 段 −10%、**16–40 B 段 +9…+19%**、97 B 段 −24%、無匹配長掃描 −57…−58%。無單一形態三區間全贏;落地取決於對 16–40 B 段回退的接受度與 std 是否重新接受架構特化 memchr。x86 用 `pcmpeqb+pmovmskb` 取 mask 更短,中段劣勢預期較小,未實測。

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
| `u128::isqrt` 末端除法 | `num::int_sqrt::u128_sqrt_{predictable,random,uniform}` | **原型驗證**(窄化至原生 `udiv`;uniform −26.7%、predictable −18.8%、random −18.4%;u16/u32/u64/u8 ±0.2%) |
| `Filter`/`FilterMap::next_chunk` 壓縮迴圈 | `iter::bench_next_chunk_{filter,filter_map}_*`(新增 3 項 shuffled)| **原型驗證**(mostly_false −38%/−41%、shuffled −19%/−34%、`filter_even` −15%;`filter_map_even` +3.3%) |
| `Fuse` 缺 `InPlaceIterable` | `vec::bench_in_place_recycle`(時間上不可見;分配計數 1 → 0) | **原型驗證**(獨立探針 −12%;需健全性確認) |
| `Iterator::array_chunks` | `iter::bench_next_chunk_trusted_random_access[_runtime_len]`(harness 測不到;探針 3.06×) | **原型驗證**(根因為迴圈形態,非字段訪問) |
| `BTreeMap` 順序插入樹形(`splitpoint`) | `btree::map::find_seq_10_000`、`range_*`、`insert_seq_*` | 候選(collect 建樹同查詢 −50%) |
| `escape_debug_ext` BMP 位圖 | `str::debug::{mostly_unicode,mixed,some_unicode}`、`fmt::write_{str,vec}_macro_debug` | **原型驗證**(−87%/−75%;`ascii_*` 持平) |
| `core::slice::memchr` | `str::split_unicode_ascii`、`split_*`(短段);`contains`/`CStr` 長掃描 | 候選(短段 −38%、長掃 −58%;16–40 B 段 +9…19%) |
| `BTreeMap::iter[_mut]` fold | `btree::map::iteration[_mut]_fold_{20,1000,100000}`(新增) | **原型驗證**(fold_1000 −43%,無回退) |
| `u8::is_ascii_*` / `[u8]::is_ascii` | `ascii::*::is_ascii_*` + `ascii::is_ascii::*`(80 項,**全部無效**) | 先修 bench(三層失效已定位) |
| `BTreeMap` 節點內搜索(整數鍵) | `btree::{map,set}::clone_*_and_remove_half`、`range_included_*`、`find_*`、`insert_*`;回退:`set::difference_*`、`intersection_*`、`range_included_unbounded` | **原型驗證**(remove_half −36%、range −48%;`difference_random` +89% 待修) |
| `BTreeMap::IntoIter` drop | `btree::{map,set}::clone_*`、`from_iter_seq_*`(基線端) | **原型驗證**(clone −57…−66%,無回退) |
| `VecDeque::iter[_mut]` 的 `for`(`next()`) | `vec_deque::bench_{iter,mut_iter}_1000`(`into_iter*`/`try_fold` 為佈局噪聲) | **原型驗證**(−31%,零語義改動) |
| `from_str_radix(_, 10)` 32/64 位 | `num::bench_{u32,u64,i32,i64}_from_str[_radix_10]`(混合僅 2.8 位;單串 ≥8 位 −65…−75%) | **原型驗證**(佈局噪聲 ±27% 蓋過官方數字) |
| `Rev<I>::count` | `str::char_{indicesator,iterator}_rev` | **原型驗證**(−68…−76%;落地需特化 trait 保副作用順序) |
| `[T]::cmp`/`partial_cmp`/`<`(寬整數) | `slice` 比較、`binary_search`、`BTreeMap<Vec<T>,_>` 鍵;原型 standalone(等長相等切片 0.36→0.10 ns/元素,3.3–3.7×) | **SVE 原型驗證**(掛點 `AlwaysApplicableOrd` 已存在;`u8`/`bool` 已走 memcmp) |
| `[f32]`/`[f64]` 切片相等 | `[f32]==[f32]`、浮點 `starts_with`/`ends_with`;原型 standalone(0.67→0.11 ns/元素,4.5–6.1×) | **SVE 原型驗證**(`fcmne` 即 IEEE `!=`;`b.any` 前須補 `ptest`) |
| `VecDeque::retain`/`retain_mut` | 原型 standalone u32(64→2.20×、1 000→2.05×、100 000→10.43×;wrap 1/3 處 9.91×) | **SVE 原型驗證**(ring 分段切 chunk + scratch 貼回;panic guard 沿用 `sve_retain.rs` 模板) |
| `Vec::extract_if(..)` 全消耗 | 原型 standalone u32(100 000:5.13× vs `with_capacity`;64:1.20×) | **SVE 原型驗證**(同 mask 正反各 COMPACT;需確認謂詞呼叫時序可否由 per-`next` 改 per-chunk) |
| `chunk_by().count()` / run 計數 | 原型 standalone u32(16→2.69×、4 096→2.49×、65 536→2.23×) | **SVE 原型驗證**(`cmpne`+`cntp`,無回退) |
| ASCII 封閉類別計數(`filter(pred).count()`) | 原型 standalone(數字:24→6.00×、96→7.31×、65 536→5.02×;空白:64→3.42×) | **SVE 原型驗證**(`cmphs`/`cmpls`+`cntp`;std 無對應公開接口) |
| `unzip` AoS→SoA(`&[(u32,u32)]`) | 原型 standalone(16→12.44×、64→5.52×、65 536→9.57×;1K–4K 頻寬所限 ~1.0×) | **SVE 原型驗證**(`ld2w`/`st1w`;需新增切片來源的 `unzip` 掛點) |
| `trim_ascii_start`/`_end` | 原型 standalone(1/3 前導空白:64→2.77×、4 096→1.74×;**無空白 0.38–0.42× 回退**) | **SVE 原型驗證**(需標量首字節門檻;`const_eval_select!` 保 CTFE) |
| `[T]::is_sorted` 尾塊 | 原型 standalone u32(64→3.57×、1 000→1.22×、100 000→1.05×) | **SVE 原型驗證**(主收益在修尾部標量段,純 Rust 即可 3.57×;SVE 為二階) |
| `[u8]::is_ascii` SVE 中段 | 原型 standalone(16–192 B 勝 1.13–1.80×;**≥256 B 為 0.68–0.69× 回退**) | **已驗證,收益窗口窄**(樹內 NEON 64 B unroll 在長輸入更強;優先級低) |
| SVE 否決項 | 原型 standalone:`make_ascii_uppercase` 0.48–0.78×、`Vec::dedup_by`(閉包)0.80–0.86×、`String::retain` +36…+212% | **實測為負,勿實作** |
| `Iterator::position`(generic 閉包) | 0.46 ns/元素 vs `contains` 0.07(同操作慢 6×) | **API 缺口**(缺 `[T]::index_of` 閉合接口;新增後 SVE 形態同 §20) |
