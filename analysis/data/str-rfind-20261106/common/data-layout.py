from pathlib import Path
import re,json,struct,hashlib
r=Path(__file__).resolve().parent
text=(r/'inputs.rs').read_text();inputs=[]
for name,literal in re.findall(r'\("(\w+)",\s*("(?:\\.|[^"\\])*")\),',text,re.S):
 data=json.loads(re.sub(r'\\\n\s*','',literal),strict=False).encode();inputs.append((name,data))
assert len(inputs)==4,len(inputs)
def sections(path):
 b=path.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);off,size,n,idx=h[6],h[11],h[12],h[13];ss=[struct.unpack_from('<IIQQQQIIQQ',b,off+i*size)for i in range(n)];s=ss[idx];nb=b[s[4]:s[4]+s[5]]
 return b,[(nb[s[0]:].split(b'\0')[0].decode(),s)for s in ss]
rows=[]
for arch,p in [('aarch64',r/'arm-final'),('x86_64',r)]:
 for binary in ['benches-base','counted-base','probes-base']:
  exe=p/(arch+'-unknown-linux-gnu')/binary;b,ss=sections(exe)
  for name,data in inputs:
   locations=[]
   for sec,s in ss:
    if s[1]!=1 or not(s[2]&2)or(s[2]&4):continue
    sb=b[s[4]:s[4]+s[5]];start=0
    while True:
     i=sb.find(data,start)
     if i<0:break
     addr=s[3]+i;prefix=min((-addr)%8,len(data));chunks=(len(data)-prefix)//16;suffix=len(data)-prefix-16*chunks;cross=sum((addr+prefix+16*j)%64>48 for j in range(chunks));locations.append(dict(section=sec,elf_address=hex(addr),mod64=addr%64,prefix_bytes=prefix,suffix_bytes=suffix,body_pairs=chunks,cross_64b_pairs=cross,cross_32b_pairs=sum((addr+prefix+16*j)%32>16 for j in range(chunks))));start=i+1
   assert len(locations)==1,(arch,binary,name,locations)
   rows.append(dict(arch=arch,binary=binary,case=name,bytes=len(data),**locations[0],exe_sha256=hashlib.sha256(b).hexdigest()))
(r/'data-layout.json').write_text(json.dumps(rows,indent=2))
for x in rows:print(x['arch'],x['binary'],x['case'],'mod64',x['mod64'],'scalar',x['prefix_bytes']+x['suffix_bytes'],'pairs',x['body_pairs'],'cross',x['cross_64b_pairs'])
