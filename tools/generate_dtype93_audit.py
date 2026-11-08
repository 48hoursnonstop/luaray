import numpy as np, itertools, math
from pathlib import Path
lines=['local np=require("luaray_core")','local n=0','local function flat(a,o) if type(a)=="table" then for _,v in ipairs(a) do flat(v,o) end else o[#o+1]=a end end','local function check(x,y,st,expect,ident,label) assert(#y.strides==#st,label.." ndim");for j=1,#st do assert(y.strides[j]==st[j],label.." stride "..j.." got "..tostring(y.strides[j]).." != "..st[j])end; local f={};flat(y:tolist(),f);assert(#f==#expect,label.." len");for j=1,#f do assert(f[j]==expect[j],label.." val "..j)end;assert((x==y)==ident,label.." identity");n=n+1 end']
cases=0
for shape in [(1,3,4),(2,1,3),(1,1,4),(2,3,1),(0,3,4),(2,0,4),(2,3,0),(1,2,1),(2,2,2),(1,1,1),(4,),(1,),(0,)]:
  m=math.prod(shape)
  for perm in ([tuple(range(len(shape)))] if len(shape)==1 else itertools.permutations(range(len(shape)))):
    for axis in [-1,0,1] if len(shape)>1 else [-1,0]:
      if axis>=len(shape): continue
      base=np.arange(m,dtype=np.int32).reshape(shape); x=np.flip(base.transpose(perm),axis) if axis>=0 else base.transpose(perm)
      code=f'np.arange({m},"int32"):reshape({{{",".join(map(str,shape))}}})'
      if perm!=tuple(range(len(shape))):code=f'np.transpose({code},{{{",".join(str(v+1) for v in perm)}}})'
      if axis>=0:code=f'np.flip({code},{axis+1})'
      lines.append('do local x='+code)
      for order,copy in itertools.product('CF AK'.replace(' ',''),[True,False]):
        y=x.astype(np.int32, order=order, copy=copy)
        label=f'{shape}/{perm}/{axis}/{order}/{copy}'
        st=','.join(str(int(v)) for v in y.strides)
        dat=','.join(str(int(v)) for v in y.ravel(order='C'))
        lines.append(f'check(x,np.astype(x,"int32",{{order="{order}",copy={str(copy).lower()}}}),{{{st}}},{{{dat}}},{str(y is x).lower()},"{label}")')
        cases+=1
      lines.append('end')
lines.append('print("dtype93 audit:",n)')
(Path(__file__).resolve().parents[1] / 'tests/dtype93_audit_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('cases',cases)
