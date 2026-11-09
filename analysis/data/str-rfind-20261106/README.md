# str::rfind 双平台分析证据

2026-11-06。报告见 chapter.md，合并记录见 merge-plan.json。原 benchmark 和标准库源码保持不变，所有接口变体均在独立程序中。

## 复现

需要原实验的冻结 sysroot：`/tmp/contains-bad-simd-20261105/sysroots/baseline`；远程编译器：`/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc`。库和编译器校验信息见环境、provenance 与构建命令文件。二进制依赖这些运行库，证据包不重新分发整个 sysroot。

将 common 中的驱动文件与目标平台目录、对应原始 json 放回同一工作目录。脚本按自身目录解析输入；构建和运行使用临时工作目录，不在 Rust 源码树内执行。

1. `build.py`、`build-extra.py`、`build-shims.py`、`build-char-check.py` 保存对应构建流程；执行前核对脚本中的工具链路径。实际参数见各 build-commands.json。
2. `python3 run.py check` 验证接口副本；`python3 run.py bench` 运行原宏的 16 项 find/rfind 对照。
3. `python3 run.py load` 重现地址边界；`python3 run.py flags` 对照编译选项。
4. `python3 run.py cases`、`matrix`、`align16` 分别测字节接口、SIMD 矩阵及对齐矩阵。
5. `python3 binding-check.py` 验证动态符号绑定；`python3 run.py shim` 执行原 8 项的同可执行文件接口替换对照和差分检查。

完整命令（含 LD_LIBRARY_PATH、LD_PRELOAD、绑核、setarch、perf、重复次数）记录在每行原始 JSON 的 command 字段。ARM 核 52，x86 P 核 12。LD_PRELOAD 仅用于临时子进程；Rust ABI 与工具链必须完全匹配，不能作为部署方法。

## 文件

- arm / x86：各阶段原始 JSON、日志、正确性检查、环境、二进制、IR、汇编与 perf 数据。
- common：复现源文件、脚本、构建参数、输入、源码校验、ELF 数据地址和逐 pass 检查脚本。
- *-summary：按场景汇总，3 次中位数及最小/最大值；alu 为 5 次。
- matrix-comparison / align16-comparison：每个场景相对 core 的变化，包含收益与退化。
- validation.json：样本数、计数器运行比例、缺页、迁移与调度检查。
- previous-find-rfind-sections.md：替换前两节历史报告。其历史收益和假设未转记为本次证据。

libtest 时间与 counted 周期属于不同程序，数据地址可能不同。不能拼接两者计算 IPC。x86 波动明显，raw 数据保留全部运行；单点中位数不代表统计显著性。uops-x86 仅为本机补充诊断，无 ARM 同语义计数，不用于推断两平台端口数量。

SHA256SUMS 覆盖除清单自身外的所有文件；保存后使用 `sha256sum -c SHA256SUMS` 核对。
