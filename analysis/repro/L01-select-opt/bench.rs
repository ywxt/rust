// L01 效應:真實 BinaryHeap::from(Vec<u32>);同源以 -aarch64-select-opt=false 重編作對照。
// 用法:bench <rand|asc> <reps>;每次含一次 clone(與章節探針相同)。
use std::collections::BinaryHeap;
use std::hint::black_box;
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let reps: usize = a[2].parse().unwrap();
    let mut v: Vec<u32> = (0..100_000).collect();
    if a[1] == "rand" {
        let mut s = 0x9E3779B97F4A7C15u64;
        for i in (1..v.len()).rev() {
            s ^= s << 13; s ^= s >> 7; s ^= s << 17;
            v.swap(i, (s % (i as u64 + 1)) as usize);
        }
    }
    for _ in 0..reps { black_box(BinaryHeap::from(v.clone())); }
}
