// R05:x86 store 提交寬度與 cache line 的關係;collect_droppable 熱迴圈的 store 形態
// ./repro <line1|line2|mix|same|drop> [N](迴圈皆 64 B 對齊,避開前端對齊干擾)
//   line1:每輪 2 個 store 寫同一條 line(+0、+8)       line2:每輪 2 個 store 寫兩條 line(+0、+64)
//   mix  :bench 第一個熱迴圈:載入 src[i],寫棧槽 A、B(同一 line)與 dst[i](另一 line)
//   same :同 mix,只把 dst[i] 改寫成棧槽 C(3 個 store 同一 line)
//   drop :bench 第二個熱迴圈(Drop 內 black_box):每輪 1 個 store 寫同一棧槽
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static _Alignas(64) unsigned long src[1024], dst[1024];
int main(int argc, char **argv) {
  long n = argc > 2 ? atol(argv[2]) : 100000000;
  _Alignas(64) unsigned long slot[16];
  unsigned long *s = slot, *a = src, *d = dst, i = 0, j, t = 0;
  const char *m = argv[1];
#if defined(__x86_64__)
// %0=n %1=i %2=j(i&1023) %3=t %4=src %5=棧槽 %6=dst
#define BODY(st3) __asm__ volatile(".p2align 6\n1: mov %1, %2\n and $1023, %2\n mov (%4,%2,8), %3\n mov %3, (%5)\n xor %1, %3\n mov %1, 8(%5)\n" st3 \
                  " inc %1\n dec %0\n jnz 1b" : "+r"(n), "+r"(i), "=&r"(j), "+r"(t) : "r"(a), "r"(s), "r"(d) : "memory")
#define TWO(off) __asm__ volatile(".p2align 6\n1: mov %1, (%2)\n mov %1, " off "(%2)\n inc %1\n dec %0\n jnz 1b" : "+r"(n), "+r"(i) : "r"(s) : "memory")
  if (!strcmp(m, "mix")) BODY("mov %3, (%6,%2,8)\n");
  else if (!strcmp(m, "same")) BODY("mov %3, 16(%5)\n");
  else if (!strcmp(m, "line1")) TWO("8");
  else if (!strcmp(m, "line2")) TWO("64");
  else if (!strcmp(m, "drop"))
    __asm__ volatile(".p2align 6\n1: mov %1, (%2)\n add $8, %1\n dec %0\n jnz 1b" : "+r"(n), "+r"(i) : "r"(s) : "memory");
#elif defined(__aarch64__)
#define BODY(st3) __asm__ volatile(".p2align 6\n1: and %2, %1, #1023\n ldr %3, [%4, %2, lsl #3]\n str %3, [%5]\n eor %3, %3, %1\n str %1, [%5, #8]\n" st3 \
                  " add %1, %1, #1\n subs %0, %0, #1\n b.ne 1b" : "+r"(n), "+r"(i), "=&r"(j), "+r"(t) : "r"(a), "r"(s), "r"(d) : "memory", "cc")
#define TWO(off) __asm__ volatile(".p2align 6\n1: str %1, [%2]\n str %1, [%2, #" off "]\n add %1, %1, #1\n subs %0, %0, #1\n b.ne 1b" : "+r"(n), "+r"(i) : "r"(s) : "memory", "cc")
  if (!strcmp(m, "mix")) BODY("str %3, [%6, %2, lsl #3]\n");
  else if (!strcmp(m, "same")) BODY("str %3, [%5, #16]\n");
  else if (!strcmp(m, "line1")) TWO("8");
  else if (!strcmp(m, "line2")) TWO("64");
  else if (!strcmp(m, "drop"))
    __asm__ volatile(".p2align 6\n1: str %1, [%2]\n add %1, %1, #8\n subs %0, %0, #1\n b.ne 1b" : "+r"(n), "+r"(i) : "r"(s) : "memory", "cc");
#endif
  else return 1;
  printf("%lu %lu %lu\n", t, j, dst[5]);
  return 0;
}
