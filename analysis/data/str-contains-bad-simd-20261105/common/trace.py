from pathlib import Path
import json
r=Path(__file__).resolve().parent
needle=b'aaabaaaa';haystack=b'a'*74
window=list(range(len(needle)-4,len(needle)));found=[i for i in window if needle[i]!=needle[0]]
def maximal(arr,greater):
 left,right,offset,period=0,1,0,1
 while right+offset<len(arr):
  a,b=arr[right+offset],arr[left+offset]
  if(a<b and not greater)or(a>b and greater):right+=offset+1;offset=0;period=right-left
  elif a==b:
   if offset+1==period:right+=offset+1;offset=0
   else:offset+=1
  else:left=right;right+=1;offset=0;period=1
 return left,period
mf,mt=maximal(needle,False),maximal(needle,True);crit,period=mf if mf[0]>mt[0]else mt;short=needle[:crit]==needle[period:period+crit];assert not short
period=max(crit,len(needle)-crit)+1;pos=0;steps=[]
while pos+len(needle)<=len(haystack):
 compared=[];mismatch=None
 for i in range(crit,len(needle)):
  compared.append(i)
  if needle[i]!=haystack[pos+i]:mismatch=i;break
 if mismatch is not None:steps.append(dict(start=pos,indices=compared,mismatch=mismatch,shift=mismatch-crit+1));pos+=mismatch-crit+1;continue
 for i in range(crit-1,-1,-1):
  compared.append(i)
  if needle[i]!=haystack[pos+i]:mismatch=i;break
 assert mismatch is not None;steps.append(dict(start=pos,indices=compared,mismatch=mismatch,shift=period));pos+=period
out=dict(needle=needle.decode(),haystack_length=len(haystack),probe_window=window,probe_found=found,maximal_false=mf,maximal_true=mt,crit_pos=crit,long_period=True,period=period,search_rounds=len(steps),byte_comparisons=sum(len(s['indices'])for s in steps),steps=steps,candidate_probe=max(i for i,b in enumerate(needle)if b!=needle[0]))
(r/'algorithm-trace.json').write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
