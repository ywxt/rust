// R02:[char;3] 回寫形狀後 8 B@0 重載的轉發成本
// ./bench <split_dep|whole_dep|split_ind|whole_ind> [N]
//   split:4 B@0 + 8 B@4(x86 to_upper 的形狀)   whole:8 B@0 + 4 B@8(單筆 store 供應 8 B@0)
//   dep:載入值作下一輪 store 的值(延遲)        ind:每輪獨立(吞吐)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char **argv) {
  long n = argc > 2 ? atol(argv[2]) : 100000000;
  _Alignas(64) unsigned long buf[8] = {0};
  unsigned long *p = buf, x = 1;
  const char *m = argv[1];
#if defined(__x86_64__)
#define SPLIT(v) "movl %k" v ", (%2)\n movq $0, 4(%2)\n"
#define WHOLE(v) "movq %" v ", (%2)\n movl $0, 8(%2)\n"
#define LOOP(st) __asm__ volatile("1:" st "movq (%2), %0\n dec %1\n jnz 1b" : "+r"(x), "+r"(n) : "r"(p) : "memory")
#elif defined(__aarch64__)
#define SPLIT(v) "str %w" v ", [%2]\n stur xzr, [%2, #4]\n"
#define WHOLE(v) "str wzr, [%2, #8]\n stp %w" v ", wzr, [%2]\n"
#define LOOP(st) __asm__ volatile("1:" st "ldr %0, [%2]\n subs %1, %1, #1\n b.ne 1b" : "+r"(x), "+r"(n) : "r"(p) : "memory", "cc")
#endif
  if (!strcmp(m, "split_dep")) LOOP(SPLIT("0"));
  else if (!strcmp(m, "whole_dep")) LOOP(WHOLE("0"));
  else if (!strcmp(m, "split_ind")) LOOP(SPLIT("1"));
  else if (!strcmp(m, "whole_ind")) LOOP(WHOLE("1"));
  else return 1;
  printf("%lu\n", x);
  return 0;
}
