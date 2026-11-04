// B10:兩個 8 B store 之後以較寬的一次 load 讀回(store→load 轉發跨兩個 store)。
// 相依鏈經記憶體串接:x → 兩個 8 B store → load → x。單位:每輪(鏈的一圈)。
// ld16:16 B 向量 load 跨兩個 store(aarch64 ldr q;x86 movdqu),再搬回 GPR
// ld8 :同上,只讀 8 B(ldr d / movq,只對應第一個 store;只差載入寬度,基線)
// ldp :aarch64 ldp 兩半各來自一個 store;x86 無配對載入,用兩條 8 B mov(同 ldr2)
// ldr2:兩條 8 B ldr 各自轉發(只差是否配對;基線)
// ldp_x / ldr2_x:同 ldp / ldr2,但前一半改由跨 16 B 邊界的 stp 上半提供(c43 棧著色形狀);x86 用三條 8 B mov 存
// slot 16 B 對齊,p 指向 slot+16
use std::arch::asm;
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 50_000_000;
    #[repr(align(16))]
    struct S([u64; 8]);
    let mut slot = S([0; 8]);
    let p = unsafe { slot.0.as_mut_ptr().add(2) };
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m.as_str() {
            "ld16" => asm!("2:", "str {x}, [{p}]", "str {x}, [{p}, #8]", "ldr q0, [{p}]", "fmov {x}, d0", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, n = inout(reg) n => _, out("v0") _),
            "ld8" => asm!("2:", "str {x}, [{p}]", "str {x}, [{p}, #8]", "ldr d0, [{p}]", "fmov {x}, d0", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, n = inout(reg) n => _, out("v0") _),
            "ldp" => asm!("2:", "str {x}, [{p}]", "str {x}, [{p}, #8]", "ldp {x}, {t}, [{p}]", "add {x}, {x}, {t}", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, t = out(reg) _, n = inout(reg) n => _),
            "ldr2" => asm!("2:", "str {x}, [{p}]", "str {x}, [{p}, #8]", "ldr {t}, [{p}, #8]", "ldr {x}, [{p}]", "add {x}, {x}, {t}", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, t = out(reg) _, n = inout(reg) n => _),
            "ldp_x" => asm!("2:", "stp {x}, {x}, [{p}, #-8]", "str {x}, [{p}, #8]", "ldp {x}, {t}, [{p}]", "add {x}, {x}, {t}", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, t = out(reg) _, n = inout(reg) n => _),
            "ldr2_x" => asm!("2:", "stp {x}, {x}, [{p}, #-8]", "str {x}, [{p}, #8]", "ldr {t}, [{p}, #8]", "ldr {x}, [{p}]", "add {x}, {x}, {t}", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, t = out(reg) _, n = inout(reg) n => _),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m.as_str() {
            "ld16" => asm!("2:", "mov [{p}], {x}", "mov [{p} + 8], {x}", "movdqu xmm0, [{p}]", "movq {x}, xmm0", "dec {n}", "jnz 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, n = inout(reg) n => _, out("xmm0") _),
            "ld8" => asm!("2:", "mov [{p}], {x}", "mov [{p} + 8], {x}", "movq xmm0, [{p}]", "movq {x}, xmm0", "dec {n}", "jnz 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, n = inout(reg) n => _, out("xmm0") _),
            "ldp" | "ldr2" => asm!("2:", "mov [{p}], {x}", "mov [{p} + 8], {x}", "mov {t}, [{p} + 8]", "mov {x}, [{p}]", "add {x}, {t}", "dec {n}", "jnz 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, t = out(reg) _, n = inout(reg) n => _),
            "ldp_x" | "ldr2_x" => asm!("2:", "mov [{p} - 8], {x}", "mov [{p}], {x}", "mov [{p} + 8], {x}", "mov {t}, [{p} + 8]", "mov {x}, [{p}]", "add {x}, {t}", "dec {n}", "jnz 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, t = out(reg) _, n = inout(reg) n => _),
            _ => panic!("mode"),
        }
    }
    std::hint::black_box(&slot.0);
    println!("{n}");
}
