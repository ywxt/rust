// L03 效應:do_count_chars 主體縮減(usize 塊、每 192 字一組、每 4 字一 unroll),對照組以關交錯重編。
// 用法:bench <reps>;資料 344 576 B(與章節 en_huge 同大小)。計數與資料值無關。
use std::hint::black_box;
fn cnc(w: usize) -> usize { ((!w >> 7) | (w >> 6)) & 0x0101010101010101 }
fn sum_bytes(v: usize) -> usize {
    const S: usize = 0x00ff00ff00ff00ff;
    ((v & S) + ((v >> 8) & S)).wrapping_mul(0x0001000100010001) >> 48
}
#[inline(never)]
fn count(body: &[usize]) -> usize {
    let mut total = 0;
    for chunk in body.chunks(192) {
        let mut c = 0;
        let (un, _) = chunk.as_chunks::<4>();
        for u in un { for &w in u { c += cnc(w); } }
        total += sum_bytes(c);
    }
    total
}
fn main() {
    let reps: usize = std::env::args().nth(1).unwrap().parse().unwrap();
    let v = vec![0x6161616161616161usize; 344_576 / 8];
    let mut t = 0;
    for _ in 0..reps { t += count(black_box(&v)); }
    println!("{t}");
}
