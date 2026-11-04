// F3:迴圈出口預測 vs 每輪必跳分支數。內層固定 10 次,每輪 K 條必跳條件分支(跳到下一條)。
// 報告每次內層出口的失誤數;K 增大到某值後出口開始猜錯,即全域歷史裝不下 10 輪。
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
#define LX(K) static void lx##K(long n) { long t; __asm__ volatile( \
  "4: mov $10, %[t]\n3: .rept " #K "\n test %[o], %[o]\n jnz 1f\n1:\n .endr\n dec %[t]\n jnz 3b\n dec %[n]\n jnz 4b" \
  : [n] "+r"(n), [t] "=&r"(t) : [o] "r"(1L) : "cc"); }
#else
#define LX(K) static void lx##K(long n) { long t; __asm__ volatile( \
  "4: mov %[t], 10\n3: .rept " #K "\n cbnz %[o], 1f\n1:\n .endr\n subs %[t], %[t], 1\n b.ne 3b\n subs %[n], %[n], 1\n b.ne 4b" \
  : [n] "+r"(n), [t] "=&r"(t) : [o] "r"(1L) : "cc"); }
#endif
LX(0) LX(1) LX(2) LX(3) LX(4) LX(5) LX(6) LX(8) LX(12) LX(16) LX(20) LX(24) LX(32)
static const int ks[] = {0, 1, 2, 3, 4, 5, 6, 8, 12, 16, 20, 24, 32};
static void (*const fs[])(long) = {lx0, lx1, lx2, lx3, lx4, lx5, lx6, lx8, lx12, lx16, lx20, lx24, lx32};

int main(void) {
  const long n = 2000000;
  pinit();
  for (unsigned j = 0; j < sizeof ks / sizeof *ks; j++) {
    long long best[3] = {1LL << 62};
    for (int r = 0; r < 5; r++) {
      long long a[3], b[3];
      rd(a); fs[j](n); rd(b);
      if (b[0] - a[0] < best[0]) for (int i = 0; i < 3; i++) best[i] = b[i] - a[i];
    }
    printf("K %2d cyc/exit %6.1f miss/exit %5.3f\n", ks[j], best[0] / (double)n, best[2] / (double)n);
  }
  return 0;
}
