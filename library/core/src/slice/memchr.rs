// Original implementation taken from rust-memchr.
// Copyright 2015 Andrew Gallant, bluss and Nicolas Koch

use crate::intrinsics::const_eval_select;

const USIZE_BYTES: usize = size_of::<usize>();

/// Returns the first index matching the byte `x` in `text`.
#[inline]
#[must_use]
pub const fn memchr(x: u8, text: &[u8]) -> Option<usize> {
    // Fast path for small slices.
    let result =
        if text.len() < 2 * USIZE_BYTES { memchr_naive(x, text) } else { memchr_aligned(x, text) };
    if let Some(index) = result {
        // SAFETY: Both implementations only return an index from within `text`.
        unsafe { crate::hint::assert_unchecked(index < text.len()) };
    }
    result
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

#[rustc_allow_const_fn_unstable(const_eval_select)] // fallback impl has same behavior
const fn memchr_aligned(x: u8, text: &[u8]) -> Option<usize> {
    // The runtime version behaves the same as the compiletime version, it's
    // just more optimized.
    const_eval_select!(
        @capture { x: u8, text: &[u8] } -> Option<usize>:
        if const {
            memchr_naive(x, text)
        } else {
           memchr_raw(x, text)
        }
    )
}

/// Returns the last index matching the byte `x` in `text`.
#[inline]
#[must_use]
pub fn memrchr(x: u8, text: &[u8]) -> Option<usize> {
    let result = memrchr_raw(x, text);
    if let Some(index) = result {
        // SAFETY: `memrchr_aligned` only returns the index of a matching byte in `text`.
        unsafe { crate::hint::assert_unchecked(index < text.len()) };
    }
    result
}

/// Returns the first index matching the byte `x` in `text`.
#[inline]
fn memchr_raw(x: u8, text: &[u8]) -> Option<usize> {
    // SAFETY: memchr_plaftorm, when a match is found, always returns a valid
    // pointer between start and end.
    unsafe { search_slice_with_raw(text, |start, end| memchr_plaftorm(x, start, end)) }
}

/// Returns the last index matching the byte `x` in `text`.
#[inline]
fn memrchr_raw(x: u8, text: &[u8]) -> Option<usize> {
    // SAFETY: memrchr_plaftorm, when a match is found, always returns a valid
    // pointer between start and end.
    unsafe { search_slice_with_raw(text, |start, end| memrchr_plaftorm(x, start, end)) }
}

/// Searches `needle` in `start..end` with SIMD on specified platform, fallback to
/// SWAR if no SIMD implementation. Returns the pointer to the first needle if there is,
/// otherwise returns `None`.
///
/// # Safety
///
/// * It must be the case that `start < end`.
/// * `start..end` must point to an initialized range.
/// * Both `start` and `end` must point to the same allocated object and
/// must either be in bounds or at most one byte past the end of the
/// allocated object.
/// * Both `start` and `end` must be _derived from_ a pointer to the same
/// object.
/// * The distance between `start` and `end` must not overflow `isize`.
/// * The distance being in bounds must not rely on "wrapping around" the
/// address space.
#[inline]
unsafe fn memchr_plaftorm(needle: u8, start: *const u8, end: *const u8) -> Option<*const u8> {
    #[cfg(all(target_arch = "x86_64", target_feature = "sse2", not(target_feature = "avx2")))]
    type V = crate::arch::x86_64::__m128i;
    #[cfg(all(target_arch = "x86_64", target_feature = "avx2"))]
    type V = crate::arch::x86_64::__m256i;
    #[cfg(all(target_arch = "aarch64", target_feature = "neon"))]
    type V = crate::arch::aarch64::uint8x16_t;
    #[cfg(all(target_arch = "wasm32", target_feature = "simd128"))]
    type V = crate::arch::wasm32::v128;

    #[cfg(any(
        all(target_arch = "x86_64", target_feature = "sse2"),
        all(target_arch = "aarch64", target_feature = "neon"),
        all(target_arch = "wasm32", target_feature = "simd128")
    ))]
    type MEMCHR = simd::One<V>;

    #[cfg(not(any(
        all(target_arch = "x86_64", target_feature = "sse2"),
        all(target_arch = "aarch64", target_feature = "neon"),
        all(target_arch = "wasm32", target_feature = "simd128")
    )))]
    type MEMCHR = swar::One;

    // SAFETY: Platform dispatch enables the selected backend's target features.
    #[allow(unused_unsafe)]
    let one = unsafe { MEMCHR::new(needle) };
    // SAFETY: guaranteed by caller.
    unsafe { one.find_raw(start, end) }
}
/// Searches `needle` in `start..end` with SIMD on specified platform, fallback to
/// SWAR if no SIMD implementation. Returns the pointer to the last needle if there is,
/// otherwise returns `None`.
/// # Safety
///
/// * It must be the case that `start < end`.
/// * `start..end` must point to an initialized range.
/// * Both `start` and `end` must point to the same allocated object and
/// must either be in bounds or at most one byte past the end of the
/// allocated object.
/// * Both `start` and `end` must be _derived from_ a pointer to the same
/// object.
/// * The distance between `start` and `end` must not overflow `isize`.
/// * The distance being in bounds must not rely on "wrapping around" the
/// address space.
#[inline]
unsafe fn memrchr_plaftorm(needle: u8, start: *const u8, end: *const u8) -> Option<*const u8> {
    #[cfg(all(target_arch = "x86_64", target_feature = "sse2", not(target_feature = "avx2")))]
    type V = crate::arch::x86_64::__m128i;
    #[cfg(all(target_arch = "x86_64", target_feature = "avx2"))]
    type V = crate::arch::x86_64::__m256i;
    #[cfg(all(target_arch = "aarch64", target_feature = "neon"))]
    type V = crate::arch::aarch64::uint8x16_t;
    #[cfg(all(target_arch = "wasm32", target_feature = "simd128"))]
    type V = crate::arch::wasm32::v128;

    #[cfg(any(
        all(target_arch = "x86_64", target_feature = "sse2"),
        all(target_arch = "aarch64", target_feature = "neon"),
        all(target_arch = "wasm32", target_feature = "simd128")
    ))]
    type MEMRCHR = simd::One<V>;

    #[cfg(not(any(
        all(target_arch = "x86_64", target_feature = "sse2"),
        all(target_arch = "aarch64", target_feature = "neon"),
        all(target_arch = "wasm32", target_feature = "simd128")
    )))]
    type MEMRCHR = swar::One;

    // SAFETY: Platform dispatch enables the selected backend's target features.
    #[allow(unused_unsafe)]
    let one = unsafe { MEMRCHR::new(needle) };
    // SAFETY: guaranteed by caller.
    unsafe { one.rfind_raw(start, end) }
}

