use std::str::pattern::Pattern;

trait ContainsDispatch: Pattern {
    fn contains_in(self, haystack: &str) -> bool;
}

impl<P: Pattern> ContainsDispatch for P {
    default fn contains_in(self, haystack: &str) -> bool {
        self.is_contained_in(haystack)
    }
}

impl ContainsDispatch for &str {
    fn contains_in(self, haystack: &str) -> bool {
        if self.len() == 1 && haystack.len() >= 16 {
            byte_contains(haystack.as_bytes(), self.as_bytes()[0])
        } else {
            haystack.contains(self)
        }
    }
}

impl ContainsDispatch for char {
    fn contains_in(self, haystack: &str) -> bool {
        if self.is_ascii() && haystack.len() >= 16 {
            byte_contains(haystack.as_bytes(), self as u8)
        } else {
            haystack.contains(self)
        }
    }
}

pub fn contains<P: Pattern>(haystack: &str, pattern: P) -> bool {
    pattern.contains_in(haystack)
}

#[cfg(target_arch = "aarch64")]
fn block16(c: &[u8], needle: u8) -> bool {
    use std::arch::aarch64::*;
    assert_eq!(c.len(), 16);
    unsafe { vmaxvq_u8(vceqq_u8(vld1q_u8(c.as_ptr()), vdupq_n_u8(needle))) != 0 }
}

#[cfg(target_arch = "x86_64")]
fn block16(c: &[u8], needle: u8) -> bool {
    use std::arch::x86_64::*;
    assert_eq!(c.len(), 16);
    unsafe {
        _mm_movemask_epi8(_mm_cmpeq_epi8(
            _mm_loadu_si128(c.as_ptr().cast()),
            _mm_set1_epi8(needle as i8),
        )) != 0
    }
}

#[cfg(target_arch = "aarch64")]
fn block64(c: &[u8], needle: u8) -> bool {
    use std::arch::aarch64::*;
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

#[cfg(target_arch = "x86_64")]
fn block64(c: &[u8], needle: u8) -> bool {
    use std::arch::x86_64::*;
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

fn byte_contains(bytes: &[u8], needle: u8) -> bool {
    if bytes.len() < 64 {
        let mut chunks = bytes.chunks_exact(16);
        for c in &mut chunks {
            if block16(c, needle) { return true; }
        }
        return !chunks.remainder().is_empty()
            && block16(&bytes[bytes.len() - 16..], needle);
    }
    let prefix = if bytes.len() >= 128 {
        bytes.as_ptr().align_offset(64)
    } else { 0 };
    if prefix != 0 && block64(&bytes[..64], needle) { return true; }
    let mut chunks = bytes[prefix..].chunks_exact(64);
    for c in &mut chunks {
        if block64(c, needle) { return true; }
    }
    !chunks.remainder().is_empty() && block64(&bytes[bytes.len() - 64..], needle)
}
