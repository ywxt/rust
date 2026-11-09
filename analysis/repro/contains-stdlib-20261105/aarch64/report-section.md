

# 标准库内实现 `str::contains` 通用单字节 SIMD 路径并重建验证（2026-11-05）

本节落实到实际远程标准库，替代前节外部完整Pattern包装原型作为本轮代码结论。个人实验，不用于上游贡献；未新增inline属性。实际工作树 `/home/wheel/c00936152/rust-analysis`，源码HEAD `dc55da5cca14a0aa773ecb7a0459756260b2ee5c`，包含用户已有library改动；基线与修改版均保留这些已有改动，差别仅为本节标准库实现。main在表中指未修改contains的同源基线，不是重新拉取最新main。

## 实际修改与功能范围

- `library/core/src/str/pattern.rs:591`：Pattern for char 的ASCII分支，在支持的目标上、haystack至少64 B时进入SIMD；更短输入保留原有slice contains路径。
- `library/core/src/str/pattern.rs:1008`：Pattern for &str 的既有len=1分支采用相同路径。needle来自运行时参数，没有固定 `!` 或0x21。
- 同文件2026/2041/2059行新增NEON/SSE2的64 B比较与布尔扫描函数。先检查首字节，命中立即返回；长度至少128 B时覆盖前缀并将后续主体对齐64 B；尾部重叠检查最后64 B，所有读取均在输入切片内。
- `library/alloctests/tests/str.rs:2681`、2708行新增全ASCII/长度/偏移与完整Pattern语义测试，保留用户此前已有内容。

`str::contains<P: Pattern>` 的公共入口和签名保持标准实现，调用原有Pattern方法；空串、多字节/Unicode字符串、非ASCII字符、字符集合、谓词、自定义Pattern仍保留标准语义。实现只加速既有单字节分支，没有外部specialization包装，也不要求调用者改成自定义函数。unsupported SIMD目标继续执行原有路径；实际验证目标为ARM64 NEON和x86_64 SSE2。

实现要点（完整可编译源码在归档的pattern.optimized.rs及实际仓库）：

```rust
// 概略流程；不是独立实现文件。
// 原有char ASCII分支或&str len=1分支：
if haystack.len() >= 64 {
    return contains_byte_simd(haystack.as_bytes(), needle);
}
// 随后保留原有标量路径。
```

完整实现中平台条件、短路径、字节值来源和边界处理全部包含；上面只说明接入位置。64 B比较是四组16 B相等比较，先向量OR再判断是否有匹配；不构造64位位置掩码，也不计算匹配索引。它仅服务contains布尔语义，未替换find/rfind所需的索引查找。

## 真正重建标准库与版本控制

此前原型使用缓存Rust1.101/LLVM23.1.4；实际远程工作树是Rust1.99。不能将两个版本混作本次优化前后。本节两目标均由远程同一个stage1 rustc1.99.0-dev、LLVM23.1.0编译，Cargo1.99.0-nightly（b07e5a086，2026-08-07）。x86程序在ARM上交叉生成，再到i7-12700 P核12实际运行；ARM绑核52，HiSilicon具体微架构仍未知。

隔离构建工作树 `/home/wheel/c00936152/rust-contains-stdlib` 快照用户当前library，独立输出 `/tmp/contains-stdlib-build`。为复用已有1.99编译器而不重建编译器，使用local-rebuild及stage0，并仅在隔离bootstrap中允许宿主std重建、安装重建产物。build-only修正存为bootstrap-local-rebuild.patch，实际用户仓库bootstrap未修改。未采用试验过的自定义JSON目标，两边最终都用内置GNU目标。

基线/优化sysroot按Cargo真实dist/build/*/*/out产物组装，不使用stage0自动复制来的旧宿主库。每个目标仅保存一个core/std/test版本，完整SHA清单为baseline-sysroot-manifest.json、optimized-sysroot-manifest.json；运行前逐文件核验。原有str测试安装的core也核验与优化快照相同，实际源码与已测pattern.optimized.rs逐字节一致。源码对照、应用构建参数和两个目标由同一编译器生成的命令均保存。

