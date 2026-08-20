# `bench_read_slice` x86_64 / aarch64 彙編對比與性能熱點分析

- 日期：2026-08-12
- 測試機器：HiSilicon aarch64（CPU part `0xd02`），2.9 GHz，L1d 64K，SVE VL = 256-bit（實測 `rdvl` = 32 字節）
- 工具鏈：`rustc 1.98.0-nightly (01dfd7924 2026-06-15)`，`-O`
- 分析對象：`library/alloctests/benches/io.rs` 中的 `bench_read_slice`

## Benchmark 代碼

```rust
#[bench]
fn bench_read_slice(b: &mut test::Bencher) {
    let buf = [5; 1024];
    let mut dst = [0; 128];

    b.iter(|| {
        let mut rd = &buf[..];
        for _ in 0..8 {
            let _ = rd.read(&mut dst);
            test::black_box(&dst);
        }
    })
}
```

`<&[u8] as Read>::read` 本質是 `copy_from_slice`。由於 `rd` 的長度可靜態推導（1024→896→…→128，每次恰好拷 128 字節），兩個平臺上 LLVM 都把 `min`/`split_at`/`Result` 全部常量摺疊，將整個閉包內聯成 **8 段展開的 128 字節直線拷貝**，無分支、無函數調用，段間夾着 `black_box` 的空 asm 塊。

分析方法：把閉包體抽成 `#[inline(never)]` 的獨立函數（語義一致），用 `rustc -O --emit asm` 分別生成兩個平臺的彙編；再單獨編譯完整 bench 二進制在本機用 perf 實測。

## 彙編對比

### aarch64（NEON 基線）

`ldp`/`stp` 成對搬運兩個 128-bit q 寄存器，**每條指令 32 字節，每個 128 字節塊 8 條訪存指令**：

```asm
ldp  q0, q1, [x0, #64]      ; 一條指令載入 32 字節
stp  q0, q1, [x1, #64]
ldp  q0, q2, [x0, #96]
stp  q0, q2, [x1, #96]
ldp  q1, q0, [x0]
stp  q1, q0, [x1]
ldp  q2, q0, [x0, #32]
stp  q2, q0, [x1, #32]
//APP                        ; black_box
//NO_APP
str  x8, [sp, #8]           ; black_box 迫使 dst 指針每輪落棧
ldr  x10, [sp]              ; 並重新載入
```

### x86_64（基線 SSE2）

`movups` 每條只搬一個 xmm（16 字節），**每個 128 字節塊 16 條訪存指令**，是 aarch64 的兩倍：

```asm
movups  112(%rdi), %xmm0
movups  %xmm0, 112(%rsi)
movups  96(%rdi), %xmm0
movups  %xmm0, 96(%rsi)
...
movq    %rax, -8(%rsp)      ; black_box 對應的落棧/重載，與 aarch64 對稱
movq    -16(%rsp), %rdx
```

### 關鍵差異

| 維度 | aarch64 (NEON) | x86_64 (SSE2 基線) |
|---|---|---|
| 每條訪存指令寬度 | 32 B（`ldp/stp` q 對） | 16 B（`movups` xmm） |
| 每 128 B 塊指令數 | 8 | 16 |
| 可加寬路徑 | **無**（見下） | `-Ctarget-cpu=x86-64-v3` → `vmovups ymm` 32 B/條（已驗證）；AVX-512 可再翻倍 |

- **指令密度**：aarch64 基線代碼即達到 32 字節/指令；x86 基線只有一半，但開 AVX2 後追平，AVX-512 機器可反超。
- **SVE 不參與**：用 `-Ctarget-feature=+sve` 重新編譯，生成的彙編與純 NEON **逐字節相同**——LLVM 目前不會用 SVE 做固定大小 memcpy 的內聯展開，即使硬件 SVE VL 是 256-bit。這條路徑在本機上限被鎖在 NEON 128-bit。
- **拷貝順序不同但無關緊要**：aarch64 先拷 #64..#127 再回頭拷 #0..#63，x86 從尾部向前，均爲調度器自由發揮。
- **`black_box` 開銷兩邊等價**：每輪一條 store + 一條 load（指針落棧/重載），並阻止 8 次拷貝被合併或刪除——這是該 benchmark 能測到東西的前提。

## aarch64 實測熱點（perf）

結果：**16.75 ns/iter**（±0.13），即每輪 8×128 B = 1024 字節約 48.6 週期 @2.9 GHz，平均每個 128 字節 `read` 約 6 週期。

| 指標 | 數值 | 解讀 |
|---|---|---|
| IPC | 2.18 | 不低，但遠未打滿，前端不是瓶頸 |
| backend 停頓 | **46.5%** | 主要瓶頸 |
| L1d 未命中 | ~0%（53K / 361 億次訪問） | 1024 B 源 + 128 B 目標全駐留 L1，cache 不是問題 |

`perf annotate`：99.8% 樣本落在 bench 閉包內，熱點全部是 NEON 訪存指令本身——最熱是寫 `dst` 的 `str q2`（18.7%，含 skid 聚集）與讀 `buf` 的 `ldp q2, q0`（11.7%、4.7% 等），樣本均勻塗抹在整個拷貝序列上，無單點異常。

**結論：瓶頸是 LSU（load/store 端口 / store buffer）吞吐上限，不是 cache、不是分支、不是指令發射。** 純 L1 內的流式拷貝已貼近這顆核約 21 B/週期讀 + 21 B/週期寫的實測帶寬，再快只能靠更寬的數據通路。

## 對 SVE 優化工作（`retian-sve` 分支）的啓示

1. 想在此類拷貝路徑上用 SVE-256 把指令數減半，只能走顯式 SVE 內聯彙編 / intrinsics，LLVM 的 memcpy 展開不會自動生成 SVE。
2. **先驗證 LSU 數據通路寬度再投入**：若這顆核（0xd02，TSV110 系）的 LSU 是 128-bit，256-bit SVE 訪存會被拆成 2 個 128-bit µop——指令數減半但訪存帶寬不變，收益趨近於零。實測已顯示瓶頸在帶寬而非指令發射（IPC 僅 2.18，前端很閒）。
3. 建議動作：寫一個 `ld1d/st1d` 對比 `ldp/stp q` 的微基準，確認 0xd02 的 LSU 寬度，再決定是否在拷貝類路徑上投入 SVE。

## 附錄：復現步驟

```bash
# 抽取閉包體爲獨立函數後生成彙編
rustc -O --crate-type lib --emit asm -o aarch64.s snippet.rs
rustc -O --crate-type lib --target x86_64-unknown-linux-gnu --emit asm -o x86_64.s snippet.rs
rustc -O --crate-type lib --target x86_64-unknown-linux-gnu -Ctarget-cpu=x86-64-v3 --emit asm -o x86_64_avx2.s snippet.rs
rustc -O --crate-type lib -Ctarget-feature=+sve --emit asm -o aarch64_sve.s snippet.rs   # 與 aarch64.s 逐字節相同

# 本機實測
rustc -O --test bench_main.rs -o bench_main
perf stat -e cycles,instructions,L1-dcache-loads,L1-dcache-load-misses,stalled-cycles-backend ./bench_main --bench
perf record -g ./bench_main --bench && perf annotate --stdio
```

生成的彙編文件保存在 `/tmp/read_bench_asm/`（`aarch64.s`、`x86_64.s`、`x86_64_avx2.s`、`aarch64_sve.s`）。

---

# `case03_manual_char_len` aarch64 vs x86_64 對比與熱點分析

- 日期：2026-08-12
- 分析對象：`library/coretests/benches/str/char_count.rs` 中的 `case03_manual_char_len`（`manual_char_len` 函數），語料來自 `corpora.rs`（en/zh/ru/emoji × tiny..huge）
- 機器與工具鏈同上（HiSilicon `0xd02`，2.9 GHz；rustc 1.98.0-nightly，`-O`）
- 注意：本機無 x86 硬件。x86 部分基於交叉編譯的彙編做代碼形態分析，並在 aarch64 上構造了一個與 x86 codegen 同構的「保留分支」變體做等價實驗（見下），用同一塊硬件量化兩種代碼形態的差距。

## 函數與其本質

```rust
fn manual_char_len(s: &str) -> usize {
    let s = s.as_bytes();
    let (mut c, mut i, l) = (0, 0, s.len());
    while i < l {
        let b = s[i];
        if b < 0x80 { i += 1; }
        else if b < 0xe0 { i += 2; }
        else if b < 0xf0 { i += 3; }
        else { i += 4; }
        c += 1;
    }
    c
}
```

這是**串行字節跳躍**：下一次載入的地址 `i` 取決於上一個載入字節的解碼結果。性能完全由「載入值 → 增量 → 下一個載入地址」這條循環攜帶依賴鏈是否真的存在決定——而這恰好是兩個平臺 codegen 分歧的地方。

## 兩平臺彙編對比

### aarch64：完全 if-conversion，csel/cinc 無分支鏈

LLVM 把三個 else 分支全部轉成條件選擇（百分比爲 perf annotate 實測熱點，ru_huge 語料）：

```asm
.LBB0_3:
    ldrsb w12, [x8, x9]        ; 46.1%  下一次載入，地址依賴 x9
    tbnz  w12, #31, .LBB0_2    ; ASCII 捷徑: i += 1（常量增量）
    ...
.LBB0_2:                       ; 多字節路徑（全部無分支）
    and   w12, w12, #0xff      ; 44.2%  依賴鏈第二環
    cmp   w12, #240
    cinc  x13, x11, hs         ; 3 或 4
    cmp   w12, #224
    csel  x12, x10, x13, lo    ; 2 或上面的結果
    add   x9, x9, x12          ; i += len —— 依賴載入的字節值！
```

**任何非 ASCII 字節的增量都要穿過 load→and→cmp→csel→add 數據鏈**才能得到下一個載入地址。L1 load-to-use ~4 週期加上 ALU 鏈，每個多字節字符約 9 週期，CPU 完全無法投機預取下一個字符。

### x86_64：1/2 字節路徑用分支（常量增量），僅 3-vs-4 用 sbb

```asm
.LBB0_2:
    movzbl (%rdi,%rcx), %r8d
    movl   $1, %edx
    testb  %r8b, %r8b
    jns    .LBB0_5             ; ASCII → +1，常量
    movl   $2, %edx
    cmpb   $-32, %r8b
    jb     .LBB0_5             ; 2 字節 → +2，常量（分支預測後地址鏈自由）
    cmpb   $-16, %r8b
    movl   $4, %edx
    sbbq   $0, %rdx            ; 3 或 4 —— 僅此處數據依賴
.LBB0_5:
    addq   %rdx, %rcx          ; i += len
```

關鍵差異：對 en（ASCII）和 ru（清一色 2 字節）這類**編碼長度高度可預測**的文本，x86 的分支 100% 預測成功，增量是立即數，地址鏈不穿過載入值——亂序引擎可以跑到幾十個字符前面。只有 zh/emoji（3/4 字節）纔會落入 `sbb` 的數據依賴。aarch64 版本則是**所有**非 ASCII 文本都串行化。

## 實測（aarch64，csel 版本）

| 語料 (huge, ~40KB) | 吞吐 | ~cycles/字符 | IPC | backend 停頓 | 分支失誤 |
|---|---|---|---|---|---|
| en (1B/字符) | 2445 MB/s | 1.2 | 5.84 | — | 0.02% |
| ru (2B/字符) | **659 MB/s** | 8.6 | 1.31 | **78.1%** | 0.01% |
| zh (3B/字符) | 884 MB/s | 9.5 | — | — | — |
| emoji (4B/字符) | 1115 MB/s | 10.1 | — | — | — |

perf annotate（ru_huge）熱點全部集中在依賴鏈頭部：`ldrsb` 46.1%、`and` 44.2%——不是分支、不是 cache（L1 miss ≈ 0），是**載入延遲串行化**。en 的 ASCII 捷徑增量是常量，IPC 打到 5.84（發射寬度上限），1.2 週期/字符。

## 決定性實驗：在同一塊硬件上覆現 x86 的代碼形態

在 else 分支裏插入空 `black_box(())` 阻止 if-conversion，得到與 x86 同構的 codegen（2 字節路徑 `mov w11, #2` 常量增量 + 分支；3-vs-4 仍是 `cinc` 數據依賴，恰好對應 x86 的 `sbb`）。同機實測：

| 語料 (huge) | csel 版 | branchy 版（x86 形態） | 提升 |
|---|---|---|---|
| ru | 659 MB/s | **2893 MB/s** | **4.4×** |
| en | 2389 MB/s | 2396 MB/s | 持平 |
| zh | 886 MB/s | 878 MB/s | 持平 |
| emoji | 1116 MB/s | 1117 MB/s | 持平 |

ru 上 branchy 版 IPC 1.31 → **5.71**，backend 停頓 78% → **4.6%**，分支失誤仍 ~0%。zh/emoji 持平的原因彙編上一目瞭然：3-vs-4 的選擇在 branchy 版裏仍是 `cinc`（數據依賴），與 x86 的 `sbb` 完全同構——所以可以推斷 x86 硬件上 zh/emoji 也同樣被 ~9-10 週期/字符的依賴鏈鎖死，而 ru 能跑到 ~2 週期/字符。

**結論：aarch64 與 x86 在此 benchmark 上的真實差距只出現在 2 字節文本（ru 類）上，約 4.4×/同頻，且方向是 aarch64 更慢；根因不是硬件，是 LLVM AArch64 後端激進的 if-conversion 把 100% 可預測的分支換成了穿過載入的數據依賴。** 這是 csel 的經典陷阱：分支預測器本可免費消除的控制依賴，被轉換成每字符必付的 4+ 週期載入延遲。en 持平是因爲 ASCII 捷徑兩版都是常量增量；zh/emoji 持平是因爲兩版（以及 x86）都殘留同構的數據依賴。

## 復現

```bash
# 彙編（snippet 含 #[inline(never)] 的 manual_char_len）
rustc -O --crate-type lib --emit asm -o aarch64.s snippet.rs
rustc -O --crate-type lib --target x86_64-unknown-linux-gnu --emit asm -o x86_64.s snippet.rs

# branchy 變體：在 else 分支中插入 core::hint::black_box(()) 阻止 if-conversion

# 實測
perf stat -e cycles,instructions,branches,branch-misses,stalled-cycles-backend \
    ./bench --bench ru_huge::case03
perf record ./bench --bench ru_huge::case03 && perf annotate --stdio
```

彙編與 bench 源碼保存在 `/tmp/case03_bench/`（`aarch64.s`、`x86_64.s`、`aarch64_branchy.s`、`bench2.rs`）。

---

# `rotate_huge_by*` 系列分析：算法選擇與訪存模式主導，`gcd` 路徑是明確熱點

- 日期：2026-08-12
- 分析對象：`library/alloctests/benches/slice.rs` 的 `rotate_huge_*` 系列（40 MiB 數組，元素 1B/8B/24B(String)/128B）
- 機器同上；緩存：L1d 64K（2 核共享簇）、L2 1.25M、**L3 70 MiB（80 核共享）**、頁 4K
- 注：源碼註釋稱 "Intended to use more RAM than the machine has cache"，但本機 L3 = 70 MiB > 40 MiB 工作集，實際部分由 L3 供給（memcpy 基線 29 GB/s 佐證）。相對結論不受影響。

## 每個 bench 落入哪條算法路徑

`rotate_left` → `ptr_rotate`（`core/src/slice/rotate.rs`）按 `min(left,right)` 與 `size_of::<T>()` 三選一：

| bench | 元素 | left / right（元素） | 路徑 |
|---|---|---|---|
| by1 | u64 | 1 / 5242879 | **memmove**（min ≤ 256B 棧緩衝） |
| by9199_{u64,bytes,strings} | 8B/1B/24B | ~9199·8B / 其餘 | **swap**（算法3） |
| by1234577_{u64,bytes,strings} | 8B/1B/24B | ~9.4MiB / 其餘 | **swap** |
| by9199_big, by1234577_big | **128B** | 575 / 327105 等 | **gcd**（算法2，因 `size_of::<T>() > 32B`） |
| half | u64 | 對半 | **swap**（單趟） |
| half_plus_one | u64 | 對半±1 | **swap**（退化，見下） |

## 實測（aarch64，含自建 memcpy 基線）

| bench | 吞吐 | IPC | dTLB miss | backend 停頓 |
|---|---|---|---|---|
| baseline_memcpy_40m | 29.1 GB/s | 1.57 | — | 68% |
| rotate_huge_half | 12.8 GB/s | — | 0.04% | — |
| rotate_huge_by1 | 12.4 GB/s | — | — | — |
| by9199_u64 / bytes / strings | 8.6–8.9 GB/s | 0.71 | 0.04% | 86% |
| by1234577_u64 / bytes / strings | 6.4–6.6 GB/s | — | — | — |
| half_plus_one | 6.6 GB/s | 1.88 | — | 66% |
| **by9199_big / by1234577_big** | **4.8–4.9 GB/s（墊底）** | **0.50** | **2.16%（3 億次）** | **88%** |

各檔位成因：

- **by1（12.4 GB/s）**：整體就是一次 40 MiB 重疊 memmove（隔離實測 13.1 GB/s，吻合）。純 DRAM/L3 帶寬受限。
- **half（12.8 GB/s）**：單趟 `swap_nonoverlapping` 20 MiB↔20 MiB，一遍過，帶寬受限，與 memmove 同級。
- **half_plus_one（6.6 GB/s，比 half 慢 2×）**：swap 算法的退化案例——第一趟後剩 `left=2`，之後**每次只交換 2 個元素**共 130 萬次內層調用，訪存量翻倍且每 16 字節攤一次循環開銷。
- **by9199 系列（~8.9 GB/s）**：73 KB 的小塊在數組中逐步前移，小塊駐留 L1/L2 反覆交換，DRAM 流量 ≈ 全數組讀寫一遍 + 塊內緩存流量，故略低於單趟。
- **by1234577 系列（~6.5 GB/s）**：同 swap，但滑動塊 9.4 MiB > L2(1.25M)，塊本身也走 L3/DRAM，流量接近 2×。
- **big 系列（4.9 GB/s，本系列熱點）**：見下。

## `gcd` 路徑爲什麼墊底：72 KB 步長 + 棧上 128B 臨時量

by9199_big：`left=575`（元素）。算法核心 `tmp = x.add(i).replace(tmp)` 中 `i` 每步減 `left`——即**以 575×128B = 72 KB 的步長倒着掃全數組**，每步一次 128B 讀 + 128B 寫：

- 72 KB ≈ 18 頁：**每次訪問都落在新頁**，dTLB miss 高達 2.16%（3.0 億次），硬件預取器對這種步長也無能爲力；
- perf annotate 顯示熱點全是 `str q0, [sp, #912]` 一類**棧寫**（單條佔 45.8%）——128 字節的 `tmp` 過大，LLVM 讓 `replace` 經由棧槽中轉，每元素額外 256B 棧往返；
- 結果 IPC 僅 0.50，backend 停頓 88%。

**決定性實驗**：把算法 3（swap）移植出來對同樣輸入強制使用，同機對比 libcore 的 gcd 選擇：

| 輸入（128B 元素，40 MiB） | libcore（gcd） | 強制 swap | 差距 |
|---|---|---|---|
| by9199 (left=575) | 4.96 GB/s | **9.39 GB/s** | **1.9×** |
| by1234577 (left=77162) | 4.91 GB/s | **6.68 GB/s** | **1.36×** |

`rotate.rs` 中 `size_of::<T>() > size_of::<[usize; 4]>()` ⇒ gcd 的啓發式（註釋稱大元素下 gcd 更優）**在本機大數組場景下是明確的劣化**——它把順序訪存換成了 TLB 敵對的大步長訪存。該閾值來自小規模微基準，未考慮工作集遠超緩存時的訪存局部性。

## x86_64 對比

算法選擇邏輯是平臺無關的（同樣的 256B 棧緩衝閾值、同樣的 >32B ⇒ gcd），所以**三條路徑的劃分與 gcd 的訪存病理在 x86 上原樣存在**；差異只在兩處：

1. **swap 內層循環的指令寬度**（交叉編譯彙編對照）：

   | 目標 | 指令形態 | 每側每迭代 | 指令數/迭代 |
   |---|---|---|---|
   | aarch64 (NEON) | `ldp/stp q` 對，32B/條 | 32 B | 6 |
   | x86_64 基線 (SSE2) | `movups xmm`，16B/條 | 32 B | 11 |
   | x86-64-v3 (AVX2) | `vmovups ymm`，32B/條 | 64 B | ~11 |

   但 huge 檔全部帶寬受限（backend 停頓 66–88%），指令密度差異基本被掩蓋——這與前兩節「計算受限時 codegen 形態決定一切」相反。
2. **gcd 路徑的 TLB 代價與頁大小/TLB 規格強相關**：x86 服務器上若啓用 2 MiB 透明大頁，72 KB 步長仍在同一大頁內，dTLB 病理會大幅緩解；本機 4 KB 頁放大了該路徑的劣勢。換言之 big 系列的絕對差距在 x86 上預期更小，但「gcd 慢於 swap」的方向不變。

## 結論與含義

