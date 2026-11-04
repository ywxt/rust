; AoS 取欄位:<8 x i32> 載入後取偶 lane。
; AArch64 的 VectorCombine 依成本把載入縮成 <7 x i32>(lane 7 未用),
; 之後 InterleavedAccess 認不出 ld2,只能 ldr q + ld1 逐 lane + lane mov。
; x86 不縮,後端一條 shufps。關掉 VectorCombine 時 AArch64 得到 ld2。
;
; RUN: opt -mtriple=aarch64-linux-gnu -passes=vector-combine -S %s | FileCheck %s --check-prefix=VC-A64
; RUN: opt -mtriple=x86_64-linux-gnu -passes=vector-combine -S %s | FileCheck %s --check-prefix=VC-X86
; RUN: opt -mtriple=aarch64-linux-gnu -passes=vector-combine %s | llc -mtriple=aarch64-linux-gnu -O3 | FileCheck %s --check-prefix=A64
; RUN: opt -mtriple=x86_64-linux-gnu -passes=vector-combine %s | llc -mtriple=x86_64-linux-gnu -O3 | FileCheck %s --check-prefix=X86
; 開關:-disable-vector-combine
; RUN: opt -mtriple=aarch64-linux-gnu -passes=vector-combine -disable-vector-combine %s | llc -mtriple=aarch64-linux-gnu -O3 | FileCheck %s --check-prefix=A64-NOVC

; VC-A64: load <7 x i32>
; VC-X86: load <8 x i32>

; A64-LABEL: f:
; A64:       ldr q0, [x0]
; A64:       mov v0.s[1], v0.s[2]
; A64:       ld1 { v0.s }[2]
; A64:       ld1 { v0.s }[3]
; A64-NOT:   ld2
; A64:       str q0, [x1]

; X86-LABEL: f:
; X86:       movups (%rdi), %xmm0
; X86-NEXT:  movups 16(%rdi), %xmm1
; X86-NEXT:  shufps $136, %xmm1, %xmm0
; X86-NEXT:  movups %xmm0, (%rsi)

; A64-NOVC-LABEL: f:
; A64-NOVC:       ld2 { v0.4s, v1.4s }, [x0]
; A64-NOVC-NEXT:  str q0, [x1]

define void @f(ptr %s, ptr %d) {
  %w = load <8 x i32>, ptr %s, align 4
  %v = shufflevector <8 x i32> %w, <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  store <4 x i32> %v, ptr %d, align 4
  ret void
}
