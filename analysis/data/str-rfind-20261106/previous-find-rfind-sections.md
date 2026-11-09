# `str::find_zzz_char::*` / `rfind_zzz_char::*`(8 項):時間幾乎全在 core 的 SWAR `memchr`(16 B/輪,每輪約 4.2 cycles,0.26 cyc/B);本地 NEON 原型 −65…−74%(相對 2026-10-12 基線,未在 `07e526db9df` 上重測),並帶動 `contains`/`find_underscore`/`splitn` 等 35 項;但密集命中的 `split(' ')` 在 harness 上回退——已證實是 bench 重複同一文字讓分支預測器背誦所致,在不可背誦輸入上 NEON v3 反而 −22%;取捨待決,原型已還原

- 日期:2026-10-12
- 分析對象:`library/alloctests/benches/str.rs:331-332`(`s.find('\u{1F4A4}')` / `s.rfind(..)`,× `short_ascii`(64 B)/`short_mixed`(65 B)/`short_pile_of_poo`(65 B)/`long_lorem_ipsum`(2551 B);`💤` = `F0 9F 92 A4`,四個字串都不含 `0xA4`,每次都掃完整串)
- 實現:`CharSearcher::next_match`(`str/pattern.rs:434`)→ `memchr(last_byte)`(`slice/memchr.rs`,純 Rust SWAR:對齊前綴逐位元組 + 每輪 2×`usize` 的 `contains_zero_byte` + 尾段逐位元組);`rfind` 對稱走 `memrchr`
- 平臺:本機 HiSilicon aarch64,stage1,rustflags 為空。**注意**:bench 二進位動態連結 libstd,`memchr_aligned` 經 PLT 呼叫、不內聯

## 基線(min of 3;2026-10-12 的樹)

| | find | rfind |
|---|---|---|
| short_ascii / mixed / poo | 12.43 / 12.77 / 13.02 | 12.74 / 13.24 / 13.91 |
| long_lorem_ipsum(2551 B) | 203.34(0.23 cyc/B);`07e526db9df` 上 231.22(0.26 cyc/B) | 212.82;`07e526db9df` 上 244.15 |

## 探針:memchr 實作對照(ns/次,不含 harness 迴圈)

| 輸入 | `str::find` | core SWAR | glibc | 可移植 `[u8;16]` 分塊 | 手寫 NEON |
|---|---|---|---|---|---|
| 64–65 B | 8.0–8.2 | 7.0–7.1 | 5.2 | 11.6–12.8 | **3.0–3.2** |
| 2551 B | 205 | 213 | 60 | 389 | **58** |

`CharSearcher` 本身只佔 ~1 ns。可移植分塊寫法 LLVM 未有效向量化,反而更慢——不用 intrinsics 的路線不可行。

## 樹內原型的四個版本(`core/src/slice/memchr.rs`,`aarch64` + `neon` 才啟用)

- **v1**:64 B/輪(4×`cmeq` + `orr` + `umaxv`),命中後 16 B 迴圈 + 逐位元組定位,尾段重疊讀最後 16 B。
- **v2**:先單獨檢查首 16 B,並用 `shrn` 壓成 64-bit 遮罩、`trailing_zeros/4` O(1) 定位。**退步**:向量→GPR 的搬移(`shrn`+`fmov`)在本機昂貴,且被放上每次呼叫的關鍵路徑(短無命中 3.8 → 5.5 ns,`split_space_char::short_ascii` +48%)。
- **v3**:先以 GPR SWAR 檢查首/末 8 B(精確零位元組式 `!(((x & 0x7f..) + 0x7f..) | x | 0x7f..)`,無 `contains_zero_byte` 在零位元組上方的假陽性,故 `leading_zeros` 找末次命中也正確),未中再進 v1 本體(自偏移 8 起)。
- **v4**:v3,但 NEON 自偏移 0 起(64 B 輸入可走一個 64 B 區塊)。

正確性(四版皆過):core `memchr` 測試 15 項、alloc `str` 相關 422+151+140+24 項;差分 342 730 例(長度 0–200 × 起點偏移 0–15 × 目標位置/0–2 次出現 × `find`/`rfind`/`contains`,另含 `💤` 於各位置)+ 隨機背景 226 500 例(背景取與目標差 1 bit、`0x00`/`0x01`/`0x7f` 等易觸發借位的位元組;`contains` 用任意位元組)。

## harness A/B(alloctests 全 `str::` 129 項,min of 3)

