// bench_peek_mut_deref_mut 本體;keep:只把寫入值包一層 black_box(對照,迴圈必須保留)
// 用法:./peek <bench|keep> 外層次數
use std::collections::BinaryHeap;
use std::hint::black_box;
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let (keep, n) = (a[1] == "keep", a[2].parse::<u64>().unwrap());
    let mut bheap = BinaryHeap::from(vec![42u32]);
    let vec: Vec<u32> = (0..1_000_000).collect();
    for _ in 0..n {
        let vec = black_box(&vec);
        let mut peek_mut = bheap.peek_mut().unwrap();
        for &i in vec.iter() {
            *peek_mut = if keep { black_box(i) } else { i };
        }
        std::mem::forget(peek_mut);
    }
}
