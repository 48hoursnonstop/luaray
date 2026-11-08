#!/usr/bin/env python3
"""Generate source-reproducible NumPy nan extrema fixtures (oracle NumPy 2.3.5).
NumPy indexes are zero-based; LuaRay indexes are one-based by design.
"""
from pathlib import Path
import random, warnings
import numpy as np

rng = random.Random(470042)
root = Path(__file__).resolve().parent.parent
out = root / 'tests/nanextrema_differential_generated.lua'

def lit(x):
    if isinstance(x,(bool,np.bool_)):return 'true' if x else 'false'
    if isinstance(x,(complex,np.complexfloating)):
        return 'n.complex('+lit(float(x.real))+','+lit(float(x.imag))+')'
    if isinstance(x,(int,np.integer)):return str(int(x))
    x=float(x)
    if np.isnan(x):return '(0/0)'
    if np.isposinf(x):return 'math.huge'
    if np.isneginf(x):return '-math.huge'
    return repr(x)

def val(x):
    if isinstance(x,np.ndarray):return val(x.tolist())
    if isinstance(x,(list,tuple)):return '{'+','.join(val(v) for v in x)+'}'
    return lit(x)

lines=["local n=require('luaray_core')",'''local function eq(a,b)
 if type(a)=='table' then
  assert(type(b)=='table' and #a==#b,'table length mismatch')
  for i=1,#a do eq(a[i],b[i]) end
 elseif type(a)=='userdata' and type(b)=='userdata' then
  eq(a.real,b.real);eq(a.imag,b.imag)
 elseif type(a)=='number' and type(b)=='number' then
  if a~=a or b~=b then assert(a~=a and b~=b,'NaN mismatch')
  elseif a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then assert(a==b,'infinity mismatch')
  else assert(math.abs(a-b)<=0.00015*math.max(1,math.abs(b)),tostring(a)..' != '..tostring(b)) end
 else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function must_fail(f) local ok=pcall(f);assert(not ok,'expected failure') end''']

shapes=[(),(0,),(1,),(4,),(2,3),(3,2),(0,3),(3,0),(2,0,3),(2,3,2),(1,2,1),(2,1,3)]
dtypes=['bool','int8','uint8','int32','int64','float16','float32','float64','complex64','complex128']
ops=['nanmin','nanmax','nanargmin','nanargmax']
count=good=bad=0
for shape in shapes:
 for dt in dtypes:
  for variant in range(4):
   size=int(np.prod(shape)) if shape else 1
   vals=[]
   for i in range(size):
    x=rng.choice([-7,-4,-2,0,0,1,3,5,8])
    if dt=='bool':v=bool(x)
    elif dt.startswith('uint'):v=abs(x)
    elif dt.startswith('complex'):
      v=complex(float(x),float(rng.choice([-2,0,0,1,4])))
      if variant==1 and i==size//2: v=complex(float('nan'),2)
      if variant==3: v=complex(float('nan'),float(i))
    elif dt.startswith('float'):
      v=float(x)/2
      if variant==1 and i==size//2:v=float('nan')
      if variant==3:v=float('nan')
    else:v=x
    vals.append(v)
   arr=np.array(vals,dtype=dt).reshape(shape)
   lua_arr='n.reshape(n.array('+val(vals)+',n.'+dt+'),'+val(list(shape))+')'
   if variant==2 and len(shape)>=2:
    arr=arr.swapaxes(0,-1)
    lua_arr='n.swapaxes('+lua_arr+',1,'+str(len(shape))+')'
   if variant==1 and len(shape)>=1:
    arr=np.flip(arr,axis=-1)
    lua_arr='n.flip('+lua_arr+',-1)'
   axes=list(dict.fromkeys([None]+list(range(arr.ndim))+([-1] if arr.ndim else [0])))
   for op in ops:
    for ax in axes:
     for keep in (False,True):
      opts='{keepdims='+str(keep).lower() + (',axis='+str(ax+1 if ax>=0 else ax) if ax is not None else '')+'}'
      call='n.'+op+'(a,'+opts+')'
      kw={'keepdims':keep}
      if ax is not None:kw['axis']=ax
      with warnings.catch_warnings():
       warnings.simplefilter('ignore',RuntimeWarning)
       try:r=getattr(np,op)(arr,**kw);success=True
       except (ValueError,TypeError,np.exceptions.AxisError):success=False
      lines.append(f'do -- case {count}: {op} {dt} {shape} variant {variant} axis {ax} keepdims {keep}')
      lines.append(' local a='+lua_arr)
      if success:
       rr=np.asarray(r)
       if op.startswith('nanarg'):rr=rr+1
       if rr.ndim:
        lines.append(' local r='+call)
        lines.append(' assert(type(r)=="userdata")')
        lines.append(' eq(r.shape,'+val(rr.shape)+')')
        lines.append(' assert(r.dtype=='+repr(str(np.asarray(r).dtype if op.startswith('nanarg') else arr.dtype))+')')
        lines.append(' eq(r:tolist(),'+val(rr)+')')
       else:
        lines.append(' eq('+call+','+val(rr.item())+')')
       good+=1
      else:
       lines.append(' must_fail(function() '+call+' end)');bad+=1
      lines.append('end')
      count+=1
lines.append(f"print('nan extrema differential: {good}/{good} valid + {bad}/{bad} rejected = {count}/{count}')")
out.write_text('\n'.join(lines)+'\n')
print(f'wrote {count} cases ({good} valid, {bad} rejected), NumPy {np.__version__}')