| | base | v1 | v3 | v4 |
|---|---|---|---|---|
| `find_zzz_char::long` | 203.34 | 56.08(−72%) | 56.08 | 55.35(−73%) |
| `find_zzz_char::short_*` | 12.4–13.0 | 3.8(−70%) | 5.5(−57%) | 4.1–4.5(−66%) |
| `rfind_zzz_char::long` / `short_*` | 212.8 / 12.7–13.9 | −74% / −72% | −74% / −58% | −74% / −67% |
| `contains_bang_*::long` | 204–231 | −69…−71% | 同 | 同 |
| `find/rfind_underscore_char::long` | 229 / 243 | −76% / −78% | 同 | 同 |
| `splitn_space_char::*` | 65–77 | −8…−13% | −21…−26% | −14…−22% |
| **`split_space_char::long`** | 2825.5 | **+12.8%** | **+12.5%** | **+32.4%** |
| **`split_terminator_space_char::long`** | 2828.1 | +12.4% | +13.3% | +32.4% |
| **`rsplitn_space_char::short_ascii`** | 102.2 | +18.9% | +12.9% | +21.1% |

v4 總計:改善 35 項(≤ −3%)、回退 7 項(≥ +3%)、持平 87 項。回退的 7 項全是「空白分割、密集命中」型。

## 回退的機理:分支預測器背誦了 bench

`split_space_char::long`:perf 中 81–83% 在 `memchr_aligned`。base IPC 4.17、誤判 0.18/千指令;v1 IPC 3.21、誤判 2.55/千指令。以固定工作量探針(lorem 378 段,73% 的段長 ≤ 7 B)量每次 `memchr` 呼叫:

| 每呼叫 | 同一段文字重複(= harness) | 64 份不同文字輪流(詞彙表隨機重排,統計相同) |
|---|---|---|
| base | 20.6 cyc,誤判 0.008 | **41.3 cyc,誤判 1.13** |
| v1 | 20.9,0.09 | 48.5(+17%),1.19 |
| v3 | 22.7,0.24 | **32.2(−22%)**,0.57 |
| v4 | 26.8,0.31 | 34.0(−18%),0.56 |

base 在 harness 上幾乎不誤判,是因為 bench 對同一段 2551 B 文字重複數十萬次,每輪 378 次呼叫的分支序列完全相同,base 每次呼叫的大量逐位元組分支為長歷史預測器提供了足夠脈絡去背下整個序列;換成不重複的輸入,base 每次呼叫誤判 1.13 次、成本翻倍。v3 的「首 8 B 是否命中」分支(27% 的段 > 8 B)本質上不可預測,但每次呼叫指令數只有 base 的 57%(52.6 vs 91.9),在真實輸入上勝出。**harness 上的回退是 bench 設計的假象;真實輸入上 v1 確實回退(+17%),v3/v4 改善 18–22%。**

## 判斷

1. **std 有可落地的收益**:core `memchr`/`memrchr` 加 aarch64 NEON 路徑,稀疏/無命中情形 3–4×(短串受限於呼叫固定開銷,長串追平 glibc),惠及 `str::find/rfind/contains(char)`、`[u8]::contains`、`split`/`splitn` 等。x86(i7-12700)上 SIMD 化收益與本機相當(16 B SSE2 下,長串 2 551 B 時 485 → 143,3.4×),且對密集 split 不構成回退(見「x86_64 對比」小節)。
2. **待決取捨**(不替使用者選):v1 短串最快但真實密集輸入回退 17%;v3/v4 真實密集輸入改善,但 harness 的 `split_space_char` 系列顯示 +12…+32%,reviewer 會看到,需附「不可背誦輸入」的對照數據說明。若要落地,建議同時為 `str` bench 新增不重複輸入的 `split` 項,否則 harness 會持續獎勵 SWAR 的可背誦分支。
3. 落地時需把 SWAR 本體拆成獨立函式以 `cfg` 二選一(原型為了通過 `deny(warnings)` 暫用 `allow(unreachable_code)`)。
4. 方法論:v2 的失敗(向量→GPR 搬移昂貴)與 v3 的成功(GPR SWAR 先篩)都說明,本機上「短距離命中」應盡量留在通用暫存器;另一次教訓是我在 v2→v3 之間曾憑猜測迭代修法,直到剖析每呼叫誤判數才找到真因。

