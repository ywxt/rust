// Original implementation taken from rust-memchr.
// Copyright 2015 Andrew Gallant, bluss and Nicolas Koch

use crate::intrinsics::const_eval_select;

const LO_USIZE: usize = usize::repeat_u8(0x01);
const HI_USIZE: usize = usize::repeat_u8(0x80);
const USIZE_BYTES: usize = size_of::<usize>();

/// Returns `true` if `x` contains any zero byte.
///
/// From *Matters Computational*, J. Arndt:
///
/// "The idea is to subtract one from each of the bytes and then look for
/// bytes where the borrow propagated all the way to the most significant
/// bit."
#[inline]
const fn contains_zero_byte(x: usize) -> bool {
    x.wrapping_sub(LO_USIZE) & !x & HI_USIZE != 0
}

/// Returns the first index matching the byte `x` in `text`.
#[inline]
#[must_use]
pub const fn memchr(x: u8, text: &[u8]) -> Option<usize> {
    // Fast path for small slices.
    if text.len() < 2 * USIZE_BYTES {
        return memchr_naive(x, text);
    }

    memchr_aligned(x, text)
}

#[inline]
const fn memchr_naive(x: u8, text: &[u8]) -> Option<usize> {
    let mut i = 0;

    // FIXME(const-hack): Replace with `text.iter().pos(|c| *c == x)`.
    while i < text.len() {
        if text[i] == x {
            return Some(i);
        }

        i += 1;
    }

    None
}

#[cfg(not(all(
    target_arch = "aarch64",
    target_feature = "neon",
    target_endian = "little",
    target_pointer_width = "64"
)))]
#[rustc_allow_const_fn_unstable(const_eval_select)] // fallback impl has same behavior
const fn memchr_aligned(x: u8, text: &[u8]) -> Option<usize> {
    // The runtime version behaves the same as the compiletime version, it's
    // just more optimized.
    const_eval_select!(
        @capture { x: u8, text: &[u8] } -> Option<usize>:
        if const {
            memchr_naive(x, text)
        } else {
            // Scan for a single byte value by reading two `usize` words at a time.
            //
            // Split `text` in three parts
            // - unaligned initial part, before the first word aligned address in text
            // - body, scan by 2 words at a time
            // - the last remaining part, < 2 word size

            // search up to an aligned boundary
            let len = text.len();
            let ptr = text.as_ptr();
            let mut offset = ptr.align_offset(USIZE_BYTES);

            if offset > 0 {
                offset = offset.min(len);
                let slice = &text[..offset];
                if let Some(index) = memchr_naive(x, slice) {
                    return Some(index);
                }
            }

            // search the body of the text
            let repeated_x = usize::repeat_u8(x);
            while offset <= len - 2 * USIZE_BYTES {
                // SAFETY: the while's predicate guarantees a distance of at least 2 * usize_bytes
                // between the offset and the end of the slice.
                unsafe {
                    let u = *(ptr.add(offset) as *const usize);
                    let v = *(ptr.add(offset + USIZE_BYTES) as *const usize);

                    // break if there is a matching byte
                    let zu = contains_zero_byte(u ^ repeated_x);
                    let zv = contains_zero_byte(v ^ repeated_x);
                    if zu || zv {
                        break;
                    }
                }
                offset += USIZE_BYTES * 2;
            }

            // Find the byte after the point the body loop stopped.
            // FIXME(const-hack): Use `?` instead.
            // FIXME(const-hack, fee1-dead): use range slicing
            let slice =
            // SAFETY: offset is within bounds
                unsafe { super::from_raw_parts(text.as_ptr().add(offset), text.len() - offset) };
            if let Some(i) = memchr_naive(x, slice) { Some(offset + i) } else { None }
        }
    )
}

/// Returns the last index matching the byte `x` in `text`.
#[must_use]
pub fn memrchr(x: u8, text: &[u8]) -> Option<usize> {
    // Scan for a single byte value by reading two `usize` words at a time.
    //
    // Split `text` in three parts:
    // - unaligned tail, after the last word aligned address in text,
    // - body, scanned by 2 words at a time,
    // - the first remaining bytes, < 2 word size.
    let len = text.len();
    let ptr = text.as_ptr();
    type Chunk = usize;

    let (min_aligned_offset, max_aligned_offset) = {
        // We call this just to obtain the length of the prefix and suffix.
        // In the middle we always process two chunks at once.
        // SAFETY: transmuting `[u8]` to `[usize]` is safe except for size differences
        // which are handled by `align_to`.
        let (prefix, _, suffix) = unsafe { text.align_to::<(Chunk, Chunk)>() };
        (prefix.len(), len - suffix.len())
    };

    let mut offset = max_aligned_offset;
    if let Some(index) = text[offset..].iter().rposition(|elt| *elt == x) {
        return Some(offset + index);
    }

    // Search the body of the text, make sure we don't cross min_aligned_offset.
    // offset is always aligned, so just testing `>` is sufficient and avoids possible
    // overflow.
    let repeated_x = usize::repeat_u8(x);
    let chunk_bytes = size_of::<Chunk>();

    while offset > min_aligned_offset {
        // SAFETY: offset starts at len - suffix.len(), as long as it is greater than
        // min_aligned_offset (prefix.len()) the remaining distance is at least 2 * chunk_bytes.
        unsafe {
            let u = *(ptr.add(offset - 2 * chunk_bytes) as *const Chunk);
            let v = *(ptr.add(offset - chunk_bytes) as *const Chunk);

            // Break if there is a matching byte.
            let zu = contains_zero_byte(u ^ repeated_x);
            let zv = contains_zero_byte(v ^ repeated_x);
            if zu || zv {
                break;
            }
        }
        offset -= 2 * chunk_bytes;
    }

    // Find the byte before the point the body loop stopped.
    text[..offset].iter().rposition(|elt| *elt == x)
}