1. `rotate_huge_by*` 的性能層級由**算法路徑與訪存模式**決定：memmove/單趟 swap（~13 GB/s）> 小塊 swap（~9）> 大塊 swap / 退化 swap（~6.5）> gcd（~4.9）。
2. 本系列真正可行動的發現是 **`ptr_rotate` 的大元素啓發式**：對 128B 元素、40 MiB 數組，強制 swap 比 libcore 的 gcd 快 1.9×。若要上游化，需在 `min(left,right)` 很小而總長很大時避免 gcd（例如增加 `left+right` 上限條件），並用多平臺數據支撐。
3. 對 SVE 工作：此路徑帶寬受限，向量寬度不是瓶頸，投入 SVE 收益有限；優先級應排在 `char_count` 類計算受限路徑之後。

## 復現

```bash
# 算法路徑推導：按 rotate.rs 閾值對每個 bench 計算 min(left,right)、元素大小
# 實測與對照
rustc -O --test bench.rs -o bench      # 含 baseline_memcpy_40m
rustc -O --test bench3.rs -o bench3    # 含 big_gcd_libcore vs big_swap_forced
perf stat -e dTLB-load-misses,dTLB-loads,cycles ./bench --bench --exact rotate_huge_by9199_big
perf record ./bench --bench --exact rotate_huge_by9199_big && perf annotate --stdio
```

源碼與彙編保存在 `/tmp/rotate_bench/`（`bench.rs`、`bench2.rs`、`bench3.rs`、`aarch64.s`、`x86_64.s`、`x86_64_avx2.s`）。

## 優化方案與原型實測

針對上面定位的兩個病理，做了兩個互相獨立的修復，合成 `ptr_rotate_v2` 原型並實測驗證。

### Fix A：大元素按 usize 字重新解釋（消滅 gcd 病理）

旋轉是**純字節置換**——旋轉 `[T; n]` 按 `k` 個元素，等價於旋轉底層字節按 `k * size_of::<T>()`。因此當 `size_of::<T>() > 32` 且尺寸是 `usize` 倍數、對齊足夠時，直接把切片重新解釋成 `usize` 切片旋轉，完全繞開 gcd 路徑：

```rust
// in ptr_rotate, before the three-way dispatch:
if size_of::<T>() > size_of::<[usize; 4]>()
    && size_of::<T>() % size_of::<usize>() == 0
    && align_of::<T>() >= align_of::<usize>()
{
    let ratio = size_of::<T>() / size_of::<usize>();
    return ptr_rotate(left * ratio, mid as *mut usize, right * ratio);
}
```

`[u64; 16]` 元素於是走 swap 的向量化 `ldp/stp` 循環（順序訪存、TLB 友好），而不是 72 KB 大步長 + 128B 棧中轉的 gcd。T 帶 padding 時字節內容照搬 padding，行爲不變（rotate 本就對 `Copy`/非 `Copy` 一視同仁地搬字節）。尺寸非 usize 倍數或欠對齊的大元素仍走原 gcd，不受影響。

### Fix B：swap 尾部混合終結（消滅 half+1 退化）

算法 3 每輪把問題縮小成 `(left % right, right)` 的子問題；當某側縮到很小（如 half+1 時第一輪後 `left=2`），繼續 swap 就是 130 萬次 2 元素交換。修復：子問題的 `min(left,right)` 一旦落入棧緩衝（256B）能力範圍，改用算法 1 memmove 一次收尾：

```rust
// in ptr_rotate_swap's outer loop:
if left.min(right) <= size_of::<BufType>() / size_of::<T>() {
    ptr_rotate_memmove(left, mid, right);
    return;
}
```

（等價地：讓 `ptr_rotate` 的三段 dispatch 整體循環化，swap 每輪縮小後重新走 dispatch——上游化時後者改動更小。）

### 實測（40 MiB，同機；窮舉正確性測試通過：len 0..130 × 全部 k × 4 種元素類型）

| bench | libcore | v2 | 提升 |
|---|---|---|---|
| **by9199_big**（Fix A） | 4771 MB/s | **9398 MB/s** | **+97%** |
| **by1234577_big**（Fix A） | 5180 MB/s | **6883 MB/s** | **+33%** |
| **half_plus_one**（Fix B） | 6630 MB/s | **8561 MB/s** | **+29%** |
| **medium half+1**（9158 元素，L1 駐留，Fix B） | 11.7 GB/s | **41.5 GB/s** | **+254%** |
| by1 / half / by9199_{u64,bytes} / by1234577_{u64,bytes} / medium 其他 | — | — | 全部持平（±1%） |
| tiny_half_p1（16 元素） | 8.4 ns | 9.7 ns | −15%（見下） |

- Fix A 把 by9199_big 從墊底（4.8 GB/s）拉到與 u64 swap 同級（9.4 GB/s），dTLB 病理與棧中轉同時消失；by1234577_big 受滑動塊 9.4 MiB > L2 的帶寬限制，提升 33% 後與同尺寸 u64 持平——已到該訪存模式的上限。
- Fix B 對緩存駐留的 medium 尺寸提升最大（3.5×）：退化 swap 的循環開銷在無帶寬瓶頸時完全暴露。
- 唯一回退是 tiny（16 元素）：`min(left,right)=7 ≤ 32` 本來第一步就進 memmove，v2 原型多了一層 Fix A 的尺寸判斷（`u64` 不觸發但要判斷）。這是原型把判斷放在函數頭部所致；上游化時把 Fix A 的檢查放進 gcd 分支內（只有大元素才到達）即可歸零，tiny 路徑一條指令都不多走。

### 上游化要點

- 兩個修復都在 `ptr_rotate` 內部（`core/src/slice/rotate.rs`），不改公共 API 與文檔語義（rotate 的三種算法選擇本就是內部啓發式）。
- `ptr_rotate` 是 `const unsafe fn`：Fix A 的遞歸/重新 dispatch 與 Fix B 的循環化都是 const 可用的操作（指針 cast、`size_of`/`align_of` 均 const）；注意 FIXME(const-hack) 風格保持一致。
- Fix A 的前提「按字節搬 T 等價於搬 T」正是現有三個算法共同的前提（都用 `ptr::copy`/`swap_nonoverlapping` 搬原始字節），無新增安全性假設；`mid as *mut usize` 需要 `align_of::<T>() >= align_of::<usize>()` 保證對齊（已在條件中）。
- 需要多平臺基準支撐（x86 大頁環境下 Fix A 的收益會小一些，但方向一致；Fix B 平臺無關）。

原型與對照基準：`/tmp/rotate_bench/bench4.rs`（v2 實現 + 窮舉正確性 + huge 全配置）、`bench5.rs`（medium/tiny 回退守衛）。

### 樹內落地與 `./x bench` 實測（2026-08-12）

兩個修復已落地到 `library/core/src/slice/rotate.rs`，相比原型增加了兩個上游必需的處理：

1. **`const_eval_select` 隔離**：`rotate_left/right` 是 `const fn`，CTFE 下不允許把含指針/padding 的元素按字重讀，Fix A 只在運行時分支生效（沿用 `memchr.rs`/`swap_nonoverlapping` 的既有模式）；const 分支走原 dispatch，行爲不變。
2. **字類型用 `MaybeUninit<usize>`**（而非裸 `usize`）：padding 字節保持「可讀的未初始化字節」語義，指針 provenance 經由 `ptr::copy`/`swap_nonoverlapping` 的無類型搬運保留。重定向後 gcd 不可達（`min×ratio > 32` 與 `total×ratio < 24` 矛盾），故無類型化讀取只發生在 memmove/swap 兩條無類型路徑上。

結構上把原三路 dispatch 抽成 `ptr_rotate_dispatch`，`ptr_rotate` 入口做 ZST/零檢查後經 `const_eval_select` 分流；Fix B 直接加在 `ptr_rotate_swap` 外層循環尾部（`optimize_for_size` 下禁用，保持該配置零增量）。

**正確性**：`./x test --stage 1 library/coretests --test-args rotate` 通過；另用 stage1 編譯器窮舉驗證 len 0..200 × 全部 k × {u64, [u64;16], [u8;33], String}（覆蓋 Fix A 路徑、gcd 保留路徑、非 Copy 帶 Drop 類型）以及 const 上下文全 mid 旋轉，全部通過。

**`./x bench --stage 1 library/alloctests --test-args rotate`（20 個全跑，基線 vs 修改後）**：

| bench | 基線 | 修改後 | 變化 |
|---|---|---|---|
| rotate_huge_by9199_big | 8,735,325 ns | **4,390,921 ns** | **1.99×**（Fix A，原型預測 1.97×） |
| rotate_huge_by1234577_big | 7,985,543 ns | **6,047,793 ns** | **1.32×**（Fix A，原型預測 1.33×） |
| rotate_huge_half_plus_one | 6,215,438 ns | **4,718,068 ns** | **1.32×**（Fix B） |
| rotate_medium_half_plus_one | 6,222 ns | **1,769 ns** | **3.52×**（Fix B） |
| 其餘 16 個（tiny/medium/huge 全型別） | — | — | 持平（±2% 內，無回退） |

原型裏 tiny 的 -15% 回退在樹內版本消失（7.60 → 7.26 ns）：Fix A 的判斷全是編譯期常量，單態化後小元素路徑一條指令都不多。`by9199_bytes` 首輪出現 ±2.1ms 異常方差，穩定復測 4.61–4.62 ms 與基線持平，確認爲一次性測量噪聲。

---

# `char_count` benchmark 系列：按接口分類的全量分析與優化空間

- 日期：2026-08-12
- 分析對象：`library/coretests/benches/str/char_count.rs`（4 接口 × 4 語言 × 5 尺寸 = 80 個 benchmark）
- 運行方式：`./x bench --stage 1 library/coretests --test-args char_count`（stage1 樹內 std）；熱點與原型用 stage1 rustc 編譯保證 codegen 一致
- 機器同上（HiSilicon 0xd02，2.9 GHz，SVE-256）

## 接口分類

| case | 接口 | 實現路徑 | 本質 |
|---|---|---|---|
| case00_libcore | `s.chars().count()` | `core::str::count::count_chars`：<32B 走逐字節，否則 192B 塊 × 4 usize 展開的位運算計數，LLVM 自動向量化 | 數據無關的字節分類計數 |
| case01_filter_count_cont_bytes | `as_bytes().iter().filter(非連續字節).count()` | 迭代器適配器鏈，LLVM 自動向量化 | 同上，但經由通用迭代器 |
| case02_iter_increment | `for _ in s.chars() { c += 1 }` | `Chars::next` 完整 UTF-8 解碼 | 逐字符串行解碼 |
| case03_manual_char_len | 手寫首字節分類跳躍 | 見第 2 節 | 逐字符串行跳躍（csel 依賴鏈） |

## 實測（huge ≈ 300–360 KB，吞吐 = 語料字節數 / ns）

| corpus | case00 | case01 | case02 | case03 |
|---|---|---|---|---|
| en (ASCII) | **13.2 GB/s** | 4.1 GB/s | 1.6 GB/s | 2.4 GB/s |
| zh (3字節) | **13.2 GB/s** | 4.1 GB/s | 0.9 GB/s | 0.9 GB/s |
| ru (2字節) | **13.2 GB/s** | 4.1 GB/s | 2.1 GB/s | 0.7 GB/s |
| emoji (4字節) | **13.3 GB/s** | 4.1 GB/s | 1.1 GB/s | 1.1 GB/s |

- **case00/case01 吞吐與語言完全無關**（純字節分類，不解碼）；case00 領先 case01 約 3.2×。
- **case02/case03 數據相關**且慢一個量級——都是穿過載入的串行依賴鏈。有趣的交叉：ru 上 case02（分支解碼，模式可預測）比 case03（csel 鏈）快 3×；en 上反過來 case03 快 1.5×（ASCII 捷徑更短）。與第 2 節結論一致。
- **tiny（≤8B）排序反轉**：case03/case02（3.0–4.4 ns）< case00（4.4–4.9 ns）——`count_chars` 的閾值分支與調用開銷；small（16–40B）起 case00 即反超。

## case00 熱點：LLVM 自動向量化的兩個病理

perf annotate（en_huge，stage1 二進制）顯示熱循環是 `ld4` 交錯載入 + 棧溢出：

```
30.5%  mov  x2, x18            ; skid（來自相鄰 ld4）
 8.2%  ld4  {v28.2d-v31.2d}, [x2]   ; 4×ld4/迭代，共 256B
22.8%  ldr  q3, [sp] / str q, [sp]  ; 循環內 8 次棧溢出往返
```

1. **`ld4` 交錯載入**：LLVM 把 4-usize 展開識別成 interleave group，但本算法各字完全對稱，解交錯是純浪費——`ld4` 在本核吞吐遠低於等量 `ldp`；
2. **寄存器溢出**：256B/迭代的展開超出寄存器預算，循環內 8 次 `[sp]` 往返。

結果 case00 只有 13.2–16 GB/s ≈ 5.4 B/cycle，遠低於 LSU 載入帶寬。**對照實驗（portable4）**：把源碼改成 4 路獨立累加器等可移植重構**無效**——LLVM 生成同樣的 ld4 形態（en_huge 15.6 vs 15.8 GB/s，持平）。這是目標相關的向量化 cost model 問題，源碼層面繞不開。

## 優化空間：顯式 NEON 原型（已實測）

非連續字節判定 `(b as i8) >= -64` 正是 NEON 一條 `cmge` 的語義。原型：`vcgeq_s8`（命中得 0xFF）+ `vsubq_u8` 累加（−0xFF = +1）+ 每 ≤255 輪 `vaddlvq_u8` 收攏，64B/迭代 4 路累加器：

| 尺寸 | libcore | NEON 原型 | 提升 |
|---|---|---|---|
| huge (300–360KB) | 15.7–16.0 GB/s | **49.3–49.6 GB/s** | **3.1×** |
| large (~5KB) | 15.8 GB/s | **52.8 GB/s** | **3.3×** |
| medium (~670B) | 14.0 GB/s | 23.2 GB/s | 1.66× |
| small (35B) | 5.8 GB/s | 2.5 GB/s | 回退（原型未設閾值，實現時 <64B 沿用現路徑即可歸零） |
| tiny (8B) | 2.0 GB/s | 2.0 GB/s | 持平 |

正確性已窮舉驗證（全部語料 + 頭尾錯位子串，與 `chars().count()` 逐一對比）。

**結論與上游化評估**：

1. `char_count` 熱路徑存在 **3.1× 的已驗證優化空間**，根因是 LLVM 在 aarch64 上的 ld4+spill 自動向量化病理，可移植重構無效，需顯式 SIMD。
2. NEON 是 aarch64 基線特性，`core::arch` 在 core 內靜態可用，無需運行時檢測——技術上可以 `#[cfg(target_arch = "aarch64")]` 特化 `do_count_chars`（x86 側需另測，其 SSE2 自動向量化未必有同樣病理）。
3. 49.5 GB/s ≈ 17 B/cycle 已接近本核 LSU 讀帶寬，**SVE-256 的增益上限有限**（指令數減半但帶寬封頂，估計 <30%）——第 1 節「先驗證 LSU 寬度再投 SVE」的結論在此同樣適用；NEON 版本已拿走絕大部分空間。
4. case01/02/03 不是 libcore 接口，無上游意義；但 case02（`chars()` 迭代計數）與 case00 的 8–15× 差距說明：**任何「數 char 但不用 char 值」的用戶代碼都應該用 `chars().count()` 而不是手寫循環**——這正是這組 benchmark 的教學意義。

原型與熱點數據：`/tmp/char_count2/`（`bench_neon.rs`、`bench_portable.rs`、`count_stage1.s`、`p00.data`）。

## case01 / case02 / case03 深入分析（彙編 + perf）

三者用 stage1 rustc 編譯成 `#[inline(never)]` 獨立函數（`/tmp/char_count2/bench3.rs`），逐個 annotate。

### case01（iterator filter+count）：自動向量化成功，但「過早加寬」吃掉 3×

LLVM 把 filter+count 向量化了（吞吐 4.4 GB/s、IPC 3.13、無停頓——純計算受限），但形態很差。內循環每 32 字節：

```asm
ldp   q26, q27, [x8, #-16]     ; 38.3%  載入 32B
cmgt  v26.16b, v26.16b, v3.16b ; 47.1%  字節比較 → 每字節 0xFF/0x00 掩碼
ushll/ushll2 ... (×28)          ; 掩碼從 16b 逐級加寬 8h → 4s → 2d
and   ... (×16), add ... (×16)  ; 在 64-bit lane 裏累加
```

比較本身 2 條指令就完成了，但因爲 `count()` 的累加器是 `usize`，LLVM 把每字節掩碼**逐級加寬到 64-bit lane 再加**（`ushll` 級聯 28 條 + and/add 32 條），~2 指令/字節。它不敢在 u8 lane 裏累加，因爲無法證明迭代段 ≤255 次不溢出——這正是人肉 NEON 原型（`vsubq_u8` 字節累加 + 每 255 輪收攏）快它 **11×**（49.3 vs 4.4 GB/s）的原因，也是 libcore `count.rs` 用 CHUNK_SIZE=192 分段的同一動機。case01 與語言無關（en/ru 都是 4.41 GB/s），因爲根本不解碼。

### case02（`for _ in s.chars()`）：LLVM 刪光解碼後 ≡「branchy 版 case03」

關鍵發現：char 值沒人用，LLVM 把 `Chars::next` 的**解碼計算全部 DCE 掉**，只剩首字節分類跳躍——和 case03 語義完全相同的循環，但控制流形態不同：

```asm
.LBB1_4:
    ldrsb w12, [x11], #1     ; 載入首字節
    tbz   w12, #31, .LBB1_2  ; ASCII → +1（常量，post-increment）
    and   w11, w12, #0xff
    cmp   w11, #224
    b.lo  .LBB1_7            ; 2 字節 → 分支到 add x8, x8, #2（常量！）
    cmp   w11, #239
    cinc  x11, x10, hi       ; 3-vs-4 → 數據依賴
    add   x8, x8, x11
```

迭代器的結構化控制流（每字符要和 `end` 指針比較）讓 LLVM **保留了分支**，沒有像 case03 的手寫 while 循環那樣 if-conversion 成 csel 鏈。所以 case02 天然就是第 2 節裏我人工構造的「branchy 變體」——1/2 字節路徑常量增量，僅 3-vs-4 數據依賴。perf 完全證實：

| corpus | case02 | case03 (csel) | 解釋 |
|---|---|---|---|
| ru (2字節) | **2078 MB/s**（IPC 4.10） | 659 MB/s（IPC 1.31） | case02 的 2 字節路徑是分支+常量，快 3.2×；分支失誤僅 0.32% |
| zh (3字節) | 909 MB/s（IPC 1.39） | 886 MB/s | 兩者都被 `cinc` 依賴鏈鎖死（~9.6 cycles/char），持平 |
| emoji (4字節) | 1129 MB/s（IPC 1.31） | 1116 MB/s | 同上（~10.3 cycles/char） |
| en (ASCII) | 1574 MB/s | 2445 MB/s | case02 反而慢：每字符多一次 end 指針比較 + 迭代器結構開銷（1.84 vs 1.2 cycles/char） |

zh 的熱點 annotate 顯示 88% 樣本堆在依賴鏈頭部兩條指令（`mov x11, x8` 43.1% + `and w11` 44.4%）——與 case03 的 `ldrsb`/`and` 熱點同構。

### case03：見第 2 節（csel 依賴鏈），此處不重複

### case02 的 x86_64 vs aarch64 codegen 對比：結構同構，case03 的跨平臺分歧在此消失

兩平臺生成的代碼**逐塊同構**（aarch64 系統 rustc 與 stage1 輸出一致）：

| 路徑 | aarch64 | x86_64 | 性質 |
|---|---|---|---|
| ASCII (+1) | `ldrsb w12, [x11], #1` + `tbz #31`（post-increment 尋址合併自增） | `movzbl` + `testb/jns` + `incq` | 都是**分支 + 常量增量** |
| 2 字節 (+2) | `cmp #224; b.lo` → `add x8, x8, #2` | `cmpb $-32; jb` → `addq $2` | 都是**分支 + 常量增量** |
| 3-vs-4 字節 | `cmp #239; cinc x11, x10, hi; add` | `cmpb $-16; sbbq $-1, %rdi; addq $3`（+4−CF） | 都是**標誌位算術 = 數據依賴** |
| 循環尾 | `cmp x8, x9; add x0, #1; b.eq` | `incq %rax; cmpq; je` | 同構（end 比較 + 計數） |

每字符指令數同爲 ~7 條（ASCII 路徑），差異全部是 ISA 慣用法層面：`ldrsb`+`tbz` 對 `movzbl`+`jns`（符號位測試）、post-increment 尋址對獨立 `incq`、`cinc` 對 `sbb`（標誌位選擇增量）——沒有任何結構性分歧。

這與 case03 形成精確對照：**case03 裏兩後端分道揚鑣**（aarch64 全 if-conversion 成 csel，x86 保留分支，導致 ru 上 4.4×/同頻的跨平臺差距）；**case02 裏兩後端收斂到同一形態**。原因是迭代器展開後的多塊控制流——三條路徑各自在不同基本塊裏推進指針再匯入共享循環尾，不存在單一的 `i += len` 合併點，AArch64 的 csel 生成只處理簡單菱形，於是被迫保留分支，「意外地」得到了對可預測文本更優的代碼。

