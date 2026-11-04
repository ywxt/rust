// bench <llvm|ld2|uzp> <n> <iters>:[(u32,u32)] 取 .1 到 [u32]
// ld2/uzp 僅 aarch64;另以 -C llvm-args=-disable-vector-combine 編一份 llvm 對照
use std::hint::black_box;
#[inline(never)]
fn llvm(s: &[(u32, u32)], d: &mut [u32]) { for (o, i) in d.iter_mut().zip(s) { *o = i.1; } }
#[cfg(target_arch = "aarch64")]
#[inline(never)]
fn ld2(s: &[(u32, u32)], d: &mut [u32]) { use std::arch::aarch64::*; let n = d.len().min(s.len()) / 4 * 4;
    unsafe { for i in (0..n).step_by(4) { vst1q_u32(d.as_mut_ptr().add(i), vld2q_u32(s.as_ptr().add(i) as *const u32).1); } } }
#[cfg(target_arch = "aarch64")]
#[inline(never)]
fn uzp(s: &[(u32, u32)], d: &mut [u32]) { use std::arch::aarch64::*; let n = d.len().min(s.len()) / 4 * 4;
    unsafe { for i in (0..n).step_by(4) { let p = s.as_ptr().add(i) as *const u32;
        vst1q_u32(d.as_mut_ptr().add(i), vuzp2q_u32(vld1q_u32(p), vld1q_u32(p.add(4)))); } } }
fn main() { let a: Vec<String> = std::env::args().collect(); let n: usize = a[2].parse().unwrap(); let it: usize = a[3].parse().unwrap();
    let s: Vec<(u32, u32)> = (0..n as u32).map(|x| (x, x ^ 7)).collect(); let mut d = vec![0u32; n];
    let f: fn(&[(u32, u32)], &mut [u32]) = match a[1].as_str() { "llvm" => llvm,
        #[cfg(target_arch = "aarch64")] "ld2" => ld2,
        #[cfg(target_arch = "aarch64")] "uzp" => uzp, _ => panic!() };
    for _ in 0..it { f(black_box(&s), black_box(&mut d)); }
    assert_eq!(d[n - 1], (n as u32 - 1) ^ 7); }
