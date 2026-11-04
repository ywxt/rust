// bench <iters>:7000 B 全 ASCII 上跑 iter().all(u8::is_ascii);run.sh 以不同展開開關各編一份
use std::hint::black_box;
#[inline(never)]
fn all_ascii(b: &[u8]) -> bool { b.iter().all(u8::is_ascii) }
fn main() {
    let it: u64 = std::env::args().nth(1).unwrap().parse().unwrap();
    let v: Vec<u8> = (0..7000).map(|i| b"abcxyz019 .,"[i % 12]).collect();
    let mut ok = true;
    for _ in 0..it { ok &= all_ascii(black_box(&v)); }
    assert!(ok);
}
