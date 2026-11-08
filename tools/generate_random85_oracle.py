#!/usr/bin/env python3
"""Generate frozen, independently executed NumPy 2.3.5 noncentral distribution cases.
NumPy is only used to regenerate the fixture, never during LuaRay runtime.
"""
from pathlib import Path
import numpy as np
root=Path(__file__).resolve().parents[1]

def lit(x):
    if isinstance(x,(np.integer,int)) and not isinstance(x,bool):return str(int(x))
    if isinstance(x,(float,np.floating)):
        f=float(x)
        return repr(f)
    if isinstance(x,(list,tuple,np.ndarray)):
        return '{'+','.join(lit(z) for z in x)+'}'
    raise TypeError(type(x))
class P:
    def __init__(self,e,v):self.e,self.v=e,v
def A(values,dtype='float64',view=None):
    v=np.array(values,dtype=dtype)
    e=f'np.array({lit(values)},"{dtype}")'
    if view=='flip':v=np.flip(v,axis=-1);e=f'np.flip({e},{v.ndim})'
    if view=='transpose':v=v.T;e=f'np.transpose({e})'
    return P(e,v)
def S(x):return P(lit(x),x)
chi=[
 (A([[.25],[.99],[1.],[4.5]]),A([[0.,.01,1.,25.]])),
 (A([.125,.5,1.,5.,100.]),S(0.)),
 (S(2.),A([0.,.1,1.,20.,100.])),
 (A([[.1,1.,3.],[5.,10.,50.]],view='flip'),S(4.)),
 (A([[.25,2.],[1.,4.]],dtype='float32',view='transpose'),A([[.1,2.],[3.,10.]])),
 (A(.75),A(1.)),
 (A([.01,.125,.5,1.,1.1,2.,4.]),A([0.,.1,1.,5.,20.,30.,100.])),
 (S(7.),S(0.)),
 (A([1.,2.,3.,4.],dtype='int64'),S(.5)),
 (A([[1.,2.,4.],[6.,10.,20.]],view='transpose'),A([[.1,1.],[2.,20.],[30.,100.]])),
 (A([1e-4,1.,10.,1000.]),A([.01,1.,10.,1000.])),
 (S(.5),S(22.)),
]
f_cases=[
 (A([[.25],[1.],[2.5]]),A([[2.,5.,20.]]),S(3.)),
 (A([[.5],[1.],[2.]]),S(6.),A([[0.,.1,1.,20.]])),
 (S(5.),A([3.,5.,10.,100.]),A([0.,.01,1.,100.])),
 (A([.5,1.,2.,5.,20.]),S(5.),S(1.)),
 (S(3.),S(8.),A([0.,.25,2.,20.,100.])),
 (A([[2.,4.],[10.,100.]],view='flip'),A([[3.,4.],[5.,6.]],dtype='float32'),S(4.)),
 (A([[1.,2.],[3.,5.]],view='transpose'),S(10.),A([[.1,1.],[2.,10.]])),
 (A(1.),A(5.),A(2.)),
 (A([1.,2.,3.,4.],'int64'),S(10.),A([0.,1.,10.,100.])),
 (S(5.),S(5.),S(0.)),
 (S(.5),S(3.),S(22.)),
 (A([.25,1.,2.,4.,10.]),A([2.,4.,6.,8.,10.]),A([0.,1.,2.,3.,4.])),
]
seeds=[0,1,2,3,42,1234,850085,2**31-1,2**32-1]
header='''-- Frozen NumPy 2.3.5 independent reference for noncentral vectorization
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
  return a==b or math.abs(a-b)<=2e-12*math.max(1,math.abs(a),math.abs(b))
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
lines=[header];count=0
for seed in seeds:
 for kind,items in [('noncentral_chisquare',chi),('noncentral_f',f_cases)]:
  for params in items:
   shp=np.broadcast_shapes(*(np.shape(p.v) for p in params))
   for size in [None,(2,)+shp,(0,)+shp]:
    r=np.random.default_rng(seed)
    with np.errstate(all='ignore'): y=getattr(r,kind)(*(p.v for p in params),size=size)
    tail=f'{int(r.bit_generator.random_raw()):016x}'
    ar=np.asarray(y)
    arg=','.join(p.e for p in params)
    if size is not None: arg+=','+lit(size)
    lines.append(f'do local r=np.random.default_rng({seed}); local x=r:{kind}({arg}); check(x,{lit(ar.shape)},{lit(ar.tolist())},"{tail}",r) end\n')
    count+=1
lines.append(f"print('random85 NumPy differential: '..count..'/'..count..' passed')\n")
(root/'tests/random85_differential_generated.lua').write_text(''.join(lines))
print(f'Generated {count} oracle cases from NumPy {np.__version__}')
