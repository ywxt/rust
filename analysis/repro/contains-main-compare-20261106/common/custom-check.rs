#![feature(pattern)]
use std::cell::Cell;
use std::str::pattern::Pattern;
struct Custom<'n> { needle: &'n str, calls: &'n Cell<usize>, drops: &'n Cell<usize> }
impl Drop for Custom<'_> { fn drop(&mut self) { self.drops.set(self.drops.get()+1); } }
impl<'n> Pattern for Custom<'n> {
    type Searcher<'h> = <&'n str as Pattern>::Searcher<'h>;
    fn into_searcher(self, haystack: &str) -> Self::Searcher<'_> { self.needle.into_searcher(haystack) }
    fn is_contained_in(self, haystack: &str) -> bool {
        self.calls.set(self.calls.get()+1);
        haystack.contains(self.needle)
    }
}
fn main() {
    for s in ["", "abc", "abc中def", "a!b!"] {
        for n in ["", "!", "中", "abc", "no"] {
            let (ac,ad,bc,bd)=(Cell::new(0),Cell::new(0),Cell::new(0),Cell::new(0));
            let a=s.contains( Custom{needle:n,calls:&ac,drops:&ad});
            let b=s.contains(Custom{needle:n,calls:&bc,drops:&bd});
            assert_eq!((a,ac.get(),ad.get()),(b,bc.get(),bd.get()));
            assert_eq!((ac.get(),ad.get()),(1,1));
        }
        let mut ac=0;let mut bc=0;
        let mut ap=|_:char|{ac+=1;ac==3};let mut bp=|_:char|{bc+=1;bc==3};
        assert_eq!(s.contains(&mut ap),s.contains(&mut bp));
        assert_eq!(ac,bc);
    }
    println!("passed custom Pattern override/drop checks and mutable stateful predicates");
}
