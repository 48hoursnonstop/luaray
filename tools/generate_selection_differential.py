#!/usr/bin/env python3
"""Deterministic differential fixture for LuaRay argmin/argmax/ptp.
Requires NumPy only when generating fixtures, not during LuaRay runtime.
LuaRay's public position indices are 1-based; NumPy's are 0-based.
"""
import numpy as np
from pathlib import Path
import random

rng=random.Random(430031)
out=Path(__file__).resolve().parent.parent/'tests/selection_differential_generated.lua'
lines=["local n=require('luaray_core')", '''local function eq(a,b)
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
local function must_fail(fn) local ok,err=pcall(fn); assert(not ok,'expected a rejection') end''']

def lit(v):
    if isinstance(v,(np.bool_,bool)):return 'true' if v else 'false'
    if isinstance(v,(complex,np.complexfloating)):
        return 'n.complex('+lit(float(v.real))+','+lit(float(v.imag))+')'
    if isinstance(v,(int,np.integer)):return str(int(v))
    v=float(v)
    if np.isnan(v):return '(0/0)'
    if np.isposinf(v):return 'math.huge'
    if np.isneginf(v):return '-math.huge'
    return repr(v)

def val(v):
    if isinstance(v,np.ndarray):return val(v.tolist())
    if isinstance(v,list):return '{'+','.join(val(z) for z in v)+'}'
    return lit(v)

dtypes=['int8','uint8','int32','int64','float16','float32','float64','complex64','complex128','bool']
shapes=[(),(0,),(1,),(4,),(2,3),(3,2),(0,3),(3,0),(2,0,3),(2,3,2),(1,2,1),(2,1,3),(2,3,1)]
count=0; valid=0; invalid=0
for shape in shapes:
  for dt in dtypes:
    for variant in range(3):
      count0=int(np.prod(shape)) if shape else 1
      vals=[]
      for i in range(count0):
        v=rng.choice([-9,-4,-2,-1,0,0,0,1,1,3,3,7,12])
        if dt=='bool':v=bool(v)
        elif dt.startswith('uint'):v=abs(v)
        elif dt.startswith('float'):
          v=float(v)*0.5
          if variant==1 and i==count0//2:v=float('nan')
          if variant==2 and i==0:v=-0.0
        elif dt.startswith('complex'):
          v=complex(float(v), rng.choice([-4,0,1,3]))
          if variant==1 and i==count0//2:v=complex(float('nan'),1)
        vals.append(v)
      arr=np.array(vals,dtype=dt).reshape(shape)
      lua_arr='n.reshape(n.array('+val(vals)+',n.'+dt+'),'+val(list(shape))+')'
      # Contiguous, reversed last axis, and transposed 2-D/3-D arrays.
      if variant==2 and len(shape)>=2:
        arr=arr.swapaxes(0,len(shape)-1)
        lua_arr='n.swapaxes('+lua_arr+',1,'+str(len(shape))+')'
      if variant==1 and len(shape)>=1:
        arr=np.flip(arr,axis=-1)
        lua_arr='n.flip('+lua_arr+',-1)'
      axes=[None]+list(range(len(shape)))+([-1] if len(shape) else [0]);axes=list(dict.fromkeys(axes))
      for op in ('argmin','argmax','ptp'):
        for ax in axes:
          for keep in (False,True):
            kwargs=dict(keepdims=keep)
            if ax is not None:kwargs['axis']=ax
            try:
              with np.errstate(all='ignore'):
                result=getattr(np,op)(arr,**kwargs)
              good=True
            except (ValueError,TypeError,np.exceptions.AxisError if hasattr(np,'exceptions') else ValueError):
              good=False
            lua_axis='nil' if ax is None else str(ax+1 if ax>=0 else ax)
            if ax is None:
              call='n.'+op+'(a,{keepdims='+str(keep).lower()+'})'
            else:
              call='n.'+op+'(a,{axis='+lua_axis+',keepdims='+str(keep).lower()+'})'
            if good:
              if op in ('argmin','argmax'):result=np.asarray(result)+1
              expected=val(result)
              result_arr=np.asarray(result)
              if result_arr.ndim:
                # Assert shape as well as values; empty tolist() alone loses shape.
                shp=val(list(result_arr.shape))
                test='local r='+call+'; assert(type(r)=="userdata"); eq(r.shape,'+shp+'); eq(r:tolist(),'+expected+')'
                if op=='ptp':test+='; assert(r.dtype=="'+str(result_arr.dtype)+'")'
              else:test='eq('+call+','+expected+')'
              valid+=1
            else:
              test='must_fail(function() return '+call+' end)'
              invalid+=1
            lines.append('do -- case '+str(count)+' '+op+' '+dt+' '+str(arr.shape)+' axis='+str(ax)+'\n local a='+lua_arr+'\n '+test+'\nend')
            count+=1
lines.append(f"print('selection differential: {count}/{count} (valid {valid}, expected rejections {invalid})')")
out.write_text('\n'.join(lines)+'\n')
print(out,count,valid,invalid)
