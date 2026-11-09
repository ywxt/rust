# vec::bench_from_iter_0100 复现材料

结论集中在仓库根目录 `benchmarks-conclusion.md` 的对应章节。`chapter-in-conclusion.md` 是写入时的存档。

`arm/` 保存远程测试目录的完整快照：6 份相关源码、原 benchmark 函数体、独立驱动、构建命令、双目标汇编和 LLVM IR、运行文件、原始 perf stat 和 perf record 数据。`x86/` 保存本机实际运行文件、输出及环境。`bench-summary.csv` 包含所有原 benchmark 及选项的三次范围；`related-benchmarks.md` 和 `option-scenes.md` 便于查阅。计时变化为新值/基线−1，正数表示变慢。

构建依赖远程 `/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc` 和冻结 sysroot `/tmp/contains-bad-simd-20261105/sysroots/baseline`；x86 交叉链接器为 `/tmp/contains-stdlib-20261105/x86-cc`。运行依赖文件的路径和校验和保存在构建命令与 `x86/environment.json`，没有将 sysroot 改动后的库混入结果。源文件校验和见 `arm/provenance.json`。

在原远程 `/tmp/vec-from-iter-20261106` 中运行 `python3 build-variants-v2.py`、`python3 build-rawcopy.py`、`python3 build-minimal.py` 构建。所有真实参数保存在 `variant-commands.json`、`rawcopy-commands.json`、`minimal-build-commands.json`，两端默认 CPU 特性一致，未启用 native。仅最小 IR 例子显式使用 `-Ccodegen-units=1`，其他构建的多输出模式也使用单个代码生成单元。

将匹配运行文件复制至 x86 的同名目录后，在两端分别运行 `python3 run.py bench`、`counted`、`primitive`、`alignment`、`rawcopy`、`profile`。执行记录包含完整命令；`run.py` 根据架构选择 CPU 52/12，并固定 perf 父进程。`profile` 采样另行执行，未给时间结果附加采样开销。这里列出的多个参数应分别作为 `run.py` 的一次调用。

`counted.rs` 的原查询体与 `query-bodies.rs` 一致，仅将 libtest Bencher 替换成固定次数调用器。main/worker 分别测试主线程及额外工作线程，报告采用 main，原 libtest 的 bench 也在进程主线程执行。其输出含转义字符，读取周期等指标使用 JSON 中已解析的 `per_call` 字段；raw stdout 原样保留。

`diagnostics.rs` 区分 malloc/free、仅 memcpy、malloc/memcpy/free，复制数据在计时前初始化。`rawcopy.rs` 排除分配成本并控制源目标相对 64 字节边界的偏移，测后验证内容与边界。它们是诊断程序；循环开销、函数调用方式及地址与真实 libtest 不同，不能当作原接口耗时的可加分解。

libc 的实际释放路径保存于 `free.*.s`。上游对应资料：[glibc 2.38 malloc.c](https://raw.githubusercontent.com/bminor/glibc/glibc-2.38/malloc/malloc.c)、[glibc 2.42 malloc.c](https://raw.githubusercontent.com/bminor/glibc/glibc-2.42/malloc/malloc.c)、[free 缓存快路径改动](https://sourceware.org/pipermail/glibc-cvs/2024q4/086689.html)、[_int_free 内联](https://sourceware.org/pipermail/glibc-cvs/2025q2/088019.html)。资料用于解释实际路径差异，没有使用上游其他机器的收益数字代替本次测试。

未修改原 benchmark 或接口源码。LLVM 参数实验只证明本次构建中的效果；没有将单个长度的收益归为通用优化。
