//! UTF-8 validation with 16-byte vectors, used at run time on AArch64.
//!
//! This is the lookup algorithm from Keiser and Lemire, "Validating UTF-8 In Less Than One
//! Instruction Per Byte" (2020). Almost every UTF-8 error shows up in a byte and the one before
//! it, so for every byte we look up three 16-entry tables (one `tbl` each), indexed by the high
//! nibble of the previous byte, its low nibble, and the high nibble of the current byte. Each
//! entry has one bit per kind of error that is still possible given only that nibble, so the
//! bitwise AND of the three entries holds the errors that really occur.
//!
//! The vector code only decides *whether* a block is valid. When it is not, the scalar validator
//! is restarted a few bytes before the block and produces the exact [`Utf8Error`]. That keeps
//! `valid_up_to` and `error_len` identical to the scalar implementation by construction. The
//! scalar validator also checks everything after the restart point, so a block that is wrongly
//! reported as invalid only costs time, never correctness.

use super::validations::{run_utf8_validation, utf8_is_cont_byte};
use super::{Utf8Error, from_utf8_unchecked, from_utf8_unchecked_mut};
use crate::simd::num::SimdUint;
use crate::simd::{simd_swizzle, u8x16};

/// Shorter inputs are validated by the scalar implementation.
pub(super) const MIN_LEN: usize = 64;

// One bit per kind of error. `TOO_LARGE_1000` and `OVERLONG_4` share a bit: they need different
// low nibbles in the previous byte, so they never apply at the same time.
const TOO_SHORT: u8 = 1 << 0; // a lead byte followed by a non-continuation byte: C2 41
const TOO_LONG: u8 = 1 << 1; // an ASCII byte followed by a continuation byte: 41 80
const OVERLONG_3: u8 = 1 << 2; // E0 followed by 80..9F
const TOO_LARGE: u8 = 1 << 3; // F4 followed by 90..BF, or F5..FF followed by anything
const SURROGATE: u8 = 1 << 4; // ED followed by A0..BF
const OVERLONG_2: u8 = 1 << 5; // C0 or C1
const TOO_LARGE_1000: u8 = 1 << 6; // F5..FF followed by 80..8F
const OVERLONG_4: u8 = 1 << 6; // F0 followed by 80..8F
const TWO_CONTS: u8 = 1 << 7; // two continuation bytes in a row
const CARRY: u8 = TOO_SHORT | TOO_LONG | TWO_CONTS;

/// Indexed by the high nibble of the previous byte.
const PREV_HIGH_NIBBLE: [u8; 16] = [
    TOO_LONG,
    TOO_LONG,
    TOO_LONG,
    TOO_LONG,
    TOO_LONG,
    TOO_LONG,
    TOO_LONG,
    TOO_LONG,
    TWO_CONTS,
    TWO_CONTS,
    TWO_CONTS,
    TWO_CONTS,
    TOO_SHORT | OVERLONG_2,
    TOO_SHORT,
    TOO_SHORT | OVERLONG_3 | SURROGATE,
    TOO_SHORT | TOO_LARGE | TOO_LARGE_1000 | OVERLONG_4,
];

/// Indexed by the low nibble of the previous byte.
const PREV_LOW_NIBBLE: [u8; 16] = [
    CARRY | OVERLONG_3 | OVERLONG_2 | OVERLONG_4,
    CARRY | OVERLONG_2,
    CARRY,
    CARRY,
    CARRY | TOO_LARGE,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000 | SURROGATE,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
    CARRY | TOO_LARGE | TOO_LARGE_1000,
];

/// Indexed by the high nibble of the current byte.
const CURRENT_HIGH_NIBBLE: [u8; 16] = [
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
    TOO_LONG | OVERLONG_2 | TWO_CONTS | OVERLONG_3 | TOO_LARGE_1000 | OVERLONG_4,
    TOO_LONG | OVERLONG_2 | TWO_CONTS | OVERLONG_3 | TOO_LARGE,
    TOO_LONG | OVERLONG_2 | TWO_CONTS | SURROGATE | TOO_LARGE,
    TOO_LONG | OVERLONG_2 | TWO_CONTS | SURROGATE | TOO_LARGE,
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
    TOO_SHORT,
];

