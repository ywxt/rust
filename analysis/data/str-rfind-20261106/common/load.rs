use std::arch::asm;
fn main(){
 let a:Vec<_>=std::env::args().collect();let mode=&a[1];let offset:usize=a[2].parse().unwrap();let n:usize=a[3].parse().unwrap();assert!(offset<64&&offset%8==0&&n>0);
 let mut b=vec![0usize;256];let head=((64-b.as_ptr()as usize%64)%64+offset)/8;let nodes=[head,head+32,head+64];
 for i in 0..3 {b[nodes[i]]=(&b[nodes[(i+1)%3]]as*const usize)as usize;}
 let start=(&b[head]as*const usize)as usize;assert_eq!(start%64,offset);let mut p=start;let mut count=n;let ops=if mode.ends_with("chain"){n}else{8*n};let t=std::time::Instant::now();
 unsafe{
  #[cfg(target_arch="aarch64")]
  match mode.as_str(){
   "ldp"=>asm!(".p2align 6","2:",
    "ldp x8,x9,[{p}]","ldp x10,x11,[{p}]","ldp x12,x13,[{p}]","ldp x14,x15,[{p}]",
    "ldp x8,x9,[{p}]","ldp x10,x11,[{p}]","ldp x12,x13,[{p}]","ldp x14,x15,[{p}]",
    "subs {n},{n},#1","b.ne 2b",p=in(reg)p,n=inout(reg)count,out("x8")_,out("x9")_,out("x10")_,out("x11")_,out("x12")_,out("x13")_,out("x14")_,out("x15")_,options(nostack,readonly)),
   "ldr"=>asm!(".p2align 6","2:",
    "ldr x8,[{p}]","ldr x9,[{p},#8]","ldr x10,[{p}]","ldr x11,[{p},#8]","ldr x12,[{p}]","ldr x13,[{p},#8]","ldr x14,[{p}]","ldr x15,[{p},#8]",
    "ldr x8,[{p}]","ldr x9,[{p},#8]","ldr x10,[{p}]","ldr x11,[{p},#8]","ldr x12,[{p}]","ldr x13,[{p},#8]","ldr x14,[{p}]","ldr x15,[{p},#8]",
    "subs {n},{n},#1","b.ne 2b",p=in(reg)p,n=inout(reg)count,out("x8")_,out("x9")_,out("x10")_,out("x11")_,out("x12")_,out("x13")_,out("x14")_,out("x15")_,options(nostack,readonly)),
   "ldp-chain"=>asm!(".p2align 6","2:","ldp {p},x9,[{p}]","subs {n},{n},#1","b.ne 2b",p=inout(reg)p,n=inout(reg)count,out("x9")_,options(nostack,readonly)),
   "ldr-chain"=>asm!(".p2align 6","2:","ldr {p},[{p}]","subs {n},{n},#1","b.ne 2b",p=inout(reg)p,n=inout(reg)count,options(nostack,readonly)),_=>panic!()
  }
  #[cfg(target_arch="x86_64")]
  match mode.as_str(){
   "mov"=>asm!(".p2align 6","2:",
    "mov r8,[{p}]","mov r9,[{p}+8]","mov r10,[{p}]","mov r11,[{p}+8]","mov r12,[{p}]","mov r13,[{p}+8]","mov r14,[{p}]","mov r15,[{p}+8]",
    "mov r8,[{p}]","mov r9,[{p}+8]","mov r10,[{p}]","mov r11,[{p}+8]","mov r12,[{p}]","mov r13,[{p}+8]","mov r14,[{p}]","mov r15,[{p}+8]",
    "dec {n}","jnz 2b",p=in(reg)p,n=inout(reg)count,out("r8")_,out("r9")_,out("r10")_,out("r11")_,out("r12")_,out("r13")_,out("r14")_,out("r15")_,options(nostack,readonly)),
   "mov-chain"=>asm!(".p2align 6","2:","mov {p},[{p}]","dec {n}","jnz 2b",p=inout(reg)p,n=inout(reg)count,options(nostack,readonly)),_=>panic!()
  }
 }
 let elapsed=t.elapsed().as_nanos();assert_eq!(count,0);assert!(nodes.iter().any(|i|(&b[*i]as*const usize)as usize==p));
 println!("{{\"elapsed_ns\":{elapsed},\"ops\":{ops},\"alignment\":{offset}}}");
}
