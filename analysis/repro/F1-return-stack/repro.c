// F1:返回棧容量。D 層呼叫鏈,每層返回位址都不同(.rept 產生 64 個相鄰函數 f_i 呼叫 f_i+1)。
// 鏈深超過返回棧後每次多出的 ret 誤預測;miss/鏈 從 0 開始上升的 D 即容量。
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

// 每個 S 字節塊是一個函數:呼叫下一塊後返回;最後一塊直接 ret
// S=16 緊湊;S=4160 每幀不同頁、不同 I-cache 組(模擬跨 so 的分散代碼)
#if defined(__x86_64__)
#define BODY " call 1f\n ret\n"
#else
#define BODY " stp x29, x30, [sp, -16]!\n bl 1f\n ldp x29, x30, [sp], 16\n ret\n"
#endif
#define CHAIN(name, S) __asm__(".text\n .balign 64\n" #name ":\n .rept 64\n0:\n" BODY " .org 0b + " #S "\n1:\n .endr\n ret\n");
CHAIN(near, 16)
CHAIN(far, 4160)
extern char near[], far[];

int main(int argc, char **argv) {
  const long n = 1000000;
  pinit();
  int far_ = argc > 1 && argv[1][0] == 'f'; // 第一個參數 near|far,其餘為深度
  for (int d = 2; d < argc; d++) {
    int depth = atoi(argv[d]); // 呼叫 depth 次 call(含進入鏈的那次)
    void (*f)(void) = (void (*)(void))(far_ ? far + 4160 * (65 - depth) : near + 16 * (65 - depth));
    long long best[3] = {1LL << 62};
    for (int r = 0; r < 5; r++) {
      long long a[3], b[3];
      rd(a); for (long k = 0; k < n; k++) { f(); __asm__ volatile("" ::: "memory"); } rd(b);
      if (b[0] - a[0] < best[0]) for (int i = 0; i < 3; i++) best[i] = b[i] - a[i];
    }
    printf("%s depth %2d cyc/chain %6.1f miss/chain %5.2f\n", argv[1], depth, best[0] / (double)n, best[2] / (double)n);
  }
  return 0;
}
