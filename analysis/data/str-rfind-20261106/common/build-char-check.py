from pathlib import Path
import subprocess,json,os
r=Path('/tmp/str-rfind-20261106');cmds=json.loads((r/'build-commands.json').read_text());e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';saved=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 c=next(c.copy()for c in cmds if c[-1]==str(r/target/'counted-base'));c[c.index(str(r/'counted.rs'))]=str(r/'char-check.rs');c[c.index('-o')+1]=str(r/target/'char-check');p=subprocess.run(c,env=e,text=True,capture_output=True);(r/target/'char-check-build.log').write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;saved.append(c)
(r/'char-check-build-commands.json').write_text(json.dumps(saved,indent=2))
