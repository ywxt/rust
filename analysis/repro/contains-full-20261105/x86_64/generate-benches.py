from pathlib import Path
import re,shutil
r=Path(__file__).resolve().parent;source=Path('/tmp/xdiff-src/library/alloctests/benches/str.rs').read_text();shutil.copy2('/tmp/str-contains-bang-20261105/fixtures.rs',r/'fixtures.rs')
long=re.search(r'static LONG_HAYSTACK: &str = .*?;',source,re.S)[0]
existing=re.findall(r'#\[bench\]\nfn bench_contains_.*?\n}',source,re.S);assert len(existing)==8
s='''#![feature(test, pattern, specialization)]
#![allow(incomplete_features)]
extern crate test;
mod contains_impl;
use std::hint::black_box;
use std::str::pattern::Pattern;
use test::Bencher;
include!("fixtures.rs");
fn baseline<P: Pattern>(s: &str, p: P) -> bool { s.contains(p) }
'''+long+'\n'
extras=[('empty','""','""'),('empty_in_long','LONG_HAYSTACK','""'),('longer_needle','"abc"','"abcdef"'),('unicode_str_hit','"aé中💩".repeat(256)','"中💩"'),('unicode_str_miss','"aé中💩".repeat(256)','"é💩"'),('unicode_char_hit','"aé中💩".repeat(256)',"'💩'"),('unicode_char_miss','"aé中💩".repeat(256)',"'国'"),('nul_str','"x".repeat(2551) + "\\0"','"\\0"'),('ascii_char','"x".repeat(2551) + "~"',"'~'"),('char_array','"abcé中".repeat(256)',"&['中', '💩']"),('char_slice','"abcé中".repeat(256)',"&['中', '💩'][..]"),('predicate','"abcé中".repeat(256)',"|c: char| c=='中'")]
for variant,run in [('main','baseline'),('optimized','contains_impl::contains')]:
 s+=f'mod {variant} {{\nuse super::*;\nuse super::{run} as run;\n'
 for body in existing:s+=body.replace('black_box(haystack).contains(black_box(needle))','run(black_box(haystack), black_box(needle))')+'\n'
 for idx,name in enumerate(['short_ascii','short_mixed','short_pile_of_poo','long_lorem_ipsum']):
  for typ,needle in [('str','"!"'),('char',"'!'")]:
   s+=f'''#[bench]
fn contains_bang_{typ}_{name}(b: &mut Bencher) {{
 let s=CASES[{idx}].1;
 b.iter(|| {{ black_box(run(black_box(s),black_box({needle}))); }});
}}
'''
 for name,hay,needle in extras:
  s+=f'''#[bench]
fn extra_{name}(b: &mut Bencher) {{
 let input={hay}; let s: &str= input.as_ref();
 b.iter(|| {{black_box(run(black_box(s),black_box({needle})));}});
}}
'''
 s+='}\n'
(r/'benches.rs').write_text(s);print('existing',len(existing),'benchmarks',s.count('#[bench]'))
