use std::arch::asm;
use std::hint::black_box;
fn main(){
 let a:Vec<_>=std::env::args().collect();let n:u64=a[2].parse().unwrap();let mut count=n;let t=std::time::Instant::now();
 unsafe{
  #[cfg(target_arch="aarch64")]
  match a[1].as_str(){
   "alu"=>asm!("mov x15, #0x55","mov x9, #1","mov x10, #2","mov x11, #3","mov x12, #4","mov x13, #5","mov x14, #6",".p2align 6","2:",
    "eor x9,x9,x15","eor x10,x10,x15","eor x11,x11,x15","eor x12,x12,x15","eor x13,x13,x15","eor x14,x14,x15",
    "orr x9,x9,x15","orr x10,x10,x15","orr x11,x11,x15","orr x12,x12,x15","orr x13,x13,x15","orr x14,x14,x15",
    "subs {n},{n},#1","b.ne 2b",n=inout(reg)count,out("x9")_,out("x10")_,out("x11")_,out("x12")_,out("x13")_,out("x14")_,out("x15")_,options(nomem,nostack)),
   "nop"=>asm!(".p2align 6","2:",".rept 12","nop",".endr","subs {n},{n},#1","b.ne 2b",n=inout(reg)count,options(nomem,nostack)),_=>panic!()
  }
  #[cfg(target_arch="x86_64")]
  match a[1].as_str(){
   "alu"=>asm!("mov r15,0x55","mov r8,1","mov r9,2","mov r10,3","mov r11,4","mov r12,5","mov r13,6",".p2align 6","2:",
    "xor r8,r15","xor r9,r15","xor r10,r15","xor r11,r15","xor r12,r15","xor r13,r15",
    "or r8,r15","or r9,r15","or r10,r15","or r11,r15","or r12,r15","or r13,r15",
    "dec {n}","jnz 2b",n=inout(reg)count,out("r8")_,out("r9")_,out("r10")_,out("r11")_,out("r12")_,out("r13")_,out("r15")_,options(nomem,nostack)),
   "nop"=>asm!(".p2align 6","2:",".rept 12","nop",".endr","dec {n}","jnz 2b",n=inout(reg)count,options(nomem,nostack)),_=>panic!()
  }
 }
 black_box(count);println!("{}",t.elapsed().as_nanos());
}
