// R07:短呼叫的固定成本:call/ret 往返 + 保存兩個被呼叫者保存暫存器
// ./repro <inline|call0|call2|icall0|icall2> [N];相依鏈 x = f(x),f 只做 x+1
//   inline:不呼叫(基線)  call0:直接呼叫、不保存  call2:直接呼叫、保存 2 個(x86 push r14/rbx;aarch64 stp x19,x20)
//   icall0 / icall2:經函數指標間接呼叫(harness 的 x86 為 call *GOT),不保存 / 保存 2 個
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if defined(__x86_64__)
__asm__(".text\n.p2align 6\nf0: lea 1(%rdi), %rax\n ret\n"
        ".p2align 6\nf2: push %r14\n push %rbx\n mov %rdi, %rbx\n lea 1(%rbx), %rax\n pop %rbx\n pop %r14\n ret\n");
#define CALL(fn) __asm__ volatile("1: mov %0, %%rdi\n call " fn "\n mov %%rax, %0\n dec %1\n jnz 1b" \
                 : "+r"(x), "+r"(n) :: "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11", "memory")
#define INLINE() __asm__ volatile("1: lea 1(%0), %0\n dec %1\n jnz 1b" : "+r"(x), "+r"(n))
#define ICALL(p) __asm__ volatile("1: mov %0, %%rdi\n call *%2\n mov %%rax, %0\n dec %1\n jnz 1b" \
                 : "+r"(x), "+r"(n) : "r"(p) : "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11", "memory")
#elif defined(__aarch64__)
__asm__(".text\n.p2align 6\nf0: add x0, x0, #1\n ret\n"
        ".p2align 6\nf2: stp x20, x19, [sp, #-16]!\n mov x19, x0\n add x0, x19, #1\n ldp x20, x19, [sp], #16\n ret\n");
#define CALL(fn) __asm__ volatile("1: mov x0, %0\n bl " fn "\n mov %0, x0\n subs %1, %1, #1\n b.ne 1b" \
                 : "+r"(x), "+r"(n) :: "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", \
                   "x12", "x13", "x14", "x15", "x16", "x17", "x30", "memory", "cc")
#define INLINE() __asm__ volatile("1: add %0, %0, #1\n subs %1, %1, #1\n b.ne 1b" : "+r"(x), "+r"(n) :: "cc")
#define ICALL(p) __asm__ volatile("1: mov x0, %0\n blr %2\n mov %0, x0\n subs %1, %1, #1\n b.ne 1b" \
                 : "+r"(x), "+r"(n) : "r"(p) : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", \
                   "x12", "x13", "x14", "x15", "x16", "x17", "x30", "memory", "cc")
#endif
extern char f0[], f2[];
int main(int argc, char **argv) {
  long n = argc > 2 ? atol(argv[2]) : 100000000, x = 0;
  void *volatile fp0 = f0, *volatile fp2 = f2;
  void *p0 = fp0, *p2 = fp2;
  const char *m = argv[1];
  if (!strcmp(m, "inline")) INLINE();
  else if (!strcmp(m, "call0")) CALL("f0");
  else if (!strcmp(m, "call2")) CALL("f2");
  else if (!strcmp(m, "icall0")) ICALL(p0);
  else if (!strcmp(m, "icall2")) ICALL(p2);
  else return 1;
  printf("%ld\n", x);
  return 0;
}
