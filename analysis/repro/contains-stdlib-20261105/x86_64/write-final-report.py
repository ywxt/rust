from pathlib import Path
import json
r=Path(__file__).resolve().parent;d=json.loads((r/'comparison.json').read_text());a=d['aarch64'];x=d['x86_64'];ab={(v['variant'],v['case']):v for v in a['counted']};xb={(v['variant'],v['case']):v for v in x['counted']}
s='''

# 标准库内实现 `str::contains` 通用单字节 SIMD 路径并重建验证（2026-11-05）

本节落实到实际远程标准库，替代前节外部完整Pattern包装原型作为本轮代码结论。个人实验，不用于上游贡献；未新增inline属性。实际工作树 `/home/wheel/c00936152/rust-analysis`，源码HEAD `dc55da5cca14a0aa773ecb7a0459756260b2ee5c`，包含用户已有library改动；基线与修改版均保留这些已有改动，差别仅为本节标准库实现。main在表中指未修改contains的同源基线，不是重新拉取最新main。

## 实际修改与功能范围

- `library/core/src/str/pattern.rs:591`：Pattern for char 的ASCII分支，在支持的目标上、haystack至少64 B时进入SIMD；更短输入保留原有slice contains路径。
- `library/core/src/str/pattern.rs:1008`：Pattern for &str 的既有len=1分支采用相同路径。needle来自运行时参数，没有固定 `!` 或0x21。
- 同文件2026/2041/2059行新增NEON/SSE2的64 B比较与布尔扫描函数。先检查首字节，命中立即返回；长度至少128 B时覆盖前缀并将后续主体对齐64 B；尾部重叠检查最后64 B，所有读取均在输入切片内。
- `library/alloctests/tests/str.rs:2681`、2708行新增全ASCII/长度/偏移与完整Pattern语义测试，保留用户此前已有内容。

`str::contains<P: Pattern>` 的公共入口和签名保持标准实现，调用原有Pattern方法；空串、多字节/Unicode字符串、非ASCII字符、字符集合、谓词、自定义Pattern仍保留标准语义。实现只加速既有单字节分支，没有外部specialization包装，也不要求调用者改成自定义函数。unsupported SIMD目标继续执行原有路径；实际验证目标为ARM64 NEON和x86_64 SSE2。

实现要点（完整可编译源码在归档的pattern.optimized.rs及实际仓库）：

```rust
// 概略流程；不是独立实现文件。
// 原有char ASCII分支或&str len=1分支：
if haystack.len() >= 64 {
    return contains_byte_simd(haystack.as_bytes(), needle);
}
// 随后保留原有标量路径。
```

完整实现中平台条件、短路径、字节值来源和边界处理全部包含；上面只说明接入位置。64 B比较是四组16 B相等比较，先向量OR再判断是否有匹配；不构造64位位置掩码，也不计算匹配索引。它仅服务contains布尔语义，未替换find/rfind所需的索引查找。

## 真正重建标准库与版本控制

此前原型使用缓存Rust1.101/LLVM23.1.4；实际远程工作树是Rust1.99。不能将两个版本混作本次优化前后。本节两目标均由远程同一个stage1 rustc1.99.0-dev、LLVM23.1.0编译，Cargo1.99.0-nightly（b07e5a086，2026-08-07）。x86程序在ARM上交叉生成，再到i7-12700 P核12实际运行；ARM绑核52，HiSilicon具体微架构仍未知。

隔离构建工作树 `/home/wheel/c00936152/rust-contains-stdlib` 快照用户当前library，独立输出 `/tmp/contains-stdlib-build`。为复用已有1.99编译器而不重建编译器，使用local-rebuild及stage0，并仅在隔离bootstrap中允许宿主std重建、安装重建产物。build-only修正存为bootstrap-local-rebuild.patch，实际用户仓库bootstrap未修改。未采用试验过的自定义JSON目标，两边最终都用内置GNU目标。

基线/优化sysroot按Cargo真实dist/build/*/*/out产物组装，不使用stage0自动复制来的旧宿主库。每个目标仅保存一个core/std/test版本，完整SHA清单为baseline-sysroot-manifest.json、optimized-sysroot-manifest.json；运行前逐文件核验。原有str测试安装的core也核验与优化快照相同，实际源码与已测pattern.optimized.rs逐字节一致。源码对照、应用构建参数和两个目标由同一编译器生成的命令均保存。

构建中曾误跟随sysroot源码链接，产生递归副本；已删除本任务副本并确认/tmp空间恢复。最终快照只取明确的目标库文件，原仓库和工具链未覆盖。交叉sysroot中libgcc_s运行库、LLD驱动名及Cargo版本兼容问题均已修正；失败日志保留，最终成功构建日志单列，不将失败产物计入测量。

## 语义验证

最终版本在两平台各通过5,573,952次独立对照，预期由窗口逐字节匹配、逐字符比较及显式谓词遍历计算，不用修改后的contains作为字符串/char预期。覆盖128种ASCII值、64种偏移、0..70及多个阈值/大长度至65536 B、未命中/首/中/尾、随机Unicode、空串、长needle、&String、字符数组/切片、FnMut访问次序。额外检查自定义Pattern覆写方法的调用和析构次数、借用有状态谓词行为。

原有coretests/alloctests中与str匹配的571项单元测试以及136项benchmark冒烟检查通过，共707项；包含本次新增两项测试。命令及原始输出在in-tree-str-tests-v2.log。未修改标准库公共API，没有新增inline属性，未提交或推送。

## 测量方法与计时干扰

最终第二版完成两平台28组完整libtest基准的main/优化交错三轮（每台168条），覆盖8个原始多字节bench_contains、8个contains_bang和12个空串/Unicode/NUL/集合/谓词补充项。haystack与needle每次查询统一black_box。另做144种动态needle输入的直接计数矩阵（每台864条）。

发现libtest同一二进制在不同轮次间出现约2倍墙钟波动。第一版x86 char长串的原始日志例：100.27 ns时CPU/墙钟约1.00，211.03/214.97 ns时CPU/墙钟约0.50；对同一基线补测为105.07 ns、CPU利用比例约0.986。这些记录在previous-v1/libtest-timing-audit.json、wall-control.json及原始日志。不能将墙钟ns乘以整进程CPU频率得到的“cycles估计”当作精确每调用周期，也不能把大波动全部归因于库算法。全局cgroup配额检查未发现throttling；具体外部抢占来源未追踪。

因此本节主表采用固定调用次数：保留28种benchmark的原始输入、查询体、assert/black_box，仅将自适应计时器替换成确定N的迭代驱动。每项每次200万或1000万调用，计数为cycles:u/N，未减空循环。包含每次查询的输入/结果屏障和循环成本；整进程一次性准备也计入后按N摊薄。它是完整查询体的受控复现，不等同于原始libtest调用栈。

基线/优化采用等长v0/v1运行路径，并只对被测进程关闭ASLR；程序自身读取personality确认标志实际继承。两平台每个case三次交错，中位数及min/max全部保存；CPU时间、墙钟和其比例也记录。原始libtest和144场景矩阵数据完整保留，未因不利结果删除。所有实际计数的PMU运行比例100%，x86 cpu_atom未计数事件排除。每台先语义核验，再libtest、固定计数、输入矩阵、采样，时间戳记录且无本任务性能阶段重叠。

## 最终结果：直接cycles/调用

变化为优化版相对本平台基线；负数表示减少周期。R=ARM cycles/x86 cycles。以下均为本节真实标准库、固定N对照，不能与前节外部原型或Rust1.101缓存数字拼接。

| 查询场景 | ARM前→后 | ARM变化 | x86前→后 | x86变化 | R前→后 |
| --- | ---: | ---: | ---: | ---: | ---: |
'''
for k in sorted(k[1] for k in ab if k[0]=='baseline'):
 av=ab['baseline',k];ao=ab['optimized',k];xv=xb['baseline',k];xo=xb['optimized',k];am=av['cycles'];ap=ao['cycles'];xm=xv['cycles'];xp=xo['cycles'];label=k.removeprefix('str::')
 s+=f'| {label} | {am:.2f}→{ap:.2f} | {(ap/am-1)*100:+.1f}% | {xm:.2f}→{xp:.2f} | {(xp/xm-1)*100:+.1f}% | {am/xm:.3f}→{ap/xp:.3f} |\n'
