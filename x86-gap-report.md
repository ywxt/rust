# 920B 与 x86 的性能差距

比较对象为 HiSilicon 920B（2.9 GHz）与 Intel i7-12700 P 核。标准库测试提交为 `07e526db9df`，编译器为相同版本的 rustc 1.101.0-dev、LLVM 23.1.4；glibc 分别为 2.38 和 2.42。

`R = ARM cycles / x86 cycles`。R=1.30 表示完成相同工作时 ARM 多用 30% 的周期。以下先总结原因和代表性 benchmark，再列出已合入上游的修改方法。原始测量与 PR 数据分别保留各自的版本、输入和计时范围。

## 原因总结

### 源码缺少 NEON 路径

源码只为 x86 启用 SSE2 分块处理时，ARM 会执行逐元素判断和索引更新，长输入的指令数随元素数量增长。此类问题需核对平台条件、长度条件和测试版本。

| 接口与 benchmark | 原因及适用范围 | 证据 |
|---|---|---|
| `[u8]::is_ascii`；`ascii::*::case00_libcore` | 早期实现提供 x86 SSE2 路径，AArch64 缺少对应 NEON 路径。PR #160143 已补齐，测试版本已包含 | 原 PR 的 long 对照从 19.69 降到 6.46 ns；该数据说明合入前缺少 NEON 的成本 |
| `[u8]` / `str::eq_ignore_ascii_case`；`str::eq_ignore_ascii_case::bench_large_str_eq` | PR #160143 将至少 16 B 的分块路径扩展到 AArch64 NEON；测试版本在此长度已具备 SSE2/NEON 对应实现 | 原 PR 的长字符串对照从 6235.89 降到 546.61 ns |
| 同一接口，4–15 B；`bench_str_of_8_bytes_eq` | 测试版本的短输入仍使用逐字节比较。该长度在两平台均未进入上述 16 B 路径，不能归为仅 ARM 缺少对应实现 | 原始 8 B benchmark 的 R≈1.05；ARM 短输入 NEON 原型说明仍有优化空间，但没有证明明显的跨机差距 |

源码平台条件已在测试提交的 `library/core/src/slice/ascii.rs` 核对。现行版本的剩余差距按下列具体原因分析。

### LLVM 优化产生低效代码

以下问题已通过生成代码、关闭具体优化或固定代码地址的对照确认。

| 原因 | 代表性接口和 benchmark | 实验解释 |
|---|---|---|
| 将难以预测的条件选择改成分支 | `BinaryHeap::from/pop`；`binary_heap::bench_from_vec`、`bench_find_smallest_1000` | ARM 的 select-optimize 将随机子节点选择改成跳转。关闭后 ARM 从 1830893 降到 1160030 cycles，x86 为 1197668，解释主要差距。[L01](analysis/repro/L01-select-opt/) |
| 将可预测分支改成条件选择，增加地址依赖 | 手写 UTF-8 字符计数；`str::char_count::ru_huge::case03_manual_char_len` | early-ifcvt 生成 csel，使下一字符地址依赖当前判断。保留分支后 ARM 从 8.16 降到 1.80 cycles/字符，x86 为 1.76–2.35；中文输入只减少约 0.13。[L02](analysis/repro/L02-ifconv-csel/) |
| 循环出口比较多生成整数指令 | `SkipWhile::fold/try_fold`；`iter::bench_skip_while_sum`、`bench_skip_while_ref_sum` | LSR 与常量提升的组合使每元素多一条 add。消除后 ARM 从 1.873 降到 1.036 cycles/元素，x86 约为 1.006。[L04](analysis/repro/L04-lsr-cmp-imm/) |
| 向量加载和重排选择不佳 | `str::chars().count()`；`str::char_count::*::case00_libcore`；结构体字段抽取 `vec::bench_map_fast/regular` | chars count 的 ld4 和临时栈存取使 ARM 为 0.1862 cycles/B；关闭该加载选择后为 0.1486，x86 为 0.1499。字段抽取中，VectorCombine 将 8 个 i32 加载缩成 7 个，产生逐 lane 加载和搬移；关闭约快 6%，完整 benchmark 仍有剩余差距。[L03](analysis/repro/L03-interleave-ld4/)、[L07](analysis/repro/L07-aos-ld1-lane/) |
| 栈槽复用与写入配对增加写后读等待 | `Any::downcast_ref`；`any::bench_downcast_ref` | 两个指针分别写入，不同宽度临时值又共用栈槽。固定指令地址的组合对照从 20.05 降到 4.97 cycles，参考程序为 4.88。单独调整其中一项不足以消除等待；源码修法尚未验证。[Any 对照](analysis/data/unknown-causes-20261103/sret-clean.aarch64.json) |

