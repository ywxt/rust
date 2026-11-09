from pathlib import Path
import subprocess,os,fcntl,struct,json,shutil
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','');subprocess.run([r,'--edition=2024','-O',str(p/'reflink-probe.rs'),'-o',str(p/'reflink-probe')],env=e,check=True);allrows=[]
for extra in [[],['pattern']]:
 x=subprocess.run([str(p/'reflink-probe'),'std','131072','3','/tmp']+extra,env=e,capture_output=True,text=True,check=True);d=Path(x.stderr.strip().split('PRESERVED=')[1]);out={'command':x.args,'stdout':x.stdout,'files':{}}
 for n in ['src','dst']:
  with (d/n).open('rb')as f:
   b=bytearray(32+56*16);struct.pack_into('QQIIII',b,0,0,2**64-1,1,0,16,0);fcntl.ioctl(f,0xc020660b,b,True);count=struct.unpack_from('I',b,20)[0];out['files'][n]=[{'logical':struct.unpack_from('Q',b,32+56*i)[0],'physical':struct.unpack_from('Q',b,40+56*i)[0],'length':struct.unpack_from('Q',b,48+56*i)[0],'flags':struct.unpack_from('I',b,72+56*i)[0]}for i in range(count)]
 allrows.append(out);shutil.rmtree(d)
(p/'fiemap.x86_64.json').write_text(json.dumps(allrows,indent=2));print(json.dumps(allrows))
