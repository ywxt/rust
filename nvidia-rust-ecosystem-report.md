# NVIDIA 与 Rust 生态动向报告

生成日期：2026-09-15

## 一、官方社区层面：白金会员与 RustConf

**成为 Rust 基金会白金会员**（2026年9月9日）

Rust Foundation 在 RustConf 2026 开幕致辞中宣布，NVIDIA 与 Solana Foundation 同时成为白金会员——这是基金会最高等级会员：

- 年度资金承诺 **32.5万美元**
- 附带 **董事会席位**
- 执行董事 Rebecca Rumbul 表示，这标志着 Rust 在 GPU 加速工作负载（现代 AI 基础设施核心）中扮演着日益重要的角色

**RustConf 2026 会议露出**

- NVIDIA 研究科学家 Melih Elibol 发表主题演讲《Fearless Concurrency on the GPU》，详细介绍 cuTile Rust 的设计与路线图
- 该演讲基于同名论文（与 Jared Roesch、Isaac Gelado、Eric Buehler[Hugging Face]、Michael Garland 合著），核心贡献是将 Rust 所有权规则延伸到基于 tile 的 GPU 内核，在 B200 GPU 上实现 GEMM 达 cuBLAS 96% 性能
- NVIDIA 有多名员工到场，是其首次在 Rust 官方旗舰大会上有明显的技术布道存在

目前**没有证据**显示 NVIDIA 员工已进入 rust-lang 官方 Core Team / Lang Team / Compiler Team 等决策团队。

### cuTile Rust 的设计与路线图

**核心定位**：基于 tile（分块）的安全、地道（idiomatic）GPU 内核编写系统，是《Fearless Concurrency on the GPU》论文的实现成果，也是 cutile-rs 库的技术基础。

**编程模型**
- Tile 是不可变、固定大小的数组类值：从内存中的张量（tensor）加载数据产生一个 tile；对 tile 的操作产生新的 tile；写回（store）操作针对内存中的可变子张量
- 内核 = 一组 tile 程序的网格（grid），每个 tile 程序被建模为对数据 tile 进行操作的单一逻辑执行线程
- 多输出场景下，cuTile Rust 提供"带标记的分区索引"（branded partition indices）和有界维度迭代器，让前端能够证明常见的分区访问是有界且互不相交的

**所有权与安全设计（核心创新）**
- 把 Rust 的所有权规则跨越 GPU launch 边界延伸：可变张量在 launch 前被划分为互不相交的若干块，不可变张量被共享，生成的 launcher 在 GPU 任务执行期间保持所有权
- 每个 tile 程序获得对自己内存的独占 `&mut` 视图，加上作为共享引用的输入
- `#[cutile::module]` 宏是实现核心：把函数转换为 GPU 内核，同时生成 host 端 launcher；host 代码构造惰性的张量操作，把可变输出分块，调用 `.sync()` 才真正 JIT 编译并执行
- 编译期由 Rust 借用检查器本身强制检查：把 kernel 的输出 buffer 又作为自己的输入传入会触发 `E0502`（cannot borrow as mutable because it is also borrowed as immutable），Tile 侧对应的别名问题则触发 `E0382`（use of moved value）
- 与此前 GPU-Rust 尝试的根本区别：以往方案把要编译的内核当作 unsafe 代码处理，而 cuTile Rust 让 host 和 device 两端代码都能享受 Rust 的所有权保证

**Host 端执行模型（可组合）**
- 生成的 launcher 接管所有张量的所有权，GPU 计算完成后再归还；调用链中的所有操作只是记录下来，直到调用 `.sync_on(&stream)` 才真正触发编译执行
- 涵盖三种执行方式：同步 launch、异步流水线（asynchronous pipelines）、CUDA graph 重放（replay）
- 效果：给 Rust 程序员提供所有权检查过的张量句柄、异步内核启动，以及一套防止设备指针逃逸出其生命周期的 host API

