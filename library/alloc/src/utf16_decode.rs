//! Decoding UTF-16 slices into UTF-8 (or WTF-8) bytes, shared by `String::from_utf16`,
//! `String::from_utf16_lossy` and `Wtf8Buf::from_wide`.
//!
//! The input is read in blocks of 16 units. A block that is all ASCII starts an ASCII run,
//! which is narrowed in chunks of 32 units. A block with surrogates is decoded one character
//! at a time. Any other block is encoded without branching on its content (see
//! `encode_block`).
//!
//! Note: This module is also included in the alloctests crate using #[path], because
//! `wtf8` (which alloctests includes the same way) depends on it.

use core::hint::select_unpredictable;
use core::mem::MaybeUninit;

use crate::vec::Vec;

/// Units per block.
const BLOCK: usize = 16;

/// Appends `v`, decoded from UTF-16, to `out` as UTF-8.
///
/// `on_unpaired(unit)` is called, in order, for every unpaired surrogate. It returns the unit
/// to write in its place, which may be the surrogate itself (written as WTF-8), or `Err(())`
/// to stop. Surrogate pairs are always combined; this matches `char::decode_utf16`.
#[inline]
pub(crate) fn decode_utf16_into(
    v: &[u16],
    out: &mut Vec<u8>,
    mut on_unpaired: impl FnMut(u16) -> Result<u16, ()>,
) -> Result<(), ()> {
    // `out`'s buffer, length and capacity are kept in locals, and written back only when
    // `out` is used: storing the length and loading it again for the next block stalls on
    // store-to-load forwarding.
    let mut buf = out.as_mut_ptr();
    let mut len = out.len();
    let mut cap = out.capacity();
    let mut i = 0;
    while let Some(units) = v.get(i..i + BLOCK) {
        let units: &[u16; BLOCK] = units.try_into().unwrap();
        let mut max = 0;
        let mut surrogates = false;
        for &u in units {
            max = max.max(u);
            surrogates |= (u & 0xF800) == 0xD800;
        }
        if max < 0x80 {
            let rest = &v[i..];
            if cap - len < rest.len() {
                // SAFETY: the first `len` bytes are initialized.
                (buf, cap) = unsafe { grow(out, len, rest.len()) };
            }
            // SAFETY: there is room for `rest.len()` bytes, one per ASCII unit, and only the
            // returned prefix, which is ASCII, is added to the length.
            let n = unsafe { ascii_prefix(rest, buf.add(len)) };
            len += n;
            i += n;
        } else if surrogates {
            // SAFETY: the first `len` bytes are initialized.
            unsafe { out.set_len(len) };
            i = decode_scalar(v, i, i + BLOCK, out, &mut on_unpaired)?;
            (buf, len, cap) = (out.as_mut_ptr(), out.len(), out.capacity());
        } else {
            if cap - len < ENCODE_BLOCK_LEN {
                // SAFETY: the first `len` bytes are initialized.
                (buf, cap) = unsafe { grow(out, len, v.len() - i + ENCODE_BLOCK_LEN) };
            }
            // SAFETY: there is room for `ENCODE_BLOCK_LEN` bytes.
            len += unsafe { encode_block(units, buf.add(len)) };
            i += BLOCK;
        }
    }
    // SAFETY: the first `len` bytes are initialized.
    unsafe { out.set_len(len) };
    decode_scalar(v, i, v.len(), out, &mut on_unpaired)?;
    Ok(())
}

/// Writes the longest prefix of `src` made of ASCII code units to `dst`, one byte per
/// unit, and returns its length.
///
/// # Safety
/// `dst` must be valid for writes of `src.len()` bytes.
#[inline(never)]
unsafe fn ascii_prefix(src: &[u16], dst: *mut u8) -> usize {
    // Written for the auto-vectorizer: narrow the whole chunk into `dst` unconditionally
    // while max-reducing, and only then decide. A `max` reduction vectorizes (`umaxv` on
    // AArch64); the equivalent `|` reduction is left scalar.
    const CHUNK: usize = 32;
    let mut i = 0;
    while i + CHUNK <= src.len() {
        // SAFETY: `i + CHUNK <= src.len()`, and the caller guarantees `dst` has room for
        // `src.len()` bytes. Bytes written past the returned prefix are never read.
        let (units, bytes) = unsafe {
            (
                &*(src.as_ptr().add(i) as *const [u16; CHUNK]),
                &mut *(dst.add(i) as *mut [MaybeUninit<u8>; CHUNK]),
            )
        };
        let mut max = 0u16;
        for k in 0..CHUNK {
            bytes[k].write(units[k] as u8);
            max = max.max(units[k]);
        }
        if max >= 0x80 {
            break;
        }
        i += CHUNK;
    }
    while i < src.len() && src[i] < 0x80 {
        // SAFETY: `i < src.len()`, and `dst` has room for `src.len()` bytes.
        unsafe { *dst.add(i) = src[i] as u8 };
        i += 1;
    }
    i
}

