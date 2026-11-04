// bench <ascii|mix> <iters>:s.chars().rev().count()
//  ascii:4096 B 純 ASCII(長迴圈,避開出口誤判);mix:章節 bench 串(51 字元混合)
use std::hint::black_box;
#[inline(never)]
fn f(s: &str) -> usize { s.chars().rev().count() }
fn main() {
    let a: Vec<String> = std::env::args().collect(); let it: usize = a[2].parse().unwrap();
    let s: String = match a[1].as_str() {
        "ascii" => "Mary had a little lamb, ".chars().cycle().take(4096).collect(),
        "mix" => "ศไทย中华Việt Nam; Mary had a little lamb, Little lamb".into(), _ => panic!() };
    let mut t = 0;
    for _ in 0..it { t += f(black_box(&s)); }
    assert_eq!(t, s.chars().count() * it);
}
