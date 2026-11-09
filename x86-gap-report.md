# 920B 与 x86 的性能差距

比较对象为 HiSilicon 920B（2.9 GHz）与 X86 核。标准库测试提交为 `07e526db9df`，编译器为相同版本的 rustc 1.101.0-dev、LLVM 23.1.4；glibc 分别为 2.38 和 2.42。

`R = ARM cycles / x86 cycles`。R=1.30 表示完成相同工作时 ARM 多用 30% 的周期。以下先总结原因和代表性 benchmark，再列出修改方法。原始测量与 PR 数据分别保留各自的版本、输入和计时范围。

## 原因总结

### 源码缺少 NEON 路径

源码只为 x86 启用 SSE2 分块处理时，ARM 会执行逐元素判断和索引更新，长输入的指令数随元素数量增长。此类问题需核对平台条件、长度条件和测试版本。

| 接口与 benchmark | 原因及适用范围 | 证据 | 对应修改方法 |
|---|---|---|---|
| `[u8]::is_ascii`；`ascii::*::case00_libcore` | 早期实现提供 x86 SSE2 路径，AArch64 缺少对应 NEON 路径。PR #160143 已补齐，测试版本已包含 | 原 PR 的 long 对照从 19.69 降到 6.46 ns；该数据说明合入前缺少 NEON 的成本 | [NEON 批量检查](#method-neon-block) |
| `[u8]` / `str::eq_ignore_ascii_case`；`str::eq_ignore_ascii_case::bench_large_str_eq` | PR #160143 将至少 16 B 的分块路径扩展到 AArch64 NEON；测试版本在此长度已具备 SSE2/NEON 对应实现 | 原 PR 的长字符串对照从 6235.89 降到 546.61 ns | [补齐 NEON 平台路径](#method-neon-block) |

#### 示例：平台条件遗漏 AArch64

仅为 SSE2 启用分块比较时，入口形态如下。片段省略等长检查；`eq_ignore_ascii_case_chunks` 表示原实现的分块辅助函数。

```rust
#[cfg(all(target_arch = "x86_64", target_feature = "sse2"))]
if a.len() >= 16 {
    return a.eq_ignore_ascii_case_chunks::<16>(b);
}
a.eq_ignore_ascii_case_simple(b)
```

相同的长输入在 x86 进入分块路径，ARM 落入逐字节路径。PR #160143 已补齐该平台条件，当前测试版本包含此改动。

### LLVM 优化产生低效代码

以下问题已通过生成代码、关闭具体优化或固定代码地址的对照确认。