推論：case02 在 x86 上的語料排序與 aarch64 應一致（en/ru 快、zh/emoji 被 `sbb`/`cinc` 依賴鏈鎖住 ~9-10 cycles/char），只剩微架構量級差異；而 case03 的跨平臺行爲差異（第 2 節）纔是真正由後端策略造成的。兩者合起來給出一個工程啓示：**手寫緊湊 while 循環在 aarch64 上反而更容易觸發激進 if-conversion 的劣化，迭代器風格的多塊控制流在這類「長度可預測」負載上更安全**。

### 三類對比的完整圖景

同一個「數 UTF-8 字符」問題的四種寫法，性能差 75×（ru: case00 13.2 GB/s vs case03 0.66 GB/s），分界線有兩條：

1. **按字節分類（case00/01） vs 逐字符跳躍（case02/03）**：前者無循環攜帶依賴、可向量化、與數據無關；後者下一步地址依賴當前字節值，上限就是幾 cycles/char。這條線值 3–20×。
2. **同在逐字符類裏，增量是常量還是數據依賴**：case02（分支，1/2B 常量）vs case03（csel，全數據依賴）在 ru 上差 3.2×；同在字節分類裏，**累加 lane 寬度**：case00（usize lane 分段）vs case01（過早加寬到 2d lane）差 3×，人肉 u8-lane NEON 再快 3×。

實踐結論：數字符用 `chars().count()`（case00）；case01 的 filter 寫法語義等價但吃 3× 加寬稅；case02/03 這類手寫循環只在 ≤16B 的 tiny 輸入上有意義。libcore 側唯一值得做的是 case00 的 NEON 特化（前述 3.1×）。

---

# `int_log` benchmark 系列：接口、熱點與優化空間評估

- 日期：2026-08-13
- 分析對象：`library/coretests/benches/num/int_log/mod.rs`（30 個：`ilog10`/`ilog(b)` × u8..u128 × 3 種分佈）
- 運行：`./x bench --stage 1 library/coretests --test-args int_log` 全量 + stage1 rustc 獨立副本做 perf/原型

## 接口與實現路徑

- **`ilog10`** → `checked_ilog10` → `NonZero::ilog10` → `imp/int_log10.rs` 按位寬特化：u8/u16 用魔法常數加法拼位（完全無分支），u32/u64/u128 加 1–3 層「≥10^k 則除常數」縮減。
- **`ilog(b)`** → `checked_ilog`：入口的 `is_val_statically_known(base)` 常量優化被 benchmark 的 `black_box(b)` 故意擊穿，全部落入通用路徑——**試乘循環** `while r <= self/base { n += 1; r *= base }`（除法已被 LLVM 外提，彙編證實循環體僅 `mul/add/cmp/b.ls` 4 條）。u128 額外有 `ilog2` 換底下界播種。

## 實測（每調用成本，樹內 stage1）

| 類型 | ilog10 (random) | ilog(b) (random) | ilog(b) (random_small) |
|---|---|---|---|
| u8 | 0.91 ns (2.6 cyc) | 1.50 ns | 1.50 ns |
| u16 | 1.28 ns | 1.94 ns | 1.49 ns |
| u32 | 1.67 ns | 3.86 ns | 1.45 ns |
| u64 | 2.28 ns (6.6 cyc) | **5.34 ns (15.5 cyc)** | 1.45 ns |
| u128 | 5.01 ns | **12.55 ns** | 4.03 ns |

三個關鍵觀察：

1. **`ilog10` 無熱點可言**：predictable 與 random 每調用成本完全相同（u64 均 2.25–2.28 ns），IPC 3.87、分支失誤 0.01%——「無分支位技巧」名副其實，數據分佈無關，已接近最優。
2. **`ilog(b)` 的熱點是試乘循環本身**（perf annotate，u64_log_random）：`mul` 佔 29.7%（`r *= base` 是循環攜帶依賴，乘法延遲 ~4-5 cyc 直接是每迭代成本）、循環出口分支失誤 4.77%（迭代數 = log 值，數據相關本質不可預測，≈每調用一次 miss）、IPC 僅 1.57（對比 ilog10 的 3.87）。前置的一次 `udiv` 已外提，非熱點。
3. **random_small 全類型 ≈1.45 ns**：就是 `x < base → 0` 提前退出 + harness 開銷的地板，證明快路徑無代價。

## 優化空間：實測兩個原型，結論是「有限且有代價」

| 變體（u64） | random (65536 調用) | random_small | geometric |
|---|---|---|---|
| libcore 現狀 | 328 µs | **91 µs** | **3188 ns** |
| 下界播種（u128 技巧擴到 u64） | 441 µs (**−34%**) | 167 µs (−84%) | 3138 ns (持平) |
| 重複平方指數搜索 O(log log n) 次乘法 | **232 µs (+41%)** | 116 µs (−28%) | 3376 ns (−6%) |

（正確性均已窮舉驗證：200 萬隨機組合 + 16 底全部整數冪 ±1 邊界。）

- **把 u128 的下界播種擴展到 u64 是負優化**：`ilog2 + pow` 的播種成本在指數分佈輸入（log 值通常很小）下攤不回來——這反過來解釋了 libcore 只對 u128 做播種是正確的權衡（128 位乘法貴、循環更長，播種才划算）。
- **指數搜索在全範圍隨機上贏 1.4×**，但小值域回退 28%（多餘的平方嘗試+檢查），分支失誤率沒有下降（4.5%，下降路徑同樣數據相關）。要上游化需做成自適應混合（僅當 `x.ilog2()` 遠大於 `base.ilog2()` 時啓用），收益面窄。

**結論**：`int_log` 系列沒有值得行動的熱點。`ilog10` 已最優；`ilog(b)` 的 15.5 cyc/調用瓶頸是「迭代數=答案本身」的算法本質（乘法鏈延遲 × 不可預測出口），兩種經典改進在真實分佈下都各有回退，libcore 現狀（僅 u128 播種 + 常量底靜態改寫）是合理的帕累托點。文檔化建議：性能敏感且底是常量時寫字面量讓 `is_val_statically_known` 生效（`black_box` 實測差距即是證據）。

原型與數據：`/tmp/intlog/`（`bench.rs`、`proto.rs`、`ilog.s`、`p_u64r.data`）。

---

# `hash::map::new_drop`：benchmark 實測的是 TLS 計數器 RMW，x86/aarch64 差異僅在 TLS 尋址模型

- 日期：2026-08-13
- 分析對象：`library/std/benches/hash/map.rs` 的 `new_drop`（每輪 `HashMap::<i32,i32>::new()` + `assert_eq!(len(), 0)` + drop）
- 實測：2.43 ns/iter ≈ 7 cycles，IPC 1.00，分支失誤 0.01%

## 這個 benchmark 實際在測什麼

彙編證實三件事全部被編譯期消除：`HashMap::new()` 空表是常量（hashbrown 不分配）、`len()==0` 斷言摺疊、空表 drop 無代碼。唯一剩下的運行時工作是 **`RandomState::new()` 對線程局部 `KEYS`（`Cell<(u64,u64)>`，惰性初始化的 SipHash 密鑰）的訪問**：讀初始化標誌 + `keys.0 += 1`。單獨 bench `RandomState::new()` 得 2.46 ns，與 new_drop 的 2.42 ns 重合——**這個 benchmark 度量的就是 RandomState 的 TLS 計數器自增，與 HashMap 本身無關**。

## x86_64 vs aarch64 codegen 差異

未內聯的函數體（`--emit asm`，PIC 模式）唯一結構性差異是 **TLS 尋址模型**：

| | aarch64 | x86_64 |
|---|---|---|
| TLS 尋址 | **TLSDESC**：`adrp/ldr/add` + `blr x1`（描述符調用；靜態 TLS 下解析後的 stub 僅 `ldr+ret` 兩條） | **傳統 TLS-GD**：`data16` 填充的 `leaq` + `call __tls_get_addr@PLT`（進 glibc 走 DTV/generation 檢查，開銷更大） |
| 取線程基址 | `mrs x8, TPIDR_EL0`（直接讀系統寄存器） | 隱含在 `__tls_get_addr` 返回值中 |
| 之後的熱路徑 | `ldrb` 標誌 + `cbz` + `ldr/add/str` 計數器 | `cmpb $1` + `jne` + `movq/incq/movq` —— 完全同構 |

兩點抹平差異的事實：(1) 鏈接成可執行文件時兩者都可被 linker relax 成 local-exec 形態；(2) 更重要的是，**bench 閉包內聯進計時循環後，LLVM 把 TLS 地址計算整個提出了循環**（`threadlocal.address` 是循環不變量），實際被計時的循環兩平臺同構，只剩 6 條指令：

```asm
14d10: ldrb w8, [x21, #16]    ; 初始化標誌
14d14: cbz  w8, <cold>        ; 惰性初始化（每線程僅一次，完美預測）
14d18: ldr  x0, [x21]         ; 讀 keys.0
14d1c: add  x8, x0, #1
14d20: subs x27, x27, #1      ; bench 循環計數
14d24: str  x8, [x21]         ; 寫回 keys.0   ← perf 樣本 100% 落在這裏
14d28: b.ne 14d10
```

所以 **TLS 模型差異（TLSDESC vs __tls_get_addr）只影響未內聯/冷路徑的調用**；這個 benchmark 的計時窗口裏兩平臺測的是同一件事。

## aarch64 性能熱點

perf annotate：樣本 **100% 集中在 `str x8, [x21]`**（兩處內聯副本 85.4% + 14.6%）。瓶頸是**循環攜帶的內存 RMW 依賴鏈**：`ldr [x21] → add → str [x21] → 下一輪 ldr [x21]`——每輪必須等 store-to-load forwarding 完成，本核往返 ~7 cycles，這就是 2.43 ns 的全部來源。IPC 1.00、零分支失誤、無 cache miss——純轉發延遲受限，x86 上唯一區別是其轉發延遲典型 4–5 cycles，屬微架構常數而非結構差異。

**結論**：`new_drop` 沒有可行動的熱點——它實際上是「TLS Cell 計數器自增延遲」的微基準。若真要快，方向是改 `RandomState` 的設計（如每線程只取一次隨機密鑰、不逐 map 遞增計數器），但該計數器正是 HashMap 抗 HashDoS 隨機化的實現手段，屬語義權衡而非優化空間。對比數據與彙編：`/tmp/hashmap_bench/`。

---

# `str::trim_ascii_char`：通用字符 predicate 的逐字符掃描，而不是 ASCII 空白裁剪

- 日期：2026-08-17
- 分析對象：`library/alloctests/benches/str.rs` 的 `str::trim_ascii_char::*`
- 接口：`s.trim_matches(|c: char| c.is_ascii())`
- 注意：本節的 benchmark 時間來自本機 aarch64 stage1 實測；x86_64 僅討論跨目標 codegen 性質，不代表 x86 硬件實測。

## 這個 benchmark 實際裁剪甚麼

名稱容易讓人誤解。predicate 是 `char::is_ascii`，所以它會裁掉字符串兩端的**所有 ASCII 字符**（字母、數字、標點、空白、NUL 等），不是只裁 ASCII whitespace，也不是 `str::trim_ascii()`。

宏生成四種位置分佈，因而測到的工作量完全不同：

| case | 輸入邊界 | 實際掃描 |
|---|---|---|
| `short_ascii` | 65B 全 ASCII | 正向掃完整串，結果爲空；沒有剩餘反向掃描 |
| `long_lorem_ipsum` | 長串全 ASCII | 正向掃完整串，代表線性熱路徑 |
| `short_mixed` | 首字符非 ASCII、尾部長 ASCII | 正向立即 reject，反向逐字符掃 ASCII suffix |
| `short_pile_of_poo` | 首部 emoji、尾部 `!` | 正向立即 reject；反向掃一個 `!` 後在 emoji reject |

## 調用鏈與語義限制

`trim_matches` 把 closure 轉成 `CharPredicateSearcher`，先用共享的 `CharIndices` 做 `next_reject()`，再在同一 searcher 的剩餘區間做 `next_reject_back()`。每一步經過：

```text
trim_matches
  -> CharPredicateSearcher::{next,next_back}
  -> CharIndices::{next,next_back}
  -> Chars::{next,next_back}
  -> next_code_point / next_code_point_reverse
  -> closure: char::is_ascii
```

ASCII 快路徑只需讀一個 byte，但抽象語義仍是逐 `char` 調用 `FnMut(char)`。這一點限制了通用實現：predicate 可以有狀態或可觀察副作用，因此 library 不能在一般 `trim_matches<F: FnMut(char)>` 中跳過、重排或批量化 predicate 調用。也不能把任意 closure 自動當成「高位爲 0 的 byte」搜尋。

## aarch64 stage1 benchmark 實測

三次完整運行結果穩定；最新一輪：

| benchmark | ns/iter |
|---|---:|
| `long_lorem_ipsum` | **1063.70 ± 3.09** |
| `short_ascii` | **28.61 ± 0.03** |
| `short_mixed` | **39.34 ± 0.47** |
| `short_pile_of_poo` | **4.48 ± 0.00** |

另一次只過濾 long case 得 `1063.69 ± 2.02 ns`。先前兩輪 long 爲 `1064.86/1065.13 ns`，其餘 case 也只相差約 0.01–0.02 ns，測量重現性良好。

這組排序直接反映掃描距離，而不是 Unicode 解碼本身的固定成本：兩端都很快遇到非 ASCII 的 `short_pile_of_poo` 接近常數時間；全 ASCII long case 必須逐 byte 掃到末尾；`short_mixed` 的成本來自反向 ASCII suffix。

### `perf stat`（aarch64）

對 long、mixed、short ASCII 分別重複 3–5 次；計數包含 `test::Bencher` 校準，但 `perf report` 顯示 99.5%–99.9% cycles 都在 `trim_matches` 單態化函數中，因此 IPC、miss rate 和 stall rate 能代表被測熱路徑：

| case | IPC | branch miss | L1d miss | backend stalled |
|---|---:|---:|---:|---:|
| `long_lorem_ipsum` | **5.77** | **0.02%** | **0.01%** | **0.30%** |
| `short_ascii` | **5.59** | **0.11%** | ~**0.00%** | **0.25%** |
| `short_mixed` | **2.33** | **1.00%** | **0.01%** | **0.19%** |
| `short_pile_of_poo` | **5.36** | ~**0.00%** | ~**0.00%** | **0.23%** |

結論很清楚：所有輸入都不是 cache miss 或 backend stall 受限。全 ASCII forward loop 的 IPC 5.77，幾乎打滿這顆核的發射/退休寬度；瓶頸是**每 byte 都必須退休一組 scalar loop 指令**。mixed 的反向 search 包含更多控制流和在邊界處的一次 reverse UTF-8 decode，IPC 降至 2.33，branch miss 升至 1%，但 miss 絕對率仍低，且同樣沒有記憶體瓶頸。

### `perf record` / `perf annotate` 精確熱點

`long_lorem_ipsum` 共 588 個 cycles samples，`trim_matches` 佔 **99.51%**。全 ASCII forward loop 是：

```asm
add    x11, x8, #1          // 73.43%（含 sampling skid）
cmp    x10, x9
mov    x8, x11
mov    x11, x10
b.eq   done
ldrsb  w12, [x10], #1       // 26.40%
tbz    w12, #31, loop
```

這證實每 ASCII byte 要經過 **6 條 scalar 指令**；熱點不是 UTF-8 多字節 decode（該區塊 0 samples），而是 load→位置/bookkeeping→循環分支本身。73% 落在 `add`、26% 落在 `ldrsb` 是 PMU sampling skid 對循環依賴邊界的歸因，不應解讀爲 `add` 單條真的消耗 73% 執行時間；整個六指令基本塊纔是熱點。

`short_mixed` 共 781 samples，`trim_matches` 佔 **99.90%**。主要樣本落在 reverse loop：

```asm
ldrsb  w13, [x12, #-1]!
tbz    w13, #31, ascii
...
ascii:
cmp    x10, x12             // 61.06%（sampling skid 聚集）
mov    x9, x12
b.ne   reverse_loop
```

抵達非 ASCII 左邊界時執行一次 reverse UTF-8 decode；相關載入與 pointer 指令分散約 29%，最後退出 bookkeeping 約 3%。這與輸入結構吻合：正向立刻遇到 Thai 字符，主要工作是從尾部逐 byte 吃掉 ASCII suffix。

符號名在 `perf` 中顯示成 `short_pile_of_poo`/`short_ascii` 的 closure，是 LLVM 合併了四個 case 相同的 `trim_matches` 單態化函數；call graph 分別明確回到 `long_lorem_ipsum` 和 `short_mixed` bench，不是採樣錯了。

## aarch64 / x86_64 codegen 與彙編熱點判斷

對全 ASCII 熱路徑，兩端的 UTF-8 decoder 都在第一個 byte 上走 ASCII fast path；內聯後每輪的必要工作是：

1. scalar byte load；
2. 檢查最高位（`< 0x80` / `is_ascii`）；
3. 更新前端或後端位置；
4. 循環分支。

因此兩個 ISA 的**算法形態相同**，都是單 byte 串行掃描，沒有自動 SIMD，也沒有 `memchr` 類批量搜尋。aarch64 慣用 `ldrb` 加 `tbnz/tbz` 或 compare/conditional branch；x86_64 慣用 byte load/test 加 `js/jns`/`jcc`。這裏不像 `manual_char_len`：ASCII 每輪位置增量固定爲 1，不存在「從 byte 值算下一字符長度」的 `csel` 依賴鏈分歧；主要差別只會是 ISA 的尋址與旗標指令選擇，而不是算法級差別。

同理，mixed case 的反向 ASCII suffix 也是對尾 byte 的 scalar loop；直到遇到高位 byte 才進 reverse UTF-8 多 byte decode。真正會進多 byte decoder 的只是邊界 reject 附近一個字符，不會成爲 long/all-ASCII case 的主要成本。

本節已用 `perf stat`、`perf record`、`perf annotate` 得到 native aarch64 的精確指令熱點，如上所列。正式的雙目標 `rustc --emit asm` 對照仍待補測；下面的 x86_64 部分是由已確認源碼控制流作出的 code-shape 判斷，不冒充 x86 硬件實測。

## 優化方案

### 1. 直接 scalar byte scan：低風險，但預期收益有限

對**這個確切 predicate**，ASCII byte 與 ASCII `char` 一一對應，可以直接掃 `s.as_bytes()` 的首尾：向前遇到第一個高位 byte 停，向後遇到第一個高位 byte 停。所得位置必是 UTF-8 邊界：向前停在非 ASCII scalar 的 leading byte；向後留下的位置在該 scalar 末尾之後。

它能去掉 `CharIndices` 的長度差、`SearchStep` 與 UTF-8 decoder bookkeeping，但現有代碼經內聯/DCE 後可能已接近同樣的單 byte loop，所以 long ASCII 的收益上限可能只是小幅度。必須用生成彙編和同機 benchmark 判斷，不能只按源碼抽象層數估算。

### 2. `usize` word-at-a-time 高位檢查：long ASCII 更有潛力

用未對齊 `usize` load，一次檢查：

```rust
(word & usize::repeat_u8(0x80)) == 0
```

即可一次跳過 8 個 ASCII bytes（64-bit target）。遇到含高位的 word 後，再用 scalar loop 找精確邊界。`str` 的 UTF-8 有效性讓上述邊界證明成立；core 的 UTF-8 validation 已使用同類 `NONASCII_MASK` 技巧。

這對 `long_lorem_ipsum`、長 ASCII prefix/suffix 最有希望；對 65B 或兩端立即 reject 的輸入，入口判斷和尾部處理可能抵消收益，應設尺寸閾值或讓短輸入保留 scalar 路徑。

### 3. NEON/SVE：只適合專用 API 的大輸入

NEON 可用 16B load + high-bit reduction，SVE-256 可一次處理 32B；但需要快速定位第一/最後一個 non-ASCII byte，且短串 setup 成本明顯。從 1.06 µs 的 long scalar 結果看，大輸入存在理論空間，但應先證明 word-at-a-time 尚未已足夠，再投入 target-specific SIMD。

### 4. 不能直接特化通用 `trim_matches`

最合理的落地邊界不是改一般 `FnMut(char)` searcher，而是以下三者之一：

- 增加語義明確的「trim all ASCII characters」專用操作；
- 由 compiler 識別這個確切 closure 並做語義保持的 loop idiom optimization；
- 引入具有更強語義契約、可安全批量搜尋的 pattern/search primitive。

單純給 `trim_matches` 加 `#[inline]` 也值得小成本量測（它目前不像鄰近部分 trim API 那樣有顯式 `#[inline]`），但 benchmark 已能充分內聯出逐 byte 快路徑時，預期不會解決核心的 O(n) scalar 掃描。

## 結論

