#![feature(rustc_private)]
use rand::prelude::*;
use std::hint::black_box;
include!("compare.rs");
pub const DATA:[Item<'static>;6]=[("core::iter::adapters::Chain",123),("core::iter::adapters::Clone",456),("core::iter::adapters::Copie",789),("core::iter::adapters::Cycle",123),("core::iter::adapters::Flatt",456),("core::iter::adapters::TakeN",789)];
pub fn rng()->rand_xorshift::XorShiftRng{rand::SeedableRng::from_seed([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])}
#[inline(always)]pub fn relation<const M:u8>(x:&Item<'_>,y:&Item<'_>)->[bool;4]{match M{0=>predicates(x,y),1=>fused(x,y),2=>two_relations(x,y),3=>pointer_equal(x,y),4=>ordering_match(x,y),_=>string_once(x,y)}}
#[inline(never)]#[unsafe(no_mangle)]pub fn original(reps:usize)->u64{run::<0>(reps)}
#[inline(never)]#[unsafe(no_mangle)]pub fn fused_run(reps:usize)->u64{run::<1>(reps)}
#[inline(never)]#[unsafe(no_mangle)]pub fn two_run(reps:usize)->u64{run::<2>(reps)}
#[inline(never)]#[unsafe(no_mangle)]pub fn pointer_run(reps:usize)->u64{run::<3>(reps)}
#[inline(always)]fn run<const M:u8>(reps:usize)->u64{let mut rng=black_box(rng());let data=black_box(DATA);let mut out=[false;4];for _ in 0..reps{let x=data.choose(&mut rng).unwrap();let y=data.choose(&mut rng).unwrap();out=black_box(relation::<M>(x,y));}u32::from_ne_bytes(out.map(u8::from))as u64}
#[inline(never)]#[unsafe(no_mangle)]pub fn rng_only(reps:usize)->u64{let mut rng=black_box(rng());let data=black_box(DATA);let mut checksum=0u64;for _ in 0..reps{let x=data.choose(&mut rng).unwrap();let y=data.choose(&mut rng).unwrap();checksum=checksum.wrapping_add(black_box((x,y)).0.1 as u64);}checksum}
#[inline(never)]#[unsafe(no_mangle)]pub fn match_run(reps:usize)->u64{run::<4>(reps)}
fn check(){let mut cases:Vec<Item<'_>>=DATA.to_vec();let strings=[String::from(""),String::from("a"),String::from("a"),String::from("aa"),String::from("z"),String::from("中文"),String::from("\0"),String::from("core::iter::adapters::Chain")];for s in &strings{for n in [0,1,2,usize::MAX]{cases.push((s,n));}}
 let mut count=0;for x in &cases{for y in &cases{let want=predicates(x,y);assert_eq!(want,fused(x,y));assert_eq!(want,two_relations(x,y));assert_eq!(want,pointer_equal(x,y));assert_eq!(want,string_once(x,y));assert_eq!(want,ordering_match(x,y));count+=1;}}
 let a=original(100000);assert_eq!(a,fused_run(100000));assert_eq!(a,two_run(100000));assert_eq!(a,pointer_run(100000));println!("{count} pair cases and 100000 original RNG iterations per method passed; checksum={a}");}
fn main(){let a:Vec<_>=std::env::args().collect();let mode=&a[1];if mode=="check"{check();return}let reps:usize=a[2].parse().unwrap();let t=std::time::Instant::now();let out=match mode.as_str(){"original"=>original(reps),"fused"=>fused_run(reps),"two"=>two_run(reps),"pointer"=>pointer_run(reps),"rng"=>rng_only(reps),"match"=>match_run(reps),_=>panic!("mode")};black_box(out);println!("{{\"elapsed_ns\":{},\"reps\":{},\"checksum\":{}}}",t.elapsed().as_nanos(),reps,out);}