**性能数据（NVIDIA B200 GPU）**
- 逐元素运算：7 TB/s；GEMM：2 PFlop/s（cuBLAS 性能的 96%），与 cuTile Python 持平
- 安全性几乎不带来可测量的运行时开销：安全 Rust 持久化 GEMM 在 M=N=K=8192 时达到 2.07 PFlop/s（B200 密集 f16 峰值的 92%），与底层 Tile IR 版本相差仅 0.3%

**实际验证：Grout 推理引擎**
与 Hugging Face 合作构建的 Grout（基于 cuTile Rust 的 Qwen3 推理引擎）：Qwen3-4B 在 RTX 5090 上 batch-1 解码达 171 tokens/s，Qwen3-32B 在 B200 上达 82 tokens/s。

**路线图与近期进展**
- v0.2.0 已发布：新增 CUDA 13.3 低精度支持（NVFP4 打包/解包、块缩放矩阵乘法），新增 `cutile-kernels`（可复用推理算子库）
- 硬件/环境要求：compute capability 8.0+、CUDA 13.3、stable Rust 1.89+（无需 nightly、无需自定义 LLVM）、Linux
- 作为 NVIDIA "CUDA Rust" 整体计划的一部分，与偏底层的 cuda-oxide（SIMT 路线）并行发展，NVIDIA 计划持续打磨两条路线直到 2027 年及以后

---

## 二、NVIDIA 自己的 Rust 生态

NVIDIA 正在把 Rust 贯穿其软件栈的多个层次：

| 层次 | 项目 | 状态 |
|---|---|---|
| GPU 内核编程（SIMT） | **cuda-oxide** | alpha，nightly Rust，自定义 rustc codegen backend，MIR→LLVM→PTX |
| GPU 内核编程（Tile） | **cutile-rs** | 早期但更成熟，stable Rust 1.89+，已被 HuggingFace Grout、mistral.rs 采用 |
| Linux 内核驱动 | **Nova**（nova-core + DRM 层） | 逐步推进，目标取代 Nouveau 成为主线驱动 |
| AI 推理系统 | **Dynamo** | 核心用 Rust 编写 |
| 性能分析工具 | **NVTX** | 提供 Rust 绑定 |

### cuda-oxide vs cutile-rs 对比

- **cuda-oxide（SIMT 模型）**：沿用传统 CUDA C++ 思路，写单个线程逻辑再启动大量线程并行；需手动管理线程索引、共享内存、warp 操作；要求 nightly Rust、Linux、CUDA 12.x+；优点是精细控制，适合手动优化内存/线程分配的场景。
- **cutile-rs（Tile 模型）**：源自 CUDA 13.1 引入的 Tile 编程范式，以数组子集（tile）为编程单位，编译器自动负责线程映射与硬件调度（含 Tensor Core、TMA 等）；运行于 stable Rust 1.89+，`cargo add cutile` 即可安装。
- **官方建议**：优先尝试 Tile，只在确实需要控制线程/内存/架构细节时才降级到 SIMT。
- **安全机制差异**：cuda-oxide 的所有权检查作用于每次 kernel launch 调用；cutile-rs 的所有权追踪跨越 launch 边界，随张量本身流动。

### 与社区既有项目的关系

NVIDIA 明确承认自己是在既有社区成果基础上推进，而非另起炉灶：

- 致谢 rust-cuda、rust-gpu、cudarc 等社区先驱项目
- 特别点名 **VectorWare**——由 rust-gpu/rust-cuda 原维护者（含 Christian "LegNeato" Legnitto）创立的初创公司，专注 GPU-native 软件栈
- cuda-oxide 的 GitHub README 专门有生态定位说明，阐述与 Rust-GPU、CubeCL 等项目的关系

### 人才招募

NVIDIA 目前公开招聘多个 Rust 岗位，包括专门的 **Senior Software Engineer, CUDA Rust Core Libraries**（负责设计 CUDA Core Libraries 的安全 Rust API），以及偏基础设施方向的 Senior Systems Software Engineer（Rust/Go/C++）。

---

