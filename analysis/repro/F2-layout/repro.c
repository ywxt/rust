// F2:同一迴圈只改起始位址(相對 64B 邊界偏移 P 字節,前置 nop),量 cycles/元素的離散度。
// a:s += x[i]; u += i(c48 式整數迴圈,兩條獨立累加鏈,前端/發射受限);b:同上再加一條從不跳的條件分支。
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
#define PAD(P) ".balign 64\n .rept " #P "\n nop\n .endr\n"
#define BODY_A "1: add (%[p],%[i],8), %[s]\n add %[i], %[u]\n inc %[i]\n cmp %[n], %[i]\n jne 1b"
#define BODY_B "1: mov (%[p],%[i],8), %[x]\n test %[x], %[x]\n js 2f\n add %[x], %[s]\n add %[i], %[u]\n2: inc %[i]\n cmp %[n], %[i]\n jne 1b"
#else
#define PAD(P) ".balign 64\n .rept " #P "/4\n nop\n .endr\n"
#define BODY_A "1: ldr %[x], [%[p], %[i], lsl 3]\n add %[s], %[s], %[x]\n add %[u], %[u], %[i]\n add %[i], %[i], 1\n cmp %[i], %[n]\n b.ne 1b"
#define BODY_B "1: ldr %[x], [%[p], %[i], lsl 3]\n tbnz %[x], 63, 2f\n add %[s], %[s], %[x]\n add %[u], %[u], %[i]\n2: add %[i], %[i], 1\n cmp %[i], %[n]\n b.ne 1b"
#endif
#define L(K, P) static long K##P(const long *p, long n) { long i = 0, s = 0, u = 0, x; __asm__ volatile( \
  PAD(P) BODY_##K : [i] "+r"(i), [s] "+r"(s), [u] "+r"(u), [x] "=&r"(x) : [p] "r"(p), [n] "r"(n) : "cc", "memory"); return s + u; }
#define LL(P) L(A, P) L(B, P)
LL(0) LL(4) LL(8) LL(12) LL(16) LL(20) LL(24) LL(28) LL(32) LL(36) LL(40) LL(44) LL(48) LL(52) LL(56) LL(60)
#define E(P) {P, A##P, B##P},
static const struct { int p; long (*a)(const long *, long), (*b)(const long *, long); } t[] = {
  E(0) E(4) E(8) E(12) E(16) E(20) E(24) E(28) E(32) E(36) E(40) E(44) E(48) E(52) E(56) E(60)};

int main(void) {
  const long n = 4096, reps = 2000;
  long *v = malloc(n * sizeof *v);
  for (long i = 0; i < n; i++) v[i] = i;
  pinit();
  for (int k = 0; k < 2; k++)
    for (unsigned j = 0; j < sizeof t / sizeof *t; j++) {
      long (*f)(const long *, long) = k ? t[j].b : t[j].a;
      long long best[3] = {1LL << 62}; volatile long sink;
      for (int r = 0; r < 5; r++) {
        long long a[3], b[3];
        rd(a); for (long q = 0; q < reps; q++) sink = f(v, n); rd(b);
        if (b[0] - a[0] < best[0]) for (int i = 0; i < 3; i++) best[i] = b[i] - a[i];
      }
      printf("%c P %2d cyc/elem %.3f\n", 'a' + k, t[j].p, best[0] / (double)(n * reps));
    }
  return 0;
}
