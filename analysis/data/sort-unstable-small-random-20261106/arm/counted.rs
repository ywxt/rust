mod test {pub use std::hint::black_box;pub struct Bencher{pub bytes:u64,pub n:usize}impl Bencher{pub fn iter<T,F:FnMut()->T>(&mut self,mut f:F){for _ in 0..self.n{std::hint::black_box(f());}}}}
fn bench_rng() -> rand_xorshift::XorShiftRng {
    const SEED: [u8; 16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    rand::SeedableRng::from_seed(SEED)
}
mod slice {
use rand::Rng;
use rand::distr::StandardUniform;
use crate::test::{Bencher,black_box};
fn gen_ascending(len: usize) -> Vec<u64> {
    (0..len as u64).collect()
}
fn gen_descending(len: usize) -> Vec<u64> {
    (0..len as u64).rev().collect()
}
fn gen_random(len: usize) -> Vec<u64> {
    let mut rng = crate::bench_rng();
    (&mut rng).sample_iter(&StandardUniform).take(len).collect()
}
fn gen_mostly_ascending(len: usize) -> Vec<u64> {
    let mut rng = crate::bench_rng();
    let mut v = gen_ascending(len);
    for _ in (0usize..).take_while(|x| x * x <= len) {
        let x = rng.random::<u32>() as usize % len;
        let y = rng.random::<u32>() as usize % len;
        v.swap(x, y);
    }
    v
}
fn gen_mostly_descending(len: usize) -> Vec<u64> {
    let mut rng = crate::bench_rng();
    let mut v = gen_descending(len);
    for _ in (0usize..).take_while(|x| x * x <= len) {
        let x = rng.random::<u32>() as usize % len;
        let y = rng.random::<u32>() as usize % len;
        v.swap(x, y);
    }
    v
}
fn gen_big_random(len: usize) -> Vec<[u64; 16]> {
    let mut rng = crate::bench_rng();
    (&mut rng).sample_iter(&StandardUniform).map(|x| [x; 16]).take(len).collect()
}
macro_rules! sort {
    ($f:ident, $name:ident, $gen:expr, $len:expr) => {
        
        pub fn $name(b: &mut Bencher) {
            let v = $gen($len);
            b.iter(|| v.clone().$f());
            b.bytes = $len * size_of_val(&$gen(1)[0]) as u64;
        }
    };
}


sort!(sort, sort_small_ascending, gen_ascending, 10);
sort!(sort, sort_small_descending, gen_descending, 10);
sort!(sort, sort_small_random, gen_random, 10);
sort!(sort, sort_small_big, gen_big_random, 10);
sort!(sort, sort_medium_random, gen_random, 100);
sort!(sort, sort_large_ascending, gen_ascending, 10000);
sort!(sort, sort_large_descending, gen_descending, 10000);
sort!(sort, sort_large_mostly_ascending, gen_mostly_ascending, 10000);
sort!(sort, sort_large_mostly_descending, gen_mostly_descending, 10000);
sort!(sort, sort_large_random, gen_random, 10000);
sort!(sort, sort_large_big, gen_big_random, 10000);
sort!(sort_unstable, sort_unstable_small_ascending, gen_ascending, 10);
sort!(sort_unstable, sort_unstable_small_descending, gen_descending, 10);
sort!(sort_unstable, sort_unstable_small_random, gen_random, 10);
sort!(sort_unstable, sort_unstable_small_big, gen_big_random, 10);
sort!(sort_unstable, sort_unstable_medium_random, gen_random, 100);
sort!(sort_unstable, sort_unstable_large_ascending, gen_ascending, 10000);
sort!(sort_unstable, sort_unstable_large_descending, gen_descending, 10000);
sort!(sort_unstable, sort_unstable_large_mostly_ascending, gen_mostly_ascending, 10000);
sort!(sort_unstable, sort_unstable_large_mostly_descending, gen_mostly_descending, 10000);
sort!(sort_unstable, sort_unstable_large_random, gen_random, 10000);
sort!(sort_unstable, sort_unstable_large_big, gen_big_random, 10000);
}
fn main(){let a:Vec<_>=std::env::args().collect();let n:usize=a[2].parse().unwrap();let f:fn(&mut test::Bencher)=match a[1].as_str(){"slice::sort_small_ascending"=>slice::sort_small_ascending,"slice::sort_small_descending"=>slice::sort_small_descending,"slice::sort_small_random"=>slice::sort_small_random,"slice::sort_small_big"=>slice::sort_small_big,"slice::sort_medium_random"=>slice::sort_medium_random,"slice::sort_large_ascending"=>slice::sort_large_ascending,"slice::sort_large_descending"=>slice::sort_large_descending,"slice::sort_large_mostly_ascending"=>slice::sort_large_mostly_ascending,"slice::sort_large_mostly_descending"=>slice::sort_large_mostly_descending,"slice::sort_large_random"=>slice::sort_large_random,"slice::sort_large_big"=>slice::sort_large_big,"slice::sort_unstable_small_ascending"=>slice::sort_unstable_small_ascending,"slice::sort_unstable_small_descending"=>slice::sort_unstable_small_descending,"slice::sort_unstable_small_random"=>slice::sort_unstable_small_random,"slice::sort_unstable_small_big"=>slice::sort_unstable_small_big,"slice::sort_unstable_medium_random"=>slice::sort_unstable_medium_random,"slice::sort_unstable_large_ascending"=>slice::sort_unstable_large_ascending,"slice::sort_unstable_large_descending"=>slice::sort_unstable_large_descending,"slice::sort_unstable_large_mostly_ascending"=>slice::sort_unstable_large_mostly_ascending,"slice::sort_unstable_large_mostly_descending"=>slice::sort_unstable_large_mostly_descending,"slice::sort_unstable_large_random"=>slice::sort_unstable_large_random,"slice::sort_unstable_large_big"=>slice::sort_unstable_large_big,_=>panic!()};let mut b=test::Bencher{bytes:0,n};let t=std::time::Instant::now();f(&mut b);println!("{}",t.elapsed().as_nanos());}
