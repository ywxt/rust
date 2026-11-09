from pathlib import Path
import json,subprocess,os
r=Path('/tmp/sort-small-random-20261106');cmds=json.loads((r/'build-commands.json').read_text());e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';saved=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 for name in ['benches','counted','probes']:
  c=next(c.copy()for c in cmds if c[-1]==str(r/target/(name+'-base')));c[c.index('-o')+1]=str(r/target/(name+'-nolsr'));c+=['-Cllvm-args=-disable-lsr'];p=subprocess.run(c,env=e,text=True,capture_output=True);(r/target/(name+'-nolsr-build.log')).write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;saved.append(c)
(r/'nolsr-build-commands.json').write_text(json.dumps(saved,indent=2))
