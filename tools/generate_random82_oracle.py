#!/usr/bin/env python3
"""Reproducible differential fixtures for LuaRay vector Wald / logseries.
Execute with NumPy 2.3.5, not during LuaRay's runtime.
"""
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]

def literal(value):
    if isinstance(value,(np.integer,int)) and not isinstance(value,bool):return str(int(value))
    if isinstance(value,(np.floating,float)):
        x=float(value)
        if np.isnan(x): return '(0/0)'
        if np.isposinf(x):return '(1/0)'
        if np.isneginf(x):return '(-1/0)'
        return repr(x)
    if isinstance(value,(list,tuple,np.ndarray)):
        return '{'+','.join(literal(x) for x in value)+'}'
    raise TypeError(type(value))

class P:
    def __init__(self,lua,value):self.lua,self.value=lua,value

def param(value,dtype='float64',operation=None):
    a=np.array(value,dtype=dtype)
    expr=f'np.array({literal(value)},"{dtype}")'
    if operation=='transpose':
        a=np.transpose(a);expr=f'np.transpose({expr})'
    elif operation=='flip':
        a=np.flip(a,axis=-1);expr=f'np.flip({expr},{a.ndim})'
    return P(expr,a)

def scalar(value):return P(literal(value),value)

wald=[
 (param([.1,1.,5.]),param([1.,.1,2.])),
 (param([[.1],[1.]]),param([[.5,2.,8.]])),
 (param([[.3,1.2],[2.,3.]],'float32'),scalar(.8)),
 (scalar(1.5),param([.3,1.,2.],'float32')),
 (param([[1.],[3.],[10.]],operation='transpose'),param([.3,1.5,9.])),
 (param([[1.2,2.1,3.2],[4.3,5.4,6.5]],operation='flip'),param([.25,1.2,3.2])),
 (param([[1,2],[3,4]],'int64'),param([[.5,2.],[1.,4.]],'float32')),
 (param([.3,1.5]),scalar(3.0)),
 (scalar(2.0),param([[.5,3.],[2.,4.]])),
 (param([[2.,4.],[1.,3.]]),param([.1,3.])),
 (param([float('inf'),2.0]),param([1.0,3.0])),
 (param([1.,2.]),param([float('inf'),1.])),
 (param([2.,3.]),param([4.,5.],'float32')),
]
logseries=[
 param([0.,.01,.5,.9]),
 param([[0.],[.25],[.85]]),
 param([[.3,.5],[.8,.95]],'float32'),
 param([[.001],[.999]],operation='transpose'),
 param([[.3,.4,.8],[.9,.2,.05]],operation='flip'),
 param([0,.3,.6,.9],dtype='float64'),
 param([0.99,0.85,0.1]),
 param([0.0,.00001,0.75]),
 param([[.01,.4,.7],[.9,.7,.4]]),
 param([[.25,.35],[.85,.9]],'float32'),
]
SEEDS=[0,1,2,42,1234,810081,4294967295]

header='''-- Reproducible NumPy 2.3.5 oracle: tools/generate_random82_oracle.py
local np=require('luaray_core')
assert(np._version=='0.82.0-dev')
local cases=0
local function close(a,b,eps)
 if type(a)~=type(b) then return false end
 if type(a)=='table' then
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i],eps) then return false end end
  return true
 end
 if type(a)=='number' then
  if a~=a then return b~=b end
  if a==b then return true end
  if a==math.huge or b==math.huge or a==-math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=eps*math.max(1,math.abs(b))
 end
 return a==b
end
local function check(x,shape,expected,dtype,tail,r,identity)
 cases=cases+1
 assert(type(x)=='userdata',('case %d: not ndarray'):format(cases))
 assert(x.dtype==dtype,('case %d: dtype'):format(cases))
 assert(close(x.shape,shape,0),('case %d: shape'):format(cases))
 assert(close(x:tolist(),expected,1e-12),('case %d: samples'):format(cases))
 assert(r:raw_hex()==tail,('case %d: PCG64'):format(cases))
end
'''
lines=[header]
count=0
for seed in SEEDS:
 for kind,patterns in [('wald',wald),('logseries',logseries)]:
  for pi,spec in enumerate(patterns):
   for size in (None,(2,)+np.broadcast_shapes(*(np.shape(p.value) for p in (spec if kind=='wald' else (spec,)))),(0,)+np.broadcast_shapes(*(np.shape(p.value) for p in (spec if kind=='wald' else (spec,))))):
    r=np.random.default_rng(seed)
    args=tuple(p.value for p in spec) if kind=='wald' else (spec.value,)
    ans=getattr(r,kind)(*args, size=size)
    tail=f'{int(r.bit_generator.random_raw()):016x}'
    arr=np.asarray(ans)
    xargs=','.join(p.lua for p in spec) if kind=='wald' else spec.lua
    if size is not None:xargs+=','+literal(size)
    lines.append(f'do local r=np.random.default_rng({seed});local x=r:{kind}({xargs});check(x,{literal(arr.shape)},{literal(arr.tolist())},"{arr.dtype}","{tail}",r) end\n')
    count+=1
lines.append(f"print('random82 NumPy differential: '..cases..'/{count} cases passed')\n")
out=ROOT/'tests/random82_differential_generated.lua'
out.write_text(''.join(lines))
print(f'{count} NumPy differential cases written to {out}')
