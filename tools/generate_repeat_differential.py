#!/usr/bin/env python3
"""Frozen NumPy 2.3.5 differential tests for tile/repeat in LuaRay.
Implementation specification: NumPy 2.5.3 numeric.tile/fromnumeric.repeat.
Python is required for test generation only, never LuaRay runtime.
"""
from pathlib import Path
import math
import numpy as np

root=Path(__file__).resolve().parents[1]
lines=["local np=require('luaray_core')",'local total=0',r'''
local function eq(x,y)
 if type(y)=='table' then
  assert(type(x)=='table' and #x==#y,'case '..total..' table length mismatch')
  for i=1,#y do eq(x[i],y[i]) end
 elseif type(y)=='number' then
  assert(type(x)=='number' and (x==y or (x~=x and y~=y) or
    math.abs(x-y)<1e-7*math.max(1,math.abs(y))),
    'case '..total..' value '..tostring(x)..' ~= '..tostring(y))
 else assert(x==y,'case '..total..' value '..tostring(x)..' ~= '..tostring(y)) end
end
local function check(a,shape,dtype,values,strides)
 assert(a.ndim==#shape,'case '..total..' rank')
 assert(a.dtype==dtype,'case '..total..' dtype '..a.dtype..' != '..dtype)
 eq(a.shape,shape);eq(a:tolist(),values)
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
        return repr(float(v))
    if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"')+'"'
    raise ValueError(type(v))

def dtype_name(x):
    d=x.dtype
    if d.kind=='U':return f'<U{d.itemsize//4}'
    if d.kind=='S':return f'|S{d.itemsize}'
    return d.name

count=passed=rejected=0

def case(expr,call,stride=True):
    global count,passed,rejected
    count+=1
    try:result=call()
    except (ValueError,TypeError,OverflowError,AxisError if hasattr(np,'AxisError') else ValueError):
        rejected+=1
        lines.append(f'assert(not pcall(function()return {expr} end),"case {count}: should reject")')
    else:
        passed+=1
        strides=lit(result.strides) if stride and result.size else 'nil'
        lines.append(f'check({expr},{lit(result.shape)},{lit(dtype_name(result))},{lit(result.tolist())},{strides})')
    lines.append('total=total+1')

shapes=[(),(0,),(1,),(3,),(1,3),(3,1),(2,3),(2,0),(0,2),(2,1,3),(2,2,2)]
reps=[(),(0,),(1,),(2,),(3,),(1,0),(0,3),(2,3),(3,1),(1,1,2),(2,0,3),(1,2,1,2)]
for dtype in ('int32','float64','bool','U2','float16'):
 for shape in shapes:
  size=math.prod(shape)
  if dtype=='U2':values=(['東','é','µ','東京','A']*(1+size//5))[:size]
  elif dtype=='bool': values=[k%2==0 for k in range(size)]
  else:values=[k*1.5-3 for k in range(size)]
  a=np.array(values,dtype=dtype).reshape(shape)
  code=f'np.reshape(np.array({lit(values)},{lit(dtype)}),{lit(shape)})'
  variants=[(a,code)]
  if a.ndim:variants.append((np.flip(a,axis=-1),f'np.flip({code},-1)'))
  if a.ndim>1:variants.append((a.T,f'np.transpose({code})'))
  for v,vcode in variants:
   for repspec in reps:
    case(f'np.tile({vcode},{lit(repspec)})',lambda v=v,r=repspec:np.tile(v,r))
   for times in (0,1,2,3):
    case(f'np.tile({vcode},{times})',lambda v=v,t=times:np.tile(v,t))
   for axis in [None,0,-1]+([1] if v.ndim>1 else []):
    axis_code='false' if axis is None else str(axis+1 if axis>=0 else axis)
    alen=(v.size if axis is None else (v.shape[axis] if v.ndim else 1))
    counts=[0,1,2,3,[0],[2],[],[i%3 for i in range(alen)],
            [2]*alen, [0]*alen, [2]*(alen+1)]
    for rep in counts:
     expr=f'np["repeat"]({vcode},{lit(rep)},{axis_code})'
     case(expr,lambda v=v,r=rep,ax=axis:np.repeat(v,r,axis=ax))

# Invalid shapes and axis semantics, including overflow and nonintegral input.
code='np.array({1,2,3},"int16")';a=np.array([1,2,3],dtype='int16')
for rep in ([-1,1],[1,-1],[-1],[-3,2], [1,1.5], [1,2.5,3], [1,2,3,4]):
 case(f'np["repeat"]({code},{lit(rep)},1)',lambda r=rep:np.repeat(a,r,axis=0))
for axis in (-4,-2,1,2,3):
 axis_code=axis+1 if axis>=0 else axis
 case(f'np["repeat"]({code},2,{axis_code})',lambda ax=axis:np.repeat(a,2,axis=ax))
for rep in ((-1,),(-2,3),(1,-1,0)):
 case(f'np.tile({code},{lit(rep)})',lambda r=rep:np.tile(a,r))
lines.append(f"print('repeat/tile differential: {passed}/{passed} matches, {rejected}/{rejected} rejected (total {count})')")
(root/'tests/repeat_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('generated',count,'cases',passed,'matches',rejected,'rejections')
