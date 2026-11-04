// bench <iters>:bench_range_step_by_fold_u16 的閉包(0..u16::MAX,step 64,1024 元素);run.sh 另以 IC 4 編一份
use std::hint::black_box;
#[inline(never)]
fn f16(end: u16) -> u16 { (0..end).step_by(64).map(|x| x ^ x.wrapping_sub(1)).fold(0, |a, b| a.wrapping_add(b)) }
fn main() {
    let it: u64 = std::env::args().nth(1).unwrap().parse().unwrap();
    let mut s = 0u16;
    for _ in 0..it { s = s.wrapping_add(f16(black_box(u16::MAX))); }
    black_box(s);
}
