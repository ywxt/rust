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

**慢的原因**:aarch64 後端把 `(cmp) as usize` 生成**真分支** `b.hi`(x86_64 生成 `sbb` branchless,無此問題)。隨機資料上 sibling 比較近 50% 熵,branch miss 9–21%,IPC 壓到 1.2–1.7。三個獨立 benchmark 現場證實同一病灶。

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

---

## 三、候選方向(根因已定位,修復未原型化)

### 6. `flt2dec` Dragon `format_exact`(digit 批量化)

**接口**:`library/core/src/num/imp/flt2dec/strategy/dragon.rs::format_exact`(`f64::MAX` 的 `{}` 格式化與高精度 `{:.N}` 都會到達;`grisu::format_exact` 高精度時 100% fallback 到此)。

**慢的原因**:每個十進制輸出位做一次對整個 `Big32x40` 的 O(limbs) 除 10(`umulh` 倒數乘法),O(digits × limbs) 平方級;32-bit limb 在 64-bit 硬件上每迭代只消化半字寬。1024 位輸出 = 42 µs。

**優化方法**(兩者正交可疊加):
1. 每輪除 10⁹ 一次取 9 位,大數操作次數 ÷9(ryū/dragonbox 常規手法);
2. `Big64x20`(64-bit limb),所有迴圈迭代減半。

```rust
// 現狀: loop { let d = mant.div_rem_small(10); out.push(d) }
// 改為: loop {
//     let r = mant.div_rem_small(1_000_000_000);  // 一次 O(limbs) 吃 9 位
//     out.extend(expand_9_digits(r));              // 純標量展開,不碰 bignum
// }
// 注意 format_exact 的 limit 截斷與 rounding 進位邏輯需隨之重排。
```

**Benchmarks**(`library/coretests/benches/num/flt2dec/`):`strategy::dragon::bench_{small,big}_exact_{3,12,inf}`、`strategy::dragon::bench_{small,big}_shortest`、`strategy::grisu::bench_{small,big}_exact_inf`(經 fallback)。預期對 exact_inf 類數倍(除法次數 ÷9),對 shortest 類 ~1.5–2×。x86 同構(`mulx/adc`),平臺無關。

### 7. `Iterator::array_chunks`(TRA fold 的向量化懸崖)

**接口**:`library/core/src/iter/adapters/array_chunks.rs` 的 `SpecFold`(TrustedRandomAccess 特化)。

**慢的原因**:`from_fn` 閉包經 `&mut self.iter` 訪問 iterator 結構體字段,IR 到達 LoopVectorizer 時仍是結構體內存形式,向量化被放棄——**僅在長度非編譯期常量時**觸發(官方 bench 的 `vec![1u8;1024]` 內聯後長度可見,測不到這個懸崖)。裸 slice 上同形狀迴圈向量化正常,證明 `from_fn` 本身不是病因。

**優化方法**:對 inner 可還原為連續 slice 的情形(`slice::Iter`/`Copied`/`Cloned`),fold 改走 `as_chunks` 型塊狀訪問;需逐一論證非連續 TRA 源(`vec::IntoIter` 的 drop 責任、`Zip` 雙緩衝、`Map` 副作用順序)不受影響。或 LLVM 側:讓 iterator 結構體 SROA 在向量化前完成。

```rust
// 用戶側 workaround(即刻可用,快 2.9×):
let (chunks, _) = bytes.as_chunks::<8>();
chunks.iter().map(|c| u64::from_ne_bytes(*c))...
```

**Benchmarks**(`library/coretests/benches/iter.rs`):`bench_next_chunk_trusted_random_access`(37.6 ns,現狀健康——但同鏈條在運行時長度下 98.0 vs 33.4 ns,2.9× 懸崖;建議補 `black_box(len)` 變體守護)。

### 8. `BTreeMap::iter` / `iter_mut`(fold 葉節點批量化)

**接口**:`library/alloc/src/collections/btree/map.rs` 的 `Iter/IterMut`(無 fold/try_fold 覆寫)。

**慢的原因**:無微架構事件(miss ≈0、IPC 3.64),純指令數——每元素一次 `next()` 狀態機(18.6 指令/元素 vs Vec 的 4.0),含 length 遞減、葉內邊界檢查、每 11 元素一次爬樹。

