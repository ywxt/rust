# iter::bench_filter_map_chain_sum 复现

`analysis.md` 为报告，`scenario-results.md` 列出全部输入范围、长度和过滤分布的中位数。`aarch64/`、`x86_64/` 保存各自源码、构建与命令、原始输出、LLVM IR、汇编和热点；`source-reference/` 保存参考源码。已构建标准库精确提交未知，实际 benchmark 的二进制校验记录在 environment JSON。

原工作目录 `/tmp/iter-filter-map-chain-sum-20261105`。工具链配置为 `/tmp/xdiff/rustc.txt`、`libdir.txt`、`bins.txt`；迁移时先调整这些路径与绑核配置。ARM 使用 52，x86 P 核使用 12。perf 自身清除自定义 LD_LIBRARY_PATH，测量子进程单独注入。

```sh
python3 build.py
export LD_LIBRARY_PATH="$(cat /tmp/xdiff/libdir.txt):${LD_LIBRARY_PATH:-}"
./probe check 1
./probe original 80
./probe guarded 80
./probe dynamic 80 0 1000000
./probe guarded_dynamic 80 0 1000000
./probe checked_slice 100 0 100000 random
./probe guarded_slice 100 0 100000 random
```

输入为两个同样的范围/数组；`original`、`guarded` 为编译期固定百万范围，`dynamic` 等模式从命令行取得范围。`map` 仅对固定安全范围去掉 checked_mul，`no_blackbox` 仅用于确认生成代码，二者不作为一般接口替代。`initial-probe.rs` 为初始排查程序，最终性能来自 `probe.rs`。

```sh
python3 measure.py
python3 variants.py
python3 layout.py
TAG=layout ROUNDS=3 CONFIGS="$(cat layout-configs.json)" python3 measure.py
python3 scenarios.py
python3 fullbench.py
python3 build-ir.py
TAG=ir CONFIGS='[["ir-checked","ir",0,500000,"all_valid",160],["ir-mul","ir",0,500000,"all_valid",160]]' python3 measure.py
python3 rotation.py
python3 evidence.py
python3 profile.py
```

同平台性能命令串行，并用 `flock -n /tmp/xdiff/core12.lock` 保护；ARM 替换为 core52.lock。所有实际 CONFIGS、重复次数、perf 原始 stderr 和热循环时间都保存在 `results.*.json`，不依赖此处示例重建参数。最小 IR 的每次输入为一百万个元素，IR 驱动输出也逐次核对。

- `probe.rs`：原始链、范围判断、动态范围、数组分布、手动展开及正确性检查。
- `harness.rs`、`fullbench.*.json`：四类相关 benchmark 的原始预构建、重建、范围版、四路展开完整结果。
- `repro.ll`、`repro-header.ll`：尾部相等判断和入口范围判断的 LLVM 最小复现；用 `opt -S '-passes=default<O3>'` 优化比较。
- `repro-mul.ll`、`ir-*.ll/.s`、`ir-driver.rs`、`ir-build.*.json`：只删除已证明安全的溢出检查的诊断对照；没有改生产代码。
- `shape.rs`、`shape-base.ll`：单段、by_ref、chain 生成代码差异；LLVM pass 追踪在 x86 进行，命令保存在 `shape-passes-summary.x86_64.json` 和 `shape-helper-summary.x86_64.json`。
- `single-helper-*-eliminate.ir.txt`、`chained-first-checked.ir.txt`：函数级 IR 片段，不是独立完整模块；对应完整模块和 pass 输出同时保存。
- `scalar-evolution-original.x86_64.txt`：索引范围已知但检查仍保留的证据。
- `reopt-*.ll`、`reopt.x86_64.json`：追加 indvars、correlated-propagation、constraint-elimination 和 O3 的失败消除对照。
- `options.*.json`、`rotation.*.json`：LLVM 选项的准确构建命令及正确性检查。
- `results.*.json`、`summary.*.json`：每轮原始计数和中位数；main 为初始五轮，warm-main 为补充三轮，均保留重大缺页样本。
- `correctness.*.json`、`environment.*.json`、`build.*.json`：检查与来源；`profile-*.txt` 为热点报告，未归档大体积 perf.data，可按 profile.py 重测。

没有覆盖的类型、平台及编译配置不包含在收益结论内。范围写法对一般数据有回退，展开参数也有 x86 回退，完整记录见报告和场景附表。
