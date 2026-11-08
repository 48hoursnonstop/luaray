#!/usr/bin/env python3
"""Freeze NumPy >=2.3 oracle results for LuaRay's Lua 1-based atleast APIs.
Reference: numpy/_core/shape_base.py, NumPy 2.5.3 source archive.
This generator is development-only, not needed at LuaRay runtime.
"""
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests/atleast_differential_generated.lua'
lines=["local np=require('luaray_core')",'local cases=0',r'''
local function equal(actual,expected)
  if type(expected)=='table' then
    assert(type(actual)=='table' and #actual==#expected,'case '..cases..' table shape')
    for i=1,#expected do equal(actual[i],expected[i]) end
  elseif type(expected)=='number' then
    assert(type(actual)=='number' and (actual==expected or (actual~=actual and expected~=expected)),
      'case '..cases..' number mismatch '..tostring(actual)..' ~= '..tostring(expected))
  else assert(actual==expected,'case '..cases..' value mismatch '..tostring(actual)..' ~= '..tostring(expected)) end
end
local function check(a,shape,dtype,data,strides)
 assert(a.ndim==#shape,'case '..cases..' rank '..a.ndim..' ~= '..#shape)
 assert(a.dtype==dtype,'case '..cases..' dtype '..a.dtype..' ~= '..dtype)
 equal(a.shape,shape);equal(a:tolist(),data)
 if strides then equal(a.strides,strides) end
end
''']

def lit(v):
 if isinstance(v,np.ndarray):return lit(v.tolist())
 if isinstance(v,(list,tuple)):return '{'+','.join(map(lit,v))+'}'
 if isinstance(v,(np.bool_,bool)):return 'true' if v else 'false'
 if isinstance(v,(np.integer,int)):return str(int(v))
 if isinstance(v,(np.floating,float)):return repr(float(v))
 if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"')+'"'
 raise ValueError(type(v))

def dname(a):
 d=a.dtype
 if d.kind=='U':return f'<U{d.itemsize//4}'
 if d.kind=='S':return f'|S{d.itemsize}'
 return d.name

def check(expr,result):
 lines.append('check('+expr+','+lit(result.shape)+','+lit(dname(result))+','+lit(result.tolist())+','+
              (lit(result.strides) if result.size else 'nil')+')')
 lines.append('cases=cases+1')

shapes=[(),(0,),(1,),(3,),(0,3),(2,0),(1,3),(2,3),(1,1,1),(2,1,3),(0,2,3),(2,3,4),(2,1,3,1),(2,3,1,4)]
valid=0
for dtype in ('int16','float64','bool','U2'):
 for shape in shapes:
  size=int(np.prod(shape))
  if dtype=='bool':values=[i%3==0 for i in range(size)]
  elif dtype=='U2':values=(['é','界','A','ß','東','µ','b']*(1+size//7))[:size]
  elif dtype=='float64':values=[i*1.25-3.5 for i in range(size)]
  else:values=[i*3-7 for i in range(size)]
  a=np.array(values,dtype=dtype).reshape(shape)
  base=f'np.reshape(np.array({lit(values)},{lit(dtype)}),{lit(shape)})'
  variants=[(a,base)]
  if a.ndim>=1:
   variants.append((a[::-1],base+':get(np.slice(nil,nil,-1))'))
  if a.ndim>=2:
   variants.append((a.T,base+'.T'))
  for value,src in variants:
   for rank in (1,2,3):
    check(f'np.atleast_{rank}d({src})',getattr(np,f'atleast_{rank}d')(value));valid+=1

# Lua tables and non-ndarray scalars, plus NumPy's varargs return policy.
for rank in (1,2,3):
 for value in (0,1,2.5,True,'é'):
  check(f'np.atleast_{rank}d({lit(value)})',getattr(np,f'atleast_{rank}d')(value));valid+=1
 for value in ([1,2,3],[[1,2],[3,4]],[],[[],[]]):
  check(f'np.atleast_{rank}d({lit(value)})',getattr(np,f'atleast_{rank}d')(value));valid+=1
 # Each tuple element becomes a separate array result, even if one is a scalar.
 values=[np.array(5,dtype='int64'),np.arange(3,dtype='int64'),np.arange(6,dtype='int64').reshape(2,3)]
 expr=f'np.atleast_{rank}d(np.array(5,"int64"),np.arange(3,"int64"),np.reshape(np.arange(6,"int64"),{{2,3}}))'
 outs=getattr(np,f'atleast_{rank}d')(*values)
 lines.append('do local many='+expr+';assert(#many==3)')
 for j,result in enumerate(outs,1):
  check(f'many[{j}]',result);valid+=1
 lines.append('end')
 lines.append(f'assert(#np.atleast_{rank}d()==0);cases=cases+1');valid+=1

lines.append(f'assert(cases=={valid});print("atleast differential: {valid}/{valid} NumPy matches")')
OUT.write_text('\n'.join(lines)+'\n',encoding='utf-8')
print(f'wrote {OUT.name}: {valid} NumPy cases')
