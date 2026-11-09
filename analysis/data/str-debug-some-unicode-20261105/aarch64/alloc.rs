use std::alloc::{GlobalAlloc,Layout,System};
use std::sync::atomic::{AtomicBool,AtomicUsize,Ordering::Relaxed};
static ENABLED:AtomicBool=AtomicBool::new(false);
static N:AtomicUsize=AtomicUsize::new(0);
static SIZES:[AtomicUsize;16]=[const{AtomicUsize::new(0)};16];
struct A;
unsafe impl GlobalAlloc for A{
 unsafe fn alloc(&self,l:Layout)->*mut u8{if ENABLED.load(Relaxed){let i=N.fetch_add(1,Relaxed);if i<16{SIZES[i].store(l.size(),Relaxed);}}unsafe{System.alloc(l)}}
 unsafe fn dealloc(&self,p:*mut u8,l:Layout){unsafe{System.dealloc(p,l)}}
 unsafe fn realloc(&self,p:*mut u8,l:Layout,n:usize)->*mut u8{if ENABLED.load(Relaxed){let i=N.fetch_add(1,Relaxed);if i<16{SIZES[i].store(n,Relaxed);}}unsafe{System.realloc(p,l,n)}}
}
#[global_allocator]static GLOBAL:A=A;
fn main(){
 let s=std::hint::black_box("egy kis szöveg néhány unicode betűvel. legyen ez is 64 byte.");
 ENABLED.store(true,Relaxed);let out=format!("{:?}",s);ENABLED.store(false,Relaxed);
 let sizes:Vec<_>=(0..N.load(Relaxed).min(16)).map(|i|SIZES[i].load(Relaxed)).collect();
 println!("sizes={sizes:?},len={},capacity={}",out.len(),out.capacity());
}
