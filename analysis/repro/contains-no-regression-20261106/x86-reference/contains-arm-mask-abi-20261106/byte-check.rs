#![feature(ascii_char)]
use std::num::NonZeroU8;
fn main() {
    #[repr(align(64))] struct Storage([u8; 1152]);
    let mut storage=Box::new(Storage([0;1152]));
    let lengths:Vec<usize>=(0..=70).chain([79,80,95,96,127,128,129,255,256,257,1024]).collect();
    let mut total=0usize;
    for needle in 0..=255u8 {
        let fill=needle.wrapping_add(1);
        for &len in &lengths {for off in 0..64 {
            storage.0.fill(fill);
            let s=&mut storage.0[off..off+len];
            assert!(!s.contains(&needle));total+=1;
            if len>0 {
                for pos in [0,len/2,len-1] {s[pos]=needle;assert!(s.contains(&needle));total+=1;s[pos]=fill;}
            }
        }}
    }
    let mut seed=0x123456789abcdef0u64;
    for len in [0,1,8,15,16,17,31,32,33,63,64,65,127,128,129,1024] {
        let mut u=vec![0u8;len];for x in &mut u {seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;*x=seed as u8;}
        for n in 0..=255u8 {assert_eq!(u.contains(&n),u.iter().any(|x|*x==n));total+=1;}
        let nz:Vec<_>=u.iter().map(|x|NonZeroU8::new((*x).max(1)).unwrap()).collect();
        let op:Vec<_>=u.iter().map(|x|NonZeroU8::new(*x)).collect();
        let bs:Vec<_>=u.iter().map(|x|x&1!=0).collect();
        let ac:Vec<_>=u.iter().map(|x|std::ascii::Char::from_u8(*x&127).unwrap()).collect();
        for n in 0..=255u8 {
            let needle=NonZeroU8::new(n);
            assert_eq!(op.contains(&needle),op.iter().any(|x|*x==needle));total+=1;
            if let Some(v)=needle {assert_eq!(nz.contains(&v),nz.iter().any(|x|*x==v));total+=1;}
        }
        for n in [false,true] {assert_eq!(bs.contains(&n),bs.iter().any(|x|*x==n));total+=1;}
        for n in 0..128 {let c=std::ascii::Char::from_u8(n).unwrap();assert_eq!(ac.contains(&c),ac.iter().any(|x|*x==c));total+=1;}
    }
    println!("passed {total} slice comparisons across u8/bool/NonZeroU8/Option<NonZeroU8>/ascii::Char");
}
