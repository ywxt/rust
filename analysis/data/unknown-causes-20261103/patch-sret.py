from pathlib import Path
import struct,subprocess,re,sys
src=Path(sys.argv[1]);raw=src.read_bytes()
so=struct.unpack_from('<Q',raw,40)[0];ent,num,si=struct.unpack_from('<HHH',raw,58)
sh=[struct.unpack_from('<IIQQQQIIQQ',raw,so+i*ent) for i in range(num)]
ss=raw[sh[si][4]:sh[si][4]+sh[si][5]]
sec=next(x for x in sh if ss[x[0]:].split(b'\0',1)[0]==b'.text')
delta=sec[4]-sec[3]
dis=subprocess.check_output(['objdump','-d','-C',str(src)],text=True).splitlines()
entry=int(next(l.split()[0] for l in dis if '<bench::v0>:' in l),16)
for tag,slots,pair,clean in [('bool',[0x68,0xa8],False,False),('ptr',[0x7c],False,False),('both',[0x68,0xa8,0x7c],False,False),('pair',[],True,False),('bothpair',[0x68,0xa8,0x7c],True,False),('pairclean',[],True,True),('bothpairclean',[0x68,0xa8,0x7c],True,True)]:
 b=bytearray(raw)
 for rel in slots:
  off=entry+rel+delta;w=struct.unpack_from('<I',b,off)[0];assert ((w>>12)&511)==496
  struct.pack_into('<I',b,off,(w&~(511<<12))|(464<<12))
 if pair:
  off=entry+0x78+delta;assert struct.unpack_from('<I',b,off)[0]==0xf9000ff6
  struct.pack_into('<I',b,off,0xa9015bf5)
 if clean:
  off=entry+0x74+delta;assert struct.unpack_from('<I',b,off)[0]==0xa900d7ff
  struct.pack_into('<I',b,off,0xf90007ff)
 out=src.parent/('sret_'+tag);out.write_bytes(b);out.chmod(0o755)
 print(tag, sum(a!=z for a,z in zip(raw,b)), 'changed bytes')
