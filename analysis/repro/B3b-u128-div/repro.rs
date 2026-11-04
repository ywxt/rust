// B3b:執行期除數的 u128 ÷ u64(值)相依鏈。單位:每次除法。
// u128:65 位 ÷ 33 位(呼叫 __udivti3:x86 內用 div 指令,aarch64 為軟體除法)
// u64 :同一鏈改為 64 位 ÷ 33 位(兩邊都是硬體除法;只差寬度,基線)
// 鏈:q = (A ^ (q >> 40)) / d;q < 2^33,故 q >> 40 恆為 0,但編譯器不知道。
use std::hint::black_box;
#[inline(never)]
fn u128_chain(a: u128, d: u128, n: u64) -> u128 {
    let mut q = 0;
    for _ in 0..n { q = (a ^ (q >> 40)) / d; }
    q
}
#[inline(never)]
fn u64_chain(a: u64, d: u64, n: u64) -> u64 {
    let mut q = 0;
    for _ in 0..n { q = (a ^ (q >> 40)) / d; }
    q
}
fn main() {
    let m = std::env::args().nth(1).unwrap();
    let n: u64 = 20_000_000;
    let d = black_box((1u64 << 32) | 12345); // 33 位
    match m.as_str() {
        "u128" => { black_box(u128_chain(black_box((1u128 << 64) | 0xdead_beef), d as u128, n)); }
        "u64" => { black_box(u64_chain(black_box((1u64 << 63) | 0xdead_beef), d, n)); }
        _ => panic!("mode"),
    }
    println!("{n}");
}