1. `trim_ascii_char` 測的是通用 `FnMut(char)` 搜尋器裁掉**全部 ASCII 字符**；名字不等同於 ASCII whitespace trim。
2. aarch64 實測由掃描長度主導：兩端立即 reject 爲 4.48 ns，65B 全 ASCII 爲 28.61 ns，長全 ASCII 爲 1063.70 ns。
3. aarch64 和 x86_64 的 ASCII 熱路徑在算法上都應是 scalar byte test loop；沒有 `manual_char_len` 那種 aarch64 `csel` 對 x86 branch 的結構性分歧。
4. 一般 `trim_matches(FnMut)` 因副作用語義不能 SIMD 化；可優化的是這個確切 predicate 的專用路徑。直接 byte scan 是低風險基線，`usize`/NEON/SVE 批量 high-bit scan 才是 long ASCII 的主要潛力。
5. benchmark 應考慮改名，並增加明確的長 ASCII prefix、長 ASCII suffix、兩側 ASCII 包圍 Unicode、完全不需 trim 等位置分佈，避免四個現有 case 把「字符種類」與「掃描距離」混在一起。

---

# `binary_heap::bench_from_vec`：aarch64 隨機輸入受 child-choice 分支失誤限制

- 日期：2026-08-17
- 分析對象：`library/alloctests/benches/binary_heap.rs` 的 `bench_from_vec`
- 接口：`BinaryHeap::from(vec.clone())`，元素爲 100,000 個隨機排列的 `u32`
- 平臺：本機 HiSilicon aarch64；x86_64 僅作 LLVM 跨目標 codegen 比較，沒有 x86 硬件時間數據

## benchmark 實際測甚麼

輸入的建立與 shuffle 在 `b.iter` 外，不計時。每次迭代包含：

1. `vec.clone()`：配置並複製 400 KB；
2. `BinaryHeap::from(Vec)`：保留原配置，原地執行 bottom-up Floyd heap construction；
3. drop/deallocate 結果。

`From<Vec>` 只把 `Vec` 放入 `BinaryHeap` 後調用 `rebuild()`。`rebuild()` 從 `len / 2 - 1` 向 0 逐個 internal node 執行 `sift_down`，複雜度 O(n)。`Hole` 暫存父元素、把 child 向上搬，避免 swap 所需的雙倍搬移。

每層有兩個資料相關判斷：

```rust
child += (left <= right) as usize; // 選較大 child
if element >= child { return; }   // heap order 已成立則停止
```

stage1 正式 benchmark 實測爲 **608,333.06 ± 1,106.33 ns/iter**。

## 分離 clone 與資料分佈

用相同 100,000 個 `u32` 的獨立 harness 量測：

| case | ns/iter | 相對 random |
|---|---:|---:|
| clone only | **5,737.81** | 0.91% |
| random | **627,443.00** | 1.00x |
| ascending | **145,251.25** | 0.23x |
| descending（已是 max heap） | **60,762.86** | 0.10x |

所以正式 random case 超過 **99%** 的時間不在 clone，而在 heap rebuild。ascending 比 random 有更多向下搬移，卻快約 4.3x；原因不是工作量少，而是 child choice 和 continue 分支高度規律。descending 每個 internal node 幾乎在第一次 parent-child compare 就退出。

## native aarch64 `perf stat` 與熱點

原 benchmark random case 的五次穩定計數：

| 指標 | random |
|---|---:|
| IPC | **1.16** |
| branches | **120,893,353** |
| branch misses | **25,188,881（20.84%）** |
| L1d miss rate | **1.31%** |
| backend stalled | **0.95%** |

相對地，descending 的 IPC 爲 **5.74**、branch miss 約 **0.00%**。clone-only IPC 3.76、branch miss 0.03%，雖較偏 backend/memory，但只佔總時間不到 1%。random 的主因因此是控制流，不是 cache 或內存帶寬。

`perf annotate` 的 hot loop 是：

```asm
ldr   w13, [x22, x11, lsl #2] // left
ldr   w12, [x12, #8]          // right
cmp   w13, w12
b.hi  left_is_larger          // unpredictable child choice
add   x11, x11, #1            // choose right
ldr   w13, [x22, x11, lsl #2]
cmp   w9, w13
b.cs  finish                  // parent >= selected child
str   w13, [x22, x10, lsl #2]
...
b.cc  loop
```

主要樣本集中在 child-choice/continuation 基本塊（例如 26.07%、11.24%、9.42%、6.85%）以及最終 hole store（10.23%）。這些單指令百分比含 PMU skid；應把整個 compare/branch/selected-load block 視爲熱點。

## aarch64 與 x86_64 codegen 差異

同一 `u32` heapify 用本機 rustc/LLVM 22 `-O --emit asm` 跨目標生成：

- **aarch64 current**：left/right compare 後使用 `b.hi`，走 right 時才 `add child, #1`；之後再 load selected child。也就是 child choice 是真正的 unpredictable branch。
- **x86_64 current**：LLVM 已將相同表達式 if-convert：`cmp` 後用 `sbbq $-1, %r8` 把 carry 加入 index，沒有 child-choice branch。
- 兩邊仍保留 `parent >= selected_child` 的 early-exit branch；它對已建好或部分有序 heap 很重要。
- 索引/尋址只是次要 ISA 差異：aarch64 使用 scaled `ldr/str [base,index,lsl #2]` 和 `bfi` 建 `2*i+1`；x86 使用 SIB addressing、`lea`，及 `sbb` materialize comparison。

因此這裏存在實質 target 差異：Rust 的 `(comparison) as usize` **不能保證 branchless**。x86_64 current 已自然獲得 branchless child selection，aarch64 沒有。

## 優化原型實測

測試兩個候選：

1. `select`：只把較大 child 的 index 選擇改成 `hint::select_unpredictable`，保留 early exit；aarch64 生成 `cmp; csel`，x86_64 生成 `cmp; cmova`。
2. `bottom`：rebuild 改用已有的 `sift_down_to_bottom` 形態，無條件沉到底再 `sift_up`。

所有候選先對空/小尺寸、random、ascending、descending、duplicates 和有 destructor 的 non-`Copy` 類型做 heap invariant、元素保持與 drop-safe hole 測試，均通過。固定 1,000 次、綁定同一 CPU 的五次 `u32` 時間如下：

| layout | current | `select_unpredictable` | 差異 | descend-to-bottom | 差異 |
|---|---:|---:|---:|---:|---:|
| random | 661.3 µs | **389.5 µs** | **-41.1%** | 796.2 µs | +20.4% |
| ascending | **145.6 µs** | 154.8 µs | +6.3% | 160.3 µs | +10.1% |
| descending | 76.2 µs | **59.7 µs** | **-21.7%** | 212.7 µs | +179.0% |
| 16-value duplicates | 630.7 µs | **403.3 µs** | **-36.1%** | 746.8 µs | +18.4% |

時間取同一輪 `perf -r 5` 中 harness 報出的代表值；獨立五輪 raw timing 得到同樣排序。固定迭代 `perf stat` 也排除了 libtest 校準 outlier：

| random `u32` | current | select | 變化 |
|---|---:|---:|---:|
| cycles / 1000 iter | 1.922B | **1.132B** | -41.1% |
| IPC | 1.05 | **1.68** | +60.0% |
| branches | 419.6M | **305.9M** | -27.1% |
| branch misses | 87.75M | **22.33M** | -74.5% |
| branch miss rate | 20.91% | **7.30%** | -13.61 pp |

select 的 branch misses 沒歸零，因爲 early-exit、loop backedge 和 outer loop 仍存在；但最難預測的 sibling selection 被 `csel` 消除。其 backend-stall 比例由 0.55% 升至 11.60%，是移除 branch bubble 後 selected-child load 依賴鏈成爲下一瓶頸，不代表總時間退步。

select random 的 `perf annotate` 顯示：

```asm
ldr   w15, [x0, x12, lsl #2] // left
ldr   w16, [x0, x14, lsl #2] // right
cmp   w15, w16
csel  x15, x12, x14, hi      // 無分支選 index
ldr   w16, [x0, x15, lsl #2] // selected child，新的依賴鏈
cmp   w11, w16
b.hs  finish                 // 保留 early exit
```

樣本主要落在 continue block（38.53%）、outer-node final store（21.61%）、outer index work（18.61%）和兩次 child load（合計約 11.8%）。這已不再是 sibling-choice branch-mispredict hotspot。

## 局限：通用 `T: Ord` 不等同 `u32`

對 72-byte `Large { key, payload }`，clone 與元素搬移佔比大增。三輪代表結果：random current 約 **1.60 ms**、select 約 **1.61 ms**，無可靠收益；descending 兩者約 **0.57 ms**。branchless child selection 的巨大 `u32` 收益因此不能直接外推到所有 `T`。

此外：

- `Ord` 比較可能昂貴，`select_unpredictable` 仍只改 index selection，不減少比較次數；
- `csel` 建立 compare → selected index → selected load 的 serial dependency，predictable input 上可能不如 branch；
- ascending `u32` 實測回退約 6%；
- descend-to-bottom 對 random 也回退 20%，對 already-heap 回退近 3x，因而不適合直接替換 `rebuild`；它適合 `pop` 中「replacement element 多半應靠近底部」的既有使用情境。

## 結論

1. `bench_from_vec` 幾乎純測 O(n) bottom-up heapify；`Vec::clone` 只佔 random 時間約 0.91%。
2. native aarch64 random case 的決定性熱點是 larger-child branch，branch miss 20.84%、IPC 1.16；不是 cache/backend 問題。
3. x86_64 已用 `sbb` 對 child choice if-convert；aarch64 current 卻生成 `b.hi`，這是兩平臺最重要的 codegen 差異。
4. 在 aarch64 `u32` 上，`hint::select_unpredictable` 使 LLVM 生成 `csel`，random 快 **41%**、duplicates 快 **36%**、descending 快 **22%**，但 ascending 回退 **6%**；branch misses 減少 74.5%。
5. 這還不能直接作爲通用 std 修改：large element 上收益消失，且資料分佈存在 regression。合理下一步是把 `select_unpredictable` 原型放進實際 `Hole<T>` 實現，跑 std 的完整 BinaryHeap benchmark/test matrix，並特別評估昂貴 comparator、非 `Copy`/大 `T` 及不同 aarch64 微架構；若無跨類型穩定收益，應把問題交給 LLVM 改善 aarch64 對 `(cmp) as usize` 的 if-conversion，而不是在通用 collection 中強制 branchless。

---

# `Iterator::max_by_key`：CGU 改變 IR 形狀，觸發 LLVM argmax 識別缺口

- 日期：2026-08-17
- 分析對象：`a.iter().enumerate().max_by_key(|&(_, &v)| v)`，即同時歸約最大值及其索引的 argmax
- 工具鏈：`rustc 1.98.0-nightly`，LLVM 22.1.7；最小 IR 實驗使用 rustc 樹內 `opt`（LLVM 22.1.8-rust）
- 機器同上：HiSilicon aarch64，NEON；SVE VL = 256-bit

## 結論先行

這個 argmax 循環在數學和語義上都可以向量化，LLVM 22 也已具備所需的向量 max、掩碼 select 和索引歸約能力；問題在於 LLVM 目前只識別一種較窄的 IR 寫法：`select` 選中的候選索引必須直接是一個 induction PHI。若候選索引寫成該 induction variable 的遞增結果（`iv + 1`），LoopVectorizer 就不識別。

改變 `-Ccodegen-units` 會改變模塊劃分、內聯與此前各個優化 pass 留下的 IR 形狀，因此同一份 Rust 源碼在 CGU=1 下得到 `select(..., iv + 1)`，在 CGU=16 下得到等價的獨立 induction PHI。前者未向量化，後者成功向量化。**CGU 不是向量化開關，也不改變 LLVM 的能力；它只是間接改變循環到達 LoopVectorizer 時的寫法。**

## Benchmark 形狀與語義

`max_by_key` 的核心可簡化爲：

```rust
let mut best_value = i32::MIN;
let mut best_index = 0;

for (index, &value) in values.iter().enumerate() {
    if value >= best_value {
        best_value = value;
        best_index = index;
    }
}
```

它不是單一 max，而是兩個聯動的循環歸約：

1. `best_value` 是普通的 signed max reduction；
2. `best_index` 必須在 max 更新時同步更新；
3. 值相等時必須取最後一個元素，這要求索引歸約保持 last-wins 語義。

純 `max` 很容易向量化；argmax 還要求向量化器識別「最大值 + 對應索引」是一組 multi-use reduction。

## CGU=1 與 CGU=16 的決定性 IR 差異

用 `-Cllvm-args=-print-before=loop-vectorize` 抓取 LoopVectorizer 執行前的 IR。兩種構建的循環語義相同，但索引表達方式不同。

### CGU=1：候選索引是 `iv + 1`，未向量化

```llvm
%iv = phi i64 [ 0, %preheader ], [ %iv.next, %loop ]
%iv.next = add nuw i64 %iv, 1

%new.max = call i32 @llvm.smax.i32(i32 %old.max, i32 %value)
%new.index = select i1 %old_is_greater, i64 %old.index, i64 %iv.next
```

這裏只有一條計數 induction variable。當新值勝出時，`select` 取 `%iv.next`，也就是 `add` 的結果。最終彙編是逐元素標量循環，每輪約爲 `ldr + cmp + 2×csel`，存在最大值和索引的循環攜帶依賴鏈。

### CGU=16：候選索引是獨立 induction PHI，成功向量化

```llvm
%candidate.index = phi i64 [ 1, %preheader ], [ %candidate.next, %loop ]
%memory.index = phi i64 [ 0, %preheader ], [ %memory.next, %loop ]

%new.max = call i32 @llvm.smax.i32(i32 %old.max, i32 %value)
%new.index = select i1 %old_is_greater, i64 %old.index, i64 %candidate.index

%candidate.next = add i64 %candidate.index, 1
%memory.next = add nuw i64 %memory.index, 1
```

這裏保留兩條數值相差 1 的 induction variable。`select` 直接使用 `%candidate.index` 這個 PHI，正好命中 LLVM 的 argmax 模式。生成的向量循環每輪處理 8 個 `i32`：

```llvm
%vec.ind = phi <4 x i64> [ <1, 2, 3, 4>, ... ]
%new.max.0 = call <4 x i32> @llvm.smax.v4i32(...)
%new.max.1 = call <4 x i32> @llvm.smax.v4i32(...)
%new.index.0 = select <4 x i1> %cmp.0, <4 x i64> %old.index.0, <4 x i64> %vec.ind
%new.index.1 = select <4 x i1> %cmp.1, <4 x i64> %old.index.1, <4 x i64> %vec.ind.plus4
```

循環結束時先做 `vector.reduce.smax` 得到全局最大值，再保留值等於全局最大值的 lane，最後用 `vector.reduce.umax` 選出最大索引，因此平局時仍返回最後一個最大元素。

## LLVM 源碼中的明確限制

LLVM 22 的 `VPlanConstruction.cpp` 在處理 min/max 與 FindLastIV 組成的 multi-use reduction 時，要求 `select` 的候選索引是 `VPWidenIntOrFpInductionRecipe`：

```cpp
// TODO: Support cases where IVOp is the IV increment.
if (!match(IVOp, m_TruncOrSelf(m_VPValue(IVOp))) ||
    !isa<VPWidenIntOrFpInductionRecipe>(IVOp))
  return false;
```

這個 TODO 精確對應 CGU=1 的 IR：`IVOp` 不是 induction PHI，而是該 PHI 的 increment。LLVM 不是認爲 argmax 在語義上不可向量化，而是尚未把這個等價寫法接入模式識別器。

## 最小 IR 對照實驗

爲排除 Rust iterator、內聯、成本模型和其它 pass 的干擾，手寫兩個最小 LLVM IR 函數，只保留一項差異：

| 變體 | `select` 使用的候選索引 | `opt -passes=loop-vectorize` |
|---|---|---|
| A（CGU=1 形狀） | `iv.next = iv + 1` | 未生成 `vector.body` |
| B（CGU=16 形狀） | 從 1 起步的獨立 induction PHI | 生成 `vector.body` |

對 A 加 `-force-vector-width=4` 仍然不能生成向量循環，證明這不是單純的 cost-model 決策，而是模式識別／合法化入口沒有接受該形狀。

再構造變體 C：保留 A 的所有計算，只額外加入一條從 1 起步的 induction PHI，並讓 `select` 使用它。該 PHI 在每次迭代都與 `iv + 1` 逐位相等；僅改這一處後，LoopVectorizer 立即生成 `vector.body`。

Scalar Evolution 也已把 A 中的兩個值正確分析爲 `%iv = {0,+,1}`、`%iv.next = {1,+,1}`。因此等價關係在 LLVM 分析結果中存在，缺口位於 VPlan 模式匹配沒有接納 induction increment，而不是 LLVM 無法推導 `%iv.next` 的數列。

用 `lli` 對拍標量 A 與向量化 C：4096 個僞隨機元素，在索引 777 和 3000 放置相同的最大值以測試 last-wins；對 2 至 4090 的 9 種長度，兩者結果全部一致。當第二個最大值進入範圍後，兩者都更新到索引 3000。這排除了「LLVM 拒絕是爲了保持平局語義」的可能。

## 向量化器與性能驗證

### Pass 歸因

在 CGU=16 的快版本上分別禁用兩類向量化：

| 編譯選項 | `max_by_key` 結果 |
|---|---|
| 默認 | 有 `smax`/`cmgt`/`bif` 向量循環 |
| `-Cno-vectorize-loops` | 向量循環消失，退回 `csel` 標量循環 |
| `-Cno-vectorize-slp` | 向量循環保持不變 |

因此這是 LoopVectorizer 的結果，不是 SLPVectorizer。

### 同機實測

探針數據爲 1638 元素 spike 和 100,000 元素僞隨機 `i32`，取 30 輪最小值：

| 輸入 | CGU=1：標量 | CGU=16：NEON 向量 | 差距 |
|---|---:|---:|---:|
| spike 1638 | **1398 ns** | **412 ns** | 3.39× |
| random 100k | **85.4 µs** | **24.8 µs** | 3.44× |

同一個 CGU=1 二進制內，直接寫在 slice 上的顯式 argmax 循環仍正常生成 `smax`/`cmgt`/`bif`，spike 約 408 ns。這證明 CGU=1 本身不禁用向量化，也不禁用 argmax 支持；只有 `max_by_key` 在該編譯上下文中形成了未被識別的 `iv + 1` 寫法。

## 爲甚麼改 CGU 會改 IR

CGU 決定 Rust 單態化函數如何分配到 LLVM modules。模塊劃分不同會改變：

1. 哪些函數定義在同一模塊內可見；
2. iterator adapter 和 closure 在何處被實例化、內聯；
3. LoopVectorizer 之前的 canonicalization、induction-variable simplification 和其它 pass 最終保留哪種等價 IR。

在這個案例中，CGU=1 的優化歷史把兩條相差 1 的計數器合併成一條，局部上是更簡潔的 IR，卻使候選索引變成 `iv + 1`，落出 LLVM argmax 識別窗口；CGU=16 保留兩條計數器，反而正好滿足匹配器。現有實驗已定位到 LoopVectorizer 入參的精確差異，但沒有進一步把「計數器合併」歸因到此前某一個特定 pass，因此不應把某個 pass 名稱寫成已證實根因。

這也解釋了爲甚麼該現象看似像「codegen 彩票」：CGU、crate 中其它代碼和內聯上下文都可能擾動 IR 的規範形狀，但用戶沒有 Rust 源碼級手段要求 LLVM 保留獨立 induction PHI。

## 結論與優化含義

1. `max_by_key` argmax **可以向量化**；CGU=1 產生的 `select(..., iv + 1)` 形狀在語義上也可以向量化。
2. LLVM 22 的限制是模式識別不完整，而非數學依賴、內存合法性或成本問題。源碼中的 `TODO` 已明確記錄「IV increment」尚未支持。
3. CGU=1/16 既不是能否向量化的必要條件，也不是充分條件；真正決定因素是 LoopVectorizer 收到的 IR 是否落在匹配窗口內。
4. 修補 LLVM 對 `IVOp = IV increment` 的支持，可以消除這個具體的 3.4× 慢形態；理想修復應以最小 IR A/B/C 作 regression test，確認 last-wins 平局語義。
5. 即使 LLVM 修補識別缺口，庫層 SVE 分塊特化仍可能更快：它將耦合的 value/index 歸約改成純 max 加條件化 last-equal 重掃，減少熱循環中的雙累加器依賴。這是算法結構上的額外收益，與本節的 LLVM 識別修復是兩個層次。

實驗文件保存在 `/tmp/argmax_verify/`：Rust 探針、CGU=1/16 及禁用向量化的二進制、LoopVectorizer 前後 IR、最小 A/B/C IR，以及 `lli` 對拍 harness。


---

# `slice::binary_search_l1_worst_case`：`csel` 依賴鏈 vs 可預測分支的取捨已是正確選擇

- 日期：2026-08-18
- 分析對象：`library/coretests/benches/slice.rs` 的 `binary_search_l1_worst_case`（含 L2/L3 與 random/with-dups 對照）
- 接口：`[T]::binary_search` → `library/core/src/slice/mod.rs::binary_search_by`
- 平臺：本機 HiSilicon aarch64；x86_64 僅作 LLVM codegen 形狀比較，沒有 x86 硬件時間數據

## benchmark 實際測甚麼

`binary_search_worst_case(b, Cache::L1)` 構造 `vec![0; 1000]`、把最後一個元素設爲 1，然後每次迭代固定查找 `1`。要點：

