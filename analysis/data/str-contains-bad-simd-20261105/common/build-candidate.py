import subprocess,shlex
code=r'''
from pathlib import Path
import subprocess,json,hashlib,difflib
r=Path('/tmp/contains-bad-simd-20261105');source=Path('/tmp/contains-bad-simd-source');assert 'passed' in(r/'baseline-check.aarch64.log').read_text();p=source/'library/core/src/str/pattern.rs';old=p.read_text();assert old==(r/'pattern.baseline.rs').read_text();a='(needle.len().saturating_sub(4)..needle.len()).rfind(|&idx| needle[idx] != first_probe)';b='(1..needle.len()).rfind(|&idx| needle[idx] != first_probe)';assert old.count(a)==1;new=old.replace(a,b);p.write_text(new);(r/'pattern.candidate.rs').write_text(new);(r/'interface.patch').write_text(''.join(difflib.unified_diff(old.splitlines(True),new.splitlines(True),fromfile='a/library/core/src/str/pattern.rs',tofile='b/library/core/src/str/pattern.rs')))
print('candidate interface changed in isolated source; benchmark bodies unchanged',flush=True)
with(r/'candidate-stdlib-build.log').open('w')as out:p=subprocess.run(['./x','build','--stage','0','library/std','library/test','--target','aarch64-unknown-linux-gnu,x86_64-unknown-linux-gnu'],cwd=source,stdout=out,stderr=subprocess.STDOUT)
print('candidate build exit',p.returncode,flush=True);assert p.returncode==0
subprocess.run(['python3',str(r/'gather-build.py'),'candidate'],check=True)
'''
subprocess.run(['ssh','-F','/run/secrets/rendered/univpn-ssh.conf','-o','BatchMode=yes','-o','ConnectTimeout=15','univpn-work-1','python3 -c '+shlex.quote(code)],check=True)
