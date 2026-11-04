from pathlib import Path
import struct,subprocess,re,sys
src=Path(sys.argv[1]);raw=src.read_bytes()
so=struct.unpack_from('<Q',raw,40)[0];ent,num,si=struct.unpack_from('<HHH',raw,58)
sh=[struct.unpack_from('<IIQQQQIIQQ',raw,so+i*ent) for i in range(num)]
ss=raw[sh[si][4]:sh[si][4]+sh[si][5]]
sec=next(x for x in sh if ss[x[0]:].split(b'\0',1)[0]==b'.text')
delta=sec[4]-sec[3]
dis=subprocess.check_output(['objdump','-d','-C',str(src)],text=True).splitlines()
start=next(i for i,l in enumerate(dis) if '<aos_same::kernel::<1>>:' in l)
end=next(i for i in range(start+1,len(dis)) if not dis[i].strip())
b=bytearray(raw);count=0
for l in dis[start:end]:
 if re.search(r'\bmov(?:ups)?\s+0x(?:4|14|24|34)\(%rdi,%r(?:c|a)x,[48]\)',l):
  m=re.match(r'\s*([a-f0-9]+):\s+((?:[a-f0-9]{2}\s+)+)',l)
  addr=int(m[1],16);code=bytes.fromhex(m[2]);assert code[-1] in [4,20,36,52]
  b[addr+delta+len(code)-1]-=4;count+=1
assert count==5,count
out=Path(sys.argv[2]);out.write_bytes(b);out.chmod(0o755)
print('Patched five load displacements; code addresses and instruction lengths retained.')
