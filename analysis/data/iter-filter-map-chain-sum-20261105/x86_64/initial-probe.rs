use std::hint::black_box;
#[inline(never)]#[unsafe(no_mangle)]
pub fn original()->i64{(0i64..1_000_000).chain(0..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn original_dynamic(start:i64,end:i64)->i64{(start..end).chain(start..end).filter_map(|x|x.checked_mul(x)).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn direct_map()->i64{(0i64..1_000_000).chain(0..1_000_000).map(|x|x*x).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn no_blackbox()->i64{(0i64..1_000_000).chain(0..1_000_000).filter_map(|x|x.checked_mul(x)).sum()}
fn main(){let args:Vec<_>=std::env::args().collect();let mode=&args[1];let reps:usize=args[2].parse().unwrap();let start:i64=args.get(3).map_or(0,|s|s.parse().unwrap());let end:i64=args.get(4).map_or(1_000_000,|s|s.parse().unwrap());let f:fn()->i64=match mode.as_str(){"original"=>original,"map"=>direct_map,"no_blackbox"=>no_blackbox,_=>original};
 let expected=(start..end).chain(start..end).filter_map(|x|x.checked_mul(x)).fold(0i64,|a,x|a.wrapping_add(x));
 let now=std::time::Instant::now();for _ in 0..reps{let out=if mode=="dynamic"{original_dynamic(black_box(start),black_box(end))}else{f()};if mode=="dynamic"{assert_eq!(out,expected)}else{assert_eq!(out,666665666667000000)}black_box(out);}println!("{{\"elapsed_ns\":{},\"reps\":{}}}",now.elapsed().as_nanos(),reps);
}
