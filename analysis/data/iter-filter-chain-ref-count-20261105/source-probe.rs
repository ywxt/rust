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
#[inline(never)]
#[unsafe(no_mangle)]
pub fn source_unroll4() -> usize {
    let mut total=0;
    for _ in 0..2 {
        let mut counts=[0usize;4];
        for i in (0i64..1_000_000).step_by(4) {
            counts[0] += usize::from(black_box(i) % 3 == 0);
            counts[1] += usize::from(black_box(i+1) % 3 == 0);
            counts[2] += usize::from(black_box(i+2) % 3 == 0);
            counts[3] += usize::from(black_box(i+3) % 3 == 0);
        }
        total+=counts.iter().sum::<usize>();
    }
    total
}
#[inline(never)]
#[unsafe(no_mangle)]
pub fn source_unroll4_one_acc() -> usize {
    let mut count=0;
    for _ in 0..2 {
        for i in (0i64..1_000_000).step_by(4) {
            count+=usize::from(black_box(i)%3==0);
            count+=usize::from(black_box(i+1)%3==0);
            count+=usize::from(black_box(i+2)%3==0);
            count+=usize::from(black_box(i+3)%3==0);
        }
    }
    count
}
fn main() {
    let args: Vec<_>=std::env::args().collect();
    let f: fn()->usize=match args[1].as_str(){
        "source_unroll4"=>source_unroll4,"source_unroll4_one_acc"=>source_unroll4_one_acc,"original"=>original,"owned"=>owned,"split"=>split,"manual"=>manual,"unsigned"=>unsigned,"no_modulus"=>no_modulus,_=>panic!()
    };
    assert_eq!(f(),if args[1]=="no_modulus"{1_000_000}else{666_668});
    let reps:usize=args[2].parse().unwrap();
    for _ in 0..reps { black_box(f()); }
}
