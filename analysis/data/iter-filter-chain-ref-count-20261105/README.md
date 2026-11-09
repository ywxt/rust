# iter::bench_filter_chain_ref_count 实验

原 benchmark 位于 `library/coretests/benches/iter.rs`。本目录仅包含独立分析和对照程序，没有修改标准库或 LLVM 的实现。

## 文件

- `probe.rs`：原调用链、去掉 by_ref、拆开 chain、手写循环、无符号和奇偶谓词对照。后两项仅用于区分成本，奇偶谓词改变了工作，不能作为修法。
- `source-probe.rs`：原逻辑及固定输入的四路源码展开，分别使用单累加器和多个累加器。
- `repro.ll`：保留两段循环、逐元素黑盒栈往返、signed remainder 与计数的完整最小 IR。
- `build.py`、`build-source.py`、`variants.py`：独立构建和固定输入结果检查。
- `verify-ir.py`、`ir-driver.rs`：将最小 IR 编译为本机对象并调用，核对默认及四路展开均返回 666668。
- `measure.py`：绑核、交错运行、perf 原始计数，默认每组 80 次加一次正确性调用、5 轮，中位数汇总。
- `harness.rs`、`fullbench.py`：原 libtest benchmark 主体、源码展开，以及原预编译标准库 benchmark 的三轮对照。
- `layout.py`：将 .text 起点设为 0x10000 + {0,16,32,48}，构建默认、LLVM 四路展开和源码四路展开。
- `options.*.json`：选项对照原始输出；`options-summary.*.json` 为该组中位数。
- `results.source.*.json`、`results.controls.*.json`、`results.layout.*.json`、`results.ir.*.json`：源码改写、排除性对照、布局实验和最小 IR 原始记录。
- `summary.*.json`、`fullbench.*.json`、`environment.*.json`、`build.*.json`：汇总、完整框架时间和环境。
- `*.s`、`*.ll`：生成代码；交叉目标的 `repro.<target>.*` 表示在 x86 LLVM 工具上生成的目标汇编。

## 环境与计数

实验沿用各机器 `/tmp/xdiff/rustc.txt` 和 `libdir.txt` 指定的编译器及标准库产物。rustc 1.101.0-dev，LLVM 23.1.4；编译器自报 commit-hash unknown。当前源码目录的 HEAD 与已编译产物版本分别记录，不能把当前 HEAD 当成产物来源证明。

ARM：univpn-work-1，HiSilicon 920B，core 52。x86：Intel Core i7-12700，P core 12。两平台基础编译均为 `-O -C codegen-units=1`，未设置 target-cpu=native。用户态周期、指令、分支和误预测采用相同口径，另记录缺页、调度和迁移。

每次调用处理 2000000 元素，正确结果为 666668；`measure.py` 的分母包含程序启动后执行的一次结果检查。进程启动开销也在 perf 计数中，表中因此保留约数。代码地址扫描每组 60 次加一次检查、3 轮。

## 复现

在已具备上述编译器、运行库、perf 权限及可用核心的独立目录运行：

```sh
python3 build.py
python3 variants.py
python3 build-source.py
python3 verify-ir.py
TAG=ir CONFIGS='[["ir-base","original"],["ir-unroll4","original"]]' python3 measure.py
TAG=controls python3 measure.py
TAG=options CONFIGS='[["normal","original"],["unroll4","original"],["unroll8","original"],["nohoist","original"],["nolsr","original"],["nosched","original"]]' python3 measure.py
TAG=source CONFIGS='[["normal","original"],["source","original"],["source","source_unroll4"],["source","source_unroll4_one_acc"]]' python3 measure.py
python3 fullbench.py
python3 layout.py
TAG=layout ROUNDS=3 REPS=60 CONFIGS="$(cat layout-configs.json)" python3 measure.py
```

测量阶段避免同核并发；本次使用 `/tmp/xdiff/core12.lock`、`core52.lock` 的 flock 锁。运行其他机器时先修改工具链和核心配置。原标准库预编译二进制由 `fullbench.py` 从原环境 bins.txt 选择，独立搬移后需更新该位置。

ARM 另外对照 `nocsel` 和 `noselect`。选项表仅记录实际构建的参数；各选项分别测试，没有将其组合视为推荐配置。
