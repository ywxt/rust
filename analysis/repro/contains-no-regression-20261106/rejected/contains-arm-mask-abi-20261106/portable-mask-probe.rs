#![feature(portable_simd)]
pub fn contains_match(needle: u8, bytes: &[u8]) -> usize {
    use core::simd::cmp::SimdPartialEq;
    use core::simd::u8x16;

    // SAFETY: the only caller checks the 16-byte minimum.
    unsafe { core::hint::assert_unchecked(bytes.len() >= 16) };
    if bytes[0] == needle {
        return 1;
    }
    let n = u8x16::splat(needle);
    let mut chunks = bytes.chunks_exact(64);
    for c in &mut chunks {
        let a = u8x16::from_slice(&c[..16]).simd_eq(n);
        let b = u8x16::from_slice(&c[16..32]).simd_eq(n);
        let d = u8x16::from_slice(&c[32..48]).simd_eq(n);
        let e = u8x16::from_slice(&c[48..64]).simd_eq(n);
        if (a | b | d | e).any() {
            return 1;
        }
    }
    let mut tail = chunks.remainder().chunks_exact(16);
    for c in &mut tail {
        if u8x16::from_slice(c).simd_eq(n).any() {
            return 1;
        }
    }
    (!tail.remainder().is_empty() && u8x16::from_slice(&bytes[bytes.len() - 16..]).simd_eq(n).any()) as usize
}
