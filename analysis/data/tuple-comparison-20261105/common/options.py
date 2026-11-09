from pathlib import Path
import subprocess,os,json,platform,re,random,statistics
p=Path(__file__).resolve().parent;arch=platform.machine();triple=arch+'-unknown-linux-gnu';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();ld=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+os.environ.get('LD_LIBRARY_PATH','');e=os.environ.copy();e['LD_LIBRARY_PATH']=ld;deps=json.loads((p/'dependency-flags.json').read_text());fp=list((Path('/tmp/xdiff-src/build')/triple/'stage1-std'/triple/'dist/build/coretests').glob('*/fingerprint/test-bench-corebenches.json'))[0];flags=json.loads(fp.read_text())['rustflags'];(p/('fingerprint.'+arch+'.json')).write_bytes(fp.read_bytes());variants={'phi8':flags+['-Cllvm-args=-phi-node-folding-threshold=8'],'two16':flags+['-Cllvm-args=-two-entry-phi-node-folding-threshold=16'],'bonus8':flags+['-Cllvm-args=-bonus-inst-threshold=8'],'phi8two16':flags+['-Cllvm-args=-phi-node-folding-threshold=8','-Cllvm-args=-two-entry-phi-node-folding-threshold=16'],'selectofffull':flags+(['-Cllvm-args=-aarch64-select-opt=false']if arch=='aarch64'else['-Cllvm-args=-x86-cmov-converter=false'])};build=[]
for label,extra in variants.items():
 c=[r,'--test','--edition=2024','-O','-Ccodegen-units=1','--emit=link,asm,llvm-ir']+extra+deps+[str(p/'harness-exact.rs'),'-o',str(p/('harness-options-'+label))];subprocess.run(c,env=e,check=True);build.append(c)
e.pop('LD_LIBRARY_PATH',None);cases=[(label,m)for label in variants for m in ['original','two','match']];raw=[]
for rnd in range(3):
 cs=cases.copy();random.Random(551+rnd).shuffle(cs)
 for label,m in cs:
  c=['taskset','-c','52'if arch=='aarch64'else'12','env','LD_LIBRARY_PATH='+ld,str(p/('harness-options-'+label)),'--bench','--exact','--test-threads=1','bench_'+m];x=subprocess.run(c,env=e,capture_output=True,text=True,check=True,timeout=55);v=re.search(r'bench:\s+([\d,.]+) ns/iter',x.stdout);assert v;raw.append(dict(round=rnd,label=label,mode=m,ns=float(v[1].replace(',','')),stdout=x.stdout,stderr=x.stderr,command=c));(p/('options.'+arch+'.json')).write_text(json.dumps(dict(build=build,raw=raw),indent=2))
print({l+'|'+m:statistics.median(x['ns']for x in raw if x['label']==l and x['mode']==m)for l,m in cases})
