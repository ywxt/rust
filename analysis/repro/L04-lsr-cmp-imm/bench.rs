// L04 效應:bench_skip_while_sum 迴圈(含 black_box 棧往返)。
// two = 同函式兩份迴圈(觸發);one = 單份(對照)。aarch64 另以 -disable-constant-hoisting 重編。
// 用法:bench <one|two> <reps>;每次 998 999 元素。
use std::hint::black_box;
#[inline(always)]
fn sum() -> i64 { (1001i64..1000000).map(black_box).sum() }
#[inline(never)]
fn one() -> i64 { sum() }
#[inline(never)]
fn two(f: bool) -> i64 { if f { sum() } else { sum() ^ 1 } }
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let reps: usize = a[2].parse().unwrap();
    let is_two = a[1] == "two";
    for _ in 0..reps { black_box(if is_two { two(black_box(true)) } else { one() }); }
}
