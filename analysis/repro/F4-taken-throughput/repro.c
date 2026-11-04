// F4:必跳分支吞吐。每輪 N 條必跳分支,每條跳到 S 字節後的下一條(.org 填充,不執行)。
// jmp=無條件,jcc=條件恆成立;報告 cycles/taken(含迴圈回跳那條)。
#include <linux/perf_event.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>
static int fd[3];
static void pinit(void) { // cycles/instructions/branch-misses,x86 混合架構走 cpu_core PMU
  unsigned long long t = 0, c[3] = {PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, PERF_COUNT_HW_BRANCH_MISSES};
  FILE *f = fopen("/sys/bus/event_source/devices/cpu_core/type", "r");
  if (f) { if (fscanf(f, "%llu", &t) != 1) t = 0; fclose(f); }
  for (int i = 0; i < 3; i++) {
    struct perf_event_attr a = {.size = sizeof a, .type = PERF_TYPE_HARDWARE, .config = c[i] | t << 32, .exclude_kernel = 1, .exclude_hv = 1};
    if ((fd[i] = syscall(SYS_perf_event_open, &a, 0, -1, -1, 0)) < 0) { perror("perf_event_open"); exit(1); }
  }
}
static void rd(long long v[3]) { for (int i = 0; i < 3; i++) if (read(fd[i], &v[i], 8) != 8) exit(1); }

#if defined(__x86_64__)
#define JMP " jmp 1f\n"
#define JCC " test %[o], %[o]\n jnz 1f\n"
#define LOOP " dec %[n]\n jnz 2b"
#else
#define JMP " b 1f\n"
#define JCC " cbnz %[o], 1f\n"
#define LOOP " subs %[n], %[n], 1\n b.ne 2b"
#endif
#define TK(kind, N, S) static void kind##_##N##_##S(long n) { __asm__ volatile( \
  ".balign 64\n2: .rept " #N "\n0:\n" kind " .org 0b + " #S "\n1:\n .endr\n" LOOP : [n] "+r"(n) : [o] "r"(1L) : "cc"); }
#define V(N, S) TK(JMP, N, S) TK(JCC, N, S)
V(32, 8) V(32, 16) V(32, 64) V(128, 16) V(512, 8) V(512, 16) V(512, 64)
#define E(N, S) {"jmp", N, S, JMP##_##N##_##S}, {"jcc", N, S, JCC##_##N##_##S},
static const struct { const char *k; int n, s; void (*f)(long); } t[] = {E(32, 8) E(32, 16) E(32, 64) E(128, 16) E(512, 8) E(512, 16) E(512, 64)};

int main(void) {
  pinit();
  for (unsigned j = 0; j < sizeof t / sizeof *t; j++) {
    long n = 20000000 / t[j].n;
    long long best[3] = {1LL << 62};
    for (int r = 0; r < 5; r++) {
      long long a[3], b[3];
      rd(a); t[j].f(n); rd(b);
      if (b[0] - a[0] < best[0]) for (int i = 0; i < 3; i++) best[i] = b[i] - a[i];
    }
    double u = (double)n * (t[j].n + 1);
    printf("%s N %3d S %2d cyc/taken %.3f miss/taken %.4f\n", t[j].k, t[j].n, t[j].s, best[0] / u, best[2] / u);
  }
  return 0;
}