## 三、上游社区中与 NVIDIA 相关的特性（GitHub / Zulip 深挖）

### 3.1 `nvptx64-nvidia-cuda` 编译目标

这是 rustc 原生支持的 NVIDIA GPU 编译目标，相关议题活跃度较高：

- **#38788**（ptx-kernel ABI 追踪议题）：这是让 `nvptx64-nvidia-cuda` 走向 stable 的最后障碍之一。该 ABI 用于生成"内核"（global function，GPU 端入口点），区别于只能被内核/设备函数调用的普通"设备函数"
- **#135516**（NVPTX 共享内存追踪议题）：追踪对 NVPTX 设备代码访问共享内存（shared memory）两种形式的支持
- **#136480**（原子操作 bug）：记录 `nvptx64-nvidia-cuda` 上原子 fence 会报错、且原子指令生成时未带 fence，归类为 NVPTX LLVM 后端 bug
- **compiler-team#496**：提议移除已过时的 32 位 `nvptx-nvidia-cuda` target（NVIDIA 已不支持 32 位 PTX，64 位才是官方完整支持）
- **compiler-team#927**：提议将默认链接器切换为 `llvm-bitcode-linker`，因为现有默认链接器 `rust-ptx-linker` 自 2022 年起已损坏且无人维护
- **PR #150732**（作者 kulst）：将 `-Ctarget-cpu` 转为 AVR/AMDGCN/NVPTX 的 target-modifier，防止因 SM 等级不同导致的原子加载/存储错误编译
- **PR #152443**（作者 kjetilkjeka）：移除对旧架构、旧 ISA 的支持
- **2026年5月的 Rust 1.97 基线提升**：将 `nvptx64-nvidia-cuda` 的基准 PTX ISA 版本和 GPU 架构要求提高到 PTX ISA 7.0、SM 7.0，淘汰 2017 年前的老架构（不再兼容旧 GPU 和驱动），以修复多个可能导致编译器崩溃或错误编译的缺陷

从 issue/PR 参与者可以看出，GPU 相关审查已经形成一个非正式的 **"gpu-target" 通知组**（在 rustc-dev-guide 有专门页面），核心成员包括 kjetilkjeka、kulst、ZuseZ4、workingjubilee 等，并有对应 Zulip 频道 `#t-compiler` 下的相关 stream 供讨论。但**未发现**这些贡献者中有人公开确认受雇于 NVIDIA——这更像是独立贡献者/学术研究者（如 ZuseZ4 即 Manuel Drehwald）与 Rust 编译器团队协作的产物，而非 NVIDIA 官方派驻。

### 3.2 `std::offload` 特性（GPU offload）

这是 rust-lang 官方的 **2025h2 Project Goal**，目标是把"CPU 代码自动卸载到 GPU 执行"做成语言/标准库特性：

