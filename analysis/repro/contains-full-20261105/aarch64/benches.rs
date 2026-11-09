#![feature(test, pattern, specialization)]
#![allow(incomplete_features)]
extern crate test;
mod contains_impl;
use std::hint::black_box;
use std::str::pattern::Pattern;
use test::Bencher;
include!("fixtures.rs");
fn baseline<P: Pattern>(s: &str, p: P) -> bool { s.contains(p) }
static LONG_HAYSTACK: &str = "\
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse quis lorem sit amet dolor \
ultricies condimentum. Praesent iaculis purus elit, ac malesuada quam malesuada in. Duis sed orci \
eros. Suspendisse sit amet magna mollis, mollis nunc luctus, imperdiet mi. Integer fringilla non \
sem ut lacinia. Fusce varius tortor a risus porttitor hendrerit. Morbi mauris dui, ultricies nec \
tempus vel, gravida nec quam.

In est dui, tincidunt sed tempus interdum, adipiscing laoreet ante. Etiam tempor, tellus quis \
sagittis interdum, nulla purus mattis sem, quis auctor erat odio ac tellus. In nec nunc sit amet \
diam volutpat molestie at sed ipsum. Vestibulum laoreet consequat vulputate. Integer accumsan \
lorem ac dignissim placerat. Suspendisse convallis faucibus lorem. Aliquam erat volutpat. In vel \
eleifend felis. Sed suscipit nulla lorem, sed mollis est sollicitudin et. Nam fermentum egestas \
interdum. Curabitur ut nisi justo.

Sed sollicitudin ipsum tellus, ut condimentum leo eleifend nec. Cras ut velit ante. Phasellus nec \
mollis odio. Mauris molestie erat in arcu mattis, at aliquet dolor vehicula. Quisque malesuada \
lectus sit amet nisi pretium, a condimentum ipsum porta. Morbi at dapibus diam. Praesent egestas \
est sed risus elementum, eu rutrum metus ultrices. Etiam fermentum consectetur magna, id rutrum \
felis accumsan a. Aliquam ut pellentesque libero. Sed mi nulla, lobortis eu tortor id, suscipit \
ultricies neque. Morbi iaculis sit amet risus at iaculis. Praesent eget ligula quis turpis \
feugiat suscipit vel non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. \
Aliquam sit amet placerat lorem.

Cras a lacus vel ante posuere elementum. Nunc est leo, bibendum ut facilisis vel, bibendum at \
mauris. Nullam adipiscing diam vel odio ornare, luctus adipiscing mi luctus. Nulla facilisi. \
Mauris adipiscing bibendum neque, quis adipiscing lectus tempus et. Sed feugiat erat et nisl \
lobortis pharetra. Donec vitae erat enim. Nullam sit amet felis et quam lacinia tincidunt. Aliquam \
suscipit dapibus urna. Sed volutpat urna in magna pulvinar volutpat. Phasellus nec tellus ac diam \
cursus accumsan.