/// Search a slice using a function that operates on raw pointers.
///
/// Given a function to search a contiguous sequence of memory for the location
/// of a non-empty set of bytes, this will execute that search on a slice of
/// bytes. The pointer returned by the given function will be converted to an
/// offset relative to the starting point of the given slice. That is, if a
/// match is found, the offset returned by this routine is guaranteed to be a
/// valid index into `haystack`.
///
/// Callers may use this for a forward or reverse search.
///
/// # Safety
///
/// Callers must ensure that if a pointer is returned by `find_raw`, then the
/// pointer must be greater than or equal to the starting pointer and less than
/// the end pointer. The returned pointer must be derived from a pointer to
/// the same allocated object as `start` and `end`..
#[inline(always)]
unsafe fn search_slice_with_raw(
    haystack: &[u8],
    mut find_raw: impl FnMut(*const u8, *const u8) -> Option<*const u8>,
) -> Option<usize> {
    if haystack.is_empty() {
        return None;
    }

    let start = haystack.as_ptr();
    // SAFETY: `start` and `end` are valid due to the guarantees provided by
    // a &[u8]
    let end = unsafe { start.add(haystack.len()) };
    let found = find_raw(start, end)?;
    // SAFETY: guaranteed by caller.
    let idx = unsafe { found.offset_from_unsigned(start) };
    // Required by safety invariant required for find_raw
    // this lets the compiler know the returned index is in bounds for the slice
    if idx >= haystack.len() {
        // SAFETY: Both implementations only return an index from within `text`.
        unsafe { core::hint::unreachable_unchecked() };
    }
    Some(idx)
}

/// Performs a forward byte-at-a-time loop until either `ptr >= end` or
/// until `needle` is found. If the former occurs, then `None` is
/// returned. If the latter occurs, then the pointer at `needle` is returned.
///
/// # Safety
///
/// Callers must provide valid pointers and they must satisfy `start <= end`.
#[inline(always)]
unsafe fn fwd_byte_by_byte(start: *const u8, end: *const u8, needle: u8) -> Option<*const u8> {
    debug_assert!(start <= end);
    let mut ptr = start;
    while ptr < end {
        // SAFETY: `ptr` is within `start..end`.
        if needle == unsafe { *ptr } {
            return Some(ptr);
        }
        // SAFETY: `ptr <= end`
        ptr = unsafe { ptr.offset(1) };
    }
    None
}

/// Performs a reverse byte-at-a-time loop until either `ptr <= start` or
/// until `needle` is found. If the former occurs, then `None` is
/// returned. If the latter occurs, then the pointer at `needle` is returned.
///
/// # Safety
///
/// Callers must provide valid pointers and they must satisfy `start <= end`.
#[inline(always)]
unsafe fn rev_byte_by_byte(start: *const u8, end: *const u8, needle: u8) -> Option<*const u8> {
    debug_assert!(start <= end);

    let mut ptr = end;
    while ptr > start {
        // SAFETY: `ptr >= start`
        ptr = unsafe { ptr.offset(-1) };
        // SAFETY: `ptr` is within `start..end`.
        if needle == unsafe { *ptr } {
            return Some(ptr);
        }
    }
    None
}

#[cfg(any(
    all(target_arch = "x86_64", target_feature = "sse2"),
    all(target_arch = "aarch64", target_feature = "neon"),
    all(target_arch = "wasm32", target_feature = "simd128")
))]
mod simd {
    /// Finds all occurrences of a single byte in a haystack.
    #[derive(Clone, Copy, Debug)]
    pub(super) struct One<V> {
        v1: V,
        s1: u8,
    }

    impl<V: Vector> One<V> {
        /// The number of bytes we examine per each iteration of our search loop.
        const LOOP_SIZE: usize = 4 * V::BYTES;

        /// Create a new searcher that finds occurrences of the byte given.
        #[inline(always)]
        pub(super) unsafe fn new(needle: u8) -> One<V> {
            One {
                // SAFETY: Platform dispatch enables this backend's target features.
                v1: unsafe { V::splat(needle) },
                s1: needle,
            }
        }

