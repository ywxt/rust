
## Vec 从切片迭代器收集时保留复制循环，分配释放成本随平台不同

`vec::bench_from_iter_0100` 在本次冻结版本中，ARM 为 **25.04 ns**，x86 为 **15.87 ns**，ARM 耗时为 x86 的 **1.58 倍**。ARM 已生成 NEON；两端每轮复制 32 字节，共执行 25 轮。已确认的差异包括复制循环的指令形式、运行频率，以及 libc 的分配释放路径。本次没有得到同时改善各长度场景的接口修改。

### 测量范围与接口

源码来自远程 `rust-analysis`，HEAD 为 `dc55da5cca14a0aa773ecb7a0459756260b2ee5c`，相关文件的内容校验和保存在证据目录。运行库使用此前冻结的 baseline sysroot，编译器为同一套 rustc 1.99.0-dev / LLVM 23.1.0，两个目标均采用默认 CPU 特性。相关 Vec、Cloned 和原 benchmark 源码与冻结副本逐文件一致。

ARM 使用远程 HiSilicon 服务器 CPU 52，x86 使用 i7-12700 的 P 核 CPU 12。固定次数对照中测得 cycles/task-clock 约为 2.88 GHz 和 4.42 GHz。libc 分别为系统 glibc 2.38 和 Nix glibc 2.42。本次结果适用于这两个运行环境。

| 接口 | 原 benchmark | 每次迭代的工作 | 对应方法及验证状态 |
|---|---|---|---|
| `Vec::from_iter(src.iter().cloned())` | `vec::bench_from_iter_0100` | 分配 800 字节，复制 100 个 `usize`，返回并释放 Vec | 调整 LLVM 交错因子已验证，有长度相关退化；批量复制特化尚未实现 |
| `src.as_slice().to_vec()` | `vec::bench_from_slice_{0010,0100,1000}` | 分配、通过批量复制路径初始化、释放 | 已有批量复制路径，用于对照 |
| `Vec::clone()` | `vec::bench_clone_{0010,0100,1000}` | 分配、复制、释放 | 已有批量复制路径，用于对照 |

原 benchmark 的核心如下，源 Vec 在计时循环外构造。类型由 `src_len: usize` 决定，因此 100 个元素占 800 字节。

```rust
let src: Vec<_> = FromIterator::from_iter(0..src_len);
b.iter(|| {
    let dst: Vec<_> = FromIterator::from_iter(src.iter().cloned());
    dst
});
```

每次迭代只分配一次，容量已知，没有逐次扩容。libtest 对返回值执行 black_box 后释放，因此计时包含释放。原 benchmark 函数体保持原样，在独立驱动中编译运行；库内其他未提交修改没有纳入本次冻结运行库。

### 原因：LLVM 保留向量复制循环，循环控制成本在两端不同

调用链为 `FromIterator → SpecFromIterNested<TrustedLen> → SpecExtend<TrustedLen> → extend_trusted → Cloned::fold`。当前实现没有针对 `Cloned<slice::Iter<T>>` 的直接批量复制特化，LLVM 将逐元素处理向量化。逐元素 `clone` 调用和长度维护已经消除。

两端主循环都处理 4 个 `usize`。ARM 需要更新源指针、目标指针和剩余元素数；x86 通过带比例索引的地址表达式共用索引。

```asm
// ARM，原 benchmark 主循环，每轮 32 字节
ldp  q0, q1, [x10, #-16]
subs x11, x11, #4
add  x10, x10, #32
stp  q0, q1, [x9, #-16]
add  x9, x9, #32
b.ne loop
```

```asm
# x86，每轮 32 字节
movups (%r13,%rdx,8), %xmm0
movups 16(%r13,%rdx,8), %xmm1
movups %xmm0, (%rax,%rdx,8)
movups %xmm1, 16(%rax,%rdx,8)
addq $4, %rdx
cmpq %rdx, %rcx
jne loop
```