**優化方法**:實現 `fold`,按葉節點批量發元素,爬樹成本從每元素攤到每節點:

```rust
// 概念形狀(實際需在 navigate 層實現):
fn fold<B, F>(self, init: B, mut f: F) -> B {
    let mut acc = init;
    for leaf in self.leaves() {                 // 爬樹:每節點一次
        for kv in leaf.kv_slice() { acc = f(acc, kv) }  // 葉內:直線迴圈
    }
    acc
}
```

**Benchmarks**(`library/alloctests/benches/btree/map.rs`):`iteration_20/1000/100000`、`iteration_mut_20/1000/100000`。收益上限估 20–40%(僅惠及 `for`/fold 類消費);工程量在 navigate 層不小。

### 9. `u8::is_ascii_*` 謂詞族(SWAR/bitset 化)——前提是先修 benchmark

**接口**:`u8::is_ascii_whitespace/digit/alphanumeric/...` 經 `iter().all()` 的批量掃描形態。

**慢的原因**:全掃描是 0.52 ns/B 的逐字節 match,對比 `is_ascii` 的 0.018 ns/B(SWAR)有 **29× 差距**。但現有 benchmark(`ascii::{short,medium,long}::is_ascii_*`)測不到它:輸入對這些謂詞在頭幾字節就短路,190 ns 全是 harness 的 `to_vec()` memcpy。

**優化方法**:第一步修 benchmark(`@iter` 宏去掉 `to_vec`,補全真輸入);第二步纔是 128-bit bitset 查表或 SWAR 化謂詞本體。

**Benchmarks**(`library/coretests/benches/ascii.rs`):`{short,medium,long}::is_ascii_{whitespace,digit,control,uppercase,lowercase,alphabetic,alphanumeric,hexdigit,punctuation,graphic}`(現狀全部無效,僅 `is_ascii` 有效)。

---

## 四、LLVM 側修復點(影響 std 接口但改動在 LLVM)

總表;各項詳述見下。

| 修復點 | 影響接口 | 現象 | 收益 |
|---|---|---|---:|
| VPlan argmax 識別 `IVOp = IV increment` | `Iterator::max_by_key` 等 argmax 形態 | CGU/內聯上下文決定是否向量化(「codegen 彩票」) | 3.4× |
| AArch64 可預測性感知的 if-conversion | BinaryHeap、binary_search 及所有 `(cmp) as usize`/select 形狀 | 兩後端做出相反的靜態選擇,各錯一邊 | 1.5–4.4× |
| requiresScalarEpilogue 放寬 / predicated epilogue | 帶邊界檢查索引訪問的迴圈 | 長度整除 VF 仍強制整塊標量尾(2/3 時間) | ~2× |
| iterator 結構體 SROA 提前到向量化前 | `array_chunks` 等 adapter 鏈 | 結構體字段訪問形式使向量化放棄 | 2.9× |
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

**組件**:AArch64 if-conversion(SelectionDAG/early-ifcvt)+ `!unpredictable` metadata 處理。

**根因**:兩後端對同樣 IR 形狀做出**相反**的靜態選擇,各在資料分佈軸的一側犯錯:

- `child += (left <= right) as usize`(BinaryHeap):x86 降成 branchless `sbb`;AArch64 保留真分支 `b.hi`。隨機堆上 ~50% 熵 → miss 9–21%,IPC 1.2–1.7。源碼層驗證(`select_unpredictable` → `csel`)收益 **-34%~-41%**。
- 鏡像案例(`manual_char_len` UTF-8 步進迴圈):AArch64 激進 if-convert 成 `csel` 鏈,把 100% 可預測的分支換成穿過載入的資料依賴——2 字節文本上比 x86 保留的分支形態**慢 4.4×**。

兩後端都不是全局正確;缺的輸入是**可預測性**。正確的成本模型:

```text
branch cost = predicted_cost + P(miss) × miss_penalty      // P(miss)→0 時近乎免費
select cost = csel 延遲 + (cmp → csel → address → load) 佔據關鍵路徑的代價
```

