// R06:同一段逐字節掃描迴圈(EscapeAscii 的 take_while(!needs_escape).count(),
// x86 指令照抄 c30 探針反組譯)放在靜態可執行檔或 .so 中,並以 PAD 位元組平移函數起點
// 編譯:
//   靜態:cc -O2 -DPAD=n repro.c -o st
//   動態:cc -O2 -fPIC -shared -DPAD=n -DLIB repro.c -o libscan.so;cc -O2 -DUSE_LIB repro.c ./libscan.so -o dy
// 執行:./st N 或 ./dy N,每次呼叫掃描 139 B(= ASCII_PATH),印總計數
#include <stdio.h>
#include <stdlib.h>
#ifndef PAD
#define PAD 0
#endif
#define S_(x) #x
#define S(x) S_(x)
#ifndef USE_LIB
#if defined(__x86_64__)
__asm__(".text\n.p2align 6\n.skip 64+" S(PAD) ", 0xcc\n.globl scan\n.type scan,@function\nscan:\n"
        " xor %eax, %eax\n test %rsi, %rsi\n je 3f\n movabs $0x400000000000021, %rcx\n jmp 2f\n"
        "1: inc %rax\n cmp %rax, %rsi\n je 4f\n"
        "2: movzbl (%rdi,%rax,1), %edx\n lea -0x7f(%rdx), %r8d\n cmp $0xa1, %r8b\n jb 3f\n"
        " add $-0x22, %edx\n cmp $0x3a, %edx\n ja 1b\n bt %rdx, %rcx\n jae 1b\n"
        "3: ret\n4: mov %rsi, %rax\n ret\n.size scan, .-scan\n");
#elif defined(__aarch64__)
__asm__(".text\n.p2align 6\n.skip 64+" S(PAD) ", 0\n.globl scan\n.type scan,%function\nscan:\n"
        " mov x2, x0\n mov x0, #0\n cbz x1, 3f\n mov x3, #0x21\n movk x3, #0x400, lsl #48\n b 2f\n"
        "1: add x0, x0, #1\n cmp x0, x1\n b.eq 3f\n"
        "2: ldrb w4, [x2, x0]\n sub w5, w4, #0x20\n cmp w5, #0x5f\n b.hs 3f\n"
        " sub w6, w4, #0x22\n cmp w6, #0x3a\n b.hi 1b\n lsr x7, x3, x6\n tbz x7, #0, 1b\n"
        "3: ret\n.size scan, .-scan\n");
#endif
#endif
#ifndef LIB
unsigned long scan(const unsigned char *p, unsigned long n);
static const char PATH[] = "home/kyubey/rust/build/x86_64-unknown-linux-gnu/stage0/lib:/home/kyubey/workspace/rust/build/x86_64-unknown-linux-gnu/stage0-tools/release/deps";
int main(int argc, char **argv) {
  long n = argc > 1 ? atol(argv[1]) : 1000000;
  const unsigned char *volatile p = (const unsigned char *)PATH;
  unsigned long t = 0;
  for (long i = 0; i < n; i++) t += scan(p, sizeof PATH - 1);
  printf("%lu %p\n", t, (void *)scan);
  return t != (unsigned long)n * (sizeof PATH - 1);
}
#endif
