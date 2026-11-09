#![feature(portable_simd)]
use core::simd::{u8x16,cmp::SimdPartialEq,num::SimdInt};fn contains_byte_64(c:&[u8],needle:u8)->bool{assert_eq!(c.len(),64);let n=u8x16::splat(needle);let a0=u8x16::from_slice(&c[0..16]).simd_eq(n).to_simd();let a16=u8x16::from_slice(&c[16..32]).simd_eq(n).to_simd();let a32=u8x16::from_slice(&c[32..48]).simd_eq(n).to_simd();let a48=u8x16::from_slice(&c[48..64]).simd_eq(n).to_simd();(a0 | a16 | a32 | a48).reduce_min()!=0}
pub fn contains_byte_simd(bytes: &[u8], needle: u8) -> bool {
    if bytes[0] == needle {
        return true;
    }
    let prefix = if bytes.len() >= 128 { bytes.as_ptr().align_offset(64) } else { 0 };
    if prefix != 0 && contains_byte_64(&bytes[..64], needle) {
        return true;
    }
    let mut chunks = bytes[prefix..].chunks_exact(64);
    for c in &mut chunks {
        if contains_byte_64(c, needle) {
            return true;
        }
    }
    !chunks.remainder().is_empty() && contains_byte_64(&bytes[bytes.len() - 64..], needle)
}