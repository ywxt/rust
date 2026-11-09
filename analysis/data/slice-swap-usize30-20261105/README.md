# slice::swap_with_slice_usize_30 复现

`analysis.md` 为报告，`scenario-results.csv` 保存全部汇总值和地址信息；`related-benchmarks.md` 保存首次10项完整扫描。`aarch64/`、`x86_64/` 各存源码、IR、汇编、实际命令和逐轮原始计数。

原目录 `/tmp/slice-swap-usize30-20261105`。工具链、运行库和原始测试二进制由 `/tmp/xdiff/{rustc,libdir,bins}.txt` 指定，迁移时先修改路径。CPU为ARM52、x86的12。

```sh
python3 build.py
export LD_LIBRARY_PATH="$(cat /tmp/xdiff/libdir.txt):${LD_LIBRARY_PATH:-}"
./probe check 1
./probe original 500000 30 0 0
./probe vec 500000 30 0 0
./probe leaf_std 1500000 30 0 0
./probe leaf_vec 1500000 30 0 0
```

- `methods.rs`：原始、2/4/8元素块、显式128位、标量表达及reg/even诊断。有效候选保留原始skip黑盒；reg/even改变测量条件。
- `probe.rs`：32次交换和固定区间交换。初始Vec留额外空间，数组引用封装与完整libtest的Vec闭包有不同生成代码，收益幅度不能直接移用。
- `aligned.py`：生成64B基准对齐的独立驱动，允许指定偏移；仍为两个分配。
- `distance-probe.rs`、`distance.py`：单个分配中用split_at_mut建立两个不重叠区域，固定距离和偏移，隔离数据位置；源目标距离最低256B。
- `asm-probe.rs`：仅ARM，4种固定32B交换汇编。命令格式 `./asm-probe leaf_pair 10000000 4 0 0`，调用次数必须大于零；另有leaf_single、leaf_pair_split、leaf_single_split。实际perf命令见results.asm.aarch64.json。
- `scenarios.py`：24种长度、64种偏移组合和8种batch偏移条件。长度变化也改变分配地址，汇总中记录地址，不能只用长度推断阈值。
- `fullbench.py`：10个相关benchmark及原始预构建、重建、分块/向量候选，每平台126个完整进程。x86首次阶段有调度等待。
- `fullbench-clean.py`：usize30/3000的带CPU时间复测，ARM另有关闭配对的完整对照；正文采用这组耗时。
- `measure.py`：CONFIGS=[二进制,模式,n,x偏移,y偏移,reps]，TAG指定输出名。batch分母为reps×32，leaf为reps。
- `variants.py`、`options.*.json`：LLVM选项和生成代码。
- `controlled.py`：依次构建固定地址、扫描代码布局和运行全部场景；使用layout.py及scenarios.py。
- `extra-check.rs`、`evidence.py`、`correctness.*.json`：边界、析构与失败前状态检查和来源记录。
- `original-function.*.ir.txt`：原始32次交换函数的完整IR片段；完整模块为probe.ll。
- `initial-*`、`results.initial.*`：早期探针快照，不作为最终主要结论。

```sh
python3 measure.py
python3 variants.py
python3 fullbench.py
python3 controlled.py
python3 distance.py
python3 fullbench-clean.py
python3 evidence.py
```

同平台性能命令串行，用 `flock /tmp/xdiff/core12.lock` 保护，ARM为core52.lock。perf自身清除自定义LD_LIBRARY_PATH，只向目标程序注入运行库。全部实际命令、重复数、stderr、地址与计数保存于results.*.json。独立探针、完整框架和固定汇编分别解释，不能混用周期和时间。

环境记录包括参考源码校验及原始benchmark二进制SHA256；构建标准库精确提交未知。无标准库、LLVM或系统全局配置修改。
