// L05 效應:Vec::insert 取模索引,閉包經非內聯泛型呼叫(test::bench::ns_iter_inner 的形狀)。
// 對照組以 -C llvm-args=-disable-lsr 重編。用法:bench <外層次數>;每外層 100 次 insert。
use std::hint::black_box;
#[inline(never)]
fn iter<T, F: FnMut() -> T>(f: &mut F, k: u64) { for _ in 0..k { black_box(f()); } }
fn main() {
    let k: u64 = std::env::args().nth(1).unwrap().parse().unwrap();
    let (mut x, mut y, mut z, mut w) = (0x03020100u32, 0x07060504u32, 0x0b0a0908u32, 0x0f0e0d0cu32);
    let mut f = || {
        let mut v = vec![(0i32, 0i32); 30];
        for _ in 0..100 {
            let t = x ^ (x << 11); x = y; y = z; z = w; w = w ^ (w >> 19) ^ (t ^ (t >> 8));
            let l = v.len();
            v.insert(w as usize % (l + 1), (1, 1));
        }
    };
    iter(&mut f, k);
}