1. 元素類型由未註解的整數字面值推導爲 `i32`，不是普通 `binary_search` helper 的 `usize`；L1 向量實際約 **4 KB**，源碼註釋 `// 8kb` 只對 `usize` 的 helper 成立。正式 executable 的 `ldr w`（32-bit load）證實了這一點。
2. 命中元素永遠在最右端，每輪比較結果幾乎單向（`Less`），概念上這是「分支預測器最容易學會」的輸入，而不是 cache 意義上的 worst case。
3. `binary_search_by` 刻意不做 early exit，循環次數只依賴長度（1000 → 固定 10 輪），並用 `hint::select_unpredictable(cmp == Greater, base, mid)` 要求 branchless 選擇。

## 正式 stage2 benchmark 基線

```text
slice::binary_search_l1                12.85–12.95 ns/iter
slice::binary_search_l1_with_dups      12.22 ns/iter
slice::binary_search_l1_worst_case     10.75–10.77 ns/iter
slice::binary_search_l2_worst_case     16.76 ns/iter
slice::binary_search_l3_worst_case     28.70 ns/iter
```

L1 random case 的固定 filter `perf stat`：IPC 2.48，branch misses **0.01%**，L1d misses **0.01%**。`perf record` 顯示 99.99% 樣本落在 `Bencher::iter` 內聯閉包，hot loop 未展開：

```asm
loop:
  lsr   x11, x10, #1        // half = size / 2
  add   x12, x11, x9        // mid = base + half
  sub   x10, x10, x11       // size -= half
  ldr   w13, [x21, x12, lsl #2]
  cmp   w13, w23
  csel  x9, x9, x12, gt     // branchless base 選擇
  cmp   x10, #1
  b.hi  loop
```

關鍵事實：**即使在 random 查找下 branch misses 也是 ~0%**，因爲資料相關的決策已被 `csel` 移出分支；剩下的 loop 分支次數只依賴長度。時間被 `cmp → csel → 下一輪地址 → load` 的 serial 依賴鏈限制（先前 whole-run counters 顯示 backend stall ~52%，branch/L1d miss ~0%）。

## aarch64 與 x86_64 codegen：三個候選的真實形狀

固定迭代 harness（`/tmp/binary_search_candidates.rs`，`i32`，`#[inline(never)]`，演算法分派在計時迴圈外）包含：

- `current`：照抄 `binary_search_by`（含 `select_unpredictable`）；
- `plain`：把 `select_unpredictable` 改成普通 `if cmp != Greater { base = mid }`；
- `branch`：用 inline-asm barrier 強制把比較結果留在通用暫存器，逼出真正的條件分支；
- `early`：傳統三向比較 early-exit binary search。

codegen 結論：

1. **`plain` 與 `current` 在 aarch64 生成逐指令相同的 `csel` loop**；把同一 LLVM IR 用 `llc -mtriple=x86_64` 降低後，x86 上兩者是 `cmovgq`，且 `llc` 直接輸出 `plain = current` 的符號別名——LLVM 在 -O3 下無論有沒有 hint 都會對這個 pattern if-convert。所以「移除 `select_unpredictable`」在源碼層是 no-op，不是可行的優化手段；hint 的價值是**保證**這個形狀，而非創造它。
2. `branch` 版本經 barrier 後生成 `cset` + `cbnz`，是真實分支（僅此形狀無法由普通 Rust 源碼穩定取得）。
3. x86 對照由 aarch64 host IR 重定目標生成，僅用於指令形狀比較（`cmov` vs `csel` 同構），不作 x86 時間結論。

## 固定迭代候選矩陣（ns/iter，native aarch64）

L1 尺寸 1000：

| workload | current | plain | branch（真分支） | early |
|---|---:|---:|---:|---:|
| last（worst-case 複製品） | 12.49 | 12.50 | **7.98（-36%）** | 12.35 |
| dups（命中重複值） | 12.49 | — | 8.38 | **2.42（-81%）** |
| middle（命中中點） | 12.55 | — | 8.49 | **2.42** |
| miss-low（全 miss） | 12.50 | — | **7.33** | 7.99 |
| random（4096 隨機查詢） | **12.56** | 12.53 | 46.93（**+274%**，miss 17.5%） | 53.09（+323%） |
| random-same（固定路徑對照） | 12.58 | — | 7.94 | 12.10 |

更大尺寸的 last workload：

| size | current | branch | early |
|---|---:|---:|---:|
| 10,000 | 17.66 | **11.18（-37%）** | 18.44 |
| 1,000,000 | 31.39 | **16.07（-49%）** | 27.59 |

1M random（真正 stress cache 的情形）：current **57.8 ns**（L1d miss 30.2%、branch miss 0.01%）對 branch **132.6 ns**（branch miss 27.9%、L1d miss 45.7%）。

perf counters 的機理佐證（L1 last，100M 次）：

| 指標 | current | branch |
|---|---:|---:|
| cycles / search | 36.2 | **23.1** |
| instructions / search | 104 | 135 |
| IPC | 2.87 | **5.84** |
| branch misses | ~0% | ~0% |

branch 版指令更多卻快 36%：可預測分支讓下一輪 probe 地址進入 speculative 執行，打斷了 `csel` 的 load→cmp→select→address serial 鏈。current 的 36.2 cycles / 10 層 ≈ 3.6 cycles/層，已低於單條 load-use+csel 鏈的理論延遲，說明 benchmark 實際測的是 OoO window 疊加多個獨立查找的 throughput，不是單次查找 latency。

## 判斷

1. **這個 benchmark 是 `select_unpredictable` 的已知最壞情形，而目前實現仍是正確的通用選擇。** worst case 輸入單向可預測，真分支快 36–49%；但同一形狀在 random 查詢上慢 2.3–3.7 倍（miss 率 17–28%）。標準庫無法預知調用者的查詢分佈，branchless 提供的是「所有輸入一致的 12.5 ns」而非「特定輸入 8 ns、隨機輸入 47 ns」。
2. **不存在源碼層的免費改進。** `plain` 實驗證明移除 hint 不改變 codegen；`early` 只在能提早命中時贏（dups/middle 快 5 倍），在 random 上慢 4.2 倍，這正是 `bb584882070` 重寫時移除 early exit 的原因，實測支持該決定。
3. `binary_search_l3_worst_case` 並沒有真正測到 L3：固定查同一 target 使整條 probe 路徑（約 20 條 cache lines）常駐 L1，candidates 在 1M 元素上 L1d miss 0.00%。想測 memory hierarchy 必須用 random 查詢（57.8 ns、30% L1d miss）。可考慮爲 benchmark 補一個 `random worst-distance` variant，並修正 `// 8kb` 註釋或給 `vec![0; size]` 標註元素類型。
4. 若要在保持 random 不回退的前提下拿回 predictable 輸入的收益，唯一層次是 profile-guided / `!unpredictable`-aware 的 LLVM if-conversion 決策（與 BinaryHeap 一節的結論一致，方向相反：這裏是「有 profile 證明可預測時才改回 branch」）。

## 復現

```bash
# 正式 benchmark
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../out/corebenches-ed47559efb842e7d --bench 'slice::binary_search_l1'

# 候選 harness（correctness + timing）
build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 \
  -C target-cpu=native /tmp/binary_search_candidates.rs -o /tmp/binary_search_candidates
/tmp/binary_search_candidates verify
perf stat -e cycles,instructions,branches,branch-misses \
  /tmp/binary_search_candidates {current|plain|branch|early} \
  {last|dups|middle|miss-low|random|random-same} <size> <iterations>

# x86 形狀對照
build/aarch64-unknown-linux-gnu/stage1/bin/rustc --crate-type=lib --edition=2024 -C opt-level=3 \
  --emit=llvm-ir /tmp/binary_search_codegen.rs -o /tmp/binary_search_codegen.ll
build/.../bin/llc -mtriple=x86_64-unknown-linux-gnu -O3 /tmp/binary_search_codegen.ll \
  -o /tmp/binary_search_codegen_x86.s
```

candidates 全部通過 0–256 尺寸 × 5 種 layout 的插入點/命中合法性驗證（duplicates 只要求命中任一合法位置，與 API 契約一致）。

---

# `binary_heap::bench_peek_mut_deref_mut` 與 `bench_find_smallest_1000`：一個測不到東西可改，一個複現 child-choice 分支瓶頸

- 日期：2026-08-18
- 分析對象：`library/alloctests/benches/binary_heap.rs` 的兩個 `PeekMut` 相關 benchmark
- 接口：`BinaryHeap::peek_mut` → `PeekMut::{deref_mut, drop}`（`library/alloc/src/collections/binary_heap/mod.rs`）
- 平臺：本機 HiSilicon aarch64（stage1 allocbenches + 匹配 `libstd-9fa3030fc3d22e0b.so`）；x86_64 僅 codegen 形狀判斷

## 兩個 benchmark 分別測甚麼

**`bench_peek_mut_deref_mut`**：單元素 heap 上取一個 `PeekMut`，對它在迴圈裏做 1,000,000 次 `*peek_mut = i` 賦值，最後 `mem::forget` 跳過 Drop（即跳過 sift_down）。它守護的是 `DerefMut` 的 leak-amplification 實現：每次 `deref_mut` 要檢查 `len > 1`、記錄 `original_len`、`set_len(1)`；註釋要求編譯器不能把這個賦值優化掉。

**`bench_find_smallest_1000`**：經典 top-k。前 1000 個元素 collect 成 heap，之後掃描剩餘 99,000 個隨機 `u32`，`if x < *max { *max = x }`——約 1% 的概率觸發替換，替換時 `PeekMut::drop` 從根部執行一次 `sift_down`。註釋明確：多餘的 sift_down 會退化性能。

## 正式基線（各 3 輪）

```text
bench_peek_mut_deref_mut    347,723–349,599 ns/iter
bench_find_smallest_1000    262,682–263,080 ns/iter
```

## `bench_peek_mut_deref_mut`：已在硬件吞吐極限，無事可做

perf stat：IPC **3.94**，branch miss **0.00%**，L1d miss **0.01%**，backend stall 1.41%。`perf record` 99.80% 落在內聯後的 bench 閉包，逐指令 annotate 顯示熱點只有兩條 `str`（16.4% + 82.4%，即整個迴圈體）。反彙編證實內圈是：

```asm
loop:
  ldr   w12, [x10], #4     // 從 vec 順序讀
  subs  x11, x11, #4
  str   w12, [x22]         // 寫 heap.data[0]
  b.ne  loop
```

`DerefMut` 的 `len > 1` 檢查與 `set_len(1)` 只在進迴圈前執行一次（`cmp x9, #2` 那個入口塊把 `original_len` 設好），LLVM 證明之後 len 恆爲 1，把每次調用的 bookkeeping 全部提出迴圈。所以：

1. **語義守護成立**：`original_len` 寫入保留了，賦值沒有被優化掉；
2. **每元素攤銷成本 ≈ 0**：349.6 µs / 1M ≈ 0.35 ns ≈ **1.01 cycles/元素**，等於 4 指令 @ IPC 3.94 的理論值，被「每 cycle 一條 store」的機器上限釘死；
3. 這個 benchmark 是 regression guard，不是優化目標。aarch64 與 x86_64 在此形狀上同構（`ldr/str` vs `mov` 對），沒有結構性 ISA 差異，任何「改進」只可能來自打破 benchmark 本身的度量意圖。

## `bench_find_smallest_1000`：bench_from_vec 的 child-choice 瓶頸換皮再現

perf stat：IPC **1.68**，branch miss **9.12%**（27.5M），frontend stall **22.99%**（分支 flush 的典型特徵），L1d miss 0.05%——又是控制流問題,不是 cache。

`perf record` 99.64% 在 `ns_iter_inner` 內聯閉包。反彙編顯示兩個熱區：

```asm
scan:                              ; 99k 次,~99% 可預測
  ldr   w12, [x9], #4              ; 下一個元素
  ldr   w13, [x21]                 ; heap[0] = 當前第 1000 小
  cmp   w12, w13
  b.cs  scan                       ; 不替換,繼續

sift:                              ; 每次替換走 ~10 層
  ldr   w16, [x21, x13, lsl #2]    ; left child
  ldr   w14, [x14, #8]             ; right child
  cmp   w16, w14
  b.hi  take_left                  ; ← unpredictable child choice
  ...
```

樣本聚集在 sift_down 的 child 選擇塊（`lsl x16, x14, #1` 上 27.8% 是緊跟其後的 skid 聚集）與 scan 迴圈邊界（15.3%）。替換期望次數 ≈ 1000 × ln(100) ≈ 4,600 次，每次 ~10 層近 50% 熵的 sibling 比較，加上替換觸發點本身的失誤，與每 iter ~32k misses 的量級吻合。與 `bench_from_vec` 一節相同：aarch64 對 `child += (left <= right) as usize` 生成真分支 `b.hi`，x86_64 是 `sbb` branchless——同一個 codegen 分歧,不同的入口(這裏經由 `PeekMut::drop` 的根部 sift_down)。

### `select_unpredictable` 原型實測

固定 1000 次迭代的 standalone 複製品（`/tmp/find_smallest_candidates.rs`,同構 Hole + sift_down,100,000 隨機 `u32`,k=1000;correctness 對 7 種尺寸驗證 heap invariant 與 top-k 集合一致）：

| 指標 / iter | current（branch child） | select（`csel` child） | 變化 |
|---|---:|---:|---:|
| ns/iter | 272,782–274,820 | **172,013–173,856** | **-36.9%** |
| cycles | 794M | **503M** | -36.6% |
| instructions | 1.220G | 1.219G | ~0 |
| branch misses | 31.9M | **5.8M** | **-81.9%** |
| IPC | 1.54 | 2.43 | +58% |

指令數幾乎不變,收益全部來自消除 child-choice misprediction;殘餘 5.8M 是掃描替換點與 early-exit 的天然失誤。原型 current 版 273 µs 與正式 263 µs 相符(shuffle 源與 Hole 細節略異)。

## 結論

1. `bench_peek_mut_deref_mut` 驗證了 `PeekMut` leak-amplification 設計的目標——`DerefMut` 攤銷成本爲零(1.01 cycles/元素,IPC 3.94)。它是守護型 benchmark,std 層無優化空間,也不應該有。
2. `bench_find_smallest_1000` 是 `bench_from_vec` 結論的第二個獨立佐證:aarch64 上 BinaryHeap `sift_down` 的 sibling child choice 是真分支,隨機資料下 miss 率 9.12%、frontend stall 23%;`select_unpredictable` 原型快 **36.9%**,branch misses 減 **81.9%**。且這次的入口是 `peek_mut` 替換(即 `pop`/替換類工作負載),不只是 `from_vec` 的批量 heapify。
3. 局限與 `bench_from_vec` 一節完全共享:收益依賴便宜比較、小元素、高熵資料;ascending 類可預測輸入會回退,大元素收益消失。兩個 workload 疊加後,把 `select_unpredictable` 放進 `Hole` 版 `sift_down` 並跑完整 BinaryHeap benchmark/test matrix 的優先級上升——`from_vec`(-41%)與 top-k(-37%)是 BinaryHeap 最常見的兩種熱路徑。
4. 復現:

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../alloctests/2cf0e8badf7482bf/out/allocbenches-2cf0e8badf7482bf \
  --bench 'bench_peek_mut_deref_mut'   # 或 bench_find_smallest_1000

build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 -C target-cpu=native \
  /tmp/find_smallest_candidates.rs -o /tmp/find_smallest_candidates
/tmp/find_smallest_candidates verify
perf stat -e cycles,instructions,branches,branch-misses \
  /tmp/find_smallest_candidates {current|select} 1000
```

（注:stage2 的 allocbenches 二進制依賴含 SVE 實驗符號的舊 `libstd`,已無法載入;本節使用 stage1-std 構建,與其匹配的 stage1 `libstd` 一致。）

## 補充：`find_smallest_1000` 的四個優化候選實測

同一 harness 追加 descend-to-bottom(std `pop` 所用策略)與 4-ary heap 兩個結構性候選,均通過 top-k 集合與 heap invariant 驗證(4-ary 按 `(i-1)/4` 父子關係驗證):

| 候選 | ns/iter | branch misses | vs current |
|---|---:|---:|---:|
| current(branch child + early exit) | 273.6 µs | 31.9M | — |
| **select(`csel` child + early exit)** | **172.9 µs** | **5.8M** | **-36.9%** |
| bottom(無條件沉底 + sift_up,即 `pop` 策略) | 303.9 µs | 35.2M | +11.1% |
| bottom-select(沉底 + `csel` child) | 214.1 µs | 10.2M | -21.7% |
| 4-ary heap(每層 3 個 `csel` 選 4 子) | 340.0 µs | 43.7M | +24.3% |

解讀:

1. **`csel` child choice 是唯一全面勝出的手段**,且與 early exit 正交組合最佳:替換元素是「小於當前第 1000 小」的隨機值,通常沉得深但不總到底;保留 early exit 比無條件沉底少走多餘層,`csel` 消除每層 sibling 失誤。
2. descend-to-bottom 在這個 workload 輸給 early exit(+11%),即使配上 `csel` 也只到 -21.7%,不及單純 select 的 -36.9%。它的甜點仍是 `pop`(replacement 來自堆尾、幾乎必沉底);top-k 的 replacement 是隨機新值,語義不同。
3. 4-ary 失敗:深度雖減半,每層成本(4 load + 3 `csel` 串聯)超過兩倍,early-exit/尾節點分支失誤反而更多(13.0%),總 misses 高於 binary current。緩存已不是瓶頸(L1d miss 0.05%),減深度無利可圖。

---

# `vec::bench_dedup_none_100`：prescan 是純 scalar 相鄰比較,NEON 分塊可提速 ~3×

- 日期：2026-08-18
- 分析對象：`library/alloctests/benches/vec.rs` 的 `bench_dedup_none_{100,1000,10000,100000}`
- 接口：`Vec::dedup` → `Vec::dedup_by`（`library/alloc/src/vec/mod.rs` 約 2670 行）
- 平臺：本機 HiSilicon aarch64（stage1 allocbenches + 匹配 stage1 `libstd`）

## benchmark 實際測甚麼

輸入是 100 個 `u32` 交替 `0,5,0,5,…`（`black_box` 寫入防止常量摺疊）,沒有任何相鄰重複。每次迭代對同一個 vec 調用 `dedup()`——與其他 dedup benches 不同,它**不重建輸入**,因爲測的正是「無重複時 dedup 有多便宜」。

`dedup_by` 的實現分兩段:先做一個只讀 prescan 找第一個重複的索引(`first_duplicate_idx`),沒找到就直接返回、零寫入;找到才進入帶 `FillGapOnDrop` panic 保護的讀寫壓縮迴圈。`dedup_none` 只走 prescan——這個 benchmark 實際上是在測**「相鄰不等判定」的掃描吞吐**。

## 正式基線與 perf

```text
bench_dedup_none_100        59.16 ns/iter   6,779 MB/s
bench_dedup_none_1000      606.54 ns/iter   6,600 MB/s
bench_dedup_none_10000    5,978.21 ns/iter  6,691 MB/s
bench_dedup_none_100000  59,720.86 ns/iter  6,697 MB/s
```

四個尺寸的 MB/s 幾乎一樣——完全線性,無 cache 效應。perf(100 元素,整個 libtest 過程):IPC **5.26**,branch miss 0.01%,L1d miss 0.00%。`perf record` 100% 在內聯後的 bench 閉包;熱迴圈是:

```asm
prescan:
  add   x16, x11, x14, lsl #2
  ldp   w16, w17, [x16]      ; 一次載入 prev/current 對
  cmp   w17, w16
  b.eq  found
  add   x14, x14, #1
  sub   x10, x10, #1
  add   x12, x12, #4
  cmp   x15, x14
  b.ne  prescan
