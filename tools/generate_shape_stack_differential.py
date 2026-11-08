#!/usr/bin/env python3
"""Freeze NumPy 2.3.5 output for LuaRay 0.37 stack convenience APIs.
Source reference: NumPy 2.5.3 numpy/_core/shape_base.py.
Lua arrays are 1-indexed; values/dtype/shape match the NumPy executable oracle.
"""
from pathlib import Path
import itertools
import warnings
import numpy as np

out=Path(__file__).resolve().parents[1]/'tests/shape_stack_differential_generated.lua'
lines=["local np=require('luaray_core')",'local cases=0',r'''
local function equal(actual,expected)
 if type(expected)=='table' then
  assert(type(actual)=='table' and #actual==#expected,'case '..cases..' table length')
  for i=1,#expected do equal(actual[i],expected[i]) end
 elseif type(expected)=='number' then
  assert(type(actual)=='number' and (actual==expected or (actual~=actual and expected~=expected)),
   'case '..cases..': number mismatch '..tostring(actual)..' ~= '..tostring(expected))
 else assert(actual==expected,'case '..cases..' value mismatch '..tostring(actual)..' ~= '..tostring(expected)) end
end
local function check(arr,shape,dtype,data)
 assert(arr.ndim==#shape,'case '..cases..' ndim')
 assert(arr.dtype==dtype,'case '..cases..' dtype '..arr.dtype..' ~= '..dtype)
 equal(arr.shape,shape);equal(arr:tolist(),data)
end
''']

def lua(v):
 if isinstance(v,np.ndarray):return lua(v.tolist())
 if isinstance(v,(tuple,list)):return '{'+','.join(lua(x) for x in v)+'}'
 if isinstance(v,(np.bool_,bool)):return 'true' if v else 'false'
 if isinstance(v,(np.integer,int)):return str(int(v))
 if isinstance(v,(np.floating,float)):return repr(float(v))
 if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"').replace('\n','\\n')+'"'
 raise ValueError(repr(v))

def dtype_name(a):
 d=a.dtype
 if d.kind=='U':return f'<U{d.itemsize//4}'
 if d.kind=='S':return f'|S{d.itemsize}'
 return d.name

def seq(shape,dtype,seed):
 size=int(np.prod(shape))
 if dtype=='bool':vals=[bool((i+seed)%3==1) for i in range(size)]
 elif dtype=='U2':vals=[['東','ß','A','ñ','B','é','界'][(i+seed)%7] for i in range(size)]
 elif dtype=='float64':vals=[(i*3+seed)%13-6.5 for i in range(size)]
 elif dtype=='float32':vals=[(i*3+seed)%13-6.5 for i in range(size)]
 else: vals=[((i*3+seed)%17)-8 for i in range(size)]
 a=np.array(vals,dtype=dtype).reshape(shape)
 expr=f'np.reshape(np.array({lua(vals)},{lua(dtype)}),{lua(shape)})'
 return a,expr

success=0;reject=0
names=['hstack','vstack','dstack','column_stack','row_stack']
# Matched and intentionally incompatible rank/size combinations.
shapes=[(),(0,),(1,),(2,),(3,),(0,2),(2,0),(1,2),(2,1),(2,2),(2,3),(3,2),(0,2,1),(1,2,3),(2,1,2),(2,2,2)]
variants=[]
for dtype in ('bool','int16','float32','float64','U2'):
 for shape in shapes:
  base,expr=seq(shape,dtype,len(variants)%7)
  variants.append((base,expr))
  if base.ndim>=1 and base.size>0:
   variants.append((base[::-1],f'np.flip({expr},1)'))
  if base.ndim>=2:
   variants.append((base.T,f'{expr}.T'))
# Pair each shape with itself, and with a different but potentially compatible shape.
for j,(a,src_a) in enumerate(variants):
 # Keep each pair within one DType class. Numeric/text cross-promotion is
 # a separate unfinished core feature, not a stacking-specific operation.
 group=[v for v in variants if v[0].dtype==a.dtype]
 gj=next(k for k,(_,expr) in enumerate(group) if expr==src_a)
 choices=[(a,src_a),group[(gj+7)%len(group)],group[(gj+31)%len(group)]]
 for b,src_b in choices:
  for name in names:
   with warnings.catch_warnings():
    warnings.simplefilter('ignore',DeprecationWarning)
    try:expected=getattr(np,name)((a,b))
    except (ValueError,TypeError) as err: expected=None
   expression=f'np.{name}({{{src_a},{src_b}}})'
   if expected is None:
    lines.append(f'assert(not pcall(function()return {expression} end),"case {success+reject} expected failure")')
    reject+=1
   else:
    lines.append('check('+expression+','+lua(expected.shape)+','+lua(dtype_name(expected))+','+lua(expected.tolist())+')')
    success+=1
   lines.append('cases=cases+1')

# Override output dtype and casting semantics.
for name in names:
 for opts in ({'dtype':'float64'},{'dtype':'int16','casting':'unsafe'}, {'dtype':'int16','casting':'safe'}, {'casting':'no'}, {'casting':'same_kind'}):
  a=np.array([1,2],dtype='int16')
  b=np.array([3.5,4.5],dtype='float32')
  o='{'+','.join(f'{k}={lua(v)}' for k,v in opts.items())+'}'
  expr=f'np.{name}({{np.array({{1,2}},"int16"),np.array({{3.5,4.5}},"float32")}},{o})'
  try:
   with warnings.catch_warnings():
    warnings.simplefilter('ignore',DeprecationWarning)
    expected=getattr(np,name)((a,b),**opts)
  except (TypeError,ValueError):
   lines.append(f'assert(not pcall(function()return {expr} end))');reject+=1
  else:
   lines.append('check('+expr+','+lua(expected.shape)+','+lua(dtype_name(expected))+','+lua(expected.tolist())+')');success+=1
  lines.append('cases=cases+1')

lines.append(f'assert(cases=={success+reject});print("shape stack differential: {success+reject}/{success+reject} (valid {success}, expected rejections {reject})")')
out.write_text('\n'.join(lines)+'\n',encoding='utf8')
print(f'wrote {out.name}: {success} valid, {reject} expected rejections, {success+reject} total')