/// Sets the length of `out` to `len`, reserves `additional` bytes after it, and returns the
/// new buffer and capacity.
///
/// # Safety
/// The first `len` bytes of `out`'s buffer must be initialized.
#[cold]
unsafe fn grow(out: &mut Vec<u8>, len: usize, additional: usize) -> (*mut u8, usize) {
    // SAFETY: the caller guarantees that the first `len` bytes are initialized.
    unsafe { out.set_len(len) };
    out.reserve(additional);
    (out.as_mut_ptr(), out.capacity())
}

/// Decodes from `i` until at least `end`, one character at a time, with no assumption about
/// the units, and returns where it stopped: a surrogate pair may take it one unit past `end`.
#[inline(always)]
fn decode_scalar(
    v: &[u16],
    mut i: usize,
    end: usize,
    out: &mut Vec<u8>,
    on_unpaired: &mut impl FnMut(u16) -> Result<u16, ()>,
) -> Result<usize, ()> {
    // As in `decode_utf16_into`, `out`'s fields are kept in locals.
    let mut buf = out.as_mut_ptr();
    let mut len = out.len();
    let mut cap = out.capacity();
    while i < end {
        if cap - len < 4 {
            // SAFETY: the first `len` bytes are initialized.
            (buf, cap) = unsafe { grow(out, len, 4) };
        }
        let u = v[i];
        // The encoding in the low bytes of a `u32`, in memory order, and its length.
        let (word, n) = if (u & 0xF800) != 0xD800 {
            i += 1;
            encode_bmp(u)
        } else if u < 0xDC00 && i + 1 < v.len() && (v[i + 1] & 0xFC00) == 0xDC00 {
            let c = 0x10000 + (((u as u32) & 0x3FF) << 10) + ((v[i + 1] as u32) & 0x3FF);
            i += 2;
            let cont = |shift: u32| 0x80 | (c >> shift & 0x3F);
            ((0xF0 | c >> 18) | cont(12) << 8 | cont(6) << 16 | cont(0) << 24, 4)
        } else {
            i += 1;
            let Ok(unit) = on_unpaired(u) else {
                // SAFETY: the first `len` bytes are initialized.
                unsafe { out.set_len(len) };
                return Err(());
            };
            encode_bmp(unit)
        };
        // SAFETY: there is room for 4 bytes.
        unsafe { buf.add(len).cast::<u32>().write_unaligned(word.to_le()) };
        len += n;
    }
    // SAFETY: the first `len` bytes are initialized.
    unsafe { out.set_len(len) };
    Ok(i)
}

/// The UTF-8 encoding of `u` (WTF-8 if it is a surrogate) in the low bytes of a `u32` in memory
/// order (the first byte is the lowest), and its length. Without branches: lengths that vary
/// from one character to the next are not predictable, and LLVM would otherwise use branches
/// in some of the loops this is inlined into.
#[inline(always)]
fn encode_bmp(u: u16) -> (u32, usize) {
    let u = u as u32;
    let cont = |shift: u32| 0x80 | (u >> shift & 0x3F);
    let one = u;
    let two = (0xC0 | u >> 6) | cont(0) << 8;
    let three = (0xE0 | u >> 12) | cont(6) << 8 | cont(0) << 16;
    let word = select_unpredictable(u >= 0x800, three, select_unpredictable(u >= 0x80, two, one));
    (word, 1 + (u >= 0x80) as usize + (u >= 0x800) as usize)
}

/// The most bytes `encode_block` writes: 3 per unit, plus 1 past the last one.
const ENCODE_BLOCK_LEN: usize = 3 * BLOCK + 1;

/// Writes the UTF-8 encoding of 16 units that are not surrogates to `dst`, and returns its
/// length.
///
/// The first pass computes the encoding of every unit and its length, and vectorizes. The
/// second pass stores each encoding as four bytes right after the previous one, so the extra
/// bytes are overwritten by the next encoding or left past the length.
///
/// # Safety
/// `dst` must be valid for writes of `ENCODE_BLOCK_LEN` bytes.
#[inline(always)]
unsafe fn encode_block(units: &[u16; BLOCK], dst: *mut u8) -> usize {
    // Lengths as bytes, so that the first pass vectorizes.
    let mut words = [0u32; BLOCK];
    let mut lens = [0u8; BLOCK];
    for k in 0..BLOCK {
        let (word, n) = encode_bmp(units[k]);
        (words[k], lens[k]) = (word, n as u8);
    }
    let mut len = 0;
    for k in 0..BLOCK {
        // SAFETY: `len` is at most 3 per unit before this one, and the caller guarantees
        // room for `ENCODE_BLOCK_LEN` bytes.
        unsafe { dst.add(len).cast::<u32>().write_unaligned(words[k].to_le()) };
        len += lens[k] as usize;
    }
    len
}
