#![feature(test)]
extern crate test;
use std::hint::black_box;
include!("fixtures.rs");
pub fn std_str(s:&str)->bool { s.contains("!") }
pub fn std_char(s:&str)->bool { s.contains('!') }
pub fn word16(s:&str)->bool {
    const LO:u64=0x0101010101010101;
    const HI:u64=0x8080808080808080;
    let mut chunks=s.as_bytes().chunks_exact(16);
    for c in &mut chunks {
        let x=u64::from_ne_bytes(c[..8].try_into().unwrap())^0x2121212121212121;
        let y=u64::from_ne_bytes(c[8..].try_into().unwrap())^0x2121212121212121;
        let mask=(x.wrapping_sub(LO)&!x)|(y.wrapping_sub(LO)&!y);
        if mask&HI!=0 { return true; }
    }
    chunks.remainder().iter().any(|&b|b==b'!')
}
pub fn fold16(s:&str)->bool {
    let bytes=s.as_bytes();
    let mut chunks=bytes.chunks_exact(16);
    for c in &mut chunks {
        if c.iter().fold(false,|a,&b|a|(b==b'!')) { return true; }
    }
    if bytes.len()>=16 && !chunks.remainder().is_empty() {
        bytes[bytes.len()-16..].iter().fold(false,|a,&b|a|(b==b'!'))
    } else {
        chunks.remainder().iter().any(|&b|b==b'!')
    }
}
pub fn fold64(s:&str)->bool {
    let bytes=s.as_bytes();
    if bytes.len()<64 { return fold16(s); }
    let mut chunks=bytes.chunks_exact(64);
    for c in &mut chunks {
        if c.iter().fold(false,|a,&b|a|(b==b'!')) { return true; }
    }
    if !chunks.remainder().is_empty() {
        bytes[bytes.len()-64..].iter().fold(false,|a,&b|a|(b==b'!'))
    } else { false }
}
pub fn columns64(s:&str)->bool {
    let bytes=s.as_bytes();
    if bytes.len()<64 {return fold16(s);}
    let mut chunks=bytes.chunks_exact(64);
    for c in &mut chunks {
        if (0..16).fold(false,|a,i|a|(c[i]==b'!')|(c[i+16]==b'!')|(c[i+32]==b'!')|(c[i+48]==b'!')) { return true; }
    }
    if !chunks.remainder().is_empty() {
        let c=&bytes[bytes.len()-64..];
        (0..16).fold(false,|a,i|a|(c[i]==b'!')|(c[i+16]==b'!')|(c[i+32]==b'!')|(c[i+48]==b'!'))
    } else {false}
}
pub fn choose(s:&str)->fn(&str)->bool {
    match s {"std_str"=>std_str,"std_char"=>std_char,"word16"=>word16,"fold16"=>fold16,"fold64"=>fold64,"columns64"=>columns64,_=>panic!()}
}

macro_rules! bench_case {
    ($name:ident,$index:expr,$scan:expr)=>{
        #[bench]
        fn $name(b:&mut test::Bencher) {
            let mut s=CASES[$index].1;
            black_box(&mut s);
            b.iter(|| { black_box(($scan)(s)); });
        }
    };
}
macro_rules! group {
    ($name:ident,$scan:expr)=>{
        mod $name {
            use super::*;
            bench_case!(short_ascii,0,$scan);
            bench_case!(short_mixed,1,$scan);
            bench_case!(short_pile_of_poo,2,$scan);
            bench_case!(long_lorem_ipsum,3,$scan);
        }
    };
}
mod str {
    use super::*;
    group!(contains_bang_str,|s:&str|s.contains("!"));
    group!(contains_bang_char,|s:&str|s.contains('!'));
    group!(columns64_str,|s:&str|columns64(s));
    group!(columns64_char,|s:&str|columns64(s));
}
