# 文件复制实验复现

`analysis.md` 为报告，`x86_64/`、`aarch64/` 分别保存源码、测量脚本、原始输出、IR、汇编和追踪。`source-reference/` 保存参考源码；已构建标准库精确提交未知，环境文件记录了实际 benchmark 二进制的 SHA256。

原实验目录为 `/tmp/kernel-file-copy-20261105`。工具链由 `/tmp/xdiff/rustc.txt` 配置，运行库由 `/tmp/xdiff/libdir.txt` 配置，预构建标准库测试二进制从 `/tmp/xdiff/bins.txt` 选择。迁移到其他环境时修改这些文件及脚本的目录/核心配置。

x86 目录：`/tmp`（Btrfs），`/dev/shm/kernel-file-copy-20261105`（tmpfs）；ARM 目录：`/tmp`（tmpfs），`/home/wheel/copy-bench-20261105`（ext4）。先确认目录实际文件系统，不要据目录名推断。

```sh
python3 build.py
export LD_LIBRARY_PATH="$(cat /tmp/xdiff/libdir.txt):${LD_LIBRARY_PATH:-}"
./probe std 131072 20000 /tmp
./probe take 131072 20000 /tmp
./probe rw128 131072 20000 /tmp
```

探针模式：`std`（io::copy）、`take`（已知长度）、`cfr`（直接调用至 EOF）、`cfr_limited`（直接调用指定长度）、`rw8`、`rw128`、`seeks`、`metadata`。`metadata` 包含原始两次 seek，不能把结果直接全部归到 statx；分阶段数值也不能机械相加。

```sh
python3 fullbench.py
python3 run.py
TAG=scope ROUNDS=3 python3 run.py
python3 size-run-stable.py
python3 fullbench-variants.py
python3 trace.py
python3 profile.py
python3 environment.py
```

同一平台串行运行，正式采样使用 `flock -n /tmp/xdiff/core12.lock`，ARM 换为 `core52.lock`。性能计数需要允许内核事件。perf 自身运行时清除 LD_LIBRARY_PATH，只对测量子进程注入运行库路径。`run.py` 已自动处理这一点。

- `fullbench.*.json`：原始预构建 libtest 在两种目录下的三轮输出及命令。
- `fullbench-variants.*.json`、`harness.rs`：完整 libtest 的原始、take、缓冲复制对照。
- `results.main.*.json`、`summary.main.*.json`：用户态加内核态计数及循环内时间。
- `results.scope.*.json`：分离用户态和内核态计数。
- `results.sizes-{small,medium,large}.*.json`：正式不同长度验证，调用次数由 size-run-stable.py 设置。
- `results.sizes.*.json`：早期统一短采样探索，完整保留，不用于最终小输入表格。
- `trace-*.txt`、`traces.*.json`：三轮复制的完整 syscall 轨迹。编号 0 为各平台 /tmp，1 为各平台另一个目录；包含进程启动和结束检查，应按热循环区段读取。
- `profile-*.txt`、`profiles.*.json`：内核热点及采样命令。x86 内核符号受权限限制，未解析符号的地址如实保留；perf.data 未归档，可按脚本重测。
- `fiemap-check.py`、`reflink-probe.rs`、`fiemap.x86_64.json`：Btrfs 共享物理区间对照。独立快照程序保留文件到 FIEMAP 检查结束，再删除；同步发生在查询阶段，其耗时不是稳态性能结果。
- `probe.rs`、`probe.ll`、`probe.s` 及 `harness.*`：独立复现与生成代码。
- `environment.*.json`、`build.*.json`：CPU、内核、挂载、页大小、工具链、源码与二进制校验信息。

所有脚本只创建独立临时文件。没有文件系统挂载参数、系统全局配置或标准库/内核源代码改动。报告对未覆盖场景与尚未区分的内核/硬件成本有明确限制。