```text
# 原型(已還原,memchr.rs 與 HEAD 相同):/tmp/btree_bench/strfind/memchr.rs.{orig,neon(v1),neon2,neon3,neon4}
# harness 結果:/tmp/btree_bench/strfind/res_{base,neon,neon2,neon3,neon4}.txt;對照 cmp{,2,3,4}.txt
# 探針:/tmp/btree_bench/strfind/{m.rs(memchr 實作對照), diff.rs, diff_rand.rs(差分), dense.rs, dense2.rs(每呼叫成本;dense2 的 k=64 為不可背誦輸入)}
# 二進位與對應 libstd:/tmp/btree_bench/strfind/{bin_,lib_}{orig,neon,neon3}(lib_neon4 亦在)
```

## x86_64 對比(實測:i7-12700 vs 本機,上游 07e526db9df)

- x86:i7-12700 P 核(`taskset -c 8`,約 4.3–4.6 GHz);aarch64:core 48(2.9 GHz)。只比 cycles/iter。兩邊 bench 都經 PLT/GOT 呼叫 libstd.so 內的 core SWAR `memchr_aligned`。

### 底數(base.tsv)

| bench | aarch64 cyc/iter | x86 cyc/iter | 比值 | IPC a64 / x86 |
|---|---:|---:|---:|---|
| `find_zzz_char::long_lorem_ipsum` | 669.9 | 457.9 | **1.46** | 3.42 / 6.06 |
| `rfind_zzz_char::long_lorem_ipsum` | 705.6 | 480.0 | 1.47 | 3.54 / 6.11 |
| `contains_bang_char::long` / `find_underscore_char::long` | 668.5 / 665.2 | 454.1 / 459.7 | 1.47 / 1.45 | 3.4 / 6.1 |
| `find_zzz_char::short_{ascii,mixed,poo}` | 36.5–37.6 | 36.4–38.6 | 0.97–1.02 | 4.7–5.0 / 4.8 |
| `rfind_zzz_char::short_*` | 36.9–39.1 | 39.4–40.6 | 0.93–0.98 | 5.3–5.7 / 5.3–5.5 |
| `split_space_char::long_lorem_ipsum` | 7 402 | 8 980 | **0.82** | 4.45 / 3.79 |
| `split_space_char::short_ascii` | 206.2 | 277.1 | 0.74 | 4.31 / 3.44 |
| `splitn_space_char::*` | 163–206 | 198–229 | 0.81–0.90 | 4.5–4.7 / 4.1–4.5 |
| `rsplitn_space_char::*`(非 poo) | 286–320 | 326–368 | 0.87–0.89 | 4.7–4.9 / 4.7 |

- 三個區間:**長串無命中 1.46×**(本機吃虧)、**短串無命中 ≈1.0**、**密集命中 split 0.74–0.90**(x86 吃虧)。

### 熱點與機器碼

- `find_zzz_char::long`:兩邊 98–99.6% 在 `memchr_aligned`。SWAR 主迴圈每 16 B:
  - aarch64 **14 條**:`ldp` + `eor`×2 + `sub`×2 + `orr`×2 + `and` + `bics` + 3 條迴圈簿記 + 2 分支。
  - x86 **18 條**:兩次 `mov` 載入、`xor`×2、`mov`×2(複製常數,被消除)、`sub`×2、`or`×2、`and`×2、`cmp/jne`、`add`、`cmp/jbe`。
  - 每輪實測 aarch64 ≈ 4.2 cycles(IPC 3.4),x86 ≈ 2.9(IPC 6.1)。
- `split_space_char::long`(378 次呼叫/iter):
  - aarch64 `memchr_aligned` 84.7% + 閉包 13.4% + PLT 1.5%。
  - x86 `memchr_aligned` 71.9% + 閉包 28.1%。x86 有 19% 樣本在函數入口 `push %r14; push %rbx`(SysV 呼叫者保存暫存器不夠用,要壓棧)。aarch64 不需要保存任何暫存器(AAPCS64 有 18 個臨時暫存器)。

### 隔離探針

1. **整數 ALU 吞吐**(`alu.rs`,12 條獨立 `eor`/`orr` + 迴圈):aarch64 3.35 cycles/iter,x86 2.94。另一組 8 ALU + 2 `cmp` + 3 分支:aarch64 2.91。
   - 本機約 3.6–4.0 條整數 ALU/cycle,x86 約 4.4 以上(5 個 ALU 埠,`cmp`+`jcc` 宏融合)。
   - SWAR 每輪本機 11–12 條 ALU 指令 → 下限約 3 cycles,實測 4.2。x86 宏融合後約 14 uop,5 埠 → 2.8,實測 2.9。
