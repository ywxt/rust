from pathlib import Path
import subprocess,shlex
code=r'''
from pathlib import Path
import shutil,json,hashlib,os,subprocess
r=Path('/tmp/contains-bad-simd-20261105');r.mkdir(exist_ok=True);source=Path('/tmp/contains-bad-simd-source');origin=Path('/home/wheel/c00936152/rust-contains-stdlib');assert not source.exists();shutil.copytree(origin,source,symlinks=True)
p=source/'bootstrap.toml';s=p.read_text().replace('/tmp/contains-stdlib-build','/tmp/contains-bad-simd-build');p.write_text(s)
for n in ['benches.rs','fixtures.rs','counted.rs','x86-cc']:
 shutil.copy2(Path('/tmp/contains-stdlib-20261105')/n,r/n)
pattern=source/'library/core/src/str/pattern.rs';base=pattern.read_bytes();actual=Path('/home/wheel/c00936152/rust-analysis/library/core/src/str/pattern.rs').read_bytes();assert base==actual,'isolation differs from current interface';(r/'pattern.baseline.rs').write_bytes(base)
(r/'setup.json').write_text(json.dumps({'source':str(source),'original_source':str(origin),'current_interface_sha256':hashlib.sha256(actual).hexdigest(),'source_head':subprocess.check_output(['git','-C',str(origin),'rev-parse','HEAD'],text=True).strip(),'compiler':'/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc','production_files_modified':False},indent=2))
print('source snapshot created',flush=True)
with(r/'baseline-stdlib-build.log').open('w')as out:
 x=subprocess.run(['./x','build','--stage','0','library/std','library/test','--target','aarch64-unknown-linux-gnu,x86_64-unknown-linux-gnu'],cwd=source,stdout=out,stderr=subprocess.STDOUT)
print('baseline build exit',x.returncode,flush=True);raise SystemExit(x.returncode)
'''
subprocess.run(['ssh','-F','/run/secrets/rendered/univpn-ssh.conf','-o','BatchMode=yes','-o','ConnectTimeout=15','univpn-work-1','python3 -c '+shlex.quote(code)],check=True)
