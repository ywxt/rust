#![feature(test)]
extern crate test;
use std::hint::black_box;
use test::Bencher;
#[bench]
fn bench_filter_chain_ref_count(b: &mut Bencher) {
    b.iter(|| {
        (0i64..1_000_000).chain(0..1_000_000).map(black_box).by_ref().filter(|x| x % 3 == 0).count()
    })
}
#[bench]
fn bench_source_unroll4(b: &mut Bencher) {
    b.iter(|| {
        let mut total=0;
        for _ in 0..2 {
            let mut counts=[0usize;4];
            for i in (0i64..1_000_000).step_by(4) {
                counts[0]+=usize::from(black_box(i)%3==0);
                counts[1]+=usize::from(black_box(i+1)%3==0);
                counts[2]+=usize::from(black_box(i+2)%3==0);
                counts[3]+=usize::from(black_box(i+3)%3==0);
            }
            total+=counts.iter().sum::<usize>();
        }
        assert_eq!(total,666_668);
        total
    })
}
