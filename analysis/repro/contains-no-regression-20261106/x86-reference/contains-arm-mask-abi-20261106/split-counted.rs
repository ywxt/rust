mod test {
    pub struct Bencher {pub n:usize}
    impl Bencher {pub fn iter<T,F:FnMut()->T>(&mut self,mut f:F){for _ in 0..self.n{std::hint::black_box(f());}}}
}
use std::hint::black_box;
use test::Bencher;
pub fn split_unicode_ascii(b: &mut Bencher) {
    let s = "ประเทศไทย中华Việt Namประเทศไทย中华Việt Nam";

    b.iter(|| assert_eq!(black_box(s).split('V').count(), 3));
}
pub fn split_ascii(b: &mut Bencher) {
    let s = "Mary had a little lamb, Little lamb, little-lamb.";
    let len = black_box(s).split(' ').count();

    b.iter(|| assert_eq!(black_box(s).split(' ').count(), len));
}
pub fn split_extern_fn(b: &mut Bencher) {
    let s = "Mary had a little lamb, Little lamb, little-lamb.";
    let len = black_box(s).split(' ').count();
    fn pred(c: char) -> bool {
        c == ' '
    }

    b.iter(|| assert_eq!(black_box(s).split(pred).count(), len));
}
pub fn split_closure(b: &mut Bencher) {
    let s = "Mary had a little lamb, Little lamb, little-lamb.";
    let len = black_box(s).split(' ').count();

    b.iter(|| assert_eq!(black_box(s).split(|c: char| c == ' ').count(), len));
}
pub fn split_slice(b: &mut Bencher) {
    let s = "Mary had a little lamb, Little lamb, little-lamb.";
    let len = black_box(s).split(' ').count();

    let c: &[char] = &[' '];
    b.iter(|| assert_eq!(black_box(s).split(c).count(), len));
}
fn main(){let a:Vec<_>=std::env::args().collect();let f=black_box(match a[1].as_str(){"split_unicode_ascii"=>split_unicode_ascii as fn(&mut Bencher),"split_ascii"=>split_ascii as fn(&mut Bencher),"split_extern_fn"=>split_extern_fn as fn(&mut Bencher),"split_closure"=>split_closure as fn(&mut Bencher),"split_slice"=>split_slice as fn(&mut Bencher),_=>panic!()});let n=a[2].parse().unwrap();eprintln!("personality={}",std::fs::read_to_string("/proc/self/personality").unwrap().trim());f(&mut Bencher{n});println!("completed {n} split workloads");}