        /// Return a pointer to the first occurrence of the needle in the given
        /// haystack. If no such occurrence exists, then `None` is returned.
        ///
        /// When a match is found, the pointer returned is guaranteed to be
        /// `>= start` and `< end`.
        ///
        /// # Safety
        ///
        /// * It must be the case that `start < end`.
        /// * `start..end` must point to an initialized range.
        /// * Both `start` and `end` must point to the same allocated object and
        /// must either be in bounds or at most one byte past the end of the
        /// allocated object.
        /// * Both `start` and `end` must be _derived from_ a pointer to the same
        /// object.
        /// * The distance between `start` and `end` must not overflow `isize`.
        /// * The distance being in bounds must not rely on "wrapping around" the
        /// address space.
        #[inline(always)]
        pub(super) unsafe fn find_raw(
            &self,
            start: *const u8,
            end: *const u8,
        ) -> Option<*const u8> {
            // If we want to support vectors bigger than 256 bits, we probably
            // need to move up to using a u64 for the masks used below. Currently
            // they are 32 bits, which means we're SOL for vectors that need masks
            // bigger than 32 bits. Overall unclear until there's a use case.
            debug_assert!(V::BYTES <= 32, "vector cannot be bigger than 32 bytes");

            let topos = <<V as Vector>::Eq as CmpEq>::Mask::first_offset;
            // SAFETY: guaranteed by caller
            let len = unsafe { end.offset_from_unsigned(start) };
            if len < V::BYTES {
                // SAFETY: We require the caller to pass valid start/end pointers.
                return unsafe { super::fwd_byte_by_byte(start, end, self.s1) };
            }
            debug_assert!(
                len >= V::BYTES,
                "haystack has length {}, but must be at least {}",
                len,
                V::BYTES
            );

            // Search a possibly unaligned chunk at `start`. This covers any part
            // of the haystack prior to where aligned loads can start.
            //
            // SAFETY: There are `V::Bytes` elements at least.
            if let Some(cur) = unsafe { self.search_chunk(start, topos) } {
                return Some(cur);
            }
            // Set `cur` to the first V-aligned pointer greater than `start`.
            //
            // SAFETY: `BYTES - (start & ALIGN)` is in `1..=BYTES`,
            // and the preceding length check guarantees that at least `BYTES`
            // bytes remain from `start`.
            let mut cur = unsafe { start.add(V::BYTES - (start.addr() & V::ALIGN)) };
            // SAFETY: `len >= BYTES`.
            debug_assert!(cur > start && unsafe { end.sub(V::BYTES) } >= start);
            if len >= Self::LOOP_SIZE {
                // SAFETY: `len >= LOOP_SIZE`.
                while cur <= unsafe { end.sub(Self::LOOP_SIZE) } {
                    debug_assert_eq!(0, cur.addr() % V::BYTES);
                    // SAFETY: `cur` is V-aligned, and the loop condition guarantees
                    // that the entire LOOP_SIZE-byte chunk is readable.
                    let (a, b, c, d) = unsafe {
                        (
                            V::load_aligned(cur),
                            V::load_aligned(cur.add(1 * V::BYTES)),
                            V::load_aligned(cur.add(2 * V::BYTES)),
                            V::load_aligned(cur.add(3 * V::BYTES)),
                        )
                    };
                    // SAFETY: Platform dispatch guarantees that the target features required
                    // by this vector backend are enabled.
                    let (eqa, eqb, eqc, eqd, has_match) = unsafe {
                        let eqa = self.v1.cmpeq(a);
                        let eqb = self.v1.cmpeq(b);
                        let eqc = self.v1.cmpeq(c);
                        let eqd = self.v1.cmpeq(d);
                        let or1 = eqa.or(eqb);
                        let or2 = eqc.or(eqd);
                        let or3 = or1.or(or2);
                        (eqa, eqb, eqc, eqd, or3.movemask_will_have_non_zero())
                    };

                    if has_match {
                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqa.movemask() };
                        if mask.has_non_zero() {
                            // SAFETY: The nonzero mask gives an offset less than V::BYTES.
                            return Some(unsafe { cur.add(topos(mask)) });
                        }
                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqb.movemask() };
                        if mask.has_non_zero() {
                            // SAFETY: The nonzero mask gives an offset less than V::BYTES.
                            return Some(unsafe { cur.add(1 * V::BYTES).add(topos(mask)) });
                        }
                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqc.movemask() };
                        if mask.has_non_zero() {
                            // SAFETY: The nonzero mask gives an offset less than V::BYTES.
                            return Some(unsafe { cur.add(2 * V::BYTES).add(topos(mask)) });
                        }
                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqd.movemask() };
                        // The combined result contains a match, and the first three
                        // masks are zero, so the fourth mask must contain a match.
                        debug_assert!(mask.has_non_zero());
                        // SAFETY: The nonzero mask gives an offset less than V::BYTES.
                        return Some(unsafe { cur.add(3 * V::BYTES).add(topos(mask)) });
                    }
                    // SAFETY: The loop condition guarantees cur + LOOP_SIZE <= end.
                    cur = unsafe { cur.add(Self::LOOP_SIZE) };
                }
            }
            // Handle any leftovers after the aligned loop above. We use unaligned
            // loads here, but I believe we are guaranteed that they are aligned
            // since `cur` is aligned.
            //
            // SAFETY: `BYTES <= end - cur < LOOP_SIZE`.
            while cur <= unsafe { end.sub(V::BYTES) } {
                // SAFETY: `end >= cur + BYTES`.
                debug_assert!(unsafe { end.offset_from_unsigned(cur) } >= V::BYTES);
                // SAFETY: `end >= cur + BYTES`.
                if let Some(cur) = unsafe { self.search_chunk(cur, topos) } {
                    return Some(cur);
                }
                // SAFETY: `cur + BYTES <= end`
                cur = unsafe { cur.add(V::BYTES) };
            }
            // Finally handle any remaining bytes less than the size of V. In this
            // case, our pointer may indeed be unaligned and the load may overlap
            // with the previous one. But that's okay since we know the previous
            // load didn't lead to a match (otherwise we wouldn't be here).
            if cur < end {
                // SAFETY: `cur < end`.
                debug_assert!(unsafe { end.offset_from_unsigned(cur) } < V::BYTES);
                // SAFETY: `end - cur < BYTES`
                cur = unsafe { cur.sub(V::BYTES - end.offset_from_unsigned(cur)) };
                // SAFETY: `cur + BYTES = end` at the time.
                debug_assert_eq!(unsafe { end.offset_from_unsigned(cur) }, V::BYTES);
                // SAFETY: guaranteed above.
                return unsafe { self.search_chunk(cur, topos) };
            }
            None
        }

        /// Return a pointer to the last occurrence of the needle in the given
        /// haystack. If no such occurrence exists, then `None` is returned.
        ///
        /// When a match is found, the pointer returned is guaranteed to be
        /// `>= start` and `< end`.
        ///
        /// # Safety
        ///
        /// * It must be the case that `start < end`.
        /// * `start..end` must point to an initialized range.
        /// * Both `start` and `end` must point to the same allocated object and
        /// must either be in bounds or at most one byte past the end of the
        /// allocated object.
        /// * Both `start` and `end` must be _derived from_ a pointer to the same
        /// object.
        /// * The distance between `start` and `end` must not overflow `isize`.
        /// * The distance being in bounds must not rely on "wrapping around" the
        /// address space.
        #[inline(always)]
        pub(super) unsafe fn rfind_raw(
            &self,
            start: *const u8,
            end: *const u8,
        ) -> Option<*const u8> {
            // If we want to support vectors bigger than 256 bits, we probably
            // need to move up to using a u64 for the masks used below. Currently
            // they are 32 bits, which means we're SOL for vectors that need masks
            // bigger than 32 bits. Overall unclear until there's a use case.
            debug_assert!(V::BYTES <= 32, "vector cannot be bigger than 32 bytes");

            let topos = <<V as Vector>::Eq as CmpEq>::Mask::last_offset;
            // SAFETY: The caller guarantees ordered pointers into the same allocation.
            let len = unsafe { end.offset_from_unsigned(start) };
            if len < V::BYTES {
                // SAFETY: We require the caller to pass valid start/end pointers.
                return unsafe { super::rev_byte_by_byte(start, end, self.s1) };
            }
            debug_assert!(
                len >= V::BYTES,
                "haystack has length {}, but must be at least {}",
                len,
                V::BYTES
            );

            // SAFETY: There are `V::Bytes` elements at least.
            if let Some(cur) = unsafe { self.search_chunk(end.sub(V::BYTES), topos) } {
                return Some(cur);
            }
            // SAFETY: `end & ALIGN` is less than BYTES, and len >= BYTES,
            // so rounding `end` down stays within start..=end.
            let mut cur = unsafe { end.sub(end.addr() & V::ALIGN) };
            debug_assert!(start <= cur && cur <= end);
            if len >= Self::LOOP_SIZE {
                // SAFETY: `len >= LOOP_SIZE`.
                while cur >= unsafe { start.add(Self::LOOP_SIZE) } {
                    debug_assert_eq!(0, cur.addr() % V::BYTES);
                    // SAFETY: `cur >= start + LOOP_SIZE`
                    cur = unsafe { cur.sub(Self::LOOP_SIZE) };
                    // SAFETY: Subtracting `LOOP_SIZE` preserves V-alignment, and
                    // the loop condition guarantees that the whole chunk is readable.
                    let (a, b, c, d) = unsafe {
                        (
                            V::load_aligned(cur),
                            V::load_aligned(cur.add(1 * V::BYTES)),
                            V::load_aligned(cur.add(2 * V::BYTES)),
                            V::load_aligned(cur.add(3 * V::BYTES)),
                        )
                    };
                    // SAFETY: Platform dispatch guarantees that the target features required
                    // by this vector backend are enabled.
                    let (eqa, eqb, eqc, eqd, has_match) = unsafe {
                        let eqa = self.v1.cmpeq(a);
                        let eqb = self.v1.cmpeq(b);
                        let eqc = self.v1.cmpeq(c);
                        let eqd = self.v1.cmpeq(d);
                        let or1 = eqa.or(eqb);
                        let or2 = eqc.or(eqd);
                        let or3 = or1.or(or2);
                        (eqa, eqb, eqc, eqd, or3.movemask_will_have_non_zero())
                    };
                    if has_match {
                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqd.movemask() };
                        if mask.has_non_zero() {
                            // SAFETY: The nonzero mask gives an offset within the fourth
                            // vector of the readable LOOP_SIZE-byte chunk.
                            return Some(unsafe { cur.add(3 * V::BYTES).add(topos(mask)) });
                        }

                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqc.movemask() };
                        if mask.has_non_zero() {
                            // SAFETY: The nonzero mask gives an offset within the third
                            // vector of the readable LOOP_SIZE-byte chunk.
                            return Some(unsafe { cur.add(2 * V::BYTES).add(topos(mask)) });
                        }

                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqb.movemask() };
                        if mask.has_non_zero() {
                            // SAFETY: The nonzero mask gives an offset within the second
                            // vector of the readable LOOP_SIZE-byte chunk.
                            return Some(unsafe { cur.add(1 * V::BYTES).add(topos(mask)) });
                        }

                        // SAFETY: Platform dispatch enables this backend's target features.
                        let mask = unsafe { eqa.movemask() };
                        // The combined result contains a match, and the last three
                        // masks are zero, so the first mask must contain a match.
                        debug_assert!(mask.has_non_zero());
                        // SAFETY: The nonzero mask gives an offset within the first
                        // vector of the readable LOOP_SIZE-byte chunk.
                        return Some(unsafe { cur.add(topos(mask)) });
                    }
                }
            }
            // SAFETY: `BYTES <= cur - start < LOOP_SIZE`.
            while cur >= unsafe { start.add(V::BYTES) } {
                // SAFETY: `cur >= start + BYTES`.
                debug_assert!(unsafe { cur.offset_from_unsigned(start) } >= V::BYTES);
                // SAFETY: `cur >= start + BYTES`.
                cur = unsafe { cur.sub(V::BYTES) };
                // SAFETY: It remains `BYTES` elements from `cur` at least.
                if let Some(cur) = unsafe { self.search_chunk(cur, topos) } {
                    return Some(cur);
                }
            }
            if cur > start {
                // SAFETY: `cur > start`.
                debug_assert!(unsafe { cur.offset_from_unsigned(start) } < V::BYTES);
                // SAFETY: `len >= BYTES`
                return unsafe { self.search_chunk(start, topos) };
            }
            None
        }

        /// Search `V::BYTES` starting at `cur` via an unaligned load.
        ///
        /// `mask_to_offset` should be a function that converts a `movemask` to
        /// an offset such that `cur.add(offset)` corresponds to a pointer to the
        /// match location if one is found. Generally it is expected to use either
        /// `mask_to_first_offset` or `mask_to_last_offset`, depending on whether
        /// one is implementing a forward or reverse search, respectively.
        ///
        /// # Safety
        ///
        /// `cur` must be a valid pointer and it must be valid to do an unaligned
        /// load of size `V::BYTES` at `cur`.
        /// For a nonzero mask, `mask_to_offset` must return an offset less than
        /// `V::BYTES`.
        #[inline(always)]
        unsafe fn search_chunk(
            &self,
            cur: *const u8,
            mask_to_offset: impl Fn(<<V as Vector>::Eq as CmpEq>::Mask) -> usize,
        ) -> Option<*const u8> {
            // SAFETY: guaranteed by caller
            let chunk = unsafe { V::load_unaligned(cur) };
            // SAFETY: Platform dispatch enables this backend's target features.
            let mask = unsafe { self.v1.cmpeq(chunk).movemask() };
            if mask.has_non_zero() {
                // SAFETY: The caller guarantees an offset within the readable vector
                // for a nonzero mask.
                Some(unsafe { cur.add(mask_to_offset(mask)) })
            } else {
                None
            }
        }
    }

    /// A trait for describing vector operations used by vectorized searchers.
    ///
    /// The trait is highly constrained to low level vector operations needed.
    /// In general, it was invented mostly to be generic over x86's __m128i and
    /// __m256i types. At time of writing, it also supports wasm and aarch64
    /// 128-bit vector types as well.
    ///
    /// # Safety
    ///
    /// All methods are not safe since they are intended to be implemented using
    /// vendor intrinsics, which are also not safe. Callers must ensure that the
    /// appropriate target features are enabled in the calling function, and that
    /// the current CPU supports them. All implementations should avoid marking the
    /// routines with #[target_feature] and instead mark them as #[inline(always)]
    /// to ensure they get appropriately inlined. (inline(always) cannot be used
    /// with target_feature.)
    pub(crate) trait Vector: Copy + core::fmt::Debug {
        /// The number of bytes in the vector. That is, this is the size of the
        /// vector in memory.
        const BYTES: usize;
        /// The bits that must be zero in order for a `*const u8` pointer to be
        /// correctly aligned to read vector values.
        const ALIGN: usize;

        /// The type of the value returned by `Vector::cmpeq`.
        ///
        /// This supports abstracting over comparisons. For SSE2 and AVX2,
        /// comparisons return vectors. But in AVX-512, comparisons return scalar
        /// masks directly. The latter avoids the need for a separate `movemask`
        /// operation.
        type Eq: CmpEq;

        /// Create a vector with 8-bit lanes with the given byte repeated into each
        /// lane.
        unsafe fn splat(byte: u8) -> Self;

        /// Read a vector-size number of bytes from the given pointer. The pointer
        /// must be aligned to the size of the vector.
        ///
        /// # Safety
        ///
        /// Callers must guarantee that at least `BYTES` bytes are readable from
        /// `data` and that `data` is aligned to a `BYTES` boundary.
        unsafe fn load_aligned(data: *const u8) -> Self;

        /// Read a vector-size number of bytes from the given pointer. The pointer
        /// does not need to be aligned.
        ///
        /// # Safety
        ///
        /// Callers must guarantee that at least `BYTES` bytes are readable from
        /// `data`.
        unsafe fn load_unaligned(data: *const u8) -> Self;

        /// _mm_cmpeq_epi8 or _mm256_cmpeq_epi8
        unsafe fn cmpeq(self, vector2: Self) -> Self::Eq;
    }

    pub(crate) trait CmpEq: Copy + core::fmt::Debug {
        /// The type of the value returned by `CmpEq::movemask`.
        ///
        /// This supports abstracting over the specific representation used in
        /// order to accommodate different representations in different ISAs.
        type Mask: MoveMask;

        /// _mm_movemask_epi8 or _mm256_movemask_epi8
        unsafe fn movemask(self) -> Self::Mask;

        /// _mm_or or _mm256_or_si256
        unsafe fn or(self, vector2: Self) -> Self;

        /// Returns true if and only if `Self::movemask` would return a mask that
        /// contains at least one non-zero bit.
        unsafe fn movemask_will_have_non_zero(self) -> bool {
            // SAFETY: Platform dispatch enables this backend's target features.
            unsafe { self.movemask() }.has_non_zero()
        }
    }

    /// A trait that abstracts over a vector-to-scalar operation called
    /// "move mask."
    ///
    /// On x86-64, this is `_mm_movemask_epi8` for SSE2 and `_mm256_movemask_epi8`
    /// for AVX2. It takes a vector of `u8` lanes and returns a scalar where the
    /// `i`th bit is set if and only if the most significant bit in the `i`th lane
    /// of the vector is set. The simd128 ISA for wasm32 also supports this
    /// exact same operation natively.
    ///
    /// ... But aarch64 doesn't. So we have to fake it with more instructions and
    /// a slightly different representation. We could do extra work to unify the
    /// representations, but then would require additional costs in the hot path
    /// for `memchr` and `packedpair`. So instead, we abstraction over the specific
    /// representation with this trait and define the operations we actually need.
    pub(crate) trait MoveMask: Copy + core::fmt::Debug {
        /// Returns true if and only if this mask has a a non-zero bit anywhere.
        fn has_non_zero(self) -> bool;

        /// Returns the offset of the first non-zero lane this mask represents.
        fn first_offset(self) -> usize;

        /// Returns the offset of the last non-zero lane this mask represents.
        fn last_offset(self) -> usize;
    }

    /// This is a "sensible" movemask implementation where each bit represents
    /// whether the most significant bit is set in each corresponding lane of a
    /// vector. This is used on x86-64 and wasm, but such a mask is more expensive
    /// to get on aarch64 so we use something a little different.
    ///
    /// We call this "sensible" because this is what we get using native sse/avx
    /// movemask instructions. But neon has no such native equivalent.
    #[derive(Clone, Copy, Debug)]
    pub(crate) struct SensibleMoveMask(u32);

    impl SensibleMoveMask {
        /// Get the mask in a form suitable for computing offsets.
        ///
        /// Basically, this normalizes to little endian. On big endian, this swaps
        /// the bytes.
        #[inline(always)]
        fn get_for_offset(self) -> u32 {
            #[cfg(target_endian = "big")]
            {
                self.0.swap_bytes()
            }
            #[cfg(target_endian = "little")]
            {
                self.0
            }
        }
    }

    impl MoveMask for SensibleMoveMask {
        #[inline(always)]
        fn has_non_zero(self) -> bool {
            self.0 != 0
        }

        #[inline(always)]
        fn first_offset(self) -> usize {
            // We are dealing with little endian here (and if we aren't, we swap
            // the bytes so we are in practice), where the most significant byte
            // is at a higher address. That means the least significant bit that
            // is set corresponds to the position of our first matching byte.
            // That position corresponds to the number of zeros after the least
            // significant bit.
            self.get_for_offset().trailing_zeros() as usize
        }

        #[inline(always)]
        fn last_offset(self) -> usize {
            // We are dealing with little endian here (and if we aren't, we swap
            // the bytes so we are in practice), where the most significant byte is
            // at a higher address. That means the most significant bit that is set
            // corresponds to the position of our last matching byte. The position
            // from the end of the mask is therefore the number of leading zeros
            // in a 32 bit integer, and the position from the start of the mask is
            // therefore 32 - (leading zeros) - 1.
            32 - self.get_for_offset().leading_zeros() as usize - 1
        }
    }

    #[cfg(all(target_arch = "x86_64", target_feature = "sse2", not(target_feature = "avx2")))]
    mod x86sse2 {
        use super::{CmpEq, SensibleMoveMask, Vector};
        use crate::arch::x86_64::*;

        impl Vector for __m128i {
            const BYTES: usize = 16;
            const ALIGN: usize = Self::BYTES - 1;

            type Eq = __m128i;

            #[inline(always)]
            unsafe fn splat(byte: u8) -> __m128i {
                // SAFETY: Enabled under `sse2`.
                unsafe { _mm_set1_epi8(byte as i8) }
            }

            #[inline(always)]
            unsafe fn load_aligned(data: *const u8) -> __m128i {
                // SAFETY: guaranteed by caller.
                unsafe { _mm_load_si128(data as *const __m128i) }
            }

            #[inline(always)]
            unsafe fn load_unaligned(data: *const u8) -> __m128i {
                // SAFETY: guaranteed by caller.
                unsafe { _mm_loadu_si128(data as *const __m128i) }
            }

            #[inline(always)]
            unsafe fn cmpeq(self, vector2: Self) -> __m128i {
                // SAFETY: Enabled under `sse2`.
                unsafe { _mm_cmpeq_epi8(self, vector2) }
            }
        }

        impl CmpEq for __m128i {
            type Mask = SensibleMoveMask;

            #[inline(always)]
            unsafe fn movemask(self) -> SensibleMoveMask {
                // SAFETY: Enabled under `sse2`.
                SensibleMoveMask(unsafe { _mm_movemask_epi8(self) as u32 })
            }

            #[inline(always)]
            unsafe fn or(self, vector2: Self) -> __m128i {
                // SAFETY: Enabled under `sse2`.
                unsafe { _mm_or_si128(self, vector2) }
            }
        }
    }

    #[cfg(all(target_arch = "x86_64", target_feature = "avx2"))]
    mod x86avx2 {
        use super::{CmpEq, SensibleMoveMask, Vector};
        use crate::arch::x86_64::*;

        impl Vector for __m256i {
            const BYTES: usize = 32;
            const ALIGN: usize = Self::BYTES - 1;

            type Eq = __m256i;

            #[inline(always)]
            unsafe fn splat(byte: u8) -> __m256i {
                // SAFETY: Enabled under `avx2`.
                unsafe { _mm256_set1_epi8(byte as i8) }
            }

            #[inline(always)]
            unsafe fn load_aligned(data: *const u8) -> __m256i {
                // SAFETY: guaranteed by caller.
                unsafe { _mm256_load_si256(data as *const __m256i) }
            }

            #[inline(always)]
            unsafe fn load_unaligned(data: *const u8) -> __m256i {
                // SAFETY: guaranteed by caller.
                unsafe { _mm256_loadu_si256(data as *const __m256i) }
            }

            #[inline(always)]
            unsafe fn cmpeq(self, vector2: Self) -> __m256i {
                // SAFETY: Enabled under `avx2`.
                unsafe { _mm256_cmpeq_epi8(self, vector2) }
            }
        }

        impl CmpEq for __m256i {
            type Mask = SensibleMoveMask;

            #[inline(always)]
            unsafe fn movemask(self) -> SensibleMoveMask {
                // SAFETY: Enabled under `avx2`.
                SensibleMoveMask(unsafe { _mm256_movemask_epi8(self) } as u32)
            }

            #[inline(always)]
            unsafe fn or(self, vector2: Self) -> __m256i {
                // SAFETY: Enabled under `avx2`.
                unsafe { _mm256_or_si256(self, vector2) }
            }
        }
    }

    #[cfg(all(target_arch = "aarch64", target_feature = "neon"))]
    mod aarch64neon {
        use super::{CmpEq, MoveMask, Vector};
        use crate::arch::aarch64::*;

        impl Vector for uint8x16_t {
            const BYTES: usize = 16;
            const ALIGN: usize = Self::BYTES - 1;

            type Eq = uint8x16_t;

            #[inline(always)]
            unsafe fn splat(byte: u8) -> uint8x16_t {
                // SAFETY: Enabled under `neon`.
                unsafe { vdupq_n_u8(byte) }
            }

            #[inline(always)]
            unsafe fn load_aligned(data: *const u8) -> uint8x16_t {
                // I've tried `data.cast::<uint8x16_t>().read()` instead, but
                // couldn't observe any benchmark differences.
                //
                // SAFETY: guaranteed by caller.
                unsafe { Self::load_unaligned(data) }
            }

            #[inline(always)]
            unsafe fn load_unaligned(data: *const u8) -> uint8x16_t {
                // SAFETY: guaranteed by caller.
                unsafe { vld1q_u8(data) }
            }

            #[inline(always)]
            unsafe fn cmpeq(self, vector2: Self) -> uint8x16_t {
                // SAFETY: Enabled under `neon`.
                unsafe { vceqq_u8(self, vector2) }
            }
        }

        impl CmpEq for uint8x16_t {
            type Mask = NeonMoveMask;

            #[inline(always)]
            #[cfg(target_endian = "little")]
            unsafe fn movemask(self) -> NeonMoveMask {
                // SAFETY: Enabled under `neon`.
                let asu16s = unsafe { vreinterpretq_u16_u8(self) };
                // SAFETY: Enabled under `neon`.
                let mask = unsafe { vshrn_n_u16::<4>(asu16s) };
                // SAFETY: Enabled under `neon`.
                let asu64 = unsafe { vreinterpret_u64_u8(mask) };
                // SAFETY: Enabled under `neon`.
                let scalar64 = unsafe { vget_lane_u64::<0>(asu64) };
                NeonMoveMask(scalar64 & 0x8888888888888888)
            }

            #[inline(always)]
            #[cfg(target_endian = "big")]
            unsafe fn movemask(self) -> NeonMoveMask {
                // Swap the endianness of each 16-bit input.
                //
                // SAFETY: Enabled under `neon`.
                let asu16s = unsafe { vreinterpretq_u16_u8(vrev16q_u8(self)) };
                // SAFETY: Enabled under `neon`.
                let mask = unsafe { vshrn_n_u16::<4>(asu16s) };
                // SAFETY: Enabled under `neon`.
                let asu64 = unsafe { vreinterpret_u64_u8(mask) };
                // Use `swap_bytes` to swap the endianness of the 64-bit output.
                //
                // SAFETY: Enabled under `neon`.
                let scalar64 = unsafe { vget_lane_u64::<0>(asu64) }.swap_bytes();
                NeonMoveMask(scalar64 & 0x8888888888888888)
            }

            #[inline(always)]
            unsafe fn or(self, vector2: Self) -> uint8x16_t {
                // SAFETY: Enabled under `neon`.
                unsafe { vorrq_u8(self, vector2) }
            }

            /// This is the only interesting implementation of this routine.
            /// Basically, instead of doing the "shift right narrow" dance, we use
            /// adjacent folding max to determine whether there are any non-zero
            /// bytes in our mask. If there are, *then* we'll do the "shift right
            /// narrow" dance. In benchmarks, this does lead to slightly better
            /// throughput, but the win doesn't appear huge.
            #[inline(always)]
            unsafe fn movemask_will_have_non_zero(self) -> bool {
                // SAFETY: Enabled under `neon`.
                let low = unsafe { vreinterpretq_u64_u8(vpmaxq_u8(self, self)) };
                // SAFETY: Enabled under `neon`.
                unsafe { vgetq_lane_u64::<0>(low) != 0 }
            }
        }

        /// Neon doesn't have a `movemask` that works like the one in x86-64, so we
        /// wind up using a different method[1]. The different method also produces
        /// a mask, but 4 bits are set in the neon case instead of a single bit set
        /// in the x86-64 case. We do an extra step to zero out 3 of the 4 bits,
        /// but we still wind up with at least 3 zeroes between each set bit. This
        /// generally means that we need to do some division by 4 before extracting
        /// offsets.
        ///
        /// In fact, the existence of this type is the entire reason that we have
        /// the `MoveMask` trait in the first place. This basically lets us keep
        /// the different representations of masks without being forced to unify
        /// them into a single representation, which could result in extra and
        /// unnecessary work.
        ///
        /// [1]: https://community.arm.com/arm-community-blogs/b/infrastructure-solutions-blog/posts/porting-x86-vector-bitmask-optimizations-to-arm-neon
        #[derive(Clone, Copy, Debug)]
        pub(crate) struct NeonMoveMask(u64);

        impl NeonMoveMask {
            /// Get the mask in a form suitable for computing offsets.
            ///
            /// The mask is always already in host-endianness, so this is a no-op.
            #[inline(always)]
            fn get_for_offset(self) -> u64 {
                self.0
            }
        }

        impl MoveMask for NeonMoveMask {
            #[inline(always)]
            fn has_non_zero(self) -> bool {
                self.0 != 0
            }

            #[inline(always)]
            fn first_offset(self) -> usize {
                // We are dealing with little endian here (and if we aren't,
                // we swap the bytes so we are in practice), where the most
                // significant byte is at a higher address. That means the least
                // significant bit that is set corresponds to the position of our
                // first matching byte. That position corresponds to the number of
                // zeros after the least significant bit.
                //
                // Note that unlike `SensibleMoveMask`, this mask has its bits
                // spread out over 64 bits instead of 16 bits (for a 128 bit
                // vector). Namely, where as x86-64 will turn
                //
                //   0x00 0xFF 0x00 0x00 0xFF
                //
                // into 10010, our neon approach will turn it into
                //
                //   10000000000010000000
                //
                // And this happens because neon doesn't have a native `movemask`
                // instruction, so we kind of fake it[1]. Thus, we divide the
                // number of trailing zeros by 4 to get the "real" offset.
                //
                // [1]: https://community.arm.com/arm-community-blogs/b/infrastructure-solutions-blog/posts/porting-x86-vector-bitmask-optimizations-to-arm-neon
                (self.get_for_offset().trailing_zeros() >> 2) as usize
            }

            #[inline(always)]
            fn last_offset(self) -> usize {
                // See comment in `first_offset` above. This is basically the same,
                // but coming from the other direction.
                16 - (self.get_for_offset().leading_zeros() >> 2) as usize - 1
            }
        }
    }

    #[cfg(all(target_arch = "wasm32", target_feature = "simd128"))]
    mod wasm_simd128 {
        use super::{CmpEq, SensibleMoveMask, Vector};
        use crate::arch::wasm32::*;

        impl Vector for v128 {
            const BYTES: usize = 16;
            const ALIGN: usize = Self::BYTES - 1;

            type Eq = v128;

            #[inline(always)]
            unsafe fn splat(byte: u8) -> v128 {
                u8x16_splat(byte)
            }

            #[inline(always)]
            unsafe fn load_aligned(data: *const u8) -> v128 {
                // SAFETY: guaranteed by caller.
                unsafe { *data.cast() }
            }

            #[inline(always)]
            unsafe fn load_unaligned(data: *const u8) -> v128 {
                // SAFETY: guaranteed by caller.
                unsafe { v128_load(data.cast()) }
            }

            #[inline(always)]
            unsafe fn cmpeq(self, vector2: Self) -> v128 {
                u8x16_eq(self, vector2)
            }
        }

        impl CmpEq for v128 {
            type Mask = SensibleMoveMask;

            #[inline(always)]
            unsafe fn movemask(self) -> SensibleMoveMask {
                SensibleMoveMask(u8x16_bitmask(self).into())
            }

            #[inline(always)]
            unsafe fn or(self, vector2: Self) -> v128 {
                v128_or(self, vector2)
            }
        }
    }
}

