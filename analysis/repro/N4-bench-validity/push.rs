// slice::push 形:從空 Vec 無界推入(含擴容與缺頁),同 bench 的 vec 永不清空
// 用法:./push 次數
fn main() {
    let n: usize = std::env::args().nth(1).unwrap().parse().unwrap();
    let mut v: Vec<u32> = Vec::new();
    for _ in 0..n { v.push(0); std::hint::black_box(&v); }
}
