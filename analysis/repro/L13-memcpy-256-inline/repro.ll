; 256 B 定長 memcpy:AArch64 內聯成 8 對 ldp/stp q;x86-64 基線(SSE2,16 B × 8 store 上限)只內聯到 128 B,256 B 呼叫 libc memcpy。
; 開關:x86 加 -mattr=+avx(32 B store)即內聯 256 B。
;
; RUN: llc -mtriple=aarch64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -mtriple=x86_64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=X86
; RUN: llc -mtriple=x86_64-linux-gnu -mattr=+avx -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=X86-AVX

; A64-LABEL: cp256:
; A64-NOT:   bl
; A64-COUNT-8: stp q
; A64:       ret
; A64-LABEL: cp128:
; A64-NOT:   bl
; A64:       ret

; X86-LABEL: cp256:
; X86:       movl $256, %edx
; X86:       memcpy
; X86-LABEL: cp128:
; X86-NOT:   memcpy
; X86:       retq

; X86-AVX-LABEL: cp256:
; X86-AVX-NOT:   memcpy
; X86-AVX-COUNT-8: vmovups %ymm
; X86-AVX:       retq

define void @cp256(ptr %d, ptr %s) {
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %d, ptr align 8 %s, i64 256, i1 false)
  ret void
}

define void @cp128(ptr %d, ptr %s) {
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %d, ptr align 8 %s, i64 128, i1 false)
  ret void
}
