use std::hint::black_box;
const CS:[char;4]=['ö','é','á','ű'];
#[inline(never)]
#[unsafe(no_mangle)]
fn slow(cs:&[char])->usize{black_box(cs).iter().map(|&c|c.escape_debug().len()).sum()}
#[inline(never)]
#[unsafe(no_mangle)]
fn fast(cs:&[char])->usize{black_box(cs).iter().map(|&c|{let u=c as u32;if (0xa1..=0x2ff).contains(&u)&&u!=0xad{1}else{c.escape_debug().len()}}).sum()}
fn main(){
 let a:Vec<_>=std::env::args().collect();let f:fn(&[char])->usize=if a[1]=="slow"{slow}else{fast};let reps:usize=a[2].parse().unwrap();
 assert_eq!(slow(&CS),4);assert_eq!(fast(&CS),4);
 for _ in 0..reps{black_box(f(black_box(&CS)));}
}
