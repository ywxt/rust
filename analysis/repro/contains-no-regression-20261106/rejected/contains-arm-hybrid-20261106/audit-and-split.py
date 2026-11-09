from pathlib import Path
import json,subprocess,hashlib,sys
r=Path('/tmp/contains-arm-hybrid-20261106');sys.path.insert(0,str(r))
from elf_text import text_sha
manifest=json.loads((r/'sysroot-manifests.json').read_text());audit={}
for t in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 audit[t]={}
 for v in ['baseline','optimized']:
  lib=r/'sysroots'/v/'lib/rustlib'/t/'lib'
  for n,h in manifest[v][t].items():assert hashlib.sha256((lib/n).read_bytes()).hexdigest()==h,(t,v,n)
  std=next(lib.glob('libstd-*.so'));names=['counted','matrix','byte-matrix','index-matrix','split-counted']
  audit[t][v]={'std_text_sha':text_sha(std),'apps':{n:text_sha(r/v/t/n) for n in names}}
 assert audit[t]['baseline']['apps']==audit[t]['optimized']['apps'],t
 if t.startswith('x86'):assert audit[t]['baseline']['std_text_sha']==audit[t]['optimized']['std_text_sha']
(r/'code-audit.json').write_text(json.dumps(audit,indent=2));print(json.dumps(audit,indent=2))
# Avoid quadratic checkpoint serialization; each trial and the final result are still complete.
for name in ['byte','index','matrix','counted','split']:
 p=r/('run-'+name+'.py');s=p.read_text();expr="(r/'"+name+"-results.json').write_text(json.dumps(rows,indent=2))"
 assert expr in s,name
 s=s.replace(expr,"(r/'"+name+"-results.json').write_text(json.dumps(rows,indent=2)) if len(rows)%32==0 else None")
 s+="\n"+expr+"\n";p.write_text(s)
(r/'measurement-method.txt').write_text('Unchanged perf commands, 3 alternating paired trials, ASLR off, core52 ARM/core12 x86. JSON checkpoint every32 samples and final; raw log persisted every sample. Same exact app .text both variants; x86 std .text also identical.\n')
subprocess.run(['python3',str(r/'run-split.py')],check=True)

