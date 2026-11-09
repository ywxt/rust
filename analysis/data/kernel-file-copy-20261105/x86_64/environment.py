from pathlib import Path
import subprocess,platform,os,json,hashlib
p=Path(__file__).resolve().parent;arch=platform.machine();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');r=Path('/tmp/xdiff/rustc.txt').read_text().strip();out={};roots=['/tmp','/home/wheel/copy-bench-20261105']if arch=='aarch64'else['/tmp','/dev/shm/kernel-file-copy-20261105']
for name,c in [('uname',['uname','-a']),('lscpu',['lscpu','-J']),('page_size',['getconf','PAGESIZE']),('glibc',['ldd','--version']),('compiler',[r,'-vV']),('source_head',['git','-C','/tmp/xdiff-src','rev-parse','HEAD'])]+[(root,['findmnt','-J','-T',root])for root in roots]:
 x=subprocess.run(c,env=e,capture_output=True,text=True);out[name]={'command':c,'stdout':x.stdout,'stderr':x.stderr,'exit_code':x.returncode}
for name in ['/proc/sys/kernel/perf_event_paranoid','/proc/sys/kernel/kptr_restrict','/sys/kernel/mm/transparent_hugepage/shmem_enabled']:
 try:out[name]=Path(name).read_text()
 except OSError as x:out[name]=str(x)
out['source_sha256']={str(f.relative_to(Path('/tmp/xdiff-src'))):hashlib.sha256(f.read_bytes()).hexdigest()for f in [Path('/tmp/xdiff-src/library/std/src/sys/io/kernel_copy/linux.rs'),Path('/tmp/xdiff-src/library/std/src/sys/io/kernel_copy/linux/tests.rs')]}
b=next(x.strip()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if '/std-'in x and'/out/std-'in x);out['benchmark_binary']={'path':b,'sha256':hashlib.sha256(Path(b).read_bytes()).hexdigest()};out['probe_binary_sha256']=hashlib.sha256((p/'probe').read_bytes()).hexdigest();(p/('environment.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('environment saved',arch)
