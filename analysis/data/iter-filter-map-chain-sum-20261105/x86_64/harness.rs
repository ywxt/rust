#![feature(test)]
extern crate test;
use std::hint::black_box;
#[inline(always)] fn guard(x:i64)->Option<i64>{if (-3_037_000_499..=3_037_000_499).contains(&x){Some(x*x)}else{None}}
#[bench]fn original_bench_filter_map_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).sum::<i64>());}
#[bench]fn guarded_bench_filter_map_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).filter_map(guard).map(black_box).sum::<i64>());}
#[bench]fn original_bench_filter_map_ref_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).by_ref().sum::<i64>());}
#[bench]fn guarded_bench_filter_map_ref_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).filter_map(guard).map(black_box).by_ref().sum::<i64>());}
#[bench]fn original_bench_filter_map_chain_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).chain(0..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).sum::<i64>());}
#[bench]fn guarded_bench_filter_map_chain_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).chain(0..1_000_000).filter_map(guard).map(black_box).sum::<i64>());}
#[bench]fn original_bench_filter_map_chain_ref_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).chain(0..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).by_ref().sum::<i64>());}
#[bench]fn guarded_bench_filter_map_chain_ref_sum(b:&mut test::Bencher){b.iter(||(0i64..1_000_000).chain(0..1_000_000).filter_map(guard).map(black_box).by_ref().sum::<i64>());}
