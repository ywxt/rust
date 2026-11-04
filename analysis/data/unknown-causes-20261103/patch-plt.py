from pathlib import Path
import struct,re,subprocess
r=Path(__file__).resolve().parent;src=r/'alloc_dynamic';orig=src.read_bytes()
shoff=struct.unpack_from('<Q',orig,40)[0];ents,num,strings=struct.unpack_from('<HHH',orig,58)
sh=[struct.unpack_from('<IIQQQQIIQQ',orig,shoff+i*ents) for i in range(num)]
strs=orig[sh[strings][4]:sh[strings][4]+sh[strings][5]]
plt=next(x for x in sh if strs[x[0]:].split(b'\0',1)[0]==b'.plt')
offset=plt[4]-plt[3]
dis=subprocess.check_output(['objdump','-d','-C','-j','.plt',str(src)],text=True)
entries=[(int(a,16),b) for a,b in re.findall(r'^([0-9a-f]+) <(.+?@plt)>:',dis,re.M)]
meta=[]
for variant in ['allreg15','fmtreg15','allnopadd','fmtnopadd']:
 data=bytearray(orig);changed=[]
 for addr,name in entries:
  if variant.startswith('fmt') and 'format_inner' not in name:continue
  off=addr+offset
  words=list(struct.unpack_from('<4I',data,off));assert words[3]==0xd61f0220
  if variant.endswith('reg15'):
   assert words[1]&31==17
   words[1]=(words[1]&~31)|15;words[3]=0xd61f01e0
  else:words[2]=0xd503201f
  struct.pack_into('<4I',data,off,*words);changed.append(name)
 p=r/('alloc_'+variant);p.write_bytes(data);p.chmod(0o755)
 meta.append({'variant':variant,'changed':changed,'byte_changes':sum(a!=b for a,b in zip(orig,data))})
(r/'plt-patches.json').write_text(__import__('json').dumps(meta,indent=2));print(meta)
