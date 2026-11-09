from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;arch=platform.machine();roots=['/tmp','/home/wheel/copy-bench-20261105']if arch=='aarch64'else['/tmp','/dev/shm/kernel-file-copy-20261105']
for tag,reps,sizes in [('sizes-small',100000,[0,1,4096]),('sizes-medium',20000,[65536,131072]),('sizes-large',2000,[1048576])]:
 cs=[(root,m,n)for root in roots for m in ['std','take','cfr','rw128']for n in sizes];e=os.environ.copy();e.update(TAG=tag,ROUNDS='3',REPS=str(reps),CONFIGS=json.dumps(cs));subprocess.run(['python3',str(p/'run.py')],env=e,check=True)