- **追踪议题 #131513**：GPU-offload 追踪议题，feature gate 为 `#![feature(gpu_offload)]`
- **进展**：host 端（CPU 侧）代码已基本就绪并部分上游化；device 端（实际 GPU 内核生成）首个 PR 已存在但尚未充分审查测试，后续 PR 将暴露更多 GPU 特性
- **与 autodiff 的关系**：`std::autodiff`（基于 Enzyme 的自动微分）已完全上游化，但因 CI 问题尚未在 nightly 发布；offload 特性设计上与 autodiff 兼容，即可对 GPU 内核做微分
- **CI 策略**：由于 CI 环境没有 GPU，GPU 二进制不会在 CI 中实际运行，但已有 PR 尝试在 CI 中启用 `std::offload` 以尽早测试二进制体积膨胀问题
- **目标后端**：`nvptx64-nvidia-cuda`（Tier 2 无 host tools，"能编译"）和 `amdgcn-amd-amdhsa`（Tier 3，"存在即可"），内核 ABI 视 target 分别 lower 到 `ptx_kernel` 或 `amdgpu_kernel`；`core::arch::nvptx` 提供约 30 个 NVIDIA 专属底层 intrinsic 的封装
- **学术论文背书**：2026年8月的论文《GPU Offload in Rust: Portable, Safe, and Fast》（Manuel S. Drehwald、Marcelo Domínguez、Kevin Sala、Alán Aspuru-Guzik、Johannes Doerfert）详细阐述了这一两遍编译流水线（host/device IR 严格分离）、`-Z offload=Device` 编译选项、以及利用 Rust 类型系统（借用/可变借用/所有权）自动推导 host-device 数据传输的设计
- **性能数据**：在 NVIDIA H100 上对比手写 CUDA，安全 Rust 内核性能区间为 **快 11% 到慢 46%**；个别测试中 Rust 版本甚至超过 CUDA 基线
- **社区争议**：Hacker News 讨论中最尖锐的质疑是——类似的 LLVM offload 方案在 C++ 生态从未真正成功，换成 Rust 为何会不同？支持者的回应是 Rust 的子结构类型系统（substructural type system）对跨 CPU/GPU 边界的代码施加了 C++ 无法做到的强约束
- **与 cuda-oxide 的关系**：社区讨论明确区分了两条技术路线——`std::offload` 是 **rust-lang 官方主导**、基于 LLVM Offload 基础设施、多厂商（NVIDIA+AMD，Intel 进行中）的路线；而 **cuda-oxide 是 NVIDIA Labs 自己的路线**，通过 Stable MIR + Pliron 中间表示直接编译到 PTX，二者目前是并行探索、尚未合并的关系
- **性能安全权衡的争论**：社区（包括一位自称 NVIDIA 工程师的用户）在 X 上指出，安全 Rust 的切片边界检查在 GPU GEMM 热循环中可能造成 2.4 倍性能损失，原因是缓冲区大小的证明存在于 host 端，不总能传播到 device IR——这是当前该方向公开讨论中一个具体的技术痛点

### 3.3 小结：上游与 NVIDIA 的关系定性

- `nvptx64-nvidia-cuda` target 的维护主要由**独立贡献者**（非确认的 NVIDIA 雇员）推动，NVIDIA 更多是作为硬件规格/驱动兼容性的"事实标准制定者"影响上游决策（如 1.97 基线提升就是配合 NVIDIA 硬件生命周期做出的调整）
- `std::offload` 是 **rust-lang 官方项目目标**，技术上覆盖 NVIDIA/AMD 两家硬件，不是 NVIDIA 独占或主导的项目，但其论文作者与 LLVM OpenMP 团队（Johannes Doerfert）有直接关联，技术路线与 NVIDIA 自家的 cuda-oxide 并行而非合并
- 由于 Zulip 聊天记录不被搜索引擎索引，无法直接引用具体对话内容，以上关于 Zulip 的部分是基于 rustc-dev-guide 公开页面对"gpu-target 通知组"及其对应 stream 的说明整理而来，并非逐字聊天记录

---

## 四、白金会员的官方目的声明与配套动作

### 4.1 官方声明

**NVIDIA 自身在 Rust Foundation 官网的会员声明**：

> "NVIDIA is committed to open source and the communities that make technology more trustworthy, customizable and accessible. Our contributions include open models, datasets, training recipes, safety resources, software, standards, benchmarks and community collaborations. NVIDIA supports the Rust community as part of this broader commitment to open source software."

这段表态较为**通用/公关化**，套用 NVIDIA 对多个开源基金会的一贯话术模板，并非专门为 Rust 定制。

**更具体的动机**：据报道，NVIDIA 承诺让 Rust 开发者能够在其**整个 CUDA 平台（从 CPU 到 GPU）**上构建应用；白金会员资格是这一承诺的一部分，同时包含**投入专职工程资源与社区合作推进新项目**。

**Rust Foundation 一方**：执行董事 Dr. Rebecca Rumbul 表示，NVIDIA 的加入标志着一个重要时刻，因为 Rust 在编排现代 AI 基础设施核心的 GPU 加速工作负载中扮演着越来越重要的角色；像 NVIDIA 这种规模和地位的组织提供白金会员资格，增强了基金会投资于 Rust 语言本身、工具链、以及开发者群体的能力。

