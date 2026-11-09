from pathlib import Path
import json,hashlib,shutil,tarfile
p=Path(__file__).resolve().parent;d=p/'delivery'
before=(p/'conclusion-current.md').read_text();start=before.index('# `str::find_zzz_char::*` / `rfind_zzz_char::*`');end=before.index('# `iter::bench_zip_then_skip`',start)
(d/'previous-find-rfind-sections.md').write_text(before[start:end])
chapter=r'''# 反向扫描的配对加载跨越 32 字节边界时增加延迟

分析对象为 `str::rfind_underscore_char::*` 和 `str::rfind_zzz_char::*`，共 8 项。结果来自 2026-11-06 的双平台复测。

本机 HiSilicon ARM 上，反向扫描循环中的 `ldp` 在跨越 32 字节边界时成本增加。固定地址探针中，依赖加载从约 4 cycles 增至 10 cycles；改用两条独立的 64 位加载后，地址敏感性消失。原长串 benchmark 的部分加载恰好跨越该边界。将扫描块对齐到 16 字节后，两项 ARM 长串测试约从 242.6 ns 降到 218–219 ns，改善约 10%。短串补充场景存在明显退化，当前候选不能通用替换。

## 原因、接口和对应方法

| 原因类别 | 已确认的具体问题 | 对应接口与 benchmark | 对应方法 |
|---|---|---|---|
| 硬件执行成本，受 LLVM 配对加载触发 | 两次 64 位加载被合为 `ldp`。源码只保证 8 字节对齐，部分 16 字节加载范围跨越 32 字节边界；本机该访问的延迟增加 | `core::slice::memchr::memrchr` → `CharSearcher::next_match_back` → `str::rfind(char)`；两组 `long_lorem_ipsum` | 16 字节扫描块对齐；或阻止该加载配对。均需处理短串退化 |
| 测量条件 | 独立程序的字符串地址不同，会改变标量尾部长度和跨界次数；x86 存在频率与同核线程干扰，部分长串样本波动较大 | 同上；短串尤其受尾部处理量影响 | 固定可执行文件做接口替换对照；显式控制数据地址，保存样本范围 |

两平台 `memrchr` 使用同一份按整数检查字节的源码，每轮处理两个 `usize`，共 16 字节。当前路径没有专门的 NEON 或 SSE2 实现。此次没有发现“x86 有 SSE2、ARM 缺少 NEON”的源码平台差异。

## 原测试实际执行的工作

```rust
black_box(s.rfind('_'));
black_box(s.rfind('\u{1F4A4}')); // 💤，UTF-8 为 F0 9F 92 A4
```

每组包含 64 字节 ASCII、65 字节混合文本、65 字节 💩 文本、2551 字节长文本。8 项均未命中。输入也不含两个目标字符的最后一个字节 `5F`、`A4`，因此扫描结束前不会进入完整 UTF-8 字符核对。计时内没有分配或复制输入。

下表为原 benchmark 宏在独立 libtest 驱动中的结果，3 次运行取中位数，单位 ns/次。两平台使用相同输入与宏；这组程序没有替换接口。

'''
rows=json.loads((d/'bench-summary.json').read_text());rows=[r for r in rows if r['mode']=='libtest' and 'rfind_' in r['case']]
chapter+='| benchmark | ARM | x86 |\n|---|---:|---:|\n'
for name in sorted({r['case'] for r in rows}):
 a=next(r for r in rows if r['case']==name and r['arch']=='aarch64');b=next(r for r in rows if r['case']==name and r['arch']=='x86_64');chapter+=f"| `{name}` | {a['ns']:.2f} | {b['ns']:.2f} |\n"