s+='''
ARM原始2551 B末尾命中的字符串查询694.66→157.56 cycles（−77.32%），x86 486.90→138.02（−71.65%），R从1.427降至1.142。char版本R从1.459降至1.112。NUL与~同样改善，收益不依赖 `!`。这些收益属于相应的单字节扫描输入，不能推广到整个contains接口的任意调用。

回退完整列出：ARM short_pile_of_poo字符串65 B为23.23→25.46 cycles（+9.6%）；该输入唯一!在末尾，当前实现首64 B未命中后又重读最后64 B，额外重叠工作已确认，但未单独隔离该回退的全部成本。多字节16 B针长串约+1.5%/+1.8%（ARM/x86）；Unicode字符命中x86约+3.8%，谓词约+3.4%。多字节/集合/谓词算法未改，其他变化不归为SIMD算法收益，代码生成/布局等影响尚未完全分离。

## 地址、长度与动态字节值范围

合成矩阵为8/16/32/64/128/256/2551/65536 B、地址mod64=0/1、首/尾/未命中、needle=NUL/A/~，共144场景。needle由命令行运行时提供，每调用black_box；实际输入为ASCII填充与指定匹配，不是lorem或真实Unicode数据。cycles使用已知N直接相除，矩阵保留通常ASLR条件，与关闭ASLR的主表条件区分。

| 长度/偏移/needle/命中 | ARM前→后 cycles | x86前→后 cycles |
| --- | ---: | ---: |
'''
for le,off,dist,n,label in [(8,0,'front',65,'8/0/A/首'),(16,0,'front',65,'16/0/A/首'),(32,0,'absent',65,'32/0/A/未命中'),(64,0,'last',65,'64/0/A/尾'),(128,0,'front',65,'128/0/A/首'),(2551,1,'absent',0,'2551/1/NUL/未命中'),(65536,1,'absent',126,'65536/1/~/未命中')]:
 vals=[]
 for arch in [a,x]:
  vv={v['variant']:v for v in arch['matrix'] if (v['length'],v['offset'],v['distribution'],v['needle'])==(le,off,dist,n)};vals.append(f"{vv['baseline']['cycles']:.2f}→{vv['optimized']['cycles']:.2f}")
 s+='| '+label+' | '+' | '.join(vals)+' |\n'
