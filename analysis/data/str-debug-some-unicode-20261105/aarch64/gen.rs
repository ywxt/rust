fn main(){
 let mut words=[0u64;16];
 for block in 0u32..1024 {
  if (block*64..block*64+64).all(|u|char::from_u32(u).is_some_and(|c|c.escape_debug().len()==1)){
   words[(block/64)as usize]|=1u64<<(block%64);
  }
 }
 println!("const PRINTABLE_BLOCKS:[u64;16]={words:?};");
}
