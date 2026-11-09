unsafe extern "C" { fn filter_chain_ref_count() -> usize; }
fn main() {
    let reps:usize=std::env::args().last().unwrap().parse().unwrap();
    assert_eq!(unsafe {filter_chain_ref_count()},666_668);
    for _ in 0..reps {std::hint::black_box(unsafe {filter_chain_ref_count()});}
}
