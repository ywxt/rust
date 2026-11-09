from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;core='52'if platform.machine()=='aarch64'else'12'
groups={
 'ranges':[["probe",m,a,b,"all_valid",max(80,min(1000000,10000000//max(1,b-a)))]for a,b in [(0,0),(0,1),(0,3),(0,4),(0,5),(0,17),(-17,19),(0,4096),(-100000,100000),(3037000490,3037000510),(-3037000510,-3037000490)]for m in ['dynamic','guarded_dynamic','unrolled_dynamic']],
 'distributions':[["probe",m,0,n,k,max(100,min(500000,10000000//max(1,n)))]for n in [1,17,4096,100000]for k in ['all_valid','all_overflow','alternating','clustered','random','boundary']for m in ['checked_slice','guarded_slice']]
}
for tag,c in groups.items():
 e=os.environ.copy();e.update(TAG=tag,ROUNDS='3',CONFIGS=json.dumps(c));subprocess.run(['python3',str(p/'measure.py')],env=e,check=True)