分支和条件选择的优劣取决于预测准确率及数据依赖。前两项分别需要保留无分支选择和保留可预测分支，不能使用统一规则。

### 硬件执行能力存在差异

相同算法会因指令吞吐、依赖延迟和访存能力不同，产生不同成本。算法的循环组织和数据访问方式决定了这些成本出现的次数。

| 原因 | 代表性接口和 benchmark | 测量及解释 |
|---|---|---|
| 整数指令吞吐较低 | Iterator 计数与筛选；`iter::bench_enumerate_ref_sum`、`bench_next_chunk_filter_map_even` | 独立 add 每轮 16 条时为 4.36/3.10 cycles，32 条时为 8.36/5.61。受测 ARM 约每周期完成 4 条，x86 接近 6 条。额外索引、计数和控制指令更容易限制 ARM 吞吐；物理端口数尚未直接确定。[B7](analysis/repro/B7-alu-throughput/) |
| 数据相关分支难以预测 | `Vec::retain/retain_mut`、`VecDeque::retain`；`vec::bench_retain_100000` 及随机保留比例的独立对照 | 首个删除元素之后，每元素都要根据谓词结果选择删除或搬移。随机结果增加误预测；写索引还依赖保留结果。当前已确认这些操作的优化空间，尚无同条件双平台分解数据能确定各项占跨机差距的比例。VecDeque 另有环形索引和交换成本。[retain 对照](optimizable-interfaces.md) |
| 指令依赖链延迟较高 | `extract_bits`、u16 fold；`num::int_bits::*::extract_bits`、`fold_u16` | 受测 NEON 移位、异或依赖延迟约 2 cycles，SSE 约为 1。多级运算累积延迟。u16 fold 的独立交错数量从 2 改到 4 后，ARM 从 0.254 降到 0.182 cycles/元素，x86 为 0.198→0.200。[S6](analysis/repro/S6-neon-latency/)、[L14](analysis/repro/L14-fold-u16-interleave/) |
| 写后读依赖延迟较高 | `Vec::push`、`String::push`、RandomState 计数器；`slice::push`、`string::bench_push_char_two_bytes`、`hash::map::new_drop` | 同地址状态读改写链约为 7.07/1.00 cycles。Vec push 对照将 len 保存在局部变量后，ARM 从 7.14 降到 2.03，x86 约为 2。HashMap 创建测试主要耗时来自线程局部计数器，R≈6.93。[B1](analysis/repro/B1-store-load/) |
| SIMD 比较结果提取为索引的成本较高 | memchr、`str::find/contains`、`Vec::dedup`；`str::find_zzz_char`、`vec::bench_dedup_none_*` | x86 可用 pmovmskb 压缩比较结果，ARM 需要多条归约和寄存器传送指令。密集命中对照为 27.0/16.6 cycles，长无匹配为 218/277，差距随命中分布变化。[L11](analysis/repro/L11-movemask/)、[S2](analysis/repro/S2-mask-floor/) |
| 未对齐或跨缓存行访问增加成本 | Vec 插入与结构体字段抽取；`slice::random_inserts`、`vec::bench_map_fast/regular` | 16 B 未对齐加载每条额外成本约为 ARM 0.30、x86 0.04 cycle。x86 字段加载的固定地址对照，消除跨行访问后从 7993.8 降到 6021.0 cycles，指令数相同。该字段实验使用两个字段内容相同的数据，通用改法仍需保留原字段值。[B6](analysis/repro/B6-unaligned/)、[字段加载对照](analysis/data/unknown-causes-20261103/aos-split-loads.x86_64.json) |
| 宽整数除法及溢出检查的指令支持不同 | `u128::isqrt`、整数解析；`u128_sqrt_uniform`、`num::bench_u64_from_str_radix_10` | 受测 65÷33 位除法在 ARM 进入 u128 软件路径，约为 37.19 cycles；x86 硬件除法为 19.05。数值范围允许缩为 u64 后为 14.02/16.04。乘法溢出检查中 ARM 需要高半部及比较，x86 可用溢出标志。[B3](analysis/repro/B3b-u128-div/)、[L06](analysis/repro/L06-smul-overflow/) |
| 加载吞吐和工作集容量不同 | `VecDeque::Iter::try_fold`、切片 rotate、二分查找；`vec_deque::bench_try_fold`、`slice::rotate_huge_by9199_big`、`binary_search_l3_with_dups` | 独立 64/128 位加载约为 ARM 每周期 2 条、x86 3 条。40 MiB 数据超出 x86 约 25 MB 的 L3，仍可容纳于 ARM 约 70 MiB 的 L3，部分 rotate 因此 ARM 较快。大步长访问会进一步增加缓存和地址转换开销。[S4](analysis/repro/S4-load-width/)、[M1](analysis/repro/M1-tlb-stride/)、[M5](analysis/repro/M5-l3-capacity/) |

