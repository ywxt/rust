use std::str;

use test::{Bencher, black_box};

#[path = "../../../coretests/benches/str/corpora.rs"]
mod corpora;

fn repeated_to_len(pattern: &str, len: usize) -> Vec<u8> {
    let pattern = pattern.as_bytes();
    let mut input = Vec::with_capacity(len);
    while input.len() + pattern.len() <= len {
        input.extend_from_slice(pattern);
    }
    input.resize(len, b'a');
    input
}

fn bench_valid(b: &mut Bencher, pattern: &str, len: usize) {
    let input = repeated_to_len(pattern, len);
    b.bytes = len as u64;
    b.iter(|| black_box(str::from_utf8(black_box(&input))));
}

fn bench_invalid_at(b: &mut Bencher, len: usize, error_at: usize) {
    bench_invalid_document_at(b, "a", len, error_at);
}

fn bench_invalid_document_at(b: &mut Bencher, pattern: &str, len: usize, error_at: usize) {
    let mut input = repeated_to_len(pattern, len);
    input[error_at] = 0xff;
    b.bytes = (error_at + 1) as u64;
    b.iter(|| black_box(str::from_utf8(black_box(&input))));
}

fn bench_truncated_at_end(b: &mut Bencher, len: usize) {
    let mut input = vec![b'a'; len];
    input[len - 3..].copy_from_slice(&[0xf0, 0x90, 0x80]);
    b.bytes = len as u64;
    b.iter(|| black_box(str::from_utf8(black_box(&input))));
}

macro_rules! valid_bench {
    ($name:ident, $pattern:expr, $len:expr) => {
        #[bench]
        fn $name(b: &mut Bencher) {
            bench_valid(b, $pattern, $len);
        }
    };
}

macro_rules! valid_length_matrix {
    ($name:ident, $pattern:expr) => {
        mod $name {
            use super::*;

            valid_bench!(len_0, $pattern, 0);
            valid_bench!(len_1, $pattern, 1);
            valid_bench!(len_2, $pattern, 2);
            valid_bench!(len_4, $pattern, 4);
            valid_bench!(len_8, $pattern, 8);
            valid_bench!(len_31, $pattern, 31);
            valid_bench!(len_32, $pattern, 32);
            valid_bench!(len_33, $pattern, 33);
            valid_bench!(len_63, $pattern, 63);
            valid_bench!(len_64, $pattern, 64);
            valid_bench!(len_65, $pattern, 65);
            valid_bench!(len_127, $pattern, 127);
            valid_bench!(len_128, $pattern, 128);
            valid_bench!(len_129, $pattern, 129);
            valid_bench!(len_255, $pattern, 255);
            valid_bench!(len_256, $pattern, 256);
            valid_bench!(len_257, $pattern, 257);
            valid_bench!(len_511, $pattern, 511);
            valid_bench!(len_512, $pattern, 512);
            valid_bench!(len_513, $pattern, 513);
            valid_bench!(len_1023, $pattern, 1023);
            valid_bench!(len_1024, $pattern, 1024);
            valid_bench!(len_1025, $pattern, 1025);
            valid_bench!(len_2047, $pattern, 2047);
            valid_bench!(len_2048, $pattern, 2048);
            valid_bench!(len_2049, $pattern, 2049);
            valid_bench!(len_4095, $pattern, 4095);
            valid_bench!(len_4096, $pattern, 4096);
        }
    };
}

macro_rules! invalid_bench {
    ($name:ident, $len:expr, $error_at:expr) => {
        #[bench]
        fn $name(b: &mut Bencher) {
            bench_invalid_at(b, $len, $error_at);
        }
    };
}

macro_rules! invalid_document_bench {
    ($name:ident, $pattern:expr, $len:expr, $error_at:expr) => {
        #[bench]
        fn $name(b: &mut Bencher) {
            bench_invalid_document_at(b, $pattern, $len, $error_at);
        }
    };
}

valid_length_matrix!(ascii, "a");
valid_length_matrix!(latin, "é");
valid_length_matrix!(cjk, "中文");
valid_length_matrix!(emoji, "😀");
valid_length_matrix!(mixed, "abcé中文😀xyz");

