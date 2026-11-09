from pathlib import Path
import subprocess,os,platform,json,statistics,re
p=Path(__file__).resolve().parent;arch=platform.machine();core='52' if arch=='aarch64' else '12';b=next(x.strip()for x in Path('/tmp/xdiff/bins.txt').read_text().splitlines()if '/std-' in x and '/out/std-' in x);e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');roots=['/tmp','/home/wheel/copy-bench-20261105']if arch=='aarch64' else ['/tmp','/dev/shm/kernel-file-copy-20261105'];raw=[]
for rnd in range(3):
 for root in roots:
  e['TMPDIR']=root;cmd=['taskset','-c',core,b,'--bench','--exact','--test-threads=1','sys::io::kernel_copy::linux::tests::bench_file_to_file_copy'];x=subprocess.run(cmd,env=e,text=True,capture_output=True,timeout=55);x.check_returncode();m=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert m,x.stdout
  raw.append({'round':rnd,'TMPDIR':root,'command':cmd,'stdout':x.stdout,'stderr':x.stderr,'ns_per_call':float(m[1].replace(',',''))});(p/('fullbench.'+arch+'.json')).write_text(json.dumps(raw,indent=2))
print({r:statistics.median(x['ns_per_call']for x in raw if x['TMPDIR']==r)for r in roots})