构建中曾误跟随sysroot源码链接，产生递归副本；已删除本任务副本并确认/tmp空间恢复。最终快照只取明确的目标库文件，原仓库和工具链未覆盖。交叉sysroot中libgcc_s运行库、LLD驱动名及Cargo版本兼容问题均已修正；失败日志保留，最终成功构建日志单列，不将失败产物计入测量。

## 语义验证

最终版本在两平台各通过5,573,952次独立对照，预期由窗口逐字节匹配、逐字符比较及显式谓词遍历计算，不用修改后的contains作为字符串/char预期。覆盖128种ASCII值、64种偏移、0..70及多个阈值/大长度至65536 B、未命中/首/中/尾、随机Unicode、空串、长needle、&String、字符数组/切片、FnMut访问次序。额外检查自定义Pattern覆写方法的调用和析构次数、借用有状态谓词行为。

原有coretests/alloctests中与str匹配的571项单元测试以及136项benchmark冒烟检查通过，共707项；包含本次新增两项测试。命令及原始输出在in-tree-str-tests-v2.log。未修改标准库公共API，没有新增inline属性，未提交或推送。

## 测量方法与计时干扰

最终第二版完成两平台28组完整libtest基准的main/优化交错三轮（每台168条），覆盖8个原始多字节bench_contains、8个contains_bang和12个空串/Unicode/NUL/集合/谓词补充项。haystack与needle每次查询统一black_box。另做144种动态needle输入的直接计数矩阵（每台864条）。

发现libtest同一二进制在不同轮次间出现约2倍墙钟波动。第一版x86 char长串的原始日志例：100.27 ns时CPU/墙钟约1.00，211.03/214.97 ns时CPU/墙钟约0.50；对同一基线补测为105.07 ns、CPU利用比例约0.986。这些记录在previous-v1/libtest-timing-audit.json、wall-control.json及原始日志。不能将墙钟ns乘以整进程CPU频率得到的“cycles估计”当作精确每调用周期，也不能把大波动全部归因于库算法。全局cgroup配额检查未发现throttling；具体外部抢占来源未追踪。

因此本节主表采用固定调用次数：保留28种benchmark的原始输入、查询体、assert/black_box，仅将自适应计时器替换成确定N的迭代驱动。每项每次200万或1000万调用，计数为cycles:u/N，未减空循环。包含每次查询的输入/结果屏障和循环成本；整进程一次性准备也计入后按N摊薄。它是完整查询体的受控复现，不等同于原始libtest调用栈。

基线/优化采用等长v0/v1运行路径，并只对被测进程关闭ASLR；程序自身读取personality确认标志实际继承。两平台每个case三次交错，中位数及min/max全部保存；CPU时间、墙钟和其比例也记录。原始libtest和144场景矩阵数据完整保留，未因不利结果删除。所有实际计数的PMU运行比例100%，x86 cpu_atom未计数事件排除。每台先语义核验，再libtest、固定计数、输入矩阵、采样，时间戳记录且无本任务性能阶段重叠。

## 最终结果：直接cycles/调用

变化为优化版相对本平台基线；负数表示减少周期。R=ARM cycles/x86 cycles。以下均为本节真实标准库、固定N对照，不能与前节外部原型或Rust1.101缓存数字拼接。