/// Lane indices for `simd_swizzle!(prev, input, lanes_back(n))`, which yields `prev[16 - n..]`
/// followed by `input[..16 - n]`: lane `i` holds the byte `n` positions before `input[i]`.
const fn lanes_back(n: usize) -> [usize; 16] {
    let mut lanes = [0; 16];
    let mut i = 0;
    while i < 16 {
        lanes[i] = 16 - n + i;
        i += 1;
    }
    lanes
}

fn load(v: &[u8], at: usize) -> u8x16 {
    u8x16::from_slice(&v[at..at + 16])
}

/// One flag per kind of error for each of the 16 bytes of `input`, given the 16 bytes `prev` that
/// precede them. A lane is zero if the byte in it is valid.
fn error_flags(input: u8x16, prev: u8x16) -> u8x16 {
    // For each byte of `input`, the bytes 1, 2 and 3 positions before it (`ext` on AArch64).
    let prev1 = simd_swizzle!(prev, input, lanes_back(1));
    let prev2 = simd_swizzle!(prev, input, lanes_back(2));
    let prev3 = simd_swizzle!(prev, input, lanes_back(3));

    // The indices are below 16, so these are lookups in a 16-entry table, i.e. `tbl`.
    let pair = u8x16::from_array(PREV_HIGH_NIBBLE).swizzle_dyn(prev1 >> 4)
        & u8x16::from_array(PREV_LOW_NIBBLE).swizzle_dyn(prev1 & u8x16::splat(0xF))
        & u8x16::from_array(CURRENT_HIGH_NIBBLE).swizzle_dyn(input >> 4);

    // The third byte of a three-byte character and the third and fourth of a four-byte one are
    // continuation bytes that follow a continuation byte, so `pair` reports `TWO_CONTS` there.
    // That is correct exactly where `prev2` is a lead byte of at least three bytes (E0..) or
    // `prev3` of four (F0..). `saturating_sub` leaves the top bit set only in that case.
    let must_be_cont = (prev2.saturating_sub(u8x16::splat(0xE0 - 0x80))
        | prev3.saturating_sub(u8x16::splat(0xF0 - 0x80)))
        & u8x16::splat(0x80);

    // Where the two disagree, a continuation byte is missing or in excess.
    must_be_cont ^ pair
}

/// Whether the 64 bytes at `at` are all ASCII.
fn block_is_ascii(v: &[u8], at: usize) -> bool {
    ((load(v, at) | load(v, at + 16)) | (load(v, at + 32) | load(v, at + 48))).reduce_max() < 0x80
}

/// Whether `bytes` ends in the middle of a multi-byte character, if everything before is valid.
fn ends_mid_char(bytes: &[u8]) -> bool {
    let n = bytes.len();
    (n >= 1 && bytes[n - 1] >= 0xC0)
        || (n >= 2 && bytes[n - 2] >= 0xE0)
        || (n >= 3 && bytes[n - 3] >= 0xF0)
}

/// Whether the 16 bytes `x` at `at` are valid, given the 16 bytes before them in `prev`.
/// Everything before `at` must already be valid, except that it may end in a partial character.
fn vector_is_valid(v: &[u8], at: usize, x: u8x16, prev: u8x16) -> bool {
    if x.reduce_max() < 0x80 {
        // An ASCII vector can only be wrong if it cuts a character short.
        !ends_mid_char(&v[..at])
    } else {
        error_flags(x, prev).reduce_max() == 0
    }
}