#[cfg(not(any(
    all(target_arch = "x86_64", target_feature = "sse2"),
    all(target_arch = "aarch64", target_feature = "neon"),
    all(target_arch = "wasm32", target_feature = "simd128")
)))]
mod swar {
    /// The bits that must be zero for a `*const usize` to be properly aligned.
    const USIZE_ALIGN: usize = super::USIZE_BYTES - 1;

    /// Finds all occurrences of a single byte in a haystack.
    #[derive(Clone, Copy, Debug)]
    pub(super) struct One {
        s1: u8,
        v1: usize,
    }

    impl One {
        /// The number of bytes we examine per each iteration of our search loop.
        const LOOP_BYTES: usize = 2 * super::USIZE_BYTES;

        /// Create a new searcher that finds occurrences of the byte given.
        #[inline]
        pub(super) fn new(needle: u8) -> One {
            One { s1: needle, v1: usize::repeat_u8(needle) }
        }

        /// Like `find`, but accepts and returns raw pointers.
        ///
        /// When a match is found, the pointer returned is guaranteed to be
        /// `>= start` and `< end`.
        ///
        /// This routine is useful if you're already using raw pointers and would
        /// like to avoid converting back to a slice before executing a search.
        ///
        /// # Safety
        ///
        /// * `start..end` must point to an initialized range.
        /// * Both `start` and `end` must point to the same allocated object and
        /// must either be in bounds or at most one byte past the end of the
        /// allocated object.
        /// * Both `start` and `end` must be _derived from_ a pointer to the same
        /// object.
        /// * The distance between `start` and `end` must not overflow `isize`.
        /// * The distance being in bounds must not rely on "wrapping around" the
        /// address space.
        ///
        /// Note that callers may pass a pair of pointers such that `start >= end`.
        /// In that case, `None` will always be returned.
        #[inline]
        pub(super) unsafe fn find_raw(
            &self,
            start: *const u8,
            end: *const u8,
        ) -> Option<*const u8> {
            if start >= end {
                return None;
            }
            // SAFETY: `start < end`.
            let len = unsafe { end.offset_from_unsigned(start) };
            if len < super::USIZE_BYTES {
                // SAFETY: `start < end`.
                return unsafe { super::fwd_byte_by_byte(start, end, self.s1) };
            }

            // The start of the search may not be aligned to `*const usize`,
            // so we do an unaligned load here.
            //
            // SAFETY: there is an `usize` at least (`len >= super::USIZE_BYTES`).
            let chunk = unsafe { start.cast::<usize>().read_unaligned() };
            if self.has_needle(chunk) {
                // SAFETY: `start < end`.
                return unsafe { super::fwd_byte_by_byte(start, end, self.s1) };
            }

            // And now we start our search at a guaranteed aligned position.
            // The first iteration of the loop below will overlap with the the
            // unaligned chunk above in cases where the search starts at an
            // unaligned offset, but that's okay as we're only here if that
            // above didn't find a match.
            //
            // SAFETY: `USIZE_BYTES - (start & USIZE_ALIGN)` is in `1..=USIZE_BYTES`,
            // and the preceding length check guarantees that at least `USIZE_BYTES`
            // bytes remain from `start`.
            let mut cur = unsafe { start.add(super::USIZE_BYTES - (start.addr() & USIZE_ALIGN)) };
            debug_assert!(cur > start);
            if len <= One::LOOP_BYTES {
                // SAFETY: `cur < end`.
                return unsafe { super::fwd_byte_by_byte(cur, end, self.s1) };
            }
            // SAFETY: `len > LOOP_BYTES`.
            debug_assert!(unsafe { end.sub(One::LOOP_BYTES) } >= start);
            // SAFETY: `len > LOOP_BYTES`.
            while cur <= unsafe { end.sub(One::LOOP_BYTES) } {
                debug_assert_eq!(0, cur.addr() % super::USIZE_BYTES);
                // SAFETY: `cur` is aligned already.
                let a = unsafe { cur.cast::<usize>().read() };
                // SAFETY: `cur + USIZE_BYTES` is aligned to `usize`.
                let b = unsafe { cur.add(super::USIZE_BYTES).cast::<usize>().read() };
                if self.has_needle(a) || self.has_needle(b) {
                    break;
                }
                // SAFETY: `cur + LOOP_BYTES <= end`.
                cur = unsafe { cur.add(One::LOOP_BYTES) };
            }
            // SAFETY: `cur <= end`.
            unsafe { super::fwd_byte_by_byte(cur, end, self.s1) }
        }

