
#[test]
fn test_contains_runtime_ascii_all_alignments() {
    let lengths = [0usize, 1, 7, 8, 15, 16, 17, 31, 32, 63, 64, 65, 127, 128, 129, 255, 256, 257];
    for needle in 0..=127u8 {
        let encoded = [needle];
        let pattern = from_utf8(&encoded).unwrap();
        let fill = if needle == b'x' { b'y' } else { b'x' };
        for len in lengths {
            for offset in 0..64 {
                let mut bytes = vec![fill; len + 64];
                for pos in [None, Some(0), Some(len / 2), len.checked_sub(1)] {
                    bytes.fill(fill);
                    if let Some(i) = pos {
                        if i < len { bytes[offset + i] = needle; }
                    }
                    let haystack = from_utf8(&bytes[offset..offset + len]).unwrap();
                    let expected = pos.is_some_and(|p| p < len);
                    assert_eq!(haystack.contains(pattern), expected);
                    assert_eq!(haystack.contains(needle as char), expected);
                }
            }
        }
    }
}

#[test]
fn test_contains_runtime_full_pattern_semantics() {
    let haystacks = ["", "a!b", "é中💩", "a\0b", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"];
    for haystack in haystacks {
        for pattern in ["", "!", "\0", "é", "中💩", "💩中", "aaaaaaaaab", "longer than a short haystack"] {
            let expected = pattern.is_empty()
                || haystack.as_bytes().windows(pattern.len()).any(|w| w == pattern.as_bytes());
            assert_eq!(haystack.contains(pattern), expected);
        }
        for needle in ['!', '\0', 'é', '中', '💩', '\u{10ffff}'] {
            assert_eq!(haystack.contains(needle), haystack.chars().any(|c| c == needle));
        }
        let chars = ['!', '中'];
        let expected = haystack.chars().any(|c| chars.iter().any(|&n| n == c));
        assert_eq!(haystack.contains(&chars[..]), expected);
        let mut actual_visits = Vec::new();
        let mut expected_visits = Vec::new();
        let actual = haystack.contains(|c| { actual_visits.push(c); c == '中' });
        let expected = haystack.chars().any(|c| { expected_visits.push(c); c == '中' });
        assert_eq!(actual, expected);
        assert_eq!(actual_visits, expected_visits);
    }
}
