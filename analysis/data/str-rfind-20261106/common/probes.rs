#![feature(slice_internals)]
#![allow(internal_features)]
use std::hint::black_box;
mod word;
include!("inputs.rs");
type Search = fn(u8, &[u8]) -> Option<usize>;
unsafe extern "C" { #[link_name="memrchr"] fn libc_memrchr(p:*const u8,c:i32,n:usize)->*const u8; }

#[inline(never)]
#[unsafe(no_mangle)]
pub fn crate_reverse(b:u8,h:&[u8])->Option<usize>{fast::memrchr(b,h)}
#[inline(never)]
#[unsafe(no_mangle)]
pub fn vector_reverse(b:u8,h:&[u8])->Option<usize>{
    #[cfg(target_arch="aarch64")]
    {fast::arch::aarch64::neon::memchr::One::new(b).unwrap().rfind(h)}
    #[cfg(target_arch="x86_64")]
    {fast::arch::x86_64::sse2::memchr::One::new(b).unwrap().rfind(h)}
}
#[inline(never)]
pub fn c_reverse(b:u8,h:&[u8])->Option<usize>{
    let p=unsafe{libc_memrchr(h.as_ptr(),i32::from(b),h.len())};
    if p.is_null(){None}else{Some(p as usize-h.as_ptr()as usize)}
}
fn choose(name:&str)->Search{match name{
    "core"=>core::slice::memchr::memrchr,"word"=>word::copied_memrchr,
    "crate"=>crate_reverse,"v16"=>vector_reverse,"libc"=>c_reverse,_=>panic!()
}}
fn check(){
    let fs:[Search;5]=[choose("core"),choose("word"),choose("crate"),choose("v16"),choose("libc")];let mut cases=0;
    for len in 0..=128 {for offset in [0,1,7,8,15,16,31]{
        let mut b=vec![0u8;len+offset+64];
        for (i,x)in b.iter_mut().enumerate(){*x=(i.wrapping_mul(37).wrapping_add(len))as u8;}
        let h=&b[offset..offset+len];
        for target in 0..=255u8{let expected=h.iter().rposition(|x|*x==target);for f in fs{assert_eq!(f(target,h),expected);}cases+=1;}
    }}
    let mut state=0x123456789abcdefu64;
    for _ in 0..20000{state^=state<<13;state^=state>>7;state^=state<<17;let len=(state as usize)%4097;let offset=((state>>16)as usize)%32;let target=(state>>32)as u8;let mut b=vec![target^1;len+offset+64];
        for x in &mut b{state^=state<<13;state^=state>>7;state^=state<<17;*x=state as u8;}
        let h=&b[offset..offset+len];let expected=h.iter().rposition(|x|*x==target);for f in fs{assert_eq!(f(target,h),expected);}cases+=1;
    }
    for (name,s)in INPUTS{assert_eq!(s.rfind('_'),None);assert_eq!(s.rfind('\u{1f4a4}'),None);for b in [b'_',0xa4]{for f in fs{assert_eq!(f(b,s.as_bytes()),None);}}println!("input={name} bytes={} chars={} ptr_mod64={}",s.len(),s.chars().count(),s.as_ptr()as usize%64);}
    println!("CHECK_OK cases={cases}");
}
fn time_search(f:Search,h:&[u8],b:u8,n:usize){
    let expected=h.iter().rposition(|x|*x==b);assert_eq!(f(b,h),expected);let f=black_box(f);let h=black_box(h);let b=black_box(b);let t=std::time::Instant::now();
    for _ in 0..n{black_box(f(b,h));}
    let elapsed=t.elapsed().as_nanos();
    println!("{{\"elapsed_ns\":{elapsed},\"reps\":{n},\"bytes\":{},\"ptr_mod64\":{},\"end_mod64\":{}}}",h.len(),h.as_ptr()as usize%64,(h.as_ptr()as usize+h.len())%64);
}
fn main(){
    let a:Vec<_>=std::env::args().collect();if a[1]=="check"{check();return;}let f=choose(&a[2]);
    if a[1]=="case"{let (_,s)=INPUTS.iter().find(|x|x.0==a[3]).unwrap();let b:u8=a[4].parse().unwrap();let n:usize=a[5].parse().unwrap();time_search(f,s.as_bytes(),b,n);return;}
    let len:usize=a[3].parse().unwrap();let align:usize=a[4].parse().unwrap();assert!(align<64);let pat=&a[5];let b:u8=a[6].parse().unwrap();let n:usize=a[7].parse().unwrap();let fill=if b==b'x'{b'y'}else{b'x'};let mut buf=vec![fill;len+192];let start=(64-buf.as_ptr()as usize%64)%64+align;let h=&mut buf[start..start+len];
    if len>0{match pat.as_str(){"none"=>{},"first"=>h[0]=b,"middle"=>h[len/2]=b,"last"=>h[len-1]=b,"two"=>{h[0]=b;h[len-1]=b},"dense3"=>{for i in(0..len).step_by(3){h[i]=b}},_=>panic!()}}
    assert_eq!(h.as_ptr()as usize%64,align);time_search(f,h,b,n);
}
