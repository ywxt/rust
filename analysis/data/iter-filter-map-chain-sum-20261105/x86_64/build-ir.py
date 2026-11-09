from pathlib import Path
import subprocess,os,json,platform,hashlib
p=Path(__file__).resolve().parent;arch=platform.machine();triple='aarch64-unknown-linux-gnu'if arch=='aarch64'else'x86_64-unknown-linux-gnu';r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');tool=Path('/tmp/xdiff-src/build')/triple/'ci-llvm/bin';out=[]
s=(p/'repro.ll').read_text();old='%prod = call {i64, i1} @llvm.smul.with.overflow.i64(i64 %i, i64 %i)';new='%value_only = mul nuw nsw i64 %i, %i\n  %pair = insertvalue {i64,i1} poison, i64 %value_only, 0\n  %prod = insertvalue {i64,i1} %pair, i1 false, 1';assert old in s;(p/'repro-mul.ll').write_text(s.replace(old,new))
for tag,src in [('checked','repro.ll'),('mul','repro-mul.ll')]:
 commands=[[str(tool/'opt'),'-S','-passes=default<O3>',str(p/src),'-o',str(p/('ir-'+tag+'.ll'))],[str(tool/'llc'),'-O3','-filetype=obj','-relocation-model=pic','-mtriple='+triple,str(p/('ir-'+tag+'.ll')),'-o',str(p/('ir-'+tag+'.o'))],[str(tool/'llc'),'-O3','-mtriple='+triple,str(p/('ir-'+tag+'.ll')),'-o',str(p/('ir-'+tag+'.s'))],[r,'--edition=2024','-O','-C','codegen-units=1','-C','link-arg='+str(p/('ir-'+tag+'.o')),str(p/'ir-driver.rs'),'-o',str(p/('ir-'+tag))]]
 for cmd in commands:subprocess.run(cmd,env=e,check=True)
 x=subprocess.run([str(p/('ir-'+tag)),'ir','1'],env=e,text=True,capture_output=True,check=True);out.append({'tag':tag,'source_sha256':hashlib.sha256((p/src).read_bytes()).hexdigest(),'commands':commands,'check':x.stdout})
(p/('ir-build.'+arch+'.json')).write_text(json.dumps(out,indent=2));print('IR builds checked')
