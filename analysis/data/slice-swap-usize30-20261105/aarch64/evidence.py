from pathlib import Path
import subprocess,os,json,platform,hashlib
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');checks=[]
for binary in ['probe','extra-check']:
 if binary=='extra-check':subprocess.run([r,'--edition=2024','-O',str(p/'extra-check.rs'),'-o',str(p/binary)],env=e,check=True)
 cmd=[str(p/binary)]+(['check','1']if binary=='probe'else[]);x=subprocess.run(cmd,env=e,capture_output=True,text=True,check=True);checks.append({'command':cmd,'stdout':x.stdout,'exit_code':x.returncode})
(p/('correctness.'+arch+'.json')).write_text(json.dumps(checks,indent=2));out={}
for n,c in [('compiler',[r,'-vV']),('uname',['uname','-a']),('lscpu',['lscpu','-J']),('glibc',['ldd','--version']),('source_head',['git','-C','/tmp/xdiff-src','rev-parse','HEAD'])]:
 x=subprocess.run(c,env=e,capture_output=True,text=True);out[n]={'command':c,'stdout':x.stdout,'stderr':x.stderr,'exit_code':x.returncode}
out['source_sha256']={str(f):hashlib.sha256(f.read_bytes()).hexdigest()for f in list(p.glob('*.rs'))+[Path('/tmp/xdiff-src/library/coretests/benches/slice.rs'),Path('/tmp/xdiff-src/library/core/src/ptr/mod.rs')]};b=next(x.strip()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if '/corebenches-'in x);out['benchmark_binary']={'path':b,'sha256':hashlib.sha256(Path(b).read_bytes()).hexdigest()};out['probe_binary_sha256']=hashlib.sha256((p/'probe').read_bytes()).hexdigest();(p/('environment.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('checks and environment saved',arch)