**修法方向**(互補):
1. 尊重 `!unpredictable` metadata(`select_unpredictable` 已生成)作為 select 硬偏好——現狀可用,但**反方向**沒有任何推力;
2. 有 PGO/branch-probability 時,分支高度偏斜**且** select 會落在載入地址關鍵路徑上就拒絕 if-convert(`manual_char_len` 病理);
3. 無 profile 時,對不餵地址的旗標算術形狀(`(cmp) as usize` 加法,即 x86 `sbb/adc` 慣用法)傾向 if-convert。

**影響的 std 接口/benchmark**:`binary_heap::bench_{from_vec,find_smallest_1000,pop}`(branch→select 贏 34–41%)、`str::char_count::case03`(select→branch 贏 4.4×)、`slice::binary_search_*`(未知分佈下 select 正確,不得回退)。

### L3. LoopVectorizer:trip count 整除 VF 時去掉強制標量尾

**組件**:LoopVectorizer 的 `requiresScalarEpilogue`/epilogue 策略,AArch64 tail-folding 默認值。

**根因**:帶側出口(bounds-check panic)的迴圈需要精確標量尾;現行策略保留 `(n % VF == 0 ? VF : n % VF)` 個元素——**長度整除向量寬度時仍強制整塊 VF 走標量**。實測 `vec::bench_in_place_zip_iter_mut`(256B,VF=32):7 輪 NEON + **32 輪強制標量 + 每調用 alias/min guards = 2/3 總時間**,64% 樣本在標量尾。該結構在 IR 層定形,重定目標到 SSE2/AVX2 原樣保留——x86 付同樣的稅。

**修法方向**:
1. SCEV 證明 `n % VF == 0`(或發廉價運行時檢查)時整個跳過標量尾;
2. ISA 支持時優先 predicated/masked epilogue(SVE `whilelo`、AVX-512 masked)——`-prefer-predicate-over-epilogue` 機制存在但非 AArch64 默認,且 rustc 默認 generic CPU 根本不開 SVE。

**影響的 benchmark**:`vec::bench_in_place_zip_iter_mut`(~2× 空間)、`bench_in_place_zip_recycle`(同形狀)、一切帶索引側表訪問的 `iter_mut().enumerate()` 迴圈。

### L4. Pipeline:iterator 結構體 SROA 在向量化前完成

**組件**:pass 順序/LoopVectorizer 之前的 SROA 積極性。

**根因**:`ArrayChunks<Map<slice::Iter>>::fold` 經 `__iterator_get_unchecked(&mut self.iter, idx)` 取元素;閉包捕獲 `&mut` iterator,IR 到達向量化器時載入仍是結構體字段形式(`slice::Iter { ptr, end }`),向量化放棄;後續 pass 才清成乾淨標量迴圈——為時已晚。迴圈形狀本身無罪的證據:同樣的 `while len-i>=8` + `from_fn(get_unchecked(i+local))` 在**裸 slice** 上向量化正常(34.6 vs 真實鏈 98.0 ns);外層換 `Copied` 同樣復現,排除閉包層。

**修法**:在 LoopVectorizer 前對 iterator alloca 重跑 SROA 使 `ptr/end` 標量化;或讓向量化器接受「迴圈不變結構體字段基址 + 仿射偏移」。std 側替代方案(對連續 TRA 源做塊狀特化 fold)更重,且需逐源等價論證。

**影響的 benchmark**:`iter::bench_next_chunk_trusted_random_access`(定長時健康;運行時長度 2.9× 懸崖,建議補 `black_box(len)` 變體)。

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
| `flt2dec`(Dragon) | `num::flt2dec::strategy::{dragon,grisu}::*`(19 項中的 exact_inf/shortest 類) | 候選 |
| `Iterator::array_chunks` | `iter::bench_next_chunk_trusted_random_access`(+建議新增不定長變體) | 候選 |
| `BTreeMap::iter[_mut]` | `btree::map::iteration[_mut]_{20,1000,100000}` | 候選 |
| `u8::is_ascii_*` | `ascii::{short,medium,long}::is_ascii_*`(30 項,需先修 harness) | 候選(先修 bench) |
