#!/usr/bin/env python3
"""Build reference overlap tests using the installed NumPy implementation."""
from pathlib import Path
import numpy as np
p=Path(__file__).resolve().parents[1]/'tests/overlap97_differential_generated.lua'
head=["local np=require('luaray_core')","local count=0"]
cases=[]
views1={
 'whole':('base',lambda a:a), 'reverse':('np.flip(base)',lambda a:a[::-1]),
 'even':('base:get(np.slice(1,nil,2))',lambda a:a[::2]),
 'odd':('base:get(np.slice(2,nil,2))',lambda a:a[1::2]),
 'first':('base:get(np.slice(1,7))',lambda a:a[:6]),
 'last':('base:get(np.slice(7,nil))',lambda a:a[6:]),
 'middle':('base:get(np.slice(3,10))',lambda a:a[2:9]),
 'step3':('base:get(np.slice(1,nil,3))',lambda a:a[::3]),
 'copy':("np.astype(base,'int32')",lambda a:a.copy()),
}
views2={
 'whole':('base',lambda a:a),'transpose':('np.transpose(base)',lambda a:a.T),
 'flipx':('np.flip(base,1)',lambda a:a[::-1,:]),
 'flipy':('np.flip(base,2)',lambda a:a[:,::-1]),
 'evenrows':('base:get(np.slice(1,nil,2),np.slice())',lambda a:a[::2,:]),
 'oddrows':('base:get(np.slice(2,nil,2),np.slice())',lambda a:a[1::2,:]),
 'evencols':('base:get(np.slice(),np.slice(1,nil,2))',lambda a:a[:,::2]),
 'oddcols':('base:get(np.slice(),np.slice(2,nil,2))',lambda a:a[:,1::2]),
 'copy':("np.astype(base,'int32')",lambda a:a.copy()),
}
for ndim,variants in [(1,views1),(2,views2)]:
 for an,(al,ap) in variants.items():
  for bn,(bl,bp) in variants.items():
   base=np.arange(12,dtype='int32').reshape((3,4) if ndim==2 else (12,))
   x=ap(base);y=bp(base)
   exact=bool(np.shares_memory(x,y));possible=bool(np.may_share_memory(x,y))
   expr='np.arange(12,\'int32\'):reshape({3,4})' if ndim==2 else "np.arange(12,'int32')"
   cases.extend(['do',f'local base={expr}',f'local a={al}',f'local b={bl}',
    f"assert(np.shares_memory(a,b)=={str(exact).lower()},'{ndim}d {an}/{bn} exact')",
    f"assert(np.may_share_memory(a,b)=={str(possible).lower()},'{ndim}d {an}/{bn} maybe')",
    'count=count+1','end'])
n=len(views1)**2+len(views2)**2
p.write_text('\n'.join(head+cases+[f'assert(count=={n})',f"print('overlap97 differential: {n} cases passed')"])+ '\n')
print(n,p)