```

LLVM 把 `same_bucket(&mut current, &mut prev)` 的兩個指標訪問合成了一條 `ldp`,但**每元素仍是 ~7 條標量指令、一次比較**;約 0.59 ns/元素(~1.7 cycles/元素),已把這個標量形狀跑到 IPC 5.79 的極限。瓶頸不是 misprediction、不是 cache,是**每元素指令數**。

## 爲甚麼 LLVM 不自動向量化

prescan 迴圈每輪都可能 `break`(early exit),且 `same_bucket` 是拿 `&mut T` 的任意閉包;LLVM 無法對「有副作用的、逐元素提前退出」的迴圈做向量化。這與 `binary_search`/`trim_ascii` 兩節的教訓一致:早退語義是 SIMD 的天敵。

## 優化原型:分塊 prescan(塊內無早退)

思路:`u32` + `PartialEq` 的相鄰比較沒有副作用,可以按固定塊(8/16 元素)先做「塊內有沒有任何相鄰相等」的無早退歸約——LLVM 能把它向量化爲 `cmeq`——命中塊後再標量重掃塊內定位精確索引。語義不變(返回同一個 first index)。

**關鍵陷阱(實測)**:用 `v[i + j]` 寫塊內迴圈時,邊界檢查讓 LLVM 完全不向量化,收益只有 ~8%;換成 `get_unchecked`(安全性由 `i + N <= len` 保證)後 `cmeq	v.4s` 出現,收益立刻跳到 3×。

`/tmp/dedup_prescan_candidates.rs`,對 0–200 全尺寸 × 4 種 layout + 隨機 fuzz 驗證與標量結果索引一致後:

| layout / size | scalar(≈std 現狀) | chunk8 | chunk16 | 最佳收益 |
|---|---:|---:|---:|---:|
| none, 100 | 42.27 | 17.50 | **12.98** | **-69%** |
| none, 1000 | 427.07 | **117.83** | 121.67 | **-72%** |
| none, 10000 | 4767.25 | 1875.45 | **1320.30** | **-72%** |
| mid-dup, 1000 | 222.88 | 89.42 | **75.39** | -66% |
| all, 100(立即命中) | **1.39** | 2.68 | 3.07 | +121% |
| random, 100(第 2 元素即命中) | **1.73** | 2.79 | 3.45 | +99% |

counters(none,100):cycles -62%,instructions 14.1G → 3.3G(-77%),IPC 5.79 → 3.53(向量單元吞吐限制,不再是標量發射限制)。

standalone scalar 42.3 ns 對正式 59.2 ns 的差距是 libtest 閉包裏 `black_box(vec.first())` 與 `Vec` 間接訪問的攤銷,形狀相同。

## 局限與落地邊界

1. **早期命中回退 ~2 倍**(1.4 → 3.1 ns):塊粒度的無早退歸約在「第一個塊就命中」時多做了整塊比較。絕對值是 1–2 ns 級別,但 `dedup_all`/`dedup_random` 這類高重複 workload 每次調用都落在這個 case。可用「前 1–2 個塊走標量、之後切塊」的 hybrid 消除大部分回退。
2. **只適用於無副作用比較**。`dedup_by` 接受任意 `FnMut(&mut T, &mut T) -> bool`,不能改;可落地的位置是 `dedup()` 走 `T: PartialEq` 的路徑——需要 specialization(std 內部可用 `SpecDedup` 一類已有模式),對 `u8/u16/u32/u64` 等 `Copy` + bitwise-eq 類型啓用分塊 prescan。
3. prescan 之後的壓縮階段不變;`dedup_none` 之外的 benches 只有 prescan 段變快。
4. x86_64 判斷:同樣的塊內無早退歸約可被 LLVM 向量化爲 `pcmpeqd`,結構性收益可移植,但本輪沒有 x86 硬件實測。

## 結論

1. `bench_dedup_none_100` 測的是 `dedup_by` prescan 的標量相鄰比較吞吐:0.59 ns/元素,IPC 5.26,無任何 miss——現有實現已是**標量形狀的極限**,再快必須改形狀。
2. LLVM 不能自動向量化帶 early-exit 的通用閉包迴圈;顯式分塊 + `get_unchecked` 後 NEON `cmeq` 生效,100–10000 元素穩定 **-66% ~ -72%**,且結果索引逐一驗證一致。
3. 邊界檢查是向量化的硬門檻:同一算法帶 bounds check 只有 8% 收益,去掉後 3×——原型必須看彙編確認 `cmeq`,不能只看源碼。
4. 落地需要 specialization 限定在 bitwise-eq 類型,並用 hybrid 起步消除 early-hit 回退;`dedup_all`/`random` 的立即命中 case 是主要 regression 面。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../alloctests/2cf0e8badf7482bf/out/allocbenches-2cf0e8badf7482bf --bench 'dedup_none'

build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 -C target-cpu=native \
  /tmp/dedup_prescan_candidates.rs -o /tmp/dedup_prescan_candidates
/tmp/dedup_prescan_candidates verify
/tmp/dedup_prescan_candidates {scalar|chunk8|chunk16} {none|all|mid-dup|random} <size> <iterations>
```

## 補充：dedup prescan 的 aarch64 / x86_64 codegen 對比

由同一份 `no_std` probe 的 LLVM IR(rustc -O3 已在 IR 層向量化爲 `<16 x i32>` 比較)分別 lower:aarch64 native(`-C target-cpu=native`)、x86 `llc -mcpu=x86-64`(SSE2 baseline)、`llc -mattr=+avx2`。剝除 IR 中殘留的 aarch64 target-features 後結果纔有效——第一次 lower 因 feature 字串污染輸出了假的 AVX 代碼,已修正重測。

### 標量 prescan(std 現狀)兩邊同構

x86 每元素是 `mov + cmp-with-memory + je + inc + cmp + jne`,aarch64 是 `ldp + cmp + b.eq + add + cmp + b.ne`;x86 的 memory-operand `cmp` 把 load 摺進比較,aarch64 的 `ldp` 一次載入 prev/current 對——各自的慣用摺疊,**算法形態相同,無結構性分歧**。這與 binary_search 一節(兩邊都 if-convert)同類,和 BinaryHeap 一節(x86 `sbb` branchless、aarch64 真分支)不同:相鄰比較沒有需要 if-convert 的 select,兩個後端都給出等價的最優標量形狀。

### 向量 kernel:每 16 元素塊的穩態指令數差異顯著

| ISA | 每塊(16×u32)穩態指令 | 形狀 |
|---|---:|---|
| aarch64 NEON | ~13 | 6 load + 4×`cmeq` + 3×`uzp1` + `addp` + `fmov` + `cbz` |
| x86 SSE2 | 19 | 8×`movdqu` + 4×`pcmpeqd` + 2×`packssdw` + `packsswb` + `pmovmskb` + `test/je` |
| x86 AVX2 | **9** | 3×`vmovdqu` + 2×`vpcmpeqd`(1 個帶 memory operand) + `vpackssdw` + `vpmovmskb` + `test/je` |

兩邊的「塊內有無命中」歸約用了不同 ISA 慣用法,但目的相同:

- **aarch64**:`uzp1` 級聯把 4 個 128-bit 比較掩碼壓縮成 1 個向量,`addp d` 摺半後 `fmov` 到通用暫存器 `cbz` 判零。NEON 沒有 `pmovmskb` 等價物,掩碼提取天生比 x86 多一步。
- **x86**:`packssdw/packsswb` 把比較結果窄化,`pmovmskb` 一條指令得到 bitmask 進 `test`。AVX2 用 256-bit 暫存器把 load 數減半,還能把一個 load 摺進 `vpcmpeqd` 的 memory operand。

### 對比結論

1. **標量現狀無平臺分歧**:`dedup_none` 的 std 表現在兩邊都是每元素 ~1 比較 + ~2 bookkeeping 的極限標量迴圈,x86 硬件上同樣會是「每元素指令數」瓶頸,預期 MB/s 同樣與尺寸無關。
2. **分塊優化兩邊都成立,x86 收益上限更高**:IR 層向量化是共享的,SSE2 即可獲得與 NEON 同級的形狀;AVX2 的穩態指令數(9/塊)明顯低於 NEON(~13/塊),加上 256-bit 寬度,x86 現代機器的預期加速比 aarch64 實測的 3× 只高不低。方向上也適用於 AVX-512(`vpcmpeqd` + `ktest`)。
3. **掩碼提取是 aarch64 的固有小稅**:`uzp1×3 + addp + fmov` 對 `pmovmskb` 一條;SVE 的 `cmpeq` 直接產生 predicate + `ptest` 可消除這一步,是 aarch64 側進一步的方向(本機 SVE-256 可用,未實測)。
4. 此對比只做了 codegen 形狀與指令計數,x86 沒有硬件時間;所有 x86 說法是 code-shape 判斷,不是實測結論。

復現補充:

```bash
# IR + aarch64 asm(probe 為 no_std,無 panic 機制依賴)
rustc --crate-type=lib --edition=2024 -C opt-level=3 -C target-cpu=native \
  --emit=llvm-ir,asm dedup_prescan_codegen.rs
# 剝 aarch64 features 後跨目標 lower
sed -e 's/"target-cpu"="generic"/"target-cpu"="x86-64"/g' \
    -e 's/"target-features"="[^"]*"//g' dedup_prescan_codegen.ll > clean.ll
llc -mtriple=x86_64-unknown-linux-gnu -mcpu=x86-64 -O3 clean.ll -o x86_sse2.s
llc -mtriple=x86_64-unknown-linux-gnu -mattr=+avx2 -O3 clean.ll -o x86_avx2.s
```

## 補充:SVE prescan 實測——可行,小幅優於 NEON,收益主要在中大尺寸

本機 SVE VL=256-bit(每輪 8×u32 lanes)。用 inline asm 寫了兩個 predicate-driven 變體(rustc 對 SVE ACLE intrinsics 支持不全,asm 是目前可控的形狀;`whilelo` 自動處理尾部,無標量 tail loop):

- `sve`:單 `whilelo p0.s` 迴圈,`ld1w ×2 → cmpeq → ptest`,命中後 `brkb + cntp` 直接算出第一個重複 lane 的精確索引;
- `sve2x`:主迴圈 2×VL 展開(`ptrue` 全掩碼,`orrs` 合併兩個 cmpeq predicate),尾部退回 masked 1×VL。

兩者均通過 0–200 全尺寸 × 4 layout + fuzz 與標量索引逐一一致的驗證。

| none layout | scalar | chunk16(NEON) | sve | sve2x | sve2x vs NEON |
|---|---:|---:|---:|---:|---:|
| 100 | 41.8 | 13.1 | 13.1 | **12.6** | -4% |
| 1000 | 426.8 | 121.0 | 117.3 | **107.2** | **-11%** |
| 10000 | 4739 | 1374 | 1292 | **1135** | **-17%** |
| all, 100(立即命中) | **1.55** | 3.47 | — | 3.08 | -11% |
| mid-dup, 1000 | 248.4 | 73.2 | — | **70.6** | -4% |

counters(none,10000):sve2x 指令數比 NEON chunk16 少 **40%**(3.77G vs 6.31G),cycles 少 14%;IPC 反而較低(2.55 vs 3.68),因爲 SVE 指令在此微架構吞吐較低——但每指令做的工作多,總量贏。

SVE 贏在三處結構優勢:

1. **掩碼提取零開銷**:`cmpeq` 直接產生 predicate,`ptest` 一條判有無命中;NEON 需要 `uzp1×3 + addp + fmov` 五步。
2. **first-index 是原生操作**:`brkb + cntp` 兩條指令得到第一個命中 lane;NEON 命中後要標量重掃整塊。
3. **尾部免費**:`whilelo` 自動 mask 掉越界 lanes,不需要 chunk 版的標量尾迴圈,對非整塊尺寸更平滑。

局限:

- 收益相對 NEON 是 4–17%,遠小於「scalar → 任一向量版」的 3–4×;主要優化仍是「打破逐元素早退」本身,ISA 選擇是二階效應。
- 立即命中回退(~2×)與 NEON 版本同在,hybrid 起步仍是必要的。
- inline asm 形狀無法直接進 std;std 落地要等 SVE intrinsics/portable-SIMD 穩定,或依賴 LLVM 自動向量化把 chunk 形狀 lower 成 SVE(本輪 `-C target-cpu=native` 下 LLVM 仍選 NEON 而非 SVE,和 argmax 一節觀察一致)。
- 單一微架構(HiSilicon VL=256);VL=128 的機器上 SVE 對 NEON 的寬度優勢消失,只剩 predicate 結構優勢,需另測。

復現:`/tmp/dedup_prescan_candidates.rs`,algorithm 取 `sve`/`sve2x`。

---

# `slice::push`:測的是 store→load 轉發鏈上的 Vec 三欄位往返,不是 push 本身的算術

- 日期:2026-08-18
- 分析對象:`library/alloctests/benches/slice.rs::push`(注意:它在 slice.rs 裏,但測的是 `Vec::push`)
- 接口:`Vec::push` → `Vec::push_mut`(`library/alloc/src/vec/mod.rs` 995/1027 行)
- 平臺:本機 HiSilicon aarch64;x86_64 僅 codegen 形狀對照

## benchmark 實際測甚麼

```rust
let mut vec = Vec::<i32>::new();
b.iter(|| {
    vec.push(0);
    black_box(&vec);
});
```

兩個決定性細節:

1. **vec 跨迭代從不清空**,無限增長(libtest 多輪校準,最終長度上億)——絕大多數迭代走 fast path,doubling `grow_one` 的攤銷貢獻趨近 0。實測 pre-reserve 後只快 6.7%(2.68 → 2.51 ns),證明 realloc 不是主成本。
2. **`black_box(&vec)` 逃逸了 vec 的地址**——強制每輪從記憶體重讀 `(ptr, cap, len)` 並把 `len+1` 寫回記憶體。這是 benchmark 有意義的前提(否則 LLVM 會把整個迴圈向量化/常量化),但也決定了它測的是甚麼。

## 正式基線與 perf

```text
slice::push    2.48–2.49 ns/iter(≈7.2 cycles/push)
```

IPC **1.50**,branch miss 0.04%,L1d miss 1.05%,**backend stall 69.6%**。`perf record` 99.26% 在 bench 閉包,熱迴圈(內聯後的完整 fast path):

```asm
loop:
  ldr  x23, [x20, #16]      ; len       ← 上一輪剛寫回的值
  ldr  x8,  [x20]           ; cap
  cmp  x23, x8
  b.ne fast                 ; len != cap → fast path
  bl   grow_one             ; 冷路徑
fast:
  ldr  x8, [x20, #8]        ; ptr
  add  x9, x23, #1
  str  wzr, [x8, x23, lsl #2] ; 寫元素
  str  x9, [x20, #16]       ; 寫回 len   → 下一輪的 ldr 依賴這條
  b    loop                 ; (實際被展開兩份)
```

樣本聚集在 `str len`(50.9%)與緊隨的 `ldr`(20.1%、12.6%),是典型的 **store→load 轉發往返**歸因:每輪的 `ldr len` 依賴上一輪的 `str len`,約 7 cycles/迭代正是這條 serial 鏈的延遲,不是指令數(每輪僅 ~10 條)也不是分支。與 binary_search 一節同類——backend 依賴鏈瓶頸;差別是那邊是 load→csel→address,這邊是 store→forward→load。

## 各成本成分的固定迭代分解(1e8 次 push)

| 變體 | ns/push | 說明 |
|---|---:|---:|
| blackbox(=官方 bench 形狀) | 2.68 | 全部三欄位往返 + 攤銷 grow |
| pre-reserved + blackbox | 2.51 | 去掉 grow:只省 6.7% |
| 無 black_box | 0.78 | len/ptr 留在暫存器,LLVM 保留逐元素 store |
| `extend(repeat_n)` | **0.13** | 批量:len 每批寫一次,內圈向量化 |

三檔階梯正好給出成本歸屬:**記憶體往返貢獻 ~1.9 ns(71%)**,逐元素 store + 迴圈 bookkeeping ~0.65 ns,真正的「容量檢查 + 元素寫入」在批量形狀下只值 0.13 ns。

## aarch64 / x86_64 對比

用與 `push_mut` 相同欄位佈局和控制流的 probe 生成兩 ISA fast path:

- aarch64:`ldp len,cap → cmp → b.ne → ldr ptr → str elem → str len`
- x86_64:`mov len,cap → cmp → jne → mov ptr → mov elem → inc → mov len`

**逐指令同構,無任何結構性分歧**:沒有 select/branch 分歧(容量檢查是高度可預測分支,兩邊都該用分支),沒有向量化機會。x86 硬件上同樣會被 store→load 轉發延遲主導,差別只在各微架構的轉發延遲數值。這是三類 benchmark 中「兩平臺完全同構」的一類(同 dedup 標量、trim ASCII)。

## 判斷:std 無可改;benchmark 語義值得留意

1. **`push_mut` 實現已是最優形狀**:先讀 len、容量檢查、`grow_one` 出線、無條件寫元素寫 len——沒有多餘工作可刪。`#[cold]` 的 grow 路徑已在迴圈外。
2. **瓶頸是 benchmark 自己選擇的**:`black_box(&vec)` 造成的三欄位記憶體往返是度量意圖(模擬「編譯器無法把 Vec 欄位緩存在暫存器」的真實調用環境),不是 std 缺陷。刪掉它 benchmark 就不測 push 了。
3. 對用戶代碼的可移植結論:熱迴圈逐元素 `push` 的上限由 store→load 轉發決定(本機 ~2.7 ns);能改成 `extend`/批量的場景有 **20×** 空間,`with_capacity` 只值 ~7%。這是 API 選擇問題,不是 push 實現問題。
4. 唯一可探討的 std 方向:讓 `extend`/`from_iter` 一類批量路徑覆蓋更多模式(已有 specialization),或 LLVM 側更激進地把「不逃逸的 Vec」欄位 SROA 進暫存器——但對這個 benchmark 而言後者恰恰是被 black_box 刻意排除的。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../alloctests/2cf0e8badf7482bf/out/allocbenches-2cf0e8badf7482bf --bench 'slice::push' --exact

build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 -C target-cpu=native \
  /tmp/push_candidates.rs -o /tmp/push_candidates
