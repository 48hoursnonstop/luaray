#!/usr/bin/env python3
"""Golden oracle for LuaRay choice. Generated using installed real NumPy 2.3.5."""
from pathlib import Path
import numpy as np, json
r=Path(__file__).resolve().parents[1]
T=r/'tests';t=r/'tools'
assert np.__version__=='2.3.5'
def lua(v):
 if isinstance(v,np.ndarray):return lua(v.tolist())
 if isinstance(v,(list,tuple)):return '{'+','.join(lua(x) for x in v)+'}'
 if isinstance(v,(bool,np.bool_)):return 'true' if v else 'false'
 if isinstance(v,(int,np.integer)):return str(int(v))
 if isinstance(v,(float,np.floating)):return repr(float(v))
 if isinstance(v,str):return json.dumps(v,ensure_ascii=False)
 raise TypeError((v,type(v)))
prefix='''-- Oracle NumPy 2.3.5 / upstream code reference NumPy 2.5.3
local np=require('luaray_core')
assert(np._version=='0.75.0-dev')
local n=0
local function eq(a,b,id)
 assert(type(a)==type(b),id..': type '..type(a)..' vs '..type(b))
 if type(a)=='table' then
  assert(#a==#b,id..': length '..#a..' vs '..#b)
  for j=1,#a do eq(a[j],b[j],id..'['..j..']') end
 else assert(a==b,id..': '..tostring(a)..' vs '..tostring(b)) end
end
local function chk(seed,a,size,repl,p,axis,shuffle,expected,sh,dt,after,id)
 local g=np.random.default_rng(seed)
 local v=g:choice(a,size,repl,p,axis,shuffle)
 if sh~=nil then
  assert(type(v)=='userdata',id..': expected ndarray')
  eq(v.shape,sh,id..' shape')
  assert(v.dtype==dt,id..': dtype '..v.dtype..' vs '..dt)
  eq(v:tolist(),expected,id..' values')
 else eq(v,expected,id..' scalar') end
 assert(g:random()==after,id..' pcg64')
 n=n+1
end
'''
lines=[]
def put(seed,a,npa,size,replace=True,p=None,axis=1,shuffle=True,description=None):
    numaxis=axis-1 if axis>0 else axis
    try:
     r0=np.random.default_rng(seed)
     got=r0.choice(npa,size=size,replace=replace,p=p,axis=numaxis,shuffle=shuffle)
     nextval=r0.random()
    except (ValueError,TypeError,IndexError):return
    if not isinstance(got,np.ndarray):
     shape=None;dtype=None;expected=got.item() if hasattr(got,'item') else got
    else:
     shape=list(got.shape);dtype=str(got.dtype);expected=got.tolist()
    lid=description or f'{len(lines)}'
    line='chk('+','.join([lua(seed),a,lua(size) if size is not None else 'nil',lua(replace),lua(p) if p is not None else 'nil',lua(axis),lua(shuffle),lua(expected),lua(shape) if shape is not None else 'nil',lua(dtype) if dtype is not None else 'nil',lua(nextval),lua(lid)])+')'
    lines.append(line)
seeds=[0,1,42,9876,4294967297]
pops=[1,2,3,5,9,17,31,257]
sizes=[None,0,1,2,3,(2,3),(),(2,0),(1,2,2)]
for seed in seeds:
 for pop in pops:
  for size in sizes:
   for repl in (True,False):
    put(seed,str(pop),pop,size,repl)
 for pop in [3,5,9,17]:
  weights=np.array([i+1 for i in range(pop)],dtype=float);weights/=weights.sum()
  # Ensure complete enumeration of zero entries in some scenarios.
  sparse=np.zeros(pop);sparse[0]=0.2;sparse[-1]=0.8
  for probs in [weights,sparse,np.full(pop,1/pop)]:
   for size in [None,0,1,2,3,(2,2),(),(2,0)]:
    for repl in [True,False]:
     put(seed,str(pop),pop,size,repl,p=probs.tolist())
 # positional non-int ndarray and tables including axis tests
 for pop, dtype in [(3,'int32'),(4,'float64'),(5,'int64'),(6,'bool')]:
  vals=np.arange(pop,dtype=np.int64).astype(dtype)
  for size in [None,0,1,2,(2,2),()]:
   for repl in [True,False]:
    arr=f'np.astype(np.arange({pop},"int64"),"{dtype}")'
    put(seed,arr,vals,size,repl)
    if dtype=='int64':put(seed,lua(vals.tolist()),vals,size,repl)
 # multidimensional 2D and 3D with mixed axes, non-C views
 for shape in [(2,3),(3,4),(2,3,4),(3,2,2),(1,4)]:
  vals=np.arange(np.prod(shape),dtype='int64').reshape(shape)
  exp=f'np.arange({vals.size},"int64"):reshape({lua(shape)})'
  for variant in ['C','transpose','flip']:
   if variant=='transpose':
    vals2=np.transpose(vals,tuple(reversed(range(vals.ndim))))
    a=f'np.transpose({exp},{lua(tuple(reversed(range(1,vals.ndim+1))))})'
   elif variant=='flip':
    vals2=np.flip(vals,axis=0);a=f'np.flip({exp},1)'
   else:vals2=vals;a=exp
   for axis in [1,-1,vals2.ndim]:
    for size in [None,0,1,2,(2,3),()]:
     for repl in [True,False]:
      put(seed,a,vals2,size,repl,axis=axis)
 # large threshold tail-shuffle cases
 for pop in [10001,10023,12005]:
  for k in [0,1,4,12,200,600]:
   for sh in [True,False]:
    put(seed,str(pop),pop,k,False,shuffle=sh)
 # weighted array along axis
 v=np.arange(24,dtype='int32').reshape(2,3,4)
 for axis in [1,2,3]:
  pop=v.shape[axis-1]
  p=np.arange(1,pop+1,dtype=float);p/=p.sum()
  for shape in [None,1,2,(2,2),()]:
   for repl in [True,False]:
    put(seed,'np.astype(np.arange(24,"int64"):reshape({2,3,4}),"int32")',v,shape,repl,p=p.tolist(),axis=axis)
# split into small Lua chunks, local stack remains tiny
main=['-- 0.74 frozen NumPy differential oracle (source generator in tools/generate_choice74_oracle.py)']
for i in range(0,len(lines),200):
 file=f'choice74_part_{i//200+1:02}.lua'
 (T/file).write_text(prefix+'\n'.join(lines[i:i+200])+f'\nprint("choice74 differential chunk {i//200+1}: "..n.." cases")\n')
 main.append(f'dofile("tests/{file}")')
main.append(f'print("choice74: {len(lines)} NumPy cases passed")')
(T/'choice74_differential_generated.lua').write_text('\n'.join(main)+'\n')
print(len(lines),'cases',len(main)-2,'chunks')
