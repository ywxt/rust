// B2:L1 命中的載入到使用延遲(指標追逐,每條 load 依賴上一條)。單位:每條 load。
// base:ldr x,[x]            (基址定址)
// idx :ldr x,[b, x, lsl #3] (暫存器索引定址;只差定址模式)
use std::arch::asm;
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 100_000_000;
    let mut cell = [0usize; 8];
    cell[0] = cell.as_ptr() as usize; // base:指向自己
    let p = cell[0];
    let z = [0usize; 8]; // idx:z[0]=0,索引恆為 0
    let zb = z.as_ptr();
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m.as_str() {
            "base" => asm!("2:", "ldr {x}, [{x}]", "ldr {x}, [{x}]", "ldr {x}, [{x}]", "ldr {x}, [{x}]", "subs {n}, {n}, #1", "b.ne 2b",
                x = inout(reg) p => _, n = inout(reg) n / 4 => _),
            "idx" => asm!("2:", "ldr {x}, [{b}, {x}, lsl #3]", "ldr {x}, [{b}, {x}, lsl #3]", "ldr {x}, [{b}, {x}, lsl #3]", "ldr {x}, [{b}, {x}, lsl #3]", "subs {n}, {n}, #1", "b.ne 2b",
                x = inout(reg) 0usize => _, b = in(reg) zb, n = inout(reg) n / 4 => _),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m.as_str() {
            "base" => asm!("2:", "mov {x}, [{x}]", "mov {x}, [{x}]", "mov {x}, [{x}]", "mov {x}, [{x}]", "dec {n}", "jnz 2b",
                x = inout(reg) p => _, n = inout(reg) n / 4 => _),
            "idx" => asm!("2:", "mov {x}, [{b} + {x}*8]", "mov {x}, [{b} + {x}*8]", "mov {x}, [{b} + {x}*8]", "mov {x}, [{b} + {x}*8]", "dec {n}", "jnz 2b",
                x = inout(reg) 0usize => _, b = in(reg) zb, n = inout(reg) n / 4 => _),
            _ => panic!("mode"),
        }
    }
    std::hint::black_box((&cell, &z));
    println!("{n}");
}
