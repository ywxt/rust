

# `str::contains_bang_*`：字节扫描、ARM 配对加载与布尔归约（2026-11-05）

本节为个人实验，不用于上游贡献。未修改标准库实现，未添加 `inline` 属性；源码原型、注释与本报告均由 LLM 辅助生成。实验沿用既有编译配置中的 `-Zinline-mir`，所有对照保持一致。

## 结论与优化方向

| 归因 | 证据 | 对应方法与限制 |
| --- | --- | --- |
| 标准库两端均为标量 SWAR 扫描，ARM 配对加载对输入对齐更敏感 | 原始热点在 Rust memchr；同一缓冲区仅改变偏移，ARM 标准路径约 596→673 cycles，x86 约 457 不变 | 用布尔 SIMD 扫描减少工作量；长串扫描主体对齐至 32/64 B，64 B 在本次 ARM 最好 |
| LLVM 将“是否有匹配”降为完整匹配掩码，ARM 生成多余归约 | 64-lane fold 在 ARM 出现 12 条 ADDP、4 条 UMOV；x86 合并比较后一次 PMOVMSKB | 显式 NEON 比较、向量 OR、布尔归约；纯 Rust columns 改写未阻止 LLVM 合并回相同 IR |
| 短串曾被优化器移出计时循环 | 早期约 0.35/0.21 ns、每轮约 3 条指令，没有每轮扫描 | 最终 v8 对全部基线和原型每次查询统一 black_box 输入，并核验循环汇编与动态指令；早期数据排除 |

ARM 原始长串 cycles 约为 x86 的 1.47 倍。公平的完整基准复现中，64 B 对齐的布尔 SIMD 原型使该比例降至约 1.24，ARM cycles 减少约 77.6%。这不是重建标准库后的性能承诺，也不是所有输入的通用最优方案。

## 被测语义与原始基准

八个基准来自缓存源码 `library/alloctests/benches/str.rs`，分别调用 `contains("!")` 与 `contains('!')`。实际字节长度与唯一 `!` 的索引为：

| 输入 | 字节数 | `!` 索引 |
| --- | ---: | ---: |
| short_ascii | 64 | 63 |
| short_mixed | 65 | 64 |
| short_pile_of_poo | 65 | 64 |
| long_lorem_ipsum | 2551 | 2550 |

所有输入都在末尾命中，因此扫描几乎全串。ASCII 字符与单字节字符串最终走相同的字节查找路径，经 slice contains 到 `core::slice::memchr::memchr_aligned`；查询没有分配，也无需逐字符解码 UTF-8。

原始缓存二进制各跑三次，中位数如下。cycles 为 libtest ns 乘以 perf cycles/task-clock 得到的估计值，并非已知迭代次数直接相除；整进程 IPC 包含 harness。

| 原始长串 | ARM ns | x86 ns | ARM cycles估计 | x86 cycles估计 | cycles 比 |
| --- | ---: | ---: | ---: | ---: | ---: |
| str | 231.24 | 97.48 | 661.58 | 450.26 | 1.469 |
| char | 230.98 | 97.49 | 660.53 | 449.63 | 1.469 |

原始 str 长串 ARM/x86 时间比约 2.37，采样期间有效频率约 2.865/4.605 GHz。不能把时间比直接当作每周期效率差。ARM/x86 每查询指令估计约 2272/2738，分支失误约 0.20/1.00；ARM 更慢不能归因于它执行更多指令或更多分支失误。

perf record 的长串热点约 99.32%/99.12% 在动态 libstd 内的 Rust memchr，并非 libc memchr。两端都是每轮处理两个 u64 的 SWAR，不存在“x86 已用 SIMD、ARM 没用”的基线差异。ARM 循环有 LDP、两组 XOR/减法/OR、合并与条件跳转；x86 使用两次独立 64 位加载。

## 对齐与配对加载：受控证据

从原始 ELF 定位并校验完整 2551 B 字符串，ARM 地址为 0x2be2f2，x86 为 0x2dbb2，两者 mod64=50、mod16=2。原始数据 SHA256 为 `90193bdd9191b6e811547ba3ade0f940bdf5f292c066a07e48eb69564ae1e909`。PIE 页对齐偏移保持这些低位不变。标准实现仅将指针对齐到 8 B，此后 ARM 的 16 B 配对加载主体 mod16=8。

固定循环探针将同一输入复制到 64 B 对齐缓冲区，改变起始偏移；准备工作在循环外，查询内部的前缀、尾部与对齐开销全部计入。以下为三次中位数，cycles 直接用 cycles:u/已知查询次数计算，与上表估计法分开。

