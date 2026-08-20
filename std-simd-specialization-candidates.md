# 標準庫 SIMD / SVE 特化候選評估

> 目的：盤點 `library/core`、`library/alloc`、`library/std` 中可透過 NEON、SVE 或 LLVM 自動向量化受益的容器、迭代器、切片與字串操作。本文不是把所有逐元素函數都改成 SIMD；重點是評估「語義可保持、資料具連續性、且有機會超過現有實作」的候選。
>
> SVE 路徑應採用編譯期 `target_feature` 選擇；在目前 Rust 對 scalable/sizeless SVE vector value 的限制下，若需要直接操作 `z`/`p` register，應把 inline assembly 限制在很小的 kernel 中，只向 Rust 暴露 scalar count/offset 等結果。

## 1. 評估準則

每個候選依下列因素評估：

- **收益**：是否是長連續 buffer 上的高頻線性掃描或轉換。
- **可實作性**：是否能用固定寬度 NEON，或用 inline assembly 實作 VLA SVE。
- **現有優化**：目前是否已有 SWAR、NEON、`memcpy`/`memset`、或刻意設計給 LLVM vectorizer 的程式碼。
- **語義風險**：early-exit、精確錯誤位置、panic/drop 順序、overlap、NaN/overflow、closure 副作用與 const evaluation。
- **資料布局**：連續切片最適合；ring buffer、分散配置與 pointer chasing 通常不適合。

分數是工程優先級而不是承諾的 benchmark 結果。所有閾值都應由 aarch64 NEON、SVE、非 SVE scalar 三組實測決定，不能直接沿用 `Vec::retain_mut` 的閾值。

## 2. 優先級總覽

| 優先級 | API / 位置 | SIMD 形態 | 預期收益 | 主要阻礙 |
|---|---|---|---|---|
| **A** | `slice::trim_ascii_start/end`，`core/src/slice/ascii.rs` | byte classify + first/last non-match | 高（長 whitespace prefix/suffix） | `const fn`、邊界 lane 提取 |
| **A** | `slice::memchr` / `memrchr`，`core/src/slice/memchr.rs` | broadcast compare + any-match + lane index | 高（搜尋是常見基礎操作） | early exit、精確 index、短輸入成本 |
| **A-** | `str::validations` 的 ASCII prefix，`core/src/str/validations.rs` | byte high-bit test + first non-ASCII lane | 中到高（ASCII-heavy UTF-8） | 只適合 ASCII prefix；完整 UTF-8 較難 |
| **B+** | `make_ascii_uppercase/lowercase`，`core/src/slice/ascii.rs` | range mask + add/subtract | 中到高（長 ASCII buffer 的 in-place transform） | LLVM 可能已自動向量化；大小寫語義 |
| **B** | `is_ascii` 現有 NEON 路徑的 SVE 版本 | block high-bit reduction | 中 | 已有 64-byte NEON unroll，SVE 必須證明可超越 |
| **B** | `EscapeAscii` printable-prefix scan，`core/src/slice/ascii.rs` | classify + first byte needing escape | 中 | formatting 的後續控制流與 iterator 狀態 |
| **B-** | `[T]::contains`（寬 primitive），`core/src/slice/cmp.rs` | compare + predicate reduction | 中 | 現有固定 chunk 已專門設計給 auto-vectorizer |
| **C+** | `VecDeque::retain_mut`，`alloc/src/collections/vec_deque/mod.rs` | 分段掃描後 compact/copy | 不確定 | wrap layout、closure 順序、swap/drop/panic |
| **C** | `String::retain`，`alloc/src/string.rs` | 只有 closed-form predicate 才可能 | 低到中 | UTF-8 可變長、每次 callback 可能有副作用 |
| **C** | `str::count_chars`，`core/src/str/count.rs` | SVE byte classification/count | 低到中 | 現有 SWAR + auto-vectorization 已很強 |
| **Reject** | generic `Iterator::{position,find,any,all}` 等 | 理論上 predicate mask | 低 | 任意 `FnMut` 必須依序呼叫，不能批量執行 |
| **Reject** | generic sum/product/min/max | reduction | 低/語義受限 | iterator representation、overflow、浮點 reassociation |
| **Reject** | `partition_dedup_by` / `Vec::dedup_by` | 比較後 compact | 低 | mutable stateful predicate 使每步相依 |
| **Reject/已有底層優化** | `copy_from_slice`、`clone_from_slice`、fill、rotate 等 | memcpy/memmove/memset | 低新增價值 | 已使用 intrinsic/底層 routine 或 LLVM vectorized loop |
| **Reject** | `LinkedList`、BTree 結構上的遍歷/操作 | 不規則 gather | 低 | pointer chasing、cache miss，不是 SIMD 瓶頸 |

