// L06 效應:逐條複製 bench_filter_map_ref_sum 的倖存檢查迴圈(checked_mul + black_box 棧往返)。
// fm = 兩邊原形;base = 把檢查換成單條比較(與 fm 只差檢查)。用法:bench <fm|base>;N = 2e8。
use std::arch::asm;
const N: u64 = 200_000_000;
fn main() {
    let v = std::env::args().nth(1).unwrap();
    let (mut sum, mut slot) = (0u64, [0u64; 8]);
    let p = slot.as_mut_ptr();
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match v.as_str() {
            "fm" => asm!(".p2align 6", "b 3f", "2:", "add {x}, {x}, #1", "cmp {k}, {x}", "b.eq 4f", "3:",
                "mul {t}, {x}, {x}", "smulh {u}, {x}, {x}", "cmp {u}, {t}, asr #63", "b.ne 2b",
                "str {t}, [{p}]", "ldr {t}, [{p}]", "add {s}, {t}, {s}", "b 2b", "4:",
                x = inout(reg) 0u64 => _, s = inout(reg) sum, p = in(reg) p, t = out(reg) _, u = out(reg) _, k = in(reg) N),
            "base" => asm!(".p2align 6", "b 3f", "2:", "add {x}, {x}, #1", "cmp {k}, {x}", "b.eq 4f", "3:",
                "mul {t}, {x}, {x}", "cmp {t}, #1, lsl #12", "b.eq 2b",
                "str {t}, [{p}]", "ldr {t}, [{p}]", "add {s}, {t}, {s}", "b 2b", "4:",
                x = inout(reg) 0u64 => _, s = inout(reg) sum, p = in(reg) p, t = out(reg) _, k = in(reg) N),
            _ => panic!(),
        }
        #[cfg(target_arch = "x86_64")]
        match v.as_str() {
            "fm" => asm!(".p2align 6", "jmp 3f", "2:", "inc {x}", "cmp {x}, {k}", "je 4f", "3:",
                "mov {t}, {x}", "imul {t}, {x}", "jo 2b",
                "mov [{p}], {t}", "add {s}, [{p}]", "jmp 2b", "4:",
                x = inout(reg) 0u64 => _, s = inout(reg) sum, p = in(reg) p, t = out(reg) _, k = in(reg) N),
            "base" => asm!(".p2align 6", "jmp 3f", "2:", "inc {x}", "cmp {x}, {k}", "je 4f", "3:",
                "mov {t}, {x}", "imul {t}, {x}", "cmp {t}, 4096", "je 2b",
                "mov [{p}], {t}", "add {s}, [{p}]", "jmp 2b", "4:",
                x = inout(reg) 0u64 => _, s = inout(reg) sum, p = in(reg) p, t = out(reg) _, k = in(reg) N),
            _ => panic!(),
        }
    }
    std::hint::black_box(sum);
}
