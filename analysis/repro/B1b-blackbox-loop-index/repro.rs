// swap_with_slice_usize_30 隔離探針:與 coretests/benches/slice.rs 的閉包同形,用真實 std swap_with_slice。
// ./p <mode> [outer]
//   orig   : bench 原樣,skip = black_box(skip+1) % 8(skip 經棧往返)
//   reg    : skip 留在暫存器(空 asm 阻止常量傳播,不經記憶體)
//   even   : 同 orig,但 skip 只取偶數(0,2,4,6),x 側起點保持 16 B 對齊
//   evenreg: 偶數 + 暫存器
//   rot    : 同 reg,但 8 組 x/y 輪流使用,下一次交換不讀剛寫的資料
//   rotodd : 同 rot,skip 取 0..7(含奇數)
use std::arch::asm;
use std::hint::black_box;
#[inline(always)]
fn opq(mut v: usize) -> usize { unsafe { asm!("/* {0} */", inout(reg) v, options(pure, nomem, nostack)); } v }
const N: usize = 30;
#[inline(never)]
fn run(mode: &str, outer: usize) -> usize {
    let mk = |o: usize| (o..o + N).collect::<Vec<usize>>();
    let mut xs: Vec<Vec<usize>> = (0..8).map(|k| mk(k * 100)).collect();
    let mut ys: Vec<Vec<usize>> = (0..8).map(|k| mk(k * 100 + N)).collect();
    let mut skip = 0usize; let mut acc = 0usize;
    for _ in 0..outer {
        match mode {
            "orig" => for _ in 0..32 { let (x, y) = (&mut xs[0], &mut ys[0]); x[skip..].swap_with_slice(&mut y[..N - skip]); skip = black_box(skip + 1) % 8; },
            "reg" => for _ in 0..32 { let (x, y) = (&mut xs[0], &mut ys[0]); x[skip..].swap_with_slice(&mut y[..N - skip]); skip = opq(skip + 1) % 8; },
            "even" => for _ in 0..32 { let (x, y) = (&mut xs[0], &mut ys[0]); x[skip..].swap_with_slice(&mut y[..N - skip]); skip = black_box(skip + 2) % 8; },
            "evenreg" => for _ in 0..32 { let (x, y) = (&mut xs[0], &mut ys[0]); x[skip..].swap_with_slice(&mut y[..N - skip]); skip = opq(skip + 2) % 8; },
            "rot" => for i in 0..32 { let (x, y) = (&mut xs[i % 8], &mut ys[i % 8]); x[skip..].swap_with_slice(&mut y[..N - skip]); skip = opq(skip + 2) % 8; },
            "rotodd" => for i in 0..32 { let (x, y) = (&mut xs[i % 8], &mut ys[i % 8]); x[skip..].swap_with_slice(&mut y[..N - skip]); skip = opq(skip + 1) % 8; },
            _ => unreachable!(),
        }
        acc = acc.wrapping_add(black_box((xs[0][N / 3], ys[0][N * 2 / 3])).0);
    }
    acc
}
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let outer: usize = a.get(2).map_or(2_000_000, |s| s.parse().unwrap());
    let t = std::time::Instant::now();
    let r = run(&a[1], outer);
    let ns = t.elapsed().as_nanos() as f64 / (outer * 32) as f64;
    println!("{:>8} {:7.2} ns/swap ({})", a[1], ns, r & 1);
}
