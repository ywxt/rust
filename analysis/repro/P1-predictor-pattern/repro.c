// P1:預測器記憶長度 × 每輪必跳分支數 T。
// pat L T:長 L 的隨機位元序列循環播放,每元素 1 條依資料分支 + T 條必跳分支;報告 miss/元素(背不住約 0.5)。
// loop R T:內層固定 R 次,每輪 T 條必跳分支;報告 miss/出口(背不住約 1)。
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
#define FILL(T) ".rept " #T "\n test %[o], %[o]\n jnz 3f\n3:\n .endr\n"
#define PAT(T) static void pat##T(const unsigned char *p, long m, long n) { long i = 0, b, s = 0; __asm__ volatile( \
  "1: movzbl (%[p],%[i]), %k[b]\n test %k[b], %k[b]\n jz 2f\n inc %[s]\n2: " FILL(T) " inc %[i]\n and %[m], %[i]\n dec %[n]\n jnz 1b" \
  : [i] "+r"(i), [b] "=&r"(b), [s] "+r"(s), [n] "+r"(n) : [p] "r"(p), [m] "r"(m), [o] "r"(1L) : "cc", "memory"); }
#define LP(T) static void lp##T(long r, long n) { long t; __asm__ volatile( \
  "4: mov %[r], %[t]\n5: " FILL(T) " dec %[t]\n jnz 5b\n dec %[n]\n jnz 4b" : [n] "+r"(n), [t] "=&r"(t) : [r] "r"(r), [o] "r"(1L) : "cc"); }
#else
#define FILL(T) ".rept " #T "\n cbnz %[o], 3f\n3:\n .endr\n"
#define PAT(T) static void pat##T(const unsigned char *p, long m, long n) { long i = 0, b, s = 0; __asm__ volatile( \
  "1: ldrb %w[b], [%[p], %[i]]\n cbz %w[b], 2f\n add %[s], %[s], 1\n2: " FILL(T) " add %[i], %[i], 1\n and %[i], %[i], %[m]\n subs %[n], %[n], 1\n b.ne 1b" \
  : [i] "+r"(i), [b] "=&r"(b), [s] "+r"(s), [n] "+r"(n) : [p] "r"(p), [m] "r"(m), [o] "r"(1L) : "cc", "memory"); }
#define LP(T) static void lp##T(long r, long n) { long t; __asm__ volatile( \
  "4: mov %[t], %[r]\n5: " FILL(T) " subs %[t], %[t], 1\n b.ne 5b\n subs %[n], %[n], 1\n b.ne 4b" : [n] "+r"(n), [t] "=&r"(t) : [r] "r"(r), [o] "r"(1L) : "cc"); }
#endif
#define BOTH(T) PAT(T) LP(T)
BOTH(0) BOTH(1) BOTH(2) BOTH(4) BOTH(8)
static void (*const pf[])(const unsigned char *, long, long) = {pat0, pat1, pat2, pat4, pat8};
static void (*const lf[])(long, long) = {lp0, lp1, lp2, lp4, lp8};
static const int ts[] = {0, 1, 2, 4, 8};

int main(int argc, char **argv) {
  if (argc < 3) return 2;
  int loop = argv[1][0] == 'l';
  long len = atol(argv[2]), n = 4000000, ti = 0;
  int t = argc > 3 ? atoi(argv[3]) : 0;
  while (ti < 4 && ts[ti] != t) ti++;
  unsigned char *p = malloc(len); // len 須為 2 的冪
  unsigned long long x = 0x9E3779B97F4A7C15ull;
  for (long i = 0; i < len; i++) { x ^= x << 13; x ^= x >> 7; x ^= x << 17; p[i] = x >> 33 & 1; }
  if (loop) n = 40000000 / len;
  pinit();
  if (loop) lf[ti](len, n / 4); else pf[ti](p, len - 1, n); // 預熱
  long long best[3] = {1LL << 62};
  for (int r = 0; r < 5; r++) {
    long long a[3], b[3];
    rd(a); if (loop) lf[ti](len, n); else pf[ti](p, len - 1, n); rd(b);
    if (b[0] - a[0] < best[0]) for (int i = 0; i < 3; i++) best[i] = b[i] - a[i];
  }
  printf("%s %5ld T %d miss/%s %.4f cyc/%s %.2f\n", loop ? "loop" : "pat ", len, ts[ti], loop ? "exit" : "elem",
         best[2] / (double)n, loop ? "exit" : "elem", best[0] / (double)n);
  return 0;
}