retain 的数据相关分支是算法中需要执行的工作；跨机差距还取决于实际预测结果和生成代码。SVE COMPACT 属于降低压缩成本的手段，具体原因仍按分支、索引依赖和搬移操作分析。

### 已定位耗时，但具体成因尚未完全确定

| 问题与代表性 benchmark | 已确认的部分 | 尚未确定的部分 |
|---|---|---|
| 小块分配；`vec::bench_from_slice_0100`、`linked_list::bench_collect_into` | 800 B malloc+free 为 31.36/17.72 cycles，指令数为 155/97。主要差距来自 ARM 分配路径执行更多指令。8000 B 时为 70.11/70.40 cycles，已接近。[G4](analysis/repro/G4-malloc/) | glibc 版本与指令集分别造成多少额外指令。tcache_count 从 7 改到 64 时两平台均改善约 26–27%，没有解释相对差距 |
| 复制与填充；`vec_deque::bench_from_array_1000`、`vec::bench_extend_*` | 8 KB memcpy 约为 ARM 333、x86 138 或 220–222 cycles；两平台使用不同 libc 实现。1000 B memset 为 41.43/22.82；同宽 16 B 完全展开对照为 39.18/34.79。[G3](analysis/repro/G3-memcpy-variant/)、[填充对照](analysis/data/unknown-causes-20261103/fill.aarch64.json) | 库实现、指令宽度和硬件带宽对总差距的各自贡献。现有 ARM NEON/SVE 复制原型尚无稳定优势 |
| 多层 PLT 调用；`fmt::write_u8_max` 等短整数格式化 | 相同 format! 动态 PLT 调用为 153.25/106.19 cycles，非 PLT 为 108.16/106.49。ARM 前端停顿显著下降；固定地址和纯算术深调用均重现。[调用链对照](analysis/data/unknown-causes-20261103/chain.aarch64.json) | CPU 内部哪项取指或预测资源造成停顿。返回误预测数据不足以解释该差距 |
| Unicode 查表与独立查询；`str::debug::mixed`、`slice::binary_search_l1_worst_case`、部分 Zip 测试 | 批量交错完整 Unicode 查表，1 个字符时为 30.75/23.96、8 个时为 17.23/16.00 cycles/字符。说明增加独立工作有效。[查表对照](analysis/data/unknown-causes-20261103/batchfull.aarch64.json) | 原标准库中未充分重叠执行的具体限制。两平台 ROB 容量拐点接近，不能用 ROB 容量解释 |
| 整数分区；`slice::sort_unstable_large_random`、`select_nth_unstable(1024)` | 整体排序 R≈1.17；select_nth 对照为 7176.9/5479.4 cycles。多种 LLVM 开关及布局变化均未消除差距，单轮手写分区也未重现 ARM 劣势。[U1](analysis/repro/U1-sort-state/) | 多轮数据状态、读写依赖与前后控制代码的分别贡献 |

### 测量条件影响

极短循环会受代码地址影响：相同 6 条指令改变 0–60 B 偏移，ARM 可从 1.007 变到 1.627 cycles/元素。slice push 的 x86 测试存在大量缺页，同核 pipe 自旋测试受调度影响；ASCII LONG 还包含分配复制和提前退出。相关结果使用单项对照解释。[布局实验](analysis/repro/F2-layout/)、[计时范围](analysis/repro/N4-bench-validity/)、[调度对照](analysis/repro/K2-spin-pinned/)

## 已合入上游的修改方法

对应原因说明这些方法减少了哪些成本；PR 的单平台收益保留其原测量条件。测试版本已包含其中 5 项，相关收益已计入基线。

### 补齐 NEON 路径

