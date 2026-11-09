from pathlib import Path
import json,subprocess,hashlib,sys
r=Path('/tmp/contains-arm-hybrid2-20261106');sys.path.insert(0,str(r))
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
subprocess.run(['python3',str(r/'run-split.py')],check=True)