/tmp/push_candidates {blackbox|registerized|prereserved|extend} 100000000
# x86 形狀:/tmp/push_codegen.rs → llvm-ir → llc -mtriple=x86_64(剝 aarch64 features)
```

---

# `vec::bench_in_place_zip_iter_mut`:名不符實的 indexed 迴圈,2/3 時間花在被強制保留的標量 epilogue

- 日期:2026-08-18
- 分析對象:`library/alloctests/benches/vec.rs::bench_in_place_zip_iter_mut`
- 接口:`slice::iter_mut().enumerate().for_each` + `subst[i]` 索引(名字裏的 "zip" 並不存在——真正用 `zip` 的是隔壁 `bench_in_place_zip_recycle`)
- 平臺:本機 HiSilicon aarch64;x86_64 僅 IR/codegen 形狀對照

## benchmark 實際測甚麼

```rust
let mut data = vec![0u8; 256];
let mut subst = vec![0u8; 1000];   // 隨機填充
b.iter(|| {
    data.iter_mut().enumerate().for_each(|(i, d)| {
        *d = d.wrapping_add(i as u8) ^ subst[i];
    });
});
```

256 字節原地 mangle;`subst[i]` 是帶邊界檢查的索引訪問(panic 路徑存在),不是 `zip`。`b.bytes` 未設置,無 MB/s 輸出。

## 正式基線與熱點

```text
bench_in_place_zip_iter_mut    24.56–24.58 ns/iter(≈71 cycles,0.096 ns/byte)
bench_in_place_zip_recycle     37.35–37.38 ns/iter(對照:collect 重建 + 真 zip)
```

正確 `--exact vec::...` filter 下的 perf:IPC **5.91**,branch/L1d miss 0.00%。(方法記錄:第一次 perf 用了不帶 `vec::` 前綴的 filter,匹配 0 個 test,1.6 ms 全是啓動成本,已丟棄重測;第一版複製品又把 `black_box(&data)` 誤放進迴圈內,49 ns 與正式值差 2×,同樣已修正——這個 bench 的 `black_box(data)` 在 `b.iter` **之外**,迴圈內部無 black_box。)

`perf annotate`(99.83% 在 bench 閉包)的樣本分佈是決定性證據:

```asm
; NEON 主迴圈:每輪 32 bytes,~10–14% 樣本
ldp  q2, q1, [x9, #-16]      ; 10.35%(data 32B)
ldp  q3, q4, [x10, #-16]     ;        (subst 32B)
add/add/add/add v...         ; +index 向量
eor  v2/v1                   ; ^subst
stp  q2, q1, [x9, #-16]
b.ne loop

; 標量尾迴圈:~64% 樣本 ← 主要成本
ldrb w10, [x22, x9]          ;  3.96%
ldrb w11, [x21, x9]          ; 39.09%
add/eor
strb w10, [x22, x9]          ; 20.89%
b.ne tail
```

## 爲甚麼 256 整除 32 還有 32 輪標量尾巴

向量迴圈前的 trip-count 計算是:

```asm
mov  w8, #0x20               ; 32
ands x9, x19, #0x1f          ; n % 32(n=256 → 0)
...                          ; 餘 0 時取 32
sub  x26, x19, x8            ; n_vec = 256 - 32 = 224
```

即 LLVM 的 **requiresScalarEpilogue** 模式:`n_vec = n − (n%VF==0 ? VF : n%VF)`——**最後 32 個元素被強制留給標量迴圈**,即使長度整除向量寬度。7 輪 NEON(~10–15 cycles)+ 32 輪標量(~48–60 cycles)+ 每個 `b.iter` callback 重算的 min/alias guards(`cset w27` 別名檢查、`csel` 長度鉗制),合計 ≈71 cycles,與 24.6 ns 吻合。**2/3 的時間花在收尾和守衛,不在向量本體。**另外還有 `cmp x19, #0x21`:長度 <33 或 alias 檢查失敗時整段走標量。

這個結構是 `subst[i]` 可 panic 的副作用:向量化器給帶側出口(bounds-check panic)的迴圈保留精確標量尾部,並對兩個獨立 Vec 做運行時 alias 檢查。

## 候選實測(standalone,`#[inline(never)]`,長度對 callee 不透明)

| 形狀 | generic(NEON) | `-C target-cpu=native`(SVE) |
|---|---:|---:|
| indexed(=bench 現狀形狀) | 29.90 | 48.02 |
| zip | **14.80** | **13.15** |
| 手動等長 truncate + 索引 | 14.87 | 13.57 |

同源碼在 bench 內聯上下文(長度=常量可見)的複製品:generic ~3–6 ns、native SVE 8.4 ns——**正式 24.6 ns 的形狀依賴於「長度躲在 Vec 欄位後、每 callback 重讀」這個上下文**;複製實驗必須保持該不透明性纔可比。

三個獨立結論:

1. **zip 對 indexed 在通用(非內聯)形狀下快 2–3.7×**:去掉 bounds-check 側出口後,守衛更簡單、無 panic 精確性約束。
2. **native/SVE 對這個 indexed 形狀反而回退**(48 vs 29.9):SVE 版本的 gather/predication 形狀對帶側出口的迴圈更笨重;但對 zip 形狀 SVE 微幅領先。
3. 正式二進制是 generic CPU 構建(函數內只有 v 暫存器、無 z/p),機器有 SVE 也用不上——std bench 的默認構建不吃 native 向量特性。

## aarch64 / x86_64 對比

用 generic aarch64 IR(剝 target-features;native IR 含 `vscale`,llc 跨目標直接 crash——SVE IR 不可移植到 x86)lower 到 SSE2 與 AVX2:

- 兩版都得到向量本體(indexed 15 條 `paddb/pxor` 類、zip 9 條),**標量 epilogue 結構原樣保留**——它在 IR 層就已定形,與 ISA 無關。
- 所以 x86 上同樣是「向量本體 + 強制標量尾 + guards」的形狀,AVX2 只是把本體變寬,尾巴問題不變;真正消掉尾巴要 AVX-512 masked tail 或 SVE predication(而後者在 rustc 默認構建中不啓用)。
- 兩平臺無 BinaryHeap 式的結構分歧;分歧軸是「誰能用 masked/predicated tail」,是 ISA 能力 × 編譯配置問題。x86 無硬件時間,僅形狀判斷。

## 結論

1. 這個 benchmark 測的是「帶 bounds-check 的 256B mangle」:~1/3 向量工作 + ~2/3 被 requiresScalarEpilogue 強制的 32 輪標量尾與 per-callback guards。IPC 5.91、零 miss——瓶頸是**形狀**,不是微架構事件。
2. **名字有誤導**:`zip_iter_mut` 實際用 `enumerate + subst[i]`,不是 `zip`。把源碼真的改成 `zip` 在通用形狀下快 2–3.7×,還恰好讓名字變得誠實;這是 benchmark 源碼或用戶代碼層面最便宜的改進。
3. std 無可改物件(這是用戶側迭代器選擇 + LLVM epilogue 策略的組合);LLVM 側的槓桿是對「長度整除 VF 且無 interleave 需求」的迴圈放寬 requiresScalarEpilogue,或在 aarch64 啓用 predicated epilogue(`-mllvm -prefer-predicate-over-epilogue`類方向)。
4. 建議給 bench 設 `b.bytes = 256`,並考慮更名或改真 zip,與 `recycle` 形成有效對照。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../alloctests/2cf0e8badf7482bf/out/allocbenches-2cf0e8badf7482bf \
  --bench 'vec::bench_in_place_zip_iter_mut' --exact

# 候選(注意保持長度不透明;iterations 固定)
build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 \
  /tmp/zip_mut_candidates.rs -o /tmp/zip_mut_generic          # generic
/tmp/zip_mut_generic {indexed|zip|trunc|official} 256 10000000
# x86 形狀:/tmp/zip_mut_codegen.rs → generic IR → llc -mcpu=x86-64 / -mattr=+avx2
```

## 修正與機理補充(2026-08-18 後續實驗)

對「std 側方向」的原始表述需要修正。三個新對照(全部 `#[inline(never)]`、運行時長度、native):

| 形狀 | ns/iter | codegen |
|---|---:|---|
| 裸 slice 上照抄 SpecFold 形狀:`while len-i>=8` + `from_fn(get_unchecked(i+local))` | 34.58 | **向量化** |
| 同上改 chunk 計數 for 迴圈 | 33.36 | 向量化 |
| 塊狀 `read_unaligned::<[u8;8]>` | 33.36 | 向量化 |
| 真實鏈 `ArrayChunks<Map<slice::Iter>>` | 97.95 | 標量 |
| 真實鏈 `ArrayChunks<Copied<slice::Iter>>` | 98.03 | 標量 |

結論修正:**`from_fn` 逐元素索引形狀本身不是病因**——它在裸 slice 上向量化正常。退化只在真實 adapter 鏈中出現,且與外層是 `Map` 還是 `Copied` 無關。病因在 `__iterator_get_unchecked` 通過 `&mut self.iter`(`slice::Iter { ptr, end }` 結構體字段)訪問:`from_fn` 的閉包捕獲 `&mut` iterator,到達 LoopVectorizer 時訪問仍以結構體內存形式存在,向量化被放棄;後續 pass 才把標量迴圈清成乾淨的 `ldr/ror/add`,為時已晚。與 `max_by_key` 一節的「IR 到達 pass 時的形狀決定成敗」同機理。

因此兩條可行修復路線等價地址這個病因:

1. **std 特化繞道**:對 inner 可還原為連續 slice 的情形(`slice::Iter`/`Copied`/`Cloned`/`Map` over slice),讓 fold 走 `as_chunks` 型塊狀訪問,避開 per-element `&mut` 結構體訪問。需要比 TRA 更窄的一層特化,並逐一驗證非連續 TRA 源不受影響:`vec::IntoIter` 是 owned 元素(塊狀預讀後 `f` panic 時的 drop 責任)、`Zip` 是雙緩衝(無單一連續塊)、`Map` 閉包副作用的執行順序(TRA 契約允許亂序,但需覆核文檔契約)。
2. **LLVM 側**:讓 iterator 結構體的 SROA 在 LoopVectorizer 前完成,或增強向量化器對 struct-field-based stepped index 的識別——不改 std,收益自動覆蓋所有同形狀代碼。

---

# `char::methods::bench_non_ascii_char_to_uppercase`:34% 的輸入「無映射」卻付出最貴的雙重 binary search

- 日期:2026-08-18
- 分析對象:`library/coretests/benches/char/methods.rs:78`
- 接口:`char::to_uppercase` → `conversions::to_upper`(`library/core/src/unicode/unicode_data.rs:1048`)→ `conversions::lookup`
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

`(128..=255).cycle().take(10_000)` 對 Latin-1 上半區的 128 個字符循環做 `to_uppercase().count()`。調用鏈:`to_upper` 先走 `c < '\u{B5}'` 的 ASCII fast path(覆蓋輸入的 41%),其餘 59% 進 `lookup(c, &UPPERCASE_LUT)`:先對 **185 條** `singles` 範圍表做 binary search(固定 8 輪),miss 再對 **102 條** `multis` 表做第二次 binary search(7 輪)。

輸入的成本分佈是關鍵:

| 輸入類別 | 佔比 | 路徑 |
|---|---:|---|
| 0x80–0xB4 | 41% | fast path,不進 lookup |
| à–þ 等有映射字母 | ~25% | singles 8 輪命中 |
| **¶·º»¼×÷ 等無映射字符** | **~34%** | **singles 8 輪 miss + multis 7 輪 miss,最貴路徑** |

## 正式基線與 perf

```text
bench_non_ascii_char_to_uppercase    164.2–168.4 µs(16.7 ns/char)
bench_non_ascii_char_to_lowercase    121.0 µs(12.1 ns/char)
bench_ascii_char_to_uppercase         24.7 µs(2.47 ns/char)
```

uppercase 比 lowercase 慢 38%,原因有二:fast path 界更低(0xB5 對 0xC0,少 9 個百分點的直通),以及 **multis 表 102 條對 1 條**——lowercase 的 miss 幾乎免費,uppercase 的 miss 要再付 7 輪搜索。

perf:IPC 2.43,branch miss 0.17%,L1d miss 0.00%——表全在 L1,瓶頸是 `csel` binary search 的串行依賴鏈(與 binary_search 一節同構,樣本 54.9% 聚在 search 迴圈 backedge)。符號分佈:`conversions::lookup` **83.4%** + `to_upper` 12.3%;`lookup` 無 `#[inline]`,在 libstd.so 中是獨立符號,每字符一次跨 crate 調用。

## 原型:把 fast path 從 0xB5 擴到整個 Latin-1

Latin-1 的 uppercase 映射已被 Unicode 凍結且極簡單:µ→U+039C、ß→"SS"、à–þ(除 ÷)→ −0x20、ÿ→U+0178,其餘映射到自身。用一段 match 覆蓋 `c < 0x100`:

| | ns / 10k chars | vs current |
|---|---:|---:|
| current(std `to_uppercase`) | 163,053 | — |
| Latin-1 fast path | **25,755** | **-84.2%** |
| (參照:ASCII bench) | 24,670 | — |

對 U+0080..=U+00FF 逐字符與 `char::to_uppercase` 輸出比對通過(含 µ/ß/ÿ/×/÷ 特例)。Latin-1 直通後,本 benchmark 與 ASCII 版本打平——binary search 完全移出熱路徑。

## 判斷與局限

1. **收益真實且落地面窄**:西歐文本的非 ASCII 字符幾乎全在 Latin-1;`to_lower` 對稱可做(界從 0xC0 擴到 0x100,特例只有 µ 已在下半?lowercase Latin-1 特例更少)。實現只是 `to_upper`/`to_lower` 各加一段凍結區 match,不動表生成器,不影響 ≥ U+0100 的路徑(僅多一次已在暫存器的比較)。
2. 更通用的方向是治「miss 最貴」:在 LUT 前加 Changes_When_Uppercased bitmap 快速拒絕,或表生成器對低碼位區輸出直查表。複雜度高於 Latin-1 特判,收益覆蓋面更廣(其他無映射腳本),可作第二步。
3. `lookup` 缺 `#[inline]` 值得單獨小測(消除跨 so 調用開銷),但 binary search 本體纔是大頭。
4. ISA 角度無新發現:search 迴圈是 binary_search 一節的 `csel` 形狀,x86 為 `cmov` 同構;本 benchmark 的問題在算法/表結構層,與平臺無關。
5. 誠實邊界:原型未構造 `ToUppercase` iterator 殼(直接返回 `[char; 3]`);但 ASCII bench(同 iterator 殼)24.7 µs 與原型 25.8 µs 相當,殼的成本可忽略,對比成立。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../corebenches-ed47559efb842e7d --bench 'char::methods::bench_non_ascii_char_to_uppercase' --exact

build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 -C target-cpu=native \
  /tmp/upper_latin1_candidates.rs -o /tmp/upper_latin1_candidates
/tmp/upper_latin1_candidates verify
/tmp/upper_latin1_candidates {current|latin1} 10000
```

## 落地驗證(2026-08-18):patch 進 `unicode_data.rs`,官方 harness 確認 -82.5%

已將 Latin-1 fast path 直接寫入 `library/core/src/unicode/unicode_data.rs::to_upper`(注意:該文件由 `unicode-table-generator` 生成,正式 PR 應改生成器;此處為實驗性直改,+16 行),`./x bench` stage2 重建後跑官方 corebenches:

| benchmark | patch 前 | patch 後 | 變化 |
|---|---:|---:|---:|
| non_ascii_char_to_uppercase | 164.2–168.4 µs | **29.18 µs(±0.15,三輪)** | **-82.5%** |
| ascii_mix_to_uppercase | 94.97 µs | **24.87 µs** | **-73.8%**(意外收穫:mix 輸入含 Latin-1) |
| ascii_char_to_uppercase | 24.67 µs | 21.20 µs | -14.1% |
| non_ascii_char_to_lowercase | 120.98 µs | 121.10–121.22 µs | 不變(未動,無干擾) |
| ascii_char_to_lowercase | 24.67 µs | 24.67 µs | 不變 |

正確性:`./x test library/coretests --test-args 'char::'` 全部通過(37 + 13 個測試,0 failed;此前一次 `--test-args 'char'` 因 `tail` 截斷只看到 doc-tests 段,已重跑取完整輸出)。standalone 原型預測的 -84% 與官方 harness 實測的 -82.5% 一致。

殘餘的 29.2 µs 對 ASCII 版 21.2 µs 的差距是 match 分派與 `ToUppercase`(可能雙字符)iterator 殼的成本。ascii_char_to_uppercase 的 -14% 來自 `to_upper` 內聯代碼形狀變化的間接影響,非直接目標。

落地路徑:把同樣邏輯移入 `src/tools/unicode-table-generator` 的輸出模板,並對 `to_lower` 做對稱處理(Latin-1 lowercase 特例更少:只有 U+00C0..=U+00DE 減區間,無 multis),然後跑完整 `library/coretests` + `library/alloctests` 套件。

## `to_lower` 對稱處理(2026-08-18):官方 harness 確認 -78.2%,mix lowercase 額外 -66%

Latin-1 lowercase 的凍結映射比 uppercase 更簡單:只有 À..=Þ(除 ×)加 0x20,無 multis、無跨平面特例。同樣直改 `unicode_data.rs::to_lower`(+12 行;正式落地仍應改 generator)。映射先以 standalone 對未修改 stage1 std 的 `char::to_lowercase` 逐字符(U+00C0..=U+00FF)驗證通過,再 stage2 重建。

官方 corebenches(與 uppercase patch 疊加後的完整六項):

| benchmark | 原始 baseline | uppercase patch 後 | 兩 patch 後 | 總變化 |
|---|---:|---:|---:|---:|
| non_ascii_char_to_lowercase | 120.98 µs | 121.10 µs | **26.47 µs** | **-78.1%** |
| ascii_mix_to_lowercase | 70.64 µs | 70.80–71.41 µs | **23.83 µs** | **-66.3%** |
| ascii_char_to_lowercase | 24.67 µs | 24.67 µs | 21.19 µs | -14.1% |
| non_ascii_char_to_uppercase | 164.2–168.4 µs | 29.18 µs | 28.97 µs | -82.8% |
| ascii_mix_to_uppercase | 94.97 µs | 24.87 µs | 24.79 µs | -73.9% |
| ascii_char_to_uppercase | 24.67 µs | 21.20 µs | 21.19 µs | -14.1% |

uppercase 三項在本輪未動,數值穩定復現,互不干擾。`./x test library/coretests --test-args 'char::'` 37 + 13 全部通過。

lowercase 殘餘 26.5 µs 略優於 uppercase 的 29.0 µs,因為 lowercase 無 ß→SS 類雙字符輸出,match 更窄。ascii_char_to_lowercase 的 -14% 與 uppercase 側對稱,同樣來自 `to_lower` 整體代碼形狀變化。

至此 char 大小寫六個 benchmark 全部受益,無一回退;工作樹修改為 `unicode_data.rs` +28 行(兩段凍結區 match)。上游化待辦不變:移入 `unicode-table-generator` 模板 + 完整測試套件。

---

# `slice::starts_with_diff_one_element_at_end`:一次 memcmp 調用,96% 時間在 glibc 向量迴圈,無划算的 std 修改

- 日期:2026-08-19
- 分析對象:`library/alloctests/benches/slice.rs:74`
- 接口:`[T]::starts_with` → `PartialEq for [T]`(BytewiseEq 特化)→ `intrinsics::compare_bytes` → libc `memcmp`/`__memcmpeq`
- 平臺:本機 HiSilicon aarch64,glibc 2.35+

## benchmark 實際測甚麼

100 個 `i32` 的 haystack `(0..100)`,needle 前 99 個相同、最後一個是 0——「掃到最後一個元素才發現不匹配」的等長最壞情形。`i32: BytewiseEq` 使整個比較退化為一次 **400-byte memcmp**。

## 正式基線(三輪穩定)

```text
starts_with_diff_one_element_at_end    10.21–10.26 ns/iter
starts_with_same_vector                 0.35 ns/iter
starts_with_single_element              0.35 ns/iter
ends_with_diff_one_element_at_beginning 2.42 ns/iter
```

三個要點:

1. **same_vector 的 0.35 ns 不是真的 memcmp**:needle 就是 haystack 本身,LLVM 在內聯後證明兩個指針相等,整個比較常量摺疊——它測的是空迴圈,不能當作 100 元素匹配的成本。
2. ends_with 的 2.42 ns 同樣是 diff 情形,但差異在 needle 開頭→ 但 `ends_with` 比的是 haystack **尾段**,其 needle 第一個元素(0 對 1)立即不匹配,glibc 頭部 16B 檢查就返回——不是 400B 掃描。
3. 真正掃完 400B 的只有 diff-at-end:10.24 ns ≈ 30 cycles,~13.4 B/cycle。

## perf:96.4% 在 libc memcmp

`perf record` 顯示 96.38% 樣本在 `libc.so.6 [.] memcmp`(實際入口 `__memcmpeq`——編譯器知道只需要相等性,調了 glibc 的 equality-only 入口;閉包符號因 LLVM function merging 顯示為 ends_with 名字,call graph 確認是本 bench)。熱點在 glibc 的 64B/輪 NEON 主迴圈:

```asm
ldr  q0/q1/q2/q3/q4/q5 ...    ; 兩側各 48B(含 [x0,#64]! 預進位)
eor  v0, v0, v1               ; 差異檢測
umaxp v0, v0, v1              ; 歸約
fmov x6, d0                   ; 到通用暫存器
ccmp/b.eq loop                ; 每 64B 一次 early-exit 檢查
```

樣本聚在主迴圈 load(63% 單條 `ldr q`,PMU skid 聚集)。400B = 頭部處理 + ~6 輪主迴圈,30 cycles 與 glibc 這個形狀的理論值吻合——**已在 glibc 手寫向量例程的吞吐上**。

## 候選對照:std 能繞過 libc 調用嗎

三種形狀 × 三種輸入(100 × i32,固定 5000 萬次):

| ns/iter | diff-end | match(全匹配) | diff-start |
|---|---:|---:|---:|
| 現狀(memcmp) | 12.66 | 13.59 | **3.46** |
| 手寫 u64-chunk 無早退 | **10.40** | **10.41** | 10.41 |
| 手寫 64B-block 早退 | 13.23 | 13.70 | **2.81** |

尺寸敏感性(diff-end):

| size(i32) | memcmp | u64 無早退 | 64B 早退 |
|---|---:|---:|---:|
| 16(64B) | 4.98 | 6.91 | **2.81** |
| 100(400B) | 12.66 | **10.40** | 13.23 |
| 1000(4KB) | 103.7 | **101.3** | 145.2 |

沒有一個候選全面獲勝:

- 無早退 u64 版在「差異在尾部/全匹配」快 ~18%(省下 libc 調用與頭部分派),但 diff-start 慢 3×——它必須掃完全部;
- 64B 早退版在小輸入和 diff-start 贏,但大輸入的每塊分支開銷讓它比 memcmp 慢 40%;
- memcmp 的頭部成本(PLT 調用+對齊分派)在 400B 檔約佔 2–3 ns,是 diff-end 情形唯一可省的部分,而省它的代價是失去 glibc 對其它分佈/尺寸的全面調優。

## 結論

1. 這個 benchmark 測的是 **glibc `__memcmpeq` 對 400B 等長輸入的全掃描吞吐**(~13 B/cycle),std 側只貢獻長度檢查與一次調用;10.2 ns 的基線已貼近該例程的硬件上限。
2. **無 std 可改**:`BytewiseEq → compare_bytes → libc` 這條路徑把工作交給了平臺最優實現;任何 Rust 側替代在部分分佈上贏、在其它分佈上輸,且輸入分佈(差異位置、長度)std 無從預知——與 binary_search 的 branch-vs-csel 結論同構:現狀是無先驗下的正確選擇。
3. benchmark 套件本身的兩個測量陷阱值得記錄:`same_vector` 的 0.35 ns 是指針相等被常量摺疊,不代表匹配成本;`ends_with_diff_one_element_at_beginning` 實際是「第一字節就不匹配」的最好情形,與 starts_with 的最壞情形不對稱,兩者不可直接對比。
4. x86 側同構無懸念:同一條 `compare_bytes` → glibc `__memcmpeq`(AVX2 版),同樣是庫例程吞吐問題,無 codegen 分歧,故未做 x86 對照實驗。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../allocbenches-2cf0e8badf7482bf --bench 'starts_with' 

build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 -C target-cpu=native \
  /tmp/starts_with_candidates.rs -o /tmp/starts_with_candidates
/tmp/starts_with_candidates {eq|u64|u64early} {16|100|1000} {diff-end|match|diff-start} <iters>
```

---

# `binary_heap::bench_pop`:child-choice 分支病灶第三現場,`select_unpredictable` 原型 -34%

- 日期:2026-08-19
- 分析對象:`library/alloctests/benches/binary_heap.rs:81`
- 接口:`BinaryHeap::pop` → `sift_down_to_bottom`(`library/alloc/src/collections/binary_heap/mod.rs:897`)
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

每輪:向帶容量的空 heap `extend((0..10_000).rev())`,再 `pop()` 到空。兩個要點:

1. **extend 幾乎免費**:降序輸入本身就是合法 max-heap,`RebuildOnDrop` 的 rebuild 從 `rebuild_from = 0` 起對已成堆資料做 sift_down 全部第一輪比較即退出,O(n) 且完美可預測;
2. **成本全在 10,000 次 pop**:每次 pop 取尾元素放到根,`sift_down_to_bottom` **無條件沉到底**(每層一次 sibling 比較 + 搬移,無 early-exit),再 `sift_up` 回浮。隨着 heap 縮小,層數從 13 遞減,總 sibling 比較約 10⁴ × ~12 ≈ 1.2 × 10⁵ 次/輪,每次都在隨機化的堆上近似 50/50。

## 正式基線與 perf

```text
bench_pop    438,284–438,606 ns/iter(43.8 ns/pop)
```

IPC **1.46**,branch miss **15.87%**(5.15 億次/校準運行),L1d miss 0.01%——與 `bench_from_vec`(miss 20.8%)、`bench_find_smallest_1000`(9.1%)同病:**aarch64 對 `child += (left <= right) as usize` 生成真分支**。`perf annotate`(98.7% 單符號)確認熱點在 sift_down_to_bottom 迴圈:

```asm
ldp  w16, w12, [x12]     ; left/right 一次載入
cmp  w16, w12
b.le take_right           ; ← unpredictable sibling choice(15.9%+8.9% 樣本聚集)
...
str  w17, [x9, x15, lsl #2]  ; hole move(19.4%)
```

pop 的獨特之處:`sift_down_to_bottom` 註釋明言為 pop 場景設計(來自尾部的替換元素大概率屬於底層,沉到底再回浮省一半比較)——它**沒有** early-exit 分支,迴圈裏只剩 sibling choice 和 loop 條件兩種分支,因此 miss 率(15.9%)幾乎全由 sibling choice 貢獻,比 from_vec 的混合形態更純粹。

## `select_unpredictable` 原型(同構複製品,排序輸出驗證通過)

| /iter(1000 輪固定) | current | select | 變化 |
|---|---:|---:|---:|
| ns | 427,825 | **280,665** | **-34.4%** |
| cycles | 1.239G | 0.813G | -34.4% |
| instructions | 1.789G | 1.722G | -3.8% |
| branches | 340.9M | 164.6M | -51.7% |
| branch misses | **54.97M** | **1.31M** | **-97.6%** |
| IPC | 1.44 | 2.12 | +47% |

複製品 current 427.9 µs 對正式 438.3 µs(差 2.4%,Hole 細節與 RebuildOnDrop 殼略異),對齊良好。branch misses 幾乎歸零——sift_down_to_bottom 無 early-exit,`csel` 化後迴圈裏不再有任何資料相關分支,殘餘 0.8% 是 sift_up 與外層。這也解釋了為何 -34% 比 find_smallest 的 -37%、from_vec 的 -41% 略小:pop 的每層搬移(`str`)佔比更高,分支只是成本的一部分。

## 結論

1. `bench_pop` 是 BinaryHeap sibling-choice 分支病灶的**第三個獨立現場**,且形態最純(無 early-exit 干擾):miss 率 15.9%,`select_unpredictable` 化後 -97.6% misses、-34% 時間。
2. 至此三大 BinaryHeap 熱路徑全部實證同一修復點:`from_vec` -41%、top-k 替換 -37%、`pop` -34%——都指向 `Hole` 版 sift_down 家族(`sift_down_range`/`sift_down_to_bottom`)的 `child += (cmp) as usize` 行。x86_64 的 `sbb`/`cmov` codegen 天然無此問題(from_vec 節已證),這是 aarch64 特有的 if-conversion 缺失。
3. 落地評估與前兩節共享的局限不變:大元素(72B)收益消失、昂貴 comparator 未測、ascending 類可預測輸入在 from_vec 有 +6% 回退;但 pop 場景的輸入(堆頂替換元素)本質上就是高熵的,可預測輸入不構成 pop 的常見情形,回退風險比 from_vec 低。改動即把兩處 `child += ... as usize` 換成 `hint::select_unpredictable`,建議在真實 `binary_heap/mod.rs` 上打補丁跑完整 alloctests suite + 全部 BinaryHeap benchmark 矩陣。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../allocbenches-2cf0e8badf7482bf --bench 'binary_heap::bench_pop' --exact

build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 -C target-cpu=native \
  /tmp/heap_pop_candidates.rs -o /tmp/heap_pop_candidates
/tmp/heap_pop_candidates verify
perf stat -e cycles,instructions,branches,branch-misses \
  /tmp/heap_pop_candidates {current|select} 1000
```

---

# `btree::map::iteration_mut_1000`:健康的樹遍歷,成本在結構不在事件;iter_mut 對 iter 只差 4–6%

- 日期:2026-08-20
- 分析對象:`library/alloctests/benches/btree/map.rs:201`(`bench_iteration_mut`,size=1000)
- 接口:`BTreeMap::iter_mut` → `LazyLeafRange<ValMut>::next_unchecked` → `navigate.rs::next_kv`(葉內推進 + 滿邊界時 ascend/descend)
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

1000 個隨機 `i32→i32`(B=6,節點容量 11,實測樹高 3),`iter_mut()` 全遍歷,每個 `(&K, &mut V)` 過 `black_box`。`Iter/IterMut::next` 沒有 fold/try_fold 覆寫——每個元素都走一次 `next()` 狀態機:`length` 遞減、葉內 `right_kv` 推進;葉尾則沿 parent 指針 `ascend`,遇 internal KV 後再下降到下一個 first leaf。

## 正式基線與 perf

```text
iteration_mut_1000      1,865–1,880 ns/iter(1.87 ns/元素)
iteration_1000          1,773–1,776 ns/iter(對照:不可變)
iteration_mut_20        24.51 ns(1.23 ns/元素)
iteration_mut_100000    365–409 µs(3.7–4.1 ns/元素,出 L1 後)
```

IPC **3.64**,branch miss 1.61%,**L1d miss 0.00%**(1000 元素的樹 ~30KB 常駐)。`perf annotate`(99.7% 單符號)樣本分佈在三個結構區:葉內推進的 `cbz/ldrh len` 檢查(20.4%+5.8%)、`next_kv` 的 ascend 迴圈 `ldr x14,[x13]` + `ldrh [x13,#96]`(7.7%+14.0%)、下降迴圈 `ldr [x15]`(9.7%)。**沒有單一病灶——熱點就是樹遍歷本身的指針追逐與每元素狀態機。**

## 對照矩陣(standalone,1M 次固定迭代)

| 形狀 | ns/元素 | branch miss | 說明 |
|---|---:|---:|---|
| `iter_mut` | 1.77 | 1.93% | ≈正式 bench(1.87,殼差) |
| `iter`(不可變) | 1.69 | — | mut 貴 4–6%:`ValMut` 雙指針簿記 |
| `values_mut` | 1.59 | — | 少一個 K 引用的物化 |
| **`Vec<(i32,i32)>` iter_mut** | **0.36** | 0.10% | **5× 差距 = BTree 結構稅** |

Vec 對照隔離出結論:BTree 遍歷的 1.4 ns/元素額外成本不是 miss 事件(兩者 L1d miss 都≈0,branch miss 都低),而是**每元素指令數**:BTree 18.6 條/元素對 Vec 4.0 條/元素——狀態機檢查、node/idx 簿記、每 11 個元素一次的邊界爬樹。IPC 反而高達 3.63,機器在高效地執行多餘的工作。

## 判斷

1. **無 std 病灶可修**:這不是 BinaryHeap 那種 miss 災難(15–21%),也不是 epilogue 那種形狀缺陷;1.6% miss、0% L1d miss、IPC 3.64 的遍歷已經被硬件執行得很好。要快只能減指令——即 `fold`/`try_fold` 特化:按葉節點批量發元素(葉內 `for i in 0..len` 直線迴圈),把爬樹成本從每元素攤到每節點。已知方向(`Iter` 缺 fold 覆寫),非本 benchmark 暴露的新問題;收益上限可從 `values_mut`(-10%)與葉內佔比估計約 20–40%,值得原型但工程量在 navigate 層不小。
2. `iter_mut` 對 `iter` 的 4–6% 差距是 `ValMut` 借用形態的固有簿記,合理。
3. benchmark 自身健康:隨機鍵、樹高與真實使用一致;100000 版(3.7–4.1 x ns/元素)補充了出緩存後的形態,其 variance(±26 µs)來自 TLB/L2,不是測量問題。
4. 未做 x86 對照:遍歷是指針追逐+標量簿記,無向量化與 if-conversion 分歧空間,兩平臺 code shape 同構無懸念。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../allocbenches-2cf0e8badf7482bf --bench 'btree::map::iteration'

build/aarch64-unknown-linux-gnu/stage1/bin/rustc --edition=2021 -C opt-level=3 -C target-cpu=native \
  /tmp/btree_iter_candidates.rs -o /tmp/btree_iter_candidates
/tmp/btree_iter_candidates {mut|ref|values|vec} 1000 1000000
```

---

# `ascii::long::is_ascii_whitespace`:謂詞在第 6 字節就假,190 ns 全是 memcpy——benchmark 沒測到目標

- 日期:2026-08-20
- 分析對象:`library/coretests/benches/ascii.rs` 的 `@iter` 宏生成項(`bytes.iter().all(u8::is_ascii_whitespace)`)
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼(和它以爲的不同)

宏形狀決定一切:

```rust
bencher.iter(|| {
    let mut vec = LONG.as_bytes().to_vec();   // ← 每輪重新分配+複製 7000B
    { let bytes = &mut vec[..]; black_box(bytes.iter().all(u8::is_ascii_whitespace)); }
    vec
})
```

兩個事實疊加:

1. **每輪 `to_vec()` 複製 7000 字節**(這個宏是為 `make_ascii_uppercase` 類原地修改設計的,重建輸入是必要的;但 `@iter` 謂詞是只讀的,複製純屬遺留);
2. **LONG 的第 6 個字節是 'L'**(開頭 `"\n    La Guida…"`),`all(is_ascii_whitespace)` 在 6 個字節後短路返回 false。

三方證據:

- `case00_alloc_only`(空 body)**189.8 ns** ≡ `is_ascii_whitespace` **189.8–190.4 ns**,逐 ns 相同;`is_ascii_control`/`is_ascii_digit` 同樣 189.5–189.7(它們第 1 字節就假);
- `perf record`:65%+ 樣本在 libc 的 memcpy 內核 64B/輪 `ldp/stp` 迴圈(符號表歸給鄰近的 `__xpg_strerror_r`,實為 glibc 內部 memcpy 例程);
- standalone:對 7000B 輸入,early-exit(第 6 字節假)謂詞本體 **4.1 ns**,全掃描(全空白輸入)**3636 ns**——bench 的 190 ns 裏謂詞佔 ~2%。

`bencher.bytes` 還把 190 ns 折算成 "36984 MB/s" 的假吞吐,恰等於 alloc+memcpy 的速度。對比:`is_ascii`(唯一全真、真正掃完的謂詞)317 ns,其中 ~127 ns 纔是掃描本體。

## 結論

1. **這個 benchmark(以及 `@iter` 家族中除 `is_ascii` 外的全部 10 項)沒有測到它命名的東西**:輸入是英文書目文本,對 whitespace/digit/control/uppercase 等謂詞在頭幾個字節就短路,測得的 189.8 ns 是「分配 + 複製 7000B」的固定成本,謂詞貢獻 ~2%。
2. 因此在此 benchmark 上做 `is_ascii_whitespace` 的「優化」毫無意義,任何 std 修改都不可能移動這個數字(除非改掉 to_vec)。
3. Benchmark 修復建議(比任何 std 改動有價值):`@iter` 分支的宏不應 `to_vec()`(只讀謂詞直接借用靜態輸入);且每個謂詞應配「全真輸入」(全空白、全數字等)才能測到掃描成本,現狀只測了短路路徑。修好後,真正的問題纔可見:`all(is_ascii_whitespace)` 的全掃描是 0.52 ns/B 標量匹配(3636 ns / 7000B),對比 `is_ascii` 的 0.018 ns/B(SWAR/SIMD)有 ~29× 差距——bitset/SWAR 化這些 u8 謂詞纔是有數據支撐的候選,但必須先有能測到它的 benchmark。
4. 分類:與 `same_vector` 常量摺疊、`ends_with` 最好情形誤標同屬「benchmark 測量陷阱」類;本節無 ISA 對比必要(memcpy 是 libc 例程,謂詞未被執行)。

## 復現

```bash
LD_LIBRARY_PATH=... build/.../corebenches-14ea307f41bce867 \
  --bench 'ascii::long::is_ascii_whitespace' --exact   # ≡ case00_alloc_only
/tmp/ws_probe early   # 4.1 ns:LONG 形狀的謂詞本體
/tmp/ws_probe full    # 3636 ns:全空白輸入的真實掃描
```

---

# `num::flt2dec::strategy::*`:Grisu 快路徑健康;`exact_inf` 全部落入 Dragon 的 32-bit bignum 除法

- 日期:2026-08-20
- 分析對象:`library/coretests/benches/num/flt2dec/strategy/{grisu,dragon}.rs` 全部 19 項
- 接口:`grisu::format_shortest/format_exact`(帶 Dragon fallback)與 `dragon::format_shortest/format_exact`;bignum 為 `Big32x40`(u32 limb × 40)
- 平臺:本機 HiSilicon aarch64

## 基線總表(ns/iter,單輪代表值,變異 <2%)

| bench | grisu | dragon | grisu/dragon |
|---|---:|---:|---:|
| small_shortest | **33.2** | 166.4 | 5.0× |
| big_shortest | **69.6** | 3,461 | 49.7× |
| small_exact_3 | **23.0** | 86.0 | 3.7× |
| big_exact_3 | **27.4** | 828.5 | 30.2× |
| small_exact_12 | **38.7** | 152.7 | 3.9× |
| big_exact_12 | **52.5** | 1,826 | 34.8× |
| small_exact_inf | 1,058 | **1,010** | **0.95×(grisu 更慢)** |
| big_exact_inf | 42,152 | **41,967** | 1.00× |
| (grisu only) one/halfway/trailing_zero_exact_inf | 604–613 | — | — |

## 三個結論層次

**1. Grisu 快路徑工作正常,無分析必要。** shortest/exact-with-limit 檔位 23–70 ns,對 Dragon 有 4–50× 優勢,正是 Grisu3 設計目標;`{}` 格式化(`bench_small_shortest` 頂層版 write! 全鏈路)的主要成本也不在這裏。

**2. `exact_inf` 的 grisu ≈ dragon 不是巧合,是 100% fallback。** `grisu::format_exact` 是 `format_exact_opt(...).unwrap_or_else(dragon)`;要求 1024 位精確數字時 Grisu 的 64-bit 近似必然判定不可行返回 `None`,每次調用都白做一遍 Grisu 再全量走 Dragon(grisu 1,058 vs dragon 1,010 ns 的差值就是被丟棄的 Grisu 嘗試)。benchmark 名義上測 grisu,實際測 dragon——與 ascii 節同屬「測非所名」,但這裏是**設計如此**(fallback 是公開契約),不是 bug。

**3. Dragon `exact_inf` 的熱點是 32-bit limb bignum。** perf(99.3% 在 `dragon::format_exact`)樣本集中在兩個迴圈:

```asm
; div_rem_small(10):除以常數 10 的倒數乘法,每輪只消化 32 位
ldr  w14, [x9, x12]        ; 14.5%(load limb)
orr  x13, x14, x13, lsl 32
umulh x14, x14, x10        ; 1/10 定點倒數
lsr/str/msub               ; 商回寫 + 餘數
; bignum add 的 adcs 鏈(比較/加法)
ldr w / adcs w ×3          ; ~25% 合計
str  w4, [x0], #4          ; 11.3%(digit 輸出)
```

`Big32x40` 是 32-bit limb——在 64-bit 硬件上,`div_rem_small`、`add`、`mul_small` 每迭代只處理一半字寬。1024 個十進制位 × 每位一次 O(n) bignum 除 10,是 O(digits × limbs) 的平方級行為,42 µs 全花在這。

## 優化方向(未原型化,標記爲候選)

1. **64-bit limb bignum**(`Big64x20`):除 10 迴圈、adcs 鏈、輸出迴圈的迭代次數全部減半,`umulh` 開銷不變。預期對 exact_inf 類 ~1.5–2×,對 big_shortest(3.5 µs,同樣 Dragon)同比例。代價:`define_bignum!` 宏已參數化,改動集中;但 flt2dec 的 Dragon 路徑僅在「shortest 且 Grisu 失敗(<1%)」或「超高精度 exact」時到達,真實 workload 覆蓋窄,收益/工程比一般。
2. digit 批量化:每次 bignum 除法改除 10⁹(u32)或 10¹⁹(u64),一次取 9/19 個十進制位,把 O(digits) 次大數操作降為 O(digits/9)——這是比 limb 加寬更大的算法級槓桿,ryū/dragonbox 類現代實現的常規手法。
3. 不建議動 fallback 結構:`exact_inf` 白做的 Grisu 嘗試僅 ~50 ns(對 42 µs 無感);低精度檔位 fallback 命中率近 0,現狀合理。
4. ISA 對比無必要:umulh/adcs 鏈在 x86 是 mulx/adc 同構,無 codegen 分歧;瓶頸是算法(limb 寬度與逐位輸出),平臺無關。

## 誠實邊界

本節無 standalone 原型與 perf stat 逐項計數(熱點歸屬由 perf record/annotate 的 3014 樣本支撐);`exact_inf` 的 100% fallback 判定由源碼結構(1024 位需求 vs Grisu 64-bit 精度上限)與 grisu≈dragon 的時間巧合共同推出,未插樁直接計數。

## 復現

```bash
LD_LIBRARY_PATH=... build/.../corebenches-14ea307f41bce867 --bench 'flt2dec::strategy'
LD_LIBRARY_PATH=... perf record -e cycles:u -o dragon.data \
  build/.../corebenches-14ea307f41bce867 \
  --bench 'num::flt2dec::strategy::dragon::bench_big_exact_inf' --exact
perf annotate --symbol '...dragon12format_exact'
```

---

# `vec::bench_in_place_zip_recycle`:in-place collect 生效,無 alloc;剩餘差距是移動所有權的簿記稅

- 日期:2026-08-20
- 分析對象:`library/alloctests/benches/vec.rs:478`
- 接口:`vec::IntoIter` → `Zip` → `Enumerate` → `Map` → `collect::<Vec<_>>()`(InPlaceIterable 特化)
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

每輪 `mem::take` 取走 1000B 的 Vec,經 `into_iter().zip(subst).enumerate().map(...)` 重新 `collect`。它守護的是 **in-place collect 特化**:`vec::IntoIter` 是 `InPlaceIterable`,collect 應復用原 allocation 而非新分配。與 `zip_iter_mut`(24.6 ns,借用+索引)是同一計算的另一種所有權形態。

## 正式基線與熱點

```text
bench_in_place_zip_recycle    39.6–39.9 ns/iter(1000B)
bench_in_place_zip_iter_mut   24.6 ns(對照:借用 iter_mut + subst[i])
```

IPC **3.94**,branch/L1d miss ≈0。`perf record` 99.88% 單符號;反彙編確認:

1. **熱區無任何 alloc/dealloc 調用——in-place 特化生效**,守護目標成立;
2. 主迴圈是 32B/輪 NEON(`ldp q ×2 → add/eor → stp q`),與 iter_mut 版逐指令同構;
3. `zip` 形狀(真 zip,無 bounds check)同樣攜帶 requiresScalarEpilogue 尾巴與 guards——與 zip_iter_mut 節同機理。

## 對照分解(standalone,1000B,10M 次)

| 形狀 | ns/iter | 說明 |
|---|---:|---|
| recycle(=官方形狀) | 40.4 | 復刻正式 39.9 |
| fresh(同計算,每次新分配) | 43.5 | **in-place 只省 ~3 ns**:1KB malloc/free 本就便宜 |
| iter_mut in-place(zip 形狀,無所有權移動) | **32.2** | -20%:無 IntoIter 簿記 |

三個結論:

1. **in-place collect 的省分配收益在小 buffer 上很小**(~3 ns/1KB);它的真正價值在大 allocation 與 allocator 壓力場景,本 benchmark 的 1000B 只能驗證「不退化」而非展示收益。
2. recycle(40.4)對 iter_mut(32.2)慢 25% 的差距是 **`vec::IntoIter` 的所有權簿記**:take/收尾的 ptr/cap/len 搬運、IntoIter 的 front/back 指針推進、collect 端的長度重建——每輪 ~8 ns 固定稅,與元素數無關的部分佔多數。
3. 官方 `zip_iter_mut`(24.6)比本節 standalone iter_mut(32.2)快是內聯上下文差異(官方 bench 的 subst[i] 索引版在正式二進制裏長度可見;本節用 zip 形狀+不透明長度),兩者不直接可比——可比的是同 harness 內的三行。

## 判斷

1. benchmark 健康,守護目標(in-place collect 不退化為新分配)實測成立;無 std 病灶。
2. 40 ns 的構成:~29 ns 向量計算+epilogue(與 zip_iter_mut 同)+ ~8 ns IntoIter 所有權簿記 + ~3 ns 已省下的分配(對照 fresh)。想更快的用戶側答案與 zip_iter_mut 節相同:能用 `iter_mut` 原地改就不要走 IntoIter+collect,快 20%。
3. LLVM 側的 epilogue 改進(zip_iter_mut 節)同樣惠及此形狀,無新增修復點。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../allocbenches-2cf0e8badf7482bf --bench 'vec::bench_in_place_zip_recycle' --exact
/tmp/zip_recycle_candidates {recycle|fresh-noclone|inplace} 1000 10000000
```