| 已合入 PR 与接口 | 具体修改 | 对应原因与代表性 benchmark | 测试版本 |
|---|---|---|---|
| [#160143](https://github.com/rust-lang/rust/pull/160143)；`[u8]::is_ascii`、`[u8]` / `str::eq_ignore_ascii_case` | is_ascii 使用 NEON，每 64 B 合并四个向量后做一次归约；大小写无关比较将至少 16 B 的分块路径扩展到 NEON | 补齐 x86 已有而 AArch64 缺少的批处理路径，减少逐字节控制。对应 `ascii::*::case00_libcore`、`str::eq_ignore_ascii_case::bench_large_str_eq` | 已包含；短输入仍按实际路径分析 |

### 根据硬件成本调整算法与运算形式

| 已合入 PR 与接口 | 具体算法或运算修改 | 减少的成本与代表性 benchmark | 测试版本 |
|---|---|---|---|
| [#162810](https://github.com/rust-lang/rust/pull/162810)；`Vec::dedup` | 先分块比较相邻元素，找到首个重复后才进入压缩和析构流程；无重复时直接结束 | 减少无重复区间的逐元素分支和索引操作，使比较可并行执行。`vec::bench_dedup_none_1000` 的原 PR ARM 对照为 495→129，耗时降低约 74%；随机重复和全重复的收益较小 | 已包含 |
| [#163521](https://github.com/rust-lang/rust/pull/163521)；`BTreeMap` 迭代和范围迭代 | 在同一叶节点内直接递增或递减索引，仅到节点边界才进入通用导航 | 减少每元素句柄替换、状态搬移和导航判断，降低整数吞吐及依赖链压力。对应 `btree::map::iteration_*`、`range_iteration_*` | 已包含 |
| [#162931](https://github.com/rust-lang/rust/pull/162931)；`BTreeMap` / `BTreeSet` 释放及 clear | 按节点后序处理并释放节点，节点内完成必要的元素析构 | 减少逐元素导航和游标更新，降低释放过程的重复整数操作。对应 `btree::map::clone_slim_*`、`clone_slim_*_and_clear`；这些测试包含对象释放 | 已包含 |
| [#162750](https://github.com/rust-lang/rust/pull/162750)；`char::to_lowercase/to_uppercase` | 对 Latin-1 使用范围判断、固定偏移和少数特殊映射，减少通用 Unicode 表查询 | 减少依次执行的加载、比较和下一地址计算，缩短查表依赖链。对应 `char::methods::bench_non_ascii_char_to_lowercase`、`bench_non_ascii_char_to_uppercase`；非 Latin-1 仍走原查表路径 | 已包含 |
| [#164611](https://github.com/rust-lang/rust/pull/164611)；整数 `extract_bits`，宽度至多 64 位 | 利用两个位区段不重叠，将异或形式改为等价加法，使 AArch64 可生成 usra | 减少多级移位和异或的依赖成本。u64 invariant 原 PR 对照为 288.77→211.51 ns。u128 保留原式，避免跨字进位链 | 未包含 |
| [#162754](https://github.com/rust-lang/rust/pull/162754)；切片 `rotate_left/right` | 对满足大小和对齐条件的大元素，按多个机器字组织旋转，使算法采用连续块交换；一侧足够小时切换为带缓冲的 memmove | 减少 gcd 的大步长访问、较大临时值及尾部大量小交换。对应 `slice::rotate_huge_by9199_big`、`rotate_huge_by1234577_big`、half_plus_one 组；原 PR 前两项耗时分别降低约 48.4%、23.2% | 未包含 |

这些修改通过减少指令数、缩短依赖链或改善访问顺序，适应硬件成本差异；跨平台通用改进仍需分别比较两平台收益。LLVM 原因表中的问题尚无本报告所列已合入 PR 的对应修复。

## 数据来源

原因实验通常测三轮，使用周期最少一轮的配套计数，原始文件保留全部结果。全套 benchmark 原始结果包含多核并行及 x86 仅用户态计数，涉及缺页和系统调用时采用单项重测。PR 合入记录核对日期为 2026-11-03。

- [92 个分类条目及测量索引](analysis/data/classification.json)
- [逐项 benchmark 分析](benchmarks-conclusion.md)
- [双平台原因实验与复现命令](analysis/data/unknown-causes-20261103/README.md)
- [上游 PR 的状态、代码与测量来源](analysis/data/repair-classification-20261103/upstream-pr-index.json)
