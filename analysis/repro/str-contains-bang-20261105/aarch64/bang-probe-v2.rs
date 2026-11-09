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
fn main() {
    let args:Vec<String>=std::env::args().collect();
    if args[1]=="metadata" {
        for &(name,s) in CASES { println!("{name} len={} first={:?} last={:?}",s.len(),s.find('!'),s.rfind('!')); }
        return;
    }
    if args[1]=="check" {
        let mut ncheck=0;
        let lengths:Vec<usize>=(0..=70).chain(95..=130).chain([255,256,257,1023,1024,2551,4096]).collect();
        for len in lengths {
            for offset in 0..32 {
                let mut data=vec![b'x';len+64];
                for pos in [None,Some(0),Some(len/2),len.checked_sub(1)] {
                    data.fill(b'x');
                    if let Some(p)=pos { if p<len { data[offset+p]=b'!'; } }
                    let s=std::str::from_utf8(&data[offset..offset+len]).unwrap();
                    let expected=s.as_bytes().iter().any(|&b|b==b'!');
                    for mode in ["std_str","std_char","word16","fold16","fold64","columns64"] {
                        assert_eq!(choose(mode)(black_box(s)),expected,"{mode} len={len} offset={offset}");
                        ncheck+=1;
                    }
                }
            }
        }
        for unit in ["中","💩","abc","é"] {
            for n in [0,1,3,16,65,1024] {
                let mut s=unit.repeat(n);
                for yes in [false,true] {
                    if yes { s.push('!'); }
                    for mode in ["std_str","std_char","word16","fold16","fold64","columns64"] {
                        assert_eq!(choose(mode)(black_box(&s)),yes);
                        ncheck+=1;
                    }
                }
            }
        }
        println!("passed {ncheck} comparisons");
        return;
    }
    let mode=&args[1];let index:usize=args[2].parse().unwrap();let n:usize=args[3].parse().unwrap();
    let mut s=CASES[index].1;black_box(&mut s);
    let f=black_box(choose(mode));
    for _ in 0..n { black_box(f(s)); }
}