## 3. A 級候選

### 3.1 ASCII trim 的邊界掃描

位置：`library/core/src/slice/ascii.rs` 的 `trim_ascii_start`、`trim_ascii_end`、`trim_ascii`。

目前實作從兩端逐 byte 判斷 `is_ascii_whitespace`。該 predicate 是封閉集合：`0x09`、`0x0a`、`0x0c`、`0x0d`、`0x20`；`0x0b`（vertical tab）刻意不包含，SIMD classifier 必須精確保留這個差異。

建議算法：

1. 用 NEON `ld1` 或 SVE `ld1b` 載入一個 block。
2. 對五個 whitespace 值產生 equality predicate，或用範圍/位元分類降低比較數。
3. 將 whitespace mask 轉成「第一個非 whitespace」的 lane index。
4. start 直接跳過 prefix；end 從尾端 block 找最後一個非 whitespace。
5. 小輸入、const evaluation 使用原 scalar 路徑；runtime SIMD dispatch 不能破壞 `const fn`。

SVE 可用 `whilelt`、`ld1b`、predicate compare，再用 `cntp` 或 break predicate 計算 prefix 長度。NEON 則以 `umaxv`/位元 mask 加上 lane extraction 實作。因為 start/end 通常只需要少數 block，避免每次呼叫都付出過高 setup cost 很重要。

**建議優先做 `trim_ascii_start`，再共用反向掃描 helper 做 end。** Benchmark 應分別測全 whitespace、首 byte 非 whitespace、prefix 長度 0/1/15/16/31/32/63/64/128/1K，以及空 slice；同時測結果 slice offset 而非只測內容相等。

### 3.2 `memchr` / `memrchr`

位置：`library/core/src/slice/memchr.rs`。

現有實作已使用對齊的 `usize` word、needle broadcast 與 SWAR `contains_zero_byte`。因此這不是「把 scalar 直接換 SIMD」；候選是測量 NEON/SVE 是否能在中長輸入上降低每 byte 成本。

SIMD kernel：

- broadcast needle；
- `ld1b`/NEON load 後 compare；
- 若沒有 match，跳到下一個 block；
- 若有 match，提取第一個 matching lane；`memrchr` 則從最後一個 lane 開始找；
- 保留現有 scalar prefix/suffix 與短輸入 cutoff。

最難的部分是 exact early-exit：找到 match 後不能繼續掃描並回傳錯誤位置，也不能因 block 對齊改變返回 index。SVE 的 predicate-to-index 轉換需明確驗證；只回傳 `cntp` 不足以找第一個 match，必須先保留匹配 predicate 並計算其最低/最高 set lane。

這個候選值得排在前面，因為 `memchr` 可能被大量字串、解析器與標準庫函數間接使用。但要先與目前 SWAR 實作比較，而不是假設 SVE 一定更快。

## 4. B 級候選

### 4.1 UTF-8 驗證的 ASCII prefix

位置：`library/core/src/str/validations.rs` 的 `run_utf8_validation`。目前 ASCII fast path 使用兩個 `usize` word 並以 `contains_nonascii` 掃描。

可加入只處理「長 ASCII prefix」的 SIMD block：比較每 byte 的 high bit，找到第一個非 ASCII lane 後回到既有 UTF-8 validator。這樣不需要改變 multibyte validation 的核心狀態機，也能保持第一個錯誤位置與 `error_len` 語義。

不建議第一階段實作完整 SIMD UTF-8 validator。完整版本必須處理跨 block 的 continuation、overlong encoding、surrogate、上限 `F4 8F`，並精確回報錯誤位置；一個錯誤的 vector boundary 可能改變 public error semantics。優先測試 ASCII-heavy、全 ASCII、首 byte 非 ASCII、以及錯誤出現在 block 邊界的資料。

### 4.2 ASCII uppercase/lowercase in-place transform

位置：`library/core/src/slice/ascii.rs` 的 `make_ascii_uppercase` 與 `make_ascii_lowercase`。

這些是封閉 predicate 的 in-place transform：只有 `a..=z` 或 `A..=Z` 需要改變，非 ASCII byte 保持不變。可用 SIMD range compare 產生 mask，再對選定 lane 加/減 `0x20`。

但這裡必須先檢查 LLVM 產生的 NEON code。簡單的 Rust loop 可能已被 vectorizer 自動轉為高品質 NEON；SVE inline assembly 只有在長輸入、SVE hardware、以及非 SVE fallback 的實測中都勝出才值得加入。應特別測試全小寫、全大寫、混合 ASCII、完全非 ASCII、以及長度低於一個 vector 的輸入。

### 4.3 `is_ascii` 的 SVE 版本

