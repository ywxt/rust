#[unsafe(no_mangle)]pub fn collect_from_slice(src:&[usize])->Vec<usize>{src.iter().cloned().collect()}
#[unsafe(no_mangle)]pub fn collect_from_vec(src:&Vec<usize>)->Vec<usize>{src.iter().cloned().collect()}
#[unsafe(no_mangle)]pub fn slice_to_vec(src:&[usize])->Vec<usize>{src.to_vec()}
