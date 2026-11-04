// B3a:整數乘除延遲(相依鏈)。單位:每條 mul/div。
// add32 : x = x + 0(基線,1 cycle)
// mul32 : x = x * 1(32 位乘法;只差運算)
// udivW_qB:q = A / q,A = D*D,故 q 恆為 D(位數 B);鏈經除數串接。
//   aarch64 udiv 依商位數早停,x86 div 固定。x86 鏈上多一條 mov(可被消除)。
// udiv64_q64:商需 64 位,改經被除數串接:q = (A ^ (q >> 63)) / 3,鏈上多 lsr+eor 兩條;
// chain2 為同一鏈去掉 udiv 的基線(udiv64_q64 − chain2 = 除法延遲)。
use std::arch::asm;
#[cfg(target_arch = "aarch64")]
macro_rules! l { ($($i:literal),*; $($r:tt)*) => { asm!("2:", $($i,)* $($i,)* $($i,)* $($i,)* "subs {n}, {n}, #1", "b.ne 2b", $($r)*) } }
#[cfg(target_arch = "x86_64")]
macro_rules! l { ($($i:literal),*; $($r:tt)*) => { asm!("2:", $($i,)* $($i,)* $($i,)* $($i,)* "dec {n}", "jnz 2b", $($r)*) } }
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 50_000_000;
    let d: u64 = match m.as_str() { "udiv32_q8" | "udiv64_q8" => 0xff, "udiv32_q16" => 0xffff, "udiv64_q32" => 0xffff_ffff, _ => 0 };
    let (a, k, i) = (d * d, if m == "mul32" { 1u64 } else { 0 }, n / 4);
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m.as_str() {
            "add32" => l!("add {x:w}, {x:w}, {k:w}"; x = inout(reg) d => _, k = in(reg) k, n = inout(reg) i => _),
            "mul32" => l!("mul {x:w}, {x:w}, {k:w}"; x = inout(reg) d => _, k = in(reg) k, n = inout(reg) i => _),
            "udiv32_q8" | "udiv32_q16" => l!("udiv {q:w}, {a:w}, {q:w}"; q = inout(reg) d => _, a = in(reg) a, n = inout(reg) i => _),
            "udiv64_q8" | "udiv64_q32" => l!("udiv {q}, {a}, {q}"; q = inout(reg) d => _, a = in(reg) a, n = inout(reg) i => _),
            "chain2" => l!("lsr {t}, {q}, #63", "eor {q}, {t}, {a}"; q = inout(reg) 0u64 => _, a = in(reg) u64::MAX, t = out(reg) _, n = inout(reg) i => _),
            "udiv64_q64" => l!("lsr {t}, {q}, #63", "eor {t}, {t}, {a}", "udiv {q}, {t}, {d}";
                q = inout(reg) 0u64 => _, a = in(reg) u64::MAX, d = in(reg) 3u64, t = out(reg) _, n = inout(reg) i => _),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m.as_str() {
            "add32" => l!("add {x:e}, {k:e}"; x = inout(reg) d => _, k = in(reg) k, n = inout(reg) i => _),
            "mul32" => l!("imul {x:e}, {k:e}"; x = inout(reg) d => _, k = in(reg) k, n = inout(reg) i => _),
            "udiv32_q8" | "udiv32_q16" => l!("mov eax, {a:e}", "xor edx, edx", "div {q:e}", "mov {q:e}, eax";
                q = inout(reg) d => _, a = in(reg) a, out("eax") _, out("edx") _, n = inout(reg) i => _),
            "udiv64_q8" | "udiv64_q32" => l!("mov rax, {a}", "xor edx, edx", "div {q}", "mov {q}, rax";
                q = inout(reg) d => _, a = in(reg) a, out("rax") _, out("rdx") _, n = inout(reg) i => _),
            "chain2" => l!("shr {q}, 63", "xor {q}, {a}"; q = inout(reg) 0u64 => _, a = in(reg) u64::MAX, n = inout(reg) i => _),
            "udiv64_q64" => l!("mov rax, {q}", "shr rax, 63", "xor rax, {a}", "xor edx, edx", "div {d}", "mov {q}, rax";
                q = inout(reg) 0u64 => _, a = in(reg) u64::MAX, d = in(reg) 3u64, out("rax") _, out("rdx") _, n = inout(reg) i => _),
            _ => panic!("mode"),
        }
    }
    println!("{n}");
}
