#!/usr/bin/env python3
"""Generate frozen NumPy 2.3.5 oracle for broadcasted geometric/poisson.
Reference is executed only while producing test fixtures, not by LuaRay.
"""
from pathlib import Path
import numpy as np
ROOT=Path(__file__).resolve().parents[1]

def lit(x):
    if isinstance(x,(np.integer,int)) and not isinstance(x,bool):return str(int(x))
    if isinstance(x,(float,np.floating)):
        f=float(x)
        if np.isnan(f):return '(0/0)'
        if np.isposinf(f):return '(1/0)'
        if np.isneginf(f):return '(-1/0)'
        return repr(f)
    if isinstance(x,(list,tuple,np.ndarray)):
        return '{'+','.join(lit(t) for t in x)+'}'
    raise TypeError(type(x))

class P:
    def __init__(self,lua,value):self.lua,self.value=lua,value

def array(value,dtype='float64',view=None):
    v=np.array(value,dtype=dtype)
    expression=f'np.array({lit(value)},"{dtype}")'
    if view=='transpose':v=v.T;expression=f'np.transpose({expression})'
    if view=='flip':v=np.flip(v,axis=-1);expression=f'np.flip({expression},{v.ndim})'
    return P(expression,v)

def scalar(x):return P(lit(x),x)

geo=[
 array([0.01,.25,.5,.99]),array([[.01],[.25],[.9]]),
 array([[.1,.4],[.8,1.]],'float32'),
 array([[.1],[.33]],view='transpose'),
 array([[.1,.25,.5],[.7,.9,1.]],view='flip'),
 array([1.,.8,.4,.2],'float64'),array([1e-6,.1,1.]),
 array([[.001,.05],[.33,.75]],'float32'),
 array([.3333333333333, 1/3, .3333333333334]),
 array([[.001, .35, .99],[.001,.35,.99]],'float64'),
 array([[.95,.99,.999]],'float64'),array([[.2],[.99]],'float32'),
 array([.02,.03,.04],'float64'),array([.999999,1.]),
 array(.35),array(1.0),scalar(.42),scalar(.99),
]
pois=[
 array([0.,.1,1.,5.,10.,15.]),array([[0.],[3.],[12.]]),
 array([[.1,5.],[15.,30.]],'float32'),
 array([[0.],[10.]],view='transpose'),
 array([[.1,1.,3.],[10.,50.,100.]],view='flip'),
 array([0.,1.,9.999,10.,10.0001]),array([1e-7,1e-2,1000.]),
 array([[.01,15.],[40.,.2]],'float32'),
 array([4.,20.,200.],'int64'),array([[10.,20.,30.],[40.,50.,60.]]),
 array([[1.,3.]]),array([[.2],[2.]],'float32'),
 array([300., 1000., 10000.]),array([1e5,1e6]),
 array(7.0),array(0.),scalar(3.5),scalar(100.),
]
SEEDS=[0,1,2,3,4,5,42,1234,820082,830083,4294967295,2**31-1]
header='''-- Frozen NumPy 2.3.5 oracle; regenerate with tools/generate_random83_oracle.py
local np=require('luaray_core')
assert(np._version=='0.83.0-dev')
local cases=0
local function close(a,b)
 if type(a)~=type(b) then return false end
 if type(a)=='table' then
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i]) then return false end end
  return true
 end
 if type(a)=='number' then return a==b end
 return a==b
end
local function check(x,shape,expected,tail,r)
 cases=cases+1
 if #shape==0 then
  assert(type(x)=='number' and x==expected,('case %d scalar'):format(cases))
 else
  assert(type(x)=='userdata',('case %d ndarray'):format(cases))
  assert(x.dtype=='int64',('case %d dtype'):format(cases))
  assert(close(x.shape,shape),('case %d shape'):format(cases))
  assert(close(x:tolist(),expected),('case %d values'):format(cases))
 end
 assert(r:raw_hex()==tail,('case %d PCG64'):format(cases))
end
'''
lines=[header];cases=0
for seed in SEEDS:
    for kind, params in [('geometric',geo),('poisson',pois)]:
        for p in params:
            shape=np.shape(p.value)
            sizes=[None,(2,)+shape,(0,)+shape]
            for size in sizes:
                r=np.random.default_rng(seed)
                val=getattr(r,kind)(p.value,size=size)
                tail=f'{int(r.bit_generator.random_raw()):016x}'
                valarr=np.asarray(val)
                expr=p.lua+((','+lit(size)) if size is not None else '')
                lines.append(f'do local r=np.random.default_rng({seed});local x=r:{kind}({expr});check(x,{lit(valarr.shape)},{lit(valarr.tolist())},"{tail}",r) end\n')
                cases+=1
lines.append(f"print('random83 NumPy differential: '..cases..'/{cases} cases passed')\n")
file=ROOT/'tests/random83_differential_generated.lua'
file.write_text(''.join(lines))
print(cases,'cases',file)
