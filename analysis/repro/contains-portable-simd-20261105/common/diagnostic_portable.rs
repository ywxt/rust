#![feature(portable_simd)]
#[cfg(any(
    all(target_arch = "aarch64", target_feature = "neon"),
    all(target_arch = "x86_64", target_feature = "sse2"),
))]
pub fn contains_byte_64(c: &[u8], needle: u8) -> bool {
    use core::simd::cmp::SimdPartialEq;
    use core::simd::u8x16;

    assert_eq!(c.len(), 64);
    let n = u8x16::splat(needle);
    let a = u8x16::from_slice(&c[..16]).simd_eq(n);
    let b = u8x16::from_slice(&c[16..32]).simd_eq(n);
    let d = u8x16::from_slice(&c[32..48]).simd_eq(n);
    let e = u8x16::from_slice(&c[48..64]).simd_eq(n);
    (a | b | d | e).any()
}