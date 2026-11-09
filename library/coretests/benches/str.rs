use std::str;

use test::{Bencher, black_box};

mod char_count;
mod corpora;
mod debug;
mod eq_ignore_ascii_case;
mod iter;

#[bench]
fn str_validate_emoji(b: &mut Bencher) {
    b.iter(|| str::from_utf8(black_box(corpora::emoji::LARGE.as_bytes())));
}

macro_rules! validate_benches {
    ($($name:ident: $text:expr,)*) => {$(
        #[bench]
        fn $name(b: &mut Bencher) {
            b.iter(|| str::from_utf8(black_box($text.as_bytes())));
        }
    )*};
}

validate_benches! {
    str_validate_en_small: corpora::en::SMALL,
    str_validate_en_medium: corpora::en::MEDIUM,
    str_validate_en_large: corpora::en::LARGE,
    str_validate_en_huge: corpora::en::HUGE,
    str_validate_zh_small: corpora::zh::SMALL,
    str_validate_zh_medium: corpora::zh::MEDIUM,
    str_validate_zh_large: corpora::zh::LARGE,
    str_validate_zh_huge: corpora::zh::HUGE,
    str_validate_ru_small: corpora::ru::SMALL,
    str_validate_ru_medium: corpora::ru::MEDIUM,
    str_validate_ru_large: corpora::ru::LARGE,
    str_validate_ru_huge: corpora::ru::HUGE,
    str_validate_emoji_small: corpora::emoji::SMALL,
    str_validate_emoji_medium: corpora::emoji::MEDIUM,
    str_validate_emoji_huge: corpora::emoji::HUGE,
}

/// Text that switches between scripts every 20 characters, `len` bytes or a bit more.
fn mixed_text(len: usize) -> String {
    let sources = [corpora::en::HUGE, corpora::zh::HUGE, corpora::ru::HUGE, corpora::emoji::HUGE];
    let mut chars = sources.map(|s| s.chars().cycle());
    let mut text = String::new();
    let mut i = 0;
    while text.len() < len {
        text.extend(chars[i % 4].by_ref().take(20));
        i += 1;
    }
    text
}

#[bench]
fn str_validate_mixed_small(b: &mut Bencher) {
    let s = mixed_text(100);
    b.iter(|| str::from_utf8(black_box(s.as_bytes())));
}

#[bench]
fn str_validate_mixed_medium(b: &mut Bencher) {
    let s = mixed_text(1000);
    b.iter(|| str::from_utf8(black_box(s.as_bytes())));
}

#[bench]
fn str_validate_mixed_large(b: &mut Bencher) {
    let s = mixed_text(10_000);
    b.iter(|| str::from_utf8(black_box(s.as_bytes())));
}

/// Invalid input: the error is in the last byte of the text.
#[bench]
fn str_validate_invalid_en_large(b: &mut Bencher) {
    let mut v = corpora::en::LARGE.as_bytes().to_vec();
    *v.last_mut().unwrap() = 0xFF;
    b.iter(|| str::from_utf8(black_box(&v)).is_err());
}

#[bench]
fn str_validate_invalid_zh_large(b: &mut Bencher) {
    let mut v = corpora::zh::LARGE.as_bytes().to_vec();
    *v.last_mut().unwrap() = 0xFF;
    b.iter(|| str::from_utf8(black_box(&v)).is_err());
}

/// Invalid input: the error is in the 70th byte of an otherwise valid text, the position at which
/// vectors help least.
#[bench]
fn str_validate_invalid_early_en(b: &mut Bencher) {
    let mut v = corpora::en::LARGE.as_bytes().to_vec();
    v[70] = 0xFF;
    b.iter(|| str::from_utf8(black_box(&v)).is_err());
}
