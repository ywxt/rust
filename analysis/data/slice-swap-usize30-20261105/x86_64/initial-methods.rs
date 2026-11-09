use std::hint::black_box;
#[inline(always)]pub fn chunks2<T>(x:&mut[T],y:&mut[T]){assert_eq!(x.len(),y.len());let (a,at)=x.as_chunks_mut::<2>();let(b,bt)=y.as_chunks_mut::<2>();for(a,b)in a.iter_mut().zip(b){std::mem::swap(a,b);}at.swap_with_slice(bt);}
#[inline(always)]pub fn vec128(x:&mut[usize],y:&mut[usize]){assert_eq!(x.len(),y.len());let n=x.len();let mut i=0;while i+2<=n{unsafe{
 #[cfg(target_arch="aarch64")] {use std::arch::aarch64::*;let a=vld1q_u64(x.as_ptr().add(i).cast());let b=vld1q_u64(y.as_ptr().add(i).cast());vst1q_u64(x.as_mut_ptr().add(i).cast(),b);vst1q_u64(y.as_mut_ptr().add(i).cast(),a);}
 #[cfg(target_arch="x86_64")] {use std::arch::x86_64::*;let a=_mm_loadu_si128(x.as_ptr().add(i).cast());let b=_mm_loadu_si128(y.as_ptr().add(i).cast());_mm_storeu_si128(x.as_mut_ptr().add(i).cast(),b);_mm_storeu_si128(y.as_mut_ptr().add(i).cast(),a);}
 }i+=2;}if i<n{std::mem::swap(&mut x[i],&mut y[i]);}}
#[inline(always)]pub fn scalar(x:&mut[usize],y:&mut[usize]){assert_eq!(x.len(),y.len());for(a,b)in x.iter_mut().zip(y){std::mem::swap(a,b);}}
#[inline(always)]fn reg_barrier(mut v:usize)->usize{unsafe{std::arch::asm!("/* {0} */",inout(reg)v,options(pure,nomem,nostack));}v}
#[inline(always)]pub fn batch<const M:u8>(x:&mut[usize],y:&mut[usize],skip:&mut usize,n:usize)->(usize,usize){for _ in 0..32{let a=&mut x[*skip..];let b=&mut y[..n-*skip];match M{0|4|5=>a.swap_with_slice(b),1=>chunks2(a,b),2=>vec128(a,b),3=>scalar(a,b),_=>unreachable!()};*skip=if M==4{reg_barrier(*skip+1)%8}else if M==5{black_box(*skip+2)%8}else{black_box(*skip+1)%8};}black_box((x[n/3],y[n*2/3]))}
#[inline(never)]#[unsafe(no_mangle)]pub fn original(x:&mut[usize;30],y:&mut[usize;30],skip:&mut usize)->(usize,usize){batch::<0>(x,y,skip,30)}
#[inline(never)]#[unsafe(no_mangle)]pub fn chunk_batch(x:&mut[usize;30],y:&mut[usize;30],skip:&mut usize)->(usize,usize){batch::<1>(x,y,skip,30)}
#[inline(never)]#[unsafe(no_mangle)]pub fn vec_batch(x:&mut[usize;30],y:&mut[usize;30],skip:&mut usize)->(usize,usize){batch::<2>(x,y,skip,30)}
#[inline(never)]#[unsafe(no_mangle)]pub fn scalar_batch(x:&mut[usize;30],y:&mut[usize;30],skip:&mut usize)->(usize,usize){batch::<3>(x,y,skip,30)}
#[inline(never)]#[unsafe(no_mangle)]pub fn reg_batch(x:&mut[usize;30],y:&mut[usize;30],skip:&mut usize)->(usize,usize){batch::<4>(x,y,skip,30)}
#[inline(never)]#[unsafe(no_mangle)]pub fn even_batch(x:&mut[usize;30],y:&mut[usize;30],skip:&mut usize)->(usize,usize){batch::<5>(x,y,skip,30)}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_std(x:&mut[usize],y:&mut[usize]){x.swap_with_slice(y)}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_chunk(x:&mut[usize],y:&mut[usize]){chunks2(x,y)}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_vec(x:&mut[usize],y:&mut[usize]){vec128(x,y)}
#[inline(never)]#[unsafe(no_mangle)]pub fn leaf_scalar(x:&mut[usize],y:&mut[usize]){scalar(x,y)}
