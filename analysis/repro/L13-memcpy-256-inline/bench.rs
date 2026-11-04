// bench <inline|libc> <iters>:反覆拷貝 256 B 陣列([&i32; 32] 同大小)
//  inline:定長 *d = *s(a64 內聯;x86 預設呼叫 memcpy,run.sh 另以 +avx 編一份才內聯)
//  libc:長度經 black_box,兩邊都呼叫 libc memcpy(對照)
use std::hint::black_box;
#[inline(never)]
fn cp(d: &mut [u64; 32], s: &[u64; 32]) { *d = *s; }
#[inline(never)]
fn cp_libc(d: &mut [u64; 32], s: &[u64; 32]) { unsafe { std::ptr::copy_nonoverlapping(s.as_ptr(), d.as_mut_ptr(), black_box(32)) } }
fn main() {
    let a: Vec<String> = std::env::args().collect(); let it: u64 = a[2].parse().unwrap();
    let f = match a[1].as_str() { "inline" => cp, "libc" => cp_libc, _ => panic!() };
    let s = [7u64; 32]; let mut d = [0u64; 32];
    for _ in 0..it { f(black_box(&mut d), black_box(&s)); }
    assert_eq!(d[31], 7);
}
