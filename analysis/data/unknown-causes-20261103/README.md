# 未知成因追加實驗（2026-11-03）

本目錄保存 x86-gap-report.md 第5節的本輪探針和原始結果。Rust/LLVM/libc實作均未修改；二進位干預僅針對/tmp微測試副本。

量測：measure.py每case跑三輪，以cycles最少的同一輪列出instructions、branch misses及FE事件，all_runs保留全部輪次。ARM core52，x86 P core12；sort-variants與sort-layout使用core54及原驅動內部五輪最小值。ARM事件為cycles:u/instructions:u/branch-misses:u/stalled-cycles-frontend:u；x86使用cpu_core PMU與idq_bubbles.cycles_0_uops_deliv.core。兩種FE事件定義不完全相同，不直接跨架構相減。aos-split-loads另量mem_inst_retired.split_loads。比較使用週期，不乘主頻。

Rust編譯器讀各主機/tmp/xdiff/rustc.txt（同07e526db9df標準庫）；動態LD_LIBRARY_PATH見/tmp/xdiff/libdir.txt。原始工作目錄為/tmp/rust-gap-investigation-20261103。C編譯器：ARM GCC12.3.1，x86 GCC15.3.0；glibc2.38/2.42。C跨機比較含此混淆，同機干預作因果依據。

## 核心重跑命令

在複製到獨立暫存工作目錄後執行，RUSTC應指向原環境對應編譯器。結果JSON每列args及denominator保存完整測試參數。measure.py的兩個參數依序為case列表JSON、輸出標籤；它會在腳本同目錄保存結果。

```sh
$RUSTC -C opt-level=3 -C debuginfo=1 unicode.rs -o unicode
./unicode check
$RUSTC --edition=2021 -C opt-level=3 -C no-vectorize-loops -C no-vectorize-slp batch.rs -o batch
./batch check
$RUSTC --edition=2021 -C opt-level=3 -C no-vectorize-loops -C no-vectorize-slp batchfull.rs -o batchfull
./batchfull check
$RUSTC -C opt-level=3 -C debuginfo=1 alloc.rs -o alloc_static
$RUSTC -C opt-level=3 -C debuginfo=1 -C prefer-dynamic alloc.rs -o alloc_dynamic
$RUSTC -C opt-level=3 -C debuginfo=1 -C prefer-dynamic -Z plt=no alloc.rs -o alloc_noplt
$RUSTC -C opt-level=3 bench.rs -o sret_base
$RUSTC -C opt-level=3 -C llvm-args=-no-stack-coloring bench.rs -o sret_nc
python3 patch-sret.py ./sret_base
$RUSTC -C opt-level=3 alu.rs -o alu
$RUSTC --edition=2021 -C opt-level=3 aos-context.rs -o aos-context
$RUSTC --edition=2021 -C opt-level=3 aos-same.rs -o aos-same
python3 patch-aos.py ./aos-same ./aos-same-aligned
```

patch-sret.py僅用於AArch64指定編譯形態，逐字檢查原指令，不匹配就拒絕。patch-aos.py僅用於x86對應函數，逐條檢查五個位移，輸入兩欄已設相同值，以保持輸出可檢查；不是一般欄位提取修法。patch-plt.py只處理測試副本，立即綁定（LD_BIND_NOW=1）後測；archive副本使用腳本所在目錄。

```sh
gcc -O3 -fno-tree-loop-distribute-patterns -fno-builtin-memset fill.c -o fill
gcc -O3 -fno-tree-loop-distribute-patterns -fno-builtin-memset fillwide.c -o fillwide
# ARM fillwide另外加 -march=armv8-a+sve -msve-vector-bits=256；本機VL=32B。
gcc -O3 -fPIC -shared -fno-optimize-sibling-calls -Wl,--section-start=.text=0x10000 chainlib.c -o chain_plt.so
# direct同命令另加 -Wl,-Bsymbolic-functions；got同命令另加 -fno-plt。
gcc -O3 chainmain.c -ldl -o chain
```

format佈局掃描：opt-level3、prefer-dynamic、link-arg=-Wl,--section-start=.text=0x10000+offset，offset為0/16/32/48；分別預設PLT和-Zplt=no，執行時setarch aarch64 -R固定ASLR。sort佈局offset為0..112步16；sort pass變體分別為-no-stack-coloring、-aarch64-enable-early-ifcvt=false、-aarch64-select-opt=false及-enable-ext-tsp-block-placement。沒有組合套用所有pass。

partition-scan使用既有sp.rs（本目錄複本）原樣編譯，part參數依JSON；包括每輪copy成本，不是純partition淨成本。sort-state.rs亦是既有觀察程式複本，未變更演算法。sret結果不表示修改了Any/TypeId實作。

本輪有效ALU偏移探針以NOP填充，退休指令數為add數+2；初次零位元組填充試跑無效，未列入本目錄有效結果。

## 檔案族

- phase1：查表階段與真實format三種連結；batch/batchfull：1/2/4/8條交錯搜尋。
- phase2：ARM純搜尋批次與同地址PLT變體；layout：真實format固定ASLR及.text偏移。
- chain：獨立跨so深鏈；fill/fillwide：16B展開及32B寫入；alu：獨立add斜率。
- sret及sret-clean：同地址TypeId棧讀回控制；aos-context及aos-split-loads：欄位/位置與split load因果。
- sort-variants/sort-layout/partition-scan：排序未知項排除；sort-hotspot保存本輪perf摘要與熱指令。
- MANIFEST.json列出歸檔檔案SHA256及位元組數，便於核對。
