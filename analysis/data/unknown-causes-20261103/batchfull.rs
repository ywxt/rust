#![feature(unicode_internals)]
use std::hint::black_box;
#[inline(always)] fn tail(c:u32,j:usize)->usize { let mut k=(H[j]>>21) as usize;let end=if j+1<H.len(){(H[j+1]>>21) as usize}else{O.len()};let prev=if j==0{0}else{H[j-1]&0x1fffff};let total=c-prev;let mut sum=0;for _ in 0..end-k-1 {sum+=O[k] as u32;if sum>total{break;}k+=1;}k&1 }

static H:[u32;33]=[768, 2098307, 6292881, 10490717, 522196754, 526393356, 723528943, 731918378, 744531567, 752920578, 769719070, 908131840, 912326558, 920715773, 924912129, 937495844, 962662059, 971053103, 1260461811, 1407267904, 1428250910, 1436642032, 1445031759, 1453440157, 1470222080, 1474416935, 1482807808, 1528946688, 1554113198, 1583473900, 1591863504, 1617821728, 1627324912];
static O:[u8;779]=[
        0, 112, 0, 7, 0, 45, 1, 1, 1, 2, 1, 2, 1, 3, 70, 11, 48, 21, 16, 1, 101, 7, 2, 6, 2, 2, 1,
        4, 35, 1, 30, 27, 91, 11, 58, 9, 9, 1, 24, 4, 1, 9, 1, 3, 1, 5, 43, 3, 59, 9, 42, 24, 1, 32,
        55, 1, 1, 1, 4, 8, 4, 1, 3, 7, 10, 2, 29, 1, 58, 1, 1, 1, 2, 4, 8, 1, 9, 1, 10, 2, 26, 1, 2,
        2, 57, 1, 4, 2, 4, 2, 2, 3, 3, 1, 30, 2, 3, 1, 11, 2, 57, 1, 4, 5, 1, 2, 4, 1, 20, 2, 22, 6,
        1, 1, 58, 1, 1, 2, 1, 4, 8, 1, 5, 5, 10, 2, 30, 1, 59, 1, 1, 1, 12, 1, 9, 1, 40, 1, 3, 1,
        55, 1, 1, 3, 5, 3, 1, 4, 7, 2, 11, 2, 29, 1, 58, 1, 2, 2, 1, 1, 3, 3, 1, 4, 7, 2, 11, 2, 28,
        2, 57, 2, 1, 1, 2, 4, 8, 1, 9, 1, 10, 2, 29, 1, 72, 1, 4, 1, 2, 3, 1, 1, 8, 1, 81, 1, 2, 7,
        12, 8, 98, 1, 2, 9, 11, 7, 73, 2, 27, 1, 1, 1, 1, 1, 55, 14, 1, 5, 1, 2, 5, 11, 1, 36, 9, 1,
        102, 4, 1, 6, 1, 2, 2, 2, 25, 2, 4, 3, 16, 4, 13, 1, 2, 2, 6, 1, 15, 1, 0, 3, 0, 4, 28, 3,
        29, 2, 30, 2, 64, 2, 1, 7, 8, 1, 2, 11, 9, 1, 45, 3, 1, 1, 117, 2, 34, 1, 118, 3, 4, 2, 9,
        1, 6, 3, 219, 2, 2, 1, 58, 1, 1, 7, 1, 1, 1, 1, 2, 8, 6, 10, 2, 1, 48, 65, 15, 4, 48, 10, 4,
        3, 38, 9, 12, 2, 32, 4, 2, 6, 56, 1, 1, 2, 3, 1, 1, 5, 56, 8, 2, 2, 152, 3, 1, 13, 1, 7, 4,
        1, 6, 1, 3, 2, 198, 64, 0, 1, 195, 33, 0, 3, 141, 1, 96, 32, 0, 6, 105, 2, 0, 4, 1, 10, 32,
        2, 80, 2, 0, 1, 3, 1, 4, 1, 25, 2, 5, 1, 151, 2, 26, 18, 13, 1, 38, 8, 25, 11, 1, 1, 44, 3,
        48, 1, 2, 4, 2, 2, 2, 1, 36, 1, 67, 6, 2, 2, 2, 2, 12, 1, 8, 1, 47, 1, 51, 1, 1, 3, 2, 2, 5,
        2, 1, 1, 42, 2, 8, 1, 238, 1, 2, 1, 4, 1, 0, 1, 0, 16, 16, 16, 0, 2, 0, 1, 226, 1, 149, 5,
        0, 3, 1, 2, 5, 4, 40, 3, 4, 1, 165, 2, 0, 4, 65, 5, 0, 2, 30, 5, 32, 16, 70, 11, 49, 4, 123,
        1, 54, 15, 41, 1, 2, 2, 10, 3, 49, 4, 2, 2, 7, 1, 61, 3, 36, 5, 1, 8, 62, 1, 12, 2, 52, 9,
        1, 1, 8, 4, 2, 1, 95, 3, 2, 4, 6, 1, 2, 1, 157, 1, 3, 8, 21, 2, 57, 2, 1, 1, 1, 1, 12, 1, 9,
        1, 14, 7, 3, 5, 67, 1, 2, 6, 1, 1, 2, 1, 1, 3, 4, 3, 1, 1, 14, 2, 85, 8, 2, 3, 1, 1, 23, 1,
        81, 1, 2, 6, 1, 1, 2, 1, 1, 2, 1, 2, 235, 1, 2, 4, 6, 2, 1, 2, 27, 2, 85, 8, 2, 1, 1, 2,
        106, 1, 1, 1, 2, 8, 101, 1, 1, 1, 2, 4, 1, 5, 0, 9, 1, 2, 245, 1, 10, 4, 4, 1, 144, 4, 2, 2,
        4, 1, 32, 10, 40, 6, 2, 4, 8, 1, 9, 6, 2, 3, 46, 13, 1, 2, 198, 1, 1, 3, 1, 1, 201, 7, 1, 6,
        1, 1, 82, 22, 2, 7, 1, 2, 1, 2, 122, 6, 3, 1, 1, 2, 1, 7, 1, 1, 72, 2, 3, 1, 1, 1, 88, 1, 0,
        2, 11, 2, 52, 5, 5, 3, 23, 1, 0, 1, 6, 15, 0, 12, 3, 3, 0, 5, 59, 7, 0, 1, 63, 4, 81, 1, 11,
        2, 0, 2, 0, 46, 2, 23, 0, 2, 60, 5, 3, 6, 8, 8, 2, 7, 30, 4, 148, 3, 11, 3, 8, 2, 2, 1, 32,
        2, 0, 55, 4, 50, 8, 1, 14, 1, 22, 5, 1, 15, 0, 7, 1, 17, 2, 7, 1, 2, 1, 5, 100, 1, 160, 7,
        0, 1, 61, 4, 0, 4, 254, 2, 243, 1, 2, 1, 7, 2, 5, 1, 0, 7, 109, 7, 0, 96, 128, 240, 0,
    ];

