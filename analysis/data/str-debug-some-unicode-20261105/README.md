# 复现文件

`analysis.md` 为结果报告。`x86_64/` 与 `aarch64/` 保存各自构建源码、命令、原始数据、LLVM IR、汇编和检查输出。`source-reference/` 为调查时的源码参考，构建标准库精确提交未知。

在对应机器的原实验目录 `/tmp/str-debug-some-unicode-20261105` 执行，保留原 `/tmp/xdiff/{rustc,libdir,bins}.txt` 以及工具链。重新部署时先调整这些配置文件；源码和输出路径由脚本所在目录取得。不要使用另一平台的可执行文件。

```sh
python3 build.py
python3 build-candidate.py
python3 build-range.py
python3 build-leaf.py
```

运行最小复现，LD_LIBRARY_PATH 使用 `/tmp/xdiff/libdir.txt` 保存的目录：

```sh
export LD_LIBRARY_PATH="$(cat /tmp/xdiff/libdir.txt):${LD_LIBRARY_PATH:-}"
./leaf slow 500000
./leaf fast 500000
./candidate check 1
./range check 1
```

性能测量使用 `measure.py`，默认 CPU：x86 为 12，ARM 为 52。默认测量初始分阶段探针；通过 CONFIGS 指定二进制和模式，REPS、ROUNDS 控制调用数和轮数。所有原始 perf 命令均保存在 `results.*.json`，包括环境、事件、绑核和参数。模式定义见 `probe.rs`、`candidate.rs`、`range.rs`。

```sh
TAG=candidate CONFIGS='[["candidate","count_copy"],["candidate","count_fast"]]' python3 measure.py
TAG=range CONFIGS='[["range","count_copy"],["range","count_fast"]]' python3 measure.py
python3 fullbench.py
python3 fullbench-range.py
python3 layout.py
python3 variants.py
python3 profile.py
python3 evidence.py
```

正式采样时同平台串行运行，用 `flock -n /tmp/xdiff/core12.lock`（ARM 替换为 core52.lock）保护性能命令。完整 libtest 的三轮原始 stdout、命令保存在 `fullbench*.json`；它与独立循环的 heap 状态不同，不能相加或相减解释分配成本。

文件用途：

- `candidate-body.rs`：复制 Debug 流程与位图分支；`range.rs`：范围判断变体。
- `gen.rs`、`make-candidate.py`、`printable-blocks.rs`：位图生成及产物；升级 Unicode 数据后重新验证。
- `leaf.rs`、`leaf.ll`、`leaf.s`：最小字符判断复现及其生成代码。
- `probe.rs`：扫描、字符判断、属性查询、格式化、分配对照。
- `writer-check*.rs`、`writer-check.*.json`：输出调用顺序与错误传播检查。
- `correctness.*.json`：全部有效 Unicode 标量和混合字符串检查。
- `alloc.rs`、`alloc.*.txt`：单次格式化的分配申请尺寸。
- `cf.*.asm`、`default_ignorable_code_point.*.asm`：实际已链接标准库属性查询的反汇编。
- `profile-*.txt`：perf 热点文本报告；归档未包含大体积 perf.data，可按脚本重测。
- `options.*.json`：准确 LLVM 选项与构建命令；它们没有重新构建 core。
- `results.*.json`：每轮原始 perf 输出；`summary.*.json`：中位数及范围。

`SHA256SUMS.json` 校验除自身外的所有归档文件。未归档可执行文件；构建提交未知的限制见报告。
