use std::hint::black_box;
#[inline(never)]#[unsafe(no_mangle)]pub fn single()->i64{(0i64..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]pub fn single_ref()->i64{(0i64..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).by_ref().sum()}
#[inline(never)]#[unsafe(no_mangle)]pub fn chained()->i64{(0i64..1_000_000).chain(0..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).sum()}
