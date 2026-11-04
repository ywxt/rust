// S4:L1 內 8 條獨立載入/輪(asm 釘死)。q:128 位向量載入;x:64 位 GPR 載入(對照:只差寬度)
// 用法:./repro <q|x> 次數
use std::arch::asm;
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let n: u64 = a[2].parse().unwrap();
    let v = vec![1u8; 256];
    let p = std::hint::black_box(v.as_ptr());
    unsafe {
        #[cfg(target_arch = "aarch64")]
        if a[1] == "q" {
            asm!("2:", "ldr q0,[{p}]", "ldr q1,[{p},#16]", "ldr q2,[{p},#32]", "ldr q3,[{p},#48]", "ldr q4,[{p},#64]", "ldr q5,[{p},#80]", "ldr q6,[{p},#96]", "ldr q7,[{p},#112]", "subs {n},{n},#1", "b.ne 2b",
                p = in(reg) p, n = inout(reg) n => _, out("v0") _, out("v1") _, out("v2") _, out("v3") _, out("v4") _, out("v5") _, out("v6") _, out("v7") _);
        } else {
            asm!("2:", "ldr {0},[{p}]", "ldr {1},[{p},#16]", "ldr {2},[{p},#32]", "ldr {3},[{p},#48]", "ldr {4},[{p},#64]", "ldr {5},[{p},#80]", "ldr {6},[{p},#96]", "ldr {7},[{p},#112]", "subs {n},{n},#1", "b.ne 2b",
                out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, p = in(reg) p, n = inout(reg) n => _);
        }
        #[cfg(target_arch = "x86_64")]
        if a[1] == "q" {
            asm!("2:", "movdqu xmm0,[{p}]", "movdqu xmm1,[{p}+16]", "movdqu xmm2,[{p}+32]", "movdqu xmm3,[{p}+48]", "movdqu xmm4,[{p}+64]", "movdqu xmm5,[{p}+80]", "movdqu xmm6,[{p}+96]", "movdqu xmm7,[{p}+112]", "dec {n}", "jne 2b",
                p = in(reg) p, n = inout(reg) n => _, out("xmm0") _, out("xmm1") _, out("xmm2") _, out("xmm3") _, out("xmm4") _, out("xmm5") _, out("xmm6") _, out("xmm7") _);
        } else {
            asm!("2:", "mov {0},[{p}]", "mov {1},[{p}+16]", "mov {2},[{p}+32]", "mov {3},[{p}+48]", "mov {4},[{p}+64]", "mov {5},[{p}+80]", "mov {6},[{p}+96]", "mov {7},[{p}+112]", "dec {n}", "jne 2b",
                out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, out(reg) _, p = in(reg) p, n = inout(reg) n => _);
        }
    }
}
