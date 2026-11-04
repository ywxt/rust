// O1:獨立查找的重疊度與亂序窗口。
// lat:一條不重置的 L1 指標鏈,得單步 load 延遲。
// chain F:每輪重新從 p 起 16 次相依 L1 load + F 個 nop,輪與輪獨立;在途鏈數 = 16*lat/(cyc/輪)。
// rob N:兩條 DRAM 指標鏈 A、B 交錯,各後接 N 個 nop;A、B 同在窗口內時每輪約 1 次記憶體延遲,
//        N 超過 ROB 後變約 2 次(Henry Wong 法),拐點 N 即 ROB 估計。
#include <linux/perf_event.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <sys/mman.h>
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
#define LD " mov (%[r]), %[r]\n"
#define LOOP " dec %[n]\n jnz 1b"
#define RESET " mov %[p], %[r]\n"
#else
#define LD " ldr %[r], [%[r]]\n"
#define LOOP " subs %[n], %[n], 1\n b.ne 1b"
#define RESET " mov %[r], %[p]\n"
#endif
#define STR(x) #x
#define NOPS(F) ".rept " STR(F) "\n nop\n .endr\n"
static void lat(void *p, long n) { void *r = p; __asm__ volatile("1: .rept 16\n" LD " .endr\n" LOOP : [r] "+r"(r), [n] "+r"(n) :: "cc", "memory"); }
#define CH(F) static void ch##F(void *p, long n) { void *r; __asm__ volatile( \
  "1:" RESET " .rept 16\n" LD " .endr\n" NOPS(F) LOOP : [r] "=&r"(r), [n] "+r"(n) : [p] "r"(p) : "cc", "memory"); }
#if defined(__x86_64__)
#define LD2(x) " mov (%[" #x "]), %[" #x "]\n"
#else
#define LD2(x) " ldr %[" #x "], [%[" #x "]]\n"
#endif
#define RB(N) static void rb##N(void *a, void *b, long n) { __asm__ volatile( \
  "1:" LD2(a) NOPS(N) LD2(b) NOPS(N) LOOP : [a] "+r"(a), [b] "+r"(b), [n] "+r"(n) :: "cc", "memory"); }
CH(0) CH(16) CH(32) CH(64) CH(128)
RB(0) RB(32) RB(64) RB(96) RB(128) RB(160) RB(192) RB(224) RB(256) RB(320) RB(384) RB(448) RB(480) RB(512) RB(640) RB(768)
static const struct { int f; void (*c)(void *, long); } chs[] = {{0, ch0}, {16, ch16}, {32, ch32}, {64, ch64}, {128, ch128}};
static const struct { int n; void (*f)(void *, void *, long); } rbs[] = {{0, rb0}, {32, rb32}, {64, rb64}, {96, rb96}, {128, rb128},
  {160, rb160}, {192, rb192}, {224, rb224}, {256, rb256}, {320, rb320}, {384, rb384}, {448, rb448}, {480, rb480}, {512, rb512}, {640, rb640}, {768, rb768}};

static long long best[3];
#define MEAS(stmt) do { best[0] = 1LL << 62; for (int r_ = 0; r_ < 5; r_++) { long long a_[3], b_[3]; \
  rd(a_); stmt; rd(b_); if (b_[0] - a_[0] < best[0]) for (int i_ = 0; i_ < 3; i_++) best[i_] = b_[i_] - a_[i_]; } } while (0)

int main(void) {
  void *cell[8]; cell[0] = cell; // L1 自環指標
  const long nodes = 1 << 20; // 64 MB(大頁減少 TLB 噪聲),每節點一條 cache line,隨機單環(Sattolo)
  void **m = aligned_alloc(1 << 21, nodes * 64); madvise(m, nodes * 64, MADV_HUGEPAGE); long *perm = malloc(nodes * sizeof(long));
  unsigned long long x = 0x9E3779B97F4A7C15ull;
  for (long i = 0; i < nodes; i++) perm[i] = i;
  for (long i = nodes - 1; i > 0; i--) { x ^= x << 13; x ^= x >> 7; x ^= x << 17; long j = x % i, t = perm[i]; perm[i] = perm[j]; perm[j] = t; }
  for (long i = 0; i < nodes; i++) m[perm[i] * 8] = &m[perm[(i + 1) % nodes] * 8];
  pinit();
  const long n = 2000000;
  MEAS(lat(cell, n));
  double l = best[0] / (16.0 * n);
  printf("lat     cyc/load %.2f\n", l);
  for (unsigned j = 0; j < sizeof chs / sizeof *chs; j++) {
    MEAS(chs[j].c(cell, n));
    printf("chain F %3d cyc/iter %6.2f inflight %.2f\n", chs[j].f, best[0] / (double)n, 16 * l * n / best[0]);
  }
  const long k = 400000;
  for (unsigned j = 0; j < sizeof rbs / sizeof *rbs; j++) {
    MEAS(rbs[j].f(&m[perm[0] * 8], &m[perm[nodes / 2] * 8], k));
    printf("rob N %3d cyc/iter %6.1f\n", rbs[j].n, best[0] / (double)k);
  }
  return 0;
}