`is_ascii` 已有架構相關優化，AArch64 目前有 NEON 路徑，且已有較大的 unrolled block。SVE 版本的價值不在於「比 scalar 快」，而在於是否能用 VLA block 降低 loop overhead、在較長 buffer 上超過現有 64-byte NEON unroll。

建議只做 benchmark prototype，不要先改 public dispatch。測量不同 hardware vector length、對齊/非對齊 pointer、首個非 ASCII 出現位置與全 ASCII 的情況。若 SVE setup 或 predicate reduction 抵消收益，保留 NEON 即可。

### 4.4 `EscapeAscii` 的 printable-prefix scan

`EscapeAscii` 在 formatting 時會以 `take_while` 找到第一個需要 escape 的 byte。這是一個類似 `memchr` 的 closed-form boundary scan，可用 SIMD 一次分類 printable/escape byte，再找第一個不符合 lane。

收益取決於後續 formatting 是否主導成本；若字串很短或 escape 很常出現，scalar early exit 可能更快。應將 scan 單獨 benchmark，並在完整 `Display` benchmark 中確認沒有因 kernel 呼叫/狀態保存造成退化。

### 4.5 `[T]::contains` 寬 primitive specialization

位置：`library/core/src/slice/cmp.rs`。對 `u16/u32/u64`、有號整數、`f32/f64`、`usize/isize/char` 等，現有程式使用固定 lane count 的 branchless chunk reduction，明確是為 LLVM auto-vectorization 設計；一 byte 類型另有 `memchr` 路徑。

因此這不是低成本的「補 SIMD」工作。候選方案是建立 SVE prototype，對每個 block broadcast needle、compare、predicate-any；但必須與現有 auto-vectorized loop 比較。浮點只做 equality，不可引入不允許的 NaN 或 reassociation 語義。若現有 LLVM NEON 已接近記憶體頻寬，SVE 不一定有實際收益。

## 5. 容器與 retain 類候選

### 5.1 `VecDeque::retain_mut`

位置：`library/alloc/src/collections/vec_deque/mod.rs`。

表面上它與 `Vec::retain_mut` 都是 stable compaction，但不能直接套用 contiguous Vec kernel：

- logical sequence 可能跨越 allocation 尾端，必須處理一或兩個 physical slice；
- arbitrary `FnMut` 仍必須依 logical order exactly once 執行；
- 現有實作使用 `swap(idx, cur)`，ring index 與 overlap 語義要保持；
- panic 時 length、未決定元素與 drop 行為必須與 scalar 版本一致；
- `T` 可能需要 drop，不能只移動 byte 而忽略 destructor。

可行的研究方向是先把 predicate 結果寫入 mask，再對每個 physical segment 做 compact/copy，但這需要全新的 panic/drop guard 與 ring-index mapping。除非 benchmark 顯示大型、長期不 wrap 的 VecDeque 是重要 workload，否則優先級低於 slice boundary scan。

### 5.2 `String::retain`

位置：`library/alloc/src/string.rs`。它逐 UTF-8 code point 呼叫 `FnMut(char)`，並依 code point byte length 搬移資料。與 byte-oriented `Vec::retain_mut` 不同，任意 predicate 的結果不能批量計算，而且每個 char 的邊界與 output offset 依賴前面結果。

只有新增 closed-form API（例如固定 ASCII predicate）才適合 SIMD；不應對現有 generic `String::retain` 強行 vectorize。即使 predicate 對 ASCII 有規律，非 ASCII code point 與 panic guard 也使實作複雜。

### 5.3 `Vec::dedup_by` / `partition_dedup_by`

這些操作不適合通用 SIMD。predicate 取得可變 references，且文件允許透過修改 retained element 合併資料；後續比較可能依賴前一次 mutation。即使資料是 primitive，也不能在不改變 callback 呼叫順序與 aliasing 的情況下預先批量比較。

## 6. Iterator 與 reduction：為何通常不應特化

`Iterator::position`、`rposition`、`find`、`find_map`、`any`、`all` 等 generic 方法接受任意 closure。closure 可能讀寫外部狀態、panic、依呼叫次數產生不同結果；SIMD 批量執行會違反 exactly-once、in-order semantics。即使 iterator 最終來自 slice，trait method 本身通常無法安全識別可向量化 predicate。

`sum`、`product`、`min`、`max` 同樣不是通用低風險候選：

- arbitrary iterator 沒有連續 storage 保證；
- integer overflow/debug semantics 不能被不當 reassociation 改變；
- 浮點 reduction 的 associativity、NaN 與 signed zero 語義需要特別保留；
- slice iterator 的 count 等操作已經有 O(1) 或專用實作。