s+='''
该合成矩阵90个长度至少64 B的场景均改善：ARM降5.4%–79.5%，x86降10.9%–73.0%。但真实65 B fixture仍有上述ARM回退，因此不能说所有≥64 B输入都改善。极短输入虽保留原算法，新增入口判断和代码生成仍有成本；矩阵最大回退ARM约7.1%、x86约27.6%，具体场景/范围见JSON。当前仅验证固定重复热数据；冷缓存、随机切换needle/命中位置、其他CPU和native/LTO构建未测。

第一版曾对16 B以上直接进入SIMD，短/提前命中真实计数有较大回退。最终版本收紧至64 B并加首字节快速返回；previous-v1/保留其完整实现、库、原始记录和控制实验。主表仅使用第二版，不拼接不同版本中最好值。

## 证据、复现与剩余限制

实际源码修改已经留在远程原仓库上述两文件。持久证据归档于 `analysis/repro/contains-stdlib-20261105/`，common/包含标准库补丁、原文件/最终文件、构建配置和日志、隔离bootstrap修正、独立检查及完整驱动；aarch64/、x86_64/含每台程序、运行时动态库、IR/汇编、原始perf、三轮统计与计时审计；previous-v1独立保留前版数据。原始运行目录两端均为 `/tmp/contains-stdlib-20261105/`。完整静态sysroot元数据和工具链未全复制到精简归档，其SHA清单与构建命令保留；隔离源码工作树保持可复核。

```sh
# 在隔离工作树，按common/bootstrap.toml及bootstrap-local-rebuild.patch配置：
./x build --stage 0 library/std library/test --target aarch64-unknown-linux-gnu,x86_64-unknown-linux-gnu
./x test --stage 0 --set build.compiletest-allow-stage0=true library/coretests library/alloctests --target aarch64-unknown-linux-gnu --test-args str::
# 按build-harness.py，以保存的基线/优化sysroot分别构建：
python3 build-harness.py optimized check custom-check benches matrix counted
# 运行对应机器的已构建程序（先正确性，后性能阶段串行）：
python3 run-checks.py
python3 run-benches.py
python3 run-counted.py
python3 run-matrix.py
```

runtime归档可直接用run-counted.py、run-matrix.py配合已构建程序运行；run-final.py的逐文件静态元数据校验和重新编译需要完整sysroot。x86交叉链接依赖归档配置中的clang/LLD与匹配C运行库；ELF解释器是本机Nix glibc路径。工具链rustc1.99/LLVM23.1.0、原始target-cpu未知；本轮内置目标未指定target-cpu，ARM默认NEON、x86默认SSE2，应用参数统一 `-O --edition=2024 -Cprefer-dynamic -Zinline-mir -Cllvm-args=-import-instr-limit=10`。未新启用inline属性；继承的应用MIR选项两边一致。完整编译器、CPU、kernel、libc、perf、源码SHA和三轮范围见comparison.json及common/。

结论限定为：完整标准库接口内的通用单字节长扫描有已测显著收益，保留所有Pattern功能；短输入和部分真实fixture仍有回退，尚不能作为无条件的contains通用性能改进。没有对未测路径宣称收益，也没有宣称多字节搜索算法已经优化。
'''
# Source comments in the illustrative snippet are explanatory report text, not a production patch.
(r/'report-section.md').write_text(s);print('final report lines',len(s.splitlines()))
