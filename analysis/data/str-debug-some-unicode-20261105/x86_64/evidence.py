from pathlib import Path
import subprocess,os,platform,json,hashlib
p=Path(__file__).resolve().parent;arch=platform.machine();r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
checks=[]
for binary in ['candidate','range']:
 cmd=[str(p/binary),'check','1'];x=subprocess.run(cmd,env=e,capture_output=True,text=True);x.check_returncode();checks.append({'binary':binary,'command':cmd,'output':x.stdout,'exit_code':x.returncode})
(p/('correctness.'+arch+'.json')).write_text(json.dumps(checks,indent=2))
subprocess.run([r,'--edition=2024','-O',str(p/'alloc.rs'),'-o',str(p/'alloc')],env=e,check=True)
x=subprocess.check_output([str(p/'alloc')],env=e,text=True);(p/('alloc.'+arch+'.txt')).write_text(x)
meta={'arch':arch,'compiler':subprocess.check_output([r,'-vV'],env=e,text=True),'sources':{f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in p.glob('*.rs')}}
for name,cmd in [('uname',['uname','-a']),('lscpu',['lscpu','-J']),('glibc',['ldd','--version'])]:meta[name]=subprocess.check_output(cmd,text=True)
(p/('environment.'+arch+'.json')).write_text(json.dumps(meta,indent=2))
tool=Path(r).parents[2]/'ci-llvm/bin/llvm-objdump';raw=subprocess.check_output(['nm',str(p/'probe')],text=True).splitlines();dem=subprocess.check_output(['nm','-C',str(p/'probe')],text=True).splitlines()
for label in ['cf','default_ignorable_code_point']:
 hits=[l for l in raw if 'unicode_data'+str(len(label))+label+'11lookup_slow' in l];assert len(hits)==1
 sym=hits[0].split()[2];out=subprocess.check_output([str(tool),'-d','--disassemble-symbols='+sym,str(p/'probe')],text=True)
 (p/(label+'.'+arch+'.asm')).write_text(out)
print('correctness, allocation and environment saved',arch,x.strip())
