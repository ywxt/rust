; iter().all(u8::is_ascii):早退 + 計數兩出口的單字節迴圈(rustc 中端在 loop-unroll 前的形態)。
; AArch64 TTI 開啟多出口 runtime unroll,展開 4×(1 個餘數 + 4 個主體 load);x86 不展開。
; 開關:AArch64 加 -unroll-runtime-multi-exit=false 不展開;x86 加 -unroll-runtime -unroll-runtime-multi-exit 展開。
;
; RUN: opt -mtriple=aarch64-linux-gnu -passes=loop-unroll -S %s | FileCheck %s --check-prefix=UNR4
; RUN: opt -mtriple=x86_64-linux-gnu -passes=loop-unroll -S %s | FileCheck %s --check-prefix=ROLLED
; RUN: opt -mtriple=aarch64-linux-gnu -passes=loop-unroll -unroll-runtime-multi-exit=false -S %s | FileCheck %s --check-prefix=ROLLED
; RUN: opt -mtriple=x86_64-linux-gnu -passes=loop-unroll -unroll-runtime -unroll-runtime-multi-exit -unroll-count=4 -S %s | FileCheck %s --check-prefix=UNR4

; UNR4-LABEL: @all_ascii(
; UNR4:       %xtraiter = and i64 %{{.*}}, 3
; UNR4-COUNT-5: load i8
; UNR4-NOT:   load i8

; ROLLED-LABEL: @all_ascii(
; ROLLED:     load i8
; ROLLED-NOT: load i8

define i1 @all_ascii(ptr %p, i64 %n) {
entry:
  %end = getelementptr inbounds nuw i8, ptr %p, i64 %n
  %empty = icmp eq i64 %n, 0
  br i1 %empty, label %exit, label %loop

loop:
  %q = phi ptr [ %p, %entry ], [ %q1, %latch ]
  %b = load i8, ptr %q, align 1
  %ok = icmp sgt i8 %b, -1
  br i1 %ok, label %latch, label %exit

latch:
  %q1 = getelementptr inbounds nuw i8, ptr %q, i64 1
  %last = icmp eq ptr %q1, %end
  br i1 %last, label %exit, label %loop

exit:
  %r = phi i1 [ true, %entry ], [ false, %loop ], [ true, %latch ]
  ret i1 %r
}
