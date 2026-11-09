use std::hint::black_box;
#[inline(never)]#[unsafe(no_mangle)]
pub fn original()->i64{(0i64..1_000_000).chain(0..1_000_000).filter_map(|x|x.checked_mul(x)).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn original_dynamic(start:i64,end:i64)->i64{(start..end).chain(start..end).filter_map(|x|x.checked_mul(x)).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn direct_map()->i64{(0i64..1_000_000).chain(0..1_000_000).map(|x|x*x).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn no_blackbox()->i64{(0i64..1_000_000).chain(0..1_000_000).filter_map(|x|x.checked_mul(x)).sum()}

const LIMIT:i64=3_037_000_499;
#[inline(always)]fn square_guard(x:i64)->Option<i64>{if (-LIMIT..=LIMIT).contains(&x){Some(x*x)}else{None}}
#[inline(never)]#[unsafe(no_mangle)]
pub fn guarded()->i64{(0i64..1_000_000).chain(0..1_000_000).filter_map(square_guard).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn guarded_dynamic(start:i64,end:i64)->i64{(start..end).chain(start..end).filter_map(square_guard).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn checked_slice(xs:&[i64])->i64{xs.iter().copied().chain(xs.iter().copied()).filter_map(|x|x.checked_mul(x)).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn guarded_slice(xs:&[i64])->i64{xs.iter().copied().chain(xs.iter().copied()).filter_map(square_guard).map(black_box).sum()}
#[inline(never)]#[unsafe(no_mangle)]
pub fn unrolled_dynamic(start:i64,end:i64)->i64{
 let mut sum=0i64;for _ in 0..2 {let mut i=start;while i<end {
  if end.saturating_sub(i)>=4 {
   for off in 0..4 {if let Some(v)=(i+off).checked_mul(i+off){sum=sum.wrapping_add(black_box(v));}}i+=4;
  }else {if let Some(v)=i.checked_mul(i){sum=sum.wrapping_add(black_box(v));}i+=1;}
 }}sum
}
fn dataset(n:usize,kind:&str)->Vec<i64>{let mut state=0x123456789abcdefu64;(0..n).map(|i|{state^=state<<13;state^=state>>7;state^=state<<17;match kind{
 "all_valid"=>(state%2_000_001)as i64-1_000_000,
 "all_overflow"=>if i%2==0{i64::MIN}else{i64::MAX},
 "alternating"=>if i%2==0{(state%1_000_000)as i64}else{i64::MAX},
 "clustered"=>if i<n/2{(state%1_000_000)as i64}else{i64::MAX},
 "random"=>if state&1==0{(state%1_000_000)as i64}else{i64::MAX},
 "boundary"=>[-LIMIT-1,-LIMIT,-LIMIT+1,-1,0,1,LIMIT-1,LIMIT,LIMIT+1,i64::MIN,i64::MAX][i%11],
 _=>panic!("bad dataset")}}).collect()}
fn check(){
 let bounds=[i64::MIN,i64::MIN+1,-LIMIT-1,-LIMIT,-LIMIT+1,-1,0,1,LIMIT-1,LIMIT,LIMIT+1,i64::MAX-1,i64::MAX];
 for x in bounds{assert_eq!(x.checked_mul(x),square_guard(x));}
 let mut state=0xa134bdcdabcd1234u64;for _ in 0..1_000_000{state^=state<<13;state^=state>>7;state^=state<<17;let x=state as i64;assert_eq!(x.checked_mul(x),square_guard(x));}
 for &(start,end)in &[(0,0),(0,1),(0,3),(0,4),(0,5),(0,17),(-17,19),(0,1_000_000),(LIMIT-10,LIMIT+10),(-LIMIT-10,-LIMIT+10),(i64::MIN,i64::MIN+10),(i64::MAX-10,i64::MAX),(5,0)]{
  let want=(start..end).chain(start..end).filter_map(|x|x.checked_mul(x)).fold(0i64,|a,x|a.wrapping_add(x));assert_eq!(original_dynamic(start,end),want);assert_eq!(guarded_dynamic(start,end),want);assert_eq!(unrolled_dynamic(start,end),want);
 }
 for n in [0,1,2,3,4,5,7,8,9,15,16,17,31,32,33,4096]{for k in ["all_valid","all_overflow","alternating","clustered","random","boundary"]{let xs=dataset(n,k);assert_eq!(checked_slice(&xs),guarded_slice(&xs));}}
 assert_eq!(original(),666665666667000000);assert_eq!(guarded(),original());assert_eq!(direct_map(),original());println!("boundary, 1000000 random scalars, ranges and all dataset/length cases passed");
}
fn main(){let args:Vec<_>=std::env::args().collect();let mode=&args[1];if mode=="check"{check();return}let reps:usize=args[2].parse().unwrap();let start:i64=args.get(3).map_or(0,|s|s.parse().unwrap());let end:i64=args.get(4).map_or(1_000_000,|s|s.parse().unwrap());let kind=args.get(5).map_or("all_valid",|s|s.as_str());let xs=if mode.ends_with("slice"){dataset(end as usize,kind)}else{Vec::new()};let now=std::time::Instant::now();
 for _ in 0..reps{let out=match mode.as_str(){"original"=>original(),"map"=>direct_map(),"no_blackbox"=>no_blackbox(),"guarded"=>guarded(),"dynamic"=>original_dynamic(black_box(start),black_box(end)),"guarded_dynamic"=>guarded_dynamic(black_box(start),black_box(end)),"unrolled_dynamic"=>unrolled_dynamic(black_box(start),black_box(end)),"checked_slice"=>checked_slice(black_box(&xs)),"guarded_slice"=>guarded_slice(black_box(&xs)),_=>panic!("bad mode")};black_box(out);}
 println!("{{\"elapsed_ns\":{},\"reps\":{}}}",now.elapsed().as_nanos(),reps);
}
