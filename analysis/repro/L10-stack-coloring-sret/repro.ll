; any::bench_downcast_ref 的棧形態:1 B bool、8 B 指標、16 B sret 三個 alloca 生命期不重疊。
; IR 與 target 無關(rustc 兩 target 產生的 v0 只差 bool alloca 的 align 1/4)。
; 棧著色在兩個 target 都把三者放到同一槽:先 1 B store、再 8 B store、callee 寫 16 B,然後讀回 16 B。
; AArch64 讀回用 ldp(本機對此敏感),x86 用一條 movdqa。-no-stack-coloring 時三者各佔一槽。
;
; RUN: llc -mtriple=aarch64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -mtriple=x86_64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=X86
; RUN: llc -mtriple=aarch64-linux-gnu -O3 -asm-verbose=false -no-stack-coloring %s -o - | FileCheck %s --check-prefix=A64-NC
; RUN: llc -mtriple=x86_64-linux-gnu -O3 -asm-verbose=false -no-stack-coloring %s -o - | FileCheck %s --check-prefix=X86-NC

; A64-LABEL: f:
; A64:       strb w2, [sp]
; A64:       str x1, [sp]
; A64:       blr x9
; A64:       ldp x8, x9, [sp]

; X86-LABEL: f:
; X86:       movb %dl, (%rsp)
; X86:       movq %rsi, (%rsp)
; X86:       movq %rsp, %rdi
; X86-NEXT:  callq *%rax
; X86-NEXT:  movdqa (%rsp), %xmm0

; A64-NC-LABEL: f:
; A64-NC:       strb w2, [sp, #47]
; A64-NC:       str x1, [sp, #24]
; A64-NC:       mov x8, sp
; A64-NC:       blr x9
; A64-NC:       ldp x8, x9, [sp]

; X86-NC-LABEL: f:
; X86-NC:       movb %dl, 7(%rsp)
; X86-NC:       movq %rsi, 8(%rsp)
; X86-NC:       leaq 16(%rsp), %rdi
; X86-NC-NEXT:  callq *%rax
; X86-NC-NEXT:  movdqa 16(%rsp), %xmm0

define i1 @f(ptr %fn, ptr %arg, i8 %flag) {
  %b = alloca [1 x i8], align 1
  %p = alloca [8 x i8], align 8
  %s = alloca [16 x i8], align 16
  call void @llvm.lifetime.start.p0(ptr %b)
  store i8 %flag, ptr %b, align 1
  call void asm sideeffect "", "r,~{memory}"(ptr %b)
  call void @llvm.lifetime.end.p0(ptr %b)
  call void @llvm.lifetime.start.p0(ptr %p)
  store ptr %arg, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr %p)
  call void @llvm.lifetime.end.p0(ptr %p)
  call void @llvm.lifetime.start.p0(ptr %s)
  call void %fn(ptr sret([16 x i8]) %s, ptr %arg)
  %v = load i128, ptr %s, align 16
  call void @llvm.lifetime.end.p0(ptr %s)
  %c = icmp eq i128 %v, -133984589522889354356817377326685809265
  ret i1 %c
}
