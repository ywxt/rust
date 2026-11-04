; R02:sret 回傳 [char;3] = [c,0,0](core::unicode::conversions::to_upper 的 ASCII / Latin-1 路徑)。
; @to_upper 為 aarch64 中端(SLP 把兩個 0 合成 <2 x i32>)之後的形狀,兩個 target 都餵同一份:
;   x86:movl c,(r) + movq $0,4(r),呼叫端 8 B@0 重載跨兩筆 store → 轉發失敗;
;   aarch64:str wzr,[x8,#8] + stp w,wzr,[x8],8 B@0 由單筆 stp 供應。
; @one 只有一條返回路徑:aarch64 也寫成 str w@0 + stp wzr,wzr@4,同樣跨 store(aarch64 的好形狀是偶然的)。
; @scalar 為 x86 中端的形狀(三筆 i32);SLP 只在 aarch64 把後兩筆合成向量。
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s -o - | FileCheck %s --check-prefix=X86
; RUN: llc -O3 -mtriple=aarch64-linux-gnu %s -o - | FileCheck %s --check-prefix=A64
; RUN: opt -S -passes=slp-vectorizer -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s | FileCheck %s --check-prefix=SLPX
; RUN: opt -S -passes=slp-vectorizer -mtriple=aarch64-linux-gnu %s | FileCheck %s --check-prefix=SLPA

define void @to_upper(ptr sret([12 x i8]) align 4 %r, i32 %c, i1 %b) {
  %lo = icmp ult i32 %c, 181
  br i1 %lo, label %ascii, label %next
next:
  br i1 %b, label %ff, label %slow
ascii:
  %d = add i32 %c, -97
  %l = icmp ult i32 %d, 26
  %m = and i32 %c, 95
  %u = select i1 %l, i32 %m, i32 %c
  store i32 %u, ptr %r, align 4
  %p4 = getelementptr inbounds i8, ptr %r, i64 4
  store <2 x i32> zeroinitializer, ptr %p4, align 4
  ret void
ff:
  store i32 376, ptr %r, align 4
  %q4 = getelementptr inbounds i8, ptr %r, i64 4
  store <2 x i32> zeroinitializer, ptr %q4, align 4
  ret void
slow:
  call void @lookup(ptr sret([12 x i8]) align 4 %r, i32 %c)
  ret void
}

define void @one(ptr sret([12 x i8]) align 4 %r, i32 %c) {
  store i32 %c, ptr %r, align 4
  %p4 = getelementptr inbounds i8, ptr %r, i64 4
  store <2 x i32> zeroinitializer, ptr %p4, align 4
  ret void
}

define void @scalar(ptr sret([12 x i8]) align 4 %r, i32 %c) {
  store i32 %c, ptr %r, align 4
  %p4 = getelementptr inbounds i8, ptr %r, i64 4
  store i32 0, ptr %p4, align 4
  %p8 = getelementptr inbounds i8, ptr %r, i64 8
  store i32 0, ptr %p8, align 4
  ret void
}

define void @caller(ptr %out, i32 %c) {
  %t = alloca [12 x i8], align 4
  call void @to_upper(ptr sret([12 x i8]) align 4 %t, i32 %c, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %out, ptr align 4 %t, i64 12, i1 false)
  ret void
}
declare void @lookup(ptr, i32)

; X86-LABEL: to_upper:
; X86:       movl %{{e[a-z]+}}, (%rdi)
; X86-NEXT:  movq $0, 4(%rdi)
; X86-LABEL: caller:
; X86:       leaq [[S:[0-9]+]](%rsp), %rdi
; X86:       callq to_upper
; X86:       movq [[S]](%rsp), %r

; A64-LABEL: to_upper:
; A64:       str wzr, [x8, #8]
; A64:       stp w{{[0-9]+}}, wzr, [x8]
; A64-NEXT:  ret
; A64-LABEL: one:
; A64:       stp wzr, wzr, [x8, #4]
; A64-NEXT:  str w0, [x8]
; A64-LABEL: caller:
; A64:       bl to_upper
; A64-NEXT:  ldur x{{[0-9]+}}, [sp, #4]

; SLPX-LABEL: @scalar(
; SLPX:       store i32 0, ptr %p4
; SLPX:       store i32 0, ptr %p8
; SLPA-LABEL: @scalar(
; SLPA:       store <2 x i32> zeroinitializer, ptr %p4