#[inline(always)] fn step(c:u32,b:usize,m:usize,v:u32)->usize {let mut out=b;
#[cfg(target_arch="aarch64")] unsafe{std::arch::asm!("cmp {c:w}, {v:w}","csel {out}, {b}, {m}, lo",c=in(reg)c,v=in(reg)v,b=in(reg)b,m=in(reg)m,out=out(reg)out,options(pure,nomem,nostack));}
#[cfg(target_arch="x86_64")] unsafe{std::arch::asm!("cmp {c:e}, {v:e}","cmovae {out}, {m}",c=in(reg)c,v=in(reg)v,m=in(reg)m,out=inout(reg)out,options(pure,nomem,nostack));}
out}
#[inline(always)] fn stage<const K:usize>(cs:&[u32;K],b:&mut [usize;K],half:usize){for j in 0..K {let mid=b[j]+half;let val=H[mid]<<11;b[j]=step(cs[j]<<11,b[j],mid,val);}}
#[inline(always)] fn batch<const K:usize>(cs:&[u32;K])->[usize;K]{let mut b=[0usize;K];stage(cs,&mut b,16);stage(cs,&mut b,8);stage(cs,&mut b,4);stage(cs,&mut b,2);stage(cs,&mut b,1);stage(cs,&mut b,1);for j in 0..K{b[j]+=((H[b[j]]<<11)<=(cs[j]<<11)) as usize;}b}
#[inline(never)] fn run<const K:usize>(cs:&[u32],it:u64,full:bool)->usize {let mut s=0;for _ in 0..it {for z in black_box(cs).chunks_exact(K){let a:&[u32;K]=z.try_into().unwrap();let out=batch(a);for j in 0..K {s+=if full && a[j]>=768 {tail(a[j],out[j])}else if full{0}else{out[j]};}}}s}
fn main(){let a:Vec<String>=std::env::args().collect();if a[1]=="check" {for i in 0..=0x10ffff{let exp=H.partition_point(|h|(h&0x1fffff)<=i);assert_eq!(batch(&[i;8]),[exp;8],"{i}");if let Some(c)=char::from_u32(i){let got=if i<768{0}else{tail(i,exp)};assert_eq!(got,core::unicode::unicode_data::grapheme_extend::lookup(c) as usize,"{i}");}}println!("batch indices checked");return;}
let full=a[1].starts_with("full");let k:usize=a[1].trim_start_matches("full").parse().unwrap();let it:u64=a[3].parse().unwrap();let text=if a[2]=="mostly"{"предложение из кириллических букв."}else{"\"❤️\"\n\"hűha ez betű\"\n\"кириллических букв\"."};let initial:Vec<u32>=text.chars().filter(|c|!c.is_ascii()).map(|c|c as u32).collect();let cs:Vec<u32>=(0..initial.len()*8).map(|i|initial[i%initial.len()]).collect();let s=match k{1=>run::<1>(&cs,it,full),2=>run::<2>(&cs,it,full),4=>run::<4>(&cs,it,full),8=>run::<8>(&cs,it,full),_=>panic!()};println!("{s} chars={}",cs.len());}
