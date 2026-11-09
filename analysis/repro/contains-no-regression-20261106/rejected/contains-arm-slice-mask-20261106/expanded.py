from pathlib import Path
import subprocess,json,os,time,tarfile,hashlib
r=Path('/tmp/contains-arm-slice-mask-20261106')
while not (r/'matrix-complete.json').exists():time.sleep(3)
time.sleep(1)
subprocess.run(['python3',str(r/'summarize-suites.py')],stdout=(r/'all-suite-summary.txt').open('w'),check=True)
with tarfile.open(str(r)+'.x86.tar.gz','w:gz') as tar:
 allowed={'sysroot-manifests.json','provenance.json','code-audit.json','baseline-harness-commands.json','optimized-harness-commands.json','baseline-sysroot-manifest.json'}
 for p in r.iterdir():
  if p.is_file() and (p.suffix in ['.rs','.py'] or p.name=='x86-cc' or p.name in allowed):tar.add(p,arcname=p.name)
 for v in ['baseline','optimized']:
  for p in (r/v/'x86_64-unknown-linux-gnu').iterdir():
   if p.is_file():tar.add(p,arcname=str(p.relative_to(r)))
 for p in (r/'sysroots/optimized/lib/rustlib/x86_64-unknown-linux-gnu/lib').iterdir():
  if p.is_file():tar.add(p,arcname=str(p.relative_to(r)))
package=Path(str(r)+'.x86.tar.gz')
(r/'x86-package.json').write_text(json.dumps({'bytes':package.stat().st_size,'sha256':hashlib.sha256(package.read_bytes()).hexdigest()}))
print('PACKAGE READY',flush=True)
with (r/'full-tests.log').open('w') as out:
 p=subprocess.run(['./x','test','--stage','0','--set','build.compiletest-allow-stage0=true','library/coretests','library/alloctests','--target','aarch64-unknown-linux-gnu'],cwd='/home/wheel/c00936152/rust-contains-stdlib',stdout=out,stderr=subprocess.STDOUT)
(r/'full-tests-exit.json').write_text(json.dumps({'exit_code':p.returncode}));assert p.returncode==0
for name in ['run-byte','run-index','run-boundary','run-split-long','collect','summarize-suites']:
 with (r/(name+'.log')).open('w') as out:subprocess.run(['python3',str(r/(name+'.py'))],stdout=out,stderr=subprocess.STDOUT,check=True)
(r/'expanded-complete.json').write_text(json.dumps({'time':time.time(),'state':'all complete'}))