valid_bench!(document_en_tiny, corpora::en::TINY, corpora::en::TINY.len());
valid_bench!(document_en_small, corpora::en::SMALL, corpora::en::SMALL.len());
valid_bench!(document_en_medium, corpora::en::MEDIUM, corpora::en::MEDIUM.len());
valid_bench!(document_en_large, corpora::en::LARGE, corpora::en::LARGE.len());
valid_bench!(document_en_huge, corpora::en::HUGE, corpora::en::HUGE.len());
valid_bench!(document_zh_tiny, corpora::zh::TINY, corpora::zh::TINY.len());
valid_bench!(document_zh_small, corpora::zh::SMALL, corpora::zh::SMALL.len());
valid_bench!(document_zh_medium, corpora::zh::MEDIUM, corpora::zh::MEDIUM.len());
valid_bench!(document_zh_large, corpora::zh::LARGE, corpora::zh::LARGE.len());
valid_bench!(document_zh_huge, corpora::zh::HUGE, corpora::zh::HUGE.len());
valid_bench!(document_ru_tiny, corpora::ru::TINY, corpora::ru::TINY.len());
valid_bench!(document_ru_small, corpora::ru::SMALL, corpora::ru::SMALL.len());
valid_bench!(document_ru_medium, corpora::ru::MEDIUM, corpora::ru::MEDIUM.len());
valid_bench!(document_ru_large, corpora::ru::LARGE, corpora::ru::LARGE.len());
valid_bench!(document_ru_huge, corpora::ru::HUGE, corpora::ru::HUGE.len());
valid_bench!(document_emoji_tiny, corpora::emoji::TINY, corpora::emoji::TINY.len());
valid_bench!(document_emoji_small, corpora::emoji::SMALL, corpora::emoji::SMALL.len());
valid_bench!(document_emoji_medium, corpora::emoji::MEDIUM, corpora::emoji::MEDIUM.len());
valid_bench!(document_emoji_large, corpora::emoji::LARGE, corpora::emoji::LARGE.len());
valid_bench!(document_emoji_huge, corpora::emoji::HUGE, corpora::emoji::HUGE.len());

invalid_document_bench!(document_en_len_64_error_start, corpora::en::LARGE, 64, 0);
invalid_document_bench!(document_en_len_64_error_middle, corpora::en::LARGE, 64, 32);
invalid_document_bench!(document_en_len_64_error_end, corpora::en::LARGE, 64, 63);
invalid_document_bench!(document_en_len_256_error_start, corpora::en::LARGE, 256, 0);
invalid_document_bench!(document_en_len_256_error_middle, corpora::en::LARGE, 256, 128);
invalid_document_bench!(document_en_len_256_error_end, corpora::en::LARGE, 256, 255);
invalid_document_bench!(document_en_len_4096_error_start, corpora::en::LARGE, 4096, 0);
invalid_document_bench!(document_en_len_4096_error_middle, corpora::en::LARGE, 4096, 2048);
invalid_document_bench!(document_en_len_4096_error_end, corpora::en::LARGE, 4096, 4095);

invalid_document_bench!(document_zh_len_64_error_start, corpora::zh::LARGE, 64, 0);
invalid_document_bench!(document_zh_len_64_error_middle, corpora::zh::LARGE, 64, 32);
invalid_document_bench!(document_zh_len_64_error_end, corpora::zh::LARGE, 64, 63);
invalid_document_bench!(document_zh_len_256_error_start, corpora::zh::LARGE, 256, 0);
invalid_document_bench!(document_zh_len_256_error_middle, corpora::zh::LARGE, 256, 128);
invalid_document_bench!(document_zh_len_256_error_end, corpora::zh::LARGE, 256, 255);
invalid_document_bench!(document_zh_len_4096_error_start, corpora::zh::LARGE, 4096, 0);
invalid_document_bench!(document_zh_len_4096_error_middle, corpora::zh::LARGE, 4096, 2048);
invalid_document_bench!(document_zh_len_4096_error_end, corpora::zh::LARGE, 4096, 4095);

