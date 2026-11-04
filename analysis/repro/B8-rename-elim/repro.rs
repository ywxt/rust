// B8:暫存器搬移消除與立即數加法摺疊。單位:每條 mov/add。
// movchain:a=b; b=a; …(8 條相依 mov 鏈)
// movindep:8 條 mov 都從同一來源(無相依;只差來源暫存器,基線)
// addchain:a+=1 ×8(相依立即數加法鏈)
// addreg  :a+=r ×8(相依暫存器加法鏈,r=1;只差運算元,基線)
use std::arch::asm;
macro_rules! r8 { ($i:literal) => { concat!($i, "\n", $i, "\n", $i, "\n", $i, "\n", $i, "\n", $i, "\n", $i, "\n", $i) } }
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 100_000_000;
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m.as_str() {
            "movchain" => asm!("2:", r8!("mov {a}, {b}\nmov {b}, {a}"), "subs {n}, {n}, #1", "b.ne 2b", a = out(reg) _, b = out(reg) _, n = inout(reg) n / 2 => _),
            "movindep" => asm!("2:", r8!("mov {a}, {s}\nmov {b}, {s}"), "subs {n}, {n}, #1", "b.ne 2b", a = out(reg) _, b = out(reg) _, s = in(reg) 5u64, n = inout(reg) n / 2 => _),
            "addchain" => asm!("2:", r8!("add {a}, {a}, #1"), "subs {n}, {n}, #1", "b.ne 2b", a = out(reg) _, n = inout(reg) n => _),
            "addreg" => asm!("2:", r8!("add {a}, {a}, {r}"), "subs {n}, {n}, #1", "b.ne 2b", a = out(reg) _, r = in(reg) 1u64, n = inout(reg) n => _),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m.as_str() {
            "movchain" => asm!("2:", r8!("mov {a}, {b}\nmov {b}, {a}"), "dec {n}", "jnz 2b", a = out(reg) _, b = out(reg) _, n = inout(reg) n / 2 => _),
            "movindep" => asm!("2:", r8!("mov {a}, {s}\nmov {b}, {s}"), "dec {n}", "jnz 2b", a = out(reg) _, b = out(reg) _, s = in(reg) 5u64, n = inout(reg) n / 2 => _),
            "addchain" => asm!("2:", r8!("add {a}, 1"), "dec {n}", "jnz 2b", a = out(reg) _, n = inout(reg) n => _),
            "addreg" => asm!("2:", r8!("add {a}, {r}"), "dec {n}", "jnz 2b", a = out(reg) _, r = in(reg) 1u64, n = inout(reg) n => _),
            _ => panic!("mode"),
        }
    }
    println!("{}", n * 8);
}
