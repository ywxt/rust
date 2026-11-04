// B7:整數發射吞吐。單位:每輪迴圈(cycles/iter)。
// alu8  :8 條獨立 add + 計數 + 分支(add/cycle = 8 / 結果)
// nop12 :12 個 nop + 計數 + 分支(指令/cycle = 14 / 結果;前端/派發寬度)
// ex    :st x;x+=1;c=x+k;ld t;cmp c,#1001;s+=t;分支 —— 4 條 ALU(含 cmp)+ ld + st + 分支(bench_enumerate_* LSR 出口形狀)
// excr  :同 ex 去掉 c=x+k,改 cmp x,k —— 3 條 ALU(只差一條 add;基線)
// mul7  :c32/c48 的 7 條迴圈(乘法 + 棧往返 + 累加);兩邊逐條對應
// 兩邊指令逐條對應(x86 的 add 移到 cmp 之前以免改旗標,cmp/jne 可巨集融合);迴圈 .p2align 6。
use std::arch::asm;
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 200_000_000;
    let mut slot = [0u64; 8];
    let p = slot.as_mut_ptr();
    let k = 1001u64.wrapping_sub(n); // ex:x 由 0 起,c = x + k 在第 n 輪等於 1001
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m.as_str() {
            "alu8" => asm!(".p2align 6", "2:", "add {a0}, {a0}, #1", "add {a1}, {a1}, #1", "add {a2}, {a2}, #1", "add {a3}, {a3}, #1",
                "add {a4}, {a4}, #1", "add {a5}, {a5}, #1", "add {a6}, {a6}, #1", "add {a7}, {a7}, #1", "subs {n}, {n}, #1", "b.ne 2b",
                a0 = out(reg) _, a1 = out(reg) _, a2 = out(reg) _, a3 = out(reg) _, a4 = out(reg) _, a5 = out(reg) _, a6 = out(reg) _, a7 = out(reg) _,
                n = inout(reg) n => _),
            "nop12" => asm!(".p2align 6", "2:", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop",
                "subs {n}, {n}, #1", "b.ne 2b", n = inout(reg) n => _),
            "ex" => asm!(".p2align 6", "2:", "str {x}, [{p}]", "add {x}, {x}, #1", "add {c}, {x}, {k}", "ldr {t}, [{p}]",
                "cmp {c}, #1001", "add {s}, {t}, {s}", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, k = in(reg) k, c = out(reg) _, t = out(reg) _, s = inout(reg) 0u64 => _),
            "excr" => asm!(".p2align 6", "2:", "str {x}, [{p}]", "add {x}, {x}, #1", "ldr {t}, [{p}]",
                "cmp {x}, {k}", "add {s}, {t}, {s}", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, k = in(reg) n, t = out(reg) _, s = inout(reg) 0u64 => _),
            "mul7" => asm!(".p2align 6", "2:", "mul {t}, {x}, {x}", "add {x}, {x}, #1", "cmp {k}, {x}", "str {t}, [{p}]",
                "ldr {t}, [{p}]", "add {s}, {t}, {s}", "b.ne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, k = in(reg) n, t = out(reg) _, s = inout(reg) 0u64 => _),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m.as_str() {
            "alu8" => asm!(".p2align 6", "2:", "add {a0}, 1", "add {a1}, 1", "add {a2}, 1", "add {a3}, 1",
                "add {a4}, 1", "add {a5}, 1", "add {a6}, 1", "add {a7}, 1", "dec {n}", "jnz 2b",
                a0 = out(reg) _, a1 = out(reg) _, a2 = out(reg) _, a3 = out(reg) _, a4 = out(reg) _, a5 = out(reg) _, a6 = out(reg) _, a7 = out(reg) _,
                n = inout(reg) n => _),
            "nop12" => asm!(".p2align 6", "2:", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop", "nop",
                "dec {n}", "jnz 2b", n = inout(reg) n => _),
            "ex" => asm!(".p2align 6", "2:", "mov [{p}], {x}", "inc {x}", "lea {c}, [{x} + {k}]", "mov {t}, [{p}]",
                "add {s}, {t}", "cmp {c}, 1001", "jne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, k = in(reg) k, c = out(reg) _, t = out(reg) _, s = inout(reg) 0u64 => _),
            "excr" => asm!(".p2align 6", "2:", "mov [{p}], {x}", "inc {x}", "mov {t}, [{p}]",
                "add {s}, {t}", "cmp {x}, {k}", "jne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, k = in(reg) n, t = out(reg) _, s = inout(reg) 0u64 => _),
            "mul7" => asm!(".p2align 6", "2:", "lea {u}, [{x} + 1]", "imul {x}, {x}", "mov [{p}], {x}", "add {s}, [{p}]",
                "mov {x}, {u}", "cmp {u}, {k}", "jne 2b",
                p = in(reg) p, x = inout(reg) 0u64 => _, k = in(reg) n, u = out(reg) _, s = inout(reg) 0u64 => _),
            _ => panic!("mode"),
        }
    }
    std::hint::black_box(&slot);
    println!("{n}");
}