指令条数不能直接换算为执行周期：`ldp/stp` 与 `movups` 的处理方式不同。汇编支持“地址和循环控制形式不同”的判断；具体执行端口、加载存储吞吐各占多少尚未测定。

最小复现保持接口调用相同，只改变输入参数类型：

```rust
#[unsafe(no_mangle)]
pub fn collect_from_slice(src: &[usize]) -> Vec<usize> {
    src.iter().cloned().collect()
}

#[unsafe(no_mangle)]
pub fn collect_from_vec(src: &Vec<usize>) -> Vec<usize> {
    src.iter().cloned().collect()
}
```

使用 `-O -Ccodegen-units=1 --crate-type=lib --emit=asm,llvm-ir` 编译，两个目标均得到相同的区别：切片参数版本生成 `llvm.memcpy`，Vec 参数版本保留重叠检查和向量循环。切片参数的 LLVM IR 直接携带数据指针的 `noalias readonly` 属性；Vec 参数的属性作用于 Vec 结构体，数据指针由字段加载取得。这个对照说明生成结果受传入数据指针的形式及其别名信息影响。准确发生在哪个优化阶段仍需进一步定位。

```llvm
; collect_from_slice 的关键部分，省略参数和元数据
define void @collect_from_slice(ptr %out, ptr noalias readonly %src, i64 %len) {
  ; 分配及错误处理省略
  call void @llvm.memcpy.p0.p0.i64(ptr %dst, ptr %src, i64 %bytes, i1 false)
  ; 返回 Vec 省略
}

; collect_from_vec 的向量循环，省略入口检查和元数据
vector.body:
  %index = phi i64 [ 0, %vector.ph ], [ %next, %vector.body ]
  %sp = getelementptr i64, ptr %src_data, i64 %index
  %sp2 = getelementptr i8, ptr %sp, i64 16
  %v0 = load <2 x i64>, ptr %sp, align 8
  %v1 = load <2 x i64>, ptr %sp2, align 8
  %dp = getelementptr i64, ptr %dst, i64 %index
  %dp2 = getelementptr i8, ptr %dp, i64 16
  store <2 x i64> %v0, ptr %dp, align 8
  store <2 x i64> %v1, ptr %dp2, align 8
  %next = add nuw i64 %index, 4
  %done = icmp eq i64 %next, %n_vec
  br i1 %done, label %exit, label %vector.body
```

以上为便于对照而删节的 IR，完整可编译例子和真实 IR 在证据目录。这个现象同时存在于 ARM 和 x86，不能单独解释两端全部差距。

### 原因：ARM 运行环境的分配释放路径更长

原 benchmark 每次迭代都分配并释放一个 Vec。ARM 热点包含 `_int_free` 和 `cfree`；x86 热点包含 `malloc` 和 `cfree`。ARM 采样数为 595，x86 约 7000，热点比例用于定位函数，不用于精确分摊耗时。

