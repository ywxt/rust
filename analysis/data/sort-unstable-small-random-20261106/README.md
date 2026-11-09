# slice::sort_unstable_small_random 复现材料

结论保存在仓库根目录 `benchmarks-conclusion.md` 的对应章节，`chapter-in-conclusion.md` 是写入时的存档。

`arm/` 保存远程临时目录快照，包含原源码、保持原样的 benchmark 宏及生成器、构建脚本、原始 JSON/日志、perf record 数据、LLVM IR、汇编和实际运行文件。`x86/` 保存本机实际测量文件与运行结果。根目录的 `*-summary.csv`、`*-summary.json` 为汇总，ns 为每组三次或五次中位数，范围另列；独立驱动 cycles 等指标按次数归一化。没有将不同驱动或不同测量轮次混合。

工具链是远程 `/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc`，版本 1.99.0-dev / LLVM 23.1.0，版本输出中的编译器提交未知。冻结标准库在 `/tmp/contains-bad-simd-20261105/sysroots/baseline`。x86 使用 `/tmp/contains-stdlib-20261105/x86-cc` 交叉链接。命令中有这些绝对路径，换目录复现需调整路径并保持依赖版本。实际运行库的路径与 SHA256 见两端 `environment.*.json`。没有把其他正在修改的 stdlib 版本纳入比较。

源码快照包括完整排序目录、原 benchmark 文件、Cargo.lock 和 Cargo.toml。`provenance.json` 保存校验和及源码 HEAD。RNG 依赖为锁定的 rand 0.9.3（alloc feature）、rand_core 0.9.3、rand_xorshift 0.4.0，构建脚本使用本机 Cargo registry 的源码并直接调用 rustc 构建这几个独立依赖。原 benchmark 的 `bench_rng`、生成器、sort 宏和 22 个调用保持原样。

复现步骤：在原远程临时目录运行 `python3 setup-remote.py`、`python3 build.py`、`python3 build-nolsr.py`。第一步只读取仓库并生成独立分析程序，不修改原文件。构建命令、参数和日志保存在 `build-commands.json`、`nolsr-build-commands.json`。将 x86 目标目录及 common 驱动复制到 x86 同名目录。

两端分别运行以下各条命令，保证测量顺序执行：

```sh
python3 run.py target
python3 run.py related base
python3 run.py probes base nounroll
python3 run.py nolsr
python3 run.py nolsr-probes
python3 run.py profile
```

`target` 和 `nolsr` 同时保存 libtest 原查询及固定次数驱动。固定次数驱动只替换 Bencher，不改变查询逻辑；与原 libtest 内联、寄存器使用和代码地址存在区别。`probes.rs` 调用现有标准库接口，未提供排序替代实现。命令 `probes-base full 10 original 1000000` 是完整克隆排序对照；`sort` 在预分配缓冲区中恢复数据并排序；`clone`、`reset` 分别控制克隆释放和恢复输入；`vary` 轮换 256 组输入，其准备在循环计时外。原 benchmark 始终使用固定种子生成的一组输入。

驱动记录用户态 cycles/instructions/branches/branch-misses、task-clock、上下文切换、迁移、主次缺页。四项硬件计数均未复用。CPU 为 ARM 52、x86 P 核 12，perf 父子进程都绑核，并通过 setarch 关闭 ASLR。cycles:u/task-clock 会受内核时间影响，短探针的这个比值不能作为实际频率。进程级缺页统计也不能确定缺页是否位于 libtest 的计时窗口。

`trace-lsr.py` 用当前 rustc 的 `-print-before=loop-reduce`、`-print-after=loop-reduce` 和函数过滤保存实际 pass 前后 IR，详见 `lsr-stage-ir.txt`，过滤及完整编译命令在 `lsr-trace-commands.json`。普通 `probes-base.ll` 是后端 LSR 前保存的优化 IR，不能只对比它与 nolsr.ll 来判断该 pass 是否运行。

布局实验：`link-capture.py` 保存现有链接输入；`build-layout.py` 使用 objcopy 重命名一个原函数段后重新链接。x86 的 objcopy 在本机执行，再将 placed.o 上传回交叉链接环境；相关对象及 section 名保存在 layout-build。没有改 benchmark 或排序函数体。布局虚拟地址为 `0x1000000 + offset`，offset 0–240、步长 16，文件名补齐为三位数字。

运行布局对照使用 `python3 run.py layout`。`validate-layout.py` 校验目标函数除重定位字段外的字节、其他函数的地址和实际链接起点。ARM 满足单函数地址控制条件。x86 链接器移动了其他函数，已标为整体布局对照，不能当作单函数地址控制成功。检查结果见 `layout-validation.json`。

`related.x86_64.pilot.*` 和 `probes.x86_64.pilot.*` 有一次相互重叠，随后两组完整重跑。正文及所有汇总使用无 pilot 后缀的最终数据；pilot 和 overlap-note 仅保存调查记录。其余组在各平台内部顺序执行。

没有接口源码修改。LLVM 选项改变的排序实例在应用编译单元内生成；已有动态标准库及 libc 没有随选项重编。关闭 LSR 只能视为诊断配置，在完整矩阵中同时有收益和退化。
