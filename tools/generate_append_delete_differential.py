#!/usr/bin/env python3
"""Freeze LuaRay 0.38 append/delete comparisons to locally installed NumPy.

The source specification is user-provided NumPy 2.5.3, while these evaluated
results are generated with the installed NumPy oracle (usually 2.3.5).
Axis and positions are translated from NumPy zero-based to LuaRay one-based.
"""
from pathlib import Path
import itertools
import numpy as np

out=Path(__file__).resolve().parents[1]/'tests/append_delete_differential_generated.lua'
lines=["local np=require('luaray_core')",'local cases=0',r'''
local function equal(a,b)
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,'case '..cases..' table length '..tostring(#a)..' ~= '..tostring(#b))
  for i=1,#b do equal(a[i],b[i]) end
 elseif type(b)=='number' then
  assert(type(a)=='number' and (a==b or (a~=a and b~=b)),'case '..cases..': value '..tostring(a)..' ~= '..tostring(b))
 else assert(a==b,'case '..cases..': value '..tostring(a)..' ~= '..tostring(b)) end
end
local function check(actual,shape,dtype,data)
 assert(actual.ndim==#shape,'case '..cases..': ndim')
 assert(actual.dtype==dtype,'case '..cases..': dtype '..actual.dtype..' ~= '..dtype)
 equal(actual.shape,shape)
 equal(actual:tolist(),data)
end
''']
def literal(v):
 if isinstance(v,np.ndarray):return literal(v.tolist())
 if isinstance(v,(tuple,list)):return '{'+','.join(literal(x) for x in v)+'}'
 if isinstance(v,(np.bool_,bool)):return 'true' if v else 'false'
 if isinstance(v,(np.integer,int)):return str(int(v))
 if isinstance(v,(np.floating,float)):return repr(float(v))
 if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"')+'"'
 if v is None:return 'nil'
 raise TypeError(v)
def dtype(a):
 if a.dtype.kind=='U':return f'<U{a.dtype.itemsize//4}'
 return a.dtype.name

def data(shape,dt,seed):
 size=int(np.prod(shape))
 if dt=='bool':values=[bool((j+seed)%3==0) for j in range(size)]
 elif dt=='U2':values=[['東','界','ö','ñ','ß','A','B'][(seed+j)%7] for j in range(size)]
 elif dt in ('float32','float64'):values=[((j+seed)%11-5.5) for j in range(size)]
 else:values=[((j*3+seed)%13-6) for j in range(size)]
 a=np.array(values,dtype=dt).reshape(shape)
 lua=f'np.reshape(np.array({literal(values)},{literal(dt)}),{literal(shape)})'
 return a,lua

valid=0; rejected=0

def add(expr,result=None,err=False):
 global valid,rejected
 if err:
  lines.append('assert(not pcall(function()return '+expr+' end),"case '+str(valid+rejected)+' expected failure")')
  rejected+=1
 else:
  lines.append('check('+expr+','+literal(result.shape)+','+literal(dtype(result))+','+literal(result.tolist())+')')
  valid+=1
 lines.append('cases=cases+1')

shapes=[(),(0,),(1,),(3,),(4,),(0,2),(2,0),(1,3),(2,2),(2,3),(3,2),(2,2,2),(2,0,3)]
variants=[]
for dt in ['bool','int16','float32','float64','U2']:
 for shape in shapes:
  a,source=data(shape,dt,len(variants)%7)
  variants.append((a,source))
  if a.ndim>=1 and a.size>0:
   variants.append((np.flip(a,axis=0),f'np.flip({source},1)'))
  if a.ndim>=2:
   variants.append((a.swapaxes(0,1),f'np.swapaxes({source},1,2)'))

# Append: scalar/vector/compatible and incompatible ranks; C-order flatten.
for k,(a,source) in enumerate(variants):
 group=[v for v in variants if v[0].dtype==a.dtype]
 choices=[(a,source),group[(k*5+11)%len(group)],group[(k*7+19)%len(group)]]
 if a.dtype.kind in ('f','i','b'):
  other_dt='float32' if a.dtype.kind in ('i','b') else 'int16'
  arr,arrsrc=data((2,),other_dt,k%7)
  choices.append((arr,arrsrc))
 for b,vsrc in choices:
  for ax in [None, 0, -1]:
   expr=f'np.append({source},{vsrc}'+(')' if ax is None else f',{ax+1 if ax>=0 else ax})')
   try: expected=np.append(a,b,axis=ax)
   except (ValueError,TypeError,np.exceptions.AxisError): add(expr,err=True)
   else: add(expr,expected)

# Delete: integer/list/boolean ndarray + slice, flattened and per-axis.
for a,source in variants:
 for ax in [None]+([0,-1] if a.ndim else [0]):
  length=a.size if ax is None else (a.shape[ax] if a.ndim else a.size)
  # Raw Lua 1-based indices. Avoid index=0 (always invalid in LuaRay).
  tests=[('1',0),('-1',-1),('2',1),('{1,-1}',[0,-1]),('{1,1}',[0,0]),('{}',[]),('{2,1}',[1,0]),
        (f'{{{length+1}}}',[length]),('{0}',[0]),
        ('np.slice()',slice(None)), ('np.slice(2)',slice(1,None)),
        ('np.slice(nil,nil,-1)',slice(None,None,-1)),
        ('np.slice(nil,nil,-2)',slice(None,None,-2)),
        ('np.slice(2,4)',slice(1,3)),
        ('np.slice(3,1,-1)',slice(2,0,-1)),
        ('np.array({1,-1},"int16")',np.array([0,-1],dtype=np.int16)),
        ('np.array({},"int16")',np.array([],dtype=np.int16))]
  if length<10:
   bools=[j%3==0 for j in range(length)]
   tests.extend([(literal(bools),bools),('np.array('+literal(bools)+',"bool")',np.array(bools,dtype=bool)),
                 ('{true}',[True]),('np.array({true},"bool")',np.array([True],dtype=bool))])
  for objexpr,obj in tests:
   expr='np.delete('+source+','+objexpr+(')' if ax is None else f',{ax+1 if ax>=0 else ax})')
   if objexpr=='{0}':
    # Lua index 0 is invalid, independent of valid NumPy index zero.
    add(expr,err=True)
    continue
   try: expected=np.delete(a,obj,axis=ax)
   except (IndexError,ValueError,TypeError,np.exceptions.AxisError): add(expr,err=True)
   else: add(expr,expected)

lines.append(f'assert(cases=={valid+rejected});print("append/delete differential: {valid+rejected}/{valid+rejected} (valid {valid}, rejected {rejected})")')
out.write_text('\n'.join(lines)+'\n',encoding='utf8')
print(f'generated {out}: {valid} valid + {rejected} rejected = {valid+rejected}')
