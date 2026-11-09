from pathlib import Path
import json,struct,hashlib,subprocess
r=Path(__file__).resolve().parent
def elf(path):
 b=path.read_bytes();assert b[:6]==b'\x7fELF\x02\x01';h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);off,size,n,idx=h[6],h[11],h[12],h[13];ss=[struct.unpack_from('<IIQQQQIIQQ',b,off+i*size)for i in range(n)];names=ss[idx];nb=b[names[4]:names[4]+names[5]]
 return b,ss,[nb[s[0]:].split(b'\0')[0].decode()for s in ss]
results=[]
for arch,p in [('aarch64',r/'arm-final'),('x86_64',r)]:
 t=p/(arch+'-unknown-linux-gnu');build=t/'layout-build'
 for name in ['benches','counted']:
  selected=json.loads((build/(name+'-selected.json')).read_text());b,ss,names=elf(build/(name+'-placed.o'));i=names.index('.sort_case');masks=[]
  for s in ss:
   if s[1]==4 and s[7]==i:
    for off in range(s[4],s[4]+s[5],s[9]):
     loc,info,addend=struct.unpack_from('<QQq',b,off);width=8 if arch=='x86_64'and(info&0xffffffff)==1 else 4;masks.append((loc,width))
  hashes=set();maps=[]
  for offset in range(0,256,16):
   exe=t/(name+f'-layout{offset:03}');b,sections,names=elf(exe);s=sections[names.index('.sort_case')];assert s[3]==0x1000000+offset
   code=bytearray(b[s[4]:s[4]+s[5]])
   for loc,width in masks:code[loc:loc+width]=b'\0'*width
   hashes.add(hashlib.sha256(code).hexdigest())
   nm=subprocess.check_output(['nm','-S',str(exe)],text=True);mp={l.split()[-1]:int(l.split()[0],16)for l in nm.splitlines()if len(l.split())==4 and l.split()[2]in ['t','T','w','W']and l.split()[-1]!=selected['symbol']};maps.append(mp)
  assert len(hashes)==1,(arch,name,'non-relocated instruction bytes changed');same=all(m==maps[0]for m in maps)
  if arch=='aarch64':assert same,(arch,name,'other function addresses changed')
  moved={k for m in maps for k,v in m.items()if maps[0].get(k)!=v}
  results.append(dict(arch=arch,binary=name,offsets=list(range(0,256,16)),masked_instruction_sha256=next(iter(hashes)),relocations_masked=masks,other_function_addresses_equal=same,other_function_addresses_changed=len(moved),scope='single_function_address'if same else'whole_layout_only'))
(r/'layout-validation.json').write_text(json.dumps(results,indent=2));print('Instruction bytes verified; ARM single-function placement verified; x86 changes other function addresses and is not an isolated placement experiment')
