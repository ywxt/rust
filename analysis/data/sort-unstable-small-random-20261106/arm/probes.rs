use std::hint::black_box;
use rand::Rng;
use rand::distr::StandardUniform;

fn input(len: usize, pattern: &str) -> Vec<u64> {
    let seed = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    let mut rng: rand_xorshift::XorShiftRng = rand::SeedableRng::from_seed(seed);
    match pattern {
        "original" => (&mut rng).sample_iter(&StandardUniform).take(len).collect(),
        "ascending" => (0..len as u64).collect(),
        "descending" => (0..len as u64).rev().collect(),
        "equal" => vec![7; len],
        "few" => (0..len).map(|_| rng.random::<u64>() % 4).collect(),
        _ => panic!(),
    }
}

#[inline(never)]
#[unsafe(no_mangle)]
pub fn sort_u64(v: &mut [u64]) { v.sort_unstable(); }

#[inline(never)]
#[unsafe(no_mangle)]
pub fn clone_sort(v: &Vec<u64>) { v.clone().sort_unstable(); }

fn counted_operations(v: &[u64]) -> (usize, usize) {
    let mut a = v.to_vec();
    let (mut comparisons, mut moves) = (0, 0);
    for i in 1..a.len() {
        let key = a[i]; let mut j = i;
        while j > 0 {
            comparisons += 1;
            if key >= a[j-1] { break; }
            a[j] = a[j-1]; moves += 1; j -= 1;
        }
        a[j] = key;
    }
    assert!(a.windows(2).all(|w| w[0] <= w[1]));
    (comparisons, moves)
}

fn check() {
    for len in 0..=64 {
        for pattern in ["original", "ascending", "descending", "equal", "few"] {
            let src = input(len, pattern); let mut got=src.clone();sort_u64(&mut got);
            let mut expected=src.clone();expected.sort();assert_eq!(got,expected);
            let mut comparisons=0;let mut custom=src.clone();custom.sort_unstable_by(|a,b|{comparisons+=1;a.cmp(b)});assert_eq!(custom,expected);
            clone_sort(&src);
            if len==10 && pattern=="original" { println!("input={src:?} comparisons={comparisons} insertion_ops={:?}",counted_operations(&src)); }
        }
    }
    println!("CHECK_OK");
}

fn main() {
    let a: Vec<_> = std::env::args().collect();
    if a[1] == "check" {check();return;}
    let len:usize=a[2].parse().unwrap();let reps:usize=a[4].parse().unwrap();let src=input(len,&a[3]);
    let mut work=src.clone();let mut expected=src.clone();expected.sort();
    let t=std::time::Instant::now();
    match a[1].as_str() {
        "full" => for _ in 0..reps { clone_sort(black_box(&src)); },
        "clone" => for _ in 0..reps { black_box(black_box(&src).clone()); },
        "reset" => for _ in 0..reps { work.copy_from_slice(black_box(&src));black_box(&mut work); },
        "sort" => for _ in 0..reps { work.copy_from_slice(black_box(&src));sort_u64(black_box(&mut work));black_box(&work); },
        "vary" => {
            let mut sets=Vec::new();let mut state=0x123456789abcdefu64;
            for _ in 0..256 {let mut v=Vec::new();for _ in 0..len{state^=state<<13;state^=state>>7;state^=state<<17;v.push(state);}sets.push(v);}
            // This mode reports its own timer so input preparation is excluded.
            let tv=std::time::Instant::now();
            for i in 0..reps {work.copy_from_slice(black_box(&sets[i&255]));sort_u64(black_box(&mut work));black_box(&work);}
            println!("{}",tv.elapsed().as_nanos());assert!(work.windows(2).all(|w|w[0]<=w[1]));return;
        }
        _=>panic!(),
    }
    println!("{}",t.elapsed().as_nanos());
    if a[1]=="sort" {assert_eq!(work,expected);}
}
