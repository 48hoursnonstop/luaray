#!/usr/bin/env python3
"""Generate native LuaRay logical-reduction reference cases from installed NumPy."""
from pathlib import Path
import random, warnings, math
import numpy as np
r=random.Random(490049)
p=Path(__file__).resolve().parents[1]/'tests/truth_differential_generated.lua'
lines=["local np=require('luaray_core')", '''local function same(a,b)
 if type(a)=='table' then
  assert(type(b)=='table' and #a==#b,'table length mismatch')
  for i=1,#a do same(a[i],b[i]) end
 elseif type(a)=='number' and type(b)=='number' and a~=a and b~=b then return
 else assert(a==b, tostring(a)..' ~= '..tostring(b)) end
end''']
def lua(v):
 if isinstance(v,np.ndarray): return lua(v.tolist())
 if isinstance(v,(list,tuple)):return '{'+','.join(lua(x) for x in v)+'}'
 if isinstance(v,(bool,np.bool_)):return 'true' if v else 'false'
 if isinstance(v,(complex,np.complexfloating)):return 'np.complex('+lua(float(v.real))+','+lua(float(v.imag))+')'
 if isinstance(v,(int,np.integer)):return str(int(v))
 if isinstance(v,(float,np.floating)):
  v=float(v)
  if math.isnan(v):return '(0/0)'
  if math.isinf(v):return 'math.huge' if v>0 else '-math.huge'
  return repr(v)
 if isinstance(v,(str,bytes,np.str_,np.bytes_)):
  if isinstance(v,bytes):v=v.decode('ascii')
  return '"'+str(v).replace('\\','\\\\').replace('"','\\"')+'"'
 raise TypeError((type(v),v))
shapes=[(),(0,),(1,),(2,),(4,),(0,3),(2,0),(2,1),(2,3),(3,2),(2,3,2),(1,2,3),(2,0,3)]
dtypes=['bool','int8','int16','int32','int64','uint8','uint64','float16','float32','float64','complex64','complex128','S3','U3']
count=0
for k in range(3200):
 shape=r.choice(shapes);dtype=r.choice(dtypes);n=math.prod(shape);op=r.choice(['any','all','count_nonzero'])
 if dtype=='bool':data=[r.random()<.45 for _ in range(n)]
 elif dtype in ('S3','U3'):data=[r.choice(['','a','XX','xyz']) for _ in range(n)]
 elif dtype.startswith('complex'):data=[complex(r.choice([0,0,2,-1,float('nan')]),r.choice([0,0,0,3])) for _ in range(n)]
 elif dtype.startswith('float'):data=[r.choice([0.0,0.0,-0.0,-2.0,4.0,float('nan'),float('inf')]) for _ in range(n)]
 else: data=[r.choice([0,0,0,1,-1,5]+([2**53+3] if dtype in ('int64','uint64') else [])) for _ in range(n)]
 if dtype.startswith('uint'):data=[abs(x) for x in data]
 arr=np.array(data,dtype=dtype).reshape(shape)
 if not n:inp='np.zeros('+lua(shape)+',"'+dtype+'")'
 else:inp='np.array('+lua(arr.tolist())+',"'+dtype+'")'
 # 0d ndarray from scalar, selected shapes naturally become 0d through np.array
 view=r.choice(['none','none','flip','transpose'])
 if view=='flip' and arr.ndim:arr=np.flip(arr,axis=-1);inp='np.flip('+inp+','+str(arr.ndim)+')'
 if view=='transpose' and arr.ndim>1:arr=arr.T;inp='np.transpose('+inp+')'
 ax=r.choice(['none','none','none','single','all','empty'])
 axis=None
 if ax=='single' and arr.ndim:axis=r.randrange(arr.ndim)
 if ax=='all':axis=tuple(range(arr.ndim))
 if ax=='empty':axis=()
 kd=r.random()<.25
 opts=[];npopts={}
 if axis is not None:
  opts.append('axis='+lua(tuple(a+1 for a in axis) if isinstance(axis,tuple) else axis+1))
  npopts['axis']=axis
 if kd:opts.append('keepdims=true');npopts['keepdims']=True
 if op!='count_nonzero' and r.random()<.32:
  wm=r.choice(['false','true','full','broadcast'])
  if wm=='false':v=False;wexpr='false'
  elif wm=='true':v=True;wexpr='true'
  elif wm=='broadcast' and arr.ndim>0:
   mshape=(1,)*max(0,arr.ndim-1)+(arr.shape[-1],)
   v=np.array([r.random()<.6 for _ in range(arr.shape[-1])],dtype=bool).reshape(mshape)
   wexpr='np.array('+lua(v.tolist())+',"bool")'
  else:
   v=np.array([r.random()<.5 for _ in range(arr.size)],dtype=bool).reshape(arr.shape)
   wexpr='np.array('+lua(v.tolist())+',"bool")' if v.size else 'np.zeros('+lua(v.shape)+',"bool")'
  npopts['where']=v;opts.append('where='+wexpr)
 call='np.'+op+'(a'+(',{'+','.join(opts)+'}' if opts else '')+')'
 with warnings.catch_warnings():
  warnings.simplefilter('ignore')
  try:res=getattr(np,op)(arr,**npopts)
  except Exception:lines.append('do local a='+inp+'; assert(not pcall(function() '+call+' end)) end');count+=1;continue
 if isinstance(res,np.ndarray):
  val=lua(res.tolist());ct='local v='+call+';assert(v.dtype=="'+('int64' if op=='count_nonzero' else 'bool')+'")\nsame(v:tolist(),'+val+')'
 else:ct='same('+call+','+lua(res)+')'
 lines.append('do local a='+inp+'; '+ct+' end')
 count+=1
lines.append("print('truth differential: "+str(count)+" cases passed')")
p.write_text('\n'.join(lines)+'\n')
print('generated',count,'cases to',p,'from NumPy',np.__version__)
