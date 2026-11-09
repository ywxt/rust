mod test {pub use std::hint::black_box;pub struct Bencher {pub bytes:u64,pub n:usize}impl Bencher {pub fn iter<T,F:FnMut()->T>(&mut self,mut f:F){for _ in 0..self.n{std::hint::black_box(f());}}}}
use std::iter::repeat;
use test::{Bencher,black_box};
mod vec {
use super::*;
fn do_bench_from_iter(b: &mut Bencher, src_len: usize) {
    let src: Vec<_> = FromIterator::from_iter(0..src_len);

    b.bytes = src_len as u64;

    b.iter(|| {
        let dst: Vec<_> = FromIterator::from_iter(src.iter().cloned());
        dst
    });
}
fn do_bench_from_slice(b: &mut Bencher, src_len: usize) {
    let src: Vec<_> = FromIterator::from_iter(0..src_len);

    b.bytes = src_len as u64;

    b.iter(|| src.as_slice().to_vec());
}
fn do_bench_clone(b: &mut Bencher, src_len: usize) {
    let src: Vec<usize> = FromIterator::from_iter(0..src_len);

    b.bytes = src_len as u64;

    b.iter(|| src.clone());
}
fn do_bench_from_fn(b: &mut Bencher, src_len: usize) {
    b.bytes = src_len as u64;

    b.iter(|| (0..src_len).collect::<Vec<_>>())
}
fn do_bench_from_elem(b: &mut Bencher, src_len: usize) {
    b.bytes = src_len as u64;

    b.iter(|| repeat(5).take(src_len).collect::<Vec<usize>>())
}
fn do_bench_with_capacity(b: &mut Bencher, src_len: usize) {
    b.bytes = src_len as u64;

    b.iter(|| Vec::<u32>::with_capacity(src_len))
}
pub fn bench_from_iter_0000(b: &mut Bencher) {
    do_bench_from_iter(b, 0)
}
pub fn bench_from_iter_0010(b: &mut Bencher) {
    do_bench_from_iter(b, 10)
}
pub fn bench_from_iter_0100(b: &mut Bencher) {
    do_bench_from_iter(b, 100)
}
pub fn bench_from_iter_1000(b: &mut Bencher) {
    do_bench_from_iter(b, 1000)
}
pub fn bench_from_slice_0000(b: &mut Bencher) {
    do_bench_from_slice(b, 0)
}
pub fn bench_from_slice_0010(b: &mut Bencher) {
    do_bench_from_slice(b, 10)
}
pub fn bench_from_slice_0100(b: &mut Bencher) {
    do_bench_from_slice(b, 100)
}
pub fn bench_from_slice_1000(b: &mut Bencher) {
    do_bench_from_slice(b, 1000)
}
pub fn bench_clone_0000(b: &mut Bencher) {
    do_bench_clone(b, 0)
}
pub fn bench_clone_0010(b: &mut Bencher) {
    do_bench_clone(b, 10)
}
pub fn bench_clone_0100(b: &mut Bencher) {
    do_bench_clone(b, 100)
}
pub fn bench_clone_1000(b: &mut Bencher) {
    do_bench_clone(b, 1000)
}
pub fn bench_from_fn_0000(b: &mut Bencher) {
    do_bench_from_fn(b, 0)
}
pub fn bench_from_fn_0010(b: &mut Bencher) {
    do_bench_from_fn(b, 10)
}
pub fn bench_from_fn_0100(b: &mut Bencher) {
    do_bench_from_fn(b, 100)
}
pub fn bench_from_fn_1000(b: &mut Bencher) {
    do_bench_from_fn(b, 1000)
}
pub fn bench_from_elem_0000(b: &mut Bencher) {
    do_bench_from_elem(b, 0)
}
pub fn bench_from_elem_0010(b: &mut Bencher) {
    do_bench_from_elem(b, 10)
}
pub fn bench_from_elem_0100(b: &mut Bencher) {
    do_bench_from_elem(b, 100)
}
pub fn bench_from_elem_1000(b: &mut Bencher) {
    do_bench_from_elem(b, 1000)
}
pub fn bench_with_capacity_0000(b: &mut Bencher) {
    do_bench_with_capacity(b, 0)
}
pub fn bench_with_capacity_0010(b: &mut Bencher) {
    do_bench_with_capacity(b, 10)
}
pub fn bench_with_capacity_0100(b: &mut Bencher) {
    do_bench_with_capacity(b, 100)
}
pub fn bench_with_capacity_1000(b: &mut Bencher) {
    do_bench_with_capacity(b, 1000)
}
}

fn main(){let args:Vec<_>=std::env::args().collect();let n:usize=args[2].parse().unwrap();let f:fn(&mut Bencher)=match args[1].as_str(){"vec::bench_from_iter_0000"=>vec::bench_from_iter_0000,"vec::bench_from_iter_0010"=>vec::bench_from_iter_0010,"vec::bench_from_iter_0100"=>vec::bench_from_iter_0100,"vec::bench_from_iter_1000"=>vec::bench_from_iter_1000,"vec::bench_from_slice_0000"=>vec::bench_from_slice_0000,"vec::bench_from_slice_0010"=>vec::bench_from_slice_0010,"vec::bench_from_slice_0100"=>vec::bench_from_slice_0100,"vec::bench_from_slice_1000"=>vec::bench_from_slice_1000,"vec::bench_clone_0000"=>vec::bench_clone_0000,"vec::bench_clone_0010"=>vec::bench_clone_0010,"vec::bench_clone_0100"=>vec::bench_clone_0100,"vec::bench_clone_1000"=>vec::bench_clone_1000,"vec::bench_from_fn_0000"=>vec::bench_from_fn_0000,"vec::bench_from_fn_0010"=>vec::bench_from_fn_0010,"vec::bench_from_fn_0100"=>vec::bench_from_fn_0100,"vec::bench_from_fn_1000"=>vec::bench_from_fn_1000,"vec::bench_from_elem_0000"=>vec::bench_from_elem_0000,"vec::bench_from_elem_0010"=>vec::bench_from_elem_0010,"vec::bench_from_elem_0100"=>vec::bench_from_elem_0100,"vec::bench_from_elem_1000"=>vec::bench_from_elem_1000,"vec::bench_with_capacity_0000"=>vec::bench_with_capacity_0000,"vec::bench_with_capacity_0010"=>vec::bench_with_capacity_0010,"vec::bench_with_capacity_0100"=>vec::bench_with_capacity_0100,"vec::bench_with_capacity_1000"=>vec::bench_with_capacity_1000,_=>panic!()};let worker=args.get(3).is_some_and(|s|s=="worker");let task=move||{let mut b=Bencher{bytes:0,n};let t=std::time::Instant::now();f(&mut b);println!("{{\"elapsed_ns\":{},\"reps\":{}}}",t.elapsed().as_nanos(),n);};if worker{std::thread::spawn(task).join().unwrap()}else{task()}}
