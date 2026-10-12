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
5. 這還不能直接作爲通用 std 修改：large element 上收益消失，且資料分佈存在 regression。合理下一步是把 `select_unpredictable` 原型放進實際 `Hole<T>` 實現，跑 std 的完整 BinaryHeap benchmark/test matrix，並特別評估昂貴 comparator、非 `Copy`/大 `T` 及不同 aarch64 微架構；若無跨類型穩定收益，應把問題交給 LLVM 改善 aarch64 對 `(cmp) as usize` 的 if-conversion，而不是在通用 collection 中強制 branchless。分支的具體來源（AArch64 `select-optimize` pass 的內層迴圈啓發式）見後文「`BinaryHeap` sift_down：aarch64 child-choice 分支的 LLVM 來源定位」一節。

---

# `BinaryHeap` sift_down：aarch64 child-choice 分支的 LLVM 來源定位

- 日期：2026-09-15
- 分析對象：`sift_down_range` / `sift_down_to_bottom` 中的 `child += (hole.get(child) <= hole.get(child + 1)) as usize`；本文件中 `bench_from_vec`、`bench_find_smallest_1000`、`bench_pop` 三節均已把熱點歸結到這一行在 aarch64 上生成的真分支 `b.hi`
- 目的：回答「爲甚麼 LLVM 在 aarch64 上把這個表達式生成分支，而 x86_64 生成 `sbb`」，並確認 `hint::select_unpredictable` 原型生效的機制
- 工具鏈：`rustc 1.100.0-nightly (e457a7b0d 2026-08-27)`，LLVM 23.1.0；LLVM 源碼引用自 rust 樹內 `src/llvm-project`
- 平臺：本機 HiSilicon aarch64（implementer 0x48）；`rustc --print target-cpus` 顯示 `native` 解析爲 `generic`

## 結論摘要

分支不是指令選擇（SelectionDAG）或 early if-conversion 的產物，而是 AArch64 後端在 `-O3`（rustc `opt-level=3`）下額外插入的 IR 級 pass **`select-optimize`**（LLVM `lib/CodeGen/SelectOptimize.cpp`）主動把 branchless 的 `zext(i1) + add` 改寫成分支。該 pass 由 subtarget feature `FeatureEnableSelectOptimize` 控制，`generic` CPU 以及 Neoverse N1/N2/V1/V2、Cortex-A76/A78/X1 等 tune list 預設開啓；x86 後端根本不運行此 pass。它的內層迴圈成本模型以固定 25% 的誤預測率估算分支成本，對本案例算出 `BranchCost=8.56 < SelectCost=15.0` 而選擇分支；實際 sibling 比較在隨機堆上接近 50% 熵，模型假設不成立。

`select_unpredictable` 原型最終生成 `csel` 並非因爲 `select-optimize` 尊重 `!unpredictable` metadata——內層迴圈路徑不檢查該 metadata，原型同樣被轉成分支——而是後續機器層 `early-ifcvt` 把它折回 `csel`，且僅以 1 個 cycle 的餘量落在門檻之內。

## 最小復現

以下獨立源碼與 `Hole<T>` 版 `sift_down_range` 同構（`u64` 元素，`get_unchecked` 消除邊界檢查，避免 panic 分支干擾迴圈形狀）。第二個函數是 `select_unpredictable` 原型。

```rust
#[inline(never)]
pub fn sift_down_range(v: &mut [u64], pos: usize, end: usize) -> usize {
    let mut hole = pos;
    let elt = v[pos];
    let mut child = 2 * hole + 1;
    while child <= end.saturating_sub(2) {
        child += (unsafe { *v.get_unchecked(child) <= *v.get_unchecked(child + 1) }) as usize;
        if elt >= unsafe { *v.get_unchecked(child) } { v[hole] = elt; return hole; }
        unsafe { *v.get_unchecked_mut(hole) = *v.get_unchecked(child) };
        hole = child;
        child = 2 * hole + 1;
    }
    if child == end - 1 && elt < v[child] {
        unsafe { *v.get_unchecked_mut(hole) = *v.get_unchecked(child) };
        hole = child;
    }
    v[hole] = elt;
    hole
}

#[inline(never)]
pub fn sift_down_sel(v: &mut [u64], pos: usize, end: usize) -> usize {
    let mut hole = pos;
    let elt = v[pos];
    let mut child = 2 * hole + 1;
    while child <= end.saturating_sub(2) {
        let r = unsafe { *v.get_unchecked(child) <= *v.get_unchecked(child + 1) };
        child = core::hint::select_unpredictable(r, child + 1, child);
        if elt >= unsafe { *v.get_unchecked(child) } { v[hole] = elt; return hole; }
        unsafe { *v.get_unchecked_mut(hole) = *v.get_unchecked(child) };
        hole = child;
        child = 2 * hole + 1;
    }
    if child == end - 1 && elt < v[child] {
        unsafe { *v.get_unchecked_mut(hole) = *v.get_unchecked(child) };
        hole = child;
    }
    v[hole] = elt;
    hole
}
```

```bash
rustc -O --crate-type=lib --emit=asm,llvm-ir -C panic=abort s.rs
```

兩個函數的迴圈主體：

```asm
; sift_down_range（現狀）
.LBB1_2:
    add   x12, x8, x13, lsl #3
    ldr   x13, [x8, x0, lsl #3]      ; left
    ldr   x12, [x12, #16]            ; right
    cmp   x13, x12
    b.hi  .LBB1_4                    ; ← child choice 是真分支
    add   x12, x0, #1                ; 走 right
    ldr   x14, [x8, x12, lsl #3]
    cmp   x9, x14
    b.lo  .LBB1_5
    b     .LBB1_14
.LBB1_4:
    mov   x12, x0                    ; 走 left
    ldr   x14, [x8, x0, lsl #3]
    cmp   x9, x14
    b.hs  .LBB1_14
.LBB1_5:
    ...

; sift_down_sel（select_unpredictable 原型）
.LBB0_2:
    add   x12, x12, #2
    ldr   x13, [x8, x0, lsl #3]
    ldr   x14, [x8, x12, lsl #3]
    cmp   x13, x14
    csel  x13, x0, x12, hi           ; 無分支
    ldr   x14, [x8, x13, lsl #3]
    cmp   x9, x14
    b.hs  .LBB0_12
    ...
```

x86_64 對照（`--target x86_64-unknown-linux-gnu`）的同一位置是 `cmpq (%rdi,%rax,8), %r9; movq %rax, %r9; sbbq $-1, %r9`，與前節觀察一致。

## 第一步：分支不在 IR 優化管線中產生

`--emit=llvm-ir` 得到的是中端優化完成後的 IR。迴圈主體中 child 的選擇仍是純算術：

```llvm
%_14 = icmp ule i64 %_15, %_17
%_13 = zext i1 %_14 to i64
%2   = add nuw nsw i64 %child.sroa.0.028, %_13
%_44 = getelementptr inbounds nuw [8 x i8], ptr %v.0, i64 %2
%_21 = load i64, ptr %_44, align 8
%_20.not = icmp ult i64 %elt, %_21
br i1 %_20.not, label %bb6, label %bb15
```

因此問題出在後端。用 `-print-after-all` 逐 pass 導出後端 IR/MIR，並找出 `freeze i1` + `br i1` 首次替代 `zext` 的位置：

```bash
rustc -O --crate-type=lib --emit=asm -C panic=abort -C codegen-units=1 \
  -C llvm-args=-print-after-all \
  -C llvm-args=-filter-print-funcs=_RNvCsewkfLJIkpWD_1s15sift_down_range \
  -o out.s s.rs 2> dump.txt
awk '/^\*\*\* IR Dump After/{hdr=$0} /freeze i1/ {print hdr; exit}' dump.txt
# *** IR Dump After Optimize selects (select-optimize) ***
```

該 pass 前一個 dump（`expand-reductions`）中迴圈塊仍是 `zext + add`；該 pass 之後：

```llvm
22:
  ...
  %32 = icmp ule i64 %27, %31
  %33 = zext i1 %32 to i64          ; 已無使用者
  %34 = freeze i1 %32
  br i1 %34, label %35, label %37

35:
  %36 = add nuw nsw i64 %23, 1
  br label %37

37:
  %38 = phi i64 [ %36, %35 ], [ %23, %22 ]
  %40 = getelementptr inbounds nuw [8 x i8], ptr %0, i64 %38
  %41 = load i64, ptr %40, align 8
  %42 = icmp ult i64 %8, %41
  br i1 %42, label %60, label %56
```

隨後的 CodeGenPrepare、ISel、early-ifcvt 均未改變此結構，ISel 後的 MIR 直接是 `SUBSXrr; Bcc 8(hi)`。

## 第二步：`select-optimize` 的啓用條件

AArch64 後端在 `addIRPasses` 末尾自行加入這個 pass（`lib/Target/AArch64/AArch64TargetMachine.cpp`）：

```cpp
TargetPassConfig::addIRPasses();

if (getOptLevel() == CodeGenOptLevel::Aggressive && EnableSelectOpt)
  addPass(createSelectOptimizePass());
```

`EnableSelectOpt` 是 `cl::opt` `-aarch64-select-opt`（預設 true）。通用的 `TargetPassConfig` 也有一份加入邏輯，但受 `-disable-select-optimize` 控制且**預設爲 true**（`lib/CodeGen/TargetPassConfig.cpp:255`），所以 x86 等其他目標實際上不運行此 pass；這也解釋了爲何 `-C llvm-args=-disable-select-optimize` 對 aarch64 輸出無影響——它控制的是那個本來就關閉的實例。

pass 內部再以 TTI 門控（`SelectOptimize.cpp:366`）：

```cpp
if (!TTI->enableSelectOptimize())
  return PreservedAnalyses::all();
```

AArch64 的實現轉發到 subtarget feature（`AArch64TargetTransformInfo.h:473`）：

```cpp
bool enableSelectOptimize() const override {
  return ST->enableSelectOptimize();   // FeatureEnableSelectOptimize
}
```

`lib/Target/AArch64/AArch64Features.td`：

```tablegen
def FeatureEnableSelectOptimize : SubtargetFeature<
    "enable-select-opt", "EnableSelectOptimize", "true",
    "Enable the select optimize pass for select loop heuristics">;
```

`lib/Target/AArch64/AArch64Processors.td` 的 `generic` 定義帶此 feature：

```tablegen
def : ProcessorModel<"generic", CortexA510Model, ProcessorFeatures.Generic,
                     [FeatureFuseAES, FeatureFuseAdrpAdd, FeaturePostRAScheduler,
                      FeatureEnableSelectOptimize]>;
```

含此 feature 的 tune list：A57、A65、A72、A73、A75、A76、A77、A78/A78AE/A78C、A710、A715、A720/A720AE、A725、X1、X2、X3、X4、X925、Neoverse N1/N2/N3/V1/V2/V3/V3AE/512TVB、Ampere1B、Oryon、Olympus、MONAKA。

以下驗證直接指向該 pass：

```bash
# 關閉 pass（AArch64 專用開關）
rustc -O --crate-type=lib --emit=asm -C panic=abort -C llvm-args=-aarch64-select-opt=false s.rs
# 或關閉 subtarget feature
rustc -O --crate-type=lib --emit=asm -C panic=abort -C target-feature=-enable-select-opt s.rs
```

兩者的迴圈主體均變爲：

```asm
ldr   x13, [x8, x0, lsl #3]
ldr   x12, [x12, #16]
cmp   x13, x12
cinc  x13, x0, ls                ; child += (left <= right)
ldr   x14, [x8, x13, lsl #3]
cmp   x9, x14
b.hs  ...
```

`cinc ... ls` 正是 x86 `sbbq $-1` 的 aarch64 對應形式。也就是說，SelectionDAG 對 `zext(i1) + add` 本來就能生成 branchless 代碼；分支是 `select-optimize` 在其之前主動引入的。

按 `-C target-cpu` 掃描（同一源碼，讀迴圈主體中 child 選擇的指令）：

| target-cpu | child 選擇 | 說明 |
|---|---|---|
| generic（本機 `native` 的解析結果） | `b.hi` | tune list 含 feature |
| neoverse-n1 / n2 / v1 / v2 | `b.hi` | 含 feature |
| cortex-a76 / a78 / x1 | `b.hi` | 含 feature |
| cortex-a72 | `cinc` | 含 feature，但成本模型判定不轉換 |
| cortex-a53 / a55 | `cinc` | 不含 feature |
| apple-m1 / m4 | `cinc` | 不含 feature |
| tsv110（Kunpeng 920） | `cinc` | 不含 feature |
| a64fx、ampere1 | `cinc` | 不含 feature |

cortex-a72 一列說明 feature 只是必要條件；最終決定仍取決於該 CPU 調度模型給出的延遲數字。

## 第三步：pass 爲何把 `zext + add` 當作 select

`select-optimize` 的處理對象不限於 `select` 指令。`SelectOptimize.cpp:790–843` 把「二元運算的一個操作數是單次使用的 `zext/sext i1`」識別爲 select-like：

```cpp
// `Aux` can be either `ZExt(1bit)`, `SExt(1bit)` or `XShr(Val), ValBitSize - 1`
auto MatchZExtOrSExtPattern =
    m_c_BinOp(m_Value(), m_OneUse(m_ZExtOrSExt(m_Value(X))));
...
if ((match(I, MatchZExtOrSExtPattern) && X->getType()->isIntegerTy(1)) || ...)
```

`child + zext(c)` 因而被視爲 `select c, child + 1, child`，true 分支帶一條 `add`，false 分支爲空。轉換函數 `convertProfitableSIGroups` 對條件插入 `freeze` 後生成上面看到的 diamond。

## 第四步：內層迴圈成本模型的判定

pass 對最內層迴圈使用專門的路徑 `findProfitableSIGroupsInnerLoops`，以 `-C remark=select-optimize` 可以直接讀到其判定：

```text
s.rs:7:9   select-optimize (success): Profitable to convert to branch (loop analysis).
           BranchCost=8.5625, SelectCost=15.0.
hint.rs:879 select-optimize (success): Profitable to convert to branch (loop analysis).
           BranchCost=7.8125, SelectCost=15.0.
```

（`neoverse-n1` 下爲 8.25 / 15.0 與 9.0 / 15.0，結論相同。）第二行針對的是 `sift_down_sel` 中 `select_unpredictable` 內部的 `select`，下一節討論。

成本計算（`computeLoopCosts`，`SelectOptimize.cpp:1279` 起）對迴圈中每條指令累積延遲，select 版本的成本是整條依賴鏈：

```text
InstCost      = InstLatency + max(OpCosts)
BranchCost    = PredictedPathCost + MispredictCost
PredictedPathCost = TrueOpCost × P(true) + FalseOpCost × P(false)
MispredictCost    = max(MispredictPenalty, CondCost) × MispredictRate / 100
```

```cpp
static cl::opt<unsigned> MispredictDefaultRate(
    "mispredict-default-rate", cl::Hidden, cl::init(25),
    cl::desc("Default mispredict rate (initialized to 25%)."));
```

無 profile 時 `MispredictRate` 固定取 25%。本案例中 select 版本的關鍵路徑是 `ldr(left/right) → cmp → csel → ldr(child) → cmp(elt) → 下一輪 phi`，`SelectCost=15`；分支版本把 `cmp → csel` 從地址鏈上移除，加上 25% × 誤預測懲罰後得 8.56。之後的迴圈級門檻（`checkLoopHeuristics`）全部通過：

```cpp
GainGradientThreshold  = 25   // %
GainCycleThreshold     = 4    // cycles
GainRelativeThreshold  = 8    // 即 gain ≥ PredCost / 8 = 12.5%
```

問題不在公式而在輸入：sibling 比較在隨機堆上的實測 miss 率是 20.8%（`from_vec`）到 9.1%（top-k），對應分支本身的熵接近 50%，而模型以 25% 估算並且在 `PredictedPathCost` 中假設可以完全預測執行路徑。在這個假設下 `b.hi` 的期望成本被低估約一倍，判定隨之反轉。這也是 x86 天然無此問題的原因：x86 從未運行該 pass，SelectionDAG 直接把 `zext + add` 降爲 `sbb`。

## 第五步：`select_unpredictable` 原型爲何仍是 `csel`

`select-optimize` 對 `!unpredictable` 的檢查只有一處，位於非迴圈路徑 `isConvertToBranchProfitableBase`（`SelectOptimize.cpp:1021`）：

```cpp
if (SI.getI()->getMetadata(LLVMContext::MD_unpredictable)) {
  ++NumSelectUnPred;
  ORmiss << "Not converted to branch because of unpredictable branch. ";
  return false;
}
```

內層迴圈路徑 `optimizeSelectsInnerLoops → findProfitableSIGroupsInnerLoops` 不經過這個函數。對 `sift_down_sel` 的 dump 證實原型同樣被轉成了分支，metadata 只是被搬到了 `br` 上：

```llvm
%32 = icmp ugt i64 %27, %31
%33 = freeze i1 %32
br i1 %33, label %35, label %34, !unpredictable !12

34:
  br label %35

35:
  %36 = phi i64 [ %23, %22 ], [ %28, %34 ]
```

最終 asm 仍是 `csel`，是因爲機器層的 `early-ifcvt` 又把這個 diamond 折了回去。`-C remark=early-ifcvt`：

```text
hint.rs:879  early-ifcvt (success): performing if-conversion on branch: the condition
             adds 5 cycles to the critical path, and the short leg adds another 1 cycle,
             and the long leg adds another 2 cycles, each staying under the threshold of 5 cycles.
s.rs:7:9     early-ifcvt (missed): did not if-convert branch: the condition would add
             6 cycles to the critical path exceeding the limit of 5 cycles, ...
```

門檻 `CritLimit = MispredictPenalty / 2`（`EarlyIfConversion.cpp`）。兩個版本相差的 1 個 cycle 來自 diamond 的形狀：原型的 true 塊爲空（`child + 1` 復用了已算好的 `child + 2` 減一，phi 直接取值），而 `zext + add` 版本的 true 塊多一條 `add`。`early-ifcvt` 本身不讀 `!unpredictable`。

驗證：對原型加 `-C llvm-args=-disable-early-ifcvt`，迴圈主體同樣退化爲 `b.hi`。

因此當前原型的收益依賴兩個互不相干的機制恰好對齊，而不是 `select_unpredictable` 的語義被後端遵守。若 `Hole<T>` 版本的實際 IR 形狀、元素類型或比較器導致 diamond 多出一條指令，`early-ifcvt` 就會拒絕折回，原型將靜默失效。落地時必須以 asm 或 `-C remark=early-ifcvt` 確認，不能只看 benchmark 數字。

## 結論

1. aarch64 上 `child += (cmp) as usize` 的真分支由 AArch64 專用的 `select-optimize` pass 產生，觸發條件是 `opt-level=3` 且 target-cpu 的 tune list 含 `FeatureEnableSelectOptimize`；`generic`（即多數 Linux 發行版與 `target-cpu=native` 在非白名單 CPU 上的結果）及 Neoverse/Cortex 大核均開啓。關閉該 pass 後 SelectionDAG 生成 `cinc`，與 x86 的 `sbb` 同構。
2. 判定錯誤的直接原因是內層迴圈成本模型以固定 25% 誤預測率估算分支成本；對接近 50% 熵的 sibling 比較，分支成本被低估約一倍。這是 pass 的通用缺陷，任何 `zext(i1)` 餵 `add/or` 且結果進入地址鏈的迴圈都可能命中。
3. `select_unpredictable` 在此路徑上並未被 `select-optimize` 尊重（只在非迴圈路徑檢查 metadata），原型的 `csel` 是 `early-ifcvt` 以 1 cycle 餘量折回的結果。這降低了源碼層修法的穩健性，也把前節結論 5「交給 LLVM 改善 if-conversion」的目標具體化爲兩點：`select-optimize` 的內層迴圈路徑應尊重 `!unpredictable`；`MispredictDefaultRate` 應由條件的可預測性（profile 或 select-like 形狀的靜態特徵）調整而非固定常數。
4. 對 std 的 `BinaryHeap` 修改，`select_unpredictable` 仍是當前可用的最小改動，但 PR 說明應把原因寫爲「`select-optimize` 對 `zext+add` select-like 形狀的迴圈啓發式誤判」，並附上本節的 remark 與 asm 作爲依據。
5. 復現與驗證命令：

```bash
# 定位 pass
rustc -O --crate-type=lib --emit=asm -C panic=abort -C codegen-units=1 \
  -C llvm-args=-print-after-all -C llvm-args=-filter-print-funcs=<mangled> -o out.s s.rs 2> dump.txt
# 讀判定依據
rustc -O --crate-type=lib --emit=asm -C panic=abort -C codegen-units=1 -C debuginfo=1 \
  -C remark=select-optimize -C remark=early-ifcvt -o out.s s.rs
# 反向驗證
rustc -O --crate-type=lib --emit=asm -C panic=abort -C llvm-args=-aarch64-select-opt=false -o out.s s.rs
rustc -O --crate-type=lib --emit=asm -C panic=abort -C target-feature=-enable-select-opt -o out.s s.rs
```

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
2. 至此三大 BinaryHeap 熱路徑全部實證同一修復點:`from_vec` -41%、top-k 替換 -37%、`pop` -34%——都指向 `Hole` 版 sift_down 家族(`sift_down_range`/`sift_down_to_bottom`)的 `child += (cmp) as usize` 行。x86_64 的 `sbb`/`cmov` codegen 天然無此問題(from_vec 節已證),這是 aarch64 特有的問題，來源已在「`BinaryHeap` sift_down：aarch64 child-choice 分支的 LLVM 來源定位」一節確認爲 `select-optimize` pass 的迴圈啓發式。
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

---

# `string::bench_push_char_two_bytes`:與 `Vec::push` 同一塊 store-forward 地板,UTF-8 編碼幾乎免費

- 日期:2026-08-21
- 分析對象:`library/alloctests/benches/string.rs:47`
- 接口:`String::push` → `reserve(ch_len)` + `encode_utf8_raw_unchecked` + `set_len`(`library/alloc/src/string.rs:1432`)
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

每輪新建空 `String`,push 10,000 次 `'â'`(2 字節 UTF-8),`black_box` 同時打在 receiver 與 char 上——後者使 `len_utf8`/編碼分支不可常量摺疊,每次 push 都要走完整的「按 char 值分 1/2/3/4 字節」判定鏈。字符串從 0 增長到 20,000 字節,途中 doubling realloc ~15 次。

## 正式基線與 perf

```text
bench_push_char_two_bytes    26.77–26.92 µs/iter(2.69 ns/push,747 MB/s)
bench_push_char_one_byte     25.07 µs(2.51 ns/push,398 MB/s)
bench_push_str_one_byte      35.23 µs(3.52 ns/push,對照:push_str 單字節)
```

IPC **3.91**,branch miss 0.05%,backend stall 極低。`perf record` 96.6% 單符號;反彙編顯示內聯後的完整 push 迴圈:每輪從記憶體重讀 `(cap,ptr,len)`(black_box 逃逸所致)、`cmp w22, #0x80 / #0x800 / #0x10,lsl 12` 的長度判定鏈(`cinc/csel` 無分支)、`reserve` 的 `cmp x2, x8` 容量檢查、兩條 `strb` 寫出 UTF-8 字節、`str x8, [x20,#16]` 寫回 len。樣本聚在 `strb`(52.5%)與 len 寫回/重讀(12.7%)——**與 `slice::push` 節相同的 store→load 轉發鏈歸因**。

## 分解實驗(standalone,2.6 ns 地板的歸屬)

| 變體 | ns/push | 結論 |
|---|---:|---|
| official(復刻正式形狀) | 2.64 | ≈正式 2.69 |
| pre-reserved(去掉全部 realloc) | 2.61 | **grow 攤銷僅 ~1%** |
| const char(編碼分支迴圈外) | 2.61 | **1/2/3/4 字節判定鏈 ~1%** |
| 手寫 u16 單 store 編碼(替代兩條 strb) | 2.62 | **雙 strb 合併無收益** |
| registerized(receiver 不逃逸) | 2.60 | 欄位重讀稅也只 ~2% |

**全部候選壓在同一塊 2.6 ns 地板上**:瓶頸是每 push 一次的 `str len → 下輪 ldr len` store-forward 往返(本核 ~7 cycles),與元素編碼、容量管理、black_box 形態幾乎無關。one_byte(2.51)與 two_bytes(2.69)只差 7%,同理。

## 結論

