// B5:L1 內 16 B 向量拷貝的 store 吞吐。8000 B,src/dst 皆 64 B 對齊、相距 10 KB(避開 4K 別名),
// 每輪 4 × 16 B,內外兩層迴圈都在 asm 內(迴圈中無棧存取)。單位:每 16 B。
// copy     :4 × (16 B load + 16 B store)  aarch64 ldr/str q;x86 SSE2 movdqu
// copy_stp :同上,aarch64 改用 LLVM 對 intrinsic 拷貝迴圈生成的 ldp/stp q(x86 無配對指令,同 copy)
// store    :只有 4 × 16 B store(基線:去掉 load);store_stp 同理用 stp q
// load     :只有 4 × 16 B load (基線:去掉 store)
// *_o16    :src/dst 都 +16 B(只 16 B 對齊,同 malloc 回傳;c83 探針的條件)
use std::arch::asm;
#[cfg(target_arch = "aarch64")]
macro_rules! l { ($($i:literal),*) => { |s: *mut u8, d: *mut u8, r: u64| asm!("3:", "mov {s}, {s0}", "mov {d}, {d0}", "mov {n}, #125", "2:", $($i,)*
    "add {s}, {s}, #64", "add {d}, {d}, #64", "subs {n}, {n}, #1", "b.ne 2b", "subs {r}, {r}, #1", "b.ne 3b",
    s0 = in(reg) s, d0 = in(reg) d, s = out(reg) _, d = out(reg) _, n = out(reg) _, r = inout(reg) r => _,
    out("v0") _, out("v1") _, out("v2") _, out("v3") _, options(nostack)) } }
#[cfg(target_arch = "x86_64")]
macro_rules! l { ($($i:literal),*) => { |s: *mut u8, d: *mut u8, r: u64| asm!("3:", "mov {s}, {s0}", "mov {d}, {d0}", "mov {n:e}, 125", "2:", $($i,)*
    "add {s}, 64", "add {d}, 64", "dec {n:e}", "jnz 2b", "dec {r}", "jnz 3b",
    s0 = in(reg) s, d0 = in(reg) d, s = out(reg) _, d = out(reg) _, n = out(reg) _, r = inout(reg) r => _,
    out("xmm0") _, out("xmm1") _, out("xmm2") _, out("xmm3") _, options(nostack)) } }
#[repr(align(4096))]
struct Buf([u8; 18432]);
fn main() {
    let a = std::env::args().nth(1).unwrap();
    let (m, o) = match a.strip_suffix("_o16") { Some(m) => (m, 16), None => (a.as_str(), 0) };
    let reps: u64 = 200_000;
    let mut b = Box::new(Buf([1; 18432]));
    let s = unsafe { b.0.as_mut_ptr().add(o) };
    let d = unsafe { s.add(10240) };
    unsafe {
        #[cfg(target_arch = "aarch64")]
        match m {
            "copy" => l!("ldr q0, [{s}]", "ldr q1, [{s}, #16]", "ldr q2, [{s}, #32]", "ldr q3, [{s}, #48]",
                "str q0, [{d}]", "str q1, [{d}, #16]", "str q2, [{d}, #32]", "str q3, [{d}, #48]")(s, d, reps),
            "copy_stp" => l!("ldp q0, q1, [{s}]", "ldp q2, q3, [{s}, #32]", "stp q0, q1, [{d}]", "stp q2, q3, [{d}, #32]")(s, d, reps),
            "store" => l!("str q0, [{d}]", "str q0, [{d}, #16]", "str q0, [{d}, #32]", "str q0, [{d}, #48]")(s, d, reps),
            "store_stp" => l!("stp q0, q0, [{d}]", "stp q0, q0, [{d}, #32]")(s, d, reps),
            "load" => l!("ldr q0, [{s}]", "ldr q1, [{s}, #16]", "ldr q2, [{s}, #32]", "ldr q3, [{s}, #48]")(s, d, reps),
            _ => panic!("mode"),
        }
        #[cfg(target_arch = "x86_64")]
        match m {
            "copy" | "copy_stp" => l!("movdqu xmm0, [{s}]", "movdqu xmm1, [{s} + 16]", "movdqu xmm2, [{s} + 32]", "movdqu xmm3, [{s} + 48]",
                "movdqu [{d}], xmm0", "movdqu [{d} + 16], xmm1", "movdqu [{d} + 32], xmm2", "movdqu [{d} + 48], xmm3")(s, d, reps),
            "store" | "store_stp" => l!("movdqu [{d}], xmm0", "movdqu [{d} + 16], xmm0", "movdqu [{d} + 32], xmm0", "movdqu [{d} + 48], xmm0")(s, d, reps),
            "load" => l!("movdqu xmm0, [{s}]", "movdqu xmm1, [{s} + 16]", "movdqu xmm2, [{s} + 32]", "movdqu xmm3, [{s} + 48]")(s, d, reps),
            _ => panic!("mode"),
        }
    }
    std::hint::black_box(&b);
    println!("{}", reps * 500); // 每輪 500 個 16 B
}
