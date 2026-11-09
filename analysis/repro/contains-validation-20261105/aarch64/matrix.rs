use std::hint::black_box;

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

#[cfg(target_arch="aarch64")]
fn block64(c:&[u8])->bool {
    use std::arch::aarch64::*;
    assert_eq!(c.len(),64);
    unsafe {
        let p=c.as_ptr();let needle=vdupq_n_u8(b'!');
        let a=vceqq_u8(vld1q_u8(p),needle);
        let b=vceqq_u8(vld1q_u8(p.add(16)),needle);
        let d=vceqq_u8(vld1q_u8(p.add(32)),needle);
        let e=vceqq_u8(vld1q_u8(p.add(48)),needle);
        vmaxvq_u8(vorrq_u8(vorrq_u8(a,b),vorrq_u8(d,e)))!=0
    }
}
#[cfg(target_arch="x86_64")]
fn block64(c:&[u8])->bool {
    use std::arch::x86_64::*;
    assert_eq!(c.len(),64);
    unsafe {
        let p=c.as_ptr().cast::<__m128i>();let needle=_mm_set1_epi8(b'!' as i8);
        let a=_mm_cmpeq_epi8(_mm_loadu_si128(p),needle);
        let b=_mm_cmpeq_epi8(_mm_loadu_si128(p.add(1)),needle);
        let d=_mm_cmpeq_epi8(_mm_loadu_si128(p.add(2)),needle);
        let e=_mm_cmpeq_epi8(_mm_loadu_si128(p.add(3)),needle);
        _mm_movemask_epi8(_mm_or_si128(_mm_or_si128(a,b),_mm_or_si128(d,e)))!=0
    }
}
pub fn simd64(s:&str)->bool {
    let bytes=s.as_bytes();
    if bytes.len()<64 { return fold16(s); }
    let mut chunks=bytes.chunks_exact(64);
    for c in &mut chunks { if block64(c) { return true; } }
    if !chunks.remainder().is_empty() {
        block64(&bytes[bytes.len()-64..])
    } else {false}
}
pub fn aligned64(s:&str)->bool {
    let bytes=s.as_bytes();
    if bytes.len()<128 { return simd64(s); }
    let prefix=bytes.as_ptr().align_offset(16);
    if prefix!=0 && bytes[..16].iter().fold(false,|a,&b|a|(b==b'!')) { return true; }
    let mut chunks=bytes[prefix..].chunks_exact(64);
    for c in &mut chunks { if block64(c) { return true; } }
    if !chunks.remainder().is_empty() {
        block64(&bytes[bytes.len()-64..])
    } else {false}
}
pub fn align32_scan64(s:&str)->bool {
    let bytes=s.as_bytes();
    if bytes.len()<128 { return simd64(s); }
    let prefix=bytes.as_ptr().align_offset(32);
    if prefix!=0 && bytes[..32].iter().fold(false,|a,&b|a|(b==b'!')) { return true; }
    let mut chunks=bytes[prefix..].chunks_exact(64);
    for c in &mut chunks { if block64(c) { return true; } }
    if !chunks.remainder().is_empty() { block64(&bytes[bytes.len()-64..]) } else {false}
}
pub fn align64_scan64(s:&str)->bool {
    let bytes=s.as_bytes();
    if bytes.len()<128 { return simd64(s); }
    let prefix=bytes.as_ptr().align_offset(64);
    if prefix!=0 && block64(&bytes[..64]) { return true; }
    let mut chunks=bytes[prefix..].chunks_exact(64);
    for c in &mut chunks { if block64(c) { return true; } }
    if !chunks.remainder().is_empty() { block64(&bytes[bytes.len()-64..]) } else {false}
}
pub fn choose(s:&str)->fn(&str)->bool {
    match s {"std_str"=>std_str,"std_char"=>std_char,"word16"=>word16,"fold16"=>fold16,"fold64"=>fold64,"columns64"=>columns64,"simd64"=>simd64,"aligned64"=>aligned64,"align32"=>align32_scan64,"align64"=>align64_scan64,_=>panic!()}
}
fn main() {
    let args:Vec<String>=std::env::args().collect();
    if args[1]=="check" {
        let mut checks=0;
        for len in (0..=260).chain([511,512,513,2551,65536]) {
            for offset in 0..64 {
                let mut data=vec![b'x';len+128];
                for pos in [None,Some(0),Some(len/2),len.checked_sub(1)] {
                    data.fill(b'x');
                    if let Some(i)=pos {if i<len {data[offset+i]=b'!';}}
                    let s=std::str::from_utf8(&data[offset..offset+len]).unwrap();
                    for f in [std_str as fn(&str)->bool,simd64,align64_scan64] {
                        assert_eq!(f(black_box(s)),s.contains('!')); checks+=1;
                    }
                }
            }
        }
        println!("passed {checks} comparisons"); return;
    }
    let f=black_box(choose(&args[1]));
    let len:usize=args[2].parse().unwrap(); let offset:usize=args[3].parse().unwrap();
    let n:usize=args[5].parse().unwrap();
    #[repr(align(64))] struct Storage([u8;65664]);
    let mut data=Box::new(Storage([b'x';65664]));
    let pos=match args[4].as_str() {"absent"=>None,"front"=>Some(0),"middle"=>Some(len/2),"last"=>len.checked_sub(1),_=>panic!()};
    if let Some(i)=pos {assert!(i<len);data.0[offset+i]=b'!';}
    let s=std::str::from_utf8(&data.0[offset..offset+len]).unwrap();
    assert_eq!(s.as_ptr() as usize%64,offset);assert_eq!(f(black_box(s)),pos.is_some());
    let mut count=0usize;
    for _ in 0..n { count+=black_box(f(black_box(s))) as usize; }
    assert_eq!(count,if pos.is_some(){n}else{0}); println!("n={n} count={count}");
}
