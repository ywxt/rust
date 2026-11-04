// B1:同址 load-add-store 經記憶體的依賴鏈,與 Vec::push 形狀。單位:每輪迴圈。
// rmw       : ld [p] → +1 → st [p](每輪經記憶體串接)
// rmw_other : 同上,但存到 [p+64](只差位址;無記憶體依賴,基線)
// push      : rustc 為 `v.push(0); black_box(&*v)` 生成的迴圈(len 經記憶體往返),元素區 256 MB(同 c14 探針 pre:寫流出快取)
// push_l1   : 同 push,但 cap=1024,元素區留在 L1
// push_reg  : 同 push_l1,但 len 留在暫存器(只差 len 的 load/store;基線)
use std::arch::asm;
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 200_000_000;
    let mut s = [0u64; 16];
    let p = s.as_mut_ptr();
    let cap = if m == "push" { 1 << 26 } else { 1024 };
    let mut el = vec![0u32; cap];
    // Vec 三欄位 {cap, ptr, len};len==cap 時歸零代替 grow(極少發生)
    let mut v = [cap as u64, el.as_mut_ptr() as u64, 0];
    let vp = v.as_mut_ptr();
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m.as_str() {
            "rmw" => asm!("2:", "ldr {t}, [{p}]", "add {t}, {t}, #1", "str {t}, [{p}]", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, t = out(reg) _, n = inout(reg) n => _),
            "rmw_other" => asm!("2:", "ldr {t}, [{p}]", "add {t}, {t}, #1", "str {t}, [{p}, #64]", "subs {n}, {n}, #1", "b.ne 2b",
                p = in(reg) p, t = out(reg) _, n = inout(reg) n => _),
            "push" | "push_l1" => asm!("2:", "ldp {c}, {e}, [{v}]", "ldr {l}, [{v}, #16]", "cmp {l}, {c}", "b.ne 3f", "mov {l}, #0", "3:",
                "str wzr, [{e}, {l}, lsl #2]", "add {l}, {l}, #1", "str {l}, [{v}, #16]", "str {v}, [{p}]", "subs {n}, {n}, #1", "b.ne 2b",
                v = in(reg) vp, p = in(reg) p, c = out(reg) _, e = out(reg) _, l = out(reg) _, n = inout(reg) n => _),
            "push_reg" => asm!("2:", "ldp {c}, {e}, [{v}]", "cmp {l}, {c}", "b.ne 3f", "mov {l}, #0", "3:",
                "str wzr, [{e}, {l}, lsl #2]", "add {l}, {l}, #1", "str {v}, [{p}]", "subs {n}, {n}, #1", "b.ne 2b",
                v = in(reg) vp, p = in(reg) p, c = out(reg) _, e = out(reg) _, l = inout(reg) 0u64 => _, n = inout(reg) n => _),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m.as_str() {
            "rmw" => asm!("2:", "mov {t}, [{p}]", "add {t}, 1", "mov [{p}], {t}", "dec {n}", "jnz 2b",
                p = in(reg) p, t = out(reg) _, n = inout(reg) n => _),
            "rmw_other" => asm!("2:", "mov {t}, [{p}]", "add {t}, 1", "mov [{p} + 64], {t}", "dec {n}", "jnz 2b",
                p = in(reg) p, t = out(reg) _, n = inout(reg) n => _),
            "push" | "push_l1" => asm!("2:", "mov {l}, [{v} + 16]", "cmp {l}, [{v}]", "jne 3f", "xor {l:e}, {l:e}", "3:", "mov {e}, [{v} + 8]",
                "mov dword ptr [{e} + {l}*4], 0", "inc {l}", "mov [{v} + 16], {l}", "mov [{p}], {v}", "dec {n}", "jnz 2b",
                v = in(reg) vp, p = in(reg) p, e = out(reg) _, l = out(reg) _, n = inout(reg) n => _),
            "push_reg" => asm!("2:", "cmp {l}, [{v}]", "jne 3f", "xor {l:e}, {l:e}", "3:", "mov {e}, [{v} + 8]",
                "mov dword ptr [{e} + {l}*4], 0", "inc {l}", "mov [{p}], {v}", "dec {n}", "jnz 2b",
                v = in(reg) vp, p = in(reg) p, e = out(reg) _, l = inout(reg) 0u64 => _, n = inout(reg) n => _),
            _ => panic!("mode"),
        }
    }
    std::hint::black_box((&s, &el, &v));
    println!("{n}");
}
