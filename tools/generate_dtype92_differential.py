from pathlib import Path
import numpy as np
from itertools import product
root=Path(__file__).resolve().parents[1]
layouts={
 'c': (lambda x:x, 'base'),
 'trans':(lambda x:x.transpose(2,1,0), 'np.transpose(base,{3,2,1})'),
 'flip':(lambda x:np.flip(x,0), 'np.flip(base,1)'),
 'flip_t':(lambda x:np.flip(x.transpose(2,1,0),0), 'np.flip(np.transpose(base,{3,2,1}),1)'),
 'flip_mix':(lambda x:np.flip(np.flip(x.transpose(1,2,0),1),2), 'np.flip(np.flip(np.transpose(base,{2,3,1}),2),3)'),
 'swap':(lambda x:x.transpose(1,0,2), 'np.transpose(base,{2,1,3})'),
 'swap_flip':(lambda x:np.flip(x.transpose(1,0,2),2), 'np.flip(np.transpose(base,{2,1,3}),3)'),
 'single':(lambda x:x.reshape(1,2,3,4), 'base:reshape({1,2,3,4})'),
}
indtypes=['int16','int32','float32','float64','uint8','bool']
outdtypes=['int16','int64','float32','float64','uint8','bool']
orders=['C','F','A','K']
cases=[]
for ind, (kind,(fn,source)), out, order, copy in product(indtypes,layouts.items(),outdtypes,orders,[True,False]):
 x=fn(np.arange(24,dtype='int32').reshape(2,3,4).astype(ind))
 y=x.astype(out,order=order,copy=copy)
 values=[v.item() for v in y.flat]
 cases.append((ind,kind,out,order,copy,source,y,values,y is x))
lines=["local np=require('luaray_core')", "local function flat(a,o) if type(a)=='table' then for _,v in ipairs(a) do flat(v,o) end else o[#o+1]=a end end", "local n=0", "local function check(x,y,dtype,strides,expected,ident,label) assert(y.dtype==dtype,label..': dtype '..y.dtype); assert(#y.strides==#strides,label..': dims'); for i=1,#strides do assert(y.strides[i]==strides[i],label..': stride '..i..' got '..tostring(y.strides[i])..' expected '..strides[i]) end; local f={};flat(y:tolist(),f);assert(#f==#expected,label..': len');for i=1,#f do assert(f[i]==expected[i],label..': value '..i)end;assert((x==y)==ident,label..': copy/identity');n=n+1 end", "local b=np.arange(24,'int32'):reshape({2,3,4})"]
for ind in indtypes:
 lines.append(f"local base=np.astype(b,'{ind}')")
 for kind,(_fn,source) in layouts.items():
  lines.append(f"local x={source}")
  relevant=[case for case in cases if case[:2]==(ind,kind)]
  for _ind,_kind,out,order,copy,_src,y,values,ident in relevant:
   def fmt(v):
    if v is True:return 'true'
    if v is False:return 'false'
    return str(v)
   strides='{'+','.join(str(s) for s in y.strides)+'}'
   expected='{'+','.join(map(fmt,values))+'}'
   label=f'{ind}/{kind}/{out}/{order}/{copy}'
   lines.append(f"check(x,np.astype(x,'{out}',{{order='{order}',copy={str(copy).lower()}}}),'{out}',{strides},{expected},{str(ident).lower()},'{label}')")
lines.append("print('dtype92 differential: '..n..' NumPy comparisons passed')")
(root/'tests/dtype92_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('cases:',len(cases),'lines:',len(lines))

# Every result below is computed by NumPy, not by LuaRay.
from itertools import product as cross
types = ['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64','complex64','complex128','S2','S5','U2','U5','datetime64[D]','datetime64[ns]','timedelta64[D]','timedelta64[ns]']
cast_modes=['no','equiv','safe','same_kind','unsafe']
lines=["local np=require('luaray_core')", "local n=0"]
for a,b,mode in cross(types,types,cast_modes):
    yes = str(bool(np.can_cast(np.dtype(a),np.dtype(b),casting=mode))).lower()
    lines.append(f"assert(np.can_cast('{a}','{b}','{mode}')=={yes},'{a}/{b}/{mode}');n=n+1")
lines.append("print('dtype92 can_cast differential: '..n..' NumPy comparisons passed')")
(root/'tests/dtype92_can_cast_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('can_cast cases:',len(lines)-3)