2. **memchr 實作對照**(`mc.rs`,cycles/呼叫,三次取最小):

   | 情形 | core SWAR a64 / x86 | crate 預設 a64 / x86(x86 = AVX2) | 16 B 向量同寬 a64 NEON / x86 SSE2 | glibc a64 / x86 |
   |---|---:|---:|---:|---:|
   | 64 B 無命中 | 19.4 / 23.6 | 12.9 / 12.5 | 13.0 / 11.4 | 12.1 / 9.9 |
   | 2 551 B 無命中 | 590.7 / 485.4 | 159.1 / 88.7 | 160.0 / 143.4 | 172.7 / 78.9 |
   | 命中間距 3 B 鏈式 | **17.4 / 21.4** | 26.9 / 21.9 | 26.9 / 17.9 | 31.0 / 22.6 |
   | 間距 6 B | 21.6 / 28.2 | 26.8 / 21.8 | 26.8 / 18.0 | 26.2 / 22.4 |
   | 間距 12 B | 28.6 / 33.7 | 26.4 / 21.7 | 26.4 / 17.7 | 26.5 / 22.3 |
   | 間距 24 B | 24.2 / 35.1 | 32.5 / 21.3 | 32.0 / 22.5 | 26.2 / 21.9 |
   | 間距 96 B | 47.5 / 56.0 | 34.5 / 25.5 | 34.2 / 26.8 | 31.9 / 23.3 |

   - core SWAR 長串無命中:本機每 cycle 慢 1.22×(探針文字使 x86 每次呼叫多 1.4 次誤判,bench 上 x86 不誤判,所以 1.46×)。
   - core SWAR 短間距密集命中:**x86 反而慢 1.2–1.45×**,與 `split_space_char` 的 0.74–0.82 對應。x86 每次呼叫多 `push`/`pop` 兩個暫存器,字節前綴 / 尾巴迴圈也更貴(x86 尾巴 `inc %rdx` 樣本 21.7%)。
   - x86 上 core SWAR 長串 0.18 cycles/B(本機 0.26)。同為 16 B 向量時,crate 在 x86 SSE2 上 2 551 B 為 143 cycles,本機 NEON 160。SIMD 化在 x86 上的收益(485 → 143,3.4×)與本機相當(591 → 160,3.7×)。
   - 密集命中 `split` 回退的成因是 crate 的向量→GPR 固定地板。同寬同算法下,本機 NEON 地板 26.4–26.9,x86 SSE2 17.7–18.0 cycles/呼叫,本機多約 9 cycles。這是 S1/S2(無 `movemask`,`shrn`+`fmov` 搬到 GPR)的實測代價;`S2-mask-floor` 的同寬 16 B 密集命中鏈為 27.0 vs 16.6 cycles/呼叫(1.63×)。同一復現的長串無命中為 aarch64 218.1 vs x86 277.2 cycles(不展開的單 16 B 迴圈),與本表 crate 64 B 展開迴圈的 160.0 / 143.4 量的不是同一形態。
   - x86 的 SSE2 版在 d = 3 B 時也與 core SWAR 持平(17.9 vs 21.4)。在 x86 上,向量化 memchr 對密集 split 不構成回退;本機上構成回退(26.9 vs 17.4)。

### 差異來源逐項

1. **LLVM IR / 中端:無差異跡象。** 兩邊 `memchr_aligned` 控制流相同(字節前綴 → 2×usize SWAR → 字節尾巴)。
2. **後端 codegen:兩向各有一項。** aarch64 用 `ldp` + `bics`(14 條/輪),x86 多 2 條 `mov` 複製常數(18 條/輪,被消除)。x86 的 `memchr_aligned` 要保存兩個被呼叫者保存暫存器,短呼叫吃虧。
3. **libc:不在 bench 路徑上。** 參考值:glibc `memchr` 2 551 B 本機 172.7、x86 78.9 cycles(本機為通用實作,x86 為 AVX2/EVEX)。
4. **記憶體配置:無關。** split 計數不配置。
5. **微架構:**
   - 長串主因是整數 ALU 吞吐(B7,成因推測)。本機約 4/cycle、x86 約 5 + 宏融合,SWAR 每 16 B 4.2 vs 2.9 cycles;`B7-alu-throughput` 量到 3.9 對 5.7 條/cycle。
   - 誤預測兩邊都低(≤0.36/千指令)。
6. **主頻:** 4.3–4.6 / 2.9 ≈ 1.5×。長串 ns 差 2.2×(231 vs 106 ns)= 1.46 × 1.5。

### 上游變化

