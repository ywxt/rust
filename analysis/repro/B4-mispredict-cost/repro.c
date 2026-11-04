// B4:誤預測代價。每元素一個依資料的條件分支(條件來自 L1 load)。
// rand=隨機位元,alt=0101 交替(同樣指令與跳轉比例,可預測)。代價 = Δcycles/Δmisses。
#include <linux/perf_event.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

static void loop(const unsigned char *p, long n) {
  long i = 0, b, s = 0;
#if defined(__x86_64__)
  __asm__ volatile("1: movzbl (%[p],%[i]), %k[b]\n test %k[b], %k[b]\n jz 2f\n inc %[s]\n"
                   "2: inc %[i]\n cmp %[n], %[i]\n jne 1b"
                   : [i] "+r"(i), [b] "=&r"(b), [s] "+r"(s) : [p] "r"(p), [n] "r"(n) : "cc", "memory");
#else
  __asm__ volatile("1: ldrb %w[b], [%[p], %[i]]\n cbz %w[b], 2f\n add %[s], %[s], 1\n"
                   "2: add %[i], %[i], 1\n cmp %[i], %[n]\n b.ne 1b"
                   : [i] "+r"(i), [b] "=&r"(b), [s] "+r"(s) : [p] "r"(p), [n] "r"(n) : "cc", "memory");
#endif
}

int main(int argc, char **argv) {
  const long n = 1 << 18, reps = 40; // 256 KB:預測器背不住
  unsigned char *p = malloc(n);
  unsigned long long x = 0x9E3779B97F4A7C15ull;
  for (long i = 0; i < n; i++) { x ^= x << 13; x ^= x >> 7; x ^= x << 17; p[i] = argc > 1 && !strcmp(argv[1], "rand") ? x >> 33 & 1 : i & 1; }
  pinit();
  long long best[3] = {1LL << 62};
  for (int r = 0; r < 7; r++) {
    long long a[3], b[3];
    rd(a); for (long k = 0; k < reps; k++) loop(p, n); rd(b);
    if (b[0] - a[0] < best[0]) for (int i = 0; i < 3; i++) best[i] = b[i] - a[i];
  }
  double u = (double)n * reps;
  printf("%-5s cyc/elem %.3f ins/elem %.3f miss/elem %.4f\n", argc > 1 ? argv[1] : "alt", best[0] / u, best[1] / u, best[2] / u);
  return 0;
}
