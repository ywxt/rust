from pathlib import Path
import subprocess,platform,hashlib,json,os
r=Path(__file__).resolve().parent;arch=platform.machine();e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);out={}
for key,c in [('cpu',['lscpu']),('kernel',['uname','-a']),('libc',['ldd','--version']),('perf',['perf','--version'])]:
 p=subprocess.run(c,env=e,text=True,capture_output=True);out[key]=dict(command=c,stdout=p.stdout,stderr=p.stderr,exit=p.returncode)
out['sources']={p.name:hashlib.sha256(p.read_bytes()).hexdigest()for p in r.glob('*.rs')};out['binaries']={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for v in ['baseline','candidate']for p in(r/v/(arch+'-unknown-linux-gnu')).glob('*')if p.is_file()and p.suffix not in ['.ll','.s','.log']};(r/('metadata.'+arch+'.json')).write_text(json.dumps(out,indent=2))