| 起始偏移 | ARM std | ARM word16 | ARM simd64 | ARM 对齐16后扫64 | ARM 对齐32后扫64 | ARM 对齐64后扫64 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 0 | 595.64 | 490.80 | 142.18 | 142.08 | 141.63 | 141.54 |
| 8 | 673.13 | 546.84 | 181.15 | 185.26 | 146.98 | 141.48 |
| 16 | 591.09 | 490.54 | 180.32 | 186.07 | 146.99 | 145.87 |
| 32 | 594.24 | 490.48 | 141.82 | 142.09 | 141.66 | 144.10 |

x86 标准路径在这些偏移下约 456.5–456.8 cycles，变化很小。16 B 对齐不足以保证 ARM 向量配对加载达到本次最优，32/64 B 对齐才消除了主要周期惩罚。旧函数名 `aligned64` 指的是“对齐到16 B后每轮扫64 B”，不是最终 `align64_scan64`。

进一步在同一探针源码上用 `-Cllvm-args=-aarch64-enable-ldst-opt=false` 诊断，汇编确认 word16 的 LDP 拆成独立 LDR，SIMD 配对加载也拆开。此选项只作用于探针 crate，预编译 libstd 未重建。

| 偏移 | word16 默认/拆开 cycles | simd64 默认/拆开 cycles |
| --- | ---: | ---: |
| 0 | 490.80 / 534.09 | 142.18 / 135.68 |
| 8 | 546.84 / 535.49 | 181.15 / 173.97 |
| 16 | 490.54 / 533.28 | 180.32 / 136.34 |
| 32 | 490.48 / 533.56 | 141.82 / 136.38 |

拆开配对加载能改善部分偏移，但也让自然对齐的 word16 回退约 9%；不能推荐全局关闭该 pass。SIMD 偏移16时拆开显著改善，偏移8仍有惩罚，与单条16 B加载和配对加载的对齐条件不同相符。证据支持“配对加载与对齐相关的成本”，不足以确定具体缓存 bank、端口或未公开微架构机制；剩余跨平台差距未完全分离。

## LLVM 布尔归约的额外工作

安全 Rust `fold64` 每64 B做比较并 OR 到一个 bool。pass trace 显示 SLP 先构造 `load <64 x i8>`、比较及 `llvm.vector.reduce.or.v64i1`；InstCombine 随后将其变成 `<64 x i1>` bitcast 到 i64 再判非零。ARM 循环因而计算完整掩码：四组比较/掩码 AND，以及12条 ADDP、4条 UMOV；结果实际只需要一个布尔值。x86 将四组比较 OR 后仅一次 PMOVMSKB。

显式 NEON 原型四组比较后先向量 OR，再用 `vmaxvq_u8(...) != 0` 表达布尔归约；实测后端生成紧凑的 ORR×3、ADDP d、FMOV、CBNZ，不要求最终一定出现 UMAXV。x86 对照使用 SSE2 实现相同逻辑，无需 AVX 才能获得收益。

同一固定循环长串对照：ARM fold64 361.63→显式 SIMD 170.58 cycles，x86 130.49→130.33，cycles 比从约2.77降至1.31。该组与后续对齐矩阵的地址、函数布局不同，不能拼接为同一组逐步收益。

失败方向也保留：纯 Rust columns64 仍被优化成相同宽向量/掩码；`-force-vector-width=16` 未改变热点（这里是 SLP）；禁用 SLP 使 ARM fold64 约362.28→1369.42 cycles，指令约1321→7755，不应作为优化方法。仅 ARM 测了这些编译器选项，未据此推断标准库整体收益。

## 源码原型与完整基准复验

原型只优化 ASCII `!` 的 contains 布尔语义，不能直接替换要求返回索引的 memchr。每64 B四组向量比较、OR、判非零；不足64 B走短串路径，末尾用最后64 B重叠扫描，不越界。长度至少128 B时才尝试主体对齐；先检查起始64 B覆盖前缀，再从64 B边界继续扫描。所有操作在字节切片上，不在任意 UTF-8 字节边界切割 str。

最终 v8 在每次查询对所有基线及变体统一 `black_box(s)` 输入，保持结果 black_box、每轮一次查询、原始四种输入与两个 API。额外输入屏障改变了基准开销，因此仅在同一 guarded 构建内比较，不与未经屏障的原始缓存数字拼成收益。每个 case 三次，以下为中位数（ns / cycles估计）：

| 长串版本 | ARM str | x86 str | ARM char | x86 char |
| --- | ---: | ---: | ---: | ---: |
| 标准 contains | 231.02 / 667.44 | 98.64 / 454.46 | 232.40 / 670.51 | 98.91 / 459.32 |
| 布尔 SIMD | 57.14 / 165.05 | 25.72 / 120.71 | 57.18 / 164.83 | 25.75 / 120.58 |
| 32 B 对齐 SIMD | 53.37 / 154.09 | 27.81 / 130.13 | 52.52 / 151.61 | 27.91 / 130.29 |
| 64 B 对齐 SIMD | 51.92 / 149.82 | 25.97 / 120.99 | 51.88 / 150.01 | 26.03 / 121.60 |

