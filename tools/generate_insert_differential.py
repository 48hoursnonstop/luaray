#!/usr/bin/env python3
"""NumPy 2.3.5 executable oracle for 0.39 native insert (source: NumPy 2.5.3).

LuaRay uses 1-based positions and axes; translate equivalent NumPy cases.
"""
from pathlib import Path
import numpy as np

out=Path(__file__).resolve().parents[1]/'tests/insert_differential_generated.lua'
lines=["local np=require('luaray_core')",'local cases=0',r'''
local function equal(a,b)
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b, 'case '..cases..': table lengths')
  for i=1,#b do equal(a[i],b[i]) end
 elseif type(b)=='number' then
  assert(type(a)=='number' and (a==b or (a~=a and b~=b)),'case '..cases..': number '..tostring(a)..' ~= '..tostring(b))
 else assert(a==b,'case '..cases..': value '..tostring(a)..' ~= '..tostring(b)) end
end
local function check(a,shape,dtype,data)
 assert(a.ndim==#shape,'case '..cases..': ndim')
 assert(a.dtype==dtype,'case '..cases..': dtype '..a.dtype..' vs '..dtype)
 equal(a.shape,shape);equal(a:tolist(),data)
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
 raise TypeError(type(v))
def dtype(a):
 return f'<U{a.dtype.itemsize//4}' if a.dtype.kind=='U' else a.dtype.name

def create(shape,dt,seed):
 n=int(np.prod(shape))
 if dt=='bool': vals=[(i+seed)%3==0 for i in range(n)]
 elif dt=='U2':vals=[['東','界','ñ','ö','A'][(seed+i)%5] for i in range(n)]
 elif dt.startswith('float'):vals=[(i*3+seed)%14-5.75 for i in range(n)]
 else:vals=[(i*5+seed)%19-8 for i in range(n)]
 a=np.array(vals,dtype=dt).reshape(shape)
 return a,f'np.reshape(np.array({literal(vals)},{literal(dt)}),{literal(shape)})'

valid=rejected=0

def add(expr,expected=None,err=False):
 global valid,rejected
 if err:
  lines.append('assert(not pcall(function()return '+expr+' end),"case '+str(valid+rejected)+' expected failure")')
  rejected+=1
 else:
  lines.append('check('+expr+','+literal(expected.shape)+','+literal(dtype(expected))+','+literal(expected.tolist())+')')
  valid+=1
 lines.append('cases=cases+1')

shapes=[(),(0,),(1,),(3,),(4,),(0,2),(2,0),(2,2),(2,3),(3,2),(2,2,2),(2,0,3)]
variants=[]
for dt in ['bool','int16','int64','float32','float64','U2']:
 for shape in shapes:
  a,src=create(shape,dt,len(variants)%6)
  variants.append((a,src))
  if a.ndim and a.size:
   variants.append((np.flip(a,0),f'np.flip({src},1)'))
  if a.ndim>=2:
   variants.append((a.swapaxes(0,1),f'np.swapaxes({src},1,2)'))

for k,(arr,src) in enumerate(variants):
 for axis in [None] + ([0,-1] if arr.ndim else []):
  ln=arr.size if axis is None else arr.shape[axis]
  # positions: NumPy's 0..N insertion boundaries vs Lua's 1..N+1
  # All but mask/array are written as one-based Lua inputs.
  tests=[('1',0), (str(ln+1),ln), ('-1',-1), ('2',1),
         ('{1}',[0]), ('{2}',[1]), ('{}',[]), ('{1,1}',[0,0]),
         (f'{{{ln+1},1}}',[ln,0]), ('{-1,-1}',[-1,-1]),
         ('np.slice()',slice(None)),('np.slice(2)',slice(1,None)),
         ('np.slice(nil,nil,-1)',slice(None,None,-1)),
         ('np.slice(1,nil,2)',slice(0,None,2)),
         ('np.array({1,1},"int16")',np.array([0,0],dtype=np.int16)),
         ('np.array({},"int16")',np.array([],dtype=np.int16))]
  if ln==0:tests=[item for item in tests if item[0] not in ('-1','{-1,-1}')]
  if ln<8:
   bits=np.array([i%2==0 for i in range(ln)],dtype=bool)
   tests.append((f'np.array({literal(bits)},{literal("bool")})',bits))
  # Insert values: a native dtype-matched scalar/1d sequence; test shaped
  # insertion sources as a separate subset to cover multidimensional rules.
  val_a=np.array(9 if arr.dtype.kind!='U' else 'ö',dtype=arr.dtype)
  val_b=np.array([7,8] if arr.dtype.kind!='U' else ['東','ö'],dtype=arr.dtype)
  values=[(val_a,literal(val_a.item())),(val_b,f'np.array({literal(val_b)},{literal(dtype(val_b))})')]
  if arr.ndim>1 and k%3==0:
   v=np.array([[7],[8],[9]],dtype=arr.dtype) if arr.dtype.kind!='U' else np.array([['A'],['B'],['ñ']],dtype=arr.dtype)
   values.append((v,f'np.array({literal(v)},{literal(dtype(v))})'))
  for t,idx in enumerate(tests):
   # Keep volume bounded, but sample every selector with multiple inputs.
   for values_arr,vsrc in (values if t%4==0 else values[:1]):
    expr='np.insert('+src+','+idx[0]+','+vsrc+(')' if axis is None else ','+(str(axis+1) if axis>=0 else str(axis))+')')
    try: expected=np.insert(arr,idx[1],values_arr,axis=axis)
    except (IndexError,ValueError,TypeError,np.exceptions.AxisError):add(expr,err=True)
    else:add(expr,expected)

lines.append(f'assert(cases=={valid+rejected});print("insert differential: {valid+rejected}/{valid+rejected} (valid {valid}, rejected {rejected})")')
out.write_text('\n'.join(lines)+'\n')
print(f'generated {valid+rejected} cases ({valid} valid, {rejected} rejected), NumPy {np.__version__}')
