#[path="word-aligned.rs"]
mod word;
#[unsafe(export_name="_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr") ]
pub fn replacement(b:u8,s:&[u8])->Option<usize>{
#[cfg(align16)]{word::aligned16_memrchr(b,s)}
#[cfg(not(align16))]{word::copied_memrchr(b,s)}
}
