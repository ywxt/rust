; R01:兩筆相鄰 8 B store 之後以 16 B 整塊讀回(Vec{cap=0,ptr=8} 複製到 black_box 槽)
; x86 寫成兩條 movq 再 movups 讀 → store 轉發失敗;aarch64 合成一條 stp,ldr q 可轉發。
; @g 只為讓槽逃逸、函數非葉(x86 才把目的槽對齊到 16 並選 16 B 搬移);真實 0/0 路徑兩者之間無呼叫。
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s -o - | FileCheck %s --check-prefix=X86
; RUN: llc -O3 -mtriple=aarch64-linux-gnu %s -o - | FileCheck %s --check-prefix=A64
; 開關:標記 16 B 非對齊存取為慢,x86 改用兩次 8 B 載入,窄寫窄讀可轉發。
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -mcpu=x86-64 -mattr=+slow-unaligned-mem-16 %s -o - | FileCheck %s --check-prefix=SLOW

define void @f() "frame-pointer"="all" {
  %v = alloca [16 x i8], align 8
  %d = alloca [16 x i8], align 8
  store i64 0, ptr %v, align 8
  %p = getelementptr inbounds i8, ptr %v, i64 8
  store i64 8, ptr %p, align 8
  call void @g(ptr %v)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %d, ptr align 8 %v, i64 16, i1 false)
  call void @g(ptr %d)
  ret void
}
declare void @g(ptr)

; X86-LABEL: f:
; X86:       movq $0, [[A:-[0-9]+]](%rbp)
; X86-NEXT:  movq $8, -8(%rbp)
; X86:       callq g
; X86-NEXT:  movups [[A]](%rbp), %xmm0
; X86-NEXT:  movaps %xmm0, {{.*}}(%rbp)

; A64-LABEL: f:
; A64:       stp xzr, x{{[0-9]+}}, [[[A:sp, #[0-9]+]]]
; A64-NEXT:  bl g
; A64-NEXT:  ldr q0, [[[A]]]

; SLOW-LABEL: f:
; SLOW:      movq $0, -16(%rbp)
; SLOW-NEXT: movq $8, -8(%rbp)
; SLOW:      callq g
; SLOW-NEXT: movq -16(%rbp), %r
; SLOW-NEXT: movq -8(%rbp), %r
; SLOW-NOT:  movups