若未來要支援 SIMD reduction，較合理的方向是新增明確的 SIMD-friendly API/trait，或只對已知 primitive slice iterator 做專門化，而不是修改 generic `Iterator` 預設方法。

## 7. 已有優化、低收益或不建議重寫的 API

- `copy_from_slice`、`clone_from_slice`、`ptr::copy` 類操作應交給 memcpy/memmove 或既有 intrinsic；手寫 SVE 通常只會重複底層 runtime。
- slice fill 對 byte-replicable integer 已使用 `write_bytes`；其他 assignment loop 應先看 LLVM 是否已向量化。
- equality/ordering 與 primitive contains 已有專用路徑或 vectorizer-friendly chunking；只有 benchmark 證明現有 codegen 落後時才改。
- `str::count_chars` 已使用 aligned `usize`、unrolled chunks 與 byte-wise SWAR count。早期手寫 NEON 若不如該版本，應把它作為「不要重寫」的基準案例。
- `LinkedList` 與 BTree 類容器的主要成本是 pointer chasing 和 cache miss，SIMD 不能修復資料布局。
- substring search、完整 SIMD UTF-8 validation、通用排序/partition 屬於高複雜度專案，不應與單純 closed-form byte scan 混在第一批工作中。

## 8. 共同實作限制

### 編譯期選擇

AArch64 NEON 是基線能力；SVE 應以 `#[cfg(all(target_arch = "aarch64", target_feature = "sve"))]` 編譯期選擇。不要在這批標準庫候選中引入 runtime `getauxval` dispatch，除非另有明確的多版本 ABI/部署設計。

### const API

`trim_ascii_*`、`memchr` 等是 `const fn` 或有 CTFE 使用者。runtime SIMD 必須保留 scalar const-evaluable implementation，使用既有 `const_eval_select!` 類模式；不能因 assembly path 使 compile-time evaluation 失效。

### early exit 與 mask extraction

`any-match` 只代表 block 內存在結果，不代表第一個/最後一個 index。搜尋與 trim 必須明確提取最低或最高 set lane，並在 block 邊界與反向掃描上測試。對短資料，load、predicate setup、mask extraction 的固定成本常會超過 scalar loop。

### panic、drop、provenance

凡是接受 arbitrary closure 的 compaction，都必須保留 callback 次數、順序與 panic 後 vector observable state。對 `T` 需要 drop 的類型，byte-level compact 不能直接假定移動後可遺失 destructor。若使用 raw pointer 作為 panic guard 狀態，寫入 mask 後不得透過過期 aliasing tag 讀取；需要重新推導 pointer。SVE kernel 應只處理已證明適用的 lane width / no-drop 類型，並把 register 內搬移限制在 assembly。

## 9. 建議 benchmark matrix

每個候選至少測：

1. 長度：`0, 1, 2, 7, 15, 16, 31, 32, 63, 64, 127, 128, 1K, 4K, 16K, 1M`。
2. pointer：對齊、`+1` 非對齊、跨 cache line。
3. data shape：全 match、全 non-match、首/尾 match、每個 block 的 boundary match、隨機分布。
4. target：scalar、AArch64 NEON、SVE；分別記錄 compile flags 與硬體 vector length。
5. metric：ns/op、bytes/s、code size；對 early-exit API 另記錄實際掃描 byte 數。
6. correctness：空輸入、邊界 lane、非 ASCII、`0x0b` whitespace 差異、錯誤 index、const evaluation，以及 panic/drop 測試（適用時）。

threshold 應按 workload 分開決定。不要只用一個「大於 N 就走 SVE」的常數覆蓋所有 API；memchr、trim、transform 的 break-even point 不同。

## 10. 建議實作順序

1. 先做獨立 benchmark 與 correctness harness：`memchr/memrchr`、`trim_ascii_start/end`。
2. 以小範圍 NEON 與 SVE prototype 對照現有 SWAR/NEON codegen，確認 lane index 與 early exit。
3. 若結果穩定，再處理 UTF-8 ASCII prefix；不要一開始改完整 validator。
4. 接著評估 ASCII case conversion 與 `EscapeAscii`，先檢查 LLVM 是否已自動向量化。
5. 最後才考慮 VecDeque compaction；generic iterator、String retain、dedup 與 pointer-chasing container 不列入第一批。

**結論：** 最值得先投入的是「連續 byte buffer + 封閉分類 + 找邊界/索引」的 API，尤其 `trim_ascii_*` 與 `memchr/memrchr`。對 retain 類 generic closure，SIMD 的主要限制不是 compact 指令本身，而是 predicate、panic、drop 與 provenance 語義；對已經 vectorizer-friendly 的標準庫程式碼，必須以現有 codegen 為 baseline，不能因使用 SVE 指令就假設一定更快。