| 查询场景 | ARM前→后 | ARM变化 | x86前→后 | x86变化 | R前→后 |
| --- | ---: | ---: | ---: | ---: | ---: |
| bench_contains_16b_in_long | 523.70→531.40 | +1.5% | 312.59→318.25 | +1.8% | 1.675→1.670 |
| bench_contains_2b_repeated_long | 528.99→521.10 | -1.5% | 291.33→298.08 | +2.3% | 1.816→1.748 |
| bench_contains_32b_in_long | 515.63→517.75 | +0.4% | 296.45→302.46 | +2.0% | 1.739→1.712 |
| bench_contains_bad_naive | 24.67→25.06 | +1.6% | 24.03→20.37 | -15.2% | 1.027→1.230 |
| bench_contains_bad_simd | 289.26→281.62 | -2.6% | 315.58→235.87 | -25.3% | 0.917→1.194 |
| bench_contains_equal | 16.12→16.10 | -0.1% | 19.33→16.16 | -16.4% | 0.834→0.996 |
| bench_contains_short_long | 532.09→521.29 | -2.0% | 347.32→258.83 | -25.5% | 1.532→2.014 |
| bench_contains_short_short | 30.08→29.92 | -0.5% | 40.57→37.40 | -7.8% | 0.741→0.800 |
| contains_bang_char_long_lorem_ipsum | 691.15→143.41 | -79.3% | 473.86→129.02 | -72.8% | 1.459→1.112 |
| contains_bang_char_short_ascii | 38.98→11.10 | -71.5% | 47.07→14.17 | -69.9% | 0.828→0.783 |
| contains_bang_char_short_mixed | 44.04→13.12 | -70.2% | 44.62→13.15 | -70.5% | 0.987→0.998 |
| contains_bang_char_short_pile_of_poo | 19.33→13.10 | -32.2% | 43.51→13.08 | -69.9% | 0.444→1.002 |
| contains_bang_str_long_lorem_ipsum | 694.66→157.56 | -77.3% | 486.90→138.02 | -71.7% | 1.427→1.142 |
| contains_bang_str_short_ascii | 41.58→15.05 | -63.8% | 48.07→16.39 | -65.9% | 0.865→0.918 |
| contains_bang_str_short_mixed | 45.99→24.04 | -47.7% | 48.97→16.32 | -66.7% | 0.939→1.473 |
| contains_bang_str_short_pile_of_poo | 23.23→25.46 | +9.6% | 46.48→17.22 | -62.9% | 0.500→1.478 |
| extra_ascii_char | 596.36→147.66 | -75.2% | 487.84→128.24 | -73.7% | 1.222→1.151 |
| extra_char_array | 19.09→19.09 | +0.0% | 13.81→13.75 | -0.4% | 1.383→1.389 |
| extra_char_slice | 28.10→28.33 | +0.8% | 22.85→22.79 | -0.3% | 1.230→1.243 |
| extra_empty | 8.43→8.44 | +0.1% | 7.28→7.29 | +0.1% | 1.157→1.158 |
| extra_empty_in_long | 8.37→8.38 | +0.1% | 7.28→7.27 | -0.0% | 1.150→1.153 |
| extra_longer_needle | 8.85→8.61 | -2.7% | 7.25→7.26 | +0.2% | 1.220→1.185 |
| extra_nul_str | 591.48→147.83 | -75.0% | 495.17→137.83 | -72.2% | 1.194→1.073 |
| extra_predicate | 12.10→12.10 | -0.0% | 8.78→9.08 | +3.4% | 1.377→1.332 |
| extra_unicode_char_hit | 53.87→52.94 | -1.7% | 58.84→61.09 | +3.8% | 0.915→0.867 |
| extra_unicode_char_miss | 471.87→472.95 | +0.2% | 277.25→260.12 | -6.2% | 1.702→1.818 |
| extra_unicode_str_hit | 50.63→49.51 | -2.2% | 55.43→56.82 | +2.5% | 0.913→0.872 |
| extra_unicode_str_miss | 469.68→470.11 | +0.1% | 274.91→254.31 | -7.5% | 1.708→1.849 |

ARM原始2551 B末尾命中的字符串查询694.66→157.56 cycles（−77.32%），x86 486.90→138.02（−71.65%），R从1.427降至1.142。char版本R从1.459降至1.112。NUL与~同样改善，收益不依赖 `!`。这些收益属于相应的单字节扫描输入，不能推广到整个contains接口的任意调用。

回退完整列出：ARM short_pile_of_poo字符串65 B为23.23→25.46 cycles（+9.6%）；该输入唯一!在末尾，当前实现首64 B未命中后又重读最后64 B，额外重叠工作已确认，但未单独隔离该回退的全部成本。多字节16 B针长串约+1.5%/+1.8%（ARM/x86）；Unicode字符命中x86约+3.8%，谓词约+3.4%。多字节/集合/谓词算法未改，其他变化不归为SIMD算法收益，代码生成/布局等影响尚未完全分离。

## 地址、长度与动态字节值范围