Nam lectus enim, dapibus non nisi tempor, consectetur convallis massa. Maecenas eleifend dictum \
feugiat. Etiam quis mauris vel risus luctus mattis a a nunc. Nullam orci quam, imperdiet id \
vehicula in, porttitor ut nibh. Duis sagittis adipiscing nisl vitae congue. Donec mollis risus eu \
leo suscipit, varius porttitor nulla porta. Pellentesque ut sem nec nisi euismod vehicula. Nulla \
malesuada sollicitudin quam eu fermentum.";
mod main {
use super::*;
use super::baseline as run;
#[bench]
fn bench_contains_short_short(b: &mut Bencher) {
    let haystack = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    let needle = "sit";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_2b_repeated_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "::";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_short_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "english";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_16b_in_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "english language";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_32b_in_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "the english language sample text";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_bad_naive(b: &mut Bencher) {
    let haystack = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    let needle = "aaaaaaaab";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_bad_simd(b: &mut Bencher) {
    let haystack = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    let needle = "aaabaaaa";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_equal(b: &mut Bencher) {
    let haystack = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    let needle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn contains_bang_str_short_ascii(b: &mut Bencher) {
 let s=CASES[0].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_short_ascii(b: &mut Bencher) {
 let s=CASES[0].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn contains_bang_str_short_mixed(b: &mut Bencher) {
 let s=CASES[1].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_short_mixed(b: &mut Bencher) {
 let s=CASES[1].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn contains_bang_str_short_pile_of_poo(b: &mut Bencher) {
 let s=CASES[2].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_short_pile_of_poo(b: &mut Bencher) {
 let s=CASES[2].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn contains_bang_str_long_lorem_ipsum(b: &mut Bencher) {
 let s=CASES[3].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_long_lorem_ipsum(b: &mut Bencher) {
 let s=CASES[3].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn extra_empty(b: &mut Bencher) {
 let input=""; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("")));});
}
#[bench]
fn extra_empty_in_long(b: &mut Bencher) {
 let input=LONG_HAYSTACK; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("")));});
}
#[bench]
fn extra_longer_needle(b: &mut Bencher) {
 let input="abc"; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("abcdef")));});
}
#[bench]
fn extra_unicode_str_hit(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("中💩")));});
}
#[bench]
fn extra_unicode_str_miss(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("é💩")));});
}
#[bench]
fn extra_unicode_char_hit(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box('💩')));});
}
#[bench]
fn extra_unicode_char_miss(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box('国')));});
}
#[bench]
fn extra_nul_str(b: &mut Bencher) {
 let input="x".repeat(2551) + "\0"; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("\0")));});
}
#[bench]
fn extra_ascii_char(b: &mut Bencher) {
 let input="x".repeat(2551) + "~"; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box('~')));});
}
#[bench]
fn extra_char_array(b: &mut Bencher) {
 let input="abcé中".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box(&['中', '💩'])));});
}
#[bench]
fn extra_char_slice(b: &mut Bencher) {
 let input="abcé中".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box(&['中', '💩'][..])));});
}
#[bench]
fn extra_predicate(b: &mut Bencher) {
 let input="abcé中".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box(|c: char| c=='中')));});
}
}
mod optimized {
use super::*;
use super::contains_impl::contains as run;
#[bench]
fn bench_contains_short_short(b: &mut Bencher) {
    let haystack = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    let needle = "sit";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_2b_repeated_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "::";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_short_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "english";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_16b_in_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "english language";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_32b_in_long(b: &mut Bencher) {
    let haystack = LONG_HAYSTACK;
    let needle = "the english language sample text";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_bad_naive(b: &mut Bencher) {
    let haystack = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    let needle = "aaaaaaaab";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_bad_simd(b: &mut Bencher) {
    let haystack = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    let needle = "aaabaaaa";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(!run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn bench_contains_equal(b: &mut Bencher) {
    let haystack = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
    let needle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

    b.bytes = haystack.len() as u64;
    b.iter(|| {
        assert!(run(black_box(haystack), black_box(needle)));
    })
}
#[bench]
fn contains_bang_str_short_ascii(b: &mut Bencher) {
 let s=CASES[0].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_short_ascii(b: &mut Bencher) {
 let s=CASES[0].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn contains_bang_str_short_mixed(b: &mut Bencher) {
 let s=CASES[1].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_short_mixed(b: &mut Bencher) {
 let s=CASES[1].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn contains_bang_str_short_pile_of_poo(b: &mut Bencher) {
 let s=CASES[2].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_short_pile_of_poo(b: &mut Bencher) {
 let s=CASES[2].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn contains_bang_str_long_lorem_ipsum(b: &mut Bencher) {
 let s=CASES[3].1;
 b.iter(|| { black_box(run(black_box(s),black_box("!"))); });
}
#[bench]
fn contains_bang_char_long_lorem_ipsum(b: &mut Bencher) {
 let s=CASES[3].1;
 b.iter(|| { black_box(run(black_box(s),black_box('!'))); });
}
#[bench]
fn extra_empty(b: &mut Bencher) {
 let input=""; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("")));});
}
#[bench]
fn extra_empty_in_long(b: &mut Bencher) {
 let input=LONG_HAYSTACK; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("")));});
}
#[bench]
fn extra_longer_needle(b: &mut Bencher) {
 let input="abc"; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("abcdef")));});
}
#[bench]
fn extra_unicode_str_hit(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("中💩")));});
}
#[bench]
fn extra_unicode_str_miss(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("é💩")));});
}
#[bench]
fn extra_unicode_char_hit(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box('💩')));});
}
#[bench]
fn extra_unicode_char_miss(b: &mut Bencher) {
 let input="aé中💩".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box('国')));});
}
#[bench]
fn extra_nul_str(b: &mut Bencher) {
 let input="x".repeat(2551) + "\0"; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box("\0")));});
}
#[bench]
fn extra_ascii_char(b: &mut Bencher) {
 let input="x".repeat(2551) + "~"; let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box('~')));});
}
#[bench]
fn extra_char_array(b: &mut Bencher) {
 let input="abcé中".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box(&['中', '💩'])));});
}
#[bench]
fn extra_char_slice(b: &mut Bencher) {
 let input="abcé中".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box(&['中', '💩'][..])));});
}
#[bench]
fn extra_predicate(b: &mut Bencher) {
 let input="abcé中".repeat(256); let s: &str= input.as_ref();
 b.iter(|| {black_box(run(black_box(s),black_box(|c: char| c=='中')));});
}
}
