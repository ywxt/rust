use std::hint::black_box;
// malloc+free floor, and String grow-from-empty path, per iteration
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let n: u64 = a[2].parse().unwrap();
    let mut acc = 0usize;
    match a[1].as_str() {
        "mf" => for _ in 0..n { let v: Vec<u8> = Vec::with_capacity(black_box(3)); acc += black_box(&v).capacity(); },
        "grow" => for _ in 0..n { let mut s = String::new(); s.push_str(black_box("255")); acc += black_box(&s).len(); },
        "fmt_reuse" => { use std::fmt::Write; let mut s = String::with_capacity(16); for _ in 0..n { s.clear(); write!(s, "{}", black_box(255u8)).unwrap(); acc += black_box(&s).len(); } },
        "format" => for _ in 0..n { let s = format!("{}", black_box(255u8)); acc += black_box(&s).len(); },
        _ => panic!(),
    }
    println!("{acc}");
}
