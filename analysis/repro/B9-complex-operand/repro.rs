// B9:帶移位運算元的指令與暫存器索引定址的延遲(相依鏈經「未移位」的那個輸入)。單位:每條鏈上指令。
// eor      :x ^= y(基線)
// eor_ror  :x ^= ror(y,13);aarch64 摺成一條 eor x,x,y,ror #13(LLVM 對 SipHash 的形狀)
// eor_split:同上,但 ror 拆成獨立一條(不在鏈上);x86 無摺疊形式,eor_ror 與 eor_split 同碼
// ld_base / ld_idx:指標追逐,ldr x,[x] 對 ldr x,[b,x,lsl #3]
use std::arch::asm;
macro_rules! r4 { ($($i:literal),*) => { concat!($($i, "\n",)* $($i, "\n",)* $($i, "\n",)* $($i, "\n",)*) } }
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 100_000_000;
    let mut cell = [0usize; 8];
    cell[0] = cell.as_ptr() as usize; // ld_base:指向自己;ld_idx 用全零陣列 z,索引恆為 0
    let z = [0usize; 8];
    let i = n / 4;
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m.as_str() {
            "eor" => asm!("2:", r4!("eor {x}, {x}, {y}"), "subs {n}, {n}, #1", "b.ne 2b", x = inout(reg) 1u64 => _, y = in(reg) 7u64, n = inout(reg) i => _),
            "eor_ror" => asm!("2:", r4!("eor {x}, {x}, {y}, ror #13"), "subs {n}, {n}, #1", "b.ne 2b", x = inout(reg) 1u64 => _, y = in(reg) 7u64, n = inout(reg) i => _),
            "eor_split" => asm!("2:", r4!("ror {t}, {y}, #13", "eor {x}, {x}, {t}"), "subs {n}, {n}, #1", "b.ne 2b", x = inout(reg) 1u64 => _, y = in(reg) 7u64, t = out(reg) _, n = inout(reg) i => _),
            "ld_base" => asm!("2:", r4!("ldr {x}, [{x}]"), "subs {n}, {n}, #1", "b.ne 2b", x = inout(reg) cell[0] => _, n = inout(reg) i => _),
            "ld_idx" => asm!("2:", r4!("ldr {x}, [{b}, {x}, lsl #3]"), "subs {n}, {n}, #1", "b.ne 2b", x = inout(reg) 0usize => _, b = in(reg) z.as_ptr(), n = inout(reg) i => _),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m.as_str() {
            "eor" => asm!("2:", r4!("xor {x}, {y}"), "dec {n}", "jnz 2b", x = inout(reg) 1u64 => _, y = in(reg) 7u64, n = inout(reg) i => _),
            "eor_ror" | "eor_split" => asm!("2:", r4!("mov {t}, {y}", "ror {t}, 13", "xor {x}, {t}"), "dec {n}", "jnz 2b", x = inout(reg) 1u64 => _, y = in(reg) 7u64, t = out(reg) _, n = inout(reg) i => _),
            "ld_base" => asm!("2:", r4!("mov {x}, [{x}]"), "dec {n}", "jnz 2b", x = inout(reg) cell[0] => _, n = inout(reg) i => _),
            "ld_idx" => asm!("2:", r4!("mov {x}, [{b} + {x}*8]"), "dec {n}", "jnz 2b", x = inout(reg) 0usize => _, b = in(reg) z.as_ptr(), n = inout(reg) i => _),
            _ => panic!("mode"),
        }
    }
    std::hint::black_box((&cell, &z));
    println!("{n}");
}
