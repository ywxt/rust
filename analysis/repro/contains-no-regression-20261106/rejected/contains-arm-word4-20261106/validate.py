from pathlib import Path
import subprocess,json
r=Path('/tmp/contains-arm-word4-20261106')
with (r/'full-tests.log').open('w') as out:
 p=subprocess.run(['./x','test','--stage','0','--set','build.compiletest-allow-stage0=true','library/coretests','library/alloctests','--target','aarch64-unknown-linux-gnu'],cwd='/home/wheel/c00936152/rust-contains-stdlib',stdout=out,stderr=subprocess.STDOUT)
(r/'full-tests-exit.json').write_text(json.dumps({'exit_code':p.returncode}));assert p.returncode==0
for name in ['run-split-long','run-all','collect','run-byte','run-index','run-boundary']:
 with (r/(name+'.log')).open('w') as out:subprocess.run(['python3',str(r/(name+'.py'))],stdout=out,stderr=subprocess.STDOUT,check=True)

