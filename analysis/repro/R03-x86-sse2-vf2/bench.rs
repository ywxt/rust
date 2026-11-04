// R03:char_count case01 迴圈(filter 非延續字節再 count),量 cycles/B
// ./bench <reps>;緩衝 344 576 B(= en_huge 語料大小),內容為 ASCII 與 UTF-8 延續字節混合
use std::hint::black_box;
#[inline(never)]
fn general(s: &[u8]) -> usize { s.iter().filter(|&&b| (b as i8) >= -0x40).count() }
fn main() {
    let reps: usize = std::env::args().nth(1).unwrap().parse().unwrap();
    let s: Vec<u8> = (0..344_576u32).map(|i| if i % 7 == 0 { 0x80 | (i as u8 & 0x3f) } else { b'a' + (i % 26) as u8 }).collect();
    let mut t = 0;
    for _ in 0..reps { t += general(black_box(&s)); }
    println!("{t}");
}
