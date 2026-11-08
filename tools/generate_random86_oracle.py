#!/usr/bin/env python3
"""Reproducible independently executed NumPy 2.3.5 oracle for 0.86."""
from pathlib import Path
import math
import numpy as np
root=Path(__file__).resolve().parents[1]
def lit(x):
    if isinstance(x,(np.integer,int)) and not isinstance(x,bool):return str(int(x))
    if isinstance(x,(float,np.floating)):
        n=float(x)
        if math.isnan(n):return '(0/0)'
        if math.isinf(n):return 'math.huge' if n>0 else '(-math.huge)'
        return repr(n)
    if isinstance(x,(list,tuple,np.ndarray)):
        return '{'+','.join(lit(v) for v in x)+'}'
    raise TypeError(type(x))
class Arg:
    def __init__(self,e,val):self.e,self.val=e,val
def A(x,dtype='float64',view=None):
    arr=np.array(x,dtype=dtype)
    e=f'np.array({lit(x)},"{dtype}")'
    if view=='flip':arr=np.flip(arr,axis=-1);e=f'np.flip({e},{arr.ndim})'
    if view=='transpose':arr=arr.T;e=f'np.transpose({e})'
    return Arg(e,arr)
def S(x):return Arg(lit(x),float(x))
std=[
    (A([.01,.25,1.,2.,10.,100.]),),
    (A([[.01],[.5],[5.],[100.]]),),
    (A([.5,2.,30.],dtype='float32'),),
    (A([1,2,30,100],dtype='int64',view='flip'),),
    (A([[.3,.5,2],[5.,10.,20]],view='transpose'),),
    (A(1.),),(A(2.),),(S(.5),),(S(5.),),(S(1e-4),),
    (A([math.nan,math.inf,.5,2.]),),
]
vm=[
    (A([[0.],[1.],[-3.]]),A([[0.,1e-9,1e-6,1e-3,0.1,2.,100.,1e7]])),
    (A([0.,.5,-2.,20.],view='flip'),A([1.,0.,1e-5,1e6])),
    (A([[1.,2.],[3.,4.]],dtype='float32',view='transpose'),S(2.)),
    (S(0.),A([0.,1e-9,1e-6,1e-3,2.,1e6,1e8])),
    (A([0.,4.,-4.]),S(4.)),
    (S(1.),A(1.)),
    (A(2.),A(0.)),
    (S(-4.),S(0.)),
    (S(1e4),S(20.)),
    (A([math.nan,math.inf,0.,2.]),A([1.,0.,math.inf,2.])),
    (S(1.),A([math.nan,math.inf,0.,2.])),
]
tri=[
    (A([[0.],[.25],[-1.]]),A([[.5,1.,2.,3.]]),A([[3.,4.,5.,6.]])),
    (A([0.,1.,2.],view='flip'),A([1.,2.,3.],view='flip'),A([2.,4.,6.],view='flip')),
    (S(0.),A([0.,.2,.5,.8,1.]),S(1.)),
    (A([[0,1],[2,3]],dtype='int64',view='transpose'),S(4.),S(10.)),
    (A(0.),A(.5),A(1.)),
    (S(0.),S(.2),S(1.)),
    (S(-10.),S(-1.),S(0.)),
    (S(1.),S(1.),S(2.)),
    (S(-1.),S(2.),S(2.)),
    (A([math.nan,0.]),A([.5,.5]),A([1.,2.])),
    (A([0.,0.]),A([.5,1.]),A([1.,math.inf])),
]
header='''-- Independent NumPy 2.3.5 fixture (generated; no Python at runtime)
local np=require('luaray_core')
assert(np._version=='0.87.0-dev')
local count=0
local function eq(a,b)
 if type(a)~=type(b) then return false end
 if type(a)=='table' then
  if #a~=#b then return false end
  for i=1,#a do if not eq(a[i],b[i]) then return false end end
  return true
 end
 if type(a)=='number' then
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=8e-12*math.max(1,math.abs(a),math.abs(b))
 end
 return a==b
end
local function check(x,shape,expected,tail,r)
 count=count+1
 if #shape==0 then
  assert(type(x)=='number' and eq(x,expected),'case '..count..' scalar')
 else
  assert(type(x)=='userdata','case '..count..' ndarray')
  assert(x.dtype=='float64','case '..count..' dtype')
  assert(eq(x.shape,shape),'case '..count..' shape')
  assert(eq(x:tolist(),expected),'case '..count..' values')
 end
 assert(r:raw_hex()==tail,'case '..count..' PCG64')
end
'''
seeds=[0,1,2,3,42,1234,860086,2**31-1,2**32-1,987654321]
lines=[header];count=0
for seed in seeds:
    for func,cases in [('standard_t',std),('vonmises',vm),('triangular',tri)]:
        for args in cases:
            shape=np.broadcast_shapes(*(np.shape(p.val) for p in args))
            for size in [None, (2,)+shape,(0,)+shape]:
                r=np.random.default_rng(seed)
                with np.errstate(all='ignore'):
                    out=getattr(r,func)(*(p.val for p in args),size=size)
                tail=f'{int(r.bit_generator.random_raw()):016x}'
                arr=np.asarray(out)
                arg=','.join(a.e for a in args)
                if size is not None:arg+=','+lit(size)
                lines.append(f'do local r=np.random.default_rng({seed}); local x=r:{func}({arg}); check(x,{lit(arr.shape)},{lit(arr.tolist())},"{tail}",r) end\n')
                count+=1
lines.append(f"print('random86 NumPy differential: '..count..'/'..count..' passed')\n")
(root/'tests/random86_differential_generated.lua').write_text(''.join(lines))
print(f'Generated {count} oracle cases using NumPy {np.__version__}')
