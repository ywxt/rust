# str::bench_contains_bad_simd 复现

本归档记录2026-11-05的接口分析。本任务未写入远程实际仓库的pattern.rs及benchmark。保存期间检测到外部将单字节contains_byte_64改为portable SIMD，差异归档为production-external-change.patch。四组对照仍以开始时冻结的快照为准；相关整库数字未验证该外部更新。接口实验位于/tmp/contains-bad-simd-source；标准库、test库和两目标应用均由同一rustc1.99.0-dev/LLVM23.1.0构建。Git HEAD不包含工作树已有修改，源码对应关系以setup.json、四份pattern源码及library-input-sha256.json为准；最后一份library输入清单对应combined构建。

## 四组对照

- baseline/v0：当前接口基线，继承此前已有的单字节contains实现。
- candidate/v1：只将第二探针范围改为1..needle.len()。
- mask/v2：只将四块候选掩码合并判空，按需提取位置掩码。
- combined/v3：两项同时应用。

common/包含四份完整接口源码、补丁、原始测试体、驱动、命令和sysroot清单。arm/、x86/保留对应目标程序、动态标准库、IR、汇编、原始记录。8个原始benchmark函数体逐项token核对记录在original-bench-body-check.json，完整28项驱动额外覆盖单字节和其他Pattern场景。所有版本使用相同驱动源码。

## 最小复现

```sh
rustc --edition=2024 -O common/probe-selection.rs -o probe-selection
./probe-selection
python3 common/trace.py
```

probe-selection输出haystack_len=74、needle_len=8、old_probe=None、full_probe=Some(3)、contains=false。trace.py独立重现Two-Way分界4、长周期5、14轮及70次字符比较；其输出为algorithm-trace.json。它不替换实际接口性能验证。

## 运行已保存的二进制

在匹配架构机器上，将common/中的文件与arm/或x86/的内容合并复制到/tmp/contains-bad-simd-20261105，然后顺序执行：

```sh
python3 full-phases-all.py
python3 run-stackscan.py
```

脚本依次执行正确性、28项原查询体的libtest、相同查询体的固定次数计数、973场景矩阵、采样。矩阵采用循环内CLOCK_THREAD_CPUTIME_ID和墙钟同时记录；它排除准备及调度等待，不是原libtest计时。固定次数驱动仅改变迭代框架，查询体保持；它不作为修改benchmark的优化方案。每平台各阶段顺序执行，两平台可以独立运行。

运行需要对应ELF解释器、glibc和libgcc_s。ARM使用服务器系统运行库；x86交叉程序的解释器及libgcc路径为当前Nix glibc2.42/GCC15.3环境，脚本保存原绝对路径，换机器须提供匹配运行时。动态库SHA由四份sysroot清单核对；归档保留运行所需.so，不包含全部静态rlib/rmeta、编译器或交叉C sysroot。

## 重建

保留源副本/tmp/contains-bad-simd-source及独立构建目录/tmp/contains-bad-simd-build。将对应pattern.*.rs恢复到该副本library/core/src/str/pattern.rs，使用保存的bootstrap.toml：

```sh
./x build --stage 0 library/std library/test --target aarch64-unknown-linux-gnu,x86_64-unknown-linux-gnu
python3 gather-build.py baseline
```

variant可替换为candidate、mask、combined；gather-build.py要求输出sysroot目录尚不存在，并从真实dist/build/*/*/out提取产物，核对每目标唯一的core/std版本，再用同一源文件构建三个驱动。详细应用参数见各*-driver-commands.json。此处复用前次实验的local-rebuild bootstrap修正及交叉C环境，配置引用的compiler、cargo、x86-cc、C sysroot与LLD路径需要保持；仅有Git HEAD不足以恢复已修改的完整library输入。源码副本和原环境仍保留，重建前先核对library输入清单。归档不宣称可以脱离这些依赖从零重建。

## 计数与诊断限制

最终full-*记录的硬件事件运行占比全部100%；perf及子进程先绑核，避免混合核心机器在启动阶段落到其他核心。早期run.v1/run.v2阶段在perf外层未提前绑核，部分事件运行占比不足、进程启动占比较高；这些记录保留但不进入最终周期表。最终固定次数的重样本为500万、轻样本为1000万，未扣除空循环，进程一次性准备计入后摊薄。

ASLR对被测进程关闭。源代码版本、核心、库和程序SHA、原始事件计数、缺页及调度数据均保留。诊断全局LLVM选项未重编sysroot，只作用于应用crate及其中实例化/内联的代码。

stack-probe.rs比较相同stp/ldp与拆分读取的依赖链，地址模64取0/8/16/24/32/40/48/56。它确认特定跨界写读组合成本，未复现原框架全部差值，不能将25.65→9.90ns的选项差异全部归于该探针。x86使用实际标量8字节读写序列；split标志在x86是同一序列对照。

全部性能覆盖范围与回退在report.md、related-benchmarks.md、scenarios.md及CSV。未覆盖冷缓存、其他CPU、其他工具链及native/LTO配置；没有提交、推送或上游贡献。
