// bench <n>:複製 any::bench_downcast_ref 迴圈體;run.sh 以預設與 -no-stack-coloring 各編一份
use std::any::Any;
use std::hint::black_box;
#[inline(never)]
fn v0(n: u64) {
    for _ in 0..n {
        let mut x = 0isize;
        let mut y = &mut x as &mut dyn Any;
        black_box(&mut y);
        black_box(y.downcast_ref::<isize>() == Some(&0));
    }
}
fn main() { v0(std::env::args().nth(1).unwrap().parse().unwrap()); }