1. **無 std 可改**:`String::push` 的實現(reserve + encode_unchecked + set_len)已是最優形狀;2.69 ns 的構成 ≈ 95% store-forward 稅 + ~5% 其餘。與 `slice::push`(2.49 ns)是同一個微架構地板,String 多出的 0.2 ns 是 UTF-8 判定鏈的邊際成本。
2. 用戶側可移植結論與 Vec 節一致:熱迴圈逐字符 `push` 的上限由 store-forward 決定;批量形態(`push_str`/`extend`/`String::from_iter`)纔有數量級空間。注意 `bench_push_str_one_byte`(3.52 ns)反而比 push_char 慢——單字節 `push_str` 的 memcpy 調用開銷超過內聯編碼,「批量接口」只在真的批量時才贏。
3. benchmark 健康,是守護型:守護「push 不因 UTF-8 通用性付出可測代價」,實測成立(one_byte vs two_bytes 僅 7%)。
4. x86 對照無必要:與 `slice::push` 節同構(store-forward 延遲是各微架構常數),無 codegen 分歧空間。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../allocbenches-2cf0e8badf7482bf --bench 'push_char'
/tmp/push_char_candidates {official|prereserved|const|wide|registerized} 2000
```

---

# `str::char_iterator_for`:完整 UTF-8 解碼 @ 完美預測,0.72 ns/char 已是該串行形狀的上限

- 日期:2026-08-21
- 分析對象:`library/alloctests/benches/str.rs:11`
- 接口:`str::chars()` 的 `Chars::next` → `next_code_point`(`library/core/src/str/validations.rs`)
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

65 字節混合字符串(7 個 3 字節泰文/CJK + 44 個 ASCII,共 51 chars),`for ch in s.chars() { black_box(ch) }`。**`black_box(ch)` 是與鄰居的本質區別**:消費 char 值使解碼不可 DCE——對照 `char_iterator`(`chars().count()`,同輸入)只要 11.4 ns,因為 count 不用 char 值,LLVM 把解碼計算全部刪除只留步進(char_count 節 case02 已證此機理)。

```text
char_iterator          11.44 ns(count:解碼被 DCE)
char_iterator_for      36.82 ns(0.72 ns/char:真解碼)← 本節
char_iterator_rev      48.00 ns(反向 count:反向解碼不可全 DCE)
char_iterator_rev_for  38.69 ns(反向真解碼)
```

## perf 與熱迴圈

IPC **4.65**,branch miss **0.00%**,99.76% 單符號。反彙編是教科書式的 UTF-8 前向解碼:

```asm
ldrsb w12, [x11], #1        ; 首字節(post-increment)
tbz   w12, #31, ascii       ; ASCII → char 即字節值
ldrb  w11, [x9, #1]         ; 續字節 1
cmp   w10, #0xe0 / b.cc     ; 2 字節出口
ldrb  w12, [x9, #2]         ; 續字節 2
cmp   w10, #0xf0 / b.cc     ; 3 字節出口(orr w10, w12, w11, lsl #12)
ldrb  w10, [x9, #3]         ; 4 字節路徑
```

樣本 64% 聚在迴圈頭的指針搬運(skid 聚集於 `mov x9, x11`)——成本均勻塗抹在整條解碼鏈上,無單點異常。約 2.1 cycles/char。

**關鍵限定:0.00% miss 是 benchmark 假象的一半。** 每輪迭代重複同一個 65 字節串,預測器把 51 個字符的分支序列整條背下來——它測的是「完美訓練預測器下的解碼吞吐」。真實非重複文本的形態見 char_count 節 case02:zh_huge 0.9 GB/s(依賴鏈鎖死)對本節 1.77 GB/s。兩者機器碼相同(case02 的 iter 展開形狀:1/2 字節路徑分支+常量增量,3-vs-4 才有資料依賴),差異全在輸入統計。

## 結論

1. **無 std 可改**:`Chars::next` 的逐字符解碼已是該語義(必須產出每個 char 值)的最優串行形狀;0.72 ns/char @ IPC 4.65 貼近發射寬度。要快一個量級只能改語義——不用 char 值就用 `count()`/字節接口(11.4 ns,3.2×),要值且能批量就走 `char_indices` + 按需解碼或 SIMD 驗證後的批解碼(超出 std 現有 API)。
2. benchmark 定位正確但有兩點值得記錄:(a)65B 重複輸入使分支完美可預測,數字代表**上限**而非典型值;(b)`char_iterator_rev`(count 版反向,48.0 ns)比 `rev_for`(38.7)還慢——反向解碼(`next_code_point_reverse`)的續字節探測結構讓 LLVM 無法像正向那樣把 count 版 DCE 乾淨,rev 家族值得單獨一看,但屬 benchmark 解讀而非性能缺陷。
3. 與 char_count 節閉環:同一臺機器上「數字符」四種寫法的完整層級是 case00 SWAR 13.2 GB/s → 本節真解碼 1.77 GB/s(完美預測)→ case02 真實文本 0.9–2.1 GB/s。教學結論不變:不需要 char 值就永遠不要逐字符解碼。
4. x86 對照無必要:case02 節已證兩平臺此形狀逐塊同構(`tbz`/`jns`、`cinc`/`sbb` 慣用法差異,無結構分歧)。

## 復現

```bash
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  build/.../allocbenches-2cf0e8badf7482bf --bench 'char_iterator'
perf record -e cycles:u ... --bench 'str::char_iterator_for' --exact && perf annotate
```

---

# `io::cursor::bench_write_vec`:77 ns 裏 write 本體只佔一半,另一半是 harness 的 to_vec + realloc

- 日期:2026-08-21
- 分析對象:`library/alloctests/tests/io/cursor.rs:535`(注意:在 **tests** target 裏,`./x bench` 不跑它;需 `./x test --test-args --bench`。倉庫裏另有同名 `io::bench_write_vec` 在 benches/io.rs,測的是 `&mut [u8]` 的 Write,兩者無關)
- 接口:`Cursor<&mut Vec<u8>>::write_all` → `vec_write_all`(`library/alloc/src/io/cursor.rs:194`):`reserve_and_pad` + `vec_write_all_unchecked` + `set_len`
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

每輪:`b"some random data to overwrite".to_vec()`(29 字節,分配)→ `Cursor::new(&mut buf)` → `write_all(&[1; 128])`。position 0 + 128 字節寫入 → `reserve_and_pad` 觸發 29→128+ 的 **realloc**,無 padding(pos=0 ≤ len),然後 `copy_from` 128 字節、`set_len(128)`。每輪 1 alloc + 1 realloc + 1 free + 兩次 memcpy(29B 初始化 + 128B 寫入)。

## 正式基線(stage1 重建後;舊二進制不含 39bf757d697 搬入的 cursor tests)

```text
io::cursor::bench_write_vec            77.32 ns/iter
io::cursor::bench_write_vec_vectored  722.05 ns/iter(8 段 16KB 總量,對照)
io::bench_write_vec(benches/io.rs)     22.07 ns/iter(&mut [u8] 版,無分配)
```

## 分解實驗(standalone,固定 1000 萬次)

| 變體 | ns/iter | 隔離出的成分 |
|---|---:|---|
| official(復刻) | 70.1 | ≈正式 77.3(閉包殼差) |
| alloc-only(同分配,無 write) | **12.9** | 純 to_vec + free |
| presized(`vec![0;128]`,無 realloc) | 39.9 | **去掉 realloc 省 30 ns** |
| direct(無 Cursor:clear + extend_from_slice) | 67.8 | **Cursor 抽象稅 ≈ 2 ns** |

perf(official):IPC 3.71,miss 0.08%;樣本 **malloc 16.2% + realloc 6.7% + free 4.5% + glibc memcpy 碎片 ~6%**,官方 write 路徑本體(內聯進 official)15.7%。

成本賬:77 ns ≈ 13(alloc/free)+ 30(realloc 29→128,含 29B 搬移與 allocator 簿記)+ ~25(兩次 memcpy + reserve/pad/set_len 分派)+ ~8(harness)。**write_all 真正的邏輯(容量檢查、pad 判斷、copy、set_len)只佔 ~1/3;Cursor 對 direct Vec 寫法的淨開銷僅 ~2 ns**——`vec_write_all` 的實現(手動 spare_capacity fill 避免 resize 的多餘分支、`copy_from` 直寫)已經很緊。

## 結論

1. **std 無可改**:`vec_write_all` 鏈路(reserve_and_pad 的 saturating 容量計算、手動 pad、unchecked copy)已是緊實現,Cursor 抽象稅 ~2 ns;其餘全是 allocator 行為。
2. **benchmark 形狀值得改**:29 字節初始 vec 保證每輪 realloc——它把「Cursor 覆寫」與「Vec 增長」混在一起測。若意圖是測 write 路徑,初始 vec 應 `with_capacity(128)`(或至少加一個 presized 變體);現狀下任何 write 路徑的優化都會被 ~43 ns 的分配噪聲稀釋一半以上。
3. 發現的工程事實:這組 cursor benches 在 tests target 裏,`./x bench library/alloctests` **不會運行它們**(只跑 benches/);要跑需 `./x test --test-args --bench`。這解釋了它們長期無人關注的原因,也值得在 benchmark 整理時遷移到 benches/。
4. x86 對照無必要:成本由 glibc allocator 與 memcpy 主導,無 codegen 分歧空間。

## 復現

```bash
./x test library/alloctests --stage 1 --test-args --bench --test-args bench_write_vec
/tmp/cursor_write_candidates {official|presized|alloc|direct} 10000000
```

---

# `ascii::long::is_ascii_*` 全家 + x86 對比:兩平臺同樣拒絕向量化,標量形狀逐條同構,NEON 原型 17×

- 日期:2026-08-21
- 分析對象:`ascii.rs` `@iter` 家族的謂詞本體(`iter().all(u8::is_ascii_xxx)`),接續前節「benchmark 測不到謂詞」的結論,本節直接測謂詞真實掃描並做跨 ISA codegen 對比
- 平臺:aarch64 實測;x86 為同一 IR 剝 target-features 後 `llc -mcpu=x86-64` 的形狀對照(無 x86 硬件時間)

## 真實掃描成本(全真輸入,7000B,aarch64 實測)

| 謂詞 | ns/B | vs `<[u8]>::is_ascii` | 實現形狀 |
|---|---:|---:|---|
| `<[u8]>::is_ascii`(slice 方法,SWAR) | **0.017** | 1× | usize 高位批查 |
| `iter().all(u8::is_ascii)` | 0.218 | 12.7× | 逐字節 `tbnz`(僅 4× 展開) |
| whitespace | 0.520 | 30× | **bitmask**:`lsr x10, x9, x10` + `tbz` |
| digit / uppercase / graphic | 0.653 | 38× | 單區間:`sub + cmp + ccmp` |
| control | 0.763 | 45× | 單比較變體 |
| alphanumeric / hexdigit | 1.383 | 81× | **三區間 csel 級聯** |
| punctuation | 1.710 | **100×** | 四區間級聯 |

成本階梯精確對應謂詞的區間數——每字節的比較鏈長度就是成本,加上 `all()` 的早退迫使逐字節串行。

## aarch64 / x86_64 codegen 對比:完全同構,無平臺分歧

同一 no_std probe(9 個 `all_*` 函數)生成兩 ISA 彙編,逐項對比:

**1. 兩平臺都零向量化。** `cmhi/cmeq/ldp q/pcmp/pmovmskb` 計數全部為 0——LLVM 對帶早退的 `all()` 迴圈在兩個後端都只給標量。這不是 aarch64 特有病理(對比 char_count 的 ld4 病理),而是共同的「早退殺向量化」限制。

**2. 標量迴圈逐條同構,指令數幾乎相同:**

| 謂詞 | aarch64 全函數指令 | x86 | 慣用法差異 |
|---|---:|---:|---|
| whitespace | 14 | 15 | bitmask 測試:`lsr+tbz` vs **`btq`**(x86 有專用位測指令,反而少一步移位) |
| digit/uppercase/graphic | 14 | 15 | `sub+cmp+ccmp` vs `addb $-48 + cmpb + setb` |
| alphanumeric/hexdigit | 22 | 27 | 多區間合併:aarch64 `csel` 級聯 vs x86 `setb+cmovael` 級聯 |
| punctuation | 26 | 32 | 同上,x86 的 `xorl` 清零準備多幾條 |
| is_ascii(iter 版) | 29 | 30 | 都做了 4× 展開的 `tbnz`/`js` 符號位測試 |

x86 在多區間謂詞上略多 15–23% 指令(`setcc` 需要先 `xor` 清零,aarch64 的 `ccmp/csel` 更緊湊),但**結構完全一致:每字節一條比較鏈 + 一個早退分支**。x86 硬件上的每字節成本階梯預期與 aarch64 同形(僅微架構係數差異)。

**3. 對比的含義**:這與 BinaryHeap(x86 branchless、aarch64 分支)不同,也與 char_count(aarch64 獨有 ld4 病理)不同——is_ascii_* 家族是「兩平臺同病」:病根在 LLVM 對早退迴圈的通用限制 + 謂詞逐字節語義,不在任何一個後端。修復必須在庫層改形狀,對兩平臺同時生效。

## NEON 原型:區間檢查天然是向量操作

按 dedup-prescan 同樣的「分塊無早退 + 命中回退」方法,16B/輪:

```rust
// digit: (b - '0') <= 9 無符號 → 一條 vsubq + vcleq
let d = vsubq_u8(c, vdupq_n_u8(b'0'));
ok = vandq_u8(ok, vcleq_u8(d, vdupq_n_u8(9)));
// alnum: 三個區間各自 sub+cle 後 vorrq 合併;塊尾 vminvq_u8 判全真
```

| 謂詞 | 標量 | NEON | 提升 |
|---|---:|---:|---:|
| digit(7000B) | 4578 ns | **266 ns** | **17.2×** |
| alphanumeric | 9681 ns | **562 ns** | **17.2×** |

(混合輸入與空輸入正確性已對標量驗證。)x86 側同樣的形狀會被 SSE2 `psubb/pcmpgtb/pmovmskb` 承接,收益同構——因為兩平臺的病是同一個。

## 結論

1. `is_ascii_*` 謂詞族的掃描成本階梯(0.52–1.71 ns/B)由區間數決定,對比 slice `is_ascii` 的 SWAR(0.017)有 **30–100×** 差距;`iter().all(u8::is_ascii)` 也比 slice 方法慢 12.7×(用戶側:永遠用 `v.is_ascii()` 而非 iter 版)。
2. **跨 ISA 結論:兩平臺同病同構**。零向量化、標量鏈逐條對應、x86 多區間謂詞略多 15–23% 指令但無結構差異。這是「LLVM 早退限制」類問題,不是後端分歧類——庫層分塊化修復對兩平臺同時生效。
3. NEON 原型 17× 驗證了修復上限;x86 SSE2 同形狀可承接。落地路徑:`<[u8]>::is_ascii` 已有的 SWAR 模式推廣為按謂詞參數化的分塊掃描(區間集合在編譯期已知,可 generic 展開),或至少為 whitespace/digit 等高頻謂詞提供 slice 級方法。
4. 前提仍然是前節的 benchmark 修復——現有 `ascii::long::is_ascii_*` 對這一切不可見(190 ns 全是 to_vec)。

## 復現

```bash
# codegen 對比
rustc --crate-type=lib --edition=2024 -C opt-level=3 --emit=llvm-ir,asm ascii_pred_probe.rs
sed -e 's/"target-cpu"="generic"/"target-cpu"="x86-64"/' -e 's/"target-features"="[^"]*"//g' \
  ascii_pred_probe.ll > clean.ll && llc -mtriple=x86_64-unknown-linux-gnu -mcpu=x86-64 -O3 clean.ll
# 實測 + NEON 原型
/tmp/ascii_pred_bench
```

## 追問:LLVM 為什麼不向量化,以及熱點精確在哪(2026-08-21 補充實驗)

### 為什麼不向量化:remark 給出的直接答案

用 `-Cremark=loop-vectorize -Cdebuginfo=1` 對三個變體取 LLVM 自己的診斷:

| 變體 | 形狀 | remark | 結果 |
|---|---|---|---|
| `iter().all(pred)` | 早退 | `value that could not be identified as reduction is used outside the loop` | 標量 |
| 手寫 `while + return false` | 早退 | `loop induction variable could not be identified` / `could not determine number of loop iterations` | 標量 |
| **`fold(true, \|acc,b\| acc & pred(b))`** | **無早退** | **`vectorized loop (vectorization width: vscale x 128)`** | **SVE 向量化!** |

機理分解:

1. **早退迴圈的根本障礙是 trip count 不可知**。向量化的前提是「這 16 個元素都會被讀」;`all()` 在第 i 個元素為假時**必須不讀** i+1(語義上迭代器就停在那裏)。LLVM 要向量化早退迴圈只能靠 speculative load + 事後修正,它只在極窄的模式(如 std::find 類 pattern,且需證明越界讀安全)嘗試,這裏的 slice iterator + 任意謂詞組合不在窗口內。兩個 remark(「reduction 用在迴圈外」「無法確定迭代次數」)是同一障礙在不同 IR 形狀上的兩種報法。
2. **拿掉早退,向量化立即發生**——`fold + &`(位與,非短路 `&&`)版本被成功編成 SVE(`ptrue/rdvl`,vscale×128 的巨塊)。這修正了上節「兩平臺都拒絕向量化」的過廣表述:**準確說法是「早退形狀不可向量化;無早退形狀可以,但沒有任何 std 謂詞 API 生成無早退形狀」**。`all()`/`any()` 的短路語義是 API 契約,LLVM 無權改。
3. 上節 no_std probe 的 `fold` 版沒測——generic 構建無 SVE,LLVM 對 NEON 是否給同樣待遇需另驗(cost model 不同);但 dedup-prescan 節已證 NEON 對無早退塊狀歸約工作正常。

### 實測:fold 版就地拿到 21×

| 變體(7000B digit,全真) | ns/B | vs all() |
|---|---:|---:|
| `iter().all()`(早退,標量) | 0.655 | 1× |
| 手寫 while+break(早退,標量) | 0.722 | 0.91×(更慢:LLVM 對 iterator 版形狀略優) |
| **`fold(true, acc & pred)`**(無早退,SVE) | **0.031** | **21×** |
| (參照:上節手寫 NEON 原型) | 0.038 | 17× |

**`fold + &` 是純安全、純庫外、零 unsafe 的寫法,性能已超過我上節的手寫 NEON 原型**——這同時給出了比「std 加分塊特化」更便宜的落地路徑:`all(pred)` 語義上等於「先無早退掃完再看結果」當謂詞無副作用時,std 可以在 `iter().all` 的 slice 特化裏對無副作用謂詞(需 specialization 或新 API)改用 fold 形狀;用戶側則今天就能用 fold 重寫。

代價:fold 版永遠掃完整個輸入。首字節即假的輸入上,早退版 ~1 ns,fold 版 7000B 仍要 ~218 ns——**這是「隨資料分佈的取捨」,與 binary_search 的 branch-vs-csel 同構**:失敗位置的期望值決定哪邊贏,平衡點約在「期望掃描比例 > 幾個百分點」時 fold 勝。

### 熱點精確在哪

`perf annotate`(a_all,99.92% 樣本):**單條 `ldrb w8, [x0], #1`**。完整迴圈只有 7 條:

```asm
loop:
  ldrb w8, [x0], #1      ; 99.92% 樣本(skid 聚集點)
  sub  w10, w8, #0x30    ; b - '0'
  cmp  w10, #0xa
  cset w8, cc            ; 謂詞結果
  cmp  w10, #0x9
  ccmp x9, #0, #4, ls    ; 迴圈條件 & 早退條件融合
  sub  x9, x9, #1
  b.ne loop
```

樣本堆在 `ldrb` 是 PMU skid 對迴圈 backedge 的慣常歸因;真實瓶頸不是 load(L1 命中,IPC 高)而是**每字節必須退休這 7-8 條指令**——0.65 ns/B ≈ 1.9 cycles/B ≈ 每字節 7 條 @ IPC ~3.7,純指令吞吐限制。無 miss、無停頓,機器高效地執行着逐字節的多餘工作,與 BTree 遍歷一節同類。所以「熱點」的正確描述是:**整條 7 指令迴圈體都是熱點,消滅它的唯一方式是換掉逐字節形狀**(fold/SIMD),而不是優化其中任何一條指令。

復現:`/tmp/vect_experiment.rs`(remarks + codegen)、`vect_timing.rs`(三變體計時)。

---

# `str::to_lowercase::short_pile_of_poo`:16 個 emoji 各付一次 4 輪 binary search 只為確認「無映射」;astral fast-reject 原型 -67%

- 日期:2026-08-21
- 分析對象:`library/alloctests/benches/str.rs` make_test 宏生成的 `str::to_lowercase::short_pile_of_poo`
- 接口:`str::to_lowercase`(`library/alloc/src/str.rs:433`)→ `convert_while_ascii` + 逐字符 `conversions::to_lower` → `lookup`
- 平臺:本機 HiSilicon aarch64;x86 為 IR 重定目標的形狀對照

## 源碼層:輸入決定路徑

輸入 `"💩"×16 + "!"`(65B,17 chars)。`to_lowercase` 兩段式:

1. `convert_while_ascii`:16B 塊 SIMD 化的 ASCII 前綴快轉——首字節 0xF0 立即退出,**前綴長度 0,此路徑只貢獻 Vec::with_capacity(65)**;
2. 其餘 17 個字符逐個走 `char_indices` → 💩 非 Σ → `conversions::to_lower(c)` → `c >= '\u{C0}'` → `lookup(c, &LOWERCASE_LUT)`。

💩 = U+1F4A9 在 plane 1:`lookup` 按 `c >> 16 = 1` 取 plane-1 L2Lut(**12 條 singles,0 條 multis**——Deseret/Osage/Medefaidrin/Adlam 等少數有大小寫的輔助平面文字),對 low half 0xF4A9 做 4 輪 binary search,全 miss 返回 None → 原樣 push。**16 個 emoji 各付一次完整表搜索,買到的答案全是「不變」。**

## 基線與 perf

```text
short_pile_of_poo   265.8–266.1 ns/iter(15.6 ns/char)
short_ascii          17.98 ns(對照:全走 convert_while_ascii SIMD 路徑,14.8×)
short_mixed         339.5 ns(泰文在 plane 0,搜 172 條大表,更貴)
long_lorem_ipsum    221.7 ns(1013B 全 ASCII:SIMD 路徑 0.22 ns/B)
```

perf:IPC 3.61,branch miss 0.18%;符號分佈 **`lookup` 80.5%** + `to_lowercase` 本體 9.3% + `to_lower` 4.9% + malloc 2.2%。annotate 樣本聚在 binary search 迴圈(`b.hi` backedge 53.6%、行內加載 23.8%)——與 char::to_uppercase 節同一形狀:`ldrh → cmp → csel` 串行鏈,每字符 4 輪。

## LLVM/彙編層與 x86 對比

`lookup` 的 search 迴圈(libstd 實物)是 `binary_search_by` 的標準 csel 形狀;用最小 probe(同構 6 字節行 binary search)重定目標:

- aarch64:`ldrh + cmp + csel x0, x0, x10, hi` + `b.hi` 迴圈
- x86:`cmpw (%rdi,%r10,2) + cmovbq` + `ja` 迴圈

**逐條同構(csel ↔ cmov),無平臺分歧**——binary_search 一節的結論在此複用:兩平臺都會被同樣的 4 輪串行依賴鏈限制,x86 硬件的每字符成本同形。瓶頸在算法層(每字符一次表搜索),不在後端。

## 原型:astral fast-reject(-67%)

輔助平面(U+10000+)有大小寫映射的碼位全部落在 7 個窄區間(從 LOWERCASE_LUT plane-1 表直接讀出)。在進表搜索前先做區間拒絕:

```rust
if u >= 0x10000 && !in_cased_astral_ranges(u) { out.push(c); continue; }
// 7 個 contains() 的並聯比較,LLVM 編成無查表的直線比較鏈
```

| | ns/iter | 變化 |
|---|---:|---:|
| official(std 現狀) | 257.3 | — |
| astral_skip 原型 | **85.1** | **-67%** |

正確性:對 U+10000..U+20000 + U+1E000..U+1F000 全碼位逐字符與 std 輸出比對通過(覆蓋全部 7 個 cased 區間與邊界)。

落地評估:與 char::to_uppercase 節的 Latin-1 fast path 同族——「高頻無映射輸入付最貴路徑」的第三個實例(Latin-1 無映射 34%、plane-0 標點、astral emoji)。統一的修法是 generator 生成「Changes_When_Cased」bitmap/區間集在 lookup 前快拒;emoji 在現代文本的密度使 astral 檔位可能是三者中實際收益最高的。正式落地仍應改 `unicode-table-generator`,並用 plane-1 表自動導出區間(手抄區間有 Unicode 版本漂移風險)。

## 復現

```bash
LD_LIBRARY_PATH=... build/.../allocbenches-2cf0e8badf7482bf --bench 'to_lowercase'
/tmp/poo_probe          # official vs astral_skip + 全碼位正確性
/tmp/lookup_probe.rs    # → llc x86 形狀對照
```

---

# `hash::set_ops::set_union`:106 ns 裏 92% 是 difference 側的 10 次 SipHash+probe;SipHash 佔 2/3

- 日期:2026-08-21
- 分析對象:`library/std/benches/hash/set_ops.rs::set_union`(small=10,large=100 個 i32)
- 接口:`HashSet::union` → `large.iter().chain(small.difference(&large))`(`set.rs:781`:較大集合直接迭代,較小集合逐元素查另一側)→ `Difference::next` 的 `other.contains(elt)` → SipHash-1-3 + hashbrown group probe
- 平臺:本機 HiSilicon aarch64;x86 為 IR 重定目標形狀對照
- 方法注記:`./x bench library/std` 在本工作樹遇 `duplicate lang item`(stage1-std 構建緩存與 sysroot 衝突),官方 harness 數字缺;以下全部來自 standalone 複製品(與官方 bench 逐行同構)

## 源碼層:union 的算法選擇

`union` 選 `len` 較大側全量迭代,較小側過 `difference` 過濾——benchmark 輸入(10 vs 100,小集是大集子集)下即 `large.iter()(100 個)+ small.difference(&large)(10 次 contains,全命中,全被濾掉)`。結果 110 個迭代步,其中 10 步各付一次完整 hash+lookup。

## 分解實測(2M 次固定迭代)

| 成分 | ns/iter | 佔比 |
|---|---:|---:|
| union 全量 | 106.7 | 100% |
| large.iter().count()(100 元素 RawTable 掃描) | 3.8 | 3.6% |
| **small.difference(&large).count()(10 次 contains)** | **98.1** | **92%** |
| union with FxHash(同結構,換掉 SipHash) | **36.1** | — |

三個結論:

1. **RawTable 迭代快得驚人**:0.04 ns/元素——control-byte 掃描 + 位操作,100 個元素只要 3.8 ns。union 的「大側全迭代」策略本身零負擔。
2. **成本全在 10 次 contains:每次 ~9.6 ns**,其中 SipHash-1-3 對 4 字節 key 的固定成本 ~7 ns(FxHash 對照:106→36 ns,**SipHash 佔 union 總時間 2/3**)。
3. contains 剩餘 ~2.6 ns 是 hashbrown probe:h1 定位 group、8 字節 control 比較、h2 確認、key 比對。

## perf/彙編層

96.7% 樣本在 `Difference::fold` 單符號(count 經 fold 內聯了整條鏈)。annotate 三個熱區:SipHash 輪函數(`eor/ror #48/add` 鏈,~50% 樣本分散)、group 匹配(`cmeq.8b + fmov + rbit/clz`,~25%)、命中確認迴圈。aarch64 的 group probe 用 NEON 8 字節 `cmeq`;SipHash 是純標量 ARR(add-rotate-xor)鏈——**串行依賴,無 ILP 可挖**,這就是每 key 7 ns 的來源(1-3 輪對 4B key 已是 SipHash 家族最便宜配置)。

## x86 對比

SWAR group-match probe 重定目標:aarch64 `mul(splat) + eor + add/bic + rbit + clz` ↔ x86 `imulq + xorq + addq/notq/andq + rep bsfq`——**逐步同構**(x86 缺 rbit 用 bsf 正向位掃,方向差異無成本影響)。SipHash 輪在 x86 同樣是標量 `add/rol/xor` 串行鏈。**無平臺分歧**:兩邊瓶頸都是 SipHash 串行延遲,微架構係數外行為同形。

## 判斷

1. **無 std 病灶**:union 的「大側迭代+小側過濾」已是正確算法;RawTable 迭代與 probe 都貼近極限。106 ns 的 2/3 是 **HashDoS 防護的有意代價**(SipHash 隨機化),與 hash::map::new_drop 節的 TLS 計數器同屬語義權衡——用戶側如不需防護,`FxHashSet` 一行換掉即 3×。
2. benchmark 形狀注記:10/100 且 small ⊂ large 是「difference 全過濾」的特例;若兩集不相交,difference 側每次 miss 的 probe 更短(h2 不匹配即返回),數字會更低。現輸入測的是 contains-hit 路徑,合理但單一。
3. 唯一可探討的 std 方向:`Difference` 對連續多次 contains 沒有批量化(每個 key 獨立走完整 hash+probe);理論上可以 hash 流水化(計算 key[i+1] 的 hash 同時 probe key[i]),但 iterator 逐元素契約使之只能在 `fold`/`count` 特化裏做,收益上限 ~30%(hash 與 probe 部分重疊),工程複雜度高——不建議,先記錄。

## 復現

```bash
/tmp/set_union_probe   # union/large_iter/difference/union_fxhash 分解
/tmp/setops_codegen.rs # → llc x86 group-probe 形狀對照
```

---

# `sys::io::kernel_copy::linux::tests::bench_socket_pipe_socket_copy`:「慢」在每 iter ~4.4 次 syscall 的內核往返,splice 零拷貝本身工作正常

- 日期:2026-08-21
- 分析對象:`library/std/src/sys/io/kernel_copy/linux/tests.rs:229`
- 接口:`io::copy(&mut pipe.take(128K), &mut socket)` → kernel_copy 特化 → `splice(2)` syscall
- 平臺:本機 aarch64,kernel 6.6.0(openEuler);數據來自逐行同構的 standalone 複製品(std 官方 unit-test bench 因本工作樹 stage1-std 構建緩存的 duplicate-lang-item 衝突無法直接運行)

## benchmark 拓撲與測量對象

三線程數據環:remote socket 非阻塞灌水 → 後臺線程 `splice(socket→pipe)` 無限泵 → **被測主迴圈 `io::copy(pipe→socket, 128KB/次)`**(廻到 remote 排水)。`io::copy` 識別 pipe→socket 走 kernel_copy 的 splice 路徑——測的是「零拷貝轉發 128KB」的端到端成本,不含任何用戶態數據搬運。

## 複製過程中的兩個發現(供復現者避坑)

1. **`splice(len = u64::MAX)` 直接 EINVAL**:我的第一版複製品每秒 38 萬次 splice 全失敗(strace: 383,132 calls = 383,132 errors),pipe 無數據流入,io::copy 永久阻塞——看似 hang,實為泵線程空轉。官方 `sendfile_splice` 把 len 截到 `0x7ffff000`(linux.rs:845),照抄後即通。內核對超過 MAX_RW_COUNT 的 len 不截斷而是拒絕。
2. 官方 bench 先用 1 字節 probe 驗證 splice 可用纔進主迴圈——這個防護正是為了避免我踩的坑。

## 實測與瓶頸歸屬

```text
複製品:22.2–31.8 µs/iter(128KB → 3.9–5.6 GB/s,受 timeout/strace 擾動浮動)
```

決定性計數:

- **user 0.004 s vs sys 0.515 s——99% 時間在內核**;
- strace 3000 iter:13,201 次 splice(≈4.4 次/iter:io::copy 側 pipe→socket 每 64KB pipe 容量分段 ~2 次 + 泵線程 socket→pipe ~2 次)+ 少量 sendto/recvfrom(remote 排水,其中 sendto 48% EAGAIN——非阻塞空轉);
- perf:38.6% 單一內核地址(kallsyms 無權限,按上下文為 splice 的 pipe/socket 傳輸路徑)+ 25.4% libc syscall stub。

**「慢在哪」的答案:每 128KB 轉發要付 ~4 次 syscall 進出(每次 ~2–5 µs 的內核路徑:上下文保存、pipe buffer 頁引用移交、socket 發送路徑),外加泵線程與主迴圈在同一條 pipe 上的鎖競爭。** 沒有用戶態 memcpy(splice 本義),0.5 GB/s 級的 memcpy 成本已被消掉;剩下的就是 syscall 邊界成本 × 次數。

## 判斷

1. **std 無病灶**:kernel_copy 已把 io::copy 特化到 splice(這正是這組 tests 守護的行為);128KB/iter 只需 2 次 splice 是 pipe 默認容量(64KB)決定的,`fcntl(F_SETPIPE_SZ)` 加大 pipe 可減半 syscall 數,但那是 benchmark 參數不是 std 職責。
2. benchmark 定位是**行為守護**(splice 路徑被選中且正確)而非吞吐極限測量:三線程環的調度耦合使數字方差大(同機 22–32 µs),不適合做回歸閾值。
3. 內核側成本(頁引用移交、socket 路徑)非 std 可及;唯一用戶可見的槓桿是更大的 pipe 容量與 batch 大小。
4. x86 對照無意義:純 syscall/內核路徑成本,無用戶態 codegen 分歧。

## 復現

```bash
/tmp/kernel_copy_probe 20000     # 逐行同構複製品(注意 len 截斷)
/tmp/splice_check                # 單次 splice 可用性探針
strace -c -f ./kernel_copy_probe 3000              # syscall 分解
```

## 官方 harness 直測驗證(2026-08-21,替代複製品數據)

按要求改用**官方 benchmark 本身**測量(`./x test library/std --test-args --bench --test-args bench_socket_pipe_socket_copy`,及直接運行構建出的 `std-4eef337f42a5c3f9` 測試二進制配 stage1 libstd):

```text
官方基線:26,499–29,397 ns/iter(±466–19,607,4.5 GB/s 級)
strace 下:58,759–60,939 ns/iter(ptrace 攔截使每 syscall +~10 µs,數字翻倍——
         這本身就是「syscall 次數主導」的直接證據)
```

perf stat(官方 bench 進程):**user 0.045 s vs sys 6.29 s——98.6% 時間在內核**;用戶態 IPC 0.82,cycles:u 僅 138M(全程 3.2s)。perf record 樣本 72% 在內核地址(本機 perf_event_paranoid=2 且 kallsyms 地址隱藏,無法解析到函數名;49.8% 集中在單一地址,按 syscall 構成應為 splice 的 pipe→socket 傳輸路徑)。

**strace 逐 syscall 證據(官方 bench 全程)**:

- splice 317,300 次(65% strace 時間),recvfrom 72,552、sendto 72,553(其中 59% EAGAIN——remote 排水線程的非阻塞空轉);
- splice 延遲分佈:**p50 = 14 µs,p90 = 24 µs,p99 = 40 µs**(strace 膨脹後;無 strace 時按 26.5 µs/iter ÷ ~4 次 ≈ 6–7 µs/次);
- **per-thread 拆分**:被測 io::copy 線程 164,885 次 splice,泵線程 158,329 次——兩側幾乎 1:1;
- **splice 返回值分佈**:io::copy 側 42% 是 65536(= pipe 默認容量,每 128KB iter 需 2 次滿容量 splice),其餘為 61440/57344/... 的部分傳輸(與泵線程競速時 pipe 未滿就被取走);泵線程側同樣以 64KB 段為主。

官方數據與此前複製品結論一致並更精確:**慢在每 iter ~4 次(兩側合計)splice syscall 的內核往返,每次搬運上限被 pipe 64KB 容量卡住**;部分傳輸的長尾(splice 返回 108 字節這類碎片有 7,765 次)說明兩線程在同一條 pipe 上的生產-消費競速還會放大 syscall 次數。零拷貝語義本身工作正常,用戶態計算可忽略(0.7% 時間)。

---

# `ascii::bench_ascii_escape_display_no_escape`:fast path 本身是逐字節標量掃描,NEON 原型 4.6×;自動向量化這次連分塊都救不了

- 日期:2026-08-21
- 分析對象:`library/coretests/benches/ascii.rs:360`(139B 純可打印 ASCII 路徑,無一字節需轉義)
- 接口:`<[u8]>::escape_ascii` 的 `Display`(`library/core/src/slice/ascii.rs:378`)→ `take_while(!needs_escape)` prefix 掃描 + `write_str`
- 平臺:本機 HiSilicon aarch64

## benchmark 實際測甚麼

`EscapeAscii::fmt` 的設計已經有 fast path:用 `take_while` 數出無需轉義的前綴長度,整段一次 `write_str`,只對需轉義的單字節走 `escape_default`。本輸入(139B 全部可打印)恰好走**一次完整 take_while 掃描 + 一次 write_str**——測的就是這個 fast path 的掃描吞吐。

```text
bench_ascii_escape_display_no_escape   117.4–120.3 ns/iter(0.85 ns/B)
bench_ascii_escape_display_mixed     5,211–5,262 ns/iter(對照:1466B 含大量轉義)
```

## perf 與熱迴圈

IPC 4.85,branch miss 0.00%,94.3% 樣本在 `EscapeAscii::fmt` 單符號。annotate 熱點集中在 take_while 迴圈:

```asm
loop:
  ldrb w8, [x20, x21]      ; 逐字節載入
  sub  w9, w8, #0x7f
  cmn  w9, #0x5f           ; b > 0x7E || b < 0x20(合併範圍檢查)
  b.cc escape
  sub  w8, w8, #0x22
  cmp  w8, #0x3a
  b.hi next                ; 0x22..0x5C 窗口外 → 無需查掩碼
  lsr  x8, x28, x8         ; 64-bit 立即掩碼(x28)測 \ ' "
  tbz  w8, #0, next
```

LLVM 把 `needs_escape` 的 5 個條件優化成「範圍檢查 + 64-bit 位掩碼」的緊標量形狀(~7 指令/字節,64.9% 樣本堆在掩碼路徑,IPC 4.85 已到標量發射極限)——**與 is_ascii_* 謂詞族同病:每字節指令數,不是任何 miss**。

## 原型對照:分塊救不了,顯式 NEON 4.6×

| 形狀 | ns(139B) | ns/B | 說明 |
|---|---:|---:|---|
| take_while(=std 現狀) | 113.1 | 0.79 | 標量極限 |
| 分塊 16B 無早退(dedup 配方) | 141.9 | 0.99 | **LLVM 未向量化,反而慢 25%** |
| 顯式 NEON(5 條件 → cmgt/cmlt/ceq×3 + vorr + vmaxvq) | **24.4** | **0.17** | **4.6×** |

關鍵教訓:**dedup-prescan 的「分塊即向量化」配方在這裏失效**——`needs_escape` 是 5 條件 OR(兩個範圍+三個等值),LLVM 對這種塊內歸約直接放棄(對比 dedup 的單一相等比較)。自動向量化的可行窗口比「無早退」更窄:謂詞本身也要足夠簡單。顯式 SIMD 是唯一路徑,5 個條件恰好是 5 條 NEON 比較 + 3 條 OR + 1 條 vmaxvq 歸約,16B/輪。

正確性:空輸入、含 `\` / `"` / 控制字節、64 邊界跨塊命中等 6 組探針與 std 掃描逐一一致。

## 判斷

1. fast path 結構(prefix 掃描 + 整段 write_str)是對的,慢在掃描本身逐字節;139B 輸入 0.85 ns/B 對比 NEON 0.17 ns/B 有 **4.6×** 已驗證空間。
2. 落地位置就是 `EscapeAscii::fmt` 裏的 `needs_escape` 掃描(core 內可用 `#[cfg(target_arch)]` NEON,x86 對應 SSE2 `pcmpgtb/pcmpeqb/pmovmskb` 同構形狀——但 core 的 fmt 路徑加 arch 特化需要權衡代碼量);mixed 輸入(轉義密集)收益遞減,escape 段主導時瓶頸轉移到 `escape_default` 的單字節 Display。
3. 歸類:與 `is_ascii_*`(§ascii 謂詞族)同根——「標量逐字節分類」;但本例證明其修復配方分兩檔:簡單謂詞(相等/單範圍)分塊即可讓 LLVM 自動向量化,複合謂詞必須顯式 SIMD。
4. x86 對照未做硬件實測;`needs_escape` 的向量形狀在 SSE2 有逐條對應指令,結構收益可移植(判斷,非實測)。

## 復現

```bash
LD_LIBRARY_PATH=... build/.../corebenches-14ea307f41bce867 --bench 'ascii_escape_display'
/tmp/escape_scan_probe    # takewhile vs chunked16 vs neon + 正確性
```

---

# `iter::bench_skip_while_sum`:skip_while 被完全優化掉,測的是 `map(black_box)` 的每元素棧屏障;兩 ISA 逐條同構

- 日期:2026-08-21
- 分析對象:`library/coretests/benches/iter.rs:314`(`bench_sums!` 宏:`(0i64..1000000).skip_while(|&x| x < 1000).map(black_box).sum()`)
- 接口:`SkipWhile::{next,try_fold,fold}`(`library/core/src/iter/adapters/skip_while.rs`)
- 平臺:本機 HiSilicon aarch64;x86 為同一 IR 重定目標形狀對照

## 源碼層:bench_sums 宏的度量意圖

`bench_sums!` 生成 value 版(`$iter.map(black_box).sum()`,fold 可優化)與 ref 版(`.by_ref().sum()`,只能逐 next)。`SkipWhile::fold` 的實現:flag 未立時先用 `next()` 消化 skip 前綴,之後**直接把 inner iterator 的 fold 接管**(`self.iter.try_fold(init, fold)`)——skip 完成後的 999,000 個元素不再經過任何謂詞檢查。

## LLVM 層:三個決定性事實

用 no_std probe 對照(同源碼 ± black_box):

1. **不帶 `map(black_box)` 的純形狀被完全常量摺疊**:`skip_while_sum_pure` 編譯成單條 `mov x0, #499999000500; ret`——LLVM 對 Range+skip_while+sum 直接閉式求和。這說明 `map(black_box)` 不是點綴,是這個 benchmark 能測到任何東西的前提。
2. 帶 black_box 的版本:skip 前綴(0..1000)也被摺掉(彙編直接從 `mov w10, #1001` 起步,初值 `str x8=1000` 進棧)——**skip_while 謂詞在最終代碼裏零指令**,`fold` 移交給 inner Range 的結構被 LLVM 徹底看穿。
3. 剩下的迴圈是純粹的「black_box 稅」:每元素把值寫進棧槽、過空 asm 屏障、再從棧槽讀回來累加。

## 彙編/perf:兩 ISA 逐條同構的棧往返迴圈

official 二進制熱迴圈(99.9% 單符號,樣本 83% 堆在 `stur`——棧寫即屏障本體):

```asm
; aarch64(7 條/元素)                 ; x86(同構 6 條/元素)
stur x10, [x29, #-32]   ; black_box 寫   movq %rdx, -8(%rsp)
add  x10, x10, #1                        incq %rdx
add  x12, x10, x20      ; 迴圈計數
ldur x11, [x29, #-32]   ; black_box 讀   addq -8(%rsp), %rax
cmp  x12, #0x3e9
add  x9, x11, x9        ; sum
b.ne loop                                cmpq $1000000; jne
```

實測 641,272 ns / 999,000 元素 = **0.64 ns/元素 ≈ 1.86 cycles**,IPC 3.76、miss 0.00%——每元素一次 store→forward→load 棧往返(與 slice::push 節同類的轉發鏈,但這裏無依賴串行化,吞吐型)。x86 形狀逐條對應(`movq/incq/addq-mem/jne`),無任何平臺分歧;x86 的 memory-operand `addq` 還省一條顯式 load。

旁證:`bench_skip_while_sum`(641.3 µs)與 `bench_skip_sum`(641.6 µs)、`bench_skip_while_ref_sum`(641.4 µs)三者相等——skip 家族全部歸一到同一個 black_box 迴圈;chain 版(995 µs)多出的是 chain 的分支結構。ref 版與 value 版相等說明對 Range 這種簡單 inner,逐 next 與 fold 生成了同樣的迴圈。

## 判斷

1. **skip_while 適配器本身零開銷**(fold 移交 + LLVM 摺疊做得好到謂詞完全消失)——這正是 benchmark 守護的目標,現狀成立。
2. 641 µs 的數字全部是 `map(black_box)` 的每元素棧屏障成本,**不反映 skip_while 的任何性質**;它作為「適配器沒有引入額外開銷」的相對守護有效(與 bench_skip_sum 等值可比),作為絕對數字無意義。
3. 無 std 可改、無 LLVM 可改;x86 同構無分歧。歸類為「守護型」benchmark(同 peek_mut_deref_mut)。
4. 若想真正測 skip_while 的謂詞開銷,需要 ref_sum 形狀 + 不可預測的 skip 邊界(現輸入固定 1000,分支完美可預測);現有 ref 版與 value 版等值恰好說明現輸入測不出差異。

## 復現

```bash
LD_LIBRARY_PATH=... build/.../corebenches-14ea307f41bce867 --bench 'skip_while'
# probe:/tmp/skipwhile_probe.rs → asm(aarch64)+ llc x86;pure 版一條 mov 是決定性證據
```

---

# `iter::bench_enumerate_chain_ref_sum`:宏的 value/ref 對照假設已過時——ref 版同樣被迴圈分裂,Chain 狀態機零殘留

- 日期:2026-08-21
- 分析對象:`library/coretests/benches/iter.rs:237`(`(0i64..1M).chain(0..1M).enumerate().map(|(i,x)| x*i as i64).map(black_box).by_ref().sum()`)
- 接口:`Chain::try_fold` / `Enumerate::try_fold`(`library/core/src/iter/adapters/{chain,enumerate}.rs`)+ `&mut I` 的 try_fold 轉發
- 平臺:本機 HiSilicon aarch64;x86 為 IR 重定目標形狀對照

## 基線:value ≡ ref,宏想測的差異不存在

```text
bench_enumerate_chain_sum        1,172,416 ns(value:可用 fold 特化)
bench_enumerate_chain_ref_sum    1,172,397 ns(ref:宏註釋稱 "cannot optimize fold")
bench_enumerate_sum / ref_sum      540,8xx ns(無 chain 對照,同樣 value≡ref)
```

2M 元素 → 0.586 ns/元素(1.70 cycles);chain 對非 chain 只貴 8.5%。IPC 4.41,branch miss 0.00%。

## 彙編:ref 版也被完全迴圈分裂(決定性證據)

official 二進制(99.9% 單符號)的 ref 版熱迴圈是**兩段獨立直線迴圈**:

```asm
; 前半段:enumerate 的 i == x,LLVM 直接融合成 i²
loop1: mul  x11, x10, x10        ; x*i = i²
       add  x10, x10, #1
       stur/ldur [x29,#-32]      ; black_box 棧屏障
       add  x9, x11, x9          ; sum
       b.ne loop1
; 後半段:i = x + 1,000,000
loop2: add  x11, x10, x20        ; i = x + 1M
       mul  x11, x10, x11        ; x*i
       ...同樣屏障+sum
```

**Chain 的「當前在哪一段」狀態檢查在兩個版本裏都是零指令**;Enumerate 計數器被融合進歸納變量(前段一條 `mul`,後段多一條 `add`——這就是 8.5% 差值的全部)。x86 重定目標逐條同構(`imulq %rdx,%rdx` / `leaq 1000000(%rdx); imulq`),無平臺分歧。

## LLVM/源碼層機理:為什麼 ref 版沒有劣化

x86 probe 的符號名直接給出調用鏈:`...Iterator8try_fold...map_try_fold...NeverShortCircuit...wrap_mut_2...`——即:

1. `sum` → `fold`,而 `Iterator::fold` 的**默認實現**就是 `self.try_fold(init, NeverShortCircuit::wrap_mut_2(f))`;
2. `impl Iterator for &mut I` **轉發 try_fold** 到底層;
3. `Chain::try_fold` 自身顯式分兩段(前段 try_fold + 後段 try_fold),`Enumerate::try_fold` 疊加計數;
4. LLVM 對兩段各自做直線化與歸納變量融合。

所以 `bench_sums!` 宏註釋「by reference which cannot optimize fold」描述的是 try_fold 轉發鏈完善之前的世界;今天 ref 版經由同一條 try_fold 結構,與 value 版生成逐條相同的代碼。**value/ref 對照在所有 bench_sums 系列上都已失效**(skip_while 節的 ref≡value 是同一機理)——這是適配器架構的好消息,也是 benchmark 對照設計的過時。

剩餘的 0.586 ns/元素與 skip_while 節相同:`map(black_box)` 每元素棧屏障(stur/ldur 對)+ mul + sum,7–8 條/元素的吞吐迴圈。

## 判斷

1. **Chain/Enumerate 適配器在 fold 消費下零開銷**(狀態機、計數器全部被結構性消除),ref 轉發鏈同樣兌現——守護目標成立,無 std 病灶。
> **2026-10-10 修正**:「全系」不成立——`bench_filter_map_sum` / `_ref_sum` 差 51%。原因不是 ref 無法優化 fold,而是 ref 形狀讓常數界晚於迴圈旋轉才可見,錯過 InstCombine 消除 `checked_mul` 溢出檢查的時機。見 `iter::bench_filter_map_chain_ref_sum` 章。

2. benchmark 系列級發現:`bench_sums!` 的 value/ref 對照已測不出差異,16 對 bench 實質重複;若要恢復對照意義,ref 側需用真正的 dyn 邊界(`&mut dyn Iterator`)或 `by_ref().take(n)` 這類打斷 try_fold 靜態轉發的形狀。
3. 絕對數字由 black_box 屏障主導(同 skip_while 節),僅相對比較有效。
4. x86 同構無分歧。

## 復現

```bash
LD_LIBRARY_PATH=... build/.../corebenches-14ea307f41bce867 --bench 'enumerate'
# probe:/tmp/enum_chain_probe.rs → asm + llc x86(兩段分裂 + try_fold 符號鏈)
```

---

# `fmt::write_u64_min`:格式化 "0" 比 20 位 MAX 慢 19%——短輸出把 format! 機制固定成本放大到 87%

- 日期:2026-08-21
- 分析對象:`library/coretests/benches/fmt.rs:146`(`format!("{}", black_box(u64::MIN))`)
- 接口:`format!` → `alloc::fmt::format_inner` → `core::fmt::write` → `u64 as Display`(`library/core/src/fmt/num.rs` 的 ÷10 迴圈 + `pad_integral`)→ String 分配
- 平臺:本機 HiSilicon aarch64

## 基線:反直覺且穩定復現的排序

```text
write_u64_min("0",1 字符)     54.6–55.1 ns   ← 比 MAX 慢 19%
write_u64_max(20 字符)         44.8–44.9 ns
write_u8_min("0")              52.6–53.3 ns   ← 同樣 min > max
write_u8_max("255")            51.4–51.8 ns
write_u128_min("0")            56.4–56.5 ns
write_u128_max(39 字符)        62.2–63.2 ns   ← 僅 u128 恢復 max > min
```

> **2026-09-30 修正**:本表的 `write_u64_max = 44.8–44.9 ns` **只存在於 2026-09-15 構建的舊 libstd**。在本工作階段所建的每一個 libstd 上(`core_inert`/`core_patch2`/`core_3b2`,以及**移除全部 core 原型後重新構建的對照組**),`u64::MAX` 與 `u8::MAX` 同為 **~52 ns**;固定 2000 萬次迭代的探針顯示兩個 arm 的**指令數逐位元組相同**(496 / 576,跨 libstd 亦同),差異全在 `STALL_FRONTEND`(u64 arm:舊 libstd 3.5 vs 現版 22.5 停頓/迭代;u8 arm 兩者皆 ~39–40)。因此「min 比 max 慢 19%」不成立於現版——四項 `{u8,u64}_{min,max}` 落在 51.5–56.3 ns 帶內,由佈局決定的前端停頓主導,而非輸入長度。詳見下方 `write_u8_max` 章(2026-09-30)。

## perf 分解(F=2000 record,按各自 ns/iter 換算)

| 成分 | min("0") | max(20 位) |
|---|---:|---:|
| `u64 Display::fmt`(÷10 轉換本體) | 7.4 ns | **19.9 ns** |
| malloc + free + alloc shims + `finish_grow` | **~20.9 ns** | ~7.5 ns |
| `core::fmt::write` + `pad_integral` + `write_prefix` | 9.7 ns | 2.2 ns |
| `format_inner` | 6.7 ns | 2.6 ns |

三個確鑿事實:

1. **max 的數字轉換(19.9 ns)只解釋了它該慢 12.5 ns;實際卻快 10 ns**——即 min 的「機制段」(分配器+fmt 調度)實測 ~48 ns,是 max ~25 ns 的近兩倍。
2. min 獨有 `RawVecInner::finish_grow` 顯著樣本(2.3 ns)——兩者都從 `estimated_capacity()=0` 的空 String 起步、一次 grow,但只有 min 的 grow 路徑在 profile 中獨立成點。
3. malloc 內部熱點偏移兩邊相同(tcache 快路徑 prologue),**排除「不同 malloc 桶/路徑」假說**。

## 判讀與誠實邊界

短輸出檔位實測的是 **`format!` 機制鏈的固定成本**:跨 so 的 `format_inner → fmt::write → Display::fmt → pad_integral → write_prefix → String::write_str → reserve/grow → malloc` 串行小調用鏈,每環 5–15 cycles 的 call/ret+參數準備,無計算可與之重疊。"0" 的轉換僅 ~7 ns,其餘 87% 全是機制;20 位輸出的轉換迴圈(~20 ns)部分與機制交疊後總時間反而更低。u128 的轉換成本(39 位,128-bit 除法)足夠大才重新蓋過機制差,恢復 max > min 的直覺排序。

「min 機制段為何恰好貴 ~23 ns」在採樣 profile 的解析力內無法完全定量歸因(候選:短調用鏈的 OoO 重疊差異、採樣 skid 在小函數間的歸因漂移);已排除 malloc 路徑差異與分支失誤差異(兩者 miss 均 0.15%)。10 ns 級的差需要 pipeline 級工具才能繼續拆。

## 結論

1. 這組 min/max benchmark 實際測的是**兩個不同的東西**:min 測 `format!` 機制固定成本(~48 ns,分配器佔 40%),max 測轉換迴圈+機制。命名暗示的「同路徑不同輸入」不成立,兩者不可做同軸比較。
2. **std 可探討方向**:(a)機制鏈條的跨 so 小函數(`pad_integral`/`write_prefix` 對無 width/prefix 的 `{}` 快路徑可短路)——**仍未原型**;(b)`estimated_capacity` 對純 `{}` 返回 0 導致必然 grow——**已於 `write_u8_min` 章原型並實測為零和**(min −47% 但把前端停頓原樣轉移到 `u64_max` +47%),且 2026-09-30 的 `write_u8_max` 章顯示該 8 ns 差距只存在於舊 libstd,現版兩型別同為 ~52 ns,**此方向作廢**。兩者收益都在 5–10 ns 級,對真實 workload(格式化通常伴隨更多內容)佔比有限。
3. ISA 對比無必要:機制鏈是調用開銷+分配器,÷10 迴圈兩平臺同構(`umulh` 倒數乘法),無結構分歧。

## 復現

```bash
LD_LIBRARY_PATH=... build/.../corebenches-14ea307f41bce867 --bench 'write_u'
perf record -e cycles:u -F 2000 ... --bench 'fmt::write_u64_{min,max}' --exact
```

---

# `btree::map::clone_slim_10k_and_remove_half`:每次 remove 的 ~86% 是根到葉搜索,節點內 early-exit 線性掃描每層貢獻約一次分支失誤

- 日期:2026-09-07
- 分析對象:`library/alloctests/benches/btree/map.rs:505`(clone 一個 10k 的 `BTreeMap<usize,usize>`,逐個 `remove` 全部偶數鍵 5000 個,assert 後連 map 一起被 `Bencher::iter` drop)
- 接口:`BTreeMap::remove` → `search::search_tree`/`find_key_index`(節點內線性搜索)+ `remove::remove_leaf_kv`(下溢 steal/merge);背景噪聲來自 `Clone::clone_subtree` 與 `IntoIter` 的 dying 走查
- 平臺:本機 HiSilicon aarch64(0xd02)stage1;x86 為 llc IR 重定目標形狀對照

## 這個 benchmark 實際在測什麼

`slim_map(10_000)` 由 sorted iter bulk-build 而來:葉節點填滿(CAPACITY=11),內部節點滿 12 子——**994 個節點(910 葉 + 76 + 7 + 1 root),高度 3,搜索固定訪問 4 個節點**。clone 保形(`clone_subtree` 逐節點 push),所以每輪迭代 = 994 次 malloc 的 clone + 5000 次「從根搜索 + 葉內刪除 + 就地再平衡」+ 5000 元素殘餘 map 的 drop。

官方系列數據(同一輪 `--bench 'clone_slim_10k'`):

| benchmark | ns/iter | 淨值(減 clone 125.0µs) |
|---|---:|---:|
| `clone_slim_10k` | 125,032 | — (基線,含整棵 clone 的 drop) |
| `..._and_clear` | 124,306 | ≈0 |
| `..._and_drain_half`(extract_if) | 141,687 | **3.3 ns/元素** |
| `..._and_pop_all` | 334,332 | 20.9 ns/pop |
| `..._and_remove_all`(每次刪最左) | 379,296 | 25.4 ns/remove |
| `..._and_remove_half`(本節) | 349,061 | **44.8 ns/remove** |

三個對照已經把故事講了一半:同樣是逐元素結構刪除,**掃描位置固定在最左(remove_all/pop_all)只要 21–25 ns,位置掃過整個節點(remove_half)要 44.8 ns,走游標不搜索(drain_half)只要 3.3 ns**。

## 成本歸因(perf,cycles:u,64K 樣本)

每迭代 ~1.013M cycles(350µs @2.9GHz);IPC 2.45,branch miss 3.50%,L1d miss 0.25%,backend stall 15%——**不是訪存瓶頸,是分支+依賴鏈**。

| 區段 | 佔比 | 說明 |
|---|---:|---|
| 搜索迴圈+層間 descend(閉包內聯) | **~49%** | 下詳 |
| remove 調用簿記(閉包內) | ~9% | handle 落棧、length 遞減、root 收縮檢查 |
| `remove_leaf_kv`+`remove_kv_tracking`+memmove+steal | ~10% | 刪除與再平衡本體 |
| `clone_subtree` | 7.6% | |
| `deallocating_next`(末尾 drop 走查) | 8.0% | 逐元素調用,見「附帶發現」 |
| libc malloc/free | 12.4% | clone 994 allocs + merge/drop 的 frees |

branch-misses 事件單獨採樣:**71.9% 落在閉包搜索迴圈**,9.3% 在 `remove_leaf_kv`。每迭代 ~17.6k 次失誤,扣除 clone+drop 份額後 ≈ **2.9 次/remove——4 層節點訪問幾乎每層退出點都猜錯一次**,以 ~13–16 cycles/次計佔每次 remove(~130 cycles)的三分之一。

## 搜索熱路徑彙編(aarch64)

`find_key_index` 的三向比較被完美 if-conversion(`cset/csinv`,無分支),但**「首個非 Greater 即退出」的決策本質上是數據依賴分支**,退出位置隨掃過節點而漂移,TAGE 記不住 4 層嵌套的變長迴圈:

```asm
30460: ldr   x13, [x8, x11, lsl #3]  ; 8.9%  keys[i](鍵區在節點 +8)
30464: cmp   x21, x13
30468: cset  w13, hi                 ; Ordering 三向值,if-converted
3046c: csinv w13, w13, wzr, cs
30474: cmp   w13, #1
30478: b.ne  3048c                   ; ★ 數據依賴退出(Greater 則繼續)
3047c: subs  x12, x12, #8            ; 25.4%(失誤 skid 聚集點)
30484: b.ne  30460
3048c: cbz   w13, 304b0              ; 11.0% ★ Equal→remove / Less→下降
30498: add   x8, x8, x10, lsl #3
304a0: ldr   x8, [x8, #192]          ; descend:child 指標鏈
304a4: ldrh  w10, [x8, #186]         ; child len,4 層串行
```

每鍵 6 指令 + 2 分支;整段搜索 ≈ 49% × 1.013M / 5000 / 4 層 ≈ **25 cycles(8.6 ns)/節點訪問**。

`remove_leaf_kv`(未內聯)自身的 6.2% 裡:~30% 是 12 個 callee-saved 寄存器的出入棧與調用方剛 `stp` 的 handle 立即 `ldr` 回來(store-forward 鏈);**每次刪除兩條 `memmove@plt`**(鍵區/值區各左移一次,平均 ~44 B——這種尺寸下 PLT 調用開銷與拷貝本體同量級)。

## 決定性實驗一:get/remove/extract_if 拆分(同一二進制)

探針把官方閉包拆開(`/tmp/btree_bench/probe_split.rs`):

| 迴圈 | 總時間 | 淨值 |
|---|---:|---:|
| A clone+drop | 56.8 µs | 基線 |
| B +5000 `get` | 279.8 µs | **44.6 ns/get** |
| C +5000 `remove`(bench 複製品) | 315.3 µs | **51.7 ns/remove** |
| D +extract_if 刪一半 | 131.2 µs | 14.9 ns/元素 |

**搜索(get)= 44.6 ns,佔 remove(51.7 ns)的 86%;結構修改+再平衡+節點釋放淨值只有 ~7 ns。** 任何不動搜索的優化上限就是這 7 ns。

## 決定性實驗二:early-exit vs 無分支全掃描核心(cap=11,u64,全駐 L1)

| 目標序列 | early_exit(std 現狀形態) | branchless(計數 `k<key`) |
|---|---:|---:|
| cyclic(退出位置規律輪轉) | 5.66 ns | 3.67 ns |
| random(偽隨機退出位置) | 9.6–9.7 ns | 5.13 ns |
| random-hit(等值命中,葉層情形) | **9.9 ns** | **3.71 ns** |

樹內實測 8.6 ns/節點與 early_exit random-hit 的 9.9 ns 對上——**病理復現成功,無分支版 1.9–2.7×**。兩平臺 codegen:aarch64 把 branchless 自動向量化成 5 條 `cmhi v.2d` + `addp` 水平求和 + 尾部 `csel`,零數據依賴分支;llc 重定目標 x86 同樣自動向量化(SSE2 `pcmpgtd` 符號翻轉技巧),而 early_exit 在 x86 是逐鍵 `cmp/seta/sbb` + 兩條件跳轉的展開鏈——**病理與收益跨平臺對稱**。

## 附帶發現:整個 clone_slim_10k 系列的基線被 drop 走查的內聯失敗放大 2.2×

官方 `clone_slim_10k`(125 µs)與語義相同的獨立探針(57 µs)差 2.2×。perf 對比定位:官方二進制裡 `deallocating_next` 佔 42%(~52 µs)——`IntoIter::drop` **逐元素**調用未內聯的 `deallocating_next`(10k 次/iter,5.2 ns/元素);小探針裡它被內聯後,LLVM 看到 `(usize,usize)` 無 drop,把逐元素走查坍縮成逐節點(全部 drop ~13 µs)。大 bench crate 裡該符號調用點眾多,inliner 拒絕內聯,坍縮不發生。已排除 codegen-units(probe CGU=16 復現不出)與動態鏈接(prefer-dynamic 復現不出)。**這是系列級噪聲:所有 `clone_slim_10k_and_*` 的差值都以一個被放大約 2× 的基線做減法**;也提示一個 std 修復點——`IntoIter::drop` 對 `!needs_drop::<(K,V)>()` 特化成節點級走查,可讓 drop 結構性 O(節點數) 而不賭內聯運氣(`clear`、drop、`into_iter().count()` 全家受益)。

## 優化空間

1. **[主案] 節點內搜索的原生整數鍵特化(無分支全掃描)**:`find_key_index` 保持通用 early-exit(`Ord` 副作用可觀察,通用代碼不能多調 `cmp`),對 `K=Q=` 原生整數經內部特化 trait 走計數式全掃描。以核心實測估算:每節點省 4.5–6 ns × 4 層 ≈ 18–20 ns/remove,**remove 階段 −35–40%,本 bench 總時間約 −25%**;`get`/`insert`/`range`/`search_seq/rand` 及 `BTreeSet` 同路徑全部受益。代價:特化基建 + 掃穿節點多讀 ~5 鍵(全在同兩條 cache line 內)。
2. **[次案] `slice_remove`/`slice_insert` 的小尺寸 memmove**:cap≤11 時 `ptr::copy` 的動態長度讓 LLVM 生成 `memmove@plt` 調用(每 remove 兩次)。行內短拷貝迴圈可省調用開銷,量級 ~2–4 ns/remove,insert 側同樣受益。
3. **[附帶] `IntoIter::drop` 的 `!needs_drop` 節點級特化**(見上節,~4× drop 加速)。
4. **[接口指導] 批量條件刪除應該用 `extract_if`**:同樣刪 5000 個,游標式 3.3–15 ns/元素 vs 逐個 remove 的 44.8–51.7 ns——本 bench 度量的主體其實是「不用游標 API 的代價」。
5. **[bench 設計注記] 信號稀釋**:官方數字中 clone+drop 佔 ~36%(且基線本身被第 4 節的內聯問題放大),remove 信號只剩 ~64%;`Bencher::iter` 還把閉包體複製了兩份(冷熱雙拷貝)。若要守護 remove 路徑,值得加一個以預建 map 陣列輪換的純 remove bench。

## 復現

```bash
BIN=build/aarch64-unknown-linux-gnu/stage1-std/aarch64-unknown-linux-gnu/release/build/alloctests/2cf0e8badf7482bf/out/allocbenches-2cf0e8badf7482bf
export LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib
$BIN --bench --exact 'btree::map::clone_slim_10k_and_remove_half'
perf record -e cycles:u -F 20000 $BIN --bench --exact '...'   # + branch-misses:u 各一輪
# 探針:/tmp/btree_bench/probe_split.rs(拆分)、probe_kernel.rs(核心對比,--emit asm / llc -mtriple=x86_64)
```

---

# btree 兩項原型的樹內驗證:remove_half −36%、clone 基線 −57%,find/insert 持平——以及三個失敗形態的教訓

- 日期:2026-09-07(前一章的後續;同機 stage1,`./x bench library/alloctests`)
- 修改文件:`btree/search.rs`(整數鍵搜索特化)、`btree/navigate.rs`(`deallocate_subtree`)、`btree/map.rs`(`Drop` 特化)
- 正確性:`./x test library/alloctests --test-args btree` 全部 278 項通過(每個變體都重跑)

## 最終形態

**#11(drop 節點級走查)**:`BTreeMap::drop` 對 `!needs_drop::<K>() && !needs_drop::<V>()` 直接取出 root 走新增的 `NodeRef<Dying,_,_,LeafOrInternal>::deallocate_subtree`——後序節點級釋放(`first_leaf_edge` 下潛 + `deallocate_and_ascend` 上升,父邊有右兄弟則潛入其最左葉),完全不逐元素;`ManuallyDrop::drop` 收尾分配器。

**#10(整數鍵搜索特化)**:`find_key_index` 經內部 `SpecSearchLinear<Q>` trait(`min_specialization`,alloc 已有先例)分派;12 個原生整數類型的特化版:

```rust
if sub.len() == CAPACITY {
    // 滿節點:外聯(#[inline(never)])的無分支定長掃描
    return spec_full_scan(full, key) ...;
}
// 非滿節點:與通用路徑逐字相同的 early-exit 掃描

#[inline(never)]
fn spec_full_scan<T: Copy + Ord>(full: &[T; CAPACITY], key: T) -> (usize, bool) {
    match key.cmp(&full[0]) {          // 首鍵守衛:保住最左訪問的 O(1) 退出
        Less => return (0, false),
        Equal => return (0, true),
        Greater => {}
    }
    let mut count = 0;
    for &k in full { count += (k < key) as usize; }   // NEON 5×cmhi+addp
    (count, count < CAPACITY && full[count] == key)
}
```

三個組成缺一不可,見下面的失敗形態。

## 逐項 benchmark(baseline → 原型,同機同配置)

| benchmark | baseline | 原型 | Δ |
|---|---:|---:|---:|
| `clone_slim_10k` | 125,032 | 53,945 | **−57%** |
| `clone_slim_10k_and_clear` | 124,306 | 54,165 | **−56%** |
| `clone_slim_10k_and_remove_half` | 349,061 | 222,307 | **−36%** |
| `clone_slim_10k_and_drain_half` | 141,687 | 125,336 | **−12%** |
| `clone_slim_10k_and_remove_all` | 379,296 | 377,041 | −0.6% |
| `clone_slim_10k_and_pop_all` | 334,332 | 344,903 | +3.2% |
| `clone_slim_10k_and_drain_all` | 331,873 | 338,996 | +2.1% |
| `clone_slim_10k_and_into_iter` | 123,464 | 129,001 | +4.5% |
| `find_rand_100` | 8.59 | 8.77 | +2% |
| `find_rand_10_000` | 59.82 | 58.22 | −2.7% |
| `find_seq_100` | 9.38 | 9.22 | −1.7% |
| `find_seq_10_000` | 41.76 | 41.26 | −1.2% |
| `insert_rand_100/10k` | 16.86/16.70 | 17.05/16.97 | +1% |
| `insert_seq_100/10k` | 37.55/103.28 | 38.06/104.17 | +1% |

remove_half 的 perf stat:branch-miss 率 **3.50% → 1.02%**,IPC **2.45 → 3.29**——上一章定位的「每層一次退出失誤」被搜索特化消除,機理閉環。into_iter/pop_all/drain_all 的 +2–4.5% 不經過兩條被改路徑的熱迴圈,在各變體間穩定存在,歸因為代碼佈局漂移,是本驗證的最大殘餘回退。

## 三個失敗形態(為什麼最終形態長這樣)

1. **無條件無分支全掃描(kernel 直譯)**:`remove_all` +96%(742µs)、`find_rand_100` +144%。兩個病理:(a) 最左偏置訪問(升序逐個 remove)原本每節點 1 次比較即退出,全掃描變 11 次;(b) 隨機插入建的樹節點平均 ~70% 滿,動態長度的計數迴圈向量化差(kernel 實測動態長度只剩 15% 優勢,樹內為負)。
2. **守衛+滿/非滿分流,內聯體**:remove_half 一度到 215.8µs(−38%),但 `insert_rand` +43%——perf 證實 `search_tree<u32>` 因函數體膨脹**失去內聯**成為獨立符號(基線中它完全內聯進 insert/remove 路徑);對 `search_tree`/`search_node` 強加 `#[inline]` 反而更糟(+87%,寄存器壓力)。
3. **修復是把滿節點掃描外聯**(`#[inline(never)]`):調用點只比基線多一個 `len==CAPACITY` 分支,非滿路徑與基線同形,inliner 行為復原;滿節點付 ~5 cycles 調用開銷換 ~15 cycles 失誤消除,remove_half 略回吐(215.8→222.3µs)但 insert 全線歸位。

教訓:**微內核的收益要在「調用點內聯預算」與「訪問模式分佈」兩個約束下重新驗證**;B-tree 搜索的 early-exit 不是誤設計,它同時是最左模式的自適應快路徑與小代碼體——特化只應接管它確定輸的子空間(滿節點+高熵退出位置)。

## 落地前的待辦(原型止步於此)

- miri/careful 全量過(`deallocate_subtree` 的 Dying 走查、`as_ptr() as *const [T; CAPACITY]` 轉換);
- x86 實測(llc 形狀已對稱:SSE2 `pcmpgtd`,但閾值行為需實機);
- `u128/i128` 的計數迴圈不向量化,考慮從宏中剔除;
- set(`SetValZST`)與 `fat_val` 系列補基線對比;`IntoIter::drop` 部分消費情形仍走逐元素路徑,可另行特化;
- into_iter/pop_all 的 +3–4.5% 佈局噪聲需在多 codegen seed 下複測。

## 復現

```bash
# 修改在工作樹(未提交):btree/{search,navigate,map}.rs
./x test library/alloctests --stage 1 --test-args btree
./x bench library/alloctests --stage 1 --test-args 'btree::map::clone_slim_10k'
./x bench library/alloctests --stage 1 --test-args 'btree::map::find_'      # + insert_
```

---

# `ascii::long::is_ascii`:三層失效的 benchmark——to_vec 佔六成、掃描被常量摺疊 94%、「乾淨」對照組整個計時迴圈被刪

- 日期:2026-09-08
- 分析對象:`library/coretests/benches/ascii.rs` 的 `ascii::long::is_ascii`(`bytes.iter().all(u8::is_ascii)`,LONG = 6990B 全 ASCII 常量)及其姊妹家族 `ascii::is_ascii::*`(`is_ascii.rs`)
- 接口:`u8::is_ascii`(逐字節)與 `<[u8]>::is_ascii`(本樹已有 NEON 特化,`slice/ascii.rs::is_ascii_neon`,64B/迭代 `vmaxvq_u8`)
- 結論先行:**這一家族的官方數字全部不可信**;真值須用探針測(見下)

## 官方數字 vs 真值

| 測量 | 官方報告 | 真值(探針) | 偏差 |
|---|---:|---:|---:|
| `ascii::long::is_ascii` | 314.7 ns(22.3 GB/s) | to_vec 190ns + 標量全掃 ~1530ns | 掃描少算 **~12×** |
| `ascii::is_ascii::long::case00_libcore` | 6.38 ns(1165 GB/s!) | **114.5 ns**(61.1 GB/s) | **18×** |
| `ascii::is_ascii::long::case01_iter_all` | 81.9 ns(86 GB/s) | ~1530 ns(4.6 GB/s,標量) | **19×** |

真值探針:`black_box(&v[..])` 每迭代把**切片值**(ptr+len)過一次 asm(來源數據運行時生成),`len=6990/69900` 線性縮放、61 GB/s 貼合 LSU 上限模型(~11 µops/64B),可信。

## 三層失效的機理(全部彙編/計數證實)

**第一層:harness 稀釋。**外層宏把 `$input.as_bytes().to_vec()`(malloc+6990B memcpy+free)放進計時迴圈:`case00_alloc_only` 對照 = 190.0 ns,佔 `long::is_ascii` 總時間 60%。short/medium(7B/32B)更是 12.4 ns 全部為 to_vec。

**第二層:常量摺疊。**LONG 是 `const &str`;to_vec 從鏈接期常量 memcpy,LLVM 把 `iter().all(is_ascii)` 對常量源的掃描**部分編譯期求值**。證據鏈:(1) 閉包熱迴圈是 3 指令標量 `ldrsb/tbnz/cmp+b.ne`,但迴圈邊界比對 `#0x190`(400);(2) perf stat:每迭代僅 ~3540 條指令(4.93s ÷ 309.6ns/iter ≈ 15.9M 迭代,56.3G 指令),而 6990B 標量全掃至少 21k 條——**運行時只掃了 ~400B 殘段,94% 的「被測工作」不存在**;(3) 把源數據改成運行時生成(探針),同構代碼立即回到 1530 ns 全掃。

**第三層:計時迴圈被整個刪除。**`is_ascii.rs` 家族的 harness 看似乾淨(`&black_box(&mut vec)[$range]`,to_vec 在迴圈外),但 `black_box(&mut Vec)` 只把 **Vec 指針**變opaque,堆內容在迴圈內從未被寫——`ns_iter_inner::<case00_libcore>` 的反彙編是直線代碼:`Instant::now → 一次 NEON 掃描 → elapsed → ret`,**k 迭代參數完全未被使用,n 次迭代被 LLVM 摺疊成 1 次**。報出的 6.38 ns = 單次掃描 ÷ 校準膨脹出的 n,純虛構。case01–04 同病(數字全在物理帶寬之上)。

## `<[u8]>::is_ascii` 本體的真實狀態(無病灶,小幅頭寸)

本樹的 NEON 實現(64B/迭代:4×`ld1q` + 3×`orr` + 每 64B 一次 `vmaxvq_u8` 歸約)實測 61 GB/s(L1 駐留),對比:每迭代 ~11 µops @ 4-wide ≈ 2.75 cycles/64B ≈ 23 B/cycle——**已貼近該形態的發射上限**,非訪存瓶頸(純載入上限 ~32B/cycle ≈ 93 GB/s)。殘餘頭寸:把 `umaxv` 歸約攤到每 256B 一次(4 塊 OR 累加後單次檢查)理論 +30–40%,代價是非 ASCII 輸入的退出粒度變粗;`iter().all(u8::is_ascii)` 形態(case01)不向量化(early-exit 標量,0.219 ns/B),用戶側應改用 `slice::is_ascii`,13× 差距。

## 修法建議(bench 側,std 無需動)

1. 計時迴圈內以**切片值**過 black_box(`let bytes: &[u8] = black_box(&vec[..]);`),不要 black_box 容器指針——後者攔不住「堆內容未變 → 掃描結果 CSE/迴圈摺疊」;
2. 輸入數據運行時生成(或對 const 先過一次 `black_box`),殺死常量摺疊;
3. 只讀 benchmark 不需要 to_vec 製造 `&mut`,外層宏的 `@iter` 系列應改走 `is_ascii.rs` 式(修好後的)harness;
4. 修好之前,這 33+50 個 ascii benchmark 不應作為任何優化決策的依據——包括先前第 9 條目引用的 `0.018 ns/B` 也是本節拆穿的虛構值,真值為 0.0164 ns/B(61 GB/s,NEON)且來自探針而非官方 bench。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench --exact 'ascii::long::is_ascii' 'ascii::long::case00_alloc_only'
$BIN --bench 'ascii::is_ascii::long'
objdump -d $BIN | less   # ns_iter_inner::<...case00_libcore>:now→單次掃描→elapsed,無迴圈
# 真值:/tmp/btree_bench/probe_isascii.rs(NEON 61GB/s)、probe_iterall.rs(標量 4.6GB/s、to_vec 90ns/4640B)
# 指令數:perf stat -e cycles,instructions $BIN --bench --exact 'ascii::long::is_ascii'
```

---

# `slice::binary_search_l3_with_dups`:跨查詢 MLP 的吞吐基準——prefetch 只救延遲體制,官方形態下現實現已是最優

- 日期:2026-09-08
- 分析對象:`library/coretests/benches/slice.rs` 的 `binary_search_l3_with_dups`(1M `usize`,`v[i] = i/16*16`,LCG 全域隨機鍵)
- 接口:`[T]::binary_search` → `binary_search_by`(csel 無分支迴圈,無 early exit)
- 前置:branch-vs-csel 軸已在 `binary_search_l1_worst_case` 章(2026-08-18)結案;本章只處理記憶體層級軸
- 基線:**91.5 ns/iter**(±1–3,多輪);`l3`(x2 mapper)90–91 ns,兩者等值

## 這個 benchmark 實際在測什麼

8MB 陣列,20 層 probe,鍵均勻隨機。三個容易誤讀的點:

1. **dups 變體無資訊增量**:16 個重複值 = 128B = 同/相鄰 cache line,只影響最後 4 層的地址選擇,路徑長度與訪存層級不變(92.2 vs 91.0 ns)。這個變體是 early-exit 時代的遺產——當年重複值能讓 `Equal` 提前在 ~16 層返回;`bb584882070` 移除 early exit 後它與 `l3` 測同一件事。
2. harness 註釋「50% hits and misses」對 dups mapper 不成立:鍵 `(r%size)/16*16` 恆為在場值,**100% 命中**(對結果無影響,無 early exit)。
3. `l1`(20.39)vs `l1_with_dups`(12.28)的 66% 差距是**本二進制的佈局噪聲**:同算法同 LCG 的探針中兩種 mapper 等速(16.4 vs 16.3 ns),且前章另一個二進制中 `l1` 為 12.85。這組微基準對代碼佈局極敏感,跨二進制比較無效。

## perf 畫像:純記憶體延遲受限,且已被跨查詢 MLP 攤薄 2×

| 指標 | 數值 | 解讀 |
|---|---:|---|
| IPC | **0.65** | backend stall 89% |
| branch miss | **0.01%** | csel 形態下分支完美(前章機理) |
| L1d miss | **40.3%**(~9 次/查詢,22 loads/查詢) | 層工作集:0–9 層駐 L1、10–12 層 L2、13–19 層 L3 |

關鍵對照:官方 bench 的相鄰迭代**互相獨立**(LCG 只串行化鍵生成),OoO 視窗跨查詢重疊訪存——探針把下一個鍵改為依賴上一個結果(真延遲體制)後,同一算法同一資料 **182.4 ns**,即官方形態已經拿到 ~2× 的跨查詢 MLP。**這個 benchmark 測的是吞吐體制,不是單查詢延遲。**

## prefetch 原型:雙體制結果相反(決定性實驗)

兩個下層候選 mid 的地址不依賴當前載入,可提前 `prfm`(prefetch1 = 下層 2 個;prefetch2 = 下層 2 + 下下層 4 個)。與 std 全量對拍通過(含 dup 組內索引)。

| 體制 / 尺寸 | current | prefetch1 | prefetch2 |
|---|---:|---:|---:|
| **吞吐**(官方形態)L1 1k | **16.3** | +18% | +44% |
| 吞吐 L2 10k | **22.5** | +36% | +45% |
| 吞吐 L3 1M | **98.0** | +13% | +13% |
| 吞吐 16M | 228.7 | +7% | **216.1(−5.5%)** |
| **串行依賴**(延遲)L3 1M | 182.4 | 143.0(−22%) | **130.1(−29%)** |
| 串行依賴 16M | 379.9 | 245.4(−35%) | **211.8(−44%)** |

機理:吞吐體制下 load 端口/MSHR 已被跨查詢重疊佔滿,prefetch 是純搶佔(L2 尺寸最慘 +45%);延遲體制下鏈上只有一個查詢,prefetch 把 7 次串行 L3 訪問部分並行化,越大越賺。**兩個體制在相同尺寸上結論相反,std 無法從調用點分辨體制**——與前章 branch-vs-csel 的結局同構:現實現是「未知調用分佈下的正確通用選擇」,`binary_search` 無優化空間的判定維持不變。

## 可帶走的結論

1. 延遲敏感且陣列超出 L2 的調用者,自帶 prefetch 版二分(本章原型 30 行)可拿 **−29~44%**;吞吐型調用者(批量獨立查詢)什麼都不要做,或改排序批查(sort+merge 消滅隨機 probe)。
2. bench 設計:`with_dups` 三個變體可刪或改造(如「dup 組大小 = 4KB」才能重新產生層級差異);`l1` 系列的佈局敏感性提示對比須同二進制。
3. x86 無需另測:訪存層級故事平臺無關,csel/cmov 形狀等價已由前章 llc 對照確立。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench 'slice::binary_search'
perf stat -e cycles,instructions,branch-misses,L1-dcache-load-misses,L1-dcache-loads \
  $BIN --bench --exact 'slice::binary_search_l3_with_dups'
# 原型:/tmp/btree_bench/probe_bsearch_prefetch.rs(吞吐)、probe_bsp_serial.rs(串行依賴)
```

---

# `iter::bench_skip_while_ref_sum`:與 value 版逐條同碼;Range 內層下謂詞被 SCEV 閉式求解,任何輸入都測不到 skip_while

- 日期:2026-09-08
- 分析對象:`library/coretests/benches/iter.rs` 的 `bench_skip_while_ref_sum`(`(0i64..1M).skip_while(|&x| x < 1000).map(black_box).by_ref().sum()`)
- 前置:`bench_skip_while_sum` 章(適配器零開銷、black_box 屏障主導)與 `bench_enumerate_chain_ref_sum` 章(bench_sums! 的 value/ref 對照全系失效)已覆蓋大局;本章補 ref 專屬證據並關閉前章遺留問題
- 基線:**641,173 ns**(value 版 641,428;`skip_sum`/`skip_ref_sum` 641,349/641,403——skip 家族四項全等,0.64 ns/元素全是屏障)

## 證據一:官方二進制中 ref 與 value 是同一份機器碼

兩個 `Bencher::iter` 閉包符號(`bench_skip_while_sum` @0x794d0 與 `bench_skip_while_ref_sum` @0x7ba5c)大小同為 0x458,地址歸一化後 diff **逐條指令相同**。`by_ref()` 經 `&mut I` 的 `try_fold` 轉發(`sum → fold → try_fold(NeverShortCircuit)` 默認鏈,機理同 enumerate_chain 章)與 value 版收斂到同一 LLVM IR。宏註釋「by reference which cannot optimize」描述的世界已不存在——這是該結論在 asm 層的第一次直接驗證(此前僅由時間相等推斷)。

## 證據二(關閉前章遺留):Range 內層下謂詞永遠零指令,與邊界是否運行時值無關

前章猜想「要測到謂詞需要 ref 形狀 + 不可預測邊界」。探針(2000 元素縮小版,邊界三體制:編譯期常量 / `black_box` 運行時值 / LCG 每調用隨機)證明猜想**不成立**——謂詞掃描在所有體制下都被摺疊,閉包彙編開頭:

```asm
cmp  x1, #1999              ; bound 出界 → 空和直接返回
b.le .LBB3_2
mov  x0, xzr; ret
.LBB3_2:
bic  x8, x1, x1, asr #63    ; ← 整個「謂詞掃描」= max(bound,0),一條指令
...                          ; 之後只剩 black_box 屏障迴圈(str/ldr 每元素)
```

機理:`skip_while(|&x| x < b)` 的內層是 Range,謂詞作用於歸納變量本身,SCEV 把「首個不滿足位置」閉式求解為 `clamp(b)`。**這一 bench 家族對 Range 內層結構性測不到 skip_while,換什麼輸入都一樣。**

## 證據三:謂詞真實成本需要不可分析的內層才現形

把內層換成切片(謂詞讀記憶體資料,SCEV 不可解),LCG 隨機邊界:

| 形態 | ns/call |
|---|---:|
| `slice.iter().skip_while(...).map(bb).sum()` value | 767.2 |
| 同上 `by_ref()` | 786.6(+2.5%,噪聲級) |
| `slice[b..]` 直接尾段求和(無掃描基線) | **528.0** |

謂詞掃描 ≈ **0.24 ns/元素**(~0.7 cycles,緊湊標量迴圈)——這才是 skip_while 在不可摺疊情形下的真實開銷;ref ≈ value 在此體制同樣成立。

## 附帶觀察:微迴圈的佈局噪聲再次出現

探針中等價的閉包實例(value/ref 對同一形狀)codegen 有細微差異(`bic` 鉗位 vs 分支形),小迴圈體上造成 10–23% 的擺動(479 vs 590 ns);官方二進制裡兩者恰好收斂為同碼故無此噪聲。與 `binary_search_l1` 章的 66% 佈局擺動同類——**這組 ns 級微基準的跨實例小差異不應過度解讀**。

## 判斷

1. `bench_skip_while_ref_sum` 與 `bench_skip_while_sum`、`bench_skip_sum`、`bench_skip_ref_sum` 四項測同一個 black_box 屏障迴圈,互為冗餘;適配器零開銷的守護目標成立(asm 級確認)。
2. 前章遺留問題以更強形式關閉:不是「輸入不夠刁鑽」,而是 Range 內層在數學上不可能暴露謂詞。若要守護 skip_while 的謂詞路徑,需要**切片內層 + 運行時邊界**的新 bench 形狀(本章探針即模板,真實成本 0.24 ns/元素)。
3. x86 無需另測:摺疊發生在 target 無關的 SCEV/IR 層(enumerate_chain 章已對同機理做過 llc 對照)。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench 'skip'
# 同碼驗證:objdump -d $BIN 取兩符號,地址歸一化後 diff(本章 sed/awk 流程)
# 探針:/tmp/btree_bench/probe_skipwhile.rs(Range 三體制+asm)、probe_sw_slice.rs(切片內層)
```

# `io::bench_write_slice`:`min(data.len(), self.len())` 令 128B 拷貝退化為 `memcpy@plt` 調用——但只在 harness 的 `black_box(&wr)` 形態下發生,真實形態零收益

- 日期:2026-09-15
- 分析對象:`library/alloctests/benches/io.rs` 的 `bench_write_slice`(`&mut [u8; 1024]` 切片上 8 次 `write_all(&[u8; 128])`,每次之間 `black_box(&wr)`)
- 基線:**33.8–34.0 ns/iter**(6 次交錯複測;偶發 38.7 為佈局噪聲)。對照 `bench_read_slice` 16.0 ns——同樣 8×128 B,讀比寫快 2.1×
- 實現:`library/core/src/io/impls.rs` 的 `impl Write for &mut [u8]`

## perf 畫像:74.7% 在 libc `__memcpy_generic`

| 符號 | 佔比 |
|---|---:|
| `libc.so.6 __memcpy_generic` | 74.7% |
| bench 閉包本體(`ns_iter_inner::<bench_write_slice>`) | 23.1% |
| `memcpy@plt` | 1.9% |

閉包彙編:第 1 次 `write_all` 被完全內聯成 `ldp/stp q` 直線拷貝(`wr` 初始長度 1024 為編譯期已知);之後 **7 次全是 `bl memcpy@plt`**,每次前面一段 `ldp x0,x8,[sp,#24]; cmp x8,#0x80; csel x2,x8,x26,cc`——即 `min(128, wr.len())` 用 `csel` 算出動態長度後交給 libc。指令 2.07G/run,IPC 3.05,分支失誤 0.01%:完全是 call 開銷 + libc memcpy 的通用入口分派,不是微架構事件。

**根因**:`black_box(&wr)` 迫使 `wr` 每輪落棧重載,LLVM 失去 `wr.len()` 的常量;`write` 用 `cmp::min(data.len(), self.len())` 算拷貝長度,結果 `data.len() = 128` 這個常量被 `min` 混成動態值,`copy_from_slice` 無法內聯成定長拷貝,只能發 `memcpy` 調用。`read` 側沒這個問題純屬巧合:`bench_read_slice` 的 `black_box(&dst)` 攔的是目標緩衝而不是 `rd`,`rd` 的長度鏈 1024→896→… 仍可推導,8 次全內聯(見本文件首章)。把 read bench 改成 `black_box(&rd)` 立刻變 36 ns——**兩個 bench 的差距是 black_box 放的位置,不是 read/write 實現的差距**。

## 原型:分支形 write/write_all,fits 路徑用 `data.len()` 拷貝

```rust
fn write(&mut self, data: &[u8]) -> io::Result<usize> {
    if data.len() <= self.len() {             // 常見路徑:長度用 data.len(),調用點常量可內聯
        let (a, b) = mem::take(self).split_at_mut(data.len());
        a.copy_from_slice(data); *self = b; Ok(data.len())
    } else {                                   // 短寫:拷滿剩餘
        let amt = self.len();
        mem::take(self).copy_from_slice(&data[..amt]); Ok(amt)
    }
}
// write_all 同構,else 分支直接 Err(WRITE_ALL_EOF),省掉中間 usize
```

官方 harness:**34.0 → 25.4–26.2 ns(−25%)**,perf 中 7 個 `memcpy@plt` 調用點採樣全為 0(冷的 else 分支),8 次拷貝全部內聯成 `stp q2,q3` 鏈;IPC 3.05→1.64(內聯後變成 store-bound,這是正常的)。alloctests io 132 項 + coretests io 167 項全過。

## 但真實形態下零收益甚至微退(決定性實驗)

同一段實現放進 `#[inline(never)]` 函數,換掉 harness 的兩個人工條件(`src` 長度常量 128、`black_box(&wr)` 抹掉 `wr` 長度):

| 形態 | 現狀 | 分支形 | 變化 |
|---|---:|---:|---:|
| 官方形態(const 128 + `black_box(&wr)`) | 30.8 ns | 27.4 ns | −11% |
| const 128 ×8,無 black_box | 24.5 | 26.3 | **+7%** |
| 運行時長度 128 ×8 | 24.5 | 26.2 | **+7%** |
| 運行時長度 16 ×8 | 15.2 | 15.5 | +2% |
| 運行時長度 4096 ×8(短寫路徑) | 37.4 | 37.7 | 持平 |
| 單次 write,運行時長度 128 | 4.6 | 4.6 | 持平 |
| 序列化:1000× `write_all(&u64.to_le_bytes())` | 2436 ns | 2426 ns | 持平(兩者都已內聯 8B 拷貝) |
| 序列化:1000× 記錄(u32+u64+u16 三次 write) | 9700 ns | 10058 ns | **+4%** |

- 沒有 `black_box(&wr)` 時,現狀實現本來就能推導 `wr` 長度而全內聯——分支形反而多一條 `cmp/b.ls`,+7%;
- 運行時長度的資料兩者都得走 `memcpy`,分支形多的比較純屬開銷;
- 小常量寫(序列化最常見)在現狀下 LLVM 已把 `min(8, len)` 的 memcpy 展開成內聯 8B 拷貝,分支形沒東西可省,記錄形態還因分支密度變高退 4%。

只有「**常量長度 ≥ 數十字節 + 目標切片長度對編譯器不可見**」這一窄形態受益,而這恰好是 harness 用 `black_box(&wr)` 人工製造的。混合形 D(`amt = min(...)`,`if amt == data.len() { copy(data) }`)也試過:官方 bench 上 32.8/34.1 ns 與現狀在噪聲內——LLVM 把兩個分支的 memcpy 合併回一個動態長度調用,等於白改。

## 附帶發現:`bench_write_vec` 測的是錯誤路徑

`let mut buf = Vec::with_capacity(1024); let mut wr = &mut buf[..];`——`with_capacity` 的 `len` 是 0,`wr` 是**空切片**,8 次 `write_all` 全部立即返回 `WriteZero` 錯誤。25.5 ns 測的是 8 次錯誤構造 + 丟棄,與拷貝無關(原型前後 25.54/25.55 ns 分毫不動即為證據)。要測 `Vec` 就該直接 `buf.write_all(&src)` 走 `impl Write for Vec<u8>`,或 `vec![0; 1024]`。

## 判斷

1. `<&mut [u8] as Write>::write` 現實現已是最優:在編譯器能看到長度的地方全內聯,看不到的地方 `memcpy` 是正確選擇。**不建議落地分支形**——官方 bench 的 −25% 換來真實序列化形態的 +4–7%。
2. `bench_write_slice` 相對 `bench_read_slice` 慢 2.1× 不是 write 慢,是 `black_box` 擋在不同位置。若要兩者可比,read 側應同樣 `black_box(&rd)`(實測 36 ns,與 write 同級),或 write 側改 `black_box(&buf)`。
3. `bench_write_vec` 是失效 bench,應修。
4. x86:同機理(`min` → 動態長度 → `call memcpy`),分支形在 x86 也會有同樣的「bench 贏、真實輸」,無需另測。

## 復現

```bash
BIN=build/.../allocbenches-2cf0e8badf7482bf
$BIN --bench 'io::'
perf record $BIN --bench io::bench_write_slice   # 74.7% __memcpy_generic;閉包內 7× bl memcpy@plt
# 原型:core/src/io/impls.rs 的 write/write_all 改分支形(未提交,已回退);原型二進位 /tmp/btree_bench/io_pat/
# 探針:/tmp/btree_bench/probe_io/probe{,2,3,4,5}.rs(官方形態/無 black_box/運行時長度/混合形 D/序列化)
```

# `vec_deque::bench_iter_1000` / `bench_mut_iter_1000`:`Iter::next` 內聯的 `mem::swap(i1, i2)` 把 `for` 迴圈變成雙狀態機,每元素 6 條 `mov` 暫存器輪轉——外聯 swap 即 −31%

- 日期:2026-09-15
- 分析對象:`library/alloctests/benches/vec_deque.rs` 的 `bench_iter_1000`(`for &i in &ring { sum += i }`,1000 個 i32,連續佈局)與 `bench_mut_iter_1000`(同形 `iter_mut`);順帶 `bench_try_fold`、`bench_into_iter*`
- 基線:**695.9 ns**(iter)/ **696.0 ns**(mut),3 次交錯複測 ±0.3;`bench_try_fold` 64–77 ns(噪聲大);對照 `ring.iter().sum()` 48 ns、裸切片 `for` 44 ns
- 實現:`library/alloc/src/collections/vec_deque/{iter,iter_mut}.rs`

## 現象:同一個 deque,`for` 迴圈比 `sum()` 慢 14×

| 消費形態(1000 元素,連續) | ns | 每元素 |
|---|---:|---:|
| `for &i in &ring`(bench 原文) | 702.6 | 0.70 ns ≈ 2.0 cycles |
| `while let Some(&i) = it.next()` | 574.7 | 0.57 |
| `ring.iter().sum()` / `.fold()` / `.try_fold()` | 48.4 | 0.048(向量化) |
| `as_slices()` 兩個 `for` | 48.8 | 0.049 |
| 裸切片 `for`(上限) | 44.3 | 0.044 |
| `a.iter().chain(b)` 的 `for` | 682.9 | 0.68(同病) |

`fold`/`try_fold` 有覆寫(`i1.fold` 再 `i2.fold`,兩段各自向量化),`for` 走 `next()`。無微架構事件:IPC 4.96,branch-miss 0.10%,4.62G 指令——純指令數。

## 根因:內聯後的 swap 讓迴圈攜帶兩個活躍迭代器

`next()` 現狀:

```rust
match self.i1.next() { Some(v) => Some(v), None => { mem::swap(&mut self.i1, &mut self.i2); self.i1.next() } }
```

註釋說 swap 是為了「讓第一個分支儘量常被命中」。但內聯進 `for` 之後,LLVM 把 `(i1.ptr, i1.end, i2.ptr, i2.end)` 全 SROA 成 4 個暫存器,迴圈頭的 phi 要同時合併「未 swap」和「已 swap」兩條入邊——這是一個暫存器**置換**,寄存器分配器只能在回邊上插拷貝。官方二進位的熱迴圈(82.8% 樣本落在 `62d54`):

```asm
62d38: mov  x0, x13        ; ┐
       mov  x1, x10        ; │ 6 條 mov:輪轉 i1/i2 的 4 個暫存器
       mov  x10, x12       ; │
       ldr  w12, [x11], #4 ; ← 真正的工作:載入 + 步進
       mov  x13, x0        ; │
       add  w9, w12, w9    ; ← 累加
       mov  x12, x10       ; │
       mov  x10, x1        ; ┘
       cmp  x11, x12
       b.ne 62d38
```

10 條指令做 1 個元素,其中 6 條是搬運。`Chain<slice::Iter, slice::Iter>` 的 `for` 是 682 ns 同病,說明這不是 VecDeque 特有,而是「兩段迭代器在 `next()` 內切換」這一寫法在 `for` 迴圈裡的通病;`fold` 覆寫繞開了它。

## 探針:五種 `next()` 形態(`#[inline(never)] fn run(it) { for &i in it {..} }`,中位數/7,ns)

| 形態 | 連續 (i2 空) | 繞回 524+476 | `.rev()` 連續 / 繞回 |
|---|---:|---:|---:|
| S0 現狀(swap 內聯) | 827 | 839 | 894 / 907 |
| **S1 swap 外聯 `#[cold] #[inline(never)]`** | **545** | **559** | — |
| S5 第二段改 `Option<&[T]>`,迴圈形 `loop { if let Some = i1.next() {..} i1 = rest.take()?.iter() }` | 357–478* | 388–523* | 705 / 577 |
| S5c S5 + 切換外聯 | 551 | 547 | — |
| S6 保留兩個 Iter,迴圈形 + swap/take | 796–822 | 776–816 | 897 / 913 |
| 裸切片(上限) | 46 | — | — |

\* S5 跨編譯擺動大(357/478/415 三次構建),同一二進位內穩定——微迴圈佈局噪聲,與本文件多章一致。

S1 的機理:None 臂變成一個不內聯的 call,迴圈體內只剩 i1 的 `ptr/end` 兩個活躍值,回邊無拷貝。S6 證明「迴圈形」本身沒用,關鍵是把置換移出迴圈體。S5 更快是因為第二段只剩一個 `Option<&[T]>`(2 字 + 判空),迴圈只需保活 3 個暫存器;但它改變 `Iter` 佈局,`as_slices`/`advance_by`/`rfold`/`__iterator_get_unchecked`/`len` 全要重寫,`next_back` 在 rest 側要用 `split_last` 收縮——工程量與風險都是另一量級。

## 樹內原型(S1,`iter.rs` + `iter_mut.rs`,各 +25/−18 行)

```rust
fn next(&mut self) -> Option<&'a T> {
    match self.i1.next() { Some(val) => Some(val), None => self.next_slow() }
}
#[cold] #[inline(never)]
fn next_slow(&mut self) -> Option<&'a T> { mem::swap(&mut self.i1, &mut self.i2); self.i1.next() }
// next_back / next_back_slow 對稱
```

官方 harness(`./x bench library/alloctests --stage 1`,3 次交錯):

| benchmark | 現狀 | S1 | 變化 |
|---|---:|---:|---:|
| `vec_deque::bench_iter_1000` | 695.9 ns | **479–484 ns** | **−31%**(指令 4.62G→3.29G) |
| `vec_deque::bench_mut_iter_1000` | 696.0 ns | **481 ns** | **−31%** |
| `vec_deque::bench_try_fold` | 64–77 ns | 45–52 ns | 噪聲大;`try_fold` 有覆寫不經 `next`,差異為佈局 |
| `vec_deque::bench_into_iter{,_fold,_try_fold,_next_chunk}` | 2.89 µs / 687 / 713 / 975 ns | 同構建 A:2.88/718/**429**/**702**;構建 B:2.93/687/708/977 | **純佈局噪聲**——`IntoIter` 不經 `Iter`,兩次構建同一補丁擺動 −40%…+4% |
| 其餘 `vec_deque::*`(extend/grow/from_array,11 項) | — | ±1% | 持平 |

vec_deque 測試 56+116+15 全過。熱迴圈變成 `ldr; add; add; cmp; b.ne`(5 條),82% 樣本在 `b.ne`。

## 判斷

1. 落地建議:**S1 直接可落地**——語義零改動、佈局零改動、兩個文件各改十幾行,`for`/`while let` 形態 −31%,`.rev()` 同理受益(探針 894→~560 級)。
2. S5 是後續候選(再 −25…−35%),需要重寫 `Iter`/`IterMut` 全部方法,且 `as_slices()`(unstable API)語義要重新定義 rest 側。
3. `bench_into_iter*` 四項對佈局極敏感(同補丁兩次構建 −40%…+4%),不能作為 `IntoIter` 的回歸守衛;`bench_try_fold` 同樣噪聲 ±20%。
4. x86:置換拷貝發生在 LLVM IR phi/regalloc 層,與目標無關,預期同樣受益(本機無 x86 sysroot,未實測)。
5. `for` 迴圈永遠到不了 `sum()` 的 48 ns——那需要 LLVM 把雙段狀態機拆成兩個連續迴圈(loop unswitching on iterator state),不現實;想要向量化就用 `fold`/`sum`/`as_slices`。

## 復現

```bash
BIN=build/.../allocbenches-2cf0e8badf7482bf
$BIN --bench 'vec_deque::bench_iter_1000'
perf record $BIN --bench vec_deque::bench_iter_1000   # 82.8% 在迴圈末尾 mov,6 mov/元素
# 原型:vec_deque/{iter,iter_mut}.rs 的 next/next_back 外聯 None 臂(工作樹,未提交);二進位 /tmp/btree_bench/vd_s1/
# 探針:/tmp/btree_bench/probe_vd/{probe,shapes,shapes2,shapes3,shapes4,noise,intoiter}.rs
```

# `vec::bench_in_place_xxu8_1000_i1`:一半是 malloc/memset/free,另一半是已達 NEON 吞吐的 in-place 迴圈;`_i0` 慢 83% 是 glibc `calloc` 繞過 tcache,與 in-place collect 無關

- 日期:2026-09-16
- 分析對象:`library/alloctests/benches/vec.rs` 的 `bench_in_place![...]` 家族,重點 `bench_in_place_xxu8_1000_i1`(`black_box(vec![1u8; 1000]).into_iter().enumerate().map(|(i, e)| i as u8 ^ e).collect::<Vec<u8>>()`)
- 基線(18 項中 u8 六項):`0010_i0/i1` 21.5 / 15.1 ns、`0100_i0/i1` 25.6 / 17.4、`1000_i0/i1` **92.0 / 50.3**;u32 `1000_i0/i1` 178.6 / 209.9;u128 `1000_i0/i1` 533 / 715
- 實現:`library/alloc/src/vec/in_place_collect.rs`(`from_iter_in_place` → `SpecInPlaceCollect::collect_in_place`,`Enumerate<Map<IntoIter>>` 是 `TrustedRandomAccessNoCoerce`,走索引迴圈特化)

## 這個 bench 測的是什麼:每輪一次 1000 B 分配 + 一次釋放 + 一個 1000 B 迴圈

計數分配器確認每輪恰好 **1 次 `alloc`(i1)/ 1 次 `alloc_zeroed`(i0)、0 次 realloc**——in-place collect 生效,結果複用來源緩衝,無第二次分配。perf 按 DSO 切分:

| | i1(50.3 ns) | i0(92.0 ns) |
|---|---:|---:|
| `libc.so.6`(malloc/calloc/memset/free) | **52.8%** | **62.4%** |
| bench 本體(in-place 迴圈 + harness) | 45.5% | 34.7% |

探針拆分(`#[inline(never)]`,同形態):`vec![1u8;1000]` + drop 單獨 28.2 ns,官方 body 56.6 ns → **in-place 迴圈 ≈ 27–28 ns / 1000 B**;對照 `iter_mut().enumerate()` 原地 xor 26.9 ns、借用 `extend` 進復用 Vec 28.7 ns、`try_fold` 路徑(加 `filter(|_| true)` 逃出 TRA 特化)55.6 vs TRA 55.2——**三條路徑等價,in-place collect 本身零額外開銷**。

按尺寸看固定開銷:n=10 body 21.0 vs alloc 14.4(迴圈+簿記 6.6 ns);n=100 24.0 vs 14.5(9.5);n=1000 56.7 vs 28.3(28.4);n=10000 496 vs 180(315)。in-place 收尾(`forget_allocation_drop_remaining` + cap 比較 + `from_nonnull`)≈ 6 ns 常數,線性部分 0.028 ns/B。

## in-place 迴圈已在 NEON 吞吐上

熱迴圈(perf 67% 樣本落在兩條 `add v.16b`):

```asm
1ed18: add  v1.16b, v0.16b, v4.16b     ; idx+16
       ldp  q2, q3, [x13, #-16]        ; 32 B
       subs x14, x14, #0x20
       eor  v2.16b, v2.16b, v0.16b     ; e ^ idx
       eor  v1.16b, v3.16b, v1.16b
       add  v0.16b, v0.16b, v5.16b     ; idx += 32(loop-carried)
       stp  q2, q1, [x13, #-16]
       add  x13, x13, #0x20
       b.ne 1ed18
```

32 B/迭代、9 條指令、IPC 4.0、分支失誤 0.00%,約 2.3 cycles/迭代 → 37 GB/s。之後是 8 B 尾(`eor v.8b`)和逐字節尾。樣本集中在 `add v0` 是因為 `idx` 向量是唯一的 loop-carried 鏈(每輪 +32),不是瓶頸本身。

可壓的頭寸只在 LLVM 側:

| 迴圈單獨(1000 B,復用緩衝) | ns |
|---|---:|
| 現狀(interleave 2 → 32 B/迭代) | 26.9 |
| `-Cllvm-args=-force-vector-interleave=4`(64 B/迭代) | **21.3(−21%)** |
| `-Ctarget-cpu=native` | 22.2 |
| `-Ctarget-feature=+sve`(有 z 暫存器指令) | 22.6 |
| 手寫 64 B 塊 | 24.7 |
| `-force-vector-interleave=1` | 33.8 |

但放回官方 body,interleave=4 只從 59.0 → 57.6(−2%):迴圈只佔一半,而 TRA 索引迴圈形態下 LLVM 未同樣受益。這是 AArch64 cost model 對字節迴圈 interleave 偏保守(與 L5 章同族),std 源碼無從下手。

## `_i0` 比 `_i1` 慢 83%:glibc `calloc` 不走 tcache

`vec![0u8; n]` → `alloc_zeroed` → `libc::calloc`;`vec![1u8; n]` → `malloc` + `memset`。perf 對比:i1 的 libc 部分是 `malloc` 11.3%(tcache 快路徑)+ `__memset_sve_zva64` 27.6%;i0 的是 **`_int_malloc` 27.5% + `__libc_calloc` 8.6%**——glibc 2.38 的 `calloc` 不查 tcache,每次都進 `_int_malloc`/`_int_free` 慢路徑。單測 1000 B:`vec![0;n]` 33.5 ns vs `vec![1;n]` 27.0 vs `with_capacity + resize(n,0)` 20.8。**i0/i1 的 42 ns 差距全是分配器,與 in-place collect 無關**;u32(4 KB)與 u128(16 KB)上 calloc 反而快(memset 成本超過 tcache 收益,且大塊走 mmap 零頁),所以 `xu32_1000_i0 < _i1`、`u128_1000_i0 < _i1` 方向相反——三組 i0/i1 的符號翻轉本身就是「測的是分配器」的證據。

std 側可想的招是 `alloc_zeroed` 對小尺寸改 `malloc + write_bytes`(1000 B 上 −38%),但閾值是 glibc 版本/tcache 配置相關的平臺細節,且新版 glibc 若給 calloc 加 tcache 即失效——不建議。

## 判斷

1. `in_place_collect` 現實現沒有優化空間:零多餘分配、TRA 與 try_fold 路徑等價、迴圈已向量化到 NEON 吞吐、收尾 6 ns 常數。**排除**。
2. 這組 bench 一半以上在測 glibc:`_i0/_i1` 的差異和符號翻轉都是 calloc/tcache/memset 的交互,若要守護 in-place 路徑,應改成復用來源緩衝(像 `bench_in_place_recycle` 那樣)或至少把分配移出計時。
> **2026-10-09 修正**:`bench_in_place_recycle` 因鏈中的 `.fuse()` 並未走 in-place 路徑(每輪 1 次分配);可作典範的是 `bench_in_place_zip_recycle`。見 `vec::bench_in_place_*`(22 項全覽)章。
3. 迴圈本身 −21% 的頭寸在 LLVM AArch64 interleave 成本模型(字節寬 loop-carried 索引向量下偏保守),歸入 L 層,不另立條目。
4. x86:同機理——glibc 同一份,`calloc` 行為一致;迴圈 SSE2 16 B/迭代會比 NEON 慢一倍,AVX2 追平。

## 復現

```bash
BIN=build/.../allocbenches-2cf0e8badf7482bf
$BIN --bench 'vec::bench_in_place_xx'
perf record $BIN --bench vec::bench_in_place_xxu8_1000_i1   # 52.8% libc;熱迴圈 1ed18–1ed38
perf record $BIN --bench vec::bench_in_place_xxu8_1000_i0   # _int_malloc 27.5%:calloc 繞過 tcache
# 探針:/tmp/btree_bench/probe_ip/{probe,probe2,count,calloc,sve}.rs(拆分/路徑對照/分配計數/calloc 對照/interleave)
```

# `vec_deque::bench_extend_bytes`:一次 512 B `memcpy` 佔 77%,VecDeque 簿記 ≈ 2 ns,已貼 `Vec::extend_from_slice` 與裸 memcpy 底線

- 日期:2026-09-16
- 分析對象:`library/alloctests/benches/vec_deque.rs` 的 `bench_extend_bytes`(`ring.clear(); ring.extend(black_box(&[128u8; 512]))`,容量 1000,永不繞回)
- 基線:**16.4–16.5 ns/iter**;同組 `bench_extend_vec` 34.1、`_trustedlen` 24.2、`_chained_trustedlen` 34.3、`_chained_bytes` 27.0
- 實現:`library/alloc/src/collections/vec_deque/spec_extend.rs` 的 `SpecExtend<&T, slice::Iter<T>>`(`reserve` → `copy_slice` → `len +=`),`copy_slice` 是一或兩次 `ptr::copy_nonoverlapping`

## perf 畫像

| 符號 | 佔比 |
|---|---:|
| `libc.so.6 __memcpy_generic` | **77.0%** |
| bench 閉包(reserve/wrap 簿記 + harness) | 22.6% |
| `memcpy@plt` | 0.3% |

IPC 2.64,branch-miss 0.01%。熱點全在 memcpy 的 `stp x,x` 對(glibc ifunc 在本核選了 GPR 版 `__memcpy_generic`,64 B/迭代)。

## 拆分(探針,`-O`,同形態)

| 形態 | ns |
|---|---:|
| 官方:`clear` + `extend(&[u8;512])` | 16.9 |
| `clear` 單獨 | 0.4 |
| `extend` 不 clear(每輪繞回一次,走兩段 copy) | 17.5(+0.6) |
| `Vec::clear` + `extend_from_slice` 512 B | 13.9 |
| `[u8;1000][..512].copy_from_slice`(內聯 NEON `ldp/stp q`) | 14.9 |
| 裸 `ptr::copy_nonoverlapping` 512 B | 14.5 |

512 B 的複製底線 ≈ 14.5 ns(≈42 cycles,約 12 B/cycle 的 store 吞吐;內聯 NEON 與 libc GPR 版相同,說明卡在儲存端口不是指令選擇)。VecDeque 在其上多 **≈ 2 ns**:`reserve` 的 `checked_add` + 容量比較、`to_wrapped_index` 的加法 + 條件減、`copy_slice` 的 `head_room` 比較、`len +=`——十來條標量指令。繞回時多一次 split + 第二個 memcpy,+0.6 ns。

## 判斷

1. `VecDeque::extend(&[T])` 對 `T: Copy` 已是「reserve + memcpy」形態,離裸 memcpy 只差 2 ns 固定簿記,無可壓空間。**排除**。
2. 同組其他項:`bench_extend_vec` 34 ns 中 ~17 ns 是 `input.clone()` 的 malloc + memcpy(bench 自身成本),`_trustedlen` 24 ns 是 `Range<u16>` 經 `write_iter_wrapping` 物化 1 KB(0.024 ns/B,已向量化);未見異常,不另立章。
3. x86:同構,memcpy 底線由平臺決定。

## 復現

```bash
BIN=build/.../allocbenches-2cf0e8badf7482bf
$BIN --bench 'vec_deque::bench_extend'
perf record $BIN --bench vec_deque::bench_extend_bytes   # 77% __memcpy_generic
# 探針:/tmp/btree_bench/probe_ext/probe.rs
```

# `any::bench_downcast_ref`:3.2 ns = 一次不可去虛化的 vtable 調用 + 128-bit 比較 + 兩個 black_box 的棧往返;唯一頭寸是 `TypeId` 陣列佈局導致的 sret 回傳(≈0.2 ns)

- 日期:2026-09-17
- 分析對象:`library/coretests/benches/any.rs` 的 `bench_downcast_ref`(`let mut y = &mut x as &mut dyn Any; black_box(&mut y); black_box(y.downcast_ref::<isize>() == Some(&0))`)
- 基線:**3.23 ns/iter**(±0.20),IPC 2.30,branch-miss 0.00%
- 實現:`library/core/src/any.rs` 的 `<dyn Any>::downcast_ref` → `is::<T>()` → `TypeId::of::<T>() == self.type_id()`;`TypeId` 是 `[*const (); 2]`(16 B),`==` 經 `type_id_eq` 內建 = `transmute::<u128>` 比較

## 熱迴圈就是全部

```asm
58d8c: stp  x26, x24, [x29, #-64]   ; black_box(&mut y):胖指標落棧
       stur x8, [x29, #-48]
       ldp  x20, x8, [x29, #-64]    ; 重載 (data, vtable)
       ldr  x9, [x8, #24]           ; vtable[3] = type_id
       blr  x9                      ; 不可去虛化(y 經 black_box 變不透明)
       ldp  x9, x8, [x29, #-48]     ; sret:被調方 str q0 → 這裡 ldp 回來
       cmp  x8, x21
       ccmp x9, x22, #0, eq         ; 128-bit 比較 = 2 條
       b.ne ...                     ; 57.6% 樣本(等 blr 返回)
58d78: sturb w8, [x29, #-48]        ; black_box(bool) 落棧,18.9%
```

被調的 `<isize as Any>::type_id` 本體:`adrp; add; ldr q0,[x9]; str q0,[x8]; ret`——16 B 常量經記憶體回傳(`[*const (); 2]` 是 Array ABI,走 sret),調用方再 `ldp` 讀回。

## 拆分(探針,5000 萬次)

| 形態 | ns |
|---|---:|
| 官方 body(兩個 black_box) | 4.98(探針內聯差異;harness 3.23) |
| `is::<isize>()`,`&dyn` 不透明 | 1.283 |
| `downcast_ref::<isize>().is_some()` | 1.281 |
| 錯配 `is::<u8>()` | 1.282(分支預測完美,無差) |
| 只做 vtable 載入 + `type_id()` 調用 | **1.257** |
| 空閉包(harness 地板) | 0.355 |

`is`/`downcast_ref` 相對「一次 dyn 調用」只多 **0.02 ns**——比較本身免費。3.23 ns 裡約 1.3 ns 是那次間接調用(含 sret 往返),其餘是 bench 自己兩個 `black_box` 造成的胖指標落棧/重載與 bool 落棧。

## 唯一頭寸:`TypeId` 回傳 ABI

模擬兩種佈局經 `#[inline(never)]` dyn 調用回傳 16 B 並比較:

| `TypeId` 佈局 | dyn 調用 + eq | 被調方回傳形態 |
|---|---:|---|
| `[*const (); 2]`(現狀,Array ABI) | 1.299 ns | `ldr q0; str q0,[x8]`(sret,記憶體) |
| `{ a: *const (), b: *const () }`(ScalarPair) | **1.100 ns(−15%)** | `mov/movk x0, x1`(暫存器) |
| 調用地板 | 1.035 | — |

陣列佈局是 CTFE 的需要(commit 486ffda9dcd「opaque TypeId handles for CTFE」:首字段攜帶 provenance)。兩個具名指標字段同樣能攜帶 provenance,但 `TypeId` 是 lang item,`rustc_const_eval`/`size_of_type_id` 等都按 `data` 陣列讀,改動在編譯器側,收益每次 dyn `is`/`downcast` 約 0.2 ns。x86-64 SysV 對 16 B 聚合本就用 `rax:rdx` 回傳,無此稅——這是 AArch64 AAPCS(HFA/陣列 > 16 B 規則外的聚合按 sret)特有。

## 判斷

1. `downcast_ref` 的 std 側實現已是最小形態(一次調用 + 一次 128-bit 比較),**排除**。
2. 候選(編譯器側,低優先):`TypeId` 改 ScalarPair 佈局省掉 AArch64 上的 sret 往返,−15%/調用;絕對值 0.2 ns,只在極高頻 `dyn Any` 分派場景可見。
3. bench 本身 60% 是 `black_box` 的棧往返,量的是「一次不可去虛化調用」的成本,對 `downcast_ref` 的實現變化不敏感。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench 'any::bench_downcast_ref'
perf annotate ...   # 57.6% 在 blr 後的 b.ne,18.9% 在 black_box(bool) 的 sturb
# 探針:/tmp/btree_bench/probe_any/{probe,abi}.rs(拆分 / Array-vs-ScalarPair 回傳 ABI)
```

# `iter::bench_next_chunk_filter_map_even`:已是無分支壓縮迴圈,~2 cycles/元素貼近掃描地板;手寫 SIMD 掩碼上限僅 −10%

- 日期:2026-09-17
- 分析對象:`library/coretests/benches/iter.rs` 的 `bench_next_chunk_filter_map_even`(`[i32;1024].iter().filter_map(|&i| (i%2==0).then(|| i)).next_chunk::<32>()`——掃 64 個元素取 32 個偶數)
- 基線:**52.6 ns/iter**(0.82 ns/元素 ≈ 2.4 cycles),IPC 4.77,branch-miss 0.00%;同組 `filter_even` 61.6、`filter_map_predictably_true` 28.4、`copied`(TRA)37.6
> **2026-10-08 修正**:本章「貼近掃描地板」的結論**不成立**。該內層迴圈對每個被掃過的元素都無條件 store,改為條件式 store 後 `filter_even` −15.3%、`mostly_false` 家族 −38…−41%(見 `iter::bench_next_chunk_*` 章)。本章實測的 2.4 cycles/元素是該實現的成本,不是掃描本身的下限。
- 實現:`library/core/src/iter/adapters/filter_map.rs` 的 `FilterMap::next_chunk` 覆寫——`try_for_each` 內無條件把 `Option<B>` 的 payload 拷進 `array[idx]`,`idx += val.is_some()`,滿 N 即 `Break`

## 熱迴圈(99.75% 在閉包,單一迴圈)

```asm
3a1f0: ldr  w13, [x12, x11]        ; a[i]
       str  w13, [x27, x10, lsl #2] ; array[idx] = i(無條件寫)
       mvn  w14, w13
       and  x10, x14, #0x1          ; pred = (i & 1) == 0
       add  x10, x15, x10           ; idx += pred
       cmp  x10, #0x20
       b.cs 3a158                   ; idx == 32 → Break   (44% 樣本:等 idx 鏈)
       add  x11, x11, #0x4
       cmp  x11, #0x1, lsl #12
       b.ne 3a1f0
```

9 條/元素、零數據依賴分支,唯一的 loop-carried 鏈是 `idx`(1 cycle add)+ 以 `idx` 為地址的 store。`Option<B>` 的 `then`/payload 拷貝/`forget` 全被摺掉,和 `filter` 的 `next_chunk_dropless` 設計意圖一致。

## 對照(探針,同語義:掃到 32 個偶數即停)

| 形態 | ns |
|---|---:|
| 官方 `filter_map(..).next_chunk::<32>()` | 48.7–52.3 |
| 手寫:`MaybeUninit` 輸出 + 分支 `if even { push; if n==32 return }` | 63.3 |
| 手寫:`while n<32 { next() }` | 60.1 |
| 手寫:2× 展開無分支 | 46.4 |
| 手寫:8 寬 SIMD 掩碼 + 標量壓縮(非泛型上限) | 43.5 |
| **地板**:`filter_map(..).nth(31)`(只掃不寫) | 43.7 |
| `-Ctarget-cpu=native` / `-unroll-runtime` | 52.5(無變化) |

現實現比樸素分支寫法快 15–20%,離「只掃描不輸出」的地板差 5–9 ns(≈ 32 次 store + 收尾的 128 B `array_assume_init` 搬運);SIMD 掩碼上限也只到地板,因為瓶頸在 `idx` 依賴鏈與 store,不在謂詞計算。真正的壓縮向量化(`vcompress`/SVE `compact`)需要 `T: Copy` 定寬特化,收益上限 ~10%,不值得。

## 附帶:`filter_even` 比 `filter_map_even` 慢 17%

`Filter::next_chunk_dropless` 的元素是 `&i32`(8 B),熱迴圈多了 `ldr x10,[sp,#1248]`(每輪從棧重載迭代器指標)和 `ldp q1,q0,[sp,#976]`;閉包經 `&mut array`/`&mut initialized` 捕獲,LLVM 沒把 `initialized` 完全提進暫存器。`FilterMap` 版用 `Guard` 結構卻更乾淨——差異是閉包捕獲形態的 SROA 運氣,可能值 ~9 ns,但 `filter_even` 不是本次對象,記作線索。

## 判斷

1. `FilterMap::next_chunk` 已是無分支壓縮形態,2.4 cycles/元素,距地板 ≤10%,手寫與編譯器旗標均無法超越。**排除**。
2. ~~線索:`Filter::next_chunk_dropless` 的閉包捕獲形態有 ~15% 棧往返,可另查。~~(已於 `bench_next_chunk_filter_even` 章證偽:差距是 `&i32` vs `i32` 元素寬度,Guard 形態同碼。)
3. x86:同構,無 SVE `compact` 的平臺上限相同。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench 'next_chunk'
perf annotate ...   # 44% 在 cmp idx,#0x20(idx 鏈),單迴圈 9 條/元素
# 探針:/tmp/btree_bench/probe_nc/{probe,probe2}.rs
```

# `hash::set_ops::set_difference`:91 ns = 10 次 `large.contains`,每次 SipHash-1-3 ≈ 5.9 ns + hashbrown probe ≈ 3.7 ns;算法與 probe 已最優,2/3 是 HashDoS 防護的有意代價

- 日期:2026-09-17
- 分析對象:`library/std/benches/hash/set_ops.rs::set_difference`(`small(0..10).difference(&large(0..100)).count()`,small ⊂ large,10 次 lookup 全命中、全被過濾)
- 基線:**91.4–93.1 ns/iter**(官方 `stdbenches` 二進位直跑;`./x bench library/std` 本工作樹仍遇 `duplicate lang item`,與 `set_union` 章同);同組 `set_is_subset` 92.7、`set_intersection` 98.0、`set_union` 92.2、`set_symmetric_difference` 892.7
- 實現:`library/std/src/collections/hash/set.rs` 的 `Difference::next` = `self.iter.find(|e| !other.contains(e))`,`count` 經 `fold` 內聯;`contains` → hashbrown `find` → SipHash-1-3 + group probe
- 前置:`set_union` 章(2026-08-21)已對同一條 difference 路徑做過分解,本章補官方 harness 直測數字、miss 路徑對照與流水化可行性

## 官方 harness 畫像

99.86% 樣本在 `set_difference` 閉包單符號(整鏈內聯)。1.38G 指令 / 0.52G 週期,IPC 2.65,branch-miss 0.01%——純指令與依賴鏈,無事件。

## 分解(探針,同構)

| 成分 | ns | 每次 lookup |
|---|---:|---:|
| `small.difference(&large).count()`(官方形態) | 97.3 | 9.7 |
| `small.iter().count()`(10 元素 RawTable 掃描) | 0.65 | — |
| 10× `BuildHasher::hash_one(i32)`(只算 SipHash) | 59.4 | **5.9** |
| ⇒ probe(h1 定位 group、8 B control 比較、h2 確認、key 比對) | — | **3.7** |
| 10 次 `contains` 手寫迴圈 | 103.6 | 10.4 |
| **不相交**(10 次 miss) | 87.3 | 8.7(h2 不匹配即返回,省 1 ns) |
| **FxHash** 同形態 | **33.6** | 3.4 |

SipHash-1-3 對 4 B key 的固定成本 ~6 ns(初始化 4 個 v、1 輪壓縮 + 3 輪 finalize、加上 `RandomState` 的兩個 key 載入),probe ~3.7 ns。換 FxHash 整體 −65%。

## 流水化不可行

唯一想得到的 std 側方向是「先算 10 個 hash 再 probe」讓 SipHash 與 probe 重疊。實測「hash 10 個進陣列 + 10 次 contains」164 ns(hash 算了兩次,證明 hashbrown 沒有暴露「用預算 hash 查找」的公開 API;`RawTable::find(hash, eq)` 是 hashbrown 內部,std 的 `HashSet` 只包 `hashbrown::HashSet`,無法從 `Difference` 觸及)。且 10 次獨立 SipHash 之間 CPU 亂序本已可重疊——各 lookup 之間沒有真依賴,IPC 2.65 說明流水線並未空轉,顯式流水化的收益上限遠低於 `set_union` 章估的 30%。(獨立/串行依賴 SipHash 對照探針因工具環境中斷未跑;結論不依賴它。)

## 判斷

1. `difference` 的「小側逐元素查大側」是唯一正確算法;RawTable 掃描 0.065 ns/元素、probe 3.7 ns 均貼近極限。**排除**,與 `set_union` 章結論一致。
2. 91 ns 的 2/3 是 SipHash——HashDoS 防護的語義選擇,不是病灶;用戶側 `FxHashSet`/`ahash` 一行 −65%。
3. `set_symmetric_difference` 893 ns 同機理但**另有專章**(見下):查找次數是 `|A|+|B|` = 110 而非 10,兩個 `difference` 串接使成本翻倍於同族。
4. x86:`set_union` 章已做 SWAR probe 的 llc 對照,逐步同構;SipHash 標量輪同構。

## 復現

```bash
BIN=build/aarch64-unknown-linux-gnu/stage1-std/aarch64-unknown-linux-gnu/dist/build/std/5276defc8035ff52/out/stdbenches-5276defc8035ff52
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib $BIN --bench 'set_ops'
# 探針:/tmp/btree_bench/probe_set/probe.rs(分解 / 不相交 / FxHash / 預算 hash)
```

# `fmt::write_u8_min`:54 ns 中 ~26 ns 是 AArch64 前端停頓——`format!` 的空 String 首次寫入走 `grow` 把調用鏈加深到觸發 return-stack 溢出;`estimated_capacity()=8` 令本項 −47%,但把 stall 原封不動搬到 `u64_max`/`u128_max`(+48%/+34%),不可落地

- 日期:2026-09-17
- 分析對象:`library/coretests/benches/fmt.rs::write_u8_min`(`format!("{}", black_box(u8::MIN))`)
- 基線:**54.0–54.4 ns/iter**;`write_u8_max` 52.6、`write_u64_min` 55.2、`write_u64_max` 44.5、`write_u128_min` 57.5、`write_u128_max` 63.3
- 實現鏈:`format_inner`(`estimated_capacity()` 對「以佔位符開頭且字面量 <16」的模板返回 **0**)→ `String::with_capacity(0)` → `fmt::write` → `<u8 as Display>::fmt` → `pad_integral` → `write_prefix` → `String::write_str` → `Vec::extend_from_slice` → `reserve` → `do_reserve_and_handle`(cold)→ `grow_amortized` → `finish_grow`(cold)→ `__rust_alloc` → `malloc`
- 前置:`write_u64_min` 章(2026-08-21)已發現「min 的機制段比 max 貴 ~23 ns、無法定量歸因」;本章給出歸因
- 後續(2026-09-30):`write_u8_max` 章以固定 2000 萬次迭代 + `perf stat` 直接驗證本機制——兩個 arm 的指令數逐位元組相同(496 / 576),差異全在 `STALL_FRONTEND`;並確認該 8 ns 差距僅見於 2026-09-15 的舊 libstd

## 分解(探針,靜態鏈接 libstd)

| 成分 | ns |
|---|---:|
| `format!("{}", u8::MIN)` | 32.7 |
| `u8::MIN.to_string()`(`SpecToString`:`with_capacity(3)` + `_fmt` + `push_str`,不經 `fmt::write`) | 14.9 |
| `String::with_capacity(1)` + `push('0')`(分配地板) | 11.6 |
| `write!` 進復用 String(fmt 機制,無分配) | 12.4 |
| `u8::_fmt` 進棧緩衝(轉換本體) | **1.7** |
| `with_capacity(0)` + `write!`(= `format!` 路徑) | 27.7 |
| `with_capacity(8)` + `write!` | 23.8 |

靜態鏈接下 `format!` 只有 33 ns,fmt 機制 ~11 ns、分配 ~11 ns、grow 額外 ~4 ns,全部合理。**但官方 harness 是 54 ns**——差的 21 ns 只在 `-Cprefer-dynamic`(bootstrap 給 bench crate 的鏈接方式)下出現。

## 歸因:前端停頓,由調用深度觸發

同一探針靜態 vs 動態鏈接的 PMU 對比(每 iter):

| | 指令 | 週期 | `STALL_FRONTEND` | `BR_MIS_PRED` | `L1I_REFILL` | `L1I_TLB_REFILL` |
|---|---:|---:|---:|---:|---:|---:|
| 靜態 `format!` | 467 | 93 | 0.1 | 0.01 | 0 | 0 |
| **動態 `format!`** | 491 | **157** | **44** | 0.1 | 0 | 0 |
| 動態 `with_capacity(8)+write!` | 380 | 74 | 0.1 | — | — | — |
| 官方 harness `write_u8_min`(每 100 週期) | — | 100 | **29** | 0.10 | 0 | 0 |

指令只多 5%,週期多 68%,全是 `STALL_FRONTEND`;icache/iTLB/分支預測全零。停頓採樣落點:`malloc` 入口 53%、`format_inner` 裡 `bl core::fmt::write@plt` **之後的第一條指令** 36%——即**從深層返回時取指停頓**,典型的 return-address-stack 溢出徵狀(返回目標從 RSB 掉出,改由 BTB/順序取指恢復)。

決定性實驗——人為在 `format!` 外再包 k 層 `#[inline(never)]` 空函數:

| 額外深度 k | 動態:週期 / STALL_FE | 靜態:週期 / STALL_FE |
|---|---:|---:|
| 0 | 91 / 0 | 86 / 1 |
| 1 | 97 / 2.5 | 89 / 1 |
| **2** | **133 / 28** | 87 / 1 |
| 3 | 155 / 45 | 89 / 1 |
| **5** | 168 / 53 | **128 / 25** |
| 8 | 178 / 59 | 158 / 46 |

動態鏈接在 +2 層觸發,靜態在 +5 層觸發——差 3 層恰好是 PLT stub 與跨 so 的 `format_inner`/`fmt::write`/`__rust_alloc` shim 不被內聯所多出的幀。短鏈的 `with_capacity(8)+write!` 要到 +8 層才觸發,純 `malloc/free` 到 +12 層仍不觸發。**本核的有效 RSB 深度在 `format!` 的 grow 路徑上恰好被踩滿**:harness 的 `Bencher::iter → 閉包 → format_inner → fmt::write → Display::fmt → pad_integral → write_prefix/write_str → extend_from_slice → do_reserve_and_handle → grow_amortized → finish_grow → __rust_alloc → __rdl_alloc → malloc → _int_malloc` 十餘層,`grow` 那 3 個 cold 幀是壓垮的最後一根稻草。

## 原型:`estimated_capacity()` 對佔位符開頭模板返回 8 而非 0

官方 harness,3 次交錯:

| benchmark | 現狀 | cap=8 | 變化 | STALL_FE/100cyc 現狀→cap8 |
|---|---:|---:|---:|---:|
| `write_u8_min` | 54.3 | **28.8** | **−47%** | 29 → 0.1 |
| `write_u8_max` | 52.6 | 29.9 | −43% | — |
| `write_u64_min` / `u128_min` | 55.2 / 57.5 | 29.0 / 30.2 | −47% | — |
| `write_u64_max`(20 B) | 44.4 | **65.1** | **+47%** | 2.7 → **25** |
| `write_u128_max`(39 B) | 63.7 | **85.2** | **+34%** | 12.6 → 14 |
| `write_i*_{hex,oct,bin,exp}`(17 項)、`write_str_*`/`write_vec_*`(11 項) | — | ±2% | 持平 |

> **出處註記(2026-09-30)**:本表的「現狀」欄取自**舊 libstd**(`core_base`,2026-09-15),故 `write_u64_max` 記為 44.4;當前樹上該項為 51.5–51.8(六項見 `write_u8_max` 章),差距是佈局效應而非本原型造成。cap=8 的**相對**效果(把停頓從 min 轉移到 max)與該表的定性結論不受影響。

停頓沒有消失,只是換了受害者:cap=8 讓 "0" 不再 grow(鏈短 3 層,退出 RSB 溢出區),卻讓 20 B/39 B 輸出從「一次 grow」變成「先分配 8 再 realloc」——同樣的深鏈。容量掃描(動態鏈接,每 iter 週期 / STALL_FE):

| 預分配 | "0" | u64::MAX 20 B | u128::MAX 39 B | 100 字符 |
|---|---:|---:|---:|---:|
| 0(現狀) | 90 / 0 | 116 / 0 | 149 / 0 | 84 / 0 |
| 8 | 75 / 0 | 126 / 3 | 263 / **43** | 193 / **41** |
| 16 | 75 / 0 | 244 / **55** | 262 / 41 | 192 / 41 |
| 24 | 76 / 0 | 104 / 0 | 263 / 41 | 192 / 41 |
| 40 | 75 / 0 | 99 / 0 | 134 / 0 | 193 / 41 |

任何固定非零估計都只是把「哪個長度會踩到 realloc 深鏈」挪一挪;現狀的 0(一次 grow 到精確大小)對長輸出反而是最優。

## 判斷

1. `write_u64_min` 章的未解之謎已關閉:min 比 max 慢的 ~20 ns 是 **AArch64 前端 return-stack 溢出停頓**,由「動態鏈接 + 空 String 首寫走 grow」的調用深度觸發,與分配器路徑、分支預測無關。
2. **不建議改 `estimated_capacity`**:任何固定值都把停頓轉移到另一個輸出長度,總體零和;現狀對長輸出最優。**排除**。
3. 真正的槓桿在鏈深本身:(a)`format_inner` 對整數 Display 走 `SpecToString` 式直寫(15 ns,但 `format!` 的 `Arguments` 在運行時不知道參數類型,需要編譯期特化);(b)把 `do_reserve_and_handle → grow_amortized → finish_grow` 三個 cold 幀合併——通用收益不明,且 x86 的 RSB 深度不同(通常 16–32),本機 HiSilicon 的觸發點不代表其他核。
4. harness 注記:`-Cprefer-dynamic` 使 std 的 bench 比用戶靜態鏈接的程式多 3 層;這組 `write_*_min` 數字對真實(靜態)程式**高估 ~65%**。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
LD_LIBRARY_PATH=... perf stat -e cycles,r23,r10 $BIN --bench 'fmt::write_u8_min'   # r23=STALL_FRONTEND 29%
# 探針:/tmp/btree_bench/probe_fmt/{probe,cap,cap2,chain,depth,depth2,capn}.rs(拆分/容量/鏈環/深度掃描/容量×長度)
# 原型:core/src/fmt/mod.rs estimated_capacity 返回 8(已回退);二進位 /tmp/btree_bench/core_cap8/
```

# `btree::map::from_iter_rand_10_000`:218 µs 中 ~140 µs(65%)是 `sort_by` 排序,`bulk_build` 55 µs;排序是通用 driftsort,13.3 次比較/元素已是比較排序的形態,無 std 病灶

- 日期:2026-09-17
- 分析對象:`library/alloctests/benches/btree/map.rs::from_iter_rand_10_000`(10 000 個 `(u32, u32)`,key 為 `rng % n`,約 6 337 個唯一鍵;`vec.iter().copied().collect::<BTreeMap>()`,結果 map 在 `b.iter` 內 drop)
- 基線:**218–230 µs/iter**;`from_iter_seq_10_000` 200 µs(已排序輸入,排序退化為一趟掃描,見 §11 章 −51%)
- 實現:`FromIterator for BTreeMap` = `collect::<Vec>()` → `sort_by(|a,b| a.0.cmp(&b.0))`(穩定,保留重複鍵的插入序以便 dedup 取最後值)→ `bulk_build_from_sorted_iter`(`DedupSortedIter` + `bulk_push` 右脊柱追加)

## perf 畫像

| 符號 | 佔比 |
|---|---:|
| `sort::stable::quicksort`(driftsort 主體) | 32.2% |
| `smallsort::small_sort_general_with_scratch` | 23.1% |
| `sort::stable::...::sort8_stable` / `median3_rec` / `drift::sort` | 11.1% |
| **排序合計** | **~66%** |
| `append::bulk_push`(NodeRef Owned) | 17.6% |
| bench 閉包本體(collect 到 Vec + drop) | 3.9% |
| memcpy / malloc / consolidate | 7.2% |

1.79G 指令 / IPC 3.12,**branch-miss 5.54%**——全在排序的比較分支(隨機鍵,比較排序的本質熵);L1d miss 僅 2M。quicksort 熱點是分區迴圈的 `ldr` 載入鍵 + 比較。

## 分解(探針,同構 LCG 輸入,6 337 唯一鍵)

| 成分 | µs | 每元素 |
|---|---:|---:|
| 官方形態(clone → from_iter → drop) | 211 | 21 ns |
| `Vec` clone | 1.2 | — |
| **`sort_by(key)` 穩定** | **138** | **13.8 ns ≈ 13.3 次比較 × ~1 ns** |
| `sort_unstable_by_key` | 145 | 不更快(ipnsort 對 8 B 元素無優勢) |
| `sort()` 全元組 Ord | 209 | +50%(多比較第二字段) |
| LSD radix 2×16-bit(非泛型對照) | 144 | 桶計數 1 MB 初始化吃掉收益 |
| `bulk_build` 不 drop | 57 | 5.7 ns/元素 |
| `bulk_build` + drop | 47–54 | drop 已被 §11 節點級釋放覆蓋 |
| 對照:逐個 `insert` | 697 | 3.3× 慢——bulk 路徑本身正確 |

## 判斷

1. `FromIterator` 的「排序 + 順序批量建樹」是正確策略(比逐個 insert 快 3.3×);排序用的是 std 通用 driftsort,13.8 ns/元素對 10 k 隨機 u32 鍵是比較排序的正常水準,`sort_unstable` 亦無改善。`bulk_push` 5.7 ns/元素(每 11 元素填一葉、每 ~121 元素升一層)已貼近逐元素寫入成本。**排除**。
2. 非比較排序(radix)對 `K: Ord` 泛型接口不可用;即便對整數鍵特化,10 k 規模下桶初始化成本抵消收益,需 ≥100 k 才划算——不是 std 該做的判斷。
3. `from_iter_seq` 與 `from_iter_rand` 的 200 vs 218 µs 差距小,說明 seq 版有一半時間在 drop(§11 已修 −51%);rand 版 drop 佔比小(§10+§11 補丁 −3.6%),主體是排序。
4. x86:driftsort 的分區/小排序在 x86 有 `cmov`/`pcmpgt` 同構實現,比較次數相同,無平臺差異。

## 復現

```bash
BIN=build/.../allocbenches-2cf0e8badf7482bf
$BIN --bench 'btree::map::from_iter'
perf record $BIN --bench btree::map::from_iter_rand_10_000   # 排序 66% / bulk_push 18%
# 探針:/tmp/btree_bench/probe_fi/{probe,probe2}.rs(拆分 / 排序變體 / radix 對照 / build-vs-drop)
```

# `iter::bench_enumerate_ref_sum`:Enumerate 計數器已融進歸納變量(`mul x10,x10`),7 條/元素的迴圈裡 35% 是 `black_box` 的 stur/ldur 棧往返;ref ≡ value,無 std 病灶

- 日期:2026-09-17
- 分析對象:`library/coretests/benches/iter.rs::bench_enumerate_ref_sum`(`(0i64..1M).enumerate().map(|(i,x)| x*i as i64).map(black_box).by_ref().sum()`)
- 基線:**540.6 µs/iter = 0.541 ns/元素 ≈ 1.57 cycles**;`bench_enumerate_sum`(value 版)540.6,逐條同碼;IPC 4.46,branch-miss 0.00%
- 前置:`bench_enumerate_chain_ref_sum` 章已證 `bench_sums!` 的 value/ref 對照全系失效(`&mut I` 轉發 `try_fold`);本章補非 chain 版的逐指令歸因與屏障成本定量

## 熱迴圈(99.65% 單符號)

```asm
7a5f0: mul  x11, x10, x10       ; x*i,且 i == x → 融合成 i²(Enumerate 計數器零殘留)
       add  x10, x10, #1
       cmp  x20, x10
       stur x11, [x29, #-32]    ; ┐ map(black_box):值經記憶體往返
       ldur x11, [x29, #-32]    ; ┘
       add  x9, x11, x9         ; sum
       b.ne 7a5f0
```

7 條/元素,83% 樣本落在 `mul`(等前一輪 `ldur` 的 store-forwarding)。

## 拆分(探針)

| 形態 | ns/元素 |
|---|---:|
| 官方 ref 版 | 0.541 |
| value 版(無 `by_ref`) | 0.541(同碼) |
| 去掉 `black_box` | **0.000**——LLVM 把 Σi² 閉式求解,整個迴圈消失 |
| 只留屏障:`(0..1M).map(black_box).sum()` | 0.353 |
| 手寫 `s += black_box(i*i)` | 0.541(與官方同) |
| 手寫,屏障改為暫存器級 `asm!` inout(無 store/load) | **0.352(−35%)** |

`black_box` 的實現是「值落棧 + 記憶體 clobber + 重載」,每元素一對 stur/ldur 加一次 store-to-load forwarding 延遲;把屏障換成不經記憶體的暫存器 asm 後,mul+add+cmp+add+b 五條指令跑 0.35 ns ≈ 1 cycle/元素,即本核的 IPC 上限。**這組 bench 的絕對值有 35% 是屏障本身的實現方式**,與被測的 Enumerate/Map/sum 無關。

## 判斷

1. `Enumerate`/`Map`/`&mut I`/`sum` 在此形態下零開銷:計數器融合、無狀態檢查、無調用。**排除**。
2. 與 chain 版結論一致:value/ref 對照失效,`bench_enumerate_sum`/`_ref_sum` 是同一份機器碼;若要對照有意義需真正的 dyn 邊界(注意 `&mut dyn Iterator` 在同函數內會被去虛化——探針中亦被閉式求解成 0)。
3. `core::hint::black_box` 走記憶體是為了對所有類型通用;bench 側若想量純計算路徑,應改用暫存器級 asm 屏障。
4. x86:前章已做 llc 對照,同構。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench 'iter::bench_enumerate'
# 探針:/tmp/btree_bench/probe_en/probe.rs(閉式/屏障/暫存器屏障/dyn)
```

# `num::int_bits::u16::constant::deposit_bits`(原名 `scatter_bits`):常量掩碼下 `prepare()` 已被完全常量摺疊,熱迴圈 28 條 NEON 位運算 / 16 元素,0.245 ns/元素;掩碼特化的 morton 形態能省 22%,但那是掩碼結構特化而非通用改進

- 日期:2026-09-18
- 分析對象:`library/coretests/benches/num/int_bits/mod.rs` 的 `u16::constant::deposit_bits`(512 個 u16,掩碼 `const U::MAX/3 = 0x5555`,經 `black_box` 的 fn 指標調用 `vectored`;`scatter_bits` 已於 29596f87becf 更名 `deposit_bits`,API 仍 unstable `uint_gather_scatter_bits`)
- 基線:**123–125 ns/iter = 0.245 ns/元素 ≈ 0.7 cycles**;同組 `constant::extract_bits` 150、`invariant::deposit` 188、`variable::deposit` 830
- 實現:`library/core/src/num/imp/int_bits.rs` 的 `deposit_impl`:`prepare(mask)` 算 `STAGES = log2(BITS)` 個階段掩碼,每階段 `q = x & m; x ^= q; x ^= q << n`,最後 `& mask`;無任何架構特化(x86 BMI2 `pdep` 亦未使用)

## 熱迴圈(99.5% 單符號,`vectored` 被完整向量化)

`prepare(0x5555)` 在編譯期摺疊為 3 個非零階段掩碼(`0x00F0`/`0x30F0`/`0x0F0F`-類常量進 `v0..v4`),迴圈每次處理 2×8 個 u16:

```asm
c86dc: ldp  q5, q6, [x9, #-16]        ; 32 B(85.7% 樣本:等載入)
       and/bic/shl/orr/eor ×2         ; 階段 n=4:5 條/向量
       shl/and/and/eor ×2             ; 階段 n=2:4 條/向量
       add/and/and/orr ×2             ; 階段 n=1(shl #1 → add v,v):4 條/向量,含最終 & mask
       stp  q5, q6, [x8, #-16]
```

28 條向量 ALU / 迭代(16 元素),IPC 3.35,branch-miss 0.02%。0.7 cycles/元素已是 NEON 吞吐(4 個向量 ALU 端口的 ~1.75 op/cycle × 16 lane)。

## 對照(探針,同 512×u16、同 fn 指標形態;三者輸出逐位相等)

| 形態 | 向量 ALU/迭代 | ns | 每元素 |
|---|---:|---:|---:|
| 現狀 `deposit_bits(0x5555)` | 28 | 125.2 | 0.245 |
| 現算法改寫為 `(x & !m) \| ((x & m) << n)` | 24 | 115.8 | 0.226(−7%) |
| **0x5555 專用 morton spread** `x = (x \| x<<n) & m'`(3 階段 × 3 條) | 20 | **97.5** | **0.190(−22%)** |
| 現狀 `extract_bits(0x5555)` | — | 151.8 | 0.296 |

通用算法每階段 4 條(and, and-not, shl, eor);morton 每階段 3 條是因為 0x5555 的 run 等長、位移互不重疊,可用 `or` 合併並讓一個 `and` 同時完成「選位」與「清位」。這個結構對任意掩碼不成立(通用情形位移落點含任意位,需 xor 語義),所以 22% 是**掩碼結構特化**的收益,不是算法缺陷。

## `variable` 與 `invariant` 檔位

`variable::deposit_bits` 830 ns(6.7×):每元素重算 `prepare()`——3 階段 × parity 前綴 xor(4 次 `p ^= p << len`)≈ 48 條向量運算全在串行依賴鏈上,IPC 1.46。這是「無硬體 pdep 時逐元素可變掩碼」的固有成本;本核有 SVE 但無 SVE2 `BDEP/BEXT`(`/proc/cpuinfo` 無 `svebitperm`),無硬體路徑可走。`invariant` 188 ns 介於兩者:LLVM 沒把 `src[0]` 的 `prepare()` 提出迴圈(fn 指標調用邊界 + `prepare` 未標 `#[inline]` 之外的 hoist 判斷),多付一次每迭代的掩碼計算——若要優化,是把 `prepare` 提到迴圈外,那是調用方(bench)的形態問題。

## 判斷

1. 常量掩碼下實現已達 NEON 吞吐,通用算法 4 條/階段是 xor 語義所需;**排除**。
2. 可探討但不推薦:`const fn` 內對「所有 run 等長且與位移對齊」的掩碼走 morton 形態——收益 22%,適用面窄,且此 API 尚 unstable。
3. **x86 線索**:`int_bits.rs` 無任何 `target_feature` 分派,BMI2 機器上 `pdep`/`pext` 單指令(3 cycles)未被使用;對 `variable` 檔位可從 ~1.6 ns/元素降到 ~0.1。本機無法實測,記為 x86 側候選。
4. ARM 側:SVE2 `BDEP.B/H/S/D` 同樣是單指令,對支持 `sve2-bitperm` 的核(Neoverse V2 等)可做同樣特化;本機不支持。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench 'int_bits::u16'
perf annotate ...   # 85.7% 在 ldp(載入等待),28 條向量 ALU/16 元素
# 探針:/tmp/btree_bench/probe_bits/probe.rs(現狀 / or-form / morton / extract 對照 + asm 計數)
```

# `str::char_indicesator`:11 ns 即 SWAR `count_chars`,無事;但 `_rev` 姊妹項 35 ns 是因為 `Rev::count` 走逐字符 `next_back`——對 `Rev` 轉發 `count` 到內層即 −68%(4 KB 串 9×)

- 日期:2026-09-18
- 分析對象:`library/alloctests/benches/str.rs::char_indicesator`(65 B / 51 char 混合串,`s.char_indices().count()`)與 `char_indicesator_rev`(`.rev().count()`)
- 基線:**11.3 ns**(forward)/ **34.9 ns**(rev);`char_iterator` 11.5 / `char_iterator_rev` 48.0
- 實現:`CharIndices::count` → `Chars::count` → `count::count_chars`(SWAR,見 `str::char_count` 章);`Rev<I>::count` **無覆寫** → 默認 `fold` → `Rev::fold` → `I::rfold` → 逐字符 `next_code_point_reverse`

## forward:已在 SWAR 路徑,bench 本身還被部分常量摺疊

官方二進位裡 `Bencher::iter` 閉包直接 `bl do_count_chars@plt`(常量 `&str` 的長度/指標可見,`char_indices()` 的 `front_offset` 簿記全消失);perf 樣本 92% 落在 `ld.so`/`calloc`(11 ns 的 bench 跑不滿採樣窗)。探針用 `black_box` 串:forward `char_indices().count()` 12.0 ns = `chars().count()` 12.0 ns。**無病灶。**

## rev:逐字符反向解碼,3× 慢

`Rev::count` 落到 `Chars::rfold` → 每字符 `next_code_point_reverse`(從尾部讀 1–4 個字節、判斷 continuation),熱迴圈 `ldrsb; tbz; ldrsb; cmn; b.gt ...` 每字符 ~8 條 + 1 個難預測分支(ASCII/多字節混合,branch-miss 顯著)。47.0G 指令 / 51 字符 ≈ 17 條/字符(含 assert);而 forward 的 SWAR 是 0.23 ns/B。

`count()` 的結果與方向無關,`Chars`/`CharIndices`/`Bytes`/`slice::Iter` 都有 O(1) 或 SWAR 的 forward `count`——`Rev` 只需轉發。

## 原型(`library/core/src/iter/adapters/rev.rs`,+8 行)

```rust
#[inline]
fn count(self) -> usize { self.iter.count() }   // 與 advance_by → advance_back_by 同一風格
```

| benchmark / 探針 | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| `str::char_indicesator_rev` | 34.9 ns | **11.2 ns** | **−68%** |
| `str::char_iterator_rev`(`chars().rev().count()`) | 48.0 | **11.5** | **−76%** |
| 探針 `chars().rev().count()` 4160 B | 2165 ns | **239**(= forward) | **9.1×** |
| `slice.iter().rev().count()` / `(0..n).rev().count()` | 0 / 0.64 | 0 / 0.46 | 已是 O(1) |
| `chars().rev().filter(..).count()` | 2342 | 2344 | 不受影響(Filter 在 Rev 外層) |
| `str::char_*` 其餘 5 項 | — | ±2% | 持平 |

coretests `rev` 27 項 + `iter` 330 項 + alloctests 113 項全過。

## 落地注意:副作用順序

`Iterator::count` 文檔為「反覆調用 `next` 直到 `None`」,`Rev::next = next_back`,因此 `(0..3).map(|x| { print!("{x}"); x }).rev().count()` 現在輸出 `210`;上述原型會變成 `012`(`Map` 無 `count` 覆寫,經 forward `fold`)。純 `Chars`/`Bytes`/`slice::Iter` 無副作用,轉發安全;但對任意 `I` 的 blanket 轉發改變可觀察順序。**正確落地形態**是內部 `min_specialization` trait(如 `SpecRevCount`):default 走現有 `rfold` 計數,對 `str::Chars`/`CharIndices`/`Bytes`/`slice::Iter<T>`/`Copied<slice::Iter>` 等已知純源特化為 `self.iter.count()`。收益不變,語義零改動。

## 判斷

1. `char_indices().count()` forward 無事;**`Rev::count` 缺特化**是真病灶,影響所有 `.rev().count()`。
2. 原型 8 行;落地需改為特化 trait 以保住副作用順序(工程量 ~30 行)。x86 同構(純算法路徑選擇)。
3. 另一線索:`str::char_iterator_rev_for`/`char_iterator_for`(逐字符 `for` + `black_box`)36–39 ns 是逐字符解碼 + 屏障,與 `chars().count()` 章結論同,不另立。

## 復現

```bash
BIN=build/.../allocbenches-2cf0e8badf7482bf
$BIN --bench 'str::char_'
# 原型:core/src/iter/adapters/rev.rs 加 count 轉發(工作樹,未提交;補丁 /tmp/btree_bench/rev_count.patch)
# 探針:/tmp/btree_bench/probe_ci/{probe,rev}.rs
```

# `ascii::medium::case07_fake_simd_u32`:這不是 std 接口而是 bench 內的手寫 SWAR 對照組——它比 libcore 慢 32%、且對 `\xFF` 相鄰字節算錯(源碼自帶 FIXME);medium 檔 76% 是 `to_vec` 分配

- 日期:2026-09-20
- 分析對象:`library/coretests/benches/ascii.rs` 的 `case07_fake_simd_u32`(`align_to_mut::<u32>` 後每 4 字節做 `w &= !((w+0x1f1f1f1f & !(w+0x05050505) & 0x80808080) >> 2)`,前後零頭走 `branchless_to_ascii_upper_case`);`medium` = "Alice's Adventures in Wonderland" 32 B
- 基線:**16.2 ns/iter**;同檔 `case06_libcore`(`make_ascii_uppercase`)12.3、`case05_branchless` 12.9、`case00_alloc_only` **12.6**;long 檔(4640 B):case07 566 / case06 410 / alloc_only 190
- 性質:case00–case09 是同一操作(ASCII 轉大寫)的 10 種寫法對照,case06 是 std 實現,其餘是手寫參照。**case07 沒有對應的 std 接口。**

## medium 檔:76% 是 harness 的 `to_vec()`

perf(閉包 + libc):`_int_free` 30.4% + `malloc` 22.2% + `cfree` 13.3% = **66% 在分配器**,閉包本體 29.7% 裡熱點是 `ldr x6,[x6,#24]`(`__rust_alloc` 的 shim 間接跳轉),真正的 SWAR 迴圈採樣 <5%。`case00_alloc_only` 12.6 ns 即地板;case07 的 16.2 只比它多 3.6 ns。這是 `ascii::long::is_ascii` 章已指出的宏缺陷(`to_vec` 在計時迴圈內)在 medium 檔的極端形態——32 B 上分配佔 76%,本組 10 項有 8 項擠在 12.2–12.9 ns 完全分不開。

## 操作本體(探針,復用緩衝,無分配)

| 形態 | 32 B | 4640 B | 每 B(long) |
|---|---:|---:|---:|
| case06 `make_ascii_uppercase`(std) | 6.27 ns | **133 ns** | **0.029** |
| case05 逐字節 branchless | 6.29 | 132 | 0.028 |
| case07 fake SWAR u32 | 7.64 | 209 | 0.045 |
| case08 fake SWAR u64 | 7.13 | 209 | 0.045 |

std 版與逐字節 branchless 版被 LLVM 自動向量化成 16 B/迭代 NEON(`cmhi`/`and`/`bic`),0.029 ns/B ≈ 34 GB/s;fake-SWAR 版因 `align_to_mut` 把切片切成三段 + u32 lane 上的加法進位模式,LLVM 對中段的向量化保守(33 條 NEON + 40 條標量 vs 18 + 11),反而**慢 57%**。「fake simd」在 2018 年寫下時是為了打敗當時未向量化的標量迴圈,現在已被自動向量化的樸素版超越。

## 正確性:源碼自帶的 FIXME 是真的

`case07(b"\xFFz  ")` 輸出 `[255, 122, 32, 32]`——`z` 沒有被轉大寫(期望 `[255, 90, 32, 32]`):`0xFF + 0x1f` 進位到相鄰字節,污染了 `z` 的判定位。這個對照組本身是錯誤實現,不能作為任何優化目標。

## 判斷

1. **無 std 接口可分析**:case07 是 bench 內的錯誤參照實現,std 的 `make_ascii_uppercase`(case06)已是自動向量化的最快形態,0.029 ns/B。**排除**。
2. bench 側:medium/short 兩檔因 `to_vec` 佔 76–98%,10 項對照全部失效(同 `is_ascii` 章結論);case07/08 應刪除或修正進位(用 `!w & 0x80808080` 先遮 MSB 再加)。
3. x86:自動向量化同構(SSE2 `pcmpgtb`/`pandn`),case07 的三段結構同樣不利。

## 復現

```bash
BIN=build/.../corebenches-14ea307f41bce867
$BIN --bench 'ascii::medium::case0'    # 8/10 項擠在 12.2–12.9 ns = alloc 地板
# 探針:/tmp/btree_bench/probe_asc/probe.rs(復用緩衝 4 形態 × 2 尺寸 + FIXME 復現 + asm 計數)
```

# `vec::bench_in_place_u128_0100_i0`:102 ns = 1600 B `calloc`+`free` 走 `_int_malloc` 慢路徑(~45%)+ 100 個 16 B 元素的標量 xor 迴圈(0.31 ns/元素,store-bound);與 u8 章同一結論,無 std 病灶

- 日期:2026-09-22
- 分析對象:`bench_in_place![...]` 的 `u128_0100_i0`(`vec![0u128; 100]` → `into_iter().enumerate().map(|(i,e)| i as u128 ^ e).collect()`)
- 基線:**101.7 ns**;同尺寸 `_i1` 109.3;`0010_i0/i1` 44.2 / 20.7;`1000_i0/i1` 527 / 715
- 前置:`bench_in_place_xxu8_1000_i1` 章已證 in-place collect 零多餘分配、路徑等價;本章補 16 B 元素與 1600 B 分配檔的畫像

## perf 畫像

| 符號 | 佔比 |
|---|---:|
| bench 閉包(in-place 迴圈 + harness) | 41.1% |
| `_int_malloc` | 22.7% |
| `__memset_generic` | 9.0% |
| `__libc_calloc` | 6.7% |
| `unlink_chunk` / `_int_free_*` / `cfree` | 14.1% |
| **分配器合計** | **~53%** |

IPC 4.14,branch-miss 0.16%。1600 B 超過 tcache 上限(1032 B),i0 與 i1 都進 `_int_malloc`/`_int_free` 慢路徑——所以這一檔 i0/i1 只差 7%(u8 檔 i0 因 calloc 繞過 tcache 慢 83%,u128 1000 檔 i1 因 16 KB memset 反而慢 36%,三檔符號各異,再次證明測的是分配器)。

## 拆分(探針)

| 成分 | ns |
|---|---:|
| body i0 | 83.5 |
| `vec![0u128;100]` + free(calloc 1600 B) | 38.1 |
| body i1 / alloc i1 | 79.6 / 44.2 |
| **迴圈單獨**(復用緩衝) | **31.4 = 0.31 ns/元素 = 0.020 ns/B** |

## 迴圈:標量 `eor` × 2 / 元素,已是 store 吞吐

熱點 `ldur x17,[x13,#-16]` 40% + `ldr`/`eor`/`str`——LLVM **未向量化**(u128 lane 的 `enumerate` 索引向量化需 128-bit 加法鏈,cost model 拒絕),每元素 2 載入 + 1 `eor`(高 64 位與 0 xor 被消掉)+ 2 存儲。手寫對照(輸出逐位相等):

| 形態 | ns |
|---|---:|
| 標量(現狀) | 31.6 |
| portable_simd 2 元素/32 B | 32.3 |
| 只碰低 64 位(stride 16) | 31.1 |

三者相同 → 瓶頸是 100 × 16 B 的讀改寫帶寬(每週期 ~1 個 16 B store),不是 ALU。無頭寸。

## 判斷

1. in-place collect 對 16 B 元素同樣零額外分配、迴圈在存儲吞吐上;**排除**,與 u8 章一致。
2. `bench_in_place_*` 18 項的 i0/i1 差異全部由 glibc 分配尺寸檔位決定(tcache / `_int_malloc` / memset vs calloc),對 in-place 路徑不敏感;要守護該路徑應復用來源緩衝。
> **2026-10-09 修正**:`bench_in_place_recycle` 因鏈中的 `.fuse()` 並未走 in-place 路徑(每輪 1 次分配);可作典範的是 `bench_in_place_zip_recycle`。見 `vec::bench_in_place_*`(22 項全覽)章。

## 復現

```bash
$BIN --bench 'vec::bench_in_place_u128'
perf record $BIN --bench vec::bench_in_place_u128_0100_i0   # 53% 分配器;閉包熱點在 ldur/eor/str
# 探針:/tmp/btree_bench/probe_ip/{u128,u128b}.rs
```

# `iter::bench_next_chunk_filter_even`:比 `filter_map_even` 慢 17% 的原因是元素類型——`Filter` 產出 `&i32`(8 B 指標存儲)而 `FilterMap` 產出 `i32`(4 B);閉包捕獲形態的猜想被證偽,無 std 病灶

- 日期:2026-09-22
- 分析對象:`library/coretests/benches/iter.rs::bench_next_chunk_filter_even`(`[i32;1024].iter().filter(|&&i| i%2==0).next_chunk::<32>()`)
- 基線:**60.4–61.6 ns**(`filter_map_even` 52.6);IPC 4.17,branch-miss 0.00%
> **2026-10-08 修正**:本章把 17% 差距歸因於元素寬度(`&i32` vs `i32`)。元素寬度差確實存在,但改用**條件式 store** 後`filter_even` 61.6 → **52.2**(−15.3%),幾乎追平 `filter_map_even` 的 49.1——即 17% 的大部分來自兩者**共有**的無條件 store,而非元素寬度。見 `iter::bench_next_chunk_*` 章。
- 實現:`library/core/src/iter/adapters/filter.rs` 的 `next_chunk_dropless`(`try_for_each` 閉包內無條件 `array[idx].write(el)`,`idx += pred`)
- 前置:`filter_map_even` 章末尾記了一條線索「`Filter` 版閉包捕獲 `&mut array`/`&mut initialized` 令 LLVM 多了棧往返」——本章驗證該線索

## 熱迴圈(99.6% 單符號)

```asm
38860: ldr  w12, [x10]              ; *el
       str  x10, [x25, x9, lsl #3]  ; array[idx] = el(8 B 指標,無條件寫)
       mvn/and/add x9              ; idx += even
       cmp  x9, #0x20 ; b.cs        ; 50% 樣本:idx 鏈
       subs/add/b.ne                ; 步進
```

10 條/元素,與 `filter_map` 的 9 條同形;差異只有 `str x10`(8 B)對 `str w13`(4 B),以及迴圈前一次 `ldr x10,[sp,#1240]` 重載迭代器指標。

## 四種寫法對照(探針,同語義)

| 形態 | ns |
|---|---:|
| 官方 `filter(even).next_chunk` | 60.4 |
| 官方 `filter_map(even).next_chunk`(`i32` 元素) | 52.6 |
| A:`next_chunk_dropless` 忠實複製(閉包捕獲 `&mut` 局部) | 61.1 |
| B:同邏輯改 Guard 結構體(`FilterMap` 的寫法) | 61.1 |
| C:顯式 `while let` 迴圈,無閉包 | 58.5(−4%) |
| **A 但元素換成 `copied()` 的 `i32`** | **54.4** |

Guard 形態與閉包捕獲形態逐 ns 相同——**前章線索不成立**;把元素從 `&i32` 換成 `i32` 即追平 `filter_map`。差距來自 `Filter<I>::Item = I::Item = &i32`:每個元素無條件寫 8 B 指標而非 4 B 值,64 次存儲多 256 B 寫帶寬,加上收尾 `array_assume_init` 搬運 256 B 而非 128 B。這是 `Filter` 的語義(借用迭代器產出引用),不是實現缺陷。

## 判斷

1. `Filter::next_chunk_dropless` 已是無分支壓縮形態,與 `FilterMap` 版同碼;17% 差距是元素寬度(8 vs 4 B)固有。**排除**。
2. 撤回 `filter_map_even` 章的「閉包捕獲 SROA」線索。
3. 顯式迴圈形 C 有 4%,但 `try_for_each` 形態是為了讓內層迭代器的 `try_fold` 特化(如 `Chain`/`Flatten`)生效,不值得換。

## 復現

```bash
$BIN --bench 'iter::bench_next_chunk_filter'
# 探針:/tmp/btree_bench/probe_nc/fe.rs(A/B/C 三形態 + copied 對照)
```

# `btree::map::find_seq_10_000`:41.7 ns 裡的病灶不在搜索而在**樹形**——升序 `insert` 建出的樹每節點僅 6 鍵(裝填率 55%),同數據 `collect` 建樹 11 鍵/節點時同一 `get` 只要 20 ns;非滿節點的 early-exit 掃描每次 get 3 次分支失誤

- 日期:2026-09-22
- 分析對象:`library/alloctests/benches/btree/map.rs::find_seq_10_000`(`for i in 0..n { map.insert(i,i) }` 建樹,然後 `get(&i)`,`i` 順序遞增取模)
- 基線:**41.3–41.9 ns/iter**(§10+§11 補丁下 41.3,−1%);`find_seq_100` 9.4、`find_rand_10_000` 59.9;IPC 1.90,**branch-miss 6.24%**,L1d miss 極低
- 實現:`BTreeMap::get` → `search_tree` → 每層 `find_key_index`(§10 的整數特化:滿節點無分支全掃,**非滿節點 early-exit**)

## 決定性對比:同一數據、同一查詢序列、只換建樹方式

分配計數(10 000 個 `(usize, usize)`):

| 建樹方式 | 節點數 | 鍵/節點 | 裝填率(cap 11) |
|---|---:|---:|---:|
| 升序 `insert` 迴圈(官方 bench) | **1666** | **6.0** | 55% |
| 降序 `insert` | 1666 | 6.0 | 55% |
| `collect()`(`bulk_build_from_sorted_iter`) | 913 | 11.0 | 100% |

每次順序 `get` 的 PMU(探針,2000 萬次):

| | insert 建樹 | collect 建樹 |
|---|---:|---:|
| 週期 | **116** | **59** |
| 指令 | 227 | 195 |
| 分支 | 52 | 38 |
| **branch-miss** | **2.98** | **0.10** |
| L1d miss | 0.16 | 0.03 |

ns/get 按規模:n=100 8.6 / 8.8;n=1000 15.3 / 14.0;**n=10 000 40.2 / 20.2**;n=100 000 43.1 / 28.1。

## 機理

1. **升序插入的樹形**:`splitpoint` 在節點滿時從中間分裂(`KV_IDX_CENTER`),右側新節點只得 5 鍵;順序插入永遠打在最右葉,於是每個左側節點被凍結在 6 鍵(這是 B-tree 對順序插入的經典行為,`splitpoint` 的 #74834 規則對「插在最右」不做偏置)。樹高 4 層而非 3 層(913 節點 → 3 層可容 11×12² = 1584 節點的葉數;1666 節點需 4 層)。
2. **非滿節點走 early-exit**:§10 只對 `len == CAPACITY` 的節點做無分支掃描,6 鍵節點回到「首個非 Greater 即退出」迴圈。順序 `get` 每次的鍵比上一次大 1,退出位置在節點內逐格右移——每層一次分支失誤,4 層 ≈ 3 次(實測 2.98),每次 ~15 cycles ≈ 45 cycles,正好是 116 − 59 的差。
3. 隨機 `get`(59.9 ns / 69.9 ns 探針)另加 cache miss;`find_seq_100` 兩種樹形同速(單葉)。

## 嘗試:對 ≥4 鍵的非滿節點也走無分支——**大幅回退,已回退**

把 `sub` 拷進 `[T::MAX; CAPACITY]` 緩衝再調 `spec_full_scan`:`find_seq_10_000` 41 → 72 ns(+75%),`find_rand_100` +248%,`range_*` +100%,`insert_seq_100` +153%,`intersection/difference` 系 +210–273%——每次搜索多 88 B 的拷貝 + 外聯調用,遠超它省下的 ~1 次分支失誤。§10 章「非滿節點保持 early-exit」的判斷是對的;無分支掃描只在**不拷貝**(節點本身已滿)時划算。

## 判斷

1. 搜索代碼無可改:滿節點已無分支,非滿節點的無分支化實測是淨損失。**排除**(bench 層面)。
2. 真正的頭寸是**樹形**:順序插入產生 55% 裝填的樹,`get` 慢 2×、記憶體多 45%(342 KB vs 502 KB 但節點數 1666 vs 913——後者每節點滿載)。可探討的 std 方向是 `splitpoint` 對「插入點在最右邊緣」時偏置分裂(如 B*-tree 風格,左節點保留 CAPACITY−1),讓順序插入得到 ~90% 裝填;收益 `find_seq`/`range`/迭代 全部受益,代價是隨機插入的均衡性需重新驗證(#74834 的規則是為隨機/雙向插入調的)。這是獨立於本 bench 的算法改動,列為候選。
3. bench 注記:`find_seq`/`find_rand` 用 `insert` 建樹,測的是「順序插入樹形上的查找」;若用 `collect` 建樹,兩項各自快 2×/1.3×。

## 復現

```bash
$BIN --bench 'btree::map::find_'
# 探針:/tmp/btree_bench/probe_fs/{probe,fill,height,sel}.rs(seq/rand、規模掃描、分配計數、PMU)
# 失敗原型:search.rs 對 len>=4 非滿節點 pad 到 CAPACITY 再無分支掃(已回退)
```

# `str::split_unicode_ascii`:28 ns = 3 次 `core::slice::memchr`(78%),半數樣本在 SWAR 前後的**逐字節前綴/尾巴**迴圈;NEON/無對齊字前綴的替代在短段與長段上勝負互異,無單一形態全贏

- 日期:2026-09-23
- 分析對象:`library/alloctests/benches/str.rs::split_unicode_ascii`(86 B 泰/中/越混合串,`split('V').count()`,'V' 在 33、76 → 三段 33/42/9 B)
- 基線:**28.3 ns/iter**;`split_ascii`(49 B,9 段 ~5 B)53.2、`split_closure` 32.4(逐字符謂詞,無 memchr)
- 實現:`CharSearcher::next_match`(`pattern.rs:441`)→ `memchr::memchr(last_byte)`;`core::slice::memchr`:`<16 B` naive;否則「對齊前綴逐字節 + 對齊 2×usize SWAR + 逐字節尾」(`memchr_aligned`,portable,無 SIMD——`88ac7ace569c` 刪除了 std 的架構特化版本)

## perf 畫像

`memchr_aligned` 78.1%(IPC 4.79,branch-miss 0.00%)。其內部樣本:SWAR 主體 `sub/orr/and/bics` 約 28%,**逐字節前綴 `ldrb/cmp/add` 25.6%、逐字節尾 `ldrb/cmp/add` 20.2%**。原因:第一次 `memchr` 從偏移 0 起,命中後下一段從 34、77 起——**非對齊起點**,前綴要逐字節走 6–7 B 才到 8 B 邊界;SWAR 塊發現有匹配即 `break`,尾巴再逐字節定位(最多 15 B)。三段 33/42/9 B 裡,真正 SWAR 掃過的只有 ~40 B,另 ~40 B 全是字節迴圈。

## 對照(探針,同 3 段;正確性對 n<300 × 8 種對齊 × 全部位置驗證)

| 形態 | 86 B 'V'(本 bench) | 49 B ' '(~5 B 段) | 1160 B ' '(~6 B 段) | 1200 B(20 B 段) | 1580 B(38 B 段) | 4096 B(97 B 段) | 1160 B 無匹配 | 64 KB 無匹配 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 現狀 SWAR | 27.3 | 42.2 | 983 | 530 | 404 | 691 | 95.5 | 5101 |
| libc `memchr` | 16.8 | — | — | — | — | — | — | — |
| 純 NEON 16 B(memchr-crate 形態) | −43% | −0.5% | **+70%** | +19% | +9% | — | −59% | −58% |
| E:現狀 + 尾巴改重疊 SWAR 字 | +2% | **+25%** | +53% | +30% | +28% | — | −31% | — |
| B:全程無對齊 8 B 字 + 重疊尾 | −11% | −33% | — | — | +31% | — | — | — |
| **G:前 16 B 無對齊 SWAR 字(ctz 定位)+ NEON 主體 + 字節尾** | **−38%** | **−10%** | −1% | **+19%** | **+9%** | **−24%** | **−57%** | **−58%** |
| H:G + 32 B 雙向量 OR 歸約 | −36% | −17% | −10% | +28% | +21% | −14% | −62% | −53% |

規律:
- **段長 ≤ 16 B**:命中在首字,無對齊 SWAR 字 + `ctz` 定位一次到位,勝現狀的「字節前綴」(G −10…−38%);
- **段長 16–40 B**:命中落在 NEON 首向量,`cmeq → 取 bitmask(shrn/fmov)→ ctz` 的延遲鏈比 2 個 SWAR 字 + `bics` 分支長,G/H 輸 9–28%;
- **段長 ≥ 97 B 或無匹配**:16 B/迭代 NEON 吞吐是 SWAR 的 2.4×,−24…−62%。

沒有一個形態在三個區間同時不輸;現狀 SWAR 恰好在最常見的「十幾到幾十字節的詞/欄位」區間最優,但在 `contains`/`CStr::from_bytes_with_nul`/長行搜索這類長掃描上留下 2.4× 頭寸。

## 判斷

1. `split_unicode_ascii` 的 28 ns 本身無病灶——是 3 次短段 `memchr` 的字節前綴/尾巴成本,由 bench 的 UTF-8 非對齊斷點造成。
2. **候選**:`core::slice::memchr` 對 AArch64/x86 加 SIMD 主體(NEON `cmeq` / SSE2 `pcmpeqb`),前 16 B 保留無對齊 SWAR 字定位——長掃描 −58%、極短段 −10…−38%,代價是 16–40 B 段 +9–19%。要落地需先決定 std 是否重新接受架構特化 memchr(`88ac7ace569c` 刻意刪除),以及用 `memchr` crate 的實測分佈說服 16–40 B 區間的回退可接受。
3. x86:SSE2 `pcmpeqb + pmovmskb` 取 mask 比 NEON 的 `shrn` 序列短 2–3 cycles,16–40 B 區間的劣勢會小於 AArch64;但同樣需要實測。

## 復現

```bash
$BIN --bench 'str::split'
perf annotate ... memchr_aligned   # 前綴/尾字節迴圈 ≈ 46% 樣本
# 探針:/tmp/btree_bench/probe_mc/{probe,probe2,probe3,probe4,neon,neon2,hyb}.rs(形態 A–H × 8 種輸入分佈)
```

# `slice::sort_unstable_large_strings`:1.0 ms = 13.7 次比較/元素 × 7.5 ns,其中 64% 在 libc `memcmp` 的入口分派——平均只需看 1 個字節就分出勝負;內聯前綴比較在各輸入分佈上互有勝負,無單一形態全贏

- 日期:2026-09-24
- 分析對象:`library/alloctests/benches/slice.rs::sort_unstable_large_strings`(10 000 個 `&str`,長度 1–20 均勻、62 字母表隨機,`v.clone().sort_unstable()`)
- 基線:**1000 µs/iter**(`sort_large_strings` 穩定版 1116);IPC 1.93,**branch-miss 8.8%**(隨機鍵比較排序的固有熵),L1d miss 10.8M/run(指標追 80 KB 外的字串堆)
- 實現:`<[&str]>::sort_unstable` → ipnsort → `&str: Ord` → `<[u8] as SliceOrd>::compare`(`cmp.rs:323`,`UnsignedBytewiseOrd` 特化)→ `compare_bytes` 內建 → **libc `memcmp` 調用**(長度非常量,LLVM 不內聯)

## perf 畫像

| 符號 | 佔比 |
|---|---:|
| libc `memcmp` | **64.2%** |
| ipnsort `quicksort` 分區 | 13.7% |
| `small_sort_general` / `sort4/8_stable` | 18.0% |
| `memcmp@plt` + 其他 | 4.1% |

`memcmp` 內熱點是 `cmp x2,#16; b.cc` 尺寸分派 → `<16` 路徑的 `ldr/ldr/cmp` 與 `tbz` 位檢查鏈——**每次調用 ~4.8 ns 只為比出第 1–2 個字節**。

## 拆分(探針,同分佈 LCG 輸入)

- 比較次數 136 749 = **13.7/元素**;`v.clone()` 2.4 µs;每次比較 7.5 ns。
- 首個不同字節位置:pos0 43.5%、**pos1 49.3%**、pos2+ 7.2%(排序後期相鄰元素共享首字節);`min(len) < 8` 的比較佔 53.9%。
- 對照 `sort_unstable_by_key(|s| s.len())`(純指標搬運地板)42.7 µs——比較函數佔 96%。

## 比較器形態 × 輸入分佈(`sort_unstable_by`,2 次一致,相對現狀 memcmp)

| 輸入(10 k) | memcmp | 首字節內聯→memcmp | u32 BE 探測→memcmp | **u64 BE 探測→memcmp** | u64 探測→memcmp(跳 8) | `<8` 內聯字節迴圈 | `<16` 內聯 | 純字節迴圈 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 隨機 1..20(官方) | 1228 µs | −12% | **−41%** | −5% | +1% | −3% | −23% | −43% |
| 隨機 1..4 | 913 | −4% | +18% | +2% | +4% | −15% | −13% | −27% |
| 隨機 1..100 | 917 | +5% | −43% | −32% | −20% | +3% | +4% | −18% |
| 8 B 共同前綴 | 981 | +7% | +5% | +8% | +42% | +8% | +44% | +44% |
| 32 B 共同前綴 | 986 | +4% | +5% | +6% | +31% | +7% | +7% | +217% |
| 128 B 共同前綴 | 2000 | +1% | +3% | 0% | +7% | +2% | +2% | +318% |

每一種內聯都在某個分佈上回退 5–44%:純字節迴圈對長共同前綴災難性(memcmp 的 16 B/迭代 vs 1 B);前綴探測對短串(1..4)或共同前綴多付一次無用比較;`u32 BE` 對官方輸入 −41% 卻對 1..4 +18%。**`memcmp` 是各分佈的穩健折中**,而 bench 的「1–20 字節、62 字母表隨機」恰是它最吃虧的分佈(幾乎每次都在第 1 字節分出,但要付完整調用 + 尺寸分派)。

## 判斷

1. `[u8]::cmp` → `memcmp` 的選擇正確;bench 的 64% memcmp 開銷是「短隨機字串 + 比較排序」這一特定組合的代價,不是通用病灶。內聯前綴探測沒有無回退的形態。**排除**。
2. 若 `sort` 內部想針對 `&str`/`&[u8]` 鍵做事,正確方向是**排序算法層**的 key-prefix 快取(把每個元素前 8 B 打包成 u64 與指標一起排,如 radix/多鍵 quicksort),而非改比較函數——工程量與 ipnsort 的通用性衝突,不在 std 範圍。
3. x86:`memcmp` 入口同樣有尺寸分派(`cmp $16`),SSE2 `<16` 路徑用 `bsf` 定位差異,單次成本相近;各形態的相對勝負預期一致。

## 復現

```bash
$BIN --bench 'slice::sort.*strings'
perf record $BIN --bench slice::sort_unstable_large_strings   # 64% memcmp,入口 cmp #16 分派
# 探針:/tmp/btree_bench/probe_ss/{probe,probe2,probe3,probe4}.rs(比較計數、首異字節分佈、8 種比較器 × 6 種分佈)
```

# `vec::bench_from_slice_0100`:27 ns = malloc+free 12 ns + 800 B memcpy 12 ns + 2.6 ns 簿記;`to_vec` 的 `T: Copy` 特化已是「with_capacity + copy_nonoverlapping + set_len」,無事

- 日期:2026-09-24
- 分析對象:`library/alloctests/benches/vec.rs::bench_from_slice_0100`(`Vec<usize>` 100 元素 800 B,`src.as_slice().to_vec()`)
- 基線:**27.0 ns/iter**;`_0010` 14.9、`_1000` 155;同尺寸 `from_iter/from_fn/from_elem_0100` 25.1–25.4
- 實現:`<[T]>::to_vec_in` → `ConvertVec` 的 `T: Copy` 特化(`slice.rs:~430`):`Vec::with_capacity_in` → `copy_nonoverlapping` → `set_len`

## perf 畫像

| 符號 | 佔比 |
|---|---:|
| `__memcpy_generic`(800 B) | 44.6% |
| `_int_free` + `malloc` + `cfree` | **43.4%** |
| bench 閉包 + shim | ~10% |

IPC 4.17,branch-miss 0.01%。

## 拆分(探針)

| 成分 | ns |
|---|---:|
| `to_vec()` 100 × usize | 26.6 |
| `with_capacity(100)` + drop(malloc + free) | 12.1 |
| `clear + extend_from_slice` 進復用 Vec(純 memcpy 800 B) | 11.9 |
| ⇒ `to_vec` 本體簿記 | **2.6** |
| `iter().copied().collect()` | 24.2(TrustedLen 路徑,同構) |
| 10 元素 / 1000 元素 | 13.5(alloc 12.3)/ 137(alloc 24.7,memcpy 8 KB ≈ 112) |

分配與拷貝各佔一半,兩者都是 libc;`to_vec` 自身只剩 `with_capacity` 的容量檢查 + `set_len`。

## 判斷

1. `to_vec` 對 `Copy` 類型已是最小形態(一次分配 + 一次 memcpy)。**排除**。
2. 這組 `bench_from_*_0100` 四項全在 25–27 ns,差異僅 ±1 ns,說明 `from_iter`/`from_fn`/`from_elem` 的 TrustedLen 路徑同樣貼近 alloc+copy 地板。
3. 800 B memcpy 12 ns ≈ 67 GB/s、malloc+free 12 ns(tcache 命中),都是平臺常數;x86 同構。

## 復現

```bash
$BIN --bench 'vec::bench_from_slice'
# 探針:/tmp/btree_bench/probe_fsl/probe.rs
```

# `num::bench_*_from_str[_radix_*]`(40 項):測的是 19 個固定短串(平均 2.8 位、半數解析失敗)的混合;每位一次串行 `mul+add`(~1.3 ns/位)是成本模型;8 位 SWAR 十進制快路徑對 ≥8 位串 −57…−75%,但在官方混合上被 ±25% 的佈局噪聲淹沒

- 日期:2026-09-24
- 分析對象:`library/coretests/benches/num/mod.rs` 的 `from_str_bench!`/`from_str_radix_bench!`(8 類型 × {from_str, radix 2/10/16/36} = 40 項):`ASCII_NUMBERS`(19 串)`.cycle().take(5000).filter_map(|s| T::from_str_radix(black_box(s), R).ok()).max()`
- 基線(u64):radix 2 **15.6 µs**、10 **26.3**、16 **36.7**、36 **50.6**;i16 radix 10 35.9;u8 radix 10 22.6。IPC 3.0–4.2,branch-miss ≤0.1%
- 實現:`from_ascii_bytes_radix_impl`(`num/mod.rs:~1790`):符號 → `can_not_overflow`(radix ≤16 且位數 ≤ 2×size)選 unchecked/checked 迴圈 → 每位 `result*radix + to_digit(c)`

## 這組 bench 在測什麼

| radix | 19 串中可解析 | 平均消耗位數 | 每次調用 |
|---|---:|---:|---:|
| 2 | 2("0","1","-1","-0" 類) | 0.3 | 2.7–3.1 ns(幾乎全是首字節失敗) |
| 10 | 10 | 2.8 | 4.9–5.3 ns |
| 16 | 13 | 3.8 | 7.4–7.9 ns |
| 36 | 14 | 3.9 | 9.5–10.1 ns |

harness 地板(`cycle+take+filter_map` 不解析)0.69 ns/call。單串成本(u64,radix 10):1 位 2.1 ns、4 位 4.0、8 位 7.4、12 位 11.7、16 位 16.9、19 位 25.5——**每位 ~1.3 ns 的串行 `mul x18,x18,x12; add` 鏈**(perf 30% 在 `mul`);失敗串 1.5 ns。radix 36 每位 ~2 ns(`to_digit` 的字母分支);radix 2 的可解析串幾乎沒有,量的是符號/首字節錯誤路徑。字面量 radix 與運行時 radix 無差(8.75 vs 8.96 ns)。

## 原型:radix 10、32/64 位整數的 8 位 SWAR 快路徑(樹內,`num/mod.rs` +60 行)

```rust
// 8 個 ASCII 十進制位一次驗證 + 三次乘法合併(經典 SWAR)
fn parse_8_decimal_digits(chunk: u64) -> Option<u64> {
    let v = chunk.wrapping_sub(0x3030_3030_3030_3030);
    if (v | v.wrapping_add(0x7676_7676_7676_7676)) & 0x8080_8080_8080_8080 != 0 { return None; }
    let v = (v * (1 + (10 << 8)) >> 8) & 0x00FF_00FF_00FF_00FF;
    let v = (v * (1 + (100 << 16)) >> 16) & 0x0000_FFFF_0000_FFFF;
    Some(v * (1 + (10000 << 32)) >> 32)
}
// from_ascii_bytes_radix_impl 內:radix == 10 && 4 ≤ size ≤ 8 && digits.len() ≤ 19
//   → 8 位一組累加(≤19 位不可能溢出 u64),尾位標量,最後一次 MAX 比較;>19 位走原 checked 迴圈
```

正確性:12 032 個構造用例(邊界、溢出、符號、非法字符、前導零)逐一與現版比對相等;coretests `num` 1531 + `parse` 166 + alloctests 21+13 全過。

單串(u64,radix 10,5000 次):

| 串 | 現狀 | 原型 | 變化 |
|---|---:|---:|---:|
| `43` | 2.48 ns | 2.20 | −11% |
| `76567` | 5.04 | 3.99 | −21% |
| `987245987`(9 位) | 8.90 | **3.09** | **−65%** |
| 16 位 | 16.6 | **4.17** | **−75%** |
| `18446744073709551615`(20 位,走原路徑) | 26.5 | 11.3 / 31.9* | *官方 harness 下 20 位串 +20%(見下) |
| `abc` | 1.59 | 1.30 | −18% |

官方 harness(3 次交錯,單位 ns/iter):

| bench | 現狀 | 原型 | 變化 | 是否經快路徑 |
|---|---:|---:|---:|---|
| `u64_from_str_radix_10` | 26 240 | **21 500** | **−18%** | 是 |
| `u32_from_str_radix_10` | 24 130 | 22 020 | −9% | 是 |
| `i64_from_str_radix_10` | 29 180 | 28 140 | −4% | 是 |
| `i32_from_str_radix_10` | 29 630 | 28 780 | −3% | 是 |
| `u8_from_str_radix_10` | 22 630 | 17 190 | −24% | **否**(size<4) |
| `i16_from_str_radix_10` | 35 870 | 26 580 | −26% | **否** |
| `u16_from_str_radix_10` | 27 470 | 27 990 | +2% | 否 |
| `i32/i64/u32_from_str_radix_2` | 17 950 / 17 980 / 16 600 | 13 200 / 13 210 / 12 380 | **−27% / −27% / −25%** | **否**(radix 2) |
| `i32_from_str_radix_36` | 39 920 | 42 620 | **+7%** | 否 |
| 其餘 27 項 | — | −4…+1% | 噪聲 | — |

**沒經快路徑的項目擺動 −27…+7%**:原型改變了 `from_ascii_bytes_radix_impl` 的內聯決策(基線二進位裡 i16/i32/i64 各有 3 份外聯副本 2–3 KB,原型後只剩 i32/i64 各 1 份),radix 2/36 與 u8/i16 的變化全部是佈局/內聯效應。真正經快路徑的 u32/u64 −9/−18% 落在同一噪聲帶內——**這組 bench 的 2.8 位平均長度測不出 SWAR 的收益**,收益只在 ≥8 位串上(單串 −65…−75%)。

## 判斷

1. 現實現對這組 bench 的輸入(短串、半數失敗)已接近地板:1–3 位串 2–4 ns,失敗 1.5 ns。**bench 層面排除**。
2. **原型可作候選**:`from_str_radix(_, 10)` 對 ≥8 位十進制串 2–4×,對用戶的 `"1234567890".parse::<u64>()` 這類真實輸入是實打實的;短串不變或略降(`43` −11%);20 位邊界串多付一次長度判斷。落地需:i8/i16/u8/u16 補 `size < 4` 的路徑或明確排除、`i128/u128` 用 u128 累加、`const fn` 下 `from_le_bytes` 讀取的 CTFE 可行性。
3. bench 側:40 項用同一份 19 串混合,radix 2 實際只測失敗路徑、radix 10 平均 2.8 位;若要守護解析吞吐,需加 8/16/19 位的專項輸入。整組對內聯佈局極敏感(同補丁下未觸及項 ±27%),回歸閾值不宜低於 30%。
4. x86:SWAR 同構;`mul` 延遲 3 cycles 與本核相近,每位 ~1 ns 鏈同樣存在。

## 復現

```bash
$BIN --bench 'num::bench_'                      # 40 項
# 探針:/tmp/btree_bench/probe_radix/{probe,lit,swar,mix}.rs(拆分/字面量 radix/SWAR 原型+12k 用例/混合特徵)
# 原型:core/src/num/mod.rs parse_8_decimal_digits + parse_decimal_magnitude + radix==10 快路徑(工作樹,未提交);二進位 /tmp/btree_bench/core_radix/
```

# `vec_deque::bench_try_fold`:`Some(a+b)` 永不短路,LLVM 把 `try_fold` 摺成普通歸約並向量化(64 B/迭代 NEON,0.046 ns/元素),與 `fold`/`sum` 同碼;24% 樣本是 `black_box(Option<i32>)` 的返回值落棧

- 日期:2026-09-24
- 分析對象:`library/alloctests/benches/vec_deque.rs::bench_try_fold`(1000 個 i32 的連續 deque,`ring.iter().try_fold(0, |a, b| Some(a + b))`)
- 基線:**46–52 ns/iter**(早先各次構建間見過 45–77 ns 的擺動——`VecDeque` 章已記為佈局噪聲);IPC 3.80,branch-miss 0.01%
- 實現:`vec_deque::Iter::try_fold` = `i1.try_fold(init)?` 再 `i2.try_fold`(`iter.rs:147`)→ `slice::Iter` 的默認 `try_fold`

## 熱迴圈

```asm
2a63c: ldp  q4, q5, [x9, #-32]
       ldp  q6, q7, [x9], #64        ; 64 B / 迭代(30% 樣本:載入)
       add  v0.4s, v4.4s, v0.4s
       add  v1.4s, v5.4s, v1.4s
       add  v2.4s, v6.4s, v2.4s
       add  v3.4s, v7.4s, v3.4s      ; 4 路累加器
       b.ne 2a63c
       ... addv s0, v0.4s            ; 收攏
2a5e4: stur d0, [x29, #-40]          ; black_box(Option<i32>) 落棧,24% 樣本
```

`R = Option<i32>` 且閉包永遠返回 `Some`,`?` 的短路分支被證明不可達,`try_fold` 退化為 `fold`,slice 部分被 LoopVectorizer 以 4 累加器 × 16 B 展開。4000 B / 46 ns ≈ 87 GB/s,已是 L1 讀帶寬量級。`i2` 為空段,`?` 之後的第二段 `try_fold` 是零成本的空迴圈。

## 對照(探針,同 1000 元素)

| 形態 | ns |
|---|---:|
| 官方 `ring.iter().try_fold(0, \|a,b\| Some(a+b))` | 46.6 |
| `ring.iter().fold(0, \|a,b\| a+b)` | 46.7 |
| `ring.iter().sum::<i32>()` | 46.1 |
| `Vec` 切片 `iter().sum()` / `try_fold(Some)` | 58.4 / 58.3(佈局/對齊差,同碼) |
| 繞回 deque(524+476)`try_fold` | 61.8(兩段各自向量化 + 一次接縫) |
| **真短路**:`try_fold(0, \|a,&b\| a.checked_add(b))` | **525.6(11×)** |

最後一行才是 `try_fold` 區別於 `fold` 的形態:溢出檢查讓每步依賴上一步結果且可能退出,無法向量化,每元素 0.5 ns 的標量鏈——這是語義決定的成本,不是實現缺陷。

## 判斷

1. `VecDeque::Iter::try_fold` 的兩段轉發零開銷,`Some(a+b)` 形態已達向量化帶寬上限。**排除**。
2. bench 注記:這個 bench 實際測的是「不短路的 try_fold」= `sum`,對 `try_fold` 的短路路徑無守護;`VecDeque` 章已記錄其 ±20% 佈局噪聲(`black_box(Option)` 的落棧位置隨構建變)。
3. x86:同構(`paddd` 4 累加器)。

## 復現

```bash
$BIN --bench 'vec_deque::bench_try_fold'
# 探針:/tmp/btree_bench/probe_tf/probe.rs
```

# `str::debug::mostly_unicode`:每個非 ASCII 字符 4 次稀疏表查找(`cn_planes`/`grapheme_extend`/`cf`/`default_ignorable`)佔 85%;BMP 64 碼點塊位圖快路徑令 `mostly_unicode` −87%、`fmt::write_{str,vec}_macro_debug` −71…−75%

- 日期:2026-09-29
- 分析對象:`library/coretests/benches/str/debug.rs` 的 `str::debug::{mostly_unicode, mixed, some_unicode, ascii_only, ascii_escapes}`(64 B 定長串)與 `library/coretests/benches/fmt.rs` 的 `fmt::write_{str,vec}_macro_debug`
- 基線(潔淨協議,單 bench/進程、`--test-threads=1`、3 次中位數):`mostly_unicode` **1806 ns**、`mixed` **1415**、`some_unicode` **293**、`ascii_only` **186**、`ascii_escapes` **300**;`fmt::write_str_macro_debug` **82.0 µs**
- 實現:`impl Debug for str` → 每字符 `escape_debug_ext`(`char/methods.rs`)→ `is_control`/`is_private_use`/`is_whitespace` 為硬編碼或 cascading map,**其餘四個走 skiplist/稀疏表**:`is_grapheme_extender`(383 段)、`is_default_ignorable`(17 段)、`is_format_control`(21 段)、`!is_assigned`(`Cn_Planes_0_3`,730 段)

## 熱點:一個字符要付四次稀疏表查找

| 符號 | 基線佔比 |
|---|---:|
| `unicode_data::cn_planes_0_3::lookup_slow` | 36.1% |
| `unicode_data::grapheme_extend::lookup_slow` | 35.6% |
| `unicode_data::cf::lookup_slow` | 10.9% |
| `unicode_data::default_ignorable_code_point::lookup_slow` | 2.4% |
| **合計** | **~85%** |

`skip_search` 的每次查詢 = `SHORT_OFFSET_RUNS` 二分(`binary_search_by_key`)+ 一段前綴和線性掃描;`mostly_unicode` 的 30 個非 ASCII 字符各付 4 次,單字符 `escape_debug().len()` 實測 **51.2 ns**。這些謂詞只在「是否可打印」的**合取**裏出現,所以有快照的餘地。

## 原型 A:BMP 64 碼點塊「全可打印」位圖(45 行 + 7 行)

一張 `[u64; 16]` = 128 B 的表,位 `b` 表示 64 碼點塊 `U+{(w*64+b)*64}`..`+63` 內**每個**碼點在 `escape_grapheme_extender: true`(最嚴設定)下都可打印——即不是控制/私用/空白/組合附標/預設可忽略/格式控制/未分配。命中即 `EscapeDebug::printable`,跳過全部四個查找。

```rust
// char/methods.rs
#[inline]
pub(crate) fn is_printable_block(self) -> bool {
    let u = self as u32;
    u <= 0xFFFF && PRINTABLE_BLOCKS_BMP[(u >> 12) as usize] >> ((u >> 6) & 63) & 1 != 0
}
// escape_debug_ext 內,ASCII 臂之後:
_ if self.is_printable_block() => EscapeDebug::printable(self),

// fmt/mod.rs,Debug for str 的非可打印分支開頭:
if c.is_printable_block() { printable_range.end += c.len_utf8(); rest = chars.as_str(); continue; }
```

**正確性**:位圖由 std 自身謂詞鏈生成(塊內全體 `escape_debug().len() == 1`),對 BMP 全部 63 360 個非 ASCII 純量做**遍歷式**驗證——三種調用點參數組合(`grapheme_extender` true/false、`char` Debug、`str::escape_debug` 非首字符)**誤判 0**。覆蓋率 74.7%(47 360/63 360);CJK 100%、Hangul 100%、Latin-Ext 100%、Cyrillic 77%、Greek 47%、Devanagari 0%(塊內有組合附標,保守跳過)。非 BMP 永不命中。組合附標、`U+FF9E`/`U+FF9F`、私用區、`U+2028`、`U+FEFF` 等邊界值全部正確走慢路徑。

## Benchmarks(潔淨協議:單 bench/進程、`--test-threads=1`、3 次中位數;`core_base` = HEAD+用戶在飛改動,`core_patch2` = +原型 A,`core_3b2` = +原型 A 與 B)

| benchmark | 基線 | 原型 A | 原型 A+B |
|---|---:|---:|---:|
| `str::debug::mostly_unicode` | 1806.3 ns | **325.6(−82.0%)** | **242.2(−86.6%)** |
| `str::debug::mixed` | 1415.4 | 457.4(−67.7%) | 400.6(−71.7%) |
| `str::debug::some_unicode` | 293.3 | 199.8(−31.9%) | 189.0(−35.6%) |
| `fmt::write_str_macro_debug` | 82.0 µs | 23.9(−70.9%) | **20.8(−74.7%)** |
| `fmt::write_vec_macro_debug` | 87.9 µs | 28.1(−68.0%) | 24.9(−71.7%) |
| `str::debug::ascii_only`(無非 ASCII) | 185.8 | 185.8(+0.0%) | 185.4(−0.2%) |
| `str::debug::ascii_escapes` | 300.2 | 292.1(−2.7%) | 296.2(−1.3%) |

單字符(靜態鏈接,兩次重建後各自測):`escape_debug().len()` Cyrillic **51.2 → 2.09 ns/call(24.5×)**、Latin-1 21.8 → 2.12(10.3×)、`format!("{:?}", c)` Cyrillic 92.6 → 34.2、`write!(reused, "{:?}", c)` 65.8 → 13.5、CJK `format!` 132.1 → 35.8;整串 `format!("{:?}", s)` **1736.7 → 208.6 ns(8.3×)**。

## 回退面與歸因

1. **`ascii_only`/`ascii_escapes` 不動**(設計如此,ASCII 在該臂之前處理),±3% 內。
2. **`char::methods::{bench_to_ascii_uppercase, bench_ascii_char_to_uppercase, bench_to_digit_radix_36}` 表面 −56%/−15%/−31%,但那是代碼佈局偽影**:三者都不調用 `escape_debug_ext`;`core_inert`(常量進樹、臂不進)在潔淨協議下**重現基線**(to_ascii_uppercase 15 615 vs 基線 15 683/15 615),而只有加臂的構建才變化。反彙編顯示 `bench_to_ascii_uppercase` 的閉包在基線裏 `bl` 到一個外聯的 `Map::fold`(1240 B,310 條),在打過補丁的構建裏整條鏈內聯進 `ns_iter_inner`(1152 B,288 條)。**報告時應單獨列出,不計入收益。**
3. 與 `test::black_box` 無關;`fmt::write_str_value`(Display,不走 escape)在 4 次交錯中 +1.4%/−10%,噪聲級。

## 方法論:並行 bench 執行會系統性膨脹數字

同一二進位、同一 bench,只換調用方式:`ascii_only` **單獨跑 186.9 / 185.4 ns,與 4 個同族 bench 同進程跑 264.7 / 263.8 ns(+42%)**。libtest 以線程池並行跑 bench(HW threads 320),同族 bench 互相爭搶;所有早先「一次選多個 bench」的數字因此偏高(例如 `mostly_unicode` 基線 1891 vs 潔淨 1806)。**本節全部數字改採單 bench/進程 + `--test-threads=1`。**

## 判斷

1. 成功:**`Debug for str`/`Debug for char`/`char::escape_debug` 的 BMP 常見文字路徑**從「每字符 4 次稀疏查找」變成「一次位測試」,`mostly_unicode` −87%,`fmt` 的 `{:?}` 宏 −71…−75%,且 ASCII 路徑零影響。覆蓋 74.7% 的 BMP 非 ASCII 純量,零誤判。
2. **落地前必辦**:位圖必須由 `src/tools/unicode-table-generator` 生成(與 `unicode_data.rs` 同源,否則會與屬性表漂移);`Cn_Planes_0_3` 已有「生成器內合成派生屬性」的先例(`main.rs` 的 `load_data()` 內聯構造並帶斷言同步註釋),插入點在 `main.rs:347` 的屬性循環或 `emit_bitset` 旁新增一個 `[u64; 16]` 發射器。另外建議把「位圖為真 ⇒ 可打印」做成生成器內生成的斷言測試。
3. x86 同構:純位測試與表查找的差別與 ISA 無關。

## 復現

```bash
# 潔淨協議(單 bench/進程、單線程),否則數字會被 +42% 膨脹
LD_LIBRARY_PATH=. ./corebenches --bench --exact --test-threads=1 str::debug::mostly_unicode
# 探針:/tmp/btree_bench/probe_dbg/{gen,verify,verify2,charpath2}.rs(位圖生成、遍歷式驗證、字符路徑 A/B)
# 對照二進位:/tmp/btree_bench/{core_base,core_inert,core_patch2,core_3b2}/
```

# `hash::set_ops::set_symmetric_difference`:892 ns = `|A|+|B|` = 110 次 hash+probe(不是 10 次);兩個 `difference` 串接,`large.difference(&small)` 一側佔 91%

- 日期:2026-09-30
- 分析對象:`library/std/benches/hash/set_ops.rs::set_symmetric_difference`(`small(0..10).symmetric_difference(&large(0..100)).count()`)
- 基線(潔淨協議:單 bench/進程、`--test-threads=1`、3 次中位數):**891.8 ns**(897.6 / 887.9 / 890.0)。同族同協議對照:`set_difference` 91.5、`set_is_subset` 92.2、`set_union` 91.7、`set_intersection` 98.3——本項是唯一 ~9.7× 於同族的
- 實現:`SymmetricDifference { iter: self.difference(other).chain(other.difference(self)) }`(`set.rs:722`);`Difference { iter, other }` 的 `next` 逐元素掃描 + `other.contains(elt)`

## 10× 的來源:查找次數是 |A|+|B| 而不是 |A|

按 size 分解(探針,與官方 bench 相同的 `black_box` 形態):

| 成分 | ns |
|---|---:|
| `small.symmetric_difference(&large)` | 924.7 |
| `small.difference(&large)`(10 次查找,全命中→全被濾掉) | 106.9 |
| `large.difference(&small)`(100 次查找) | 813.3 |
| ⇒ 兩半合計 | 920.2 |

`set_difference` 只掃小側(10 次查找);`symmetric_difference` 必須**兩個方向都掃**,因為要輸出 `B \ A`。這是語義要求而非實現缺陷:**`B` 的每個元素至少要被查一次**,否則無法判定它在不在 `A` 中。

size 掃描證實成本線性於 `|A|+|B|`:(10,100) 908 ns、(100,100) 1928、(100,10) 961、(1000,10000) 114.9 µs、(10000,1000) 119.7 µs。注意 (100,100) 比 (10,100) 貴——`|A|` 也進了成本;而不相交情形(`small` vs `1000..1100`)893 ns ≈ 子集情形,因為查找次數同為 110(差別只是輸出 110 個元素而非 90)。

## 每次查找 8.1 ns = 5.9 ns SipHash + ~2 ns probe

- 純雜湊:`hash_one(i32)` = **5.90 ns/op**(110 次/組,消除迴圈開銷)。
- in-situ:813.3 / 100 = **8.13 ns/次** ⇒ probe ≈ 2.2 ns。
- 逐次 `contains`(每次調用間有 `black_box`,含屏障開銷):命中 9.3–10.8 ns、未命中 9.0–10.0 ns;**被探查集合是 10 還是 100 元素只差 ~1 ns**——成本由固定的 SipHash 主導,不是探查長度。
- perf annotate 的指令分佈與此一致:`eor` 48 / `add` 45 / `ror` 16(SipHash-1-3 輪函數)對 `cmeq.8b`(hashbrown 群組比較,佔 24% 樣本)。99.7% 樣本在單一內聯閉包裏。

## 附帶:兩個集合的 `RandomState` 密鑰不同,但不影響正確性

`RandomState::new()` 每次把 thread-local 的 `k0` 加一(`#36481`:防止迭代順序泄露成 DoS 面),所以兩個獨立構造的 `HashSet` 密鑰**不同**。`Difference::next` 的 `self.other.contains(elt)` 用的是 `other` 自己的 hasher,跨集合查找本就自洽。實測 `a.difference(&b).count() == 0`、`a.symmetric_difference(&b).count() == 90`、`a.intersection(&b).count() == 10`,全部正確。

## 判斷

1. 無 std 病灶:892 ns 中約 2/3 是 SipHash——HashDoS 防護的有意代價;其餘是 hashbrown probe。**查找次數 `|A|+|B|` 是 `symmetric_difference` 定義所必需**,不可省。承接 `set_difference` 章的結論,本項**排除**。
2. 落地槓桿在語義而非實現:如不需防護,`FxHashSet`/`ahash` 一行換掉即可(同 `set_difference` 章,−65% 量級)。
3. x86 同構:成本結構(固定雜湊 + 短 probe)與 ISA 無關。

## 復現

```bash
BIN=build/aarch64-unknown-linux-gnu/stage1-std/aarch64-unknown-linux-gnu/dist/build/std/5276defc8035ff52/out/stdbenches-5276defc8035ff52
LD_LIBRARY_PATH=build/aarch64-unknown-linux-gnu/stage1/lib/rustlib/aarch64-unknown-linux-gnu/lib \
  $BIN --bench --test-threads=1 'hash::set_ops::set_symmetric_difference'
# 探針:/tmp/btree_bench/probe_sym/{probe,perop3,perop4,scale,keys}.rs(兩半分解、每次查找定價、size 掃描、密鑰正確性)
```

# `fmt::write_u8_max`:52 ns 全是 `format!` 機制(alloc + grow + free + dispatch),轉換本體不隨位數或型別變;先前「u64::MAX 快 8 ns」只存在於 2026-09-15 的舊 libstd,現版兩者同為 ~52 ns

- 日期:2026-09-30
- 分析對象:`library/coretests/benches/fmt.rs::write_u8_max`(`format!("{}", black_box(u8::MAX))`)與同族 `write_{u8,u64,u128}_{min,max}`
- 基線(潔淨協議:單 bench/進程、`--test-threads=1`、3 次;兩組分列,`core_3b2` = **當前樹**,`core_base` = **舊 libstd**):

| bench | 當前樹 | 舊 libstd(09-15) |
|---|---:|---:|
| `write_u8_max` | 51.5 / 51.5 / 51.6 | 52.5 |
| `write_u8_min` | 53.2 / 53.2 / 53.6 | 54.1 |
| `write_u64_max` | 51.5 / 51.8 / 51.8 | **44.5** |
| `write_u64_min` | 55.6 / 56.0 / 56.3 | 55.4 |
| `write_u128_max` | 62.2 / 62.5 / 62.6 | 63.3 |
| `write_u128_min` | 55.9 / 56.0 / 56.1 | 56.9 |

⇒ 六項中只有 `u64_max` 在舊 libstd 上明顯更快(44.5 vs 51.5–51.8);其餘五項兩組相差 ≤1.0 ns。

- **`write_u64_max` 44.4 ns 只存在於 `/tmp/btree_bench/core_base`(libstd 建於 2026-09-15 10:34,早於 HEAD `d815fc5d1f9`);本次工作階段所建的每一個 libstd(`core_inert` 51.3、`core_patch2` 52.0、`core_3b2` 51.9、以及**移除全部 core 原型後重新構建的對照組** 52.3)上,`u64::MAX` 與 `u8::MAX` 同速。**

## 成本分解(動態鏈接,對齊 harness 形態)

| 形態(u8::MAX,3 位) | ns |
|---|---:|
| `format!("{}", u8::MAX)` | 52.7 |
| `write!` 進復用 String(無分配、無 grow) | **14.1** |
| ⇒ 分配 + grow + free | **38.6** |
| `String::new() + push_str("255") + drop` | 19.2 |
| `String::with_capacity(3) + push_str("255") + drop` | 15.9 |
| `String::with_capacity(0)` 後首次 `push_str`(grow 路徑)vs `with_capacity(8)` 後(直接寫) | 19.8 vs 15.9 |

轉換與格式化本體只佔 14 ns,其中 `push_str` 一次 3 位字串 3.1 ns;**約 38 ns(73%)是 `String` 從空容量起步的分配鏈**(`with_capacity(0)` → 首次 `push_str` 走 `reserve`/`grow_amortized`/`finish_grow` → `malloc`,結束時 `free`)。perf 一致:`malloc` 15.1% + `_int_free` 10.1% + `cfree` 7.8% + `finish_grow` 4.1%,`Display::fmt` 16.3%。DSO 分佈 libstd 58.7% / libc 37.1%。

## 對照:型別、位數都不影響(靜態鏈接探針,固定迭代)

| 形態 | ns |
|---|---:|
| `format!("{}", 255)` 以 u8 / u16 / u32 / u64 / usize | 31.6 / 32.2 / 32.4 / 32.3 / 32.3 |
| `format!("{}", _)` u8 的 0 / 5 / 25 / 255(1–3 位) | 31.3 / 31.0 / 31.2 / 31.6 |
| `format!("{}", _)` u64 的 0 / 255 / `u64::MAX`(1/3/20 位) | 31.4 / 32.3 / 39.5 |

同值不同型別差 ≤0.8 ns;位數只在 20 位(u64::MAX 的 5 個 4 位塊迭代)時 +8 ns。**即 u8 的 3 位輸出與 u64 的 3 位輸出在轉換階段等價,「u8_max 比 u64_max 慢」不可能來自轉換。**

## 8 ns 差距的真相:同指令數、不同前端停頓;觸發點是本倉庫的 §6

固定 2000 萬次迭代的探針,`perf stat`;每個 libstd 5 次取中位數(括號內為 min–max):

| libstd | arm | ns/iter | 指令/迭代 | IPC | **STALL_FE/迭代** |
|---|---|---:|---:|---:|---:|
| `core_base`(09-15,舊) | `u8::MAX` | 52.6 | 496 | 3.26 | 40.3(38.9–41.3) |
| `core_base`(09-15,舊) | `u64::MAX` | **44.7** | 576 | **4.45** | **3.5(3.4–4.2)** |
| `core_inert`(09-29) | `u8::MAX` | 52.5 | 496 | 3.26 | 38.5(37.5–38.9) |
| `core_inert`(09-29) | `u64::MAX` | 51.8 | 576 | 3.84 | 23.8(21.5–24.5) |
| `core_patch2`(09-29) | `u8::MAX` | 51.9 | 496 | 3.30 | 39.0(38.8–39.7) |
| `core_patch2`(09-29) | `u64::MAX` | 51.8 | 576 | 3.83 | 23.0(22.3–25.2) |
| `core_3b2`(09-29,現版) | `u8::MAX` | 52.1 | 496 | 3.28 | 39.7(39.3–41.6) |
| `core_3b2`(09-29,現版) | `u64::MAX` | 51.8 | 576 | 3.82 | 22.5(22.2–23.4) |

**u8 arm 在四個 libstd 上完全一致**(38.5–40.3 停頓/迭代,IPC 3.26–3.30);全部差異都在 u64 arm——舊 libstd 3.5 停頓/迭代、IPC 4.45,其餘三個 22.5–23.8、IPC 3.82–3.84。

**機器碼沒變**:兩個 arm 的指令數逐位元組相同(496 / 576,跨 libstd 亦同);`<u8 as Display>::fmt` 與 `<u64 as Display>::fmt` 的符號大小(160 / 308)、指令條數(40 / 77)、以及逐條指令在四個 libstd 間完全一致——唯一不同的是 1 條 `adrp` 的立即數,兩者都指向**同一張 `DECIMAL_PAIRS` 表**(`.rodata` 內容 md5 相同)。所以純粹是同一段代碼在 `libstd.so` 內的落點差異。

**觸發點定位**(逐檔回退 + 重建,同一固定迭代探針):

| 只回退該檔(其餘保留) | u64::MAX cyc/迭代 | u64 STALL_FE/迭代 |
|---|---:|---:|
| `array_chunks.rs`(§7) | 151.0 | 22.8(**仍慢**) |
| `dragon.rs`(§6) | **126.3** | **4.1(恢復到舊 libstd 水平)**,同構建下 u8 仍 150.1 |
| `bignum.rs`(§6 的輔助函數所在) | 無法單獨回退 | §6 新增的 `Big32x40::mul_small_sub_mul_small` 定義在 `bignum.rs`、由 §6 的 `dragon.rs` 調用;單獨回退 `bignum.rs` 到 `cfbfefd5ffa` 時該函數消失而調用仍在,**編譯失敗**(該次記錄到的 ~0.02 cyc/迭代是殘留二進位,非測量值) |

即 **`dragon.rs` 的 9 位批次 digit 迴圈(§6,2026-09-15 落地)改變了 `libstd.so` 的佈局**,使 `u64::MAX` 的格式化路徑前端停頓從 3.5 漲到 ~22 停頓/迭代。這是佈局副作用,不是算法代價——`<u64 as Display>::fmt` 的機器碼一個位元組都沒動。

## 判斷

1. `write_u8_max` 的 52 ns 與 `write_u64_min`/`u8_min`/`u128_min` 同級,都是 **`format!` 機制的固定成本**(分配鏈 73%、fmt 調度與轉換 27%)。這與 `write_u64_min` 章的結論一致(該章:「min 的機制段 ~48 ns,分配器佔 40%」)。**排除**。
2. **修正前一章**:`write_u64_min` 章「min 比 max 慢 19%」不成立於現版——`u64::MAX` 的 44.8 ns 是舊 libstd 的佈局產物;現版 `{u8,u64}_{min,max}` 四項落在 51.5–56.3 ns 帶內,差異由前端停頓主導而非輸入長度。
3. **`estimated_capacity()=8` 原型不再值得測**:它針對的是那 8 ns 差距(見 `write_u8_min` 章,該原型令 min −47% 但把停頓原樣轉移到 `u64_max`)。現版兩型別同在 ~52 ns,沒有可換取的差距;且分解顯示 grow 只值 ~3.9 ns(19.8 → 15.9),而它會給長輸出的 realloc 添一次分配。
4. x86:分配鏈與 `format!` 調度與 ISA 無關;RSB 深度不同,前端停頓的門檻位置會不同。
5. **副作用,需記錄**:§6(`dragon.rs` 批次 digit)落地後,`u64::MAX` 的 `{}` 格式化從 44.7 ns / IPC 4.45 退化到 51.8 ns / IPC 3.82(停頓 3.5 → 22.5/迭代),`u8::MAX` 不受影響。這不是 §6 的算法代價而是它的佈局成本;若要兩者兼得,需要在改動 flt2dec 後複測整數格式化的前端停頓(本機 5 次中位數可穩定分辨 4 vs 22 停頓/迭代)。

## 復現

```bash
BIN=build/.../corebenches-<hash>
LD_LIBRARY_PATH=<stage1 libdir> $BIN --bench --exact --test-threads=1 fmt::write_u8_max
# 探針:/tmp/btree_bench/probe_fmt2/{dyn,floor,pinned,depth,matrix}.rs(分解、地板、固定迭代+計數、深度掃描、型別×位數矩陣)
# 對照重構:/tmp/btree_bench/controlled_results.txt(移除全部 core 原型後重建,harness 52 ns 復現)
# 量測條件:六項與 pinned 探針數據取得時,另一 checkout(/home/wheel/c00936152/rust)有 7 個對手進程(2 個 rustc 滿載);各項 3 次讀數落在 ±0.3 ns 內且與早先快照交叉一致,故採用;嚴格數字宜在閒置機器複核
```

# `num::int_sqrt::u128_sqrt_*`(20 項):`u128::isqrt` 的 Karatsuba 末端除法是 **128 位軟體除法**,佔 87% 時間;把 `numerator / (2s)` 改寫為 `(numerator >> 1) / s` 使其落進原生 `udiv`——u128 各檔 −18…−27%

- 日期:2026-10-08
- 分析對象:`library/coretests/benches/num/int_sqrt/mod.rs`(u8/u16/u32/u64/u128 × predictable/random/random_small/uniform)
- 實現:`library/core/src/num/imp/int_sqrt.rs`(Karatsuba,Zimmermann 1999):u8 查表 → 每個型別 0–3 層 `middle_stage!` → 一層 `last_stage!`,每層一次除法
- 基線(潔淨協議:單 bench/進程、`--test-threads=1`、5 次中位數,`ns/iter`)

| 型別 | predictable | random | random_small | uniform |
|---|---:|---:|---:|---:|
| u8 | 69.7 | 216.7 | 216.9 | 217.5 |
| u16 | 430.8 | 495.2 | 222.8 | 934.0 |
| u32 | 1780.8 | 1123.6 | 232.0 | 1781.0 |
| u64 | 5791.8 | 1958.5 | 265.1 | 2664.3 |
| u128 | **30879.2** | **4726.6** | 296.6 | **7937.2** |

## 病灶:u128 末端除法無法用硬體

`perf` 對 `u128_sqrt_uniform` 的取樣:

```text
74.53%  compiler_builtins::int::specialized_div_rem::u128_div_rem
12.30%  __udivti3
11.04%  core::num::imp::int_sqrt
```

87% 在 `compiler_builtins` 的長除法。原因是 `last_stage!` 的除法:

```rust
let numerator = (($r as $ty) << QUARTER_BITS) | (lo >> QUARTER_BITS);
let denominator = ($s as $ty) << 1;
let q = numerator / denominator;      // u128: numerator 可達 65 位 → 軟體除法
```

`middle_stage!`(u64 層)輸出滿足 `r < 2·s < 2^33`,`lo >> QUARTER_BITS < 2^32`,故 **`numerator < 2^65`**、`denominator = 2s < 2^33`。AArch64 的 `udiv` 只吃 64 位,65/33 的除法只能走 `__udivti3`(Knuth D 長除法,逐位元試除)。

**實測上界**(50.3M 輸入:`top 24 位` 窮舉 × 3 種低位填充,加上 `u128::MAX-i`、`2^64+i` 等邊界)——上界成立且保守:

```text
max numerator   = 36893488143124135935  (65 位;遠小於 2^66)
max r           = 8589934590 (33 位)    max s = 4294967295 (32 位)
numerator < 2^65 : true                 numerator>>1 fits u64 : true
```

## 修復:先折半,再除以 `s`

嵌套除法恆等式 `floor(floor(a/2)/b) == floor(a/(2b))`(整數、`b ≥ 1`)給出

```rust
// numerator / (2 * s)  等價於  (numerator >> 1) / s
let q = ((numerator >> 1) as u64) / (s as u64);   // 一次原生 udiv
```

折半後 `numerator >> 1 < 2^64`,除法落進硬體 `udiv`。**必須逐型別區分**:u16/u32/u64 的 `numerator` 本來就 ≤ 型別寬度,已是硬體除法,加一次移位純屬多餘——實驗證實對所有型別一律改寫會讓 **u16/u32 回退 3–5%**(見下)。

## A/B(pre-patch 與 post-patch 二進位,交錯 5 次取中位數)

| bench | 修復前 | 修復後 | 變化 |
|---|---:|---:|---:|
| `u128_sqrt_uniform` | 7937.2 | 5817.7 | **−26.7%** |
| `u128_sqrt_predictable` | 30879.2 | 25074.0 | **−18.8%** |
| `u128_sqrt_random` | 4726.6 | 3855.4 | **−18.4%** |
| `u128_sqrt_random_small` | 296.6 | 300.2 | +1.2%(雜訊) |
| `u16/u32/u8` 共 12 檔 | — | — | **±0.2%** |
| `u64_sqrt_{random,random_small,uniform}` | — | — | **±0.2%** |
| `u64_sqrt_predictable` | 5792 | 7380 | **+27.4%(佈局,見下)** |
| 對照:`int_log::u64_log10_random`、`int_bits::u16::constant::deposit_bits`、`int_pow::pow_{variable,m7,m8}` | — | — | **±0.1%** |

單獨量末端那一次除法(同一探針、同一輸入集,u128 前綴預先算好只計時除法):

```text
u128: numerator / (2s)   [libcall]   11.117 ns/div
u128: (numerator>>1) / s [native]     4.617 ns/div      → 2.4×
u64 : numerator / (2s)                2.072 ns/div      → 兩式等價,故不改
u64 : (numerator>>1) / s              2.071 ns/div
```

移除了 2 處 `__udivti3` 引用(base 二進位 `int_sqrt` 區有 2 處、修復後 0 處)。

### `u64_sqrt_predictable` 的 +27% 是佈局,不是本次改動的代價

u64 並不走窄化路徑(見上表「u64 兩式等價」),其 `u64::isqrt` 機器碼在兩份二進位中**逐指令相同**:

```text
base ns_iter_inner u64_predictable: 173 insns   min: 173 insns   僅 2 行不同:
  [11] adrp x10, <anon>+0x5bd8      →  adrp x10, <anon>+0x5c58
  [12] add  x10, x10, #0x831        →  add  x10, x10, #0x7b1
```

兩行合起來的**有效位址相同**(`0x5bd8 + 0x831 == 0x5c58 + 0x7b1 == 0x6409`),差別只是 `adrp` 的 4 KB 分頁基準寫法;故這是「同一段程式碼被放到不同位址」。

排除建置彩票:以**完全相同的(最小補丁)原始碼**再獨立建置兩次,`u64_sqrt_predictable` 得 7383.7 / 7393.0,與首次的 7376.8 一致;base 則穩定在 5792(`u128_sqrt_uniform` 三次建置為 5819.7/5819.9/5821.2,亦一致)。即該位移是補丁造成的**確定性**佈局效應,而非構建間隨機。

判定:u128 的 −18…−27% 是演算法層(移除 libcall),而 u64 的 +27% 是同一段程式碼的落點效應——與 `fmt::write_u8_max` 章的機制同類。若要入上游,需在 PR 中說明此項為佈局偽影,或以 `-Z` 佈局微調/對齊消弭。

## 正確性

- **恆等式**:32 768 組 u128 輸入上 `num/(2s)` 與 `(num>>1)/s` 逐位元相同;邊界展開亦同。
- **對照原型**:21 000 000+ 輸入(u128 全範圍隨機、`u128::MAX-i`、`2^64+i`、完全平方 ±1)與**未修改的公式**逐一比對,0 不符;u16/u32 以 `wide` 形式同樣 0 不符。
- **不變量**:50.3M 輸入上 `r ≥ 2^33` 0 次、`numerator ≥ 2^65` 0 次。
- `./x test library/core --stage 1 --test-args isqrt` 通過。

## 一併排除:u64 的 f64 播種(可行但用不了)

`(x as f64).sqrt() as u64` 對 u64 **精確到 ±1 以內**(15M 案例,最大誤差 1),加兩次比較修正即可,`u64::isqrt` 從 9.72 → **2.62 ns**(3.7×)。但 **`isqrt` 是 `const fn`(`rustc_const_stable since 1.84.0`),而 `intrinsics::sqrtf64` 不是 const**——`error: cannot call non-const intrinsic sqrtf64 in constant functions`。故本路徑在 `core` 內不可用,記為否決。

u128 的 f64 播種同樣不可行且有額外問題:u128→f64 丟 75 位尾數,sqrt 後整數結果誤差最大達 **1726**(需修正迴圈);且 `wrapping_mul` 在 y 接近 2^64 時會回繞,使比較失去單調性(探針曾因此不收斂)。

## 系列其餘:無可行動項

1. **`int_pow`(7 項)排除**。`pow` ≡ `wrapping_pow`(4.22 ns/次,release 下 `overflow_checks()` 為假,不走 `strict_pow`);`overflowing_pow`/`checked_pow`/`saturating_pow` 5.6–6.4 ns/次,差額即每次乘法的溢位簿記。`pow_m8`(2.18)比 `pow_m7`(4.16)快 2× 是因為 `-8 = -2^3`:靜態已知的底數命中 `overflowing_pow` 開頭的「底數為 2 的冪」改基分支(O(1) 位移),`-7` 不命中。熱點是 `umulh/mul` + 指數位迴圈分支(`pow_variable` 的 `umulh` 佔 14.3%、`tbz` 10.6%),即平方乘的固有成本。**試把 `wrapping_pow` 改寫成不追蹤溢位的純平方乘反而更慢**(5.02 vs 4.48 ns)。
2. **`int_bits`(30 項)**:u16 `constant::deposit_bits` 已有專章。補齊全部型別的**每元素**成本(iterations = 1024/size_of,故原始 `ns/iter` 不可跨型別比較):

   | 型別 | deposit const | invariant | variable | extract const | invariant | variable |
   |---|---:|---:|---:|---:|---:|---:|
   | u8 | 0.060 | 0.110 | 0.468 | 0.100 | 0.106 | 0.399 |
   | u16 | 0.210 | 0.352 | 1.601 | 0.294 | 0.345 | 1.354 |
   | u32 | 0.655 | 0.932 | 5.024 | 0.789 | 0.894 | 4.000 |
   | u64 | 1.747 | 2.355 | 14.049 | 2.028 | 2.257 | 11.446 |
   | u128 | 3.287 | 6.553 | 28.734 | 5.183 | 6.432 | 23.281 |

   `variable` 相對 `constant` 為 **4.0–8.7×**(deposit 7.6–8.7×、extract 4.0–5.7×),正是每元素重算 `prepare()` 的代價;`invariant` 1.05–2.0×。與既有章節結論一致,**排除**(常量掩碼已達 NEON 吞吐;可變掩碼的槓桿是 x86/SVE2 的單指令 `pdep`/`BDEP`)。
3. **`int_log`(30 項)重測一致**:本次 u64 `ilog(b)` random 5.24 ns/調用 vs 專章 5.34;u128 12.64 vs 12.55(差 <1%)。既有 `int_log` 章(2026-08-13)結論「無可行動熱點」維持。

## 判斷

1. **可落地**:`int_sqrt` 末端除法窄化——語義零改動、u128 各檔 −18…−27%、其餘 19 檔與無關 bench 均在 ±0.2% 內(`u64_sqrt_predictable` 例外,為佈局偽影,見上)。改動僅 `last_stage!` 巨集加一個型別參數 + 一個布林,四處呼叫各帶自己的 `div_ty`。
2. 關鍵是**只改 u128**。對稱地改所有型別會讓 u16/u32 回退 3–5%(多出的 `>> 1` 與型別轉換);u64 因兩式等價可改可不改,故一律保持原式。
3. 更深的槓桿是**演算法層**:Karatsuba 末端那一次 65/33 除法可用「預算倒數 + 2 次乘法」的 Barrett/Möller–Granlund 形態替代,但那是 `u128` 上的 `mul` 鏈,需另測;本次的窄化是零風險的第一步。
4. x86_64 同構:65 位除以 33 位同樣落入 `__udivti3`(GCC/LLVM 對 u128 除法一律 libcall),`div` 指令亦只到 64 位。收益預期相同或更大(`div r64` 較 AArch64 `udiv` 慢,libcall 差距更明顯)。

## 復現

```bash
# 量測(交替 A/B,單 bench/進程)
cd /tmp/btree_bench/isqrt_base  && LD_LIBRARY_PATH=. ./corebenches --bench --exact --test-threads=1 num::int_sqrt::u128_sqrt_uniform
cd /tmp/btree_bench/isqrt_min   && LD_LIBRARY_PATH=. ./corebenches --bench --exact --test-threads=1 num::int_sqrt::u128_sqrt_uniform
# 探針:/tmp/btree_bench/probe_ls2(窄化正確性+計時)、probe_inv(不變量 50.3M 掃描)、
#      probe_div_ab(除法形狀 A/B)、probe_seed(f64 播種誤差)、probe_verify(21M 對照)、probe_fisqrt(u64 f64 播種)
# 二進位快照:isqrt_base / isqrt_patch / isqrt_min(各含 corebenches + libstd-*.so)
# 樹內改動:library/core/src/num/imp/int_sqrt.rs(未提交)
```

# `iter::bench_next_chunk_*`(9 項,另新增 3 項):`Filter`/`FilterMap` 的 `next_chunk` 壓縮迴圈「無條件 store」在稀疏謂詞下是純浪費——改為條件式 store 後 `mostly_false` −38%/−41%、`filter_even` −15%;既有的「已貼近掃描地板」結論需修正

- 日期:2026-10-08
- 分析對象:`library/coretests/benches/iter.rs` 的 `bench_next_chunk_*` 共 9 項,以及為覆蓋「不可預測謂詞」而新增的 3 項(見下)
- 實現:`Filter::next_chunk_dropless`(`filter.rs`)、`FilterMap::next_chunk`(`filter_map.rs`)、`Copied::next_chunk`(`copied.rs`,`slice::Iter` 特化)、`ArrayChunks` 的 `SpecFold` TRA 特化(`array_chunks.rs`)

## 基線(潔淨協議:單 bench/進程、`--test-threads=1`;A/B 交錯 5–8 次取中位數)

| benchmark | ns/iter | 掃描元素 | 命中 |
|---|---:|---:|---:|
| `next_chunk_copied`(`Copied` + `slice::Iter` 特化) | 37.6 | — | — |
| `next_chunk_trusted_random_access`(`ArrayChunks` TRA) | 37.7 | — | — |
| `next_chunk_trusted_random_access_runtime_len` | 36.0 | — | — |
| `next_chunk_filter_predictably_true`(`i < 100`) | 34.3 | 32 | 32 |
| `next_chunk_filter_map_predictably_true` | 28.3 | 32 | 32 |
| `next_chunk_filter_even`(`i % 2 == 0`) | 61.6 | 63 | 32 |
| `next_chunk_filter_map_even` | 49.1 | 63 | 32 |
| `next_chunk_filter_mostly_false`(`i > 900`) | **639.7** | 933 | 32 |
| `next_chunk_filter_map_mostly_false` | **601.3** | 933 | 32 |

## 病灶:壓縮迴圈對每個「被掃過」的元素都寫一次

`Filter::next_chunk_dropless` 與 `FilterMap::next_chunk` 的內層迴圈刻意做成無分支:索引用 `cinc`/`csinc` 前進,**store 無條件執行**,被謂詞濾掉的元素也照寫一次。原始註解(`2be2d77c5017`,2024-06-24)的理由是:

> branchless index update combined with unconditionally copying the value even when it is filtered reduces branching and dependencies in the loop.

反彙編證實兩份二進位只差這一段(`filter_mostly_false` 的內層迴圈):

```asm
# 現狀(branchless):每元素都 store,idx 由 cinc 前進
38b04: ldr  w12, [x10]
38b08: str  x10, [x19, x9, lsl #3]     ; array[idx] = el —— 無條件
38b0c: cmp  w12, #0x384                ; i > 900 ...
38b10: cinc x9, x9, gt                 ; idx += pred(無分支)
38b14: cmp  x9, #0x20
38b18: b.cs <full>
38b1c: subs x11, x11, #0x4
38b20: add  x10, x10, #0x4
38b24: b.ne 38b04

# 原型(branched):只有命中才 store
38b10: ldr  w12, [x10]
38b14: cmp  w12, #0x385
38b18: b.lt 38b04                      ; 未命中 → 直接下一個,不 store
38b1c: cmp  x9, #0x1e
38b20: str  x10, [x19, x9, lsl #3]     ; 僅命中時
38b24: b.ls 38b00
```

代價差異是**掃描長度的函數**:`i % 2 == 0` 掃 63 個元素,`i > 900` 掃 933 個——兩者都只想要 32 個結果。無條件 store 讓前者多寫 31 次、後者多寫 **901 次(29×)**。此外 store 的位址依賴 `idx`,而 `idx += pred` 是迴圈攜帶依賴,未命中時本可整條鏈不動。

## 原型與 A/B

原型把 store 移進條件內(索引仍只在命中時前進,語義等價)。兩份二進位交錯量測:

| benchmark | 現狀(無條件 store) | 原型(條件 store) | 變化 |
|---|---:|---:|---:|
| `filter_map_mostly_false` | 601.3 | 354.8 | **−41.0%** |
| `filter_mostly_false` | 639.7 | 398.1 | **−37.8%** |
| `filter_map_shuffled_12pct`(新增) | 198.6 | 130.5 | **−34.3%** |
| `filter_shuffled_12pct`(新增) | 194.2 | 157.6 | **−18.9%** |
| `filter_even` | 61.6 | 52.2 | **−15.3%** |
| `filter_shuffled_50pct`(新增) | 68.8 | 62.3 | −9.5% |
| `filter_predictably_true` | 34.3 | 31.4 | −8.5% |
| `filter_map_even` | 49.1 | 50.7 | **+3.3%** |
| `filter_map_predictably_true` | 28.3 | 28.6 | +1.0% |
| `next_chunk_copied` | 37.6 | 37.6 | −0.0% |
| `trusted_random_access`(TRA) | 37.7 | 37.7 | −0.0% |
| `trusted_random_access_runtime_len` | 36.0 | 36.0 | −0.1% |

**歸因(拆檔 A/B,`filter.rs` 與 `filter_map.rs` 各自單獨打)**:得到乾淨的 2×2 塊狀結構——打 `filter.rs` 只動 `filter::*`、`filter_map::*` 完全不動(601.3→601.3、49.1→49.1),打 `filter_map.rs` 反之(61.6→61.6、639.7→639.6),兩者合打等於各自效果之和。**排除了全域佈局偽影**(對照組 `copied`/TRA×2 在四欄中恆為 37.6/37.7/36.0)。

**新增 3 項覆蓋不可預測謂詞**。原始註解主張無分支在**分支不可預測**時有利,而既有 9 項全是可預測輸入(`i<100` 前綴命中、`i>900` 後綴命中、`i%2` 規則週期),沒有任何一項驗證過該主張。故新增:同值同謂詞但**先洗牌**的 3 項(`bench_next_chunk_filter_shuffled_12pct` / `_50pct` / `filter_map_shuffled_12pct`)。結果:不可預測情形**原型同樣勝出**(−18.9% / −9.5% / −34.3%)——原註解的立論未被實測支持。

**混合形態否決**:保留無分支索引前進、只把 store 放進 `if val.is_some()` 的混合版**更慢**(`filter_map_even` 49.1 → 72.8、`mostly_false` 601.3 → 666.6)。該輪中未觸及的 `filter_even` 在三欄恆為 61.6,再次確認無佈局效應。

## 正確性

- **差分測試 1194 組**對照現狀與原型:`Filter` 掃 N ∈ {1..64} × 密度 k ∈ {1,2,3,4,5,7,8,16,32} × 來源長度 ∈ {0,1,4,17,32,33,100,1024}(936 組)、`FilterMap` i32(240 組)、`FilterMap` **具 drop 的 `String`**(18 組)——**0 不符**。
- **panic 安全**:閉包在第 3 個命中元素 panic(N 未填滿),`Guard` 正確 drop 部分初始化的陣列,無洩漏/重複釋放。
- `./x test library/core --test-args next_chunk` 與 `--test-args filter` 全通過(含 `test_next_chunk_does_not_leak`)。

## 與既有兩章的矛盾(需修正)

1. `iter::bench_next_chunk_filter_map_even` 章(2026-09-17)結論「已是無分支壓縮迴圈,~2 cycles/元素貼近掃描地板」——**不成立**:該迴圈並非地板,條件式 store 讓 `filter_even` −15.3%、`mostly_false` 家族 −38…−41%。
2. `iter::bench_next_chunk_filter_even` 章(2026-09-22)結論「比 `filter_map_even` 慢 17% 是元素類型所致」——**部分成立但結論要改**:`&i32`(8 B)vs `i32`(4 B)的寬度差確實存在,但改用條件式 store 後 `filter_even` 61.6 → 52.2,幾乎追平 `filter_map_even` 的 49.1,17% 差距的大部分來自兩者**共有的**無條件 store,而非元素寬度。

## 判斷

1. **可落地**:把 `next_chunk_dropless` 與 `FilterMap::next_chunk` 的 store 改為條件式。收益 −8…−41%,涵蓋稀疏與不可預測兩種輸入;代價是 `filter_map_even` +3.3% 與 `filter_map_predictably_true` +1.0% 兩項小幅回退。
2. 兩項回退都在「謂詞便宜且命中率 50%」的角落,而 `filter_map_even` 的 +3.3% 恰是新增的分支在**完美可預測**時的邊際成本;`filter_even` 同形態卻是 −15.3%(元素指標較寬,省下的 store 更值錢)。是否接受這 3.3% 取決於對 `filter_map` + 規則週期謂詞的權重。
3. **原註解的立論應更新**:「無分支減少分支與依賴」在 2024 年寫下時未附數據;本次在可預測、稀疏、洗牌三類輸入上都測到分支勝出。
4. 其餘 3 項(`copied`、TRA×2)不受影響,`ArrayChunks` 的 TRA `SpecFold` 計數迴圈本來就是正確形態,無事。
5. x86 同構:無條件 store 的浪費是 ISA 無關的(多出的 store 與迴圈攜帶依賴);x86 的 store-to-load forwarding 與更深的 store buffer 可能讓該項差距略小,但方向不變。

## 復現

```bash
# 交錯 A/B(單 bench/進程)
cd /tmp/btree_bench/nc2_base   && LD_LIBRARY_PATH=. ./corebenches --bench --exact --test-threads=1 iter::bench_next_chunk_filter_mostly_false
cd /tmp/btree_bench/nc2_branch && LD_LIBRARY_PATH=. ./corebenches --bench --exact --test-threads=1 iter::bench_next_chunk_filter_mostly_false
# 二進位快照:nc2_base/nc2_branch(兩檔合打)、nc3_filt/nc3_fm(拆檔歸因)、nc4_hy(混合形態)
# 原型補丁:/tmp/btree_bench/patch2.py、patch3.py(混合);備份 filter.rs.orig / filter_map.rs.orig
# 差分測試:/tmp/btree_bench/probe_diff/probe.rs(1194 組 + panic 安全)
# bench 新增:library/coretests/benches/iter.rs 的 3 項 shuffled(工作樹,未提交)
# 註:探針 probe_nc / probe_pred / probe_density 的閉包形態與真實 codegen 不符,
#     對可預測謂詞給出與 harness 相反的符號,故本篇只採 harness A/B 數據
```

# `vec::bench_in_place_*`(22 項全覽):18 項數值格的 i0/i1 符號由「分配位元組數是否超過 tcache」決定,in-place collect 本身在每一格都生效;但 `bench_in_place_recycle` 因 `.fuse()` 自 2021 年起**並未 in-place**(每輪 1 次分配)——為 `Fuse` 補回 `InPlaceIterable` 後 1 → 0 次分配

- 日期:2026-10-09
- 分析對象:`library/alloctests/benches/vec.rs` 的 `bench_in_place![...]` 18 項(u8/u32/u128 × 10/100/1000 × `i0`/`i1`)與 `bench_in_place_{recycle,zip_recycle,zip_iter_mut,collect_droppable}`
- 前置:`xxu8_1000_i1`(2026-09-16)、`u128_0100_i0`(09-22)、`zip_iter_mut`、`zip_recycle` 四章;本章補齊其餘 16 格與兩項未分析的 bench,並修正其中兩處結論
- 環境:glibc 2.38;官方 harness 單 bench/進程、`--test-threads=1`、5–9 次中位數

## 18 格基線:符號在 1032 B 翻轉

| 型別 | n | 位元組 | i0(`calloc`) | i1(`malloc`+填充) | i1 相對 i0 | 分配檔位 |
|---|---:|---:|---:|---:|---:|---|
| u8 | 10 | 10 | 23.6 | 17.4 | −26% | tcache |
| u8 | 100 | 100 | 25.8 | 18.4 | −29% | tcache |
| u8 | 1000 | 1000 | 96.6 | 60.0 | −38% | tcache |
| u32 | 10 | 40 | 23.9 | 17.4 | −27% | tcache |
| u32 | 100 | 400 | 63.7 | 28.4 | −55% | tcache |
| u32 | 1000 | 4000 | 159.7 | 176.9 | **+11%** | 超過 |
| u128 | 10 | 160 | 64.5 | 17.5 | −73% | tcache |
| u128 | 100 | 1600 | 87.1 | 104.0 | **+19%** | 超過 |
| u128 | 1000 | 16000 | 543.2 | 721.4 | **+33%** | 超過 |

六格 tcache 內 i0 較慢,三格超過後 i0 較快,無例外。細掃(探針,每 rep 內交錯)把翻轉點定在**請求 1032 → 1040 B 之間**,且三種型別都按位元組而非元素數翻轉:u8 n=1032/1040、u32 n=258/266、u128 n=64/65 的「僅分配+釋放」分別是 −22%/+9%、−21%/+14%、−14%/+12%。

## 這是 glibc 的曲線,與 Rust 無關

純 C 對照(`calloc(n)+free` 對 `malloc(n)+memset+free`,交錯 9 次中位數):

| 請求 B | calloc | malloc+memset | calloc 相對 |
|---:|---:|---:|---:|
| 64 | 16.6 | 11.0 | +51% |
| 160 | 26.6 | 11.9 | **+124%** |
| 400 | 28.0 | 14.0 | +100% |
| 1032 | 31.1 | 23.0 | +35% |
| 1040 | 30.4 | 33.9 | −10% |
| 4096 | 47.0 | 74.8 | −37% |
| 16384 | 123.8 | 239.9 | −48% |

`calloc` 自身的成本對尺寸幾乎平坦(1000 → 1040 B:31.1 → 30.4 ns),翻轉完全來自 `malloc` 一側在 1040 B 掉出 tcache(23.0 → 33.9 ns)。即:tcache 內 `malloc` 走快路徑而 `calloc` 不走,所以 i0 慢;超過後兩者都走 `_int_malloc`,而 `calloc` 省掉一次外部填充,所以 i0 快。160–400 B 處 `calloc` 的額外台階(16.6 → 26.6 ns)與 fastbin 上限的位置相符,這一點是依曲線形狀的推論,未讀 glibc 原始碼驗證。

由此關閉 09-16 章留下的未解項:該章基線裡 u32 `1000_i0/i1` = 178.6 / 209.9(i1 較慢)與其「i0 慢」的主題相反而未解釋——4000 B 已超過 tcache,i1 較慢是正確行為。

**絕對數字依賴進程的堆狀態**:`u128_0010_i0` 在 harness 內 64.7 ns,同形態獨立進程 34.0 ns,C 端 `calloc(160)` 26.6 ns。同一格在不同進程差 2×,i1 則一致(17.5 / 16.6)。tcache 內 i0 各格不宜作跨構建比較。

## in-place collect 在全部數值格生效

計數分配器:每輪恰 1 次分配(i0 為 `alloc_zeroed`,i1 為 `alloc`)、0 次 `realloc`、1 次釋放,各尺寸皆同。`alloc_zeroed` 在 aarch64 上 `MIN_ALIGN = 16`,故 u128(對齊 16)同樣走 `libc::calloc`。扣掉分配後的迴圈體 i0 與 i1 相同(u8 n=4096:119.3 對 118.5 ns)。

i1 的填充方式因型別而異:`vec![1u8; n]` 編成 `bl memset`;`vec![1u128; n]` 是出線的 `SpecFromElem::from_elem` 逐元素寫入。`u128_1000` 的 DSO 切分因此不同——i0 有 25% 在 libc(`__memset_generic` 16%,`calloc` 內部清零),i1 有 94% 在 bench 本體(填充迴圈 + xor 迴圈)。

## `bench_in_place_collect_droppable`(1115 ns):in-place 生效,一半是 `clone`

每輪 1 次分配,來自 `v.clone()`;`skip(100).enumerate().map().collect()` 沒有第二次分配(`Skip` 具備 `InPlaceIterable` + `SourceIter`)。拆分:`v.clone()` + drop 單獨 514 ns,完整形態 1111 ns,管線與 1000 次 `Drop`(各含一次 `black_box`)約 597 ns。無病灶。

## `bench_in_place_recycle`:名為 in-place,實際每輪分配

鏈是 `into_iter().enumerate().map().fuse().collect()`,22 項中唯一含 `.fuse()`。計數分配器:

| 形態 | 分配/輪 | 釋放/輪 |
|---|---:|---:|
| 官方原樣(含 `.fuse()`) | **1.000** | 1.000 |
| 同鏈去掉 `.fuse()` | 0.000 | 0.000 |
| `bench_in_place_zip_recycle` | 0.000 | 0.000 |

原因在 `library/core/src/iter/adapters/fuse.rs`:`Fuse` 有 `SourceIter` 而沒有 `InPlaceIterable`,`collect` 退回 `SpecFromIterNested`(新分配 + 複製)。歷史:

- 2019-11-20 `8ac96e6a9832` 加入此 bench(含 `.fuse()`);2019-11-23 `21a17d105c9c` 為 `Fuse` 實作 `SourceIter` + `InPlaceIterable`。
- 2021-06-30 `6f5e933adb57`(修 rust-lang/rust#85863:特化的 `Fuse` 仍可能為 `None`)把兩個 impl 一併刪除。
- 2023-04-15 `3ca6bb0b44c3` 以 `I: SourceIter + TrustedFused` 加回 `SourceIter`(註解:供 `Flatten` 使用),`InPlaceIterable` 未加回。

所以這個 bench 自 2021-06 起不再走 in-place 路徑,而且**時間上看不出來**:官方 harness 內含 `.fuse()` 與去掉後的時間地板相同(約 185 ns,兩者各 15 次的最小值 184.3 / 183.8),`perf` 卻顯示前者 16.4% 在 libc(`_int_malloc` 8.1%)、後者 0%。8000 B 的分配+釋放成本恰被「讀舊寫新」迴圈較快所抵消。獨立進程探針則有差:282 對 248 ns(−12%)。

### 原型:為 `Fuse` 補回 `InPlaceIterable`

```rust
unsafe impl<I: InPlaceIterable> InPlaceIterable for Fuse<I> {
    const EXPAND_BY: Option<NonZero<usize>> = I::EXPAND_BY;
    const MERGE_BY: Option<NonZero<usize>> = I::MERGE_BY;
}
```

`Fuse` 原樣轉發內層每個元素;in-place collect 另需 `SourceIter`,而它只對 `I: TrustedFused` 實作(`iter` 不會被設成 `None`),2021 年的健全性問題由該約束擋住。結果:

| | 現狀 | 原型 |
|---|---:|---:|
| 含 `.fuse()` 的鏈,分配/輪 | 1.000 | **0.000** |
| 獨立探針(1000 × usize) | 282–285 ns | **248 ns(−12%)**,與無 `.fuse()` 相同 |

測試:`coretests fuse` 23、`alloctests in_place` 26、`from_iter` 28、`coretests flatten` 15,全過。上游化前需要 `inplace_iteration` 維護者確認健全性論證。

## 判斷

1. 18 項數值格無 std 病灶;i0/i1 的差與符號是 glibc `calloc`/tcache 的性質,翻轉點 1032 B。**排除**,與前兩章一致,並補上了完整的檔位表與 C 端對照。
2. **修正前兩章的建議**:`xxu8_1000_i1` 章與 `u128_0100_i0` 章都建議「要守護 in-place 路徑應像 `bench_in_place_recycle` 那樣復用來源緩衝」。該 bench 恰恰沒有走 in-place 路徑;可作典範的是 `bench_in_place_zip_recycle`(0 分配/輪)。
3. **可落地(小)**:`Fuse` 補回 `InPlaceIterable`。使用者可見的效果是 `.fuse()` 不再讓 `collect` 悄悄多分配一次;同類缺口還有 `Peekable`(有 `SourceIter`、無 `InPlaceIterable`,未評估是否可補)。
4. bench 側:`bench_in_place_recycle` 應加分配計數斷言或改測不會被分配成本抵消的尺寸,否則 in-place 失效無法從時間上發現。
5. 方法記錄:同一進程內交替量 i0/i1 會互相污染堆狀態(`u128_1000_i1` 交替時 528 ns,獨立進程 701 ns,harness 722 ns);本章數字只採獨立進程與 harness。
6. x86:glibc 同一份,檔位與翻轉點相同;`MIN_ALIGN` 同為 16。

## 復現

```bash
# 基線與重測:/tmp/btree_bench/{ip_baseline,ip4_results}.txt
# C 分配器曲線:/tmp/btree_bench/alloc_curve.c;交錯細掃:probe_ip2/il.rs
# 分配計數:probe_ip3/count.rs;獨立進程複現與 droppable 拆分:probe_ip4/repl.rs
# .fuse() A/B:probe_ip5/fuse.rs(獨立);ip6_fuse / ip6_nofuse(harness 快照)
# 原型:library/core/src/iter/adapters/fuse.rs(工作樹,未提交;備份 fuse.rs.orig)
```

# `iter::bench_filter_map_chain_ref_sum`:多出的 50% 全是 `checked_mul` 倖存的溢出檢查——LLVM 只在界「先於迴圈旋轉」變成常數時才消得掉;Chain 與 `&mut I` 轉發均零成本

- 日期:2026-10-10
- 分析對象:`library/coretests/benches/iter.rs:262`(`(0i64..1M).chain(0..1M).filter_map(|x| x.checked_mul(x)).map(black_box).by_ref().sum()`)
- 接口:`FilterMap::{fold,try_fold}`、`Chain::{fold,try_fold}`、`Range<i64>` 的預設 `fold`/`try_fold`(半開 `Range` 無覆寫,走 `while let Some(x) = self.next()`)
- 平臺:本機 HiSilicon aarch64,stage1,`bootstrap.toml` rustflags 為空(**非** `+sve`,與前文基線可比);LLVM 23.1.0-rust-1.99.0-nightly

## 基線(min of 3)

```text
bench_filter_map_sum               540,713 ns   0.541 ns/元素
bench_filter_map_ref_sum           817,156 ns   0.817        (+51%)
bench_filter_map_chain_sum       1,627,562 ns   0.814
bench_filter_map_chain_ref_sum   1,628,454 ns   0.814
bench_filter_sum / ref_sum         731,591 / 732,940(value ≡ ref)
```

chain 兩版彼此相同,但都對齊的是**非 chain 的 ref 版**,而非 value 版。

## 彙編:差別只有一組 `smulh; cmp; b.ne`

```asm
; filter_map_sum(value,非 chain):7 條,1 個分支——溢出檢查已消失
loop: mul  x11, x10, x10
      add  x10, x10, #1
      cmp  x19, x10
      stur x11, [x29,#-160] ; ldur x11, [x29,#-160]   ; black_box 屏障
      add  x8, x11, x8
      b.ne loop

; 其餘三版(chain 兩段各一份,逐條相同):11 條,3 個分支
loop: add  x9, x9, #1
      cmp  x19, x9          ; x19 = 1,000,000(常數界仍在)
      b.eq exit
      mul  x11, x9, x9
      smulh x12, x9, x9
      cmp  x12, x11, asr #63
      b.ne loop             ; None → 下一個
      stur/ldur ; add x8, x11, x8
      b    loop
```

Chain 的段狀態在兩版都是零指令(兩段被分裂成兩個獨立迴圈,同 `enumerate_chain` 章);`&mut I` 的 `try_fold` 轉發同樣零殘留。

## harness A/B:把檢查拿掉的上界

臨時加入同形 bench,閉包改為 `Some(x.wrapping_mul(x))`(此值域 x² < 10¹² 不溢出,語義等價):

| | `checked_mul` | `wrapping_mul` |
|---|---|---|
| 非 chain value | 540,713 | 540,701 |
| 非 chain ref | 817,156 | 540,809 |
| chain value | 1,627,562 | 1,081,258 |
| **chain ref** | **1,628,454** | **1,081,204** |

無檢查時 chain = 精確 2× 非 chain、ref ≡ value。**本 bench 的 50.6% 超額成本全部來自倖存的溢出檢查**(≈0.27 ns ≈ 0.8 cycle/元素)。

## 機理:pass 相位順序,不是資訊缺失

以 `opt -passes='default<O3>' -print-after-all` 逐 pass 追蹤(`rustc -C no-prepopulate-passes` 產 pre-IR,O3 重跑與 rustc 結果一致):

1. **value/非 chain**:`Range::fold` 實例只有一個呼叫點,實參 `(0, 1000000, 0)` 為常數,IPSCCP 在模組最早期就把 `end = 1000000` 傳入 callee。閉包內聯進 callee 後,`smul.with.overflow(x, x)` 正被 `Range::next` 的 `icmp slt x, 1000000` 支配;**callee 內聯後的第一個 InstCombine** 即據此算出 `x ∈ [0,10⁶)`,改寫為 `mul nuw nsw`。此時迴圈尚未旋轉。
2. **chain value**:`Chain::fold` 從自身欄位(記憶體)取 `Range` 傳給 `a.fold(acc, &mut f)` / `b.fold(acc, f)`——callee 裡界是未知參數,檢查保留;callee 隨後被 LoopRotate + IndVarSimplify(LFTR)改寫為 `icmp eq %iv.next, %end` 退出。內聯進呼叫端、SROA 後界才成為常數,但支配 `smul` 的只剩 `x ≠ 10⁶`,推不出上界。
3. **ref(兩種)**:`&mut I` 使 `Range` 經指標傳遞,同 2。

最終 IR 中迴圈起點 0、步長 +1、界 10⁶ 全是常數——**資訊完全足夠,只是後段沒有 pass 回頭證明**。在最終 IR 上單獨跑 `instcombine` / `correlated-propagation` / `constraint-elimination` / `indvars` 均無法消除。

## LLVM 最小重現(與 Rust 無關)

```llvm
; for i in 0..1000000(旋轉後、LFTR 的 eq 退出): if let Some(v) = i.checked_mul(i) { use(v) }
define void @f() {
entry:
  br label %loop
loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %latch ]
  %r = call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %iv, i64 %iv)
  %ov = extractvalue { i64, i1 } %r, 1
  br i1 %ov, label %latch, label %some
some:
  %v = extractvalue { i64, i1 } %r, 0
  call void @use(i64 %v)
  br label %latch
latch:
  %iv.next = add nuw nsw i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1000000
  br i1 %done, label %exit, label %loop
exit:
  ret void
}
```

| 變體 | `default<O3>` 後保留的 overflow intrinsic |
|---|---|
| `smul.with.overflow(iv, iv)`,eq 退出 | **1** |
| `umul.with.overflow(iv, iv)`,eq 退出 | **1** |
| `sadd.with.overflow(iv, iv)`,eq 退出 | 0 |
| `smul`,退出改為 `slt` 形 | 0 |

`print<scalar-evolution>` 給出 `%iv --> {0,+,1}<nuw><nsw> U: [0,1000000) S: [0,1000000)`——SCEV 知道範圍;同一迴圈的 add 版會被消除,mul 版不會。推測(未讀 LLVM 源碼確認):SCEV 驅動的 overflow intrinsic 消除對 mul 缺少基於 ConstantRange 的回退(`[0,10⁶) × [0,10⁶) ⊂ [0,10¹²)`),符號比較 `sext(a*b) == sext(a)*sext(b)` 對二次 addrec 不成立。

## 修正前文

`iter::bench_enumerate_chain_ref_sum` 章判斷 2「`bench_sums!` 的 value/ref 對照**全系**失效」——**不完全成立**:`bench_filter_map_sum` / `_ref_sum` 有 51% 差距。但差距並非宏註釋所說的「ref 無法優化 fold」(兩者熱迴圈結構相同、`try_fold` 轉發零殘留),而是 ref 形狀讓常數界晚於迴圈旋轉才可見,錯過了 InstCombine 消除 `checked_mul` 的時機。對不含溢出檢查的閉包,value ≡ ref 的結論仍成立。

## 判斷

1. **std 無病灶**:Chain、FilterMap、`&mut I` 轉發在 fold/try_fold 消費下都零成本;差距是 LLVM 對 `{s,u}mul.with.overflow` 的相位順序/分析缺口。
2. 正確修法在 LLVM:讓 SCEV 驅動的 overflow 消除對 mul 使用操作數範圍(上表最小重現可直接附入 issue)。Rust 側在 `Range::fold` 加 `assert_unchecked` 之類的繞法侵入性高、收益只限此類閉包,不建議。
3. 影響面:任何「有界整數 Range(界在記憶體或經 `&mut`/Chain 傳遞)+ 閉包內 `checked_mul`/`overflowing_mul`」的迴圈都會多 3 條指令/元素;本 bench 上為 +50%。

```text
# 復現:/tmp/btree_bench/fm_chain/{r.rs(四形狀獨立重現), min_smul.ll, min_sadd.ll, min_smul_slt.ll}
# pre-IR:rustc -O -C no-prepopulate-passes --emit=llvm-ir r.rs;opt -passes='default<O3>' -print-after-all -filter-print-funcs=<mangled>
# harness A/B:臨時 bench_tmp_fm_{,chain_}wrap{,_ref}_sum(已移除)
```

# `btree::map::first_and_last_10k_stable`:比 nightly 慢 48% 不是導航成本,是 `iter()` 第一步內聯了用不到的上溯迴圈——快路徑必須跳過它,這個佈局讓預測器每千指令失誤 4 次;在 `LazyLeafRange` 的 Root 狀態直接取首/尾 KV 後 −38%,並消掉 `next_unchecked` 原型的 `0_stable` +121% 退化

- 日期:2026-10-10
- 分析對象:`library/alloctests/benches/btree/map.rs:301`(`bench_first_and_last_stable`:`10 × { black_box(map.iter().next()); black_box(map.iter().next_back()) }`,對照 `_nightly` 的 `first_key_value`/`last_key_value`)
- 接口:`Iter::next` → `LazyLeafRange<Immut>::next_unchecked` → `init_front`(Root → `first_leaf_edge`)→ `Handle::next_unchecked` → `next_kv`(上溯迴圈)+ `next_leaf_edge`
- 平臺:本機 HiSilicon aarch64,stage1,rustflags 為空
- 前置:工作樹的 `navigate.rs` 帶著先前 session 的未提交原型(`Handle::next_unchecked` 葉內快路徑,`iteration_1000` 1837 → 1111 ns),本文件未曾記錄;本章同時量了 HEAD 版與原型版

## 基線(min of 3)

| bench | HEAD `navigate.rs` | 工作樹原型 |
|---|---|---|
| 0_nightly / 0_stable | 3.72 / 3.74 | 3.72 / **8.28(+121%)** |
| 100_nightly / 100_stable | 15.30 / 19.27 | 15.29 / **24.24(+26%)** |
| 10k_nightly / 10k_stable | 34.52 / 50.95 | 34.51 / 50.71 |

nightly 對照組在兩版中不動,原型的兩項退化可以排除佈局效應;它在先前 session 中只量過 `iteration_*`,從未量過 `first_and_last_*`。

## 機理

**彙編**(實際計時的是 `Bencher::iter` 內聯副本,perf 99.9%;`ns_iter_inner` 只在校準時跑):root/height 在兩版中都在暫存器裡(先前「`&map` 每次重讀」的猜測在內聯副本上不成立)。兩版下降鏈逐條相同,stable 每個 op 只多三條:

```asm
; stable front 段:葉子 len==0 → 上溯迴圈(length>0 時不可能發生)
ldrh w12, [x11, #98]
cbz  w12, ascend_loop      ; 多出:不跳
mov  w13, wzr
b    compute_kv            ; 多出:每次都跳,越過內聯的上溯迴圈
ascend_loop: ...
; nightly 同一位置:csel x12, xzr, x13, eq(無分支)
```

**計數器**(perf stat,每千條指令):

| 變體 | IPC | branch-miss/千指令 |
|---|---|---|
| nightly(展開) | 4.24 | 0.011 |
| nightly_rolled(`0..black_box(10)`) | 4.35 | 0.002 |
| stable | 3.35 | **4.004** |
| stable_rolled | 3.41 | **3.976** |
| stable_unrolled(手寫 10 份) | 4.13 | 0.014 |

nightly_rolled 同樣是「外層迴圈套兩段下降迴圈」,卻沒有失誤——所以「巢狀迴圈不可預測」不成立,失誤專屬 stable 的佈局。手動展開讓失誤消失(43.4 ns),但不展開時單 op 仍貴 2.1 cycle。嘗試用 ARM SPE 精確定位失誤分支,本機 SPE 只產生極少記錄,未能使用;因果改由下面的 A/B 建立。

## A/B

**C1:`next_kv`/`next_back_kv` 的上溯分支加 `cold_path()`** —— `10k_stable` 50.95 → 35.97(−29%),確認失誤來自「快路徑必須跳過上溯迴圈」的佈局;但 `iteration_mut_1000` +33.7%、`iteration_mut_100000` +12.4%。遍歷時每 ~12 個元素就上溯一次,那條路並不冷。**否決**。

**C2:在 `LazyLeafRange<Immut>::next_unchecked` / `next_back_unchecked` 處理 Root 狀態** —— front 仍是 Root 時,下降到最左葉後直接回傳其第 0 個 KV、front 設為邊 1;back 對稱取最後一個 KV。不經過 `next_kv`。依據:呼叫端已保證還有下一個 KV,而非空樹的最左/最右葉必非空——`first_key_value`(`first_leaf_edge().right_kv().ok()?`)早已依賴同一事實。back 已先移動過時,front 的「下一個」仍是第一個元素,結論不變。

```rust
if let Some(LazyLeafHandle::Root(root)) = &self.front {
    let leaf = unsafe { ptr::read(root) }.first_leaf_edge().into_node();
    debug_assert!(leaf.len() > 0);
    self.front = Some(LazyLeafHandle::Edge(unsafe { Handle::new_edge(leaf, 1) }));
    return unsafe { Handle::new_kv(leaf, 0) }.into_kv();
}
unsafe { self.init_front().unwrap().next_unchecked() }
```

| bench | HEAD | C2 | 原型 | 原型 + C2 |
|---|---|---|---|---|
| first_and_last_0_stable | 3.74 | 3.74 | 8.28 | **3.74** |
| first_and_last_100_stable | 19.27 | 11.78 | 24.24 | **11.69(−39.3%)** |
| first_and_last_10k_stable | 50.95 | 31.42 | 50.71 | **33.10(−35.0%)** |
| iteration_1000 | 1855.6 | 1697.4 | 1110.3 | **953.7(−48.6%)** |
| iteration_20 | 24.50 | 25.42 | 22.28 | **18.64(−23.9%)** |
| iteration_mut_1000 | 1781.0 | 1861.3 | 1075.4 | 1071.3(−39.8%) |
| iteration_mut_20 | 25.75 | 24.49 | 20.02 | 19.71(−23.5%) |
| iteration_fold_* / iteration_mut_fold_* | — | ±6% | ±5% | ±3% |

**佈局包絡**:HEAD 與 C2 各重建、各量兩輪,同一建置內兩輪差 <1%;但 C2 完全未碰的路徑在換建置後有確定性偏移(`nightly_rolled` +8.6%、`iteration_mut_1000` +4.2%、`iteration_mut_20` −4.9%)。故 ±9% 內的變動不歸因;first/last 的 −35…−39% 與原型 + C2 的 iteration 收益都遠在包絡外。

原型 + C2 中,原型的 iteration 收益完整保留且 `Iter` 的 `for` 迴圈更快(每次 `next()` 的 Root 判斷有了直接出口),原型對 `0_stable`/`100_stable` 的退化同時消失。原型為何讓 `0_stable`(長度 0、在 `length` 檢查即返回)變慢,未逐條拆解。

## 正確性

- 新增 `map/tests.rs::test_iter_first_step_from_root`:批量建、升/降序插入、兩端刪到半空、6 個切點的 `split_off`+`append`、`retain` 稀疏化,共 10 種大小;每種樹形先 `map.check()` 驗不變量,再比對 `iter().next()`/`next_back()`、`keys()`/`values()` 與 `first_key_value`/`last_key_value`,並以「先消耗 back 再走 front」(4 個切點)與嚴格交替兩種順序對照 Vec 參考。
- btree 測試:原型 + C2 下 174 + 113 項全過;開 `debug-assertions-std = true` 再跑一次亦全過(耗時 77 → 106 ms,顯示斷言已編入;未另以探針確認 `cfg(debug_assertions)`)。

## 判斷

1. 10k_stable 比 nightly 慢 48% 的主因是 `iter()` 第一步內聯了在 `length > 0` 時不可能走到的上溯迴圈,快路徑要用一條必跳的 `b` 越過它,這個佈局在本機讓預測器每千指令失誤 4 次;一半由失誤、一半由每 op 多出的指令構成。
2. **可落地**:C2 只在 Root 狀態加一個直接出口,不改變 Edge 狀態(遍歷熱路徑)的程式碼,也不需要分支提示;與 `next_unchecked` 原型可直接疊加,並修掉原型的兩項退化——若原型要送 PR,C2 應一起帶上,否則 reviewer 跑 btree bench 會看到 `first_and_last_0_stable` +121%。
3. `ValMut`(`iter_mut().next()`)有同形的 Root 路徑,本章未改未量。

```text
# 二進位:/tmp/btree_bench/fl/{bin_headnav,bin_ctrl}
# navigate.rs 版本:/tmp/btree_bench/fl/navigate.rs.{proto,c1,c2,proto_c2,final}
# 量測腳本與結果:/tmp/btree_bench/fl/run.sh;res_{head,head2,c1_cold,c2_root,c2b,proto,proto_c2}.txt
# 臨時 bench(已移除):tmp_fl_10k_{nightly_rolled,stable_rolled,stable_unrolled}
# 工作樹:已還原為原型(未含 C2、未含 test_iter_first_step_from_root);C2 版本見 navigate.rs.proto_c2
```

# `iter::bench_filter_map_ref_sum`:ref 版 +51% 的逐 pass 證據——`Range` 經指標進 `try_fold`,界在 callee 內是 load;std 側用 `assert_unchecked` 補救不可行,assume 在內聯前就被 EarlyCSE 當冗餘刪除

- 日期:2026-10-10
- 分析對象:`library/coretests/benches/iter.rs:257`(`(0i64..1M).filter_map(|x| x.checked_mul(x)).map(black_box).by_ref().sum()`)
- 前置:`iter::bench_filter_map_chain_ref_sum` 章已給出差距全部來自倖存的 `checked_mul` 溢出檢查(`wrapping_mul` 對照:ref 540,809 ≡ value 540,701),並對 ref 形狀僅寫「同 chain 機理」;本章補逐 pass 證據,並評估 std 側補救
- 平臺:本機 HiSilicon aarch64,stage1,rustflags 為空;LLVM 23.1.0-rust-1.99.0-nightly

## 基線(min of 3,與前章一致)

```text
bench_filter_map_sum        540,456 ns
bench_filter_map_ref_sum    817,409 ns   (+51%)
```

## 逐 pass 證據(ref 形狀)

`rustc -C no-prepopulate-passes` 產 pre-IR,沿 `r_plain` 的呼叫鏈走,迴圈在 `Range<i64>::try_fold` 的一個 internal 實例裡:

```llvm
; r_plain:Range 放在 alloca,以指標傳入
%_1 = alloca [16 x i8]
store i64 0, ptr %_1
store i64 1000000, ptr %0
%_2 = call i64 @try_fold(ptr noalias ... dereferenceable(16) %_1, i64 0, ...)
```

該 callee 的函式級 dump(只列變化點):

| 之後 | smul | icmp | i64 load |
|---|---|---|---|
| 初始 | 0 | — | 8 |
| InlinerPass(閉包、`next` 內聯) | **1** | `slt` | 3 |
| SROAPass | 1 | `ne`, `slt` | 3 |
| InstCombinePass | 1 | `eq`, `slt` | 3 |

`start`/`end` 在 callee 內一直是 load,`smul` 被 `icmp slt x, %end_loaded` 支配,推不出上界;迴圈旋轉 + LFTR 把出口改為 `eq`。內聯回 `r_plain`、SROA 把 load 變成常數 10⁶ 時,支配 `smul` 的只剩 `≠`。`try_fold` 取 `&mut self` 並寫回 `start`,ArgumentPromotion 無法把指標拆成值;IPSCCP 也不跨記憶體傳播。value 形狀的對照(前章):`Range::fold` 以值接收 `(0, 1000000)`,IPSCCP 最早期就把常數送進 callee,InstCombine 趁比較仍是 `slt` 時消掉檢查。

## std 側補救:`spec_next` 加 `assert_unchecked(old < self.end)`——不可行

想法:LFTR 只改寫出口比較,`llvm.assume` 留在迴圈體內;界成為常數後 InstCombine 仍有 `<` 可用。

- core 原型(`RangeIteratorImpl for ops::Range<T: TrustedStep>::spec_next`)+ 全 `iter::` 套件:目標 bench 不動(ref_sum 814,051、chain_ref_sum 1,628,464),bench 二進位仍有 4 份 `smulh`。
- 原因:pre-IR 中 assume 存在(4 個),但 **`spec_next` 自身的 EarlyCSE 就把它刪了**——它被完全相同的分支條件支配,判為冗餘;這發生在任何內聯之前,最終 IR 中 assume 為 0。
- 變體「遞增後 `assert_unchecked(self.start <= self.end)`」同樣在全部形狀被刪除(可由 `start < end` 與 `nuw/nsw` 遞增推出)。

LLVM 會主動刪除「能由支配條件推出」的 assume,而這裡需要保留的恰是這份資訊,故 std 側以 assume 補救的路線關閉。修法仍在 LLVM(前章最小重現:SCEV 已知 `%iv ∈ [0,10⁶)`,`sadd.with.overflow` 會被消除而 `smul`/`umul` 不會)。

## 方法論勘誤:MergeFunctions 造成的假陽性

第一版獨立探針(自製 `R<const A: bool>` 仿 `Range`)以「函式體內 `smulh` 計數」判定,得出 assume 版 3 種形狀全部消除——**錯誤**。assume 被刪後 `_1` 與 `_0` 系列程式碼相同,MergeFunctions 把它們合併為別名(`r_plain_1 = r_plain_0`),函式體為空,計數自然為 0。以 `opt -print-after-all` 追蹤時 `r_plain_1` 的 `smul` 自始至終保留,與組合語言矛盾才發現。之後的同類探針一律加 `-Z merge-functions=disabled`,並直接檢查 IR 中各函式的 `define` 體。

## 判斷

1. 本 bench 與 value 版的差距完全由 `checked_mul` 溢出檢查的去留決定;ref 形狀錯過消除時機的路徑已由逐 pass 追蹤證實(指標傳遞 → callee 內界未知 → 旋轉後只剩 `eq`)。
2. std 側無可落地的修法:`assert_unchecked` 在內聯前即被刪除;`Range::fold`/`try_fold` 的形狀改寫同樣在 callee 內拿不到常數界。
3. LLVM 側修法與前章相同,本章的逐 pass 表可作為該 issue 的補充證據(說明為何 value 形狀「碰巧」能消除)。

```text
# 探針:/tmp/btree_bench/fm_ref/{p.rs(第一版,受 MergeFunctions 影響), p2.rs(三種 assume 變體,merge 關閉)}
# core 原型:/tmp/btree_bench/fm_ref/range.rs.assume(已還原,range.rs 與 HEAD 相同)
# 全 iter:: 量測:/tmp/btree_bench/fm_ref/res_assume.txt
```

# `slice::sort_unstable_large_random`:126.6 µs = 10k 隨機 u64 × 36.7 cycles;比較次數 13.8/元素(1.04·log₂n,接近理論),時間 75% 在 partition 迴圈的兩條 store;每 pass 2.1 cycles/元素是這個無分支形態的機器地板;兩個改法(寄存器攜帶 `left` 值、葉子 ≤20 改插入排序)實測皆回退

- 日期:2026-10-12
- 分析對象:`library/alloctests/benches/slice.rs:310`(`sort!(sort_unstable, sort_unstable_large_random, gen_random, 10000)`:`v.clone().sort_unstable()`,10 000 個均勻隨機 u64)
- 實現:ipnsort(`unstable/mod.rs`)→ `quicksort`(遞迴左、迴圈右)→ `partition_lomuto_branchless_cyclic`(u64 ≤ 96 B 走無分支 Lomuto + 循環置換,`UNROLL_LEN = 2`)+ `choose_pivot`(len ≥ 64 用 27 點遞迴 pseudo-median)+ `small_sort_network`(len ≤ 32)
- 平臺:本機 HiSilicon aarch64,stage1,rustflags 為空

## 基線(min of 3)

```text
sort_unstable_large_random        126,361 ns  = 12.6 ns/元素 = 36.7 cycles/元素
sort_unstable_large_mostly_asc    130,174         (隨機交換 √n 對後,與 random 同級)
sort_large_random (stable)        138,256         (+9%)
sort_unstable_large_big           644,497         (元素 128 B,走 branchy Hoare)
```

harness 含 `v.clone()`(80 KB memcpy,perf 中 `__memcpy_generic` 1.7%)。perf:`quicksort` 75.4%、`small_sort_network` 19.2%、`median3_rec` 3.6%。IPC 2.79,branch-miss 0.23%(每元素 0.013 次),L1 miss 0.06%——無分支化目標達成,**瓶頸不在預測也不在快取**。

## 工作量分解(獨立探針,同 RNG)

- 比較次數(`sort_unstable_by` 計數):10.3/13.8/17.3 per elem @ n=1k/10k/100k = **1.04·log₂n**。
- partition 處理的元素總數(重現 std 的 pivot 與遞迴形):**9.33 n**(≈ log₂(10000/32)+… ,pivot 品質近乎理想);葉子平均 19.3 個元素,35% 的葉子元素落在 len ≤ 20。
- 單次 partition pass(獨立函式,與 std 彙編逐條同形,64 份不同資料輪流):**2.1 cycles/元素**(n ≤ 1k);n=4095 時 2.6。對 lt-模式不敏感(全真/全假/交錯/隨機 10–50% 皆 2.5–2.6 @ n=4096)。
- 地板:同一迴圈拿掉比較依賴、固定位址的 2 load + 2 store = 1.19 cycles/元素;1 load + 1 store = 0.52;只比較計數 0.47。

**partition 迴圈的 2.1 cycles 中 ~1.2 是純粹的 4 次記憶體操作吞吐**,其餘 ~0.9 來自 `cinc` 決定的位址依賴(`ldr x16,[x9,x13,lsl #3]` 的 `x13` 由上一個比較的 `cinc` 產生)。perf annotate 把 90% 的樣本歸到兩條 store(`stur [x12,#-8]`、`str [x12],#16`)上,skid 下它們代表「等待前一步 load/位址」的停頓點。

## 預算(cycles/元素,10k)

| 項 | 估算 | 依據 |
|---|---|---|
| partition:9.33 pass × 2.1–2.6 | 20–24 | 獨立 pass 成本 × 總元素 |
| small_sort(len ≤ 32,平均 19) | ~7 | 19.2% × 36.7 |
| pivot 27 點取樣 | ~1.3 | 3.6% |
| clone + 呼叫開銷 | ~1 | 1.7% + 餘 |
| **實測** | **36.7** | |

partition 在 sort 內部的實際單價是 (36.7 − 7 − 1.3 − 1)/9.33 ≈ **2.9 cycles/pass/元素**,比獨立 2.1–2.6 高 ~0.5。其中可量化的部分是 pivot 取樣(見下段 27 點 vs 3 點對照);其餘差額的原因**未量測**(推測與子陣列短、每次 pass 的啟動成本有關,未驗證)。stall_backend 計數 std 15.3/元素,自製 driver(同 partition、3 點 pivot)7.1/元素;driver 換成 std 的 27 點 pivot 後 stall 升到 10.7/元素、cyc 從 27.7 → 30.3——**27 點 pivot 的取樣 load 是一個可量化的 stall 來源(≈3 cycles/元素,8%)**,但它換來的 pivot 品質把 partition 總元素從 10.50 n 壓到 9.33 n(−11%),兩者相抵,net 持平(n=576 時 P 比 3 點慢 15%,n=10k 時 driver P512「≥512 才用 27 點」在兩個 seed 上一正一負)。

## 嘗試過的改法(皆已還原)

1. **寄存器攜帶 `left` 值**(避免 `ldr [base+num_lt]` 重讀上一步剛 store 的位置):每元素多一次 `ptr::read(left+1)` + select;harness 外的獨立 sort **+5…+9%**(n=64…131k 全部回退)。多出的 load 比省掉的 store-to-load 轉發更貴。否決。
2. **葉子 ≤ 20 改插入排序**(`sort` 入口對整體輸入已用此門檻;隨機葉子平均 19):harness `sort_unstable_large_random` **+1.9%**、`large_big` +11.8%、`medium_random` +5.8%、`large_strings` +3.7%;只有 `large_expensive` −3.1%。`small_sort_network` 的 sort9/sort13 網路對 9–20 的隨機葉子仍勝插入排序。否決。

## 量測注意

- n 掃描中 576 → 640 出現 +26% 的階躍(18.4 → 23.3 cycles/元素),曾疑為結構性門檻。**實為資料敏感**:同 n 換 seed,576 的 8 個 seed 落在 18.8–25.6、640 落在 18.3–24.0,雙峰分佈(~19 或 ~24,無中間值),對應 stall_backend 5.5 vs 10.6;與陣列位址 mod 4 KB 無關(off 掃描 8 個偏移全同)。10k 時 8 個 seed 全落在 37.4–37.8,無雙峰——大 n 下兩種狀態在遞迴中平均掉了。小 n 的單 seed 數字不可作結論。
- 獨立 partition 探針若對同一份資料反覆跑(k=1)與輪流 64 份不同資料(k=64)結果相同(2.07 vs 2.09),記憶體依賴預測器沒有「學會」固定資料。

## 判斷

1. **無 std 病灶**:比較次數 1.04·log₂n、partition 總量 9.33 n、無分支 partition 已在 4 次記憶體操作 + 一條位址依賴鏈的吞吐上,小排序與 pivot 的佔比合理。
2. 剩餘可想的方向都是結構性的(非本章可落地):SIMD 壓縮式 partition(AVX-512 `vpcompressq` / SVE `COMPACT`,見 `optimizable-interfaces.md` 的 SVE 章——與 `VecDeque::retain` 同一把 kernel,但 partition 需雙向輸出且 pivot 比較的 lt 掩碼來自向量比較,`is_less` 泛型閉包無法向量化,只能對 `T: Ord` 整數原生型別特化)、或 BlockQuicksort 式先算 64 個 lt 位元再搬運(減少位址依賴,但 ipnsort 作者的實測是 Lomuto cyclic 在 x86/Arm 上更快,本機探針 unroll=4 也不比 2 好)。
3. 10k u64 隨機排序 12.6 ns/元素(未與 ipnsort 公開數字逐項核對);driver 自製版 3 點 pivot 27.7 cycles/元素比 std 快 25%,**但這不是改進線索**:它的 partition 總量多 12%,只是省了 27 點取樣的 stall,在 n=576 時反而慢;且未實作 ancestor_pivot 去重與 heapsort 保底。

```text
# 探針:/tmp/btree_bench/sortu/probe/{part.rs(partition 單價 + 地板), cnt.rs(比較計數), slope.rs/fine.rs/one.rs(n 掃描/perf), off.rs(位址偏移), scan.rs/pat.rs/kbuf.rs/par.rs(partition 對 n/模式/工作集/偏移), sel.rs(select_nth 對照), drv.rs/drvone.rs(自製 driver:遞迴方向、pivot 形態、葉子策略), leaf.rs(葉子分佈)}
# 原型(已還原):/tmp/btree_bench/sortu/quicksort.rs.{regleft,leaf20};harness 結果 res_{base,leaf20}.txt
# 二進位:/tmp/btree_bench/sortu/bin_base
```

# `iter::bench_range_step_by_fold_usize`:已是 NEON 4 累加器向量迴圈、無 load;比 `loop_u32` 慢一倍純粹是 u64 只有 2 lanes(每迭代週期數相同);開 SVE 只快 11%——本機 256-bit SVE 指令吞吐恰為 NEON 的一半,向量資料路徑仍是 128-bit

- 日期:2026-10-12
- 分析對象:`library/coretests/benches/iter.rs:106`(`(0..65535usize).step_by(64).map(|x| x ^ x.wrapping_sub(1)).fold(0, wrapping_add)`,1024 個元素)
- 平臺:本機 HiSilicon aarch64,stage1,rustflags 為空;SVE VL = 256

## 基線(min of 3)

```text
bench_range_step_by_fold_usize   261.55 ns  0.255 ns/元素  0.74 cyc/元素
bench_range_step_by_loop_u32     130.77 ns  0.128          0.37   (for 迴圈、u32,同運算)
bench_range_step_by_fold_u16      92.56 ns  0.090          0.26
bench_range_step_by_sum_reducible  1.34 ns                       (被常數摺疊)
```

## 彙編

`fold_usize` 與 `loop_u32` 的主迴圈**逐條同形**,只差 lane 寬度:

```asm
; 17 條向量指令 + 迴圈控制;4 組累加器;無任何 load
add  v21.2d, v19.2d, v1.2d   ; x   = base + 常數偏移(4 個向量並行從 v19 派生)
add  v24.2d, v19.2d, v5.2d   ; x-1 = base + (偏移-1)
eor  v21.16b, v24.16b, v21.16b
add  v16.2d, v21.2d, v16.2d  ; 累加
...
add  v19.2d, v19.2d, v20.2d  ; 唯一的歸納更新
```

usize 每迭代 8 個元素、u32 每迭代 16 個;換算 0.74×8 = **5.9 cycles/迭代** 與 0.37×16 = **5.9 cycles/迭代** 相同。17 條指令已接近下界(每向量「x、x−1、eor、累加」4 條 ×4 + 1 條歸納)。`StepBy<Range>` 的 fold 特化把它變成純算術計數迴圈,128 迭代 × 5.9 ≈ 755 cycles ≈ 260 ns,與實測吻合,呼叫開銷可忽略。

## SVE:只快 11%,原因是硬體

獨立探針(同閉包,stage1 rustc):

| 編譯 | usize | u32 | u16 |
|---|---|---|---|
| 預設(NEON) | 250.3 ns | 129.5 | 91.0 |
| `+sve` | 221.6(−11%) | 116.8 | 69.2 |
| `+sve` + `-aarch64-sve-vector-bits-min=256` | 215.9 | 123.9 | 59.3 |

SVE 迴圈每迭代 16 個元素(4 向量 × 4 lanes),但要 10.25 cycles。LLVM 生成的 SVE 迴圈把 4 個向量的起點寫成**串行鏈**(`z6=z5+z4; z7=z6+z4; z16=z7+z4; z5=z16+z4`),曾懷疑為瓶頸;手寫改成並行歸納後 10.45 cycles/迭代,**無改善,假設推翻**。

直接量 `add` 吞吐(8 條獨立鏈):

| | add/cycle | bit/cycle | 單條延遲 |
|---|---|---|---|
| NEON `add v.2d` | 3.58 | **459** | ~2.1 |
| SVE `add z.d`(VL 256) | 1.79 | **458** | ~2.2 |

**本機 256-bit SVE 指令吞吐恰為 NEON 的一半,每週期處理的位元數完全相同**——向量資料路徑是 128-bit,SVE 指令拆成兩個 µop 執行。SVE 那 11% 只來自迴圈控制指令變少。

## 判斷

1. **無 std 病灶**:迴圈無 load、4 累加器、指令數接近下界,向量 ALU 使用率 ~81%(17 條 / 5.9 cycles vs 峰值 3.58/cycle)。usize 對 u32 的 2× 是 lane 數,不是程式碼問題。
2. **對整個 SVE 方向的含義**:在本機,SVE 對純算術向量迴圈沒有寬度紅利;SVE 的價值只來自 NEON 沒有的指令(`COMPACT`、述詞化載入/儲存、`whilelo` 尾端處理,例如 `VecDeque::retain` 章的 2–10×)。核對 `optimizable-interfaces.md`:多數 SVE 候選的收益本就來自這類指令,且 §(make_ascii_uppercase 0.48–0.78×)、帶寬封頂條目已記「無寬度優勢」。**缺口**:§20(寬整數切片比較 3.3–3.7×)與 §21(浮點切片相等 4.5–6.1×)的倍數是對 std 現有路徑量的,**未與手寫 NEON 版對照**;依本章,其中「一次比較更多 lane」的部分在本機不會比 NEON 多,真正 SVE 獨有的只有 `brkb`+`cntp` 取索引與 `whilelo` 尾塊——兩條的 SVE 專屬增益需補 NEON 對照才能確定。
3. `fold_u16` 的 0.26 cycles/元素未達 8 lanes 的理論值(LLVM 只用 2 組累加器、64 迭代),本章未再細拆。

```text
# 探針:/tmp/btree_bench/stepby/{p.rs(NEON vs SVE 編譯對照), asm.rs(手寫 SVE 串行/並行歸納), thr.rs(NEON/SVE add 吞吐與延遲)}
# 二進位:/tmp/btree_bench/stepby/bin
```