- `0439f4ef09a` 等 4 個提交(#159784,2026-08-08 合入):`memchr` 對結果加 `assert_unchecked(index < text.len())`,`memrchr` 改成 `#[inline]` 外殼加同樣斷言、本體移到 `memrchr_aligned`。`memchr_aligned` / `memrchr_aligned` 的 SWAR 迴圈未改。
- 效果:本章基線(2026-10-12,日期晚於該提交合入)`find_zzz_char::long_lorem_ipsum` 203.34、`rfind` 212.82 ns → `07e526db9df` 231.22 / 244.15 ns(3 次最小)。本章基線已含該提交,這段差距未找到相關提交,可能來自工具鏈或佈局。

### 未修改代碼上的量化

- bench(3 次最小,ns/iter):aarch64 `find_zzz_char::long_lorem_ipsum` 231.22、`rfind_zzz_char::long_lorem_ipsum` 244.15;x86 98.28 / 103.62。
- perf:aarch64 `memchr_aligned` 99.58%,annotate 70.73% 在 `add x8, x8, #0x10`、22.59% 在 `sub x17, x13, x10`(16 B/輪 SWAR 主迴圈);x86 `memchr_aligned` 98.91%。熱點與正文相同。
- base.tsv 669.9 cycles / 2551 B = 0.26 cyc/B,每 16 B 約 4.2 cycles(正文基線 0.23 cyc/B)。標題的「4.3 B/cycle」改為現值。
- 本地 NEON 原型 v1–v4 的 −65…−74% 是相對 203.34 ns 基線;未在 `07e526db9df` 上重測。

歸類:B7 整數 ALU 吞吐(成因推測;本機約 4/cycle,x86 約 5 + 宏融合,長串 SWAR)為主;S1/S2(向量化版本的固定地板,本機多約 9 cycles);N2(glibc 通用 `memchr`,僅參考);N3 反向(x86 SysV 保存暫存器使短呼叫吃虧)。

### 最小復現

- [`B7-alu-throughput`](analysis/repro/B7-alu-throughput/)(已復現):8 條獨立 add + 計數 + 分支 aarch64 2.335 對 x86 1.587 cycles/輪(3.9 對 5.7 條 ALU/cycle);12 nop + 計數 + 分支兩邊約 6 條/cycle。成因(整數 ALU/分支埠少)為推測。
- [`S2-mask-floor`](analysis/repro/S2-mask-floor/)(部分復現):同寬 16 B memchr 形 find 的密集命中鏈 aarch64(`cmeq`→`shrn`→`fmov`→`ctz`)27.0 vs x86(`pcmpeqb`→`pmovmskb`→`tzcnt`)16.6 cycles/呼叫,地板差成立;長串無命中的不展開迴圈 aarch64 218.1 vs x86 277.2,與 crate 展開迴圈不可直接比。

```text
# 本機與遠程同路徑:/tmp/xdiff/work/c71/
#   mc.rs   ./mc <core|crate|v16|libc> <nomatch LEN|chain D>;build.sh(memchr 2.8.3 rlib + mc);run.sh <core>(IMPS=v16 只跑同寬向量版)
#           結果:a64.txt、x86.txt、a64_v16.txt(遠程 bt0lfbdeo 輸出)、x86_v16.txt
#   alu.rs  ./alu [br]:整數 ALU 吞吐
# perf:/tmp/xdiff/work/g5/str__{find_zzz_char__long_lorem_ipsum,split_space_char__long_lorem_ipsum,split_unicode_ascii}.{x86_64,aarch64}.data
```

# `str::find_zzz_char` 續:`07e526db9df` 仍是 core 的 SWAR `memchr`;本地原型改用 `memchr` crate 2.8.3 的 aarch64 NEON 搜尋(`arch::generic::memchr::One` 移植進 core)——無命中 −53…−80%,不可背誦的密集長文 −37%;但 crate 的做法對「每 3–12 B 一次命中」有 ~26 cycles/呼叫的固定地板,短文密集分割(64 B)在任何輸入上都回退 ~45%

- 日期:2026-10-13
- 來源:`~/.cargo/registry/.../memchr-2.8.3/src/arch/{generic,aarch64/neon}/memchr.rs` + `vector.rs` 的 `uint8x16_t` 實作;移植進 `core/src/slice/memchr.rs` 為 `mod neon`,`memchr_aligned`/`memrchr` 在 `aarch64 && neon` 下轉發(`< 16 B` 走既有 `memchr_naive`/`rposition`,同 crate 的 byte-by-byte 門檻)
- 與前章 v1/v3 的差別:crate 先 `search_chunk` 首 16 B(含 `shrn`+`fmov` 取遮罩),再把游標對齊到 16 B 邊界進 64 B 主迴圈(`vld1q` 無對齊要求,crate 註明對齊載入無可觀測差異),命中後用 `rbit`+`clz`(`trailing_zeros >> 2`)O(1) 定位;無 GPR 先篩。
- 正確性:core `memchr` 15 項、alloc `str` 相關 422+151+140+24 項全過;差分 342 730 + 隨機背景 226 500 例全過(與前章相同探針)。

## 移植保真度

| 64 B 無命中 | ns | 2551 B 無命中 | ns |
|---|---|---|---|
| crate 本尊(`#[inline(never)]`) | 4.14 | | 48.9 |
| crate 本尊(內聯進呼叫端) | 4.50 | | 51.4 |
| libstd 移植版 `[u8]::contains`(經 PLT) | 6.21 | | 61.9 |

主迴圈彙編逐條同形;libstd 版每呼叫多 ~1.7 ns、長串多 ~10 ns,來自 `memchr_aligned` 經動態 libstd 的 PLT 呼叫與 `[u8]::contains` 的分派,不是移植差異。

## harness(alloctests `str::` 129 項,min of 3,相對 base)

| | crate 移植 | 前章 v1 | 前章 v3 |
|---|---|---|---|
| `find_zzz_char::long` / `rfind` | **−75% / −76%** | −72% / −74% | −72% / −74% |
| `find_zzz_char::short_*` / `rfind` | −53…−55% / −57…−60% | −70% / −72% | −57% / −58% |
| `contains_bang_char::long` / `find_underscore::long` / `rfind_underscore::long` | **−79% / −78% / −80%** | −71% / −76% / −78% | 同 v1 |
| `split_space_char::long` / `split_terminator::long` | +17% / +18% | +13% / +12% | +13% / +13% |
| `split_space_char::short_ascii` / `split_terminator::short_ascii` | **+43% / +48%** | −6% / −9% | +20% / +12% |
| `rsplitn_space_char::short_mixed` | **+61%** | −2% | +26% |
| 總計(≤−3% / ≥+3% / 其餘) | 31 / 15 / 83 | 35 / 7 / 87(v4) | — |

另兩項 `bench_contains_equal` +6.7%、`bench_contains_short_long` +5.4%:perf 顯示兩者走 `memcmp` 與 `Pattern::is_contained_in`,**memchr 零樣本**,為重建後佈局偏移(v1/v3/v4 三輪皆 ±0.2%)。

## 密集命中:crate 做法的固定地板

不可背誦輸入(64 份同統計特性的不同文字輪流),每次 `memchr` 呼叫:

| | 2551 B 文字 | 64 B 文字 |
|---|---|---|
| base(SWAR) | 41.4 cyc(誤判 1.13/呼叫) | 18.8 cyc |
| v3(GPR 先篩 8 B + NEON) | 32.2 | **16.4** |
| **crate** | **26.1**(誤判 0.008) | **27.1**(+45%) |

同一文字重複(= harness 形):base 20.7 / 17.1,crate 25.6 / 26.9。**crate 無論輸入長短、可否背誦,都是平坦的 26–27 cycles/呼叫**——分支幾乎零誤判,代價是每次呼叫固定走一遍 `ld1`→`cmeq`→`shrn`→`fmov`→`rbit`→`clz` 的向量→GPR 延遲鏈。

用固定間距的命中鏈(`lat.rs`,4 KB 緩衝每 d 個位元組一個空白,從上次命中 +1 續搜,可預測)直接量這條地板:

| 命中間距 d | 3 B | 6 B | 12 B | 24 B | 48 B |
|---|---|---|---|---|---|
| crate 本尊鏈式呼叫 | 26.2 | 26.7 | 26.8 | 31.7 | 33.2 |
| 逐位元組 `position` 鏈式 | **7.0** | **10.0** | **16.1** | 28.1 | 52.2 |
| libstd base `split` | 17.5 | 21.6 | 28.2 | 26.9 | 38.5 |
| libstd crate 移植 `split` | 25.0 | 25.6 | 25.6 | 36.2 | 35.1 |

**d ≤ 12 B 時逐位元組比 crate 快 1.7–3.7×**;crate 在 d ≥ 24 才開始領先。lorem 的 378 段中 73% 間距 ≤ 7 B,所以 `split(' ')` 類負載正落在 crate 的劣勢區——這是 crate 作法(無短距離 GPR 先篩)的固有特性,不是移植誤差。

## 判斷

1. crate 2.8.3 的 NEON `One` 可直接移植進 core,稀疏/無命中情形在所有長度與方向上是四個版本中最快或持平(長串 −75…−80%),且分支行為對輸入不敏感(誤判 ~0)。
2. **它在本機對短距離密集命中有結構性回退**(x86 SSE2 同算法無此回退,見「x86_64 對比」小節):任何輸入下 ~26 cycles/呼叫地板,`split`/`splitn`/`rsplitn` 在短文字上回退 43–61%(harness)與 45%(不可背誦探針);長文字密集則 −37%(不可背誦)/ +17%(harness,背誦效應)。前章 v3 的「首/末 8 B GPR 先篩」正是補這個洞的手段(短文密集 −13%),但它在無命中短串上比 crate 慢 0.4–1 ns。
3. 若要落地,本機建議形態是 **crate 主體 + v3 的 GPR 首/末字先篩**(x86 不需要先篩)(兩者正交:先篩只在首 8 B 命中時返回,未中則進 crate 的 `search_chunk`/主迴圈);本章未實測該組合。取捨仍需使用者決定——尤其 `split` 系列 harness 數字會顯示回退,送審時需附不可背誦探針的對照。
4. 工作樹已還原(`memchr.rs` 與 HEAD 相同);crate 移植版保存在 `/tmp/btree_bench/strfind/memchr.rs.crate`(含 `allow(unreachable_code)` 權宜寫法,落地前需改為 `cfg` 二選一)。

```text
# 移植版:/tmp/btree_bench/strfind/memchr.rs.crate;harness 結果 res_crate.txt,對照 cmp5.txt
# 探針:cw.rs(crate 本尊 vs libstd,PLT 成本), fid.rs(保真度), dense3.rs(短文不可背誦), lat.rs(固定間距命中鏈)
# crate 編譯:probe/libmemchr.rlib(2.8.3,features std+alloc);libstd:lib_crate/
```

## x86_64 對比(實測:i7-12700 vs 本機,上游 07e526db9df)

- 本章的 crate 移植版只存在於本機實驗樹,兩邊 bench 二進位都是 core SWAR。harness 底數見前章 x86 小節:長串無命中 1.46×、短串 ≈1.0、密集 split 0.74–0.90。
- 本小節用同一個 memchr 2.8.3 原始碼在兩台機器上編譯探針(`mc.rs`),直接比較 crate 做法的跨平臺表現。x86 有兩個版本:
  - `memchr::memchr` 預設路徑,運行時選 AVX2,32 B 向量;
  - 強制 `arch::x86_64::sse2::memchr::One`,16 B 向量,與本機 NEON `arch::aarch64::neon::memchr::One` 同寬、同算法。

### 探針結果(cycles/呼叫,三次取最小;x86 `taskset -c 8`、本機 core 48)

| 情形 | 本機 NEON `One` | x86 SSE2 `One` | 比值 | x86 AVX2(預設) | core SWAR 本機 / x86 |
|---|---:|---:|---:|---:|---:|
| 64 B 無命中 | 13.0 | 11.4 | 1.14 | 12.5 | 19.4 / 23.6 |
| 2 551 B 無命中 | 160.0 | 143.4 | 1.12 | 88.7 | 590.7 / 485.4 |
| 命中間距 3 B 鏈式 | **26.9** | **17.9** | 1.50 | 21.9 | 17.4 / 21.4 |
| 間距 6 B | 26.8 | 18.0 | 1.49 | 21.8 | 21.6 / 28.2 |
| 間距 12 B | 26.4 | 17.7 | 1.49 | 21.7 | 28.6 / 33.7 |
| 間距 24 B | 32.0 | 22.5 | 1.42 | 21.3 | 24.2 / 35.1 |
| 間距 96 B | 34.2 | 26.8 | 1.28 | 25.5 | 47.5 / 56.0 |

- 本機 crate 地板 26.4–26.9 cycles,與本章正文 `lat.rs` 的 26.2–26.8 一致。探針可信。
- 誤預測兩邊都 ≤0.023 次/呼叫,地板不是分支造成的。

### 差異來源逐項

1. **LLVM IR / 中端:** crate 的 `One::find` 兩邊都由 target 專用 intrinsic 寫成(NEON / SSE2),IR 本就不同,但算法相同:首 16 B → 對齊 → 64 B 主迴圈 → 遮罩定位。
2. **後端 codegen / ISA:主因(S1)。** 命中後取位置:
   - x86:`pcmpeqb` → `pmovmskb` → `tzcnt`,一條指令把向量比較結果壓成 GPR 位遮罩。
   - 本機無 `movemask`,要 `cmeq` → `shrn` → `fmov` → `rbit` → `clz` → `>>2`。
   - 同寬同算法下,短距離命中每次呼叫本機多 **8.5–9.0 cycles**(26.4–26.9 vs 17.7–18.0)。
3. **libc:不在路徑上。** 參考:glibc 2 551 B 本機 172.7、x86 78.9。
4. **記憶體配置:無關。**
5. **微架構:**
   - 向量→GPR 延遲(S2)疊在第 2 項上,共同構成 9 cycles 地板差。本章未再把 `shrn`/`fmov` 各自的延遲拆開。 `S2-mask-floor` 的同寬 16 B memchr 形 find 密集命中鏈:aarch64(`cmeq`→`shrn`→`fmov`→ctz)27.0 vs x86(`pcmpeqb`→`pmovmskb`→`tzcnt`)16.6 cycles/呼叫(1.63×),地板差成立。
   - 長串無命中同寬下只差 1.12×(160 vs 143):本機 16 B NEON 迴圈吞吐接近 x86 SSE2。 這是 crate 的 64 B 展開迴圈;`S2-mask-floor` 不展開的單 16 B 迴圈為 aarch64 218.1 vs x86 277.2 cycles(0.78×,x86 每 16 B 1.74 cycles 且每呼叫 1 次退出誤預測),兩者形態不同,不可直接比。
   - x86 AVX2 再快 1.6×(88.7),這是向量寬度(本機 NEON 只有 16 B)。本機 SVE-256 若用上可對標(未測)。
6. **主頻:** 約 1.5–1.6×,另計。

### 跨平臺結論

- crate 對短距離密集命中的結構性回退只出現在本機,x86 上沒有。
  - x86 SSE2 `One` 在間距 3–12 B 時 17.7–18.0 cycles,比 core SWAR(21.4–33.7)還快。
  - 回退是本機 ISA / 微架構特有的(S1/S2),不是 crate 算法本身的問題。
- 「crate 主體 + v3 的 GPR 首/末字先篩」是**本機專用**的補洞。x86 上的 SIMD memchr 不需要先篩也不會回退。
- 若 std 重新接受架構特化 memchr,x86 的取捨比本機簡單:同寬下長串 3.4×(485 → 143),短密集也改善。

### 上游變化

- `0439f4ef09a` 等 4 個提交(#159784,2026-08-08 合入):`memchr` 結果加 `assert_unchecked`,`memrchr` 拆成 `#[inline]` 外殼 + `memrchr_aligned`;SWAR 迴圈未改。本章基線(2026-10-13)晚於該提交合入。
- 本章的 crate 移植版是本地原型,在 `07e526db9df` 上要改接 `memchr_aligned` / `memrchr_aligned`(`memrchr` 已是外殼);未在 `07e526db9df` 上重測。`07e526db9df` 的 `find_zzz_char::long_lorem_ipsum` 為 231.030 ns(base.tsv)。

歸類:S1(無 `movemask`,向量→位遮罩要多條指令)為主;S2(向量→GPR 延遲);N2(glibc 通用 `memchr`,參考)。長串的 1.8× 是 x86 AVX2 32 B 對本機 NEON 16 B 的向量寬度差,不屬 S4(每 cycle 載入次數)。

### 最小復現

- [`L11-movemask`](analysis/repro/L11-movemask/)(已復現):`bitcast <16 x i1> → i16` 在 x86 為一條 `pmovmskb`;AArch64(含 `+sve`)為 `cmlt` + 載入位權常數 + `and` + 3×`addp` + `umov`,共 7 條;只判非零時 AArch64 改走 `addp d` + `fmov`。僅 IR 形態;本章 crate 用的是 `shrn`+`fmov` 路徑。
- [`S2-mask-floor`](analysis/repro/S2-mask-floor/)(部分復現):同寬 16 B memchr 形 find 的密集命中鏈 aarch64 27.0 vs x86 16.6 cycles/呼叫(1.63×),地板差成立;長串無命中在不展開的單 16 B 迴圈上為 218.1 vs 277.2(0.78×,aarch64 較快),與本章 crate 64 B 展開迴圈的 1.12× 不是同一形態。

```text
# 本機與遠程同路徑:/tmp/xdiff/work/c71/(與 c71 共用)
#   mc.rs  ./mc <core|crate|v16|libc> <nomatch LEN|chain D>;v16 = x86 sse2::memchr::One / aarch64 neon::memchr::One
#   build.sh 以 2.8.3 原始碼建 libmemchr.rlib;run.sh <core>;IMPS=v16 ./run.sh <core>
#   結果:本機 x86.txt、x86_v16.txt;遠程 a64.txt、a64_v16.txt
```

