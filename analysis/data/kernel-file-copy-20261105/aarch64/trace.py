from pathlib import Path
import subprocess,os,platform,json
p=Path(__file__).resolve().parent;arch=platform.machine();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');roots=['/tmp','/home/wheel/copy-bench-20261105']if arch=='aarch64' else ['/tmp','/dev/shm/kernel-file-copy-20261105'];out=[]
for i,root in enumerate(roots):
 for mode in ['std','take','cfr','rw128']:
  cmd=['strace','-o',str(p/('trace-'+str(i)+'-'+mode+'.'+arch+'.txt')),'-e','trace=copy_file_range,sendfile,splice,read,write,lseek,fstat,newfstatat,statx',str(p/'probe'),mode,'131072','3',root];x=subprocess.run(cmd,env=e,text=True,capture_output=True);out.append({'root':root,'mode':mode,'command':cmd,'stdout':x.stdout,'stderr':x.stderr,'exit_code':x.returncode})
(p/('traces.'+arch+'.json')).write_text(json.dumps(out,indent=2))
print(out)
