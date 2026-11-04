// L02 效應:同一 char_len 迴圈,語料為短句重複(可預測);對照組以 -aarch64-enable-early-ifcvt=false 重編。
// chain 模式(僅 aarch64):內聯 asm 釘死資料鏈,量 and / csel 各值幾環。
// 用法:bench <en|ru|zh|emoji> <reps>   bench <chain8|chain9|chain10> <reps>
use std::hint::black_box;
#[inline(never)]
fn char_len(s: &[u8]) -> usize {
    let (mut c, mut i, l) = (0, 0, s.len());
    while i < l {
        let b = s[i];
        if b < 0x80 { i += 1 } else if b < 0xe0 { i += 2 } else if b < 0xf0 { i += 3 } else { i += 4 }
        c += 1;
    }
    c
}
#[cfg(target_arch = "aarch64")]
fn chain(m: &str, n: u64) {
    use std::arch::asm;
    let buf = vec![0xe4u8; 1 << 20]; // 全 3 字節首字節;游標每環前進 1,靠 and 環回。
    let p = buf.as_ptr();
    let mut x = 0u64;
    unsafe { match m {
        "chain8" => asm!("2: ldrb w9, [{p}, {x}]", "cmp w9, #0xf0", "cinc x10, xzr, lo", "add {x}, {x}, x10", "and {x}, {x}, #0xfffff",
            "subs {n}, {n}, #1", "b.ne 2b", p=in(reg) p, x=inout(reg) x, n=inout(reg) n => _, out("x9") _, out("x10") _),
        "chain9" => asm!("2: ldrsb w9, [{p}, {x}]", "and w9, w9, #0xff", "cmp w9, #0xf0", "cinc x10, xzr, lo", "add {x}, {x}, x10", "and {x}, {x}, #0xfffff",
            "subs {n}, {n}, #1", "b.ne 2b", p=in(reg) p, x=inout(reg) x, n=inout(reg) n => _, out("x9") _, out("x10") _),
        "chain10" => asm!("2: ldrsb w9, [{p}, {x}]", "and w9, w9, #0xff", "cmp w9, #0xf0", "cinc x10, xzr, lo", "cmp w9, #0xe0", "csel x10, xzr, x10, lo", "add {x}, {x}, x10", "and {x}, {x}, #0xfffff",
            "subs {n}, {n}, #1", "b.ne 2b", p=in(reg) p, x=inout(reg) x, n=inout(reg) n => _, out("x9") _, out("x10") _),
        _ => unreachable!(),
    } }
    black_box(x);
}
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let reps: usize = a[2].parse().unwrap();
    #[cfg(target_arch = "aarch64")]
    if a[1].starts_with("chain") { chain(&a[1], reps as u64); return; }
    let unit = match a[1].as_str() {
        "en" => "The quick brown fox jumps over the lazy dog. ",
        "ru" => "Съешь же ещё этих мягких французских булок, да выпей чаю. ",
        "zh" => "天地玄黃宇宙洪荒日月盈昃辰宿列張寒來暑往秋收冬藏閏餘成歲律呂調陽",
        _ => "😀😃😄😁😆😅😂🤣😊😇🙂🙃😉😌😍🥰",
    };
    let s = unit.repeat((1 << 18) / unit.len());
    let mut t = 0;
    for _ in 0..reps { t += char_len(black_box(s.as_bytes())); }
    // 字符數走 stdout,cycles/char 由 run.sh 算。
    println!("{}", t / reps);
}
