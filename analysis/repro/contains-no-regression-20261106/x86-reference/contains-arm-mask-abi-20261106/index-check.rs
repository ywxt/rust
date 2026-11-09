use std::hint::black_box;
fn main() {
    let mut total=0usize;
    let lengths:Vec<usize>=(0..=70).chain([79,80,95,96,127,128,129,255,256,257,1024]).collect();
    #[repr(align(64))]struct Storage([u8;1152]);
    let mut data=Box::new(Storage([b'x';1152]));
    for needle in 0..128u8 {for &len in &lengths {for off in 0..64 {
        let fill=if needle==b'x'{b'y'}else{b'x'};data.0.fill(fill);
        let b=&mut data.0[off..off+len];
        let positions=if len==0{vec![]}else{vec![0,len/2,len-1]};
        let ns=[needle];let n=std::str::from_utf8(&ns).unwrap();
        let s=std::str::from_utf8(b).unwrap();
        assert_eq!(black_box(s).find(black_box(n)),None);assert_eq!(s.find(needle as char),None);total+=2;
        for pos in positions {
            b[pos]=needle;
            let s=std::str::from_utf8(b).unwrap();
            assert_eq!(black_box(s).find(black_box(n)),Some(pos));assert_eq!(s.find(needle as char),Some(pos));total+=2;
            assert_eq!(s.match_indices(n).map(|x|x.0).collect::<Vec<_>>(),vec![pos]);total+=1;
            b[pos]=fill;
        }
        if len>2 {
            b[0]=needle;b[len/2]=needle;b[len-1]=needle;
            let s=std::str::from_utf8(b).unwrap();
            let expected:Vec<_>=b.iter().enumerate().filter_map(|(i,&v)|(v==needle).then_some(i)).collect();
            assert_eq!(s.match_indices(n).map(|x|x.0).collect::<Vec<_>>(),expected);assert_eq!(s.find(n),Some(0));assert_eq!(s.rfind(n),Some(len-1));total+=3;
        }
    }}}
    let mut state=0x123456789abcdef0u64;
    for len in [16,17,31,32,63,64,65,127,128,129,2551] {for _ in 0..128 {
        let mut v=vec![0u8;len];for b in &mut v {state^=state<<13;state^=state>>7;state^=state<<17;*b=state as u8&127;}
        let s=std::str::from_utf8(&v).unwrap();
        for n in 0..128u8 {let ns=[n];let needle=std::str::from_utf8(&ns).unwrap();let expected=v.iter().position(|x|*x==n);assert_eq!(black_box(s).find(black_box(needle)),expected);assert_eq!(s.find(n as char),expected);total+=2;}
    }}
    for reps in [0,1,2,3,4,8,16,31,32,33,64,65] {
        let s="aé中💩\0".repeat(reps);
        for c in ['a','é','中','💩','国','\0'] {
            let expected=s.char_indices().find_map(|(i,x)|(x==c).then_some(i));
            assert_eq!(s.find(c),expected);let ns=c.to_string();assert_eq!(s.find(ns.as_str()),expected);total+=2;
        }
    }
    println!("passed {total} first-index/match-order comparisons");
}