chapter+='''
x86 两项长串样本范围分别为 126.32–157.53 ns、127.16–138.40 ns。周期计数由另一个固定次数驱动采集；两种驱动的数据地址不同，短串标量处理量也可能不同，不能将其周期数与本表耗时直接拼接计算 IPC 或频率。

## LLVM 如何生成跨界配对加载

源码核心结构如下，完整可运行副本在 `common/word.rs`：

```rust
let (prefix, _, suffix) = unsafe { text.align_to::<(usize, usize)>() };
// 从末尾向前扫描；每轮读取两个 usize。
let u = unsafe { *(ptr.add(offset - 16) as *const usize) };
let v = unsafe { *(ptr.add(offset - 8) as *const usize) };
// 将 u、v 与重复目标字节异或，检查是否含零字节。
```

64 位目标上的 `(usize, usize)` 大小为 16 字节，对齐要求为 8 字节。对应复现的 LLVM IR 中，两次加载均为 `align 8`：

```llvm
%u = load i64, ptr %_26, align 8
%v = load i64, ptr %_31, align 8
```

ARM 的 `aarch64-ldst-opt` 将两条 `LDRXui` 合并为一条 `LDPXi`，逐 pass 的机器 IR 已保存。实际标准库汇编也使用同样的配对加载。x86 使用两次独立加载：

```asm
// ARM：一次加载连续的 16 字节
ldp x12, x13, [x11]
// x86：分别加载两个 8 字节整数，寄存器名按解释统一
mov r8, [r11]
mov r9, [r11 + 8]
```

加载起点若为 16 字节对齐，整个范围不会跨越 32 字节边界。起点为 `8 mod 16` 时，每隔一次就会跨界。例如起点为 `24 mod 64`，访问范围为 24–39；起点为 `56 mod 64`，范围为 56–71。前者仍在同一条 64 字节缓存行内，也出现相同代价，因此不能将问题归为跨缓存行访问。

### 固定地址、相同指令的最小复现

`common/load.rs` 构造间隔 256 字节的三节点指针环；只改变节点地址的低位。热数据范围很小，循环指令和代码地址保持相同。ARM 依赖链核心为：

```rust
asm!(
    "2:",
    "ldp {p}, x9, [{p}]",
    "subs {n}, {n}, #1",
    "b.ne 2b",
    p = inout(reg) p, n = inout(reg) count,
    out("x9") _, options(nostack, readonly),
);
```

x86 对照使用 `mov p, [p]`；另测两条独立 64 位加载的吞吐。完整源文件包含输入构造、有效指针检查和计时。

| 指标，中位数 cycles/操作 | 起点 0、8、16、32、40、48 mod 64 | 起点 24、56 mod 64 |
|---|---:|---:|
| ARM `ldp` 指针依赖链 | 约 4.05 | 约 10.05 |
| ARM `ldr` 指针依赖链 | 约 4.05 | 约 4.05 |
| ARM 独立 `ldp` 吞吐 | 约 0.506 | 约 1.006 |
| x86 指针依赖链 | 5.12–5.13 | 5.12–5.13 |
| x86 两条独立 64 位 `mov` 吞吐 | 0.682–0.685 | 0.682–0.685 |

上述结果确认了本机的地址边界代价。具体内部拆分、端口或重放机制尚无可验证的证据；结论限定于这台 HiSilicon ARM。

### 回到相同扫描循环

固定同一份 2551 字节无命中输入，只改变起始地址。扫描字节数、标量尾部总量保持相同。表中为复制接口的 cycles/调用，中位数。

| ARM 编译方式 | 地址 0 mod 64 | 地址 8 mod 64 |
|---|---:|---:|
| 默认 | 633.09 | 708.36 |
| `-aarch64-enable-ldst-opt=false` | 635.83 | 639.88 |
| `-disable-lsr` | 574.07 | 570.65 |
| 两项同时关闭 | 570.10 | 580.08 |
| `-unroll-count=4 -unroll-runtime=true` | 484.60 | 500.80 |

默认循环因地址变化增加约 75 cycles；关闭加载配对后差值缩小到约 4 cycles。独立加载虽增加指令数，却消除了主要的地址敏感性。`-disable-lsr` 同时改变寻址方式并消除该处配对，其收益包含多项变化；两选项的收益不能相加。展开增加独立工作、减少循环控制，但补充场景存在回退。

原 ARM libtest 长串地址为 `54 mod 64`：159 个扫描块中有 80 个跨越 32 字节边界。不同独立驱动的地址与跨界次数见 `common/data-layout.json`。各次加载能够重叠执行，不能将依赖链多出的 6 cycles 逐次累加，代替完整循环测量。

## 修改方法及适用范围

### 1. 将扫描块对齐到 16 字节

独立接口副本仅替换块类型，保持搜索结果和逆序检查过程：

```rust
#[repr(C, align(16))]
struct AlignedPair(usize, usize);
let (prefix, _, suffix) = unsafe { text.align_to::<AlignedPair>() };
```

这样每对加载都不会跨越 32 字节边界，但部分地址需要多做 16 字节的标量处理。短字符串中，该成本可能超过节省的加载成本。

为了回到原 8 项测试，实验使用同版本 Rust 动态库，在临时进程中分别替换 `memrchr` 为普通块副本和 16 字节对齐副本。两组使用同一个 benchmark 可执行文件、相同数据地址和相同替换机制，已核对动态符号绑定。原 benchmark 和标准库文件均未修改。该替换只用于实验；接口正式修改仍需在标准库内重建验证。

表中单位 ns/次，3 次交错运行取中位数；普通块副本作为这项对照的基线，其调用成本与上一张原始结果表不同。

'''
rows=json.loads((d/'shim-summary.json').read_text());rows=[r for r in rows if r['mode']=='libtest']
chapter+='| benchmark | ARM 普通块 → 16 字节对齐 | x86 普通块 → 16 字节对齐 |\n|---|---:|---:|\n'
for name in sorted({r['case'] for r in rows}):
 vals=[]
 for arch in ['aarch64','x86_64']:
  a=next(r for r in rows if r['arch']==arch and r['case']==name and r['variant']=='0000');b=next(r for r in rows if r['arch']==arch and r['case']==name and r['variant']=='0016');vals.append(f"{a['ns']:.2f} → {b['ns']:.2f}")
 chapter+=f"| `{name}` | {' | '.join(vals)} |\n"