invalid_document_bench!(document_ru_len_64_error_start, corpora::ru::LARGE, 64, 0);
invalid_document_bench!(document_ru_len_64_error_middle, corpora::ru::LARGE, 64, 32);
invalid_document_bench!(document_ru_len_64_error_end, corpora::ru::LARGE, 64, 63);
invalid_document_bench!(document_ru_len_256_error_start, corpora::ru::LARGE, 256, 0);
invalid_document_bench!(document_ru_len_256_error_middle, corpora::ru::LARGE, 256, 128);
invalid_document_bench!(document_ru_len_256_error_end, corpora::ru::LARGE, 256, 255);
invalid_document_bench!(document_ru_len_4096_error_start, corpora::ru::LARGE, 4096, 0);
invalid_document_bench!(document_ru_len_4096_error_middle, corpora::ru::LARGE, 4096, 2048);
invalid_document_bench!(document_ru_len_4096_error_end, corpora::ru::LARGE, 4096, 4095);

invalid_document_bench!(document_emoji_len_64_error_start, corpora::emoji::LARGE, 64, 0);
invalid_document_bench!(document_emoji_len_64_error_middle, corpora::emoji::LARGE, 64, 32);
invalid_document_bench!(document_emoji_len_64_error_end, corpora::emoji::LARGE, 64, 63);
invalid_document_bench!(document_emoji_len_256_error_start, corpora::emoji::LARGE, 256, 0);
invalid_document_bench!(document_emoji_len_256_error_middle, corpora::emoji::LARGE, 256, 128);
invalid_document_bench!(document_emoji_len_256_error_end, corpora::emoji::LARGE, 256, 255);
invalid_document_bench!(document_emoji_len_4096_error_start, corpora::emoji::LARGE, 4096, 0);
invalid_document_bench!(document_emoji_len_4096_error_middle, corpora::emoji::LARGE, 4096, 2048);
invalid_document_bench!(document_emoji_len_4096_error_end, corpora::emoji::LARGE, 4096, 4095);

invalid_bench!(invalid_len_4096_at_0, 4096, 0);
invalid_bench!(invalid_len_4096_at_15, 4096, 15);
invalid_bench!(invalid_len_4096_at_16, 4096, 16);
invalid_bench!(invalid_len_4096_at_31, 4096, 31);
invalid_bench!(invalid_len_4096_at_32, 4096, 32);
invalid_bench!(invalid_len_4096_at_63, 4096, 63);
invalid_bench!(invalid_len_4096_at_64, 4096, 64);
invalid_bench!(invalid_len_4096_at_96, 4096, 96);
invalid_bench!(invalid_len_4096_at_128, 4096, 128);
invalid_bench!(invalid_len_4096_at_192, 4096, 192);
invalid_bench!(invalid_len_4096_at_256, 4096, 256);
invalid_bench!(invalid_len_4096_at_320, 4096, 320);
invalid_bench!(invalid_len_4096_at_384, 4096, 384);
invalid_bench!(invalid_len_4096_at_512, 4096, 512);
invalid_bench!(invalid_len_4096_at_768, 4096, 768);
invalid_bench!(invalid_len_4096_at_1024, 4096, 1024);
invalid_bench!(invalid_len_4096_at_1536, 4096, 1536);
invalid_bench!(invalid_len_4096_at_2048, 4096, 2048);
invalid_bench!(invalid_len_4096_at_2560, 4096, 2560);
invalid_bench!(invalid_len_4096_at_3072, 4096, 3072);
invalid_bench!(invalid_len_4096_at_3584, 4096, 3584);
invalid_bench!(invalid_len_4096_at_4095, 4096, 4095);

#[bench]
fn truncated_len_63(b: &mut Bencher) {
    bench_truncated_at_end(b, 63);
}

#[bench]
fn truncated_len_64(b: &mut Bencher) {
    bench_truncated_at_end(b, 64);
}

#[bench]
fn truncated_len_65(b: &mut Bencher) {
    bench_truncated_at_end(b, 65);
}

#[bench]
fn truncated_len_4096(b: &mut Bencher) {
    bench_truncated_at_end(b, 4096);
}
