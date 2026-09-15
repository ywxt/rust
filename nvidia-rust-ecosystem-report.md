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
