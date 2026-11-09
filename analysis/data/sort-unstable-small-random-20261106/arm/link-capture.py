#!/usr/bin/env python3
from pathlib import Path
import sys,json,os,subprocess,shutil
r=Path('/tmp/sort-small-random-20261106')
target=os.environ['SORT_LAYOUT_TARGET']; name=os.environ['SORT_LAYOUT_NAME']; out=r/target/'layout-build';out.mkdir(exist_ok=True)
args=sys.argv[1:];(out/(name+'-link.json')).write_text(json.dumps(args,indent=2))
inputs=out/(name+'-inputs');inputs.mkdir(exist_ok=True);captured=[]
for i,a in enumerate(args):
 if a.endswith('.o') and Path(a).is_file():
  dst=inputs/(str(i)+'-'+Path(a).name);shutil.copy2(a,dst);captured.append(str(dst))
 else:captured.append(a)
(out/(name+'-captured-link.json')).write_text(json.dumps(captured,indent=2))
linker='/usr/bin/cc' if target.startswith('aarch64') else '/tmp/contains-stdlib-20261105/x86-cc'
sys.exit(subprocess.run([linker]+args).returncode)
