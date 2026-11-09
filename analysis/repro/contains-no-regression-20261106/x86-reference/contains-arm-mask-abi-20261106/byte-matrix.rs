#![feature(ascii_char)]
use std::{hint::black_box,num::NonZeroU8};
#[repr(align(64))]struct Storage<T>([T;65728]);
fn run<T:Copy+Eq>(len:usize,off:usize,dist:&str,n:usize,fill:T,needle:T) {
    let mut data=Box::new(Storage([fill;65728]));
    let pos=match dist {"absent"=>None,"front"=>Some(0),"middle"=>Some(len/2),"last"=>Some(len-1),_=>panic!()};
    if let Some(p)=pos {data.0[off+p]=needle;}
    let s=&data.0[off..off+len];assert_eq!(s.as_ptr() as usize%64,off);
    assert_eq!(s.contains(black_box(&needle)),pos.is_some());
    let mut hits=0usize;for _ in 0..n {hits+=black_box(black_box(s).contains(black_box(&needle))) as usize;}
    assert_eq!(hits,if pos.is_some(){n}else{0});println!("n={n} hits={hits}");
}
fn main() {
    let a:Vec<_>=std::env::args().collect();let len=a[2].parse().unwrap();let off=a[3].parse().unwrap();let dist=&a[4];let n=a[5].parse().unwrap();
    match a[1].as_str() {
        "i8"=>run(len,off,dist,n,-128i8,-1i8),
        "u8"=>run(len,off,dist,n,128u8,255u8),
        "bool"=>run(len,off,dist,n,false,true),
        "nonzero"=>run(len,off,dist,n,NonZeroU8::new(128).unwrap(),NonZeroU8::new(255).unwrap()),
        "option"=>run(len,off,dist,n,None,NonZeroU8::new(255)),
        "ascii"=>run(len,off,dist,n,std::ascii::Char::from_u8(b'x').unwrap(),std::ascii::Char::from_u8(0).unwrap()),
        _=>panic!()
    }
}
