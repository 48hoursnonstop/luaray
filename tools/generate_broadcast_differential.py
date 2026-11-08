#!/usr/bin/env python3
"""Generate frozen NumPy-oracle cases for native broadcast APIs.

NumPy 2.3.5 is the locally executable oracle; NumPy 2.5.3 source is
used independently for implementation references. Python is not a dependency
of the LuaRay runtime or of playing the frozen generated test file.
"""
from pathlib import Path
import itertools
import math
import numpy as np

root=Path(__file__).resolve().parents[1]
lines=["local np=require('luaray_core')",'local n=0',r'''
local function equal(a,b)
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,'case '..n..' table mismatch')
  for i=1,#b do equal(a[i],b[i]) end
 else assert(a==b or (type(a)=='number' and type(b)=='number' and
     (a~=a and b~=b or math.abs(a-b)<1e-8*math.max(1,math.abs(b)))),
     'case '..n..': '..tostring(a)..' ~= '..tostring(b)) end
end
local function check(a,shape,strides,dtype,values)
 assert(a.ndim==#shape,'case '..n..' dimension mismatch')
 assert(a.dtype==dtype,'case '..n..' dtype '..a.dtype..' ~= '..dtype)
 equal(a.shape,shape)
 equal(a.strides,strides)
 equal(a:tolist(),values)
end
''']

def lit(x):
 if isinstance(x,np.ndarray):return lit(x.tolist())
 if isinstance(x,(tuple,list)):return '{'+','.join(lit(v) for v in x)+'}'
 if isinstance(x,(np.bool_,bool)):return 'true' if bool(x) else 'false'
 if isinstance(x,(np.integer,int)):return str(int(x))
 if isinstance(x,(np.floating,float)):
  if math.isnan(x):return '(0/0)'
  return repr(float(x))
 if isinstance(x,str):return '"'+x.replace('\\','\\\\').replace('"','\\"')+'"'
 raise TypeError(type(x))

def dtname(a):
 d=a.dtype
 if d.kind=='U':return f'<U{d.itemsize//4}'
 if d.kind=='S':return f'|S{d.itemsize}'
 return d.name

total=0; success=0; rejected=0

def case(expr, func, multiple=False, shape_only=False):
 global total,success,rejected
 total+=1
 try: out=func()
 except (ValueError, TypeError, OverflowError):
  rejected+=1
  lines.append(f'assert(not pcall(function()return {expr} end),"case {total}: expected rejection")')
 else:
  success+=1
  if shape_only: lines.append(f'equal({expr},{lit(out)})')
  else:
   if not multiple:out=[out]
   lines.append(f'do local results={{{expr}}}') if not multiple else lines.append(f'do local results={expr}')
   lines.append(f'assert(#results=={len(out)},"case {total}: result count")')
   for j,arr in enumerate(out,1):
    lines.append(f'check(results[{j}],{lit(arr.shape)},{lit(arr.strides)},'+
                 f'{lit(dtname(arr))},{lit(arr.tolist())})')
   lines.append('end')
 lines.append('n=n+1')

shapes=[(),(0,),(1,),(3,),(0,1),(1,0),(1,3),(3,1),(2,3),(2,1,3),(1,2,1),(2,2,3),(0,1,3)]
targets=[(),(0,),(1,),(3,),(2,),(0,1),(1,0),(1,3),(3,1),(2,3),(0,3),(1,0,3),(2,1,3),(2,2,3),(1,2,1,3),(2,0,3),(0,2,3)]
for dtype in ('int32','float64','bool','U2'):
 for shape in shapes:
  size=math.prod(shape)
  if dtype=='bool': vals=[i%3==0 for i in range(size)]
  elif dtype=='U2': vals=(['é','界','A','東','µ']*((size//5)+1))[:size]
  elif dtype=='float64': vals=[i*1.25-4 for i in range(size)]
  else: vals=[i*3-5 for i in range(size)]
  a=np.array(vals,dtype=dtype).reshape(shape)
  expr=f'np.reshape(np.array({lit(vals)},{lit(dtype)}),{lit(shape)})'
  variants=[(a,expr)]
  if a.ndim:variants.append((np.flip(a,axis=0),f'np.flip({expr},1)'))
  if a.ndim>=2:variants.append((a.T,f'np.transpose({expr})'))
  for v,code in variants:
   for target in targets:
    case(f'np.broadcast_to({code},{lit(target)})',lambda v=v,t=target:np.broadcast_to(v,t))
# Array lists, both singleton and expanded, with writable-input view semantics.
pairs=[((1,3),(2,1)),((2,1,3),(1,2,1)),((1,0),(2,1)),((0,1),(1,2)),
       ((2,3),(1,3)),((3,),(2,3)),((),(3,)),((2,3),(2,4)),
       ((1,1),(1,1)),((2,2),(2,2)),((1,),(1,)),((0,),(1,))]
for dtype in ('int32','float64','bool','U2'):
 for sa,sb in pairs:
  aa=np.array(list(range(math.prod(sa))),dtype=dtype).reshape(sa)
  bb=np.array(list(range(math.prod(sb))),dtype=dtype).reshape(sb)
  ca=f'np.reshape(np.array({lit(aa.flat[:].tolist())},{lit(dtype)}),{lit(sa)})'
  cb=f'np.reshape(np.array({lit(bb.flat[:].tolist())},{lit(dtype)}),{lit(sb)})'
  for f1,f2,code1,code2 in [(aa,bb,ca,cb),(aa[::-1] if aa.ndim else aa,bb, f'np.flip({ca},1)' if aa.ndim else ca,cb)]:
   case(f'np.broadcast_arrays({code1},{code2})',lambda a=f1,b=f2:np.broadcast_arrays(a,b),multiple=True)
# Shape discovery, including invalid argument shapes, zero axes and scalars.
shape_set=[(),(0,),(1,),(2,),(3,),(0,1),(1,0),(1,3),(3,1),(2,3),(3,2),
           (2,1,3),(1,2,1),(0,1,3),(2,2,3),(1,0,3),(2,0,3),(-1,3)]
for left,right in itertools.product(shape_set,repeat=2):
 case(f'np.broadcast_shapes({lit(left)},{lit(right)})',
      lambda a=left,b=right:np.broadcast_shapes(a,b),shape_only=True)
for a,b,c in itertools.product([(),(0,),(1,),(2,),(1,3),(2,1),(2,3)],repeat=3):
 case(f'np.broadcast_shapes({lit(a)},{lit(b)},{lit(c)})',
      lambda a=a,b=b,c=c:np.broadcast_shapes(a,b,c),shape_only=True)
case('np.broadcast_shapes()',lambda:np.broadcast_shapes(),shape_only=True)
case('np.broadcast_arrays()',lambda:np.broadcast_arrays(),multiple=True)
lines.append(f"print('broadcast differential: {success}/{success} matches, {rejected}/{rejected} rejected (total {total})')")
(root/'tests/broadcast_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('generated',total,'cases',success,'matches',rejected,'errors')