        /// Like `rfind`, but accepts and returns raw pointers.
        ///
        /// When a match is found, the pointer returned is guaranteed to be
        /// `>= start` and `< end`.
        ///
        /// This routine is useful if you're already using raw pointers and would
        /// like to avoid converting back to a slice before executing a search.
        ///
        /// # Safety
        ///
        /// * `start..end` must point to an initialized range.
        /// * Both `start` and `end` must point to the same allocated object and
        /// must either be in bounds or at most one byte past the end of the
        /// allocated object.
        /// * Both `start` and `end` must be _derived from_ a pointer to the same
        /// object.
        /// * The distance between `start` and `end` must not overflow `isize`.
        /// * The distance being in bounds must not rely on "wrapping around" the
        /// address space.
        ///
        /// Note that callers may pass a pair of pointers such that `start >= end`.
        /// In that case, `None` will always be returned.
        #[inline]
        pub(super) unsafe fn rfind_raw(
            &self,
            start: *const u8,
            end: *const u8,
        ) -> Option<*const u8> {
            if start >= end {
                return None;
            }
            // SAFETY: `start < end`.
            let len = unsafe { end.offset_from_unsigned(start) };
            if len < super::USIZE_BYTES {
                // SAFETY: `start < end`.
                return unsafe { super::rev_byte_by_byte(start, end, self.s1) };
            }

            // SAFETY: there is an `usize` at least (`len >= super::USIZE_BYTES`).
            let chunk = unsafe { end.sub(super::USIZE_BYTES).cast::<usize>().read_unaligned() };
            if self.has_needle(chunk) {
                // SAFETY: `start < end`.
                return unsafe { super::rev_byte_by_byte(start, end, self.s1) };
            }
            // SAFETY: `(end & USIZE_ALIGN)` is in `0..=USIZE_BYTES`,
            // and the preceding length check guarantees that at least `USIZE_BYTES`
            // bytes remain until `end`.
            let mut cur = unsafe { end.sub(end.addr() & USIZE_ALIGN) };
            debug_assert!(start <= cur && cur <= end);
            if len <= One::LOOP_BYTES {
                // SAFETY: `start < cur`.
                return unsafe { super::rev_byte_by_byte(start, cur, self.s1) };
            }
            // SAFETY: `len > LOOP_BYTES`.
            while cur >= unsafe { start.add(One::LOOP_BYTES) } {
                debug_assert_eq!(0, cur.addr() % super::USIZE_BYTES);
                // SAFETY: `cur + N * USIZE_BYTES` is aligned already.
                let a = unsafe { cur.sub(2 * super::USIZE_BYTES).cast::<usize>().read() };
                // SAFETY: `cur + N * USIZE_BYTES` is aligned already.
                let b = unsafe { cur.sub(1 * super::USIZE_BYTES).cast::<usize>().read() };
                if self.has_needle(a) || self.has_needle(b) {
                    break;
                }
                // SAFETY: `cur - LOOP_BYTES >= start`.
                cur = unsafe { cur.sub(One::LOOP_BYTES) };
            }
            // SAFETY: `start < cur`.
            unsafe { super::rev_byte_by_byte(start, cur, self.s1) }
        }

        #[inline(always)]
        fn has_needle(&self, chunk: usize) -> bool {
            has_zero_byte(self.v1 ^ chunk)
        }
    }

    /// Return `true` if `x` contains any zero byte.
    ///
    /// That is, this routine treats `x` as a register of 8-bit lanes and returns
    /// true when any of those lanes is `0`.
    ///
    /// From "Matters Computational" by J. Arndt.
    #[inline(always)]
    fn has_zero_byte(x: usize) -> bool {
        // "The idea is to subtract one from each of the bytes and then look for
        // bytes where the borrow propagated all the way to the most significant
        // bit."
        const LO: usize = usize::repeat_u8(0x01);
        const HI: usize = usize::repeat_u8(0x80);

        (x.wrapping_sub(LO) & !x & HI) != 0
    }
}
