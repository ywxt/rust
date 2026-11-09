from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');extra=json.loads((p/('fingerprint.'+arch+'.json')).read_text())['rustflags'];deps=json.loads((p/'dependency-flags.json').read_text());cmds=[]
for source,name,d in [('probe.rs','probe-full',deps),('leaf.rs','leaf-full',[])]:
 c=[r,'--edition=2024','-O','-Ccodegen-units=1','--emit=link,asm,llvm-ir']+extra+d+[str(p/source),'-o',str(p/name)];subprocess.run(c,env=e,check=True);cmds.append(c)
x=subprocess.check_output([str(p/'probe-full'),'check'],env=e,text=True);(p/('full-probe-build.'+arch+'.json')).write_text(json.dumps(dict(commands=cmds,check=x),indent=2));print(x)
e['TAG']='full';e['CONFIGS']=json.dumps([['probe-full',m,10000000]for m in ['original','two','match','fused','pointer','rng']]);e.pop('LD_LIBRARY_PATH',None);subprocess.run(['python3',str(p/'measure.py')],env=e,check=True)
