// R04:小輸入(≤ 255)下 u128::isqrt 對 u64::isqrt 的每次呼叫成本
// ./bench <u128|u64> <N>;同一組 4096 個 xorshift 輸入,差值 = u128 入口分派的成本
// --cfg solo:不編 sq64,int_sqrt::u64 只剩 sq128 一個使用者而被內聯(與 harness 不同的內聯形態)
use std::hint::black_box;
#[inline(never)] fn sq128(x: u128) -> u128 { x.isqrt() }
#[cfg(not(solo))] #[inline(never)] fn sq64(x: u64) -> u64 { x.isqrt() }
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let n: usize = a[2].parse().unwrap();
    let mut s = 0x9e3779b97f4a7c15u64;
    let v: Vec<u64> = (0..4096).map(|_| { s ^= s << 13; s ^= s >> 7; s ^= s << 17; s & 255 }).collect();
    let mut t = 0u64;
    match a[1].as_str() {
        "u128" => for i in 0..n { t = t.wrapping_add(sq128(black_box(v[i & 4095] as u128)) as u64) },
        #[cfg(not(solo))]
        "u64" => for i in 0..n { t = t.wrapping_add(sq64(black_box(v[i & 4095]))) },
        _ => panic!(),
    }
    println!("{t}");
}
