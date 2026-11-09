# Any::downcast_ref 双平台实验（2026-11-04）

完整分析见仓库根目录 `any-downcast-ref-analysis.md`。

- `probe.rs`：原循环、函数隔离、不同黑盒写法、持久对象及独立 trait 返回值对照。
- `build.py`：使用各主机 `/tmp/xdiff/rustc.txt` 的编译器构建，并运行源码辅助函数检查。
- `measure.py`：原写法与编译选项矩阵；五轮随机顺序，2000 万次/组，保存全部用户态计数。
- `layout.py`：四个 `.text` 地址的构建和测量驱动。
- `patch-sret.py`：仅用于本实验 ARM normal 二进制，原指令不匹配即退出；固定地址干预，非源码修法。
- `measure-fixed.py`：ARM 固定地址干预测量驱动。
- `results.*.json`、`layout.*.json`、`fixed-address.aarch64.json`：原始计数、源码哈希、编译器信息。
- `*.asm`：对照程序关键函数的反汇编。

源码相同；ARM core 52、x86 P core 12，沿用已有编译器与标准库。运行环境需具有 perf 计数权限。x86 的 perf 进程与测试程序使用不同动态库环境，脚本在启动测试程序时注入其所需目录。

在独立工作目录恢复文件后执行：

```sh
python3 build.py
python3 measure.py
python3 layout.py
```

ARM 另执行：

```sh
python3 patch-sret.py ./normal
python3 measure-fixed.py
```

正确性检查覆盖源码辅助函数与独立 trait 的返回位模式。二进制干预按原指令、栈槽位置及完整指令数单独核对；它只用于原因实验。标准库和 LLVM 实现均未修改。
