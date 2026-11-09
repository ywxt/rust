from pathlib import Path
import subprocess,os,json,platform,hashlib
p=Path(__file__).resolve().parent;e=os.environ.copy();e.pop('LD_LIBRARY_PATH',None);meta={};cmds={'lscpu':['lscpu'],'uname':['uname','-a'],'glibc':['ldd','--version'],'aslr':['cat','/proc/sys/kernel/randomize_va_space'],'source_head':['git','-C','/tmp/xdiff-src','rev-parse','HEAD']}
for k,c in cmds.items():
 x=subprocess.run(c,env=e,text=True,capture_output=True);meta[k]=dict(command=c,stdout=x.stdout,stderr=x.stderr,exit=x.returncode)
meta['original_source']=Path('/tmp/xdiff-src/library/coretests/benches/tuple.rs').read_text();meta['original_binary']={x:hashlib.sha256(Path(x).read_bytes()).hexdigest()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if'/corebenches-'in x};(p/('environment.'+platform.machine()+'.json')).write_text(json.dumps(meta,indent=2))
