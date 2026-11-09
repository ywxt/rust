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
use std::hint::black_box;
fn std_find(x:u8,s:&[u8])->Option<usize>{
    if s.len()<2*std::mem::size_of::<usize>() {
        let mut i=0;
        while i<s.len(){if s[i]==x{return Some(i)}i+=1;}
        None
    }else{unsafe{runtime_memchr(x,s)}}
}
fn crate_find(x:u8,s:&[u8])->Option<usize>{memchr::memchr(x,s)}
fn main(){
    let args:Vec<_>=std::env::args().collect();
    if args[1]=="check"{
        let mut count=0usize;
        for needle in 0..=255u8 {
            let mut data=vec![needle.wrapping_add(1);4352];
            for len in [0,1,7,8,15,16,17,31,32,33,63,64,65,127,128,129,255,256,257,2551,4096]{
                for off in 0..64 {
                    let s=&mut data[off..off+len];
                    assert_eq!(std_find(needle,s),None);assert_eq!(crate_find(needle,s),None);count+=1;
                    if len==0{continue}
                    for pos in [0,len/2,len-1]{
                        s[pos]=needle;
                        assert_eq!(std_find(needle,s),Some(pos));assert_eq!(crate_find(needle,s),Some(pos));count+=1;
                        s[pos]=needle.wrapping_add(1);
                    }
                    if len>2 {
                        s[1]=needle;s[len-1]=needle;
                        assert_eq!(std_find(needle,s),Some(1));assert_eq!(crate_find(needle,s),Some(1));count+=1;
                        s[1]=needle.wrapping_add(1);s[len-1]=needle.wrapping_add(1);
                    }
                }
            }
        }
        println!("passed {count} cases per implementation, all 256 needles");return
    }
    let f:fn(u8,&[u8])->Option<usize>=black_box(match args[1].as_str(){"std"=>std_find,"crate"=>crate_find,_=>panic!()});
    let len:usize=args[2].parse().unwrap();let off:usize=args[3].parse().unwrap();let n:usize=args[5].parse().unwrap();
    #[repr(align(64))]struct Storage([u8;131200]);
    let mut data=Box::new(Storage([128;131200]));
    let pos=match args[4].as_str(){"absent"=>None,"front"=>Some(0),"middle"=>Some(len/2),"last"=>Some(len-1),_=>panic!()};
    if let Some(i)=pos{data.0[off+i]=255;}
    let s=&data.0[off..off+len];assert_eq!(s.as_ptr() as usize%64,off);
    assert_eq!(f(255,s),pos);
    for _ in 0..1000{black_box(f(black_box(255),black_box(s)));}
    let mut sum=0usize;
    for _ in 0..n{sum=sum.wrapping_add(black_box(f(black_box(255),black_box(s))).map_or(0,|i|i+1));}
    assert_eq!(sum,pos.map_or(0,|i|(i+1)*n));println!("n={n} sum={sum}");
}