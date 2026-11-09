# tuple::bench_tuple_comparison 复现

日期：2026-11-05。本文与 report.md 记录分析实验；未修改标准库生产代码。原始 benchmark 保持不变。two、match、fused、pointer 等变体修改了调用端，只用于诊断，不能作为接口优化方案或原 benchmark 的优化收益。fullbench、flags、options 等文件名沿用原实验名称，其改写变体仍属于探针。当前无已验证接口修改方法。

common 保存源码和运行脚本；arm、x86 保存各平台原始 JSON、编译日志、LLVM IR、汇编和 perf 采样。完整基准输出保存在 fullbench.*.json、flags.*.json、options.*.json、controls.*.json；固定迭代 PMU 数据在 results.full.*.json、results.phi16.*.json。environment.*.json 包含内核、CPU、glibc、源码提交与原二进制 SHA256；build.*.json 包含编译器版本与依赖路径。

## 最小复现

复制 common/compare.rs 和 common/leaf.rs 到同一目录：

```sh
rustc --edition=2024 -O -Ccodegen-units=1 --emit=link,asm,llvm-ir leaf.rs -o leaf
./leaf original 10000000
./leaf fused 10000000
```

leaf.rs 中固定的输入是 Chain 与 Clone，检查比较结果生成及打包。compare.rs 还包含 leaf_two。此复现不包含 libtest 和随机取样，不能用其时间代替完整 benchmark。

## 相同环境重跑

原实验脚本使用 /tmp/tuple-comparison-20261105 和 /tmp/xdiff 的工具链配置；需要先恢复同一版本的工具链及匹配的 rand 元数据、rlib。不能混用其他版本元数据。将 common 的源码和脚本复制到上述目录后运行：

```sh
python3 build.py
python3 fullbench.py
python3 shapes.py
python3 flags.py
python3 controls.py
python3 options.py
python3 full-probe.py
python3 phi16-probe.py
python3 matrix-full.py
python3 matrix-phi16.py
```

flags.py 从原 corebenches 的 Cargo fingerprint 读取 rustflags。各平台保存的 fingerprint.*.json 可核对原值。codegen-units=16 的 shapes.py 只生成 link，避免 rustc 在同时输出单份 IR/汇编时重置为一个单元。shapes-reset.* 是早期受重置影响的记录，不能当成真正 16 单元实验。

matrix 脚本对同一 matrix 输出文件进行编译。每次生成后的 matrix.ll 和 matrix.s 应立即另存，防止下一种配置覆盖；本归档中 matrix.ll/.s 对应最后的阈值16构建，历史性能结果分别保存且未覆盖。比较两个配置的 IR 时按保存的构建命令分别重新生成。

同一平台的测试应顺序执行，固定 ARM CPU52、x86 CPU12，避免并行运行争用核心。计数仅取用户态硬件事件；perf 自身不继承用于 rustc/std 的 LD_LIBRARY_PATH，测量子进程单独注入。原始 perf stat 输出中事件运行占比均为100%。循环内计时和 libtest 计时与整个进程的 PMU 范围不同，进程 PMU 包含启动工作。

原始源码及二进制的提交对应关系未知，工具链 rustc -vV 的提交字段为 unknown。当前源码目录 HEAD 只描述分析时文件状态。归档不包含工具链、依赖、被测 ELF 和系统 libc；perf.data 的符号化重放需要原路径的匹配二进制及 libc，现有符号化输出和汇编已保存。

完整性能矩阵在 scenarios.md、scenarios.csv。method 编号：0 原始，1 两关系及补集，2 cmp 后返回固定数组，3 从同一次 cmp 分别提取四个布尔值。后者与常量数组方法分开记录。
