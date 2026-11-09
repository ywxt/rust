use std::arch::asm;
#[repr(align(64))]struct Data([u64;16]);
#[cfg(target_arch="aarch64")]
#[inline(never)]fn run(p:*mut u64,n:u64,split:bool)->(u64,u64){let(mut a,mut b)=(1u64,2u64);unsafe{if split{asm!("2:","stp {a}, {b}, [{p}]","ldr {a}, [{p}]","ldr {b}, [{p}, #8]","subs {n}, {n}, #1","b.ne 2b",a=inout(reg)a,b=inout(reg)b,p=in(reg)p,n=inout(reg)n=>_,options(nostack));}else{asm!("2:","stp {a}, {b}, [{p}]","ldp {a}, {b}, [{p}]","subs {n}, {n}, #1","b.ne 2b",a=inout(reg)a,b=inout(reg)b,p=in(reg)p,n=inout(reg)n=>_,options(nostack));}}(a,b)}
#[cfg(target_arch="x86_64")]
#[inline(never)]fn run(p:*mut u64,n:u64,_split:bool)->(u64,u64){let(mut a,mut b)=(1u64,2u64);unsafe{asm!("2:","mov [{p}], {a}","mov [{p}+8], {b}","mov {a}, [{p}]","mov {b}, [{p}+8]","dec {n}","jnz 2b",a=inout(reg)a,b=inout(reg)b,p=in(reg)p,n=inout(reg)n=>_,options(nostack));}(a,b)}
fn main(){let args:Vec<_>=std::env::args().collect();let off:usize=args[1].parse().unwrap();let split=args[2]=="split";let n:u64=args[3].parse().unwrap();let mut d=Data([0;16]);let p=unsafe{d.0.as_mut_ptr().add(off/8)};assert_eq!(p as usize%64,off);let t=std::time::Instant::now();let r=run(std::hint::black_box(p),n,split);assert_eq!(r,(1,2));println!("{{\"offset\":{off},\"split\":{split},\"reps\":{n},\"elapsed_ns\":{}}}",t.elapsed().as_nanos());}