/// Checks the 16-byte vectors from `from` to `to`, the last one ending at `to` (so it may overlap
/// the one before it), and returns the position of the first one that may contain an error.
#[inline]
fn find_invalid_vector(v: &[u8], from: usize, to: usize) -> Option<usize> {
    let mut pos = from;
    while pos < to {
        let at = if pos + 16 <= to { pos } else { to - 16 };
        let prev = if at == 0 { u8x16::splat(0) } else { load(v, at - 16) };
        if !vector_is_valid(v, at, load(v, at), prev) {
            return Some(at);
        }
        pos = at + 16;
    }
    None
}

/// Validates the rest of `v` with the scalar implementation, starting at the last character
/// boundary at or before `pos`. `pos` is where the vector code found, or could not rule out, an
/// error: a character that is cut off at `pos` starts at most three bytes earlier.
#[cold]
#[inline(never)]
fn validate_scalar_from(v: &[u8], pos: usize) -> Result<(), Utf8Error> {
    let mut start = pos;
    for distance in 1..=usize::min(3, pos) {
        if !utf8_is_cont_byte(v[pos - distance]) {
            start = pos - distance;
            break;
        }
    }
    match run_utf8_validation(&v[start..]) {
        Ok(()) => Ok(()),
        Err(e) => Err(Utf8Error { valid_up_to: start + e.valid_up_to, error_len: e.error_len }),
    }
}

/// [`str::from_utf8`] for inputs of at least [`MIN_LEN`] bytes.
pub(super) fn from_utf8(v: &[u8]) -> Result<&str, Utf8Error> {
    match validate(v) {
        // SAFETY: validation succeeded.
        Ok(()) => Ok(unsafe { from_utf8_unchecked(v) }),
        Err(err) => Err(err),
    }
}

/// [`str::from_utf8_mut`] for inputs of at least [`MIN_LEN`] bytes.
pub(super) fn from_utf8_mut(v: &mut [u8]) -> Result<&mut str, Utf8Error> {
    match validate(v) {
        // SAFETY: validation succeeded.
        Ok(()) => Ok(unsafe { from_utf8_unchecked_mut(v) }),
        Err(err) => Err(err),
    }
}

// Without `always`, LLVM keeps one out-of-line copy for the two callers and adds a call.
#[inline(always)]
fn validate(v: &[u8]) -> Result<(), Utf8Error> {
    let n = v.len();
    debug_assert!(n >= MIN_LEN);

    // The first 64 bytes, one vector at a time, so that an error near the start is found early.
    if !block_is_ascii(v, 0) {
        if let Some(at) = find_invalid_vector(v, 0, 64) {
            return validate_scalar_from(v, at);
        }
    }

    // The bulk, 64 bytes per iteration.
    let mut pos = 64;
    while pos + 64 <= n {
        if block_is_ascii(v, pos) {
            if ends_mid_char(&v[..pos]) {
                return validate_scalar_from(v, pos);
            }
        } else {
            let (a, b, c, d) =
                (load(v, pos), load(v, pos + 16), load(v, pos + 32), load(v, pos + 48));
            let e = [
                error_flags(a, load(v, pos - 16)),
                error_flags(b, a),
                error_flags(c, b),
                error_flags(d, c),
            ];
            if ((e[0] | e[1]) | (e[2] | e[3])).reduce_max() != 0 {
                let bad = e.iter().position(|x| x.reduce_max() != 0).unwrap_or(0);
                return validate_scalar_from(v, pos + 16 * bad);
            }
        }
        pos += 64;
    }

    // The tail, shorter than 64 bytes. The last 64 bytes of `v` overlap bytes that are already
    // known to be valid; if they are all ASCII, only a character cut off at `pos` can be wrong.
    if pos < n {
        if block_is_ascii(v, n - 64) {
            if ends_mid_char(&v[..pos]) {
                return validate_scalar_from(v, pos);
            }
        } else if let Some(at) = find_invalid_vector(v, pos, n) {
            return validate_scalar_from(v, at);
        }
    }
    if ends_mid_char(v) {
        return validate_scalar_from(v, n);
    }
    Ok(())
}