### 4.2 "CPU 到 GPU 全平台支持 Rust" 目标的配套动作核查

| CUDA 全平台环节 | 目标声明中的范围 | 当前配套动作 | 官方 vs 社区 |
|---|---|---|---|
| GPU 内核编写 | GPU | cuda-oxide、cutile-rs | NVIDIA 官方 |
| Host 端 CCCL（CUDA Core Compute Libraries）绑定 | CPU | 招聘 "Senior Software Engineer, CUDA Rust Core Libraries"，筹备官方 Rust API | NVIDIA 官方（筹备中，尚未发布） |
| Host 端 driver / cuBLAS / cuBLASLt / cuRAND / cuFFT / cuDNN / cuSPARSE / cuSOLVER / NCCL / NVRTC / CUPTI / NVTX 等库绑定 | CPU | `cudarc` crate（覆盖上述几乎全部库，分三层：sys FFI / result / safe API） | 社区维护，非 NVIDIA 官方发布，但被 cuda-oxide/cutile-rs 的 host 运行时设计为可互操作 |
| 驱动/系统层 | 系统 | Nova Linux 驱动（nova-core + DRM 层，目标取代 Nouveau） | NVIDIA 官方 |
| AI 推理框架 | 应用层 | Dynamo（Rust 核心）、Grout（基于 cuTile Rust，与 Hugging Face 合作） | NVIDIA 官方 |

**具体细节**：

- **CCCL 官方 Rust 绑定筹备中**：招聘描述写明,该职位要"为 CUDA Core Libraries 开发 Rust 体验",设计安全、地道的 Rust API 做 GPU 计算,同时与原生 C/C++ 组件紧密集成。这说明 NVIDIA 打算亲自下场做 CCCL(Thrust/CUB/libcudacxx)的官方 Rust 绑定层,而目前 NVIDIA/cccl 官方仓库本身**仍只服务 C++**,尚无官方 Rust 支持。
- **`cudarc` 是事实标准，但非官方**：搜索未发现 NVIDIA 官方发布的 CUDA/cuBLAS/cuDNN/NCCL Rust 绑定；社区维护的 `cudarc` crate 是当前 Rust GPU 计算生态事实上的标准 host 端库，版本覆盖 CUDA 11.4-13.3、cuDNN 8.9.7-9.21.1、NCCL 2.22-2.30。
- **生态互操作信号**：cuda-oxide 的 host 端运行时（`cuda-core`，与 cutile-rs 共享）被设计为与 `cudarc` 的 launch 宏兼容——cuda-oxide 产生的 PTX 是可移植的，不依赖 cuda-oxide 全栈的项目也可以直接用 `cudarc` 启动，说明 NVIDIA 有意识地对接既有社区工具而非排斥。

### 4.3 结论

"CPU 到 GPU 全平台支持 Rust"这句承诺，**GPU 内核编写、驱动层、推理框架层已有实质产品落地**；但 **CPU 侧的官方核心库（CCCL）绑定目前仍处于"招聘筹备"阶段，尚未正式发布**，这块空白目前仍由社区的 `cudarc` 顶着。整体来看，NVIDIA 的白金会员声明与实际动作基本吻合，但"全平台"覆盖尚未完全兑现。

---

## 参考来源

