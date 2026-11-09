# 报告中的修改示例

本目录保存 `x86-gap-report.md` 中新增的独立运算和 SVE 指令示例。LLVM 原因分类的完整 IR 继续使用 `analysis/repro/L01`、`L02`、`L03`、`L04`、`L07`、`L10`、`L11` 各目录原文件。

- `extract-stage.ll`：异或形式与等价加法形式的双 lane 阶段。等价关系要求掩码满足 extract_bits 相应阶段的位区段条件。
- `extract-stage.aarch64.s`、`extract-stage.x86_64.s`：LLVM 23.1.4 的生成结果。AArch64 加法版本生成 usra。
- `retain-u32.s`：单个 SVE 向量的 u32 压缩示例。x0 为掩码地址，x1 为源地址，x2 为目标地址，x3 为本次元素数；返回保留数量。调用方须保证本次元素数不超过一个向量的 u32 lane 数、访问范围有效、p0 内所有元素均已初始化，目标写入不破坏尚未加载的数据。
- `validation.json`：语法和目标汇编验证记录。这些检查未产生新的性能测量，retain 的完整谓词、分块、析构和 panic 处理不在该汇编片段中。

复现命令：

```sh
llvm-as extract-stage.ll -o /tmp/extract-stage.bc
llc -O3 -mtriple=aarch64-linux-gnu extract-stage.ll -o /tmp/extract-stage.aarch64.s
llc -O3 -mtriple=x86_64-linux-gnu extract-stage.ll -o /tmp/extract-stage.x86_64.s
llvm-mc -triple=aarch64-linux-gnu -mattr=+sve -filetype=obj retain-u32.s -o /tmp/retain-u32.o
```

