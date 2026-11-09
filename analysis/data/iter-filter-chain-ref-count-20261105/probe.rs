use std::hint::black_box;
#[inline(never)]
#[unsafe(no_mangle)]
pub fn original() -> usize {
    (0i64..1_000_000).chain(0..1_000_000).map(black_box).by_ref().filter(|x| x % 3 == 0).count()
}
#[inline(never)]
#[unsafe(no_mangle)]
pub fn owned() -> usize {
    (0i64..1_000_000).chain(0..1_000_000).map(black_box).filter(|x| x % 3 == 0).count()
}
#[inline(never)]
#[unsafe(no_mangle)]
pub fn split() -> usize {
    (0i64..1_000_000).map(black_box).filter(|x| x % 3 == 0).count()
    + (0i64..1_000_000).map(black_box).filter(|x| x % 3 == 0).count()
}
#[inline(never)]
#[unsafe(no_mangle)]
pub fn manual() -> usize {
    let mut count=0;
    for _ in 0..2 {
        for i in 0i64..1_000_000 {
            count += usize::from(black_box(i) % 3 == 0);
        }
    }
    count
}
#[inline(never)]
#[unsafe(no_mangle)]
pub fn unsigned() -> usize {
    (0u64..1_000_000).chain(0..1_000_000).map(black_box).by_ref().filter(|x| x % 3 == 0).count()
}
#[inline(never)]
#[unsafe(no_mangle)]
pub fn no_modulus() -> usize {
    (0i64..1_000_000).chain(0..1_000_000).map(black_box).by_ref().filter(|x| x & 1 == 0).count()
}
fn main() {
    let args: Vec<_>=std::env::args().collect();
    let f: fn()->usize=match args[1].as_str(){
        "original"=>original,"owned"=>owned,"split"=>split,"manual"=>manual,"unsigned"=>unsigned,"no_modulus"=>no_modulus,_=>panic!()
    };
    assert_eq!(f(),if args[1]=="no_modulus"{1_000_000}else{666_668});
    let reps:usize=args[2].parse().unwrap();
    for _ in 0..reps { black_box(f()); }
}
