use std::any::{Any, TypeId};
use std::hint::black_box;

#[inline(never)]
fn isolated(x: &dyn Any) -> Option<&isize> { x.downcast_ref::<isize>() }

#[inline(never)]
fn base(n: u64) {
    for _ in 0..n {
        let mut x = 0isize;
        let mut y = &mut x as &mut dyn Any;
        black_box(&mut y);
        black_box(y.downcast_ref::<isize>() == Some(&0));
    }
}

#[inline(never)]
fn boundary(n: u64) {
    for _ in 0..n {
        let mut x = 0isize;
        let mut y = &mut x as &mut dyn Any;
        black_box(&mut y);
        black_box(isolated(y) == Some(&0));
    }
}

#[inline(never)]
fn value(n: u64) {
    for _ in 0..n {
        let mut x = 0isize;
        let y = black_box(&mut x as &mut dyn Any);
        black_box(y.downcast_ref::<isize>() == Some(&0));
    }
}

#[inline(never)]
fn repeated(n: u64, y: &dyn Any) {
    for _ in 0..n { black_box(black_box(y).downcast_ref::<isize>() == Some(&0)); }
}

#[inline(never)]
fn repeated_boundary(n: u64, y: &dyn Any) {
    for _ in 0..n { black_box(isolated(black_box(y)) == Some(&0)); }
}

trait ArrayId { fn array_id(&self) -> [u64; 2]; }
trait PairId { fn pair_id(&self) -> (u64, u64); }
impl<T: Any> ArrayId for T {
    fn array_id(&self) -> [u64; 2] { unsafe { std::mem::transmute(TypeId::of::<T>()) } }
}
impl<T: Any> PairId for T {
    fn pair_id(&self) -> (u64, u64) { unsafe { std::mem::transmute(TypeId::of::<T>()) } }
}
#[inline(never)]
fn array(n: u64) {
    let expected: [u64; 2] = unsafe { std::mem::transmute(TypeId::of::<isize>()) };
    for _ in 0..n {
        let mut x=0isize;
        let mut y=&mut x as &mut dyn ArrayId;
        black_box(&mut y);
        black_box(ArrayId::array_id(&*y)==expected);
    }
}
#[inline(never)]
fn pair(n: u64) {
    let expected: (u64,u64) = unsafe { std::mem::transmute(TypeId::of::<isize>()) };
    for _ in 0..n {
        let mut x=0isize;
        let mut y=&mut x as &mut dyn PairId;
        black_box(&mut y);
        black_box(PairId::pair_id(&*y)==expected);
    }
}
#[inline(never)]
fn persistent(n: u64) {
    let mut x=0isize;
    let mut y=&mut x as &mut dyn Any;
    for _ in 0..n {
        black_box(&mut y);
        black_box(y.downcast_ref::<isize>()==Some(&0));
    }
}
#[inline(never)]
fn persistent_wide(n: u64) {
    let mut x=0isize;
    let mut y=&mut x as &mut dyn Any;
    for _ in 0..n {
        black_box(&mut y);
        black_box((y.downcast_ref::<isize>()==Some(&0)) as usize);
    }
}
#[inline(never)]
fn value_wide(n: u64) {
    for _ in 0..n {
        let mut x=0isize;
        let y=black_box(&mut x as &mut dyn Any);
        black_box((y.downcast_ref::<isize>()==Some(&0)) as usize);
    }
}
#[inline(never)]
fn pair_value(n: u64) {
    let expected:(u64,u64)=unsafe{std::mem::transmute(TypeId::of::<isize>())};
    for _ in 0..n {
        let mut x=0isize;
        let y=black_box(&mut x as &mut dyn PairId);
        black_box(PairId::pair_id(&*y)==expected);
    }
}
#[inline(never)]
fn array_value(n: u64) {
    let expected:[u64;2]=unsafe{std::mem::transmute(TypeId::of::<isize>())};
    for _ in 0..n {
        let mut x=0isize;
        let y=black_box(&mut x as &mut dyn ArrayId);
        black_box(ArrayId::array_id(&*y)==expected);
    }
}
fn check_one<T: Any>(v: T) {
    let x: &dyn Any=&v;
    assert_eq!(isolated(x),x.downcast_ref::<isize>());
    let a: &dyn ArrayId=&v;
    let p: &dyn PairId=&v;
    let expected: [u64;2]=unsafe{std::mem::transmute(x.type_id())};
    let aa=ArrayId::array_id(a);let pp=PairId::pair_id(p);
    assert_eq!(aa,expected);assert_eq!([pp.0,pp.1],expected);
}
fn check() {
    for i in -1024isize..1024 {check_one(i);check_one(i as u64);check_one([i;3]);}
    check_one(String::from("test"));check_one(Vec::<u8>::new());check_one(());
    println!("checks passed: hit, miss, values, array/pair TypeId bits");
}
fn main() {
    let mut args=std::env::args().skip(1);let mode=args.next().unwrap();
    if mode=="check" { check();return; }
    let n=args.next().unwrap().parse().unwrap();
    match mode.as_str() {
        "base"=>base(n),"boundary"=>boundary(n),"value"=>value(n),
        "repeated"=>repeated(n,black_box(&0isize as &dyn Any)),
        "repeated_boundary"=>repeated_boundary(n,black_box(&0isize as &dyn Any)),
        "array"=>array(n),"pair"=>pair(n),"persistent"=>persistent(n),"persistent_wide"=>persistent_wide(n),"value_wide"=>value_wide(n),"pair_value"=>pair_value(n),"array_value"=>array_value(n),_=>panic!(),
    }
}