实际 libc 汇编显示，ARM 的 `__libc_free` 先建立栈帧、读取并保存 errno、检查块标记、取得 arena，再调用 `_int_free`，最后恢复 errno 和寄存器。x86 的小块线程缓存命中路径直接在 `__libc_free` 内更新缓存并返回。glibc 在这两个版本之间合入了缩短 free 缓存路径的改动，具体见 [避免 free 缓存快路径中的函数调用](https://sourceware.org/pipermail/glibc-cvs/2024q4/086689.html) 和 [内联 _int_free](https://sourceware.org/pipermail/glibc-cvs/2025q2/088019.html)。本机汇编与这一区别一致。

分项最小例子如下，实际驱动对输入大小、指针和函数指针使用 black_box，防止删除操作：

```text
分配释放：重复 malloc(800) → black_box(pointer) → free(pointer)
复制：    提前分配并初始化两块缓冲区 → 重复 memcpy(dst, src, 800)
完整对照：重复 malloc(800) → memcpy(dst, src, 800) → free(dst)
```

| 分项对照，800 字节 | ARM ns / cycles | x86 ns / cycles |
|---|---:|---:|
| malloc + free，默认缓存 | 10.97 / 31.79 | 5.47 / 24.76 |
| malloc + free，关闭线程缓存 | 26.23 / 75.93 | 19.64 / 88.35 |
| 仅 libc memcpy，默认缓存 | 16.52 / 47.76 | 6.25 / 28.35 |
| malloc + memcpy + free，默认缓存 | 27.61 / 79.95 | 10.73 / 48.51 |

关闭缓存使用单个进程环境变量 `GLIBC_TUNABLES=glibc.malloc.tcache_count=0`，两端均明显变慢。默认缓存下 ARM 分配释放的周期数较高；关闭缓存后周期数关系发生变化，说明分配器路径会影响结论。这些分项有独立的调用和 black_box 开销，不能相加后直接扣减原 benchmark 的耗时。原 benchmark 也没有调用 libc memcpy，复制分项只用于比较已有批量复制路径。

尚未在同一机器替换并对照相同构建配置的 libc，因此不能给出升级 libc 对该 benchmark 的收益百分比。分配和 memcpy 的剩余周期差距也尚未分解到具体微架构资源。

### 原因：ARM 的运行频率较低，同样周期需要更长时间

为避免用整场 libtest 的初始化和校准开销推算单次周期，另外使用保持原查询函数体的固定次数驱动，执行 500 万次。

| 每次操作，中位数 | ARM | x86 |
|---|---:|---:|
| cycles | 89.78 | 82.68 |
| instructions | 339.23 | 300.61 |
| branches | 69.05 | 55.12 |
| branch-misses | 0.0061 | 0.0045 |
| cycles/task-clock | 2.88 GHz | 4.42 GHz |

这组驱动中，ARM 每次操作多用约 8.6% 的周期，x86 的运行频率约高 53%。因此纳秒差距同时包含周期成本和频率因素。分支预测失败次数很少，没有证据支持将该项主要归因于 branch-miss。固定次数驱动与 libtest 的内联和循环上下文不同，表中的周期数只比较同一驱动，不能与前述 libtest 纳秒数据交叉换算。

### 修改方法及适用范围

| 原因 | 方法 | 修改示例或选项 | 双平台结果及限制 |
|---|---|---|---|
| 切片克隆收集保留循环 | 在对应收集接口中为满足平凡克隆条件的切片迭代器增加批量复制路径；或定位 LLVM 未识别复制的阶段 | 目标处理形态：`reserve(len) → copy_nonoverlapping(src, dst, len) → set_len(len)` | 仅列为待验证方向。本次没有实现接口修改；不能把调用方改成 `to_vec()` 的结果计为接口收益 |
| 循环控制成本 | 增大 LLVM 向量交错因子，一轮处理更多元素 | `-Cllvm-args=-force-vector-interleave=4` 或 `=8` | ARM 各长度有退化；x86 的 100、1000 元素测试改善。当前证据不支持全局启用 |
| 分配释放路径较长 | 在同一机器对照不同 libc 或分配器，验证缩短缓存路径的效果 | 诊断对照：单进程关闭 tcache | 已确认分配器配置会改变成本；没有完成分配器替换收益验证 |
| 频率较低 | 减少所需周期；用纳秒和周期分别评估 | 同一接口进行固定次数与 libtest 两类对照 | 无已验证的源码修改 |

批量复制特化必须保留自定义 Clone 的行为、零大小类型、分配失败和析构语义；不能将一般 `T: Copy` 或 `T: Clone` 都直接按字节复制并跳过 Clone。当前源码已有的 `TrivialClone` 约束与普通 Clone 不同，`Cloned` 内部迭代器字段的访问也需要对应的内部接口。这些正确性和接口设计尚未验证。

原有批量复制接口提供了实际性能对照：

| 原 benchmark，100 个 usize | ARM ns | x86 ns |
|---|---:|---:|
| `bench_from_iter_0100` | 25.04 | 15.87 |
| `bench_from_slice_0100` | 27.19 | 12.25 |
| `bench_clone_0100` | 26.96 | 12.39 |

在 ARM 上，现有 memcpy 路径在该长度比原收集循环更慢；x86 上更快。因此将收集接口统一改为 memcpy 的收益尚不成立。

交错因子为 8 时，两端主循环均扩大到 128 字节：100 个元素从 25 轮变为 6 轮主循环，再处理剩余 4 个元素。减少循环控制同时增加尾部处理、寄存器和代码规模成本。

| 原 benchmark | ARM 原始→交错因子 8 | 变化 | x86 原始→交错因子 8 | 变化 |
|---|---:|---:|---:|---:|
| `bench_from_iter_0010` | 14.28→14.85 ns | +4.0% | 9.88→9.76 ns | -1.2% |
| `bench_from_iter_0100` | 25.04→24.71 ns | -1.3% | 15.87→13.30 ns | -16.2% |
| `bench_from_iter_1000` | 142.26→149.72 ns | +5.2% | 86.33→79.66 ns | -7.7% |

另检查了两个已有分析中常见的诊断选项。`-no-stack-coloring` 下该项 ARM 为 25.09 ns，x86 为 18.43 ns，x86 退化约 16.1%；`-aarch64-enable-ldst-opt=false` 下 ARM 为 26.27 ns，退化约 4.9%。本项没有证据支持用它们修复。选项改变编译单元内其他函数的代码生成，完整相关场景结果见证据目录的 `option-scenes.md`。

### 覆盖范围和证据

基线覆盖 24 个原 benchmark：from_iter、from_slice、clone、from_fn、from_elem、with_capacity，各含 0、10、100、1000 元素。每个编译选项覆盖 from_iter/from_slice/clone 的全部 12 项，各重复三次。完整中位数、最小值和最大值保存在 `bench-summary.csv`，所有分项和原始 perf 输出均保留。

独立复制诊断另外覆盖 10、100、1000 个 usize、8 组源目标对齐组合、三种交错因子，每组重复三次并核对复制内容和边界。ARM 的 100 元素基线在不同对齐下为 17.26–20.13 ns，交错因子 8 为 15.95–21.11 ns。x86 相应范围为 12.08–20.74 ns 和 6.75–17.12 ns。收益依赖长度和地址对齐，当前数据不能证明某个因子适用于全部输入。

测量固定 CPU，并对程序关闭 ASLR；perf 父进程也固定到同一 CPU，x86 显式使用 `cpu_core` 事件。记录缺页、上下文切换、迁移和事件运行比例；所有硬件计数的运行比例至少 99.9%。目标基线三次运行均无主缺页和 CPU 迁移。ARM 为 25.02–25.13 ns，x86 为 15.42–16.01 ns；x86 存在上下文切换和频率变化，因此小幅变化仍需结合范围判断。启动缺页包含在进程级计数中，不能推断计时循环完全没有缺页。固定 ASLR 只控制一组代码地址，尚未覆盖代码布局变化。

历史表 `base.tsv` 中该项为 ARM 30.67 ns、x86 15.00 ns，属于另一套构建。本次匹配工具链的结果单独记录，不能用本次周期数据倒推历史差距。

证据目录：[`analysis/data/vec-from-iter-0100-20261106/`](analysis/data/vec-from-iter-0100-20261106/)。其中 `arm/` 保存远程原始数据、源码快照、双目标编译结果和构建脚本，`x86/` 保存本机原始数据及实际运行文件，`README.md` 说明复现路径和依赖。没有修改原 benchmark 或标准库接口，也没有已验证的通用源码修复。
