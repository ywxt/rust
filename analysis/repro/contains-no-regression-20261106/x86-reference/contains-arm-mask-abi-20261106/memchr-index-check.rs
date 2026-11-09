#[cfg(target_arch="aarch64")]
unsafe extern "Rust" {
    #[link_name="_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned"]
    fn runtime_memchr(x:u8,text:&[u8])->Option<usize>;
}
#[cfg(target_arch="x86_64")]
unsafe extern "Rust" {
    #[link_name="_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned"]
    fn runtime_memchr(x:u8,text:&[u8])->Option<usize>;
}
fn main() {
    #[repr(align(64))]struct Storage([u8;1152]);
    let mut data=Box::new(Storage([0;1152]));let mut total=0usize;
    let lengths:Vec<usize>=(16..=70).chain([79,80,95,96,127,128,129,255,256,257,1024]).collect();
    for n in 0..=255u8 {for &len in &lengths {for off in 0..64 {
        data.0.fill(n.wrapping_add(1));let s=&mut data.0[off..off+len];
        assert_eq!(unsafe{runtime_memchr(n,s)},None);total+=1;
        for pos in [0,len/2,len-1] {s[pos]=n;assert_eq!(unsafe{runtime_memchr(n,s)},Some(pos));total+=1;s[pos]=n.wrapping_add(1);}
        s[1]=n;s[len-2]=n;assert_eq!(unsafe{runtime_memchr(n,s)},Some(1));total+=1;
    }}}
    let mut state=0x123456789abcdef0u64;
    for len in [16,17,31,32,63,64,65,127,128,129,2551,65536] {for _ in 0..32 {
        let mut s=vec![0u8;len];for b in &mut s {state^=state<<13;state^=state>>7;state^=state<<17;*b=state as u8;}
        for n in 0..=255u8 {assert_eq!(unsafe{runtime_memchr(n,&s)},s.iter().position(|x|*x==n));total+=1;}
    }}
    println!("passed {total} direct memchr first-index comparisons, all 256 needles");
}
