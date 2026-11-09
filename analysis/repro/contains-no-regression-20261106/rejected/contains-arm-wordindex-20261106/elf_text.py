from pathlib import Path
import struct,hashlib
def text_bytes(path):
 data=Path(path).read_bytes()
 assert data[:6]==b"\x7fELF\x02\x01"
 off=struct.unpack_from("<Q",data,0x28)[0]
 ent,num,names=struct.unpack_from("<HHH",data,0x3a)
 assert num>0 and names<num
 sh=off+names*ent
 no,ns=struct.unpack_from("<QQ",data,sh+0x18)
 table=data[no:no+ns]
 for i in range(num):
  sh=off+i*ent;n=struct.unpack_from("<I",data,sh)[0]
  if table[n:table.index(b"\0",n)]==b".text":
   start,size=struct.unpack_from("<QQ",data,sh+0x18)
   return data[start:start+size]
 raise AssertionError("missing .text")
def text_sha(path):return hashlib.sha256(text_bytes(path)).hexdigest()