chapter+='''
ARM 两项长串改善约 10%；`underscore/short_pile_of_poo` 约回退 0.4%。x86 两项长串中位数均增加，但样本离散明显：普通块与对齐块的范围分别为 137.27–175.41 / 150.95–182.78 ns，以及 130.95–211.23 / 141.64–169.12 ns，不能据此确定稳定的退化比例。

补充测试覆盖 13 种长度 × 4 种地址 × 未命中、首部、中部、末部命中，共 208 个场景，每项每平台 3 次。具体退化如下，单位 cycles/调用：

| 场景 | ARM 普通块 → 对齐块 | x86 普通块 → 对齐块 |
|---|---:|---:|
| 16 字节，地址 8 mod 64，未命中 | 11.92 → 26.48 | 16.39 → 32.05 |
| 64 字节，地址 8 mod 64，未命中 | 25.70 → 37.64 | 23.84 → 38.55 |
| 2551 字节，地址 8 mod 64，未命中 | 713.61 → 650.34 | 507.58 → 522.60 |
| 2551 字节，地址 0 mod 64，未命中 | 635.35 → 633.51 | 508.90 → 506.70 |

该方法只确认了特定长串地址的收益。短串应保留原有处理方式，长度阈值和更多调用方仍需验证。目前没有可直接通用替换的修改。

### 2. 调整 LLVM 生成代码

修改示例是在复制接口的编译命令中逐项加入前述选项，保存 IR 和汇编并检查 `ldp` 是否消失，或主循环是否实际展开。完整命令在 `common/build-commands.json`。

| 选项 | 对本例的作用 | 可能影响与限制 |
|---|---|---|
| `-Cllvm-args=-aarch64-enable-ldst-opt=false` | 阻止 ARM 加载/存储配对，保留独立加载 | 指令数增加，也会影响其他有利的配对；仅适合诊断或限定范围重编译 |
| `-Cllvm-args=-disable-lsr` | 改变循环寻址形式，本例不再生成该处 `ldp` | 其他循环可能增加地址计算成本；本例不能把全部收益归到单条指令 |
| `-Cllvm-args=-unroll-count=4 -Cllvm-args=-unroll-runtime=true` | 展开本例主循环，减少循环控制 | 代码体积、尾部处理和寄存器压力增加；短串或早退出场景可能回退 |

这些是 LLVM 23.1.0 的实验选项。仅给应用程序添加选项不会改变预编译标准库；必须重编译包含目标函数的库。当前数值来自接口副本，尚未作为标准库构建方案验证。

### 3. 用 NEON / SSE2 分块比较加速原扫描算法

诊断调用示例使用 `memchr` 2.8.3 的显式 128 位实现，避免把 x86 默认分派到 AVX2 的结果与 ARM NEON 混为同宽比较：

```rust
// ARM；x86 对照使用 arch::x86_64::sse2::memchr::One。
let searcher = fast_memchr::arch::aarch64::neon::memchr::One::new(needle).unwrap();
let result = searcher.rfind(bytes);
```

实际代码见 `common/probes.rs`。向量比较一次检查 16 个字节，并展开成 64 字节循环，减少整数零字节检测和循环控制。对原长文本的末字节 `A4` 搜索，独立字节接口测试 ARM 从 219.37 ns 降到 57.47 ns，x86 从 155.65 ns 降到 35.62 ns。该驱动的地址与原 libtest 不同，收益仅属于字节扫描对照。

同样测了 208 个长度、地址、命中位置场景。ARM 的 65 字节、地址 0 mod 64、末部命中从 7.96 增至 8.72 cycles，约回退 9.6%；x86 同场景为 13.75 → 10.15 cycles。此方法尚未接入完整 `str::rfind` 接口，不能据字节扫描结果宣称字符串接口整体改善。

## 验证范围与证据

ARM 使用 HiSilicon 服务器 CPU 52，具体商业微架构型号未知；x86 使用 i7-12700 的 P 核 12，同核线程仍有活动。两平台缓存行均为 64 字节。工具链为同一套 rustc 1.99.0-dev、LLVM 23.1.0，默认目标特性。源码提交 `dc55da5cca14a0aa773ecb7a0459756260b2ee5c`；冻结标准库与当前 `memchr.rs` 一致。`pattern.rs` 字符搜索相关部分一致，文件其他位置存在先前的 contains 改动，差异已留存。

各阶段均绑核、固定地址随机化条件、交错运行；PMU 无复用、迁移为 0。x86 接口替换阶段记录到 1 次 major fault，并有调度与频率波动；所有样本保留，未选择性删除。表格使用各组中位数，不能将小幅变化一概视作稳定收益。

字节差分检查每配置覆盖 251168 例，包含所有目标字节、边界长度、地址和随机输入；动态替换下另有 83592 例字符及单字节字符串搜索检查，均通过。性能矩阵不能穷举所有内容分布；尚未覆盖其他微架构、全部命中密度、完整标准库重建及 `rsplit` 等其他调用方。

本次确认了配对加载跨 32 字节边界的额外成本，并在原测试上验证约 10% 的长串改善。ARM 与 x86 的剩余差距尚未全部拆分，不能用整数端口数量或缓存容量推断。两平台运行频率也不同，耗时比与周期比需分别查看。

证据目录：`analysis/data/str-rfind-20261106/`。`README.md` 说明复现步骤；`*-summary.csv`、`*-comparison.csv` 为全部场景汇总，`arm/`、`x86/` 保存原始输出、计数、正确性检查、IR、汇编和环境。旧两节 find/rfind 记录保存在 `previous-find-rfind-sections.md`，历史原型收益不作为此次结论。

'''
(d/'chapter.md').write_text(chapter)
(p/'conclusion-proposed.md').write_text(before[:start]+chapter+before[end:])
(d/'merge-plan.json').write_text(json.dumps(dict(before_sha256=hashlib.sha256(before.encode()).hexdigest(),prefix_sha256=hashlib.sha256(before[:start].encode()).hexdigest(),suffix_sha256=hashlib.sha256(before[end:].encode()).hexdigest(),old_start_line=before[:start].count('\n')+1,old_section_lines=before[start:end].count('\n')),indent=2))
# Preserve full independent evidence; exclude redundant transport archives and report copies.
shutil.copytree(p/'arm-final',d/'arm',dirs_exist_ok=True)
(d/'x86').mkdir(exist_ok=True);shutil.copytree(p/'x86_64-unknown-linux-gnu',d/'x86/x86_64-unknown-linux-gnu',dirs_exist_ok=True)
(d/'common').mkdir(exist_ok=True)
for f in p.iterdir():
 if not f.is_file() or f.suffix in ['.gz','.lock'] or f.name.startswith('conclusion-'):continue
 if '.x86_64.' in f.name or f.name.endswith('.x86_64.json') or f.name.endswith('.x86_64.log'):shutil.copy2(f,d/'x86'/f.name)
 elif f.suffix in ['.rs','.py','.json','.txt','.ll','.log']:shutil.copy2(f,d/'common'/f.name)
(d/'README.md').write_text('''# str::rfind 双平台分析证据

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
''')
manifest=[]
for f in sorted(d.rglob('*')):
 if f.is_file() and f.name!='SHA256SUMS':manifest.append(hashlib.sha256(f.read_bytes()).hexdigest()+'  '+str(f.relative_to(d)))
(d/'SHA256SUMS').write_text('\n'.join(manifest)+'\n')
with tarfile.open(p/'delivery.tar.gz','w:gz')as t:t.add(d,arcname='str-rfind-20261106')
print('chapter lines',chapter.count('\n'),'files',len(manifest),'archive bytes',(p/'delivery.tar.gz').stat().st_size)