合成矩阵为8/16/32/64/128/256/2551/65536 B、地址mod64=0/1、首/尾/未命中、needle=NUL/A/~，共144场景。needle由命令行运行时提供，每调用black_box；实际输入为ASCII填充与指定匹配，不是lorem或真实Unicode数据。cycles使用已知N直接相除，矩阵保留通常ASLR条件，与关闭ASLR的主表条件区分。

| 长度/偏移/needle/命中 | ARM前→后 cycles | x86前→后 cycles |
| --- | ---: | ---: |
| 8/0/A/首 | 11.53→11.58 | 9.88→12.09 |
| 16/0/A/首 | 17.26→18.25 | 20.09→23.74 |
| 32/0/A/未命中 | 20.26→20.26 | 24.01→21.11 |
| 64/0/A/尾 | 42.26→16.55 | 52.49→20.69 |
| 128/0/A/首 | 17.26→13.45 | 20.13→15.37 |
| 2551/1/NUL/未命中 | 686.46→186.79 | 503.36→145.96 |
| 65536/1/~/未命中 | 17003.70→3520.86 | 11031.51→3312.80 |

该合成矩阵90个长度至少64 B的场景均改善：ARM降5.4%–79.5%，x86降10.9%–73.0%。但真实65 B fixture仍有上述ARM回退，因此不能说所有≥64 B输入都改善。极短输入虽保留原算法，新增入口判断和代码生成仍有成本；矩阵最大回退ARM约7.1%、x86约27.6%，具体场景/范围见JSON。当前仅验证固定重复热数据；冷缓存、随机切换needle/命中位置、其他CPU和native/LTO构建未测。

第一版曾对16 B以上直接进入SIMD，短/提前命中真实计数有较大回退。最终版本收紧至64 B并加首字节快速返回；previous-v1/保留其完整实现、库、原始记录和控制实验。主表仅使用第二版，不拼接不同版本中最好值。

## 证据、复现与剩余限制

实际源码修改已经留在远程原仓库上述两文件。持久证据归档于 `analysis/repro/contains-stdlib-20261105/`，common/包含标准库补丁、原文件/最终文件、构建配置和日志、隔离bootstrap修正、独立检查及完整驱动；aarch64/、x86_64/含每台程序、运行时动态库、IR/汇编、原始perf、三轮统计与计时审计；previous-v1独立保留前版数据。原始运行目录两端均为 `/tmp/contains-stdlib-20261105/`。完整静态sysroot元数据和工具链未全复制到精简归档，其SHA清单与构建命令保留；隔离源码工作树保持可复核。

```sh
# 在隔离工作树，按common/bootstrap.toml及bootstrap-local-rebuild.patch配置：
./x build --stage 0 library/std library/test --target aarch64-unknown-linux-gnu,x86_64-unknown-linux-gnu
./x test --stage 0 --set build.compiletest-allow-stage0=true library/coretests library/alloctests --target aarch64-unknown-linux-gnu --test-args str::
# 按build-harness.py，以保存的基线/优化sysroot分别构建：
python3 build-harness.py optimized check custom-check benches matrix counted
# 运行对应机器的已构建程序（先正确性，后性能阶段串行）：
python3 run-checks.py
python3 run-benches.py
python3 run-counted.py
python3 run-matrix.py
```

runtime归档可直接用run-counted.py、run-matrix.py配合已构建程序运行；run-final.py的逐文件静态元数据校验和重新编译需要完整sysroot。x86交叉链接依赖归档配置中的clang/LLD与匹配C运行库；ELF解释器是本机Nix glibc路径。工具链rustc1.99/LLVM23.1.0、原始target-cpu未知；本轮内置目标未指定target-cpu，ARM默认NEON、x86默认SSE2，应用参数统一 `-O --edition=2024 -Cprefer-dynamic -Zinline-mir -Cllvm-args=-import-instr-limit=10`。未新启用inline属性；继承的应用MIR选项两边一致。完整编译器、CPU、kernel、libc、perf、源码SHA和三轮范围见comparison.json及common/。

结论限定为：完整标准库接口内的通用单字节长扫描有已测显著收益，保留所有Pattern功能；短输入和部分真实fixture仍有回退，尚不能作为无条件的contains通用性能改进。没有对未测路径宣称收益，也没有宣称多字节搜索算法已经优化。
