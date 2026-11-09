#![feature(pattern)]
use std::str::pattern::Pattern;
fn contains<P: Pattern>(s: &str, p: P) -> bool { s.contains(p) }
fn reference_str(s: &str, n: &str) -> bool {
    n.is_empty() || s.as_bytes().windows(n.len()).any(|w| w == n.as_bytes())
}
fn reference_char(s: &str, c: char) -> bool {
    reference_str(s, c.encode_utf8(&mut [0u8;4]))
}
use std::hint::black_box;
fn main() {
    let mut count = 0u64;
    for needle in 0..=127u8 {
        let n = std::str::from_utf8(std::slice::from_ref(&needle)).unwrap();
        for len in (0..=70).chain([95,96,97,127,128,129,255,256,257,2551,65536]) {
            for offset in 0..64 {
                let mut data = vec![if needle == b'x' { b'y' } else { b'x' }; len + 64];
                for pos in [None, Some(0), Some(len / 2), len.checked_sub(1)] {
                    data.fill(if needle == b'x' { b'y' } else { b'x' });
                    if let Some(p) = pos { if p < len { data[offset + p] = needle; } }
                    let s = std::str::from_utf8(&data[offset..offset + len]).unwrap();
                    assert_eq!(contains(black_box(s), black_box(n)), reference_str(s,n));
                    assert_eq!(contains(black_box(s), black_box(needle as char)), reference_char(s,needle as char));
                    count += 2;
                }
            }
        }
    }
    let mut seed = 0x81e79u64;
    let alphabet = ['a', 'b', '\0', '!', 'é', '中', '💩', '\u{10ffff}'];
    for i in 0..10000 {
        let mut s = String::new();
        for _ in 0..i%129 {
            seed ^= seed<<13; seed ^= seed>>7; seed ^= seed<<17;
            s.push(alphabet[seed as usize % alphabet.len()]);
        }
        let boundaries: Vec<_> = s.char_indices().map(|(p,_)|p).chain([s.len()]).collect();
        let start=boundaries[seed as usize%boundaries.len()];
        let end=boundaries[(seed>>16) as usize%boundaries.len()];
        let n=&s[start.min(end)..start.max(end)];
        for needle in [n,"", "中", "💩", "éa", "!!!", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"] {
            assert_eq!(contains(black_box(&s),black_box(needle)),reference_str(&s,needle));count+=1;
        }
        for c in alphabet {assert_eq!(contains(&s,c),reference_char(&s,c));count+=1;}
        let chars=['中','!', 'é'];
        assert_eq!(contains(&s,&chars),s.chars().any(|c|chars.iter().any(|&x|x==c)));count+=1;
        assert_eq!(contains(&s,&chars[..]),s.chars().any(|c|chars.iter().any(|&x|x==c)));count+=1;
        assert_eq!(contains(&s,chars),s.chars().any(|c|chars.iter().any(|&x|x==c)));count+=1;
        let mut got=Vec::new();let mut expected=Vec::new();
        assert_eq!(contains(&s,|c|{got.push(c);c=='中'}),s.chars().any(|c|{expected.push(c);c=='中'}));
        assert_eq!(got,expected);count+=1;
        let owned=n.to_owned();assert_eq!(contains(&s,&owned),reference_str(&s,&owned));count+=1;
    }
    println!("passed {count} comparisons including predicate visitation order");
}
