// partition-pass replica of partition_lomuto_branchless_cyclic (u64, unroll 2), plus real sort and microbench floors.
use std::hint::black_box; use std::ptr;
struct R(u64); impl R{fn n(&mut self)->u64{let mut s=self.0;s^=s<<13;s^=s>>7;s^=s<<17;self.0=s;s}}
#[inline(never)] fn part(v:&mut [u64],p:u64)->usize{unsafe{let b=v.as_mut_ptr();let len=v.len();let gapv=*b;let mut gap=b;let mut nl=0usize;let mut r=b.add(1);let e=b.add(len-1);
 while r<e{for _ in 0..2{let lt=(*r<p) as usize;let l=b.add(nl);ptr::copy(l,gap,1);ptr::copy_nonoverlapping(r,l,1);gap=r;nl+=lt;r=r.add(1);}}
 let end=b.add(len);while r<end{let lt=(*r<p) as usize;let l=b.add(nl);ptr::copy(l,gap,1);ptr::copy_nonoverlapping(r,l,1);gap=r;nl+=lt;r=r.add(1);}
 let lt=(gapv<p) as usize;let l=b.add(nl);ptr::copy(l,gap,1);*l=gapv;nl+=lt;nl}}
#[inline(never)] fn fwd(p:*mut u64,n:u64)->u64{unsafe{for _ in 0..n{let x=ptr::read_volatile(p);ptr::write_volatile(p,x+1);}*p}}
#[inline(never)] fn ls(a:*mut u64,mask:usize,k:usize,n:u64){unsafe{let mut i=0usize;for _ in 0..n{for j in 0..k{let x=ptr::read_volatile(a.add((i+j*8)&mask));ptr::write_volatile(a.add((i+j*8+64)&mask),x);}i=(i+1)&mask;}}}
fn main(){let a:Vec<String>=std::env::args().collect();let n:u64=a[2].parse().unwrap();let mut r=R(88172645463325252);
 match a[1].as_str(){
 "sort"=>{let sz:usize=a.get(3).map(|x|x.parse().unwrap()).unwrap_or(10000);let v:Vec<u64>=(0..sz).map(|_|r.n()).collect();for _ in 0..n{let mut c=v.clone();c.sort_unstable();black_box(&c);}}
 "mostly"=>{let mut v:Vec<u64>=(0..10000u64).rev().collect();for _ in 0..101{let x=(r.n()%10000) as usize;let y=(r.n()%10000) as usize;v.swap(x,y);}for _ in 0..n{let mut c=v.clone();c.sort_unstable();black_box(&c);}}
 "part"=>{let sz:usize=a[3].parse().unwrap();let pct:u64=a[4].parse().unwrap();let vs:Vec<Vec<u64>>=(0..16).map(|_|(0..sz).map(|_|r.n()).collect()).collect();let p=(u64::MAX/100)*pct;
  let mut w=vec![0u64;sz];for i in 0..n{w.copy_from_slice(&vs[(i%16) as usize]);black_box(part(&mut w,p));}}
 "fwd"=>{let mut x=0u64;black_box(fwd(&mut x,n));}
 "ls1"=>{let mut v=vec![1u64;512];ls(v.as_mut_ptr(),511,1,n);}
 "ls2"=>{let mut v=vec![1u64;512];ls(v.as_mut_ptr(),511,2,n);}
 _=>panic!()}}
