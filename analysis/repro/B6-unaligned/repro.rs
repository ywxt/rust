// B6:未對齊載入/存放的吞吐代價(L1 內,4 KB 區段反覆掃)。單位:每條訪存指令(cp 為每 16 B)。
// ld16 / st16 :連續 16 B load / store;_a 64 B 對齊,_u 位址 +8(半數跨 16 B、1/4 跨 64 B 行)
// cp16        :16 B load + 16 B store 拷貝;_u 為源 +8、目的對齊(glibc memmove 對齊目的端後的形狀)
// st32        :32 B store(aarch64 SVE st1b,VL=256;x86 AVX2 vmovdqu ymm);_u 位址 +8
// 內外兩層迴圈都在 asm 內。
use std::arch::asm;
#[cfg(target_arch = "aarch64")]
macro_rules! l { ($($i:literal),*) => { |s: *mut u8, d: *mut u8, r: u64| asm!(".arch_extension sve", "ptrue p7.b",
    "3:", "mov {s}, {s0}", "mov {d}, {d0}", "mov {n}, #64", "2:", $($i,)*
    "add {s}, {s}, #64", "add {d}, {d}, #64", "subs {n}, {n}, #1", "b.ne 2b", "subs {r}, {r}, #1", "b.ne 3b",
    s0 = in(reg) s, d0 = in(reg) d, s = out(reg) _, d = out(reg) _, n = out(reg) _, r = inout(reg) r => _,
    out("v0") _, out("v1") _, out("v2") _, out("v3") _, out("p7") _, options(nostack)) } }
#[cfg(target_arch = "x86_64")]
macro_rules! l { ($($i:literal),*) => { |s: *mut u8, d: *mut u8, r: u64| asm!("3:", "mov {s}, {s0}", "mov {d}, {d0}", "mov {n:e}, 64", "2:", $($i,)*
    "add {s}, 64", "add {d}, 64", "dec {n:e}", "jnz 2b", "dec {r}", "jnz 3b", "vzeroupper",
    s0 = in(reg) s, d0 = in(reg) d, s = out(reg) _, d = out(reg) _, n = out(reg) _, r = inout(reg) r => _,
    out("xmm0") _, out("xmm1") _, out("xmm2") _, out("xmm3") _, options(nostack)) } }
#[repr(align(4096))]
struct Buf([u8; 16384]);
fn main() {
    let a = std::env::args().nth(1).unwrap();
    let (m, o) = match a.strip_suffix("_u") { Some(m) => (m, 8), None => (a.strip_suffix("_a").unwrap(), 0) };
    let reps: u64 = 500_000;
    let mut b = Box::new(Buf([1; 16384]));
    let base = b.0.as_mut_ptr();
    // 源與目的相距 6 KB(避開 4K 別名);ld/st/st32 的偏移加在受測位址,cp 只加在源
    let (s, d) = unsafe { (base.add(o), base.add(6144 + if m == "cp16" { 0 } else { o })) };
    #[cfg(target_arch = "aarch64")]
    { let vl: usize; unsafe { asm!(".arch_extension sve", "cntb {}", out(reg) vl) }; assert_eq!(vl, 32, "st32 需 SVE VL=256"); }
    let per = unsafe {
        #[cfg(target_arch = "aarch64")]
        match m {
            "ld16" => { l!("ldr q0, [{s}]", "ldr q1, [{s}, #16]", "ldr q2, [{s}, #32]", "ldr q3, [{s}, #48]")(s, d, reps); 4 }
            "st16" => { l!("str q0, [{d}]", "str q0, [{d}, #16]", "str q0, [{d}, #32]", "str q0, [{d}, #48]")(s, d, reps); 4 }
            "cp16" => { l!("ldr q0, [{s}]", "ldr q1, [{s}, #16]", "ldr q2, [{s}, #32]", "ldr q3, [{s}, #48]",
                "str q0, [{d}]", "str q1, [{d}, #16]", "str q2, [{d}, #32]", "str q3, [{d}, #48]")(s, d, reps); 4 }
            "st32" => { l!("st1b {{z0.b}}, p7, [{d}]", "st1b {{z0.b}}, p7, [{d}, #1, mul vl]")(s, d, reps); 2 }
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m {
            "ld16" => { l!("movdqu xmm0, [{s}]", "movdqu xmm1, [{s} + 16]", "movdqu xmm2, [{s} + 32]", "movdqu xmm3, [{s} + 48]")(s, d, reps); 4 }
            "st16" => { l!("movdqu [{d}], xmm0", "movdqu [{d} + 16], xmm0", "movdqu [{d} + 32], xmm0", "movdqu [{d} + 48], xmm0")(s, d, reps); 4 }
            "cp16" => { l!("movdqu xmm0, [{s}]", "movdqu xmm1, [{s} + 16]", "movdqu xmm2, [{s} + 32]", "movdqu xmm3, [{s} + 48]",
                "movdqu [{d}], xmm0", "movdqu [{d} + 16], xmm1", "movdqu [{d} + 32], xmm2", "movdqu [{d} + 48], xmm3")(s, d, reps); 4 }
            "st32" => { l!("vmovdqu [{d}], ymm0", "vmovdqu [{d} + 32], ymm0")(s, d, reps); 2 }
            _ => panic!("mode"),
        }
    };
    std::hint::black_box(&b);
    println!("{}", reps * 64 * per);
}
