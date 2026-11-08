#!/usr/bin/env python3
"""Frozen randomized binomial/negative-binomial oracle from installed NumPy.
NumPy is required ONLY to regenerate tests, never to execute LuaRay.
"""
from pathlib import Path
import numpy as np
root=Path(__file__).resolve().parents[1]

def lit(x):
    if isinstance(x,(np.integer,int)) and not isinstance(x,bool):return str(int(x))
    if isinstance(x,(np.floating,float)):return repr(float(x))
    if isinstance(x,(list,tuple,np.ndarray)):return '{'+','.join(lit(t) for t in x)+'}'
    raise TypeError(type(x))

class P:
    def __init__(self,e,v):self.e,self.v=e,v

def A(value, dtype='float64', trans=False, flip=False):
    v=np.array(value,dtype=dtype)
    e=f'np.array({lit(value)},"{dtype}")'
    if trans:v=v.T;e=f'np.transpose({e})'
    if flip:v=np.flip(v,axis=-1);e=f'np.flip({e},{v.ndim})'
    return P(e,v)

def S(value):return P(lit(value),value)

bino=[
 (A([0,1,2,10,100,1000],'int64'),S(.4)),
 (A([[0],[1],[10],[50]],'int64'),A([[0.,.01,.5,.99,1.]])),
 (A([[4,9,13],[20,30,50]],'int64',flip=True),S(.3)),
 (S(100),A([0.,.1,.5,.9,1.],dtype='float32')),
 (A([[10,20],[30,40]],'int64',trans=True),S(.12)),
 (A([3,13,25],'int64'),A([.15,.5,.95])),
 (A([4,100,1000,100000],'int64'),A([.05,.75,.5,.001])),
 (A([[100,5],[50,25]],'int64'),A([[.2,.99],[.75,.33]],flip=True)),
 (S(1000000000000),A([.00000001,.0001,.5,.9999,1.])),
 (A(6,'int64'),A(.23)),
 (S(30),S(.5)),
 (S(0),A([0.,.4,1.])),
 (A([0,1,2,3,4],'int64'),A([1.,1.,1.,1.,1.])),
]
neg=[
 (A([.1,.5,1.,2.5,5.,20.]),S(.5)),
 (A([[.1],[.5],[1.2],[20.]]),A([[.01,.1,.5,.95,1.]])),
 (A([[1.3,2.8],[3.5,8.5]],flip=True),S(.4)),
 (S(10.),A([.001,.01,.1,.5,1.],dtype='float32')),
 (A([[3.,20.],[30.,40.]],'float32',trans=True),S(.12)),
 (A([.1,1.2,3.7]),A([.9,.5,.2])),
 (A([4,10,100,1000],'int64'),A([.95,.75,.5,.1])),
 (A([[10,5],[50,25]],'int64'),A([[.2,.99],[.75,.33]],flip=True)),
 (S(1000.),A([.01,.05,.5,.999,1.])),
 (A(6.),A(.23)),
 (S(30.),S(.5)),
 (A([.5,1.,2.,4.]),A([1.,1.,1.,1.])),
]
SEEDS=[0,1,2,3,4,5,42,1234,840084,2**31-1]
header='''-- Frozen independent NumPy 2.3.5 random84 reference
local np=require('luaray_core')
assert(np._version=='0.87.0-dev')
local cases=0
local function eq(a,b)
 if type(a)~=type(b) then return false end
 if type(a)=='table' then
  if #a~=#b then return false end
  for i=1,#a do if not eq(a[i],b[i]) then return false end end
  return true
 end
 return a==b
end
local function check(x,shape,expected,tail,r)
 cases=cases+1
 if #shape==0 then assert(type(x)=='number' and x==expected,('case %d scalar'):format(cases))
 else
  assert(type(x)=='userdata',('case %d ndarray'):format(cases))
  assert(x.dtype=='int64',('case %d dtype'):format(cases))
  assert(eq(x.shape,shape),('case %d shape'):format(cases))
  assert(eq(x:tolist(),expected),('case %d values'):format(cases))
 end
 assert(r:raw_hex()==tail,('case %d PCG64'):format(cases))
end
'''
lines=[header];cases=0
for seed in SEEDS:
 for kind,pairs in [('binomial',bino),('negative_binomial',neg)]:
  for a,b in pairs:
   shape=np.broadcast_shapes(np.shape(a.v),np.shape(b.v))
   for size in [None,(2,)+shape,(0,)+shape]:
    rng=np.random.default_rng(seed)
    val=getattr(rng,kind)(a.v,b.v,size=size)
    raw=f'{int(rng.bit_generator.random_raw()):016x}'
    ar=np.asarray(val)
    expr=f'{a.e},{b.e}'+((', '+lit(size)) if size is not None else '')
    lines.append(f'do local r=np.random.default_rng({seed});local x=r:{kind}({expr});check(x,{lit(ar.shape)},{lit(ar.tolist())},"{raw}",r) end\n')
    cases+=1
lines.append(f"print('random84 NumPy differential: '..cases..'/{cases} passed')\n")
(root/'tests/random84_differential_generated.lua').write_text(''.join(lines))
print('Generated',cases,'cases from NumPy',np.__version__)