#[cfg(all(
    target_arch = "aarch64",
    target_feature = "neon",
    target_endian = "little",
    target_pointer_width = "64"
))]
fn matching_nibbles(needle: u8, block: &[u8]) -> u64 {
    use crate::simd::cmp::SimdPartialEq;
    use crate::simd::num::SimdUint;
    use crate::simd::{u8x16, u16x8};

    let mask = u8x16::from_slice(block).simd_eq(u8x16::splat(needle));
    // SAFETY: Both vectors contain 16 initialized bytes; all u16 lane values are valid.
    let pairs: u16x8 = unsafe { crate::mem::transmute(mask.to_simd()) };
    let packed = (pairs >> u16x8::splat(4)).cast::<u8>();
    u64::from_le_bytes(packed.to_array())
}

#[cfg(all(
    target_arch = "aarch64",
    target_feature = "neon",
    target_endian = "little",
    target_pointer_width = "64"
))]
#[rustc_allow_const_fn_unstable(const_eval_select)]
const fn memchr_aligned(x: u8, text: &[u8]) -> Option<usize> {
    const_eval_select!(
        @capture { x: u8, text: &[u8] } -> Option<usize>:
        if const {
            memchr_naive(x, text)
        } else {
            // SAFETY: memchr checks for two words before calling this runtime path.
            unsafe { crate::hint::assert_unchecked(text.len() >= 16) };
            let len = text.len();
            let ptr = text.as_ptr();
            let mut offset = ptr.align_offset(USIZE_BYTES);
            if offset > 0 {
                offset = offset.min(len);
                if let Some(index) = memchr_naive(x, &text[..offset]) {
                    return Some(index);
                }
            }
            if len - offset < 16 {
                // SAFETY: the alignment prefix never exceeds len.
                let tail = unsafe { super::from_raw_parts(ptr.add(offset), len - offset) };
                return memchr_naive(x, tail).map(|i| offset + i);
            }
            let repeated_x = usize::repeat_u8(x);
            macro_rules! scan_words {
                ($pointer:expr, $index:expr) => {{
                    let pointer = $pointer.cast::<usize>();
                    // SAFETY: each call has a word-aligned, readable 16-byte block.
                    let (a, b) = unsafe { (*pointer, *pointer.add(1)) };
                    let found = contains_zero_byte(a ^ repeated_x)
                        || contains_zero_byte(b ^ repeated_x);
                    if found {
                        // SAFETY: the checked word block starts at this in-bounds index.
                        let tail = unsafe {
                            super::from_raw_parts(ptr.add($index), len - $index)
                        };
                        return memchr_naive(x, tail).map(|i| $index + i);
                    }
                }};
            }
            macro_rules! peel_words {
                () => {{
                    // SAFETY: the preceding range check covers this aligned block.
                    scan_words!(unsafe { ptr.add(offset) }, offset);
                    offset += 16;
                    if len - offset < 16 {
                        // SAFETY: the scanned block ends within the slice.
                        let tail = unsafe { super::from_raw_parts(ptr.add(offset), len - offset) };
                        return memchr_naive(x, tail).map(|i| offset + i);
                    }
                }};
            }
            peel_words!();
            peel_words!();
            peel_words!();
            peel_words!();

            // SAFETY: the peeled blocks and their range checks keep offset in bounds.
            let rest = unsafe { super::from_raw_parts(ptr.add(offset), len - offset) };
            let mut chunks = rest.chunks_exact(64);
            for block in &mut chunks {
                let a = matching_nibbles(x, &block[..16]);
                let b = matching_nibbles(x, &block[16..32]);
                let c = matching_nibbles(x, &block[32..48]);
                let d = matching_nibbles(x, &block[48..]);
                if a | b | c | d != 0 {
                    let (bits, start) = if a != 0 {
                        (a, offset)
                    } else if b != 0 {
                        (b, offset + 16)
                    } else if c != 0 {
                        (c, offset + 32)
                    } else {
                        (d, offset + 48)
                    };
                    return Some(start + bits.trailing_zeros() as usize / 4);
                }
                offset += 64;
            }
            let mut tail = chunks.remainder().chunks_exact(16);
            for block in &mut tail {
                scan_words!(block.as_ptr(), offset);
                offset += 16;
            }
            memchr_naive(x, tail.remainder()).map(|i| offset + i)
        }
    )
}
