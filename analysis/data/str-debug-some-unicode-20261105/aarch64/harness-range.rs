#![feature(unicode_internals,test)]
extern crate test;
use test::Bencher;
use std::fmt::{self,Write};
use std::hint::black_box;
use core::unicode::unicode_data as ud;
const INPUT:&str="egy kis szöveg néhány unicode betűvel. legyen ez is 64 byte.";
struct Counter{len:usize,calls:usize}
impl Write for Counter {fn write_str(&mut self,s:&str)->fmt::Result{self.len+=s.len();self.calls+=1;Ok(())}}
#[inline(never)]
#[unsafe(no_mangle)]
fn format_std(s:&str)->String{format!("{:?}",black_box(s))}
#[inline(never)]
#[unsafe(no_mangle)]
fn reused_std(s:&str,out:&mut String){out.clear();write!(out,"{:?}",black_box(s)).unwrap();}
#[inline(never)]
#[unsafe(no_mangle)]
fn count_std(s:&str)->usize{let mut w=Counter{len:0,calls:0};write!(&mut w,"{:?}",black_box(s)).unwrap();black_box(w.calls);w.len}
#[inline(never)]
#[unsafe(no_mangle)]
fn raw_quotes(s:&str)->String{let mut out=String::new();out.push('"');out.push_str(black_box(s));out.push('"');out}
#[inline(never)]
#[unsafe(no_mangle)]
fn raw_count(s:&str)->usize{let mut w=Counter{len:0,calls:0};w.write_str("\"").unwrap();w.write_str(black_box(s)).unwrap();w.write_str("\"").unwrap();black_box(w.calls);w.len}
#[inline(never)]
#[unsafe(no_mangle)]
fn scan_decode(s:&str)->usize{
 let mut rest=black_box(s);let mut count=0;
 while !rest.is_empty(){
  let Some(i)=rest.as_bytes().iter().position(|&b|b>0x7e||b<0x20||b==b'\\'||b==b'"')else{break};
  let mut chars=rest[i..].chars();let c=chars.next().unwrap();count+=c.len_utf8();rest=chars.as_str();
 }
 count
}
#[inline(never)]
#[unsafe(no_mangle)]
fn escape_four(cs:&[char])->usize{let mut n=0;for &c in black_box(cs){n+=c.escape_debug().len();}n}
#[inline(never)]
#[unsafe(no_mangle)]
fn cf_four(cs:&[char])->usize{let mut n=0;for &c in black_box(cs){n+=ud::cf::lookup(c) as usize;}n}
#[inline(never)]
#[unsafe(no_mangle)]
fn di_four(cs:&[char])->usize{let mut n=0;for &c in black_box(cs){n+=ud::default_ignorable_code_point::lookup(c) as usize;}n}
include!("printable-blocks.rs");
#[inline]
fn block_printable(c:char)->bool{let u=c as u32;(0xa1..=0x2ff).contains(&u) && u!=0xad}
struct Candidate<'a,const FAST:bool>(&'a str);
impl<const FAST:bool> fmt::Debug for Candidate<'_,FAST>{
 fn fmt(&self,f:&mut fmt::Formatter<'_>)->fmt::Result{
  f.write_char('"')?;
  let mut printable_range=0..0;let mut rest=self.0;
  while !rest.is_empty(){
   let Some(i)=rest.as_bytes().iter().position(|&b|b>0x7e||b<0x20||b==b'\\'||b==b'"')else{printable_range.end+=rest.len();break};
   printable_range.end+=i;rest=&rest[i..];let mut chars=rest.chars();
   if let Some(c)=chars.next(){
    if FAST && block_printable(c){printable_range.end+=c.len_utf8();rest=chars.as_str();continue;}
    let esc=c.escape_debug();
    if esc.len()!=1{f.write_str(&self.0[printable_range.clone()])?;fmt::Display::fmt(&esc,f)?;printable_range.start=printable_range.end+c.len_utf8();}
    printable_range.end+=c.len_utf8();
   }
   rest=chars.as_str();
  }
  f.write_str(&self.0[printable_range])?;f.write_char('"')
 }
}
#[inline(never)]
#[unsafe(no_mangle)]
fn format_copy(s:&str)->String{format!("{:?}",Candidate::<false>(black_box(s)))}
#[inline(never)]
#[unsafe(no_mangle)]
fn format_fast(s:&str)->String{format!("{:?}",Candidate::<true>(black_box(s)))}
#[inline(never)]
#[unsafe(no_mangle)]
fn reused_copy(s:&str,out:&mut String){out.clear();write!(out,"{:?}",Candidate::<false>(black_box(s))).unwrap();}
#[inline(never)]
#[unsafe(no_mangle)]
fn reused_fast(s:&str,out:&mut String){out.clear();write!(out,"{:?}",Candidate::<true>(black_box(s))).unwrap();}
#[inline(never)]
#[unsafe(no_mangle)]
fn count_copy(s:&str)->usize{let mut w=Counter{len:0,calls:0};write!(&mut w,"{:?}",Candidate::<false>(black_box(s))).unwrap();black_box(w.calls);w.len}
#[inline(never)]
#[unsafe(no_mangle)]
fn count_fast(s:&str)->usize{let mut w=Counter{len:0,calls:0};write!(&mut w,"{:?}",Candidate::<true>(black_box(s))).unwrap();black_box(w.calls);w.len}
fn check_candidate(){
 let cases=[INPUT,"","'","\"","a\nb\tc\0","предложение из кириллических букв.","\"❤️\"\n\"hűha ez betű\"\n\"кириллических букв\".","中文测试","\u{ad}\u{300}\u{378}\u{200b}\u{ff9e}\u{ff9f}\u{fe0f}\u{10ffff}"];
 for s in cases{assert_eq!(format_copy(s),format_std(s));assert_eq!(format_fast(s),format_std(s));}
 let mut base=String::with_capacity(32);let mut alt=String::with_capacity(32);let mut buf=[0u8;4];
 for u in 0..=0x10ffffu32{
  if let Some(c)=char::from_u32(u){let s=c.encode_utf8(&mut buf);base.clear();alt.clear();write!(base,"{s:?}").unwrap();write!(alt,"{:?}",Candidate::<true>(s)).unwrap();assert_eq!(base,alt,"{u:x}");}
 }
 println!("all Unicode scalars and mixed cases passed");
}


struct CountingWriter{buf:String,calls:usize}
impl Write for CountingWriter{fn write_str(&mut self,s:&str)->fmt::Result{self.buf.push_str(s);self.calls+=1;Ok(())}}
fn setup(){let mut w=CountingWriter{buf:String::new(),calls:0};write!(&mut w,"{:?}",INPUT).unwrap();assert_eq!(INPUT.len(),64);assert_eq!(w.buf,format!("\"{}\"",INPUT));assert_eq!(w.calls,3);}
#[bench]
fn some_unicode(b:&mut Bencher){setup();let s=INPUT;b.iter(||black_box(format!("{:?}",black_box(s))));}
#[bench]
fn some_unicode_copy(b:&mut Bencher){setup();let s=INPUT;b.iter(||black_box(format!("{:?}",Candidate::<false>(black_box(s)))));}
#[bench]
fn some_unicode_fast(b:&mut Bencher){setup();let s=INPUT;b.iter(||black_box(format!("{:?}",Candidate::<true>(black_box(s)))));}
