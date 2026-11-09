from pathlib import Path
import subprocess,os,json
p=Path(__file__).resolve().parent
lengths=[0,1,2,3,4,7,8,15,16,17,23,24,25,26,27,28,29,30,31,32,33,64,128,3000]
groups={
'lengths':[['probe',m,n,0,0,max(20000,min(4000000,60000000//max(1,n)))]for n in lengths for m in ['leaf_std','leaf_chunk4','leaf_chunk8','leaf_vec']],
'alignments':[['probe',m,30,ax,ay,1500000]for ax in range(8)for ay in range(8)for m in ['leaf_std','leaf_chunk8']],
'batch-alignments':[['probe',m,30,ax,ay,250000]for ax,ay in [(0,0),(0,1),(1,0),(1,1),(0,7),(7,0),(3,5),(7,7)]for m in ['original','chunk4','chunk8','vec']],
}
for tag,cs in groups.items():
 e=os.environ.copy();e.update(TAG=tag,ROUNDS='3',CONFIGS=json.dumps(cs));subprocess.run(['python3',str(p/'measure.py')],env=e,check=True)
