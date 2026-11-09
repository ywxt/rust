from pathlib import Path
import subprocess,os,re,json
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');cmd=[r,'--edition=2024','--crate-type=lib','-O','-C','codegen-units=1','-C','llvm-args=-print-after-all -filter-print-funcs=single,single_ref,chained','--emit=llvm-ir',str(p/'shape.rs'),'-o',str(p/'shape-trace.ll')];x=subprocess.run(cmd,env=e,capture_output=True,text=True,check=True);(p/'shape-passes.x86_64.txt').write_text(x.stderr);chunks=re.split(r'(?=\*\*\* IR Dump After)',x.stderr);rows=[]
for f in ['single','single_ref','chained']:
 previous=None
 for i,c in enumerate(chunks):
  m=re.search(r'^define[^\n]*@'+f+r'\([^\n]*\).*?^}',c,re.M|re.S)
  if m:
   n=m.group().count('@llvm.smul.with.overflow');header=c.splitlines()[0]
   if previous is None or n!=previous[0]:
    rows.append({'function':f,'dump':i,'header':header,'checked_muls':n})
    if previous and previous[0]>0 and n==0:
     (p/(f+'-before-eliminate.ir.txt')).write_text(previous[1]);(p/(f+'-after-eliminate.ir.txt')).write_text(c)
   previous=(n,c)
(p/'shape-passes-summary.x86_64.json').write_text(json.dumps({'command':cmd,'transitions':rows},indent=2));print(rows)
