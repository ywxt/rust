// bench <模式> <n>
//  延遲(每輪 8 步相依,鏈在 a):a64: eor | fold(eor a,b,a,ror #13) | split(ror a;eor) |
//    fold_u(eor a,a,b,ror #13,鏈走未移位運算元) | split_u(ror t,b 不在鏈上;eor a,a,t)
//    x86: xor | rolxor(rol a;xor) | rolxor_u(rol t 不在鏈上;xor a,t)
//  sip / sip_asm:SipHash-1-3 依賴鏈,cyc/雜湊(sip_asm 以不透明 ror 阻止摺疊,僅 a64)
//  diff / diff_asm:以此雜湊建 HashSet 跑 difference(10 對 100),cyc/次
use std::arch::asm;
use std::collections::HashSet;
use std::hash::{BuildHasher, Hasher};
use std::hint::black_box;
#[cfg(target_arch = "aarch64")]
macro_rules! lat { ($name:ident, $($i:literal),*) => { #[inline(never)] fn $name(n: u64) { unsafe {
    asm!("/* {t} */", "2:", $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* "subs {n}, {n}, #1", "b.ne 2b",
         n = inout(reg) n => _, a = inout(reg) 1u64 => _, b = in(reg) 3u64, t = out(reg) _); } } } }
#[cfg(target_arch = "x86_64")]
macro_rules! lat { ($name:ident, $($i:literal),*) => { #[inline(never)] fn $name(n: u64) { unsafe {
    asm!("/* {t} */", "2:", $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* $($i,)* "dec {n}", "jnz 2b",
         n = inout(reg) n => _, a = inout(reg) 1u64 => _, b = in(reg) 3u64, t = out(reg) _); } } } }
#[cfg(target_arch = "aarch64")] lat!(eor, "eor {a}, {a}, {b}");
#[cfg(target_arch = "aarch64")] lat!(fold, "eor {a}, {b}, {a}, ror #13");
#[cfg(target_arch = "aarch64")] lat!(fold_u, "eor {a}, {a}, {b}, ror #13");
#[cfg(target_arch = "aarch64")] lat!(split, "ror {a}, {a}, #13", "eor {a}, {a}, {b}");
#[cfg(target_arch = "aarch64")] lat!(split_u, "ror {t}, {b}, #13", "eor {a}, {a}, {t}");
#[cfg(target_arch = "x86_64")] lat!(xor, "xor {a}, {b}");
#[cfg(target_arch = "x86_64")] lat!(rolxor, "rol {a}, 13", "xor {a}, {b}");
#[cfg(target_arch = "x86_64")] lat!(rolxor_u, "mov {t}, {b}", "rol {t}, 13", "xor {a}, {t}");

#[inline(always)]
fn rl<const N: u32, const A: bool>(x: u64) -> u64 {
    #[cfg(target_arch = "aarch64")]
    if A { let mut v = x; unsafe { asm!("ror {v}, {v}, #{s}", v = inout(reg) v, s = const (64 - N) % 64, options(pure, nomem, nostack)); } return v; }
    x.rotate_left(N)
}
#[inline(always)]
fn round<const A: bool>(v: &mut [u64; 4]) {
    v[0] = v[0].wrapping_add(v[1]); v[1] = rl::<13, A>(v[1]); v[1] ^= v[0]; v[0] = rl::<32, A>(v[0]);
    v[2] = v[2].wrapping_add(v[3]); v[3] = rl::<16, A>(v[3]); v[3] ^= v[2];
    v[0] = v[0].wrapping_add(v[3]); v[3] = rl::<21, A>(v[3]); v[3] ^= v[0];
    v[2] = v[2].wrapping_add(v[1]); v[1] = rl::<17, A>(v[1]); v[1] ^= v[2]; v[2] = rl::<32, A>(v[2]);
}
#[inline(always)]
fn sip13<const A: bool>(k0: u64, k1: u64, m: u64) -> u64 {
    let mut v = [k0 ^ 0x736f6d6570736575, k1 ^ 0x646f72616e646f6d, k0 ^ 0x6c7967656e657261, k1 ^ 0x7465646279746573];
    let b = m | (8u64 << 56);
    v[3] ^= b; round::<A>(&mut v); v[0] ^= b; v[2] ^= 0xff; round::<A>(&mut v); round::<A>(&mut v); round::<A>(&mut v);
    v[0] ^ v[1] ^ v[2] ^ v[3]
}
#[inline(never)]
fn chain<const A: bool>(n: u64) -> u64 { let (k0, k1) = (black_box(1), black_box(2)); let mut x = 3; for _ in 0..n { x = sip13::<A>(k0, k1, x); } x }
#[derive(Clone, Copy)] struct Bh<const A: bool>(u64, u64);
struct H<const A: bool>(u64, u64, u64);
impl<const A: bool> Hasher for H<A> {
    fn write(&mut self, _: &[u8]) { unreachable!() }
    fn write_i32(&mut self, i: i32) { self.2 = i as u32 as u64; }
    fn finish(&self) -> u64 { sip13::<A>(self.0, self.1, self.2) }
}
impl<const A: bool> BuildHasher for Bh<A> { type Hasher = H<A>; fn build_hasher(&self) -> H<A> { H(self.0, self.1, 0) } }
fn diff<const A: bool>(n: u64) {
    let bh = Bh::<A>(black_box(11), black_box(22));
    let mut s = HashSet::with_hasher(bh); s.extend(0..10i32);
    let mut l = HashSet::with_hasher(bh); l.extend(0..100i32);
    for _ in 0..n { black_box(black_box(&s).difference(black_box(&l)).count()); }
}
fn main() {
    let a: Vec<String> = std::env::args().collect(); let n: u64 = a[2].parse().unwrap();
    match a[1].as_str() {
        #[cfg(target_arch = "aarch64")] "eor" => eor(n),
        #[cfg(target_arch = "aarch64")] "fold" => fold(n),
        #[cfg(target_arch = "aarch64")] "fold_u" => fold_u(n),
        #[cfg(target_arch = "aarch64")] "split" => split(n),
        #[cfg(target_arch = "aarch64")] "split_u" => split_u(n),
        #[cfg(target_arch = "x86_64")] "xor" => xor(n),
        #[cfg(target_arch = "x86_64")] "rolxor" => rolxor(n),
        #[cfg(target_arch = "x86_64")] "rolxor_u" => rolxor_u(n),
        "sip" => { black_box(chain::<false>(n)); }
        "sip_asm" => { black_box(chain::<true>(n)); }
        "diff" => diff::<false>(n),
        "diff_asm" => diff::<true>(n),
        _ => panic!(),
    }
}
