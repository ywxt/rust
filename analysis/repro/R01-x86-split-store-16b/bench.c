// R01:兩筆 8 B store 後 16 B 載入(store 轉發失敗)對照
// ./bench <split|whole|narrow> [N]
//   split :8 B + 8 B store,16 B 載入(x86 實際生成)
//   whole :單筆 16 B store(x86 movups / aarch64 stp),16 B 載入
//   narrow:8 B + 8 B store,兩次 8 B 載入(-mattr=+slow-unaligned-mem-16 的形狀)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char **argv) {
  long n = argc > 2 ? atol(argv[2]) : 100000000;
  _Alignas(64) unsigned long buf[8] = {0};
  unsigned long *p = buf;
  const char *m = argv[1];
#if defined(__x86_64__)
  if (!strcmp(m, "split"))
    __asm__ volatile("1: movq $0, (%0)\n movq $8, 8(%0)\n movups (%0), %%xmm0\n movaps %%xmm0, 16(%0)\n dec %1\n jnz 1b"
                     : "+r"(p), "+r"(n) :: "xmm0", "memory");
  else if (!strcmp(m, "whole"))
    __asm__ volatile("pxor %%xmm1, %%xmm1\n1: movups %%xmm1, (%0)\n movups (%0), %%xmm0\n movaps %%xmm0, 16(%0)\n dec %1\n jnz 1b"
                     : "+r"(p), "+r"(n) :: "xmm0", "xmm1", "memory");
  else if (!strcmp(m, "narrow"))
    __asm__ volatile("1: movq $0, (%0)\n movq $8, 8(%0)\n movq (%0), %%rax\n movq 8(%0), %%rcx\n movq %%rcx, 24(%0)\n movq %%rax, 16(%0)\n dec %1\n jnz 1b"
                     : "+r"(p), "+r"(n) :: "rax", "rcx", "memory");
#elif defined(__aarch64__)
  if (!strcmp(m, "split"))
    __asm__ volatile("mov x8, #8\n1: str xzr, [%0]\n str x8, [%0, #8]\n ldr q0, [%0]\n str q0, [%0, #16]\n subs %1, %1, #1\n b.ne 1b"
                     : "+r"(p), "+r"(n) :: "x8", "v0", "memory", "cc");
  else if (!strcmp(m, "whole"))
    __asm__ volatile("mov x8, #8\n1: stp xzr, x8, [%0]\n ldr q0, [%0]\n str q0, [%0, #16]\n subs %1, %1, #1\n b.ne 1b"
                     : "+r"(p), "+r"(n) :: "x8", "v0", "memory", "cc");
  else if (!strcmp(m, "narrow"))
    __asm__ volatile("mov x8, #8\n1: str xzr, [%0]\n str x8, [%0, #8]\n ldp x9, x10, [%0]\n stp x9, x10, [%0, #16]\n subs %1, %1, #1\n b.ne 1b"
                     : "+r"(p), "+r"(n) :: "x8", "x9", "x10", "memory", "cc");
#endif
  else return 1;
  printf("%lu\n", buf[2]);
  return 0;
}