- [Rust Foundation Announces Solana Foundation and NVIDIA as Platinum Members](https://rustfoundation.org/media/rust-foundation-announces-solana-foundation-and-nvidia-as-platinum-members/)
- [Introducing CUDA Rust: Two Tracks for Writing GPU Kernels | NVIDIA Technical Blog](https://developer.nvidia.com/blog/introducing-cuda-rust-two-tracks-for-writing-gpu-kernels/)
- [NVIDIA Announces CUDA Rust with cuda-oxide (SIMT) and cutile-rs (Tile) | MarkTechPost](https://www.marktechpost.com/2026/09/08/nvidia-announces-cuda-rust-with-cuda-oxide-simt-and-cutile-rs-tile-for-compile-time-safe-gpu-kernels/)
- [Fearless Concurrency on the GPU (arXiv)](https://arxiv.org/abs/2606.15991)
- [Fearless Concurrency on the GPU: Safe GPU kernels in Rust - Rust Users Forum](https://users.rust-lang.org/t/fearless-concurrency-on-the-gpu-safe-gpu-kernels-in-rust/140790)
- [Announcing VectorWare](https://www.vectorware.com/blog/announcing-vectorware/)
- [VectorWare Hit Hacker News With Rust SIMD, but GPU Portability Is the Real Test](https://www.remio.ai/post/vectorware-hit-hacker-news-with-rust-simd-but-gpu-portability-is-the-real-test)
- [The New Rust-Written NVIDIA "NOVA" Driver Submitted Ahead Of Linux 6.15 - Phoronix](https://www.phoronix.com/news/NOVA-Driver-For-Linux-6.15)
- [Nova GPU Driver - Rust for Linux](https://rust-for-linux.com/nova-gpu-driver)
- [Senior Software Engineer, CUDA Rust Core Libraries — NVIDIA](https://freehire.me/jobs/senior-software-engineer-cuda-rust-core-libraries-nvidia-oumqobpy)
- [Senior Systems Software Engineer - Rust, Go, C++ | NVIDIA Corporation](https://jobs.nvidia.com/careers/job/893392890515)
- [Finish the std::offload module - Rust Project Goals](https://rust-lang.github.io/goals/2025h2/finishing-gpu-offload.html)
- [Tracking Issue for GPU-offload · Issue #131513 · rust-lang/rust](https://github.com/rust-lang/rust/issues/131513)
- [GPU Offload in Rust: Portable, Safe, and Fast (arXiv)](https://arxiv.org/abs/2608.13759)
- [Tracking issue for the "ptx-kernel" ABI · Issue #38788 · rust-lang/rust](https://github.com/rust-lang/rust/issues/38788)
- [Tracking Issue for NVPTX shared memory · Issue #135516 · rust-lang/rust](https://github.com/rust-lang/rust/issues/135516)
- [atomic fences bug · Issue #136480 · rust-lang/rust](https://github.com/rust-lang/rust/issues/136480)
- [Convert -Ctarget-cpu into a target-modifier · PR #150732 · rust-lang/rust](https://github.com/rust-lang/rust/pull/150732)
- [Raising the baseline for the nvptx64-nvidia-cuda target | Rust Blog](https://blog.rust-lang.org/2026/05/01/nvptx-baseline-update/)
- [rustc-dev-guide: gpu-target notification group](https://rustc-dev-guide.rust-lang.org/notification-groups/gpu-target.html)
- [NVIDIA CUDA Tile](https://developer.nvidia.com/cuda/tile)
- [GitHub - NVIDIA/cutile-python](https://github.com/nvidia/cutile-python)
- [GitHub - NVlabs/cutile-rs](https://github.com/nvlabs/cutile-rs)
- [96% of cuBLAS, no `unsafe`: what cuTile Rust proves - DEV Community](https://dev.to/creeta/96-of-cublas-no-unsafe-what-cutile-rust-proves-4ldp)
- [cuTile Rust v0.2.0 — NVIDIA Labs ships NVFP4 GPU support | AI/TLDR](https://ai-tldr.dev/releases/nvidia-cutile-rs-v0-2-0/)
- [The Rust + GPU Ecosystem — cuda-oxide docs](https://nvlabs.github.io/cuda-oxide/appendix/ecosystem.html)
- [cudarc - Rust (docs.rs)](https://docs.rs/cudarc/latest/cudarc/)
- [GitHub - NVIDIA/cccl: CUDA Core Compute Libraries](https://github.com/NVIDIA/cccl)
- [The Rust Foundation - Official Members Page](https://rustfoundation.org/)