| 原因 | 代表性接口和 benchmark | 实验解释 | 代码示例与 IR | 对应修改方法 |
|---|---|---|---|---|
| 将难以预测的条件选择改成分支 | BinaryHeap 创建：`BinaryHeap::from/pop`；`binary_heap::bench_from_vec`、`bench_find_smallest_1000` | 随机子节点选择适合使用无分支选择指令，实际生成了条件分支，分支预测失败（branch-miss）明显增加。随机输入对照从 89849 降到 22696 次，约减少 75%。关闭后 ARM 从 1830893 降到 1160030 cycles，x86 为 1197668，解释主要差距。[L01](analysis/repro/L01-select-opt/) | [子节点选择](#example-llvm-select) | `-C llvm-args=-aarch64-select-opt=false` [说明](#method-llvm-options) |
| 将可预测分支改成条件选择，增加地址依赖 | 手写 UTF-8 字符计数；`str::char_count::ru_huge::case03_manual_char_len` | 两字节字符的分支容易预测，实际改用 csel 后，下一字符地址必须等待当前判断结果，增加每字符的等待时间。保留分支后 ARM 从 8.16 降到 1.80 cycles/字符，x86 为 1.76–2.35；中文输入只减少约 0.13。[L02](analysis/repro/L02-ifconv-csel/) | [字符长度](#example-llvm-ifcvt) | `-C llvm-args=-aarch64-enable-early-ifcvt=false` [说明](#method-llvm-options) |
| 循环出口比较多生成整数指令 | `SkipWhile::fold/try_fold`；`iter::bench_skip_while_sum`、`bench_skip_while_ref_sum` | 循环只需比较索引和结束值，实际在比较前额外执行一条 add，使每个元素都增加整数指令开销。消除后 ARM 从 1.873 降到 1.036 cycles/元素，x86 约为 1.006。[L04](analysis/repro/L04-lsr-cmp-imm/) | [双循环出口](#example-llvm-lsr) | `-C llvm-args=-disable-constant-hoisting` [说明](#method-llvm-options) |
| 向量加载和重排选择不佳 | `str::chars().count()`；`str::char_count::*::case00_libcore`；结构体字段抽取 `vec::bench_map_fast/regular` | 连续数据本可按顺序加载，实际生成 ld4 及额外的栈写入读回，增加数据搬移和等待；ARM 为 0.1862 cycles/B；关闭该加载选择后为 0.1486，x86 为 0.1499。字段抽取中，VectorCombine 将 8 个 i32 加载缩成 7 个，产生逐 lane 加载和搬移；关闭约快 6%，完整 benchmark 仍有剩余差距。[L03](analysis/repro/L03-interleave-ld4/)、[L07](analysis/repro/L07-aos-ld1-lane/) | [字符计数与字段抽取](#example-llvm-load) | chars count：`-C llvm-args=-enable-interleaved-mem-accesses=false`；AoS：`-C llvm-args=-disable-vector-combine` [说明](#method-llvm-options) |
| 栈槽复用与写入配对增加写后读等待 | `Any::downcast_ref`；`any::bench_downcast_ref` | 两个指针的配对读回跨越不同来源的写入；TypeId 返回缓冲区又被不同宽度临时值反复覆盖，增加写后读等待。固定地址对照：默认 20.134 cycles，只移动栈槽 20.175，只配对写入 13.063，组合处理并消除重复覆盖后 4.990。ARM 四个代码地址均重现主要差距；x86 原循环约 5.1 cycles。局部 LLVM 修法尚未实现。[双平台修复分析](any-downcast-ref-analysis.md) | [Any 栈槽](#example-llvm-stack) | 分别测试 `-C llvm-args=-no-stack-coloring`、`-C llvm-args=-aarch64-enable-ldst-opt=false`，其他写法可能回退 [说明](#method-llvm-options) |

分支和条件选择的优劣取决于预测准确率及数据依赖。前两项分别需要保留无分支选择和保留可预测分支，不能使用统一规则。

下列 Rust 或流程片段说明触发条件，IR 保留对应的数据依赖和控制流。IR 节选的完整函数及复现命令见各实验链接。

<a id="example-llvm-select"></a>
#### 示例：随机子节点选择被转换成分支

堆调整需要选出较大子节点。随机数据下，左右子节点的大小关系难以预测。

```rust
child += usize::from(data[child] <= data[child + 1]);
let selected = data[child];
```

[L01 的 IR 节选](analysis/repro/L01-select-opt/repro.ll)：

```llvm
%pl = getelementptr inbounds i32, ptr %d, i64 %child
%pr = getelementptr inbounds i32, ptr %pl, i64 1
%l = load i32, ptr %pl
%r = load i32, ptr %pr
%le = icmp ule i32 %l, %r
%z = zext i1 %le to i64
%c = add i64 %child, %z
%pc = getelementptr inbounds i32, ptr %d, i64 %c
%v = load i32, ptr %pc
```

IR 用比较结果计算索引。受测 ARM 后端将它转换成条件跳转；关闭 select-optimize 后使用 cinc，避免这次随机分支。

<a id="example-llvm-ifcvt"></a>
#### 示例：可预测字符分支被转换成条件选择

合法 UTF-8 首字节可以决定字符长度，下一次加载地址取决于该长度：

```rust
let len = if first < 0x80 { 1 }
          else if first < 0xe0 { 2 }
          else if first < 0xf0 { 3 }
          else { 4 };
i += len;
```

[L02 的 IR 节选](analysis/repro/L02-ifconv-csel/repro.ll)：

```llvm
multi:
  %two = icmp ult i8 %b, -32
  br i1 %two, label %latch, label %big
big:
  %three = icmp ult i8 %b, -16
  %l34 = select i1 %three, i64 3, i64 4
  br label %latch
latch:
  %len = phi i64 [ 1, %loop ], [ 2, %multi ], [ %l34, %big ]
  %i2 = add i64 %i, %len
```

`i8 -32` 的无符号值是 224。early-ifcvt 将两字节路径合并成 csel，使下一地址需要等待本次比较。俄文输入中该分支高度可预测，保留分支有利于后续加载提前执行。

<a id="example-llvm-lsr"></a>
#### 示例：两个循环共用大常数时生成额外 add

同一函数有两条相似循环，出口都比较 1000000。下面是 [L04](analysis/repro/L04-lsr-cmp-imm/repro.ll) 中其中一条循环；完整复现包含第二条同形循环：

```llvm
a:
  %x = phi i64 [ 1001, %entry ], [ %x2, %a ]
  %x2 = add i64 %x, 1
  store volatile i64 %x, ptr %p
  %c1 = icmp eq i64 %x2, 1000000
  br i1 %c1, label %exit, label %a
```

LSR 将出口重写为加偏移后比较 1001，常量提升又使该偏移失去立即数形式。受测循环最终每轮多一条 add。单循环及可编码为比较立即数的 4095 对照均没有同样问题。

<a id="example-llvm-load"></a>
#### 示例：连续字段加载被选择为低效序列

字符计数中的四组相邻 64 位字执行相同运算。[L03](analysis/repro/L03-interleave-ld4/repro.ll) 的单组 IR 为：

```llvm
%w0 = load i64, ptr %p0
%n0 = xor i64 %w0, -1
%a0 = lshr i64 %n0, 7
%b0 = lshr i64 %w0, 6
%o0 = or i64 %a0, %b0
%m0 = and i64 %o0, 72340172838076673
%s0 = add i64 %c, %m0
```

完整循环重复四组。向量化器选择的交错加载在 ARM 生成 ld4 并产生栈溢出和读回；关闭该交错加载选择后仍能向量化，并消除这些栈访问。

结构体数组抽取偶数字段则由 [L07](analysis/repro/L07-aos-ld1-lane/repro.ll) 表示，完整函数如下：

```llvm
define void @f(ptr %s, ptr %d) {
  %w = load <8 x i32>, ptr %s, align 4
  %v = shufflevector <8 x i32> %w, <8 x i32> poison,
                    <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  store <4 x i32> %v, ptr %d, align 4
  ret void
}
```

VectorCombine 因最后一个 lane 未使用，将加载缩成 7 个 i32，后续无法识别 ld2，生成额外逐 lane 加载和搬移。

<a id="example-llvm-stack"></a>
#### 示例：不同宽度临时值复用返回缓冲区

原 Any 循环包含胖指针初始化、动态调用和结果比较：

```rust
let mut x = 0isize;
let mut y = &mut x as &mut dyn std::any::Any;
std::hint::black_box(&mut y);
std::hint::black_box(y.downcast_ref::<isize>() == Some(&0));
```

[L10 的 IR 节选](analysis/repro/L10-stack-coloring-sret/repro.ll)：

```llvm
%b = alloca [1 x i8], align 1
%p = alloca [8 x i8], align 8
%s = alloca [16 x i8], align 16
call void @llvm.lifetime.start.p0(ptr %b)
store i8 %flag, ptr %b
call void asm sideeffect "", "r,~{memory}"(ptr %b)
call void @llvm.lifetime.end.p0(ptr %b)
call void @llvm.lifetime.start.p0(ptr %p)
store ptr %arg, ptr %p
call void asm sideeffect "", "r,~{memory}"(ptr %p)
call void @llvm.lifetime.end.p0(ptr %p)
call void @llvm.lifetime.start.p0(ptr %s)
call void %fn(ptr sret([16 x i8]) %s, ptr %arg)
%v = load i128, ptr %s, align 16
```

三个分配的生命周期不重叠，栈槽复用可将它们放到同一位置。AArch64 的胖指针初始化还存在跨不同写入来源的配对读回。两项需结合验证；固定地址组合实验与双平台结果见 [Any 专项分析](any-downcast-ref-analysis.md)。

### 硬件执行能力存在差异

相同算法会因指令吞吐、依赖延迟和访存能力不同，产生不同成本。算法的循环组织和数据访问方式决定了这些成本出现的次数。

| 原因 | 代表性接口和 benchmark | 测量及解释 | 示例 | 对应修改方法 |
|---|---|---|---|---|
| 整数指令吞吐较低 | Iterator 计数与筛选；`iter::bench_enumerate_ref_sum`、`bench_next_chunk_filter_map_even` | 独立 add 每轮 16 条时为 4.36/3.10 cycles，32 条时为 8.36/5.61。受测 ARM 约每周期完成 4 条，x86 接近 6 条。额外索引、计数和控制指令更容易限制 ARM 吞吐；物理端口数尚未直接确定。[B7](analysis/repro/B7-alu-throughput/) | 每元素执行 `sum += x; index += 1; remaining -= 1;`，除数据计算外还需多条控制指令 | BTreeMap：[叶内索引推进](#method-btree-iter)、[按节点析构和释放](#method-btree-drop) |
| 数据相关分支难以预测 | `Vec::retain/retain_mut`、`VecDeque::retain`；`vec::bench_retain_100000` 及随机保留比例的独立对照 | 首个删除元素之后，每元素都要根据谓词结果选择删除或搬移。随机结果增加误预测；写索引还依赖保留结果。当前已确认这些操作的优化空间，尚无同条件双平台分解数据能确定各项占跨机差距的比例。VecDeque 另有环形索引和交换成本。[retain 对照](optimizable-interfaces.md) | 随机输入执行 `v.retain(\|x\| x & 1 == 0)`；保留结果决定是否搬移及写索引是否增加 | Vec::retain：[分块谓词计算与 SVE 压缩](#method-retain)（实验路径）；VecDeque::retain：无 |
| 指令依赖链延迟较高 | `extract_bits`、u16 fold；`num::int_bits::*::extract_bits`、`fold_u16` | 受测 NEON 移位、异或依赖延迟约 2 cycles，SSE 约为 1。多级运算累积延迟。u16 fold 的独立交错数量从 2 改到 4 后，ARM 从 0.254 降到 0.182 cycles/元素，x86 为 0.198→0.200。[S6](analysis/repro/S6-neon-latency/)、[L14](analysis/repro/L14-fold-u16-interleave/) | `q = x & mask; x ^= q; x ^= q >> n;`，后续运算需要前序结果 | extract_bits：[等价加法与 usra](#method-extract)；Latin-1：[范围映射](#method-latin1)；u16 fold：`-C llvm-args=-force-vector-interleave=4` [说明](#method-llvm-options) |
| 写后读依赖延迟较高 | `Vec::push`、`String::push`、RandomState 计数器；`slice::push`、`string::bench_push_char_two_bytes`、`hash::map::new_drop` | 同地址状态读改写链约为 7.07/1.00 cycles。Vec push 对照将 len 保存在局部变量后，ARM 从 7.14 降到 2.03，x86 约为 2。HashMap 创建测试主要耗时来自线程局部计数器，R≈6.93。[B1](analysis/repro/B1-store-load/) | `ldr x0, [x1]` → `add x0, x0, #1` → `str x0, [x1]`，下一轮从同地址读取 | 无 |
| SIMD 比较结果提取为索引的成本较高 | memchr、`str::find/contains`、`Vec::dedup`；`str::find_zzz_char`、`vec::bench_dedup_none_*` | x86 可用 pmovmskb 压缩比较结果，ARM 需要多条归约和寄存器传送指令。密集命中对照为 27.0/16.6 cycles，长无匹配为 218/277，差距随命中分布变化。[L11](analysis/repro/L11-movemask/)、[S2](analysis/repro/S2-mask-floor/) | 16 个字节的比较结果转成 16 位掩码，再计算首个置位的位置；IR 见下文 | 无 |
| 未对齐或跨缓存行访问增加成本 | Vec 插入与结构体字段抽取；`slice::random_inserts`、`vec::bench_map_fast/regular` | 16 B 未对齐加载每条额外成本约为 ARM 0.30、x86 0.04 cycle。x86 字段加载的固定地址对照，消除跨行访问后从 7993.8 降到 6021.0 cycles，指令数相同。该字段实验使用两个字段内容相同的数据，通用改法仍需保留原字段值。[B6](analysis/repro/B6-unaligned/)、[字段加载对照](analysis/data/unknown-causes-20261103/aos-split-loads.x86_64.json) | 在缓存行偏移 52 B 处加载 16 B，访问范围跨越 64 B 边界 | 无 |
| 宽整数除法及溢出检查的指令支持不同 | `u128::isqrt`、整数解析；`u128_sqrt_uniform`、`num::bench_u64_from_str_radix_10` | 受测 65÷33 位除法在 ARM 进入 u128 软件路径，约为 37.19 cycles；x86 硬件除法为 19.05。数值范围允许缩为 u64 后为 14.02/16.04。乘法溢出检查中 ARM 需要高半部及比较，x86 可用溢出标志。[B3](analysis/repro/B3b-u128-div/)、[L06](analysis/repro/L06-smul-overflow/) | `((1u128 << 64) + 1) / ((1u128 << 32) + 1)`，属于 65÷33 位除法 | 无 |
| 加载吞吐和工作集容量不同 | `VecDeque::Iter::try_fold`、切片 rotate、二分查找；`vec_deque::bench_try_fold`、`slice::rotate_huge_by9199_big`、`binary_search_l3_with_dups` | 独立 64/128 位加载约为 ARM 每周期 2 条、x86 3 条。40 MiB 数据超出 x86 约 25 MB 的 L3，仍可容纳于 ARM 约 70 MiB 的 L3，部分 rotate 因此 ARM 较快。大步长访问会进一步增加缓存和地址转换开销。[S4](analysis/repro/S4-load-width/)、[M1](analysis/repro/M1-tlb-stride/)、[M5](analysis/repro/M5-l3-capacity/) | 独立加载 `a[i]`、`b[i]`、`c[i]` 观察吞吐；40 MiB 工作集分别与两平台 L3 容量比较 | 切片 rotate：[连续块交换与尾部 memmove](#method-rotate)；try_fold、二分查找：无 |

retain 的数据相关分支是算法中需要执行的工作；跨机差距还取决于实际预测结果和生成代码。SVE COMPACT 属于降低压缩成本的手段，具体原因仍按分支、索引依赖和搬移操作分析。

#### 掩码提取的 IR 示例

同一段 IR 可以在 x86 生成 pmovmskb，在 ARM 生成多条归约指令。下面是 [L11](analysis/repro/L11-movemask/repro.ll) 的完整掩码函数：

```llvm
define i16 @mask(<16 x i8> %v) {
  %c = icmp slt <16 x i8> %v, zeroinitializer
  %m = bitcast <16 x i1> %c to i16
  ret i16 %m
}
```

若接口只需要判断“有没有命中”，只需判断归约结果是否非零；若需要返回具体位置，还要计算完整位置。两种工作量在密集命中和长无匹配输入中的占比不同。

### 已定位耗时，但具体成因尚未完全确定

| 问题与代表性 benchmark | 已确认的部分 | 尚未确定的部分 | 示例 | 对应修改方法 |
|---|---|---|---|---|
| 小块分配；`vec::bench_from_slice_0100`、`linked_list::bench_collect_into` | 800 B malloc+free 为 31.36/17.72 cycles，指令数为 155/97。主要差距来自 ARM 分配路径执行更多指令。8000 B 时为 70.11/70.40 cycles，已接近。[G4](analysis/repro/G4-malloc/) | glibc 版本与指令集分别造成多少额外指令。tcache_count 从 7 改到 64 时两平台均改善约 26–27%，没有解释相对差距 | 分别测 `malloc(800); free(p);` 与 8000 B 对照，统计执行指令数 | 无 |
| 复制与填充；`vec_deque::bench_from_array_1000`、`vec::bench_extend_*` | 8 KB memcpy 约为 ARM 333、x86 138 或 220–222 cycles；两平台使用不同 libc 实现。1000 B memset 为 41.43/22.82；同宽 16 B 完全展开对照为 39.18/34.79。[G3](analysis/repro/G3-memcpy-variant/)、[填充对照](analysis/data/unknown-causes-20261103/fill.aarch64.json) | 库实现、指令宽度和硬件带宽对总差距的各自贡献。现有 ARM NEON/SVE 复制原型尚无稳定优势 | 预先分配两个 8000 B 缓冲区，只计 `memcpy(dst, src, 8000)`；与完整 Vec 构造分别计时 | 无 |
| 多层 PLT 调用；`fmt::write_u8_max` 等短整数格式化 | 相同 format! 动态 PLT 调用为 153.25/106.19 cycles，非 PLT 为 108.16/106.49。ARM 前端停顿显著下降；固定地址和纯算术深调用均重现。[调用链对照](analysis/data/unknown-causes-20261103/chain.aarch64.json) | CPU 内部哪项取指或预测资源造成停顿。返回误预测数据不足以解释该差距 | 同一 `format!("{}", 255u8)` 分别采用动态 PLT、非 PLT 与静态链接 | `-C prefer-dynamic -Z plt=no`（rustc 代码生成选项） [说明](#method-llvm-options) |
| Unicode 查表与独立查询；`str::debug::mixed`、`slice::binary_search_l1_worst_case`、部分 Zip 测试 | 批量交错完整 Unicode 查表，1 个字符时为 30.75/23.96、8 个时为 17.23/16.00 cycles/字符。说明增加独立工作有效。[查表对照](analysis/data/unknown-causes-20261103/batchfull.aarch64.json) | 原标准库中未充分重叠执行的具体限制。两平台 ROB 容量拐点接近，不能用 ROB 容量解释 | 一次完成字符 A 的全部查表；对照交错处理 A、B、C 等独立字符的查表步骤 | 无 |
| 整数分区；`slice::sort_unstable_large_random`、1024 元素的 `select_nth_unstable` | 整体排序 R≈1.17；select_nth 对照为 7176.9/5479.4 cycles。多种 LLVM 开关及布局变化均未消除差距，单轮手写分区也未重现 ARM 劣势。[U1](analysis/repro/U1-sort-state/) | 多轮数据状态、读写依赖与前后控制代码的分别贡献 | 对 1024 个随机元素执行 `values.select_nth_unstable(512)`，与单轮手写 partition 比较 | 无 |

### 测量条件影响

极短循环会受代码地址影响：相同 6 条指令改变 0–60 B 偏移，ARM 可从 1.007 变到 1.627 cycles/元素。slice push 的 x86 测试存在大量缺页，同核 pipe 自旋测试受调度影响；ASCII LONG 还包含分配复制和提前退出。相关结果使用单项对照解释。[布局实验](analysis/repro/F2-layout/)、[计时范围](analysis/repro/N4-bench-validity/)、[调度对照](analysis/repro/K2-spin-pinned/)

| 影响因素 | 示例 | 解读 | 对应修改方法 |
|---|---|---|---|
| 代码地址 | 同一 6 条指令循环，起点分别移动 0、16、32、48 B | 指令和输入相同仍可能改变短循环吞吐；收益需检查多个地址 | 无 |
| 数据准备与提前退出 | `let data = source.to_vec(); black_box(data.is_ascii());`，且 source 较早出现非 ASCII | 完整计时包含分配、复制；实际扫描长度由首个非 ASCII 的位置决定 | 无 |
| 缺页和线程调度 | 尚未触碰的内存上逐次 push；同核 pipe 两端以非阻塞自旋等待 | 用户态循环周期不能覆盖缺页或等待的全部成本，需分开测量并计入系统行为 | 无 |

## 修改方法

对应原因说明这些方法减少了哪些成本；PR 的单平台收益保留其原测量条件。表中 PR 有 4 项已包含在测试版本，相关收益已计入基线。

### 补齐 NEON 路径

| 已合入 PR 与接口 | 具体修改 | 对应原因与代表性 benchmark | 测试版本 | 修改示例 |
|---|---|---|---|---|
| [#160143](https://github.com/rust-lang/rust/pull/160143)；`[u8]::is_ascii`、`[u8]` / `str::eq_ignore_ascii_case` | is_ascii 使用 NEON，每 64 B 合并四个向量后做一次归约；大小写无关比较将至少 16 B 的分块路径扩展到 NEON | 补齐 x86 已有而 AArch64 缺少的批处理路径，减少逐字节控制。对应 `ascii::*::case00_libcore`、`str::eq_ignore_ascii_case::bench_large_str_eq` | 已包含；短输入仍按实际路径分析 | [示例](#method-neon-block) |

<a id="method-llvm-options"></a>
### 编译器与 LLVM 选项

以下为已用于原因验证的选项，按对应问题单独测试。关闭优化可能使其他写法回退；表中结果针对实验所用的 LLVM 23.1.4。示例中的输入文件分别取自所链接的复现目录。

| 对应问题 | 选项与修改示例 | 已验证的作用与范围 |
|---|---|---|
| 随机子节点选择被转成分支 | `rustc -O -C llvm-args=-aarch64-select-opt=false bench.rs` | 保留无分支选择；ARM BinaryHeap 对照约 1830893→1160030 cycles。[L01](analysis/repro/L01-select-opt/) |
| 可预测字符分支被转成 csel | `rustc -O -C llvm-args=-aarch64-enable-early-ifcvt=false bench.rs` | 保留两字节字符分支；俄文输入 ARM 约 8.16→1.80 cycles/字符。[L02](analysis/repro/L02-ifconv-csel/) |
| 循环出口比较多一条 add | `rustc -O -C llvm-args=-disable-constant-hoisting bench.rs` | 避免常量提升与 LSR 组合造成的冗余指令；ARM 约 1.873→1.036 cycles/元素。[L04](analysis/repro/L04-lsr-cmp-imm/) |
| chars count 选择 ld4 并产生栈存取 | `rustc -O -C llvm-args=-enable-interleaved-mem-accesses=false bench.rs` | 仍保留向量化，改变加载组织；ARM 约 0.1862→0.1486 cycles/B。[L03](analysis/repro/L03-interleave-ld4/) |
| AoS 字段加载被缩成 7 个 i32 | `rustc -O -C llvm-args=-disable-vector-combine bench.rs` | 避免破坏后续交错加载识别；ARM 对照约快 6%。[L07](analysis/repro/L07-aos-ld1-lane/) |
| Any 临时值与返回缓冲区复用栈槽 | `rustc -O -C llvm-args=-no-stack-coloring probe.rs` | 原 ARM 循环约 20.09→4.89 cycles；其他写法存在回退。[Any 双平台实验](analysis/data/any-downcast-ref-20261104/README.md) |
| Any 胖指针加载与写入配对不匹配 | `rustc -O -C llvm-args=-aarch64-enable-ldst-opt=false probe.rs` | 原 ARM 循环约 20.09→6.02 cycles；另一些写法会增加指令和耗时。[Any 双平台实验](analysis/data/any-downcast-ref-20261104/README.md) |
| u16 fold 独立工作不足 | `rustc -O -C llvm-args=-force-vector-interleave=4 bench.rs` | ARM 约 0.254→0.182 cycles/元素，x86 为 0.198→0.200。[L14](analysis/repro/L14-fold-u16-interleave/) |
| 动态 PLT 深调用产生较多前端停顿 | `rustc -O -C prefer-dynamic -Z plt=no alloc.rs` | 相同动态 libstd 下，format! 对照 ARM 约 153.25→108.16 cycles；该项是 rustc 代码生成选项。[PLT 对照](analysis/data/unknown-causes-20261103/README.md) |

### 根据硬件成本调整算法与运算形式

| 已合入 PR 与接口 | 具体算法或运算修改 | 减少的成本与代表性 benchmark | 测试版本 | 修改示例 |
|---|---|---|---|---|
| [#163521](https://github.com/rust-lang/rust/pull/163521)；`BTreeMap` 迭代和范围迭代 | 在同一叶节点内直接递增或递减索引，仅到节点边界才进入通用导航 | 减少每元素句柄替换、状态搬移和导航判断，降低整数吞吐及依赖链压力。对应 `btree::map::iteration_*`、`range_iteration_*` | 已包含 | [示例](#method-btree-iter) |
| [#162931](https://github.com/rust-lang/rust/pull/162931)；`BTreeMap` / `BTreeSet` 释放及 clear | 按节点后序处理并释放节点，节点内完成必要的元素析构 | 减少逐元素导航和游标更新，降低释放过程的重复整数操作。对应 `btree::map::clone_slim_*`、`clone_slim_*_and_clear`；这些测试包含对象释放 | 已包含 | [示例](#method-btree-drop) |
| [#162750](https://github.com/rust-lang/rust/pull/162750)；`char::to_lowercase/to_uppercase` | 对 Latin-1 使用范围判断、固定偏移和少数特殊映射，减少通用 Unicode 表查询 | 减少依次执行的加载、比较和下一地址计算，缩短查表依赖链。对应 `char::methods::bench_non_ascii_char_to_lowercase`、`bench_non_ascii_char_to_uppercase`；非 Latin-1 仍走原查表路径 | 已包含 | [示例](#method-latin1) |
| [#164611](https://github.com/rust-lang/rust/pull/164611)；整数 `extract_bits`，宽度至多 64 位 | 利用两个位区段不重叠，将异或形式改为等价加法，使 AArch64 可生成 usra | 减少多级移位和异或的依赖成本。u64 invariant 原 PR 对照为 288.77→211.51 ns。u128 保留原式，避免跨字进位链 | 未包含 | [示例](#method-extract) |
| [#162754](https://github.com/rust-lang/rust/pull/162754)；切片 `rotate_left/right` | 对满足大小和对齐条件的大元素，按多个机器字组织旋转，使算法采用连续块交换；一侧足够小时切换为带缓冲的 memmove | 减少 gcd 的大步长访问、较大临时值及尾部大量小交换。对应 `slice::rotate_huge_by9199_big`、`rotate_huge_by1234577_big`、half_plus_one 组；原 PR 前两项耗时分别降低约 48.4%、23.2% | 未包含 | [示例](#method-rotate) |

### Vec::retain 的实验修改方法

| 接口 | 对应原因与 benchmark | 具体方法 | 验证范围 | 修改示例 |
|---|---|---|---|---|
| `Vec::retain` / `retain_mut` | 随机保留结果导致分支误预测，写索引依赖保留数量；对应 `vec::bench_retain_100000`、`bench_retain_whole_100000` 和类型／长度矩阵 | 按块顺序计算谓词并保存掩码，使用 SVE COMPACT 批量压缩保留元素 | 测试分支已有受 SVE 构建条件控制的实验实现；上游合入记录和同条件 x86/ARM 收益尚未提供 | [u32 分块压缩](#method-retain) |

这些修改通过减少指令数、缩短依赖链或改善访问顺序，适应硬件成本差异；跨平台通用改进仍需分别比较两平台收益。LLVM 相关选项按问题分别使用，开关效果以对应实验为准。

### 修改示例

以下片段保留关键算法和条件；内部导航、内存操作及异常清理代码以对应 PR 为准。标注“伪代码”的片段只表示处理流程。

<a id="method-neon-block"></a>
#### NEON 批量检查与平台路径补齐

`is_ascii` 的 64 B 主循环合并四个向量，只做一次横向归约。示例省略短输入和尾部路径：

```rust
for chunk in bytes.chunks_exact(64) {
    let p = chunk.as_ptr();
    let max = unsafe {
        let a = vorrq_u8(vld1q_u8(p), vld1q_u8(p.add(16)));
        let b = vorrq_u8(vld1q_u8(p.add(32)), vld1q_u8(p.add(48)));
        vmaxvq_u8(vorrq_u8(a, b))
    };
    if max >= 128 { return false; }
}
```

`eq_ignore_ascii_case` 则复用 16 B 分块辅助函数，将平台条件扩展到 NEON。该条件修改节选自 PR #160143：

```diff
-#[cfg(all(target_arch = "x86_64", target_feature = "sse2"))]
+#[cfg(any(
+    all(target_arch = "x86_64", target_feature = "sse2"),
+    all(target_arch = "aarch64", target_feature = "neon")
+))]
```

前者减少每字节的控制和归约次数，后者让 ARM 能进入已向量化的分块比较。

<a id="method-btree-iter"></a>
#### 同一叶节点内直接推进索引

PR #163521 将叶节点内部的常见情况从通用导航中分离。伪代码：

```text
原流程：每个元素调用 next_kv，再构造 next_leaf_edge。
现流程：
    如果 index < 当前叶节点元素数：
        取当前叶节点的第 index 个键值
        游标直接更新为 index + 1
    否则：
        执行通用导航，跨越节点边界
```

例如一个叶节点含 11 个键值，处理前 11 个元素时只更新本节点索引；到边界才处理树导航。反向迭代使用对应的递减路径。该改动减少整数操作、句柄搬移和判断。

<a id="method-btree-drop"></a>
#### 按节点析构和释放

PR #162931 将通过 IntoIter 逐元素导航的释放流程改为节点后序遍历。伪代码：

```text
原流程：
    重复调用迭代器取得下一个键值并析构，期间维护逐元素游标。
现流程：
    node = 首个叶节点
    重复：
        析构 node 内的全部键值
        释放 node，取得后序遍历的下一个节点
        若没有下一个节点，结束
```

每个节点只导航和释放一次。元素析构仍然执行；节点内与节点间的清理守卫负责 panic 后的剩余析构和释放。无需析构的键值可消除相应操作，保留按节点释放。

<a id="method-latin1"></a>
#### 用范围运算替代通用查表

PR #162750 对 Latin-1 增加直接映射。小写映射的关键部分如下，前置 ASCII 分支与后续通用查表已省略：

```rust
if c <= '\u{ff}' {
    return match c {
        '\u{c0}'..='\u{de}' if c != '\u{d7}' => {
            [unsafe { char::from_u32_unchecked(c as u32 + 0x20) }, '\0', '\0']
        }
        _ => [c, '\0', '\0'],
    };
}
```

例如 `À` 通过加 `0x20` 得到 `à`，`×` 保持不变。大写路径采用减 `0x20`，并单独处理 `µ→Μ`、`ß→SS`、`ÿ→Ÿ`。这些字符因此省去通用 Unicode 表的多次依赖加载。

<a id="method-extract"></a>
#### 采用能生成 usra 的等价运算

PR #164611 针对 AArch64 NEON、位宽不超过 64 位的 extract_bits 阶段修改为：

```diff
 let q = x & masks[stage];
-x ^= q;
-x ^= q >> n;
+x = (x & !masks[stage]).wrapping_add(q >> n);
```

该阶段的掩码保证保留部分与右移部分没有重叠置位，加法与原异或等价。u128 保留原式，避免跨字进位成本。

下面的独立 IR 用两个 64 位 lane 展示移位量为 1 的阶段。`mask` 需满足该阶段的位区段条件；该等价关系不适用于任意掩码。

```llvm
define <2 x i64> @xor_stage(<2 x i64> %x, <2 x i64> %mask) {
  %q = and <2 x i64> %x, %mask
  %keep = xor <2 x i64> %x, %q
  %shift = lshr <2 x i64> %q, <i64 1, i64 1>
  %r = xor <2 x i64> %keep, %shift
  ret <2 x i64> %r
}
define <2 x i64> @add_stage(<2 x i64> %x, <2 x i64> %mask) {
  %notmask = xor <2 x i64> %mask, <i64 -1, i64 -1>
  %keep = and <2 x i64> %x, %notmask
  %q = and <2 x i64> %x, %mask
  %shift = lshr <2 x i64> %q, <i64 1, i64 1>
  %r = add <2 x i64> %keep, %shift
  ret <2 x i64> %r
}
```

LLVM 23.1.4 的 AArch64 后端对第二个函数生成 usra。完整 IR 和两平台汇编见[运算形式示例](analysis/data/report-examples-20261104/README.md)。

<a id="method-rotate"></a>
#### 大元素按机器字组织连续块交换

PR #162754 的第一项修改，使用原实现的内部参数表示：

```rust
if size_of::<T>() > size_of::<[usize; 4]>()
    && size_of::<T>() % size_of::<usize>() == 0
    && align_of::<T>() >= align_of::<usize>()
{
    let ratio = size_of::<T>() / size_of::<usize>();
    unsafe {
        ptr_rotate_dispatch(
            left * ratio,
            mid as *mut MaybeUninit<usize>,
            right * ratio,
        );
    }
}
```

片段省略 optimize_for_size 条件和回退分支。原内存按多个机器字组织后，分派可以选择连续块交换，减少大元素 gcd 的大步长访问；数据字节和元素顺序按原旋转语义保留。

#### 小尾部改用带缓冲的 memmove

同一 PR 的第二项修改，在块交换过程中检查剩余较短一侧能否放入栈缓冲区：

```rust
if const_min(left, right) <= size_of::<BufType>() / size_of::<T>() {
    unsafe { ptr_rotate_memmove(left, mid, right) };
    return;
}
```

带缓冲的旋转先保存较短一侧，再搬移较长一侧并放回缓冲数据。例如尾部只剩一个元素时，可以省去多轮小块交换。调用时仍保留原实现的非零大小、有效范围和构建配置条件。

<a id="method-retain"></a>
#### Vec::retain 分块计算谓词，再用 SVE 压缩

标量 retain 在首个删除元素之后，根据每个谓词结果选择删除或搬移，并推进写索引。以 u32、保留偶数为例：

```text
输入： [10, 11, 12, 13, 14, 15, 16, 17]
掩码： [ 1,  0,  1,  0,  1,  0,  1,  0]
输出： [10, 12, 14, 16]
```

分块方案先按顺序调用谓词并保存掩码，再批量搬移保留元素。u32 的处理流程如下，`compact_u32` 表示下面的 SVE 压缩步骤：

```text
read = 0，write = 0
对每个最多 64 个元素的块：
    按原顺序计算 predicate(&mut element)，每个元素恰好一次
    把结果写入 mask
    kept = compact_u32(当前块, mask, 写入位置)
    write += kept
    read += 本块元素数
最后将 Vec 长度设为 write
```

对一个 SVE 向量，u32 压缩的关键指令如下。p0 标记本次有效元素；x0 指向字节掩码，x1 指向源数据，x2 指向目标位置，x3 接收保留数量：

```asm
ld1b    { z0.s }, p0/z, [x0]
cmpne   p1.s, p0/z, z0.s, #0
ld1w    { z1.s }, p1/z, [x1]
compact z1.s, p1, z1.s
cntp    x3, p0, p1.s
whilelo p2.s, xzr, x3
st1w    { z1.s }, p2, [x2]
```

该方法减少搬移阶段的逐元素分支、写索引更新和写入指令。谓词计算仍需执行。示例限定 u32；泛型实现还须处理删除元素的析构、panic 清理、未读数据保护及元素顺序。小输入需要阈值，避免掩码和向量准备成本。

测试分支已包含受 `cfg(aarch64, target_feature="sve")` 控制的 retain_mut 实验路径。默认 generic 标准库未启用它；使用时需启用相应标准库构建，或实现运行时分派。现有记录没有该路径对应的上游合入 PR，也没有同条件 x86/ARM retain 收益数据。VecDeque 和 filter().collect() 的独立原型结果分别保留在[接口实验](optimizable-interfaces.md)，其收益不记入 Vec::retain。

## 数据来源

原因实验通常测三轮，使用周期最少一轮的配套计数，原始文件保留全部结果。全套 benchmark 原始结果包含多核并行及 x86 仅用户态计数，涉及缺页和系统调用时采用单项重测。PR 合入记录核对日期为 2026-11-03。

- [92 个分类条目及测量索引](analysis/data/classification.json)
- [逐项 benchmark 分析](benchmarks-conclusion.md)
- [双平台原因实验与复现命令](analysis/data/unknown-causes-20261103/README.md)
- [上游 PR 的状态、代码与测量来源](analysis/data/repair-classification-20261103/upstream-pr-index.json)
