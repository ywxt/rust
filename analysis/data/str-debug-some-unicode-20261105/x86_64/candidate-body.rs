include!("printable-blocks.rs");
#[inline]
fn block_printable(c:char)->bool{let u=c as u32;u<=0xffff && (PRINTABLE_BLOCKS[(u>>12) as usize]>>((u>>6)&63))&1!=0}
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
