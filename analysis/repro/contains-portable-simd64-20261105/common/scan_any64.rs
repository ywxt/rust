#![feature(portable_simd)]
use core::simd::{u8x64,cmp::SimdPartialEq,num::SimdInt};fn contains_byte_64(c:&[u8],needle:u8)->bool{assert_eq!(c.len(),64);let n=u8x64::splat(needle);let a0=u8x64::from_slice(&c[0..64]).simd_eq(n);(a0).any()}
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