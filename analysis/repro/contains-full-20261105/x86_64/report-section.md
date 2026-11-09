

# 完整 `contains<P: Pattern>` 语义与运行时 needle 复验（2026-11-05）

范围更正：前两节固定 `!` 原型只能说明专用单字节扫描路径，不能据此声称完整 contains 接口有优势。本节使用运行时 needle 和完整 Pattern 入口重新验证。仍为个人实验，不用于上游贡献；未添加 inline 属性，未修改或重建生产标准库。

## 实现的完整范围与源码

独立模块 contains_impl.rs 提供与标准接口相同的泛型调用形状：

```rust
pub fn contains<P: Pattern>(haystack: &str, pattern: P) -> bool {
    pattern.contains_in(haystack)
}
```

实验内部使用 specialization 分派：`&str` 的 needle 长度为1且 haystack至少16 B、或 char为ASCII且haystack至少16 B时，进入动态字节 SIMD 扫描。NEON DUP / SSE2广播由运行时u8生成，代码中没有固定0x21、`!`或其他特定字节。16..63 B按16 B扫描，64 B以上按64 B扫描，128 B以上尝试64 B主体对齐，末尾重叠读取但不越界。

其他字符串/字符输入复用标准 contains；其他任意 Pattern 通过默认分派原样调用其 is_contained_in。因此空串、needle长于haystack、任意UTF-8子串、非ASCII字符、字符数组/切片、谓词闭包及自定义Pattern均保留完整功能。没有重新发明多字节子串算法，也没有把功能完整说成“所有路径都已优化”。不足16 B改回标准路径，故这不是此前固定 `!` 原型的同一实现。

复现需要既有nightly工具链的 `pattern`、`specialization` 功能；specialization仅用于独立实验的完整Pattern分派，不是可直接合并到稳定标准库的补丁。支持和实测目标为aarch64、x86_64。完整实现、检查程序和基准均归档，不能用前两节固定字节结果替代本节测量。

## 正确性与公平测量

两端各通过5,573,952次对照：全部128种ASCII needle、0..70及95/96/97/127/128/129/255/256/257/2551/65536长度、64种偏移、未命中/首/中/尾，字符串和char两种调用；另含确定种子Unicode随机输入、空串、多字节子串、非ASCII字符、字符数组/切片、&String和谓词访问顺序。

额外独立检查自定义Pattern覆写 is_contained_in 的调用次数、析构次数，以及借用的有状态FnMut谓词；与标准接口结果和副作用一致。check.log、custom-check.log保存退出成功的原始结果。

完整libtest对照共28组：8个现有多字节 bench_contains_*、8个原始 contains_bang_*、12个空串/Unicode/NUL/ASCII字符/集合/谓词补充基准。每组main与optimized三轮交错，合计每台168条记录。haystack和needle均在每次查询black_box，所有入口检查与回退成本计入查询；原始多字节基准的assert行为保留。main表示当前未修改的缓存标准库，不代表重新checkout并构建最新main分支。

完整基准的cycles为libtest ns×perf cycles/task-clock估计值，原始ns、频率、指令、分支、调度计数和三轮范围保留。独立矩阵则使用cycles:u/已知迭代数，两种计量不混用。每台先完整基准、再矩阵、再采样，时间戳核验无性能任务重叠；所有实际计数PMU运行比例100%。两端源码SHA完全一致。

## 完整接口结果：单字节有收益，多字节回退仍在

下表cycles/调用取三轮中位数；变化为优化版相对本平台main，负数表示更少cycles；R为ARM/x86 cycles。

| 完整入口场景 | ARM main→优化 | ARM变化 | x86 main→优化 | x86变化 | R前→后 |
| --- | ---: | ---: | ---: | ---: | ---: |
| 原始长串，运行时字符串 ! | 678.82→150.78 | -77.8% | 457.11→130.82 | -71.4% | 1.485→1.153 |
| 原始长串，运行时字符 ! | 668.41→141.58 | -78.8% | 455.34→125.36 | -72.5% | 1.468→1.129 |
| 2552 B，运行时字符串 NUL，末尾命中 | 589.57→150.07 | -74.5% | 453.06→132.77 | -70.7% | 1.301→1.130 |
| 2552 B，运行时字符 ~ | 597.18→145.07 | -75.7% | 447.56→125.88 | -71.9% | 1.334→1.152 |
| 短文本，子串 sit | 28.63→29.13 | +1.7% | 26.05→31.46 | +20.8% | 1.099→0.926 |
| 长文本，16 B子串未命中 | 540.62→542.41 | +0.3% | 309.33→314.41 | +1.6% | 1.748→1.725 |
| Unicode子串未命中 | 462.93→463.08 | +0.0% | 275.84→277.23 | +0.5% | 1.678→1.670 |
| 非ASCII字符命中 | 53.43→54.51 | +2.0% | 57.25→59.92 | +4.7% | 0.933→0.910 |
| 字符切片 | 30.82→30.87 | +0.2% | 22.44→22.42 | -0.1% | 1.373→1.377 |
| 谓词闭包 | 11.01→11.01 | +0.0% | 8.75→8.68 | -0.8% | 1.259→1.269 |