str 的64 B对齐原型使 ARM cycles 667.44→149.82（−77.55%），x86 454.46→120.99（−73.38%），同方法 cycles 比 1.469→1.238。ARM 指令估计约2302→633。ARM 在显式 SIMD 之上增加64 B对齐约再降9.2%；x86 120.71→120.99基本持平，32 B对齐反而回退到130.13。

短串对照也全部完成，以下为标准/64 B对齐原型的 cycles估计；短串实际走 SIMD 短路径，不做长串对齐。

| 输入 | ARM 标准/原型 | x86 标准/原型 |
| --- | ---: | ---: |
| short_ascii | 41.56 / 26.91 | 38.72 / 3.98 |
| short_mixed | 35.95 / 10.39 | 39.91 / 6.98 |
| short_pile_of_poo | 37.14 / 10.40 | 41.78 / 6.95 |

回退边界：固定循环长串若首字节命中且输入64 B对齐，ARM simd64→align64 为6.07→7.07 cycles，x86 7.21→9.20。未命中、偏移1的 ARM 为181.39→142.16，显示收益不是仅靠末字节命中。前缀检查和对齐判断有成本；不能把本次末尾命中的77.6%推广至任意长度、地址或匹配位置。

早期 aligned16 短串约0.35 ns（ARM）/0.21 ns（x86）的结果被排除：扫描被提升至循环外，仅剩约3条指令。另有早期 harness-v5 的 x86 第三轮末段与控制实验重叠，也排除。原始记录均保留于 excluded-data.json 所列路径。最终 v8 每台按“偏移矩阵→完整基准→采样”串行执行，journal 记录顺序；96条基准记录均检查动态指令，并以采样汇编确认每轮重复扫描。所有实际计数的硬件 PMU 运行比例为100%；x86 cpu_atom 的未计数事件不参与计算。

正确性：两端最终各通过292,320次对照，覆盖10种方法、64种偏移、0..70/95..130及255/256/257/1023/1024/2551/4096长度，未命中/首/中/尾命中及 Unicode；另各通过120次真实 fixture 对照（原始/无命中/前缀命中）。没有对生产源码做修改或提交。

## 环境、证据与复现

ARM 固定核52，HiSilicon具体型号/微架构未取得；x86为 i7-12700 P核12。两端 stage1 rustc 1.101.0-dev、LLVM23.1.4；原始编译的 target-cpu 未恢复，明确记为未知。原型 `-O --edition=2024 -Cprefer-dynamic -Zinline-mir -Cllvm-args=-import-instr-limit=10`，未指定 target-cpu，ARM 默认 NEON、x86默认 SSE2。环境完整信息保存在 environment.json（含优化配置 cfg、lscpu、kernel、libc、perf）。

基线来自 `/tmp/xdiff-src` 缓存源码及 `/tmp/xdiff/bins.txt` 二进制，缓存 HEAD `8fcaaf4c3fe47544c8d857e421ec258e7b06be96`。远程当前工作树的 memchr/cmp/pattern 文件与缓存存在实际差异，不能宣称已重建当前工作树；相关 diff 与源码哈希见 source-work-vs-cache.json。基准宏及相关 contains 源片段两端/工作树一致。

证据归档：本仓库 `analysis/repro/str-contains-bang-20261105/{aarch64,x86_64}/` 保存两端源文件、原始 perf、IR/汇编、pass trace、验证输出、环境与排除清单；comparison.json 为跨平台汇总。运行时原目录为两端 `/tmp/str-contains-bang-20261105/`，以下命令在对应机器该目录运行。复现依赖既有 `/tmp/xdiff` 工具链与动态库，归档不包含完整工具链。

```sh
python3 reproduce.py build bang-probe-v7
python3 reproduce.py check
python3 reproduce.py build bang-benches-v8
python3 reproduce.py perf str::contains_bang_str::long_lorem_ipsum
python3 reproduce.py perf str::align64_str::long_lorem_ipsum
python3 reproduce.py probe simd64 3 16 original
python3 reproduce.py probe align64 3 16 original
```

reproduce.py 自动绑定核、为 perf 清除外部 LD_LIBRARY_PATH、为子进程设置对应 libstd。完整串行重复步骤见 run-v8.py；已测二进制保留，build 生成到 rebuilt/避免覆盖。核心证据索引：analysis-summary.json、matrix-v8-results.json、guarded-v8-no-hoisting-check.json、v8-run-journal.json、original-input-address.json、ldp-alignment/、llvm-fold64/。最终源码 SHA256：

- bang-probe-v7.rs：`3618d886c33b97d9182552f702b45248a2bb17544a120cbc2e70417f3cc5629c`
- bang-benches-v8.rs：`b67bed3c6c9e7672e4884b8de1f7785b4462f7228646439ddb1ce844df8aaf2e`
- fixtures.rs：`2737f318272d13623d98874a4224eb2bd775c2c4583d6b647b94cefb10c017e9`
