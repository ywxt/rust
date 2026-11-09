from pathlib import Path
import json,subprocess,os
r=Path('/tmp/str-rfind-20261106');e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';base=json.loads((r/'build-commands.json').read_text());saved=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 out=r/target;std=next((Path('/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib')/target/'lib').glob('libstd-*.so'));nm=subprocess.check_output(['nm','-D',str(std)],text=True);symbol=next(l.split()[-1]for l in nm.splitlines()if 'core5slice6memchr7memrchr'in l)
 source='#[path="word-aligned.rs"]\nmod word;\n#[unsafe(export_name="'+symbol+'") ]\npub fn replacement(b:u8,s:&[u8])->Option<usize>{\n#[cfg(align16)]{word::aligned16_memrchr(b,s)}\n#[cfg(not(align16))]{word::copied_memrchr(b,s)}\n}\n';(r/('shim-'+target+'.rs')).write_text(source)
 for variant,cfg in [('0000',[]),('0016',['--cfg','align16'])]:
  c=next(c.copy()for c in base if c[-1]==str(out/'probes-base'));i=c.index('--extern');del c[i:i+2];c[c.index(str(r/'probes.rs'))]=str(r/('shim-'+target+'.rs'));c[c.index('-o')+1]=str(out/('shim-'+variant+'.so'));c[c.index('--emit=link,asm,llvm-ir')]='--emit=link';c+=['--crate-type=dylib','--crate-name','rfind_shim','-Ccodegen-units=1']+cfg
  p=subprocess.run(c,env=e,text=True,capture_output=True);(out/('shim-'+variant+'-build.log')).write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;exports=subprocess.check_output(['nm','-D',str(out/('shim-'+variant+'.so'))],text=True);assert symbol in exports;saved.append(c)
 print('shim built',target,flush=True)
(r/'shim-build-commands.json').write_text(json.dumps(saved,indent=2))
