#!/usr/bin/env python3
"""Reproducible roll/rollaxis oracle: upstream numeric.py (NumPy 2.5.3),
   executed with local NumPy 2.3.5. No Python dependency in Lua runtime.
"""
from pathlib import Path
import math
import numpy as np

root=Path(__file__).resolve().parents[1]
lines=["local np=require('luaray_core')",'local total=0',r'''
local function eq(x,y)
 if type(y)=='table' then
   assert(type(x)=='table' and #x==#y,'case '..total..' shape mismatch')
   for i=1,#y do eq(x[i],y[i])end
 elseif type(y)=='number' then
   assert(type(x)=='number' and (x==y or (x~=x and y~=y) or math.abs(x-y)<1e-6*math.max(1,math.abs(y))),
     'case '..total..' value mismatch '..tostring(x)..' vs '..tostring(y))
 else assert(x==y,'case '..total..' value mismatch '..tostring(x)..' vs '..tostring(y)) end
end
local function check(a, shape, dtype, values, strides)
 assert(a.ndim==#shape,'case '..total..' rank')
 assert(a.dtype==dtype,'case '..total..' dtype '..a.dtype..' vs '..dtype)
 eq(a.shape,shape); eq(a:tolist(),values)
 if strides then eq(a.strides,strides) end
end
''']
def lit(v):
 if isinstance(v,np.ndarray):return lit(v.tolist())
 if isinstance(v,(list,tuple)):return '{'+','.join(lit(x) for x in v)+'}'
 if isinstance(v,(np.bool_,bool)):return 'true' if bool(v) else 'false'
 if isinstance(v,(np.integer,int)):return str(int(v))
 if isinstance(v,(np.floating,float)):
  if math.isnan(v):return '(0/0)'
  if math.isinf(v):return 'math.huge' if v>0 else '(-math.huge)'
  return repr(float(v))
 if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"')+'"'
 raise ValueError(type(v))

def dname(a):
 d=a.dtype
 if d.kind=='U':return f'<U{d.itemsize//4}'
 return d.name

valid=invalid=0

def case(expr,fn,check_strides=False):
 global valid,invalid
 try:r=fn()
 except (ValueError,TypeError,np.exceptions.AxisError,OverflowError):
  invalid+=1
  lines.append(f'assert(not pcall(function() return {expr} end),"case "..total.." must reject")')
 else:
  valid+=1
  strides=lit(r.strides) if check_strides and r.size else 'nil'
  lines.append(f'check({expr},{lit(r.shape)},{lit(dname(r))},{lit(r.tolist())},{strides})')
 lines.append('total=total+1')

shapes=[(),(0,),(1,),(3,),(2,3),(3,1),(1,3),(2,0),(0,2),(2,2,3),(2,1,3),(2,3,2)]
shifts=[0,1,-1,2,-3,14,-28,1.8,-2.3, [1],[0,1],[-1,2],[2,-1,4],[],[5,5,5], [9223372036854775807,-9223372036854775807]]
for dtype in ('int32','float64','bool','U2','float16'):
 for shape in shapes:
  size=math.prod(shape)
  if dtype=='U2':values=(['é','東','é東','X','A']*(1+size//5))[:size]
  elif dtype=='bool':values=[i%2==0 for i in range(size)]
  else:values=[float(i-3) for i in range(size)]
  a=np.array(values,dtype=dtype).reshape(shape)
  code=f'np.reshape(np.array({lit(values)},{lit(dtype)}),{lit(shape)})'
  versions=[(a,code)]
  if a.ndim:versions.append((np.flip(a,-1),f'np.flip({code},-1)'))
  if a.ndim>1:versions.append((a.T,f'np.transpose({code})'))
  if a.ndim>2:versions.append((np.swapaxes(a,0,1),f'np.swapaxes({code},1,2)'))
  for arr,expr in versions:
   for shift in shifts:
    case(f'np.roll({expr},{lit(shift)})',lambda arr=arr,shift=shift:np.roll(arr,shift),True)
   axspecs=[0,-1]+([1] if arr.ndim>1 else [])
   for axis in axspecs:
    luaaxis=axis+1 if axis>=0 else axis
    for shift in shifts:
     case(f'np.roll({expr},{lit(shift)},{luaaxis})',lambda arr=arr,shift=shift,axis=axis:np.roll(arr,shift,axis),True)
   if arr.ndim>1:
    for ax in [(0,-1),(-1,0),(0,0),(1,1),()]:
     for shift in [1,-1,[1,2],[2,-1],[],[1]]:
      axes=tuple(x+1 if x>=0 else x for x in ax)
      case(f'np.roll({expr},{lit(shift)},{lit(axes)})',lambda arr=arr,shift=shift,ax=ax:np.roll(arr,shift,ax),True)
   if arr.ndim:
    for axis in range(-arr.ndim,arr.ndim):
     for start in [None,0,1,arr.ndim,-1,-arr.ndim,arr.ndim+1,-arr.ndim-1]:
      arg='nil' if start is None else str(start+1 if start>=0 else start)
      query=f'np.rollaxis({expr},{axis+1 if axis>=0 else axis},{arg})'
      case(query,lambda arr=arr,axis=axis,start=start:np.rollaxis(arr,axis,start if start is not None else 0),True)
   else:
    case(f'np.rollaxis({expr},1)',lambda arr=arr:np.rollaxis(arr,0))
   for shift in [np.array(2,dtype='int16'),np.array([2,-1],dtype='int8'),np.array([1.2,2.7],dtype='float64')]:
    as_list=lit(shift.tolist())
    shape=lit(shift.shape)
    rhs=f'np.reshape(np.array({as_list},{lit(dname(shift))}),{shape})'
    case(f'np.roll({expr},{rhs})',lambda arr=arr,shift=shift:np.roll(arr,shift),True)
lines.append(f"print('roll differential: {valid} matches + {invalid} rejected = {valid+invalid} cases')")
(root/'tests/roll_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print(f'generated roll: {valid} matches, {invalid} rejected, {valid+invalid} total')
