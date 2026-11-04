use std::hint::black_box;
use std::mem::MaybeUninit;
const N:usize=16384;
#[inline(never)]fn kernel<const F:usize>(s:&[(u32,u32)],d:&mut[MaybeUninit<u32>]){for(o,i)in d.iter_mut().zip(s){o.write(if F==0{i.0}else{i.1});}}
#[inline(never)]fn run<const F:usize>(s:&[(u32,u32)],n:u64,off:usize,fresh:bool){let mut d:Vec<MaybeUninit<u32>>=Vec::with_capacity(N+off);unsafe{d.set_len(N+off);}eprintln!("src_mod4096={} dst_mod4096={}",s.as_ptr() as usize%4096,d.as_ptr().wrapping_add(off) as usize%4096);
for _ in 0..n{if fresh {let mut q:Vec<MaybeUninit<u32>>=Vec::with_capacity(N+off);unsafe{q.set_len(N+off);}kernel::<F>(black_box(s),black_box(&mut q[off..]));black_box(&q);}else{kernel::<F>(black_box(s),black_box(&mut d[off..]));black_box(&d);}}
if !fresh{for i in 0..N{assert_eq!(unsafe{d[i+off].assume_init()},if F==0{s[i].0}else{s[i].1});}}}
#[inline(never)]fn stack(f:usize,n:u64,off:usize,fresh:bool){let s:[(u32,u32);N]=std::array::from_fn(|i|(i as u32,i as u32^7));let s=black_box(&s);if f==0{run::<0>(s,n,off,fresh)}else{run::<1>(s,n,off,fresh)}}
fn main(){let a:Vec<String>=std::env::args().collect();let f:usize=a[2].parse().unwrap();let n:u64=a[3].parse().unwrap();let off:usize=a[4].parse().unwrap();let fresh=a[5]=="fresh";if a[1]=="stack"{stack(f,n,off,fresh)}else{let s:Vec<(u32,u32)>=(0..N as u32).map(|i|(i,i^7)).collect();if f==0{run::<0>(&s,n,off,fresh)}else{run::<1>(&s,n,off,fresh)}}println!("ok");}
