#![feature(portable_simd)]
#[cfg(all(target_arch = "aarch64", target_feature = "neon"))]
pub fn contains_byte_64(c: &[u8], needle: u8) -> bool {
    use core::arch::aarch64::*;
    assert_eq!(c.len(), 64);
    unsafe {
        let p = c.as_ptr();
        let n = vdupq_n_u8(needle);
        let a = vceqq_u8(vld1q_u8(p), n);
        let b = vceqq_u8(vld1q_u8(p.add(16)), n);
        let d = vceqq_u8(vld1q_u8(p.add(32)), n);
        let e = vceqq_u8(vld1q_u8(p.add(48)), n);
        vmaxvq_u8(vorrq_u8(vorrq_u8(a, b), vorrq_u8(d, e))) != 0
    }
}
#[cfg(all(target_arch = "x86_64", target_feature = "sse2"))]
pub fn contains_byte_64(c: &[u8], needle: u8) -> bool {
    use core::arch::x86_64::*;
    assert_eq!(c.len(), 64);
    unsafe {
        let p = c.as_ptr().cast::<__m128i>();
        let n = _mm_set1_epi8(needle as i8);
        let a = _mm_cmpeq_epi8(_mm_loadu_si128(p), n);
        let b = _mm_cmpeq_epi8(_mm_loadu_si128(p.add(1)), n);
        let d = _mm_cmpeq_epi8(_mm_loadu_si128(p.add(2)), n);
        let e = _mm_cmpeq_epi8(_mm_loadu_si128(p.add(3)), n);
        _mm_movemask_epi8(_mm_or_si128(_mm_or_si128(a, b), _mm_or_si128(d, e))) != 0
    }
}