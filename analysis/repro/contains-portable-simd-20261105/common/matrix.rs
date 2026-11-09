use std::hint::black_box;
fn main_str(s: &str, n: &str) -> bool { s.contains(n) }
fn optimized_str(s: &str, n: &str) -> bool { s.contains(n) }
fn main() {
    let args:Vec<String>=std::env::args().collect();
    let mut f=black_box(match args[1].as_str() {"main"=>main_str as fn(&str,&str)->bool,"optimized"=>optimized_str,_=>panic!()});
    if args.get(7).map(String::as_str)==Some("char") { f=black_box(|s: &str,n: &str|s.contains(n.as_bytes()[0] as char)); }
    let len:usize=args[2].parse().unwrap();let offset:usize=args[3].parse().unwrap();
    let needle:u8=args[5].parse().unwrap();assert!(needle.is_ascii());
    let needle_bytes=[needle];let n=std::str::from_utf8(&needle_bytes).unwrap();
    let iters:usize=args[6].parse().unwrap();
    #[repr(align(64))]struct Storage([u8;65664]);
    let mut data=Box::new(Storage([b'x';65664]));
    let pos=match args[4].as_str(){"absent"=>None,"front"=>Some(0),"last"=>Some(len-1),"middle"=>Some(len/2),_=>panic!()};
    if let Some(p)=pos {data.0[offset+p]=needle;}
    let s=std::str::from_utf8(&data.0[offset..offset+len]).unwrap();assert_eq!(s.as_ptr() as usize%64,offset);
    assert_eq!(f(black_box(s),black_box(n)),pos.is_some());
    let mut count=0usize;
    for _ in 0..iters {count+=black_box(f(black_box(s),black_box(n))) as usize;}
    assert_eq!(count,if pos.is_some(){iters}else{0});println!("n={iters} count={count}");
}
