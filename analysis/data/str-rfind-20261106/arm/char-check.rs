use std::hint::black_box;
fn main(){
 let alphabet=['a','_','\0','\u{a4}','é','中','💩','💤','\u{10ffff}'];let mut cases=0;
 for n in 0..=128{for shift in 0..alphabet.len(){let payload:String=(0..n).map(|i|alphabet[(i+shift)%alphabet.len()]).collect();for pad in [0,1,7,8,15,31]{let text="x".repeat(pad)+&payload;let s=black_box(&text[pad..]);
  for c in alphabet{let expected=s.char_indices().rev().find_map(|(i,x)|(x==c).then_some(i));assert_eq!(s.rfind(black_box(c)),expected);cases+=1;}
  for c in ['_','a','\0']{let needle=c.to_string();let expected=s.char_indices().rev().find_map(|(i,x)|(x==c).then_some(i));assert_eq!(s.rfind(black_box(needle.as_str())),expected);cases+=1;}
 }}}
 println!("CHAR_CHECK_OK cases={cases}");
}
