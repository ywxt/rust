use std::hint::black_box;
unsafe extern "C"{fn repro()->i64;}
fn main(){let args:Vec<_>=std::env::args().collect();let reps:usize=args[2].parse().unwrap();let now=std::time::Instant::now();for _ in 0..reps{let out=unsafe{repro()};assert_eq!(out,333332833333500000);black_box(out);}println!("{{\"elapsed_ns\":{},\"reps\":{}}}",now.elapsed().as_nanos(),reps);}