长串字符串 ! 的 ARM时间235.46→52.18 ns，x86 99.37→28.55 ns；cycles比1.485→1.153。NUL和~同样改善，说明不是只对字符 `!` 有效。不过这些仍是单字节needle分支的收益。

必须保留的回退：x86 short_short 为5.62→6.82 ns，cycles26.05→31.46（+20.8%）；三轮时间范围main5.37–5.84、优化6.73–6.83 ns，回退方向明确。ARM同项9.92→10.08 ns（cycles约+1.7%）。x86 needle长于haystack补充项cycles约+5.7%，非ASCII字符命中约+4.7%，同样没有被略去。8个原始多字节基准完整结果见JSON，未据其局部小幅变化声称改进。

x86汇编显示短多字节回退的基线循环直接调用Pattern::is_contained_in；原型循环先执行needle长度和haystack长度判断，回退调用前后还搬运更多活跃寄存器。指令估计约165→171；已确认新增判断/搬运存在，但未单独隔离代码布局和所有微架构因素，不能把20.8%全部定量归给某一条指令。精简汇编保存为mains_26bench_contains_short_short.s.txt与optimizeds_26bench_contains_short_short.s.txt。

采样确认完整动态入口仍执行真实扫描：x86基线长串约95.48%在Rust memchr；优化版约99.98%在包含SIMD循环的benchmark闭包。多字节short_long优化版约98.95%仍在标准Pattern::is_contained_in，证明其走保留路径而非错误地做单字节查找。ARM动态DUP及扫描汇编、两端完整report/annotate也归档。

## 非固定字节矩阵

另测8/16/32/64/128/256/2551/65536 B、地址mod64=0/1、首/尾/未命中和needle=NUL/A/~，共144个场景。main与完整optimized入口各三轮，每台864次perf运行。needle由命令行运行时提供，并在每次调用black_box；使用真实泛型入口，未直接计时内部字节helper。

| 场景（长度/偏移/needle/命中） | ARM main→优化 cycles | x86 main→优化 cycles | R前→后 |
| --- | ---: | ---: | ---: |
| 8/0/A/首 | 11.22→11.27 | 9.85→10.67 | 1.139→1.056 |
| 2551/1/NUL/未命中 | 683.29→151.86 | 482.86→154.78 | 1.415→0.981 |
| 2551/1/A/尾 | 698.22→150.09 | 514.41→155.70 | 1.357→0.964 |
| 65536/1/~/未命中 | 17181.68→3495.94 | 10933.64→3741.99 | 1.571→0.934 |

本次16 B及以上126个矩阵场景均改善，ARM cycles降低37.9%–79.8%，x86降低38.2%–82.7%。8 B保留标准算法后，仍受入口和布局影响，ARM最差增加约0.7%，x86最差增加约9.2%，不能宣称无回退。矩阵为固定重复输入、热缓存、ASCII填充与一个指定needle，不覆盖全部生产分布。

因此修正结论为：完整功能原型已实现并验证；运行时任意ASCII单字节扫描有已测收益，其余Pattern保留标准功能；当前实现因多字节短串等回退，尚不能声称完整contains整体优于标准库。没有给不同输入分布随意加权计算“总体收益”，也没有声称已重建标准库验证。这些回退需在后续真正集成标准分派路径时处理，本次无已验证的消除方案。

## 源码、环境与复现

远程持久归档：`analysis/repro/contains-full-20261105/{aarch64,x86_64}/`，跨平台comparison.json位于归档根目录。两端运行目录为 `/tmp/contains-full-20261105/`。contains_impl.rs为完整实现；benches.rs为main/optimized完整libtest；check.rs与custom-check.rs为语义检查；matrix.rs为动态needle独立入口。所有perf原始记录、IR、汇编、采样数据及报告均保留。

```sh
python3 build.py check custom-check benches matrix
python3 run-benches.py
python3 run-matrix.py
python3 collect.py
python3 record.py
```

命令串行执行。脚本使用两端既有 `/tmp/xdiff/{rustc,libdir}.txt`、缓存标准库与test框架，自动清理perf外层LD_LIBRARY_PATH并为子进程设置动态库，ARM绑核52、x86 i7-12700 P核12。rustc1.101.0-dev/LLVM23.1.4，编译参数为 `-O --edition=2024 -Cprefer-dynamic -Zinline-mir -Cllvm-args=-import-instr-limit=10`，原始target-cpu未知，原型未指定target-cpu；其余CPU/kernel/libc/cfg与前节同机紧邻环境记录保存在environment.json。未启用新inline属性，未改本地Rust仓库，未提交、推送或上游。

contains_impl.rs SHA256：`35787802290aefb774a6ca9448bd1901767cf22ae3b4b1ace1865d162ff436a1`。其他源码哈希、三轮min/max、时间戳、PMU运行比例与正确性原始结果见summary.json/comparison.json。
