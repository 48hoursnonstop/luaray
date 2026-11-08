#!/usr/bin/env python3
"""Deterministic executable NumPy 2.3.5 reference for LuaRay 0.87."""
from pathlib import Path
import math
import numpy as np
root=Path(__file__).resolve().parents[1]
def lit(x):
    if isinstance(x,(bool,np.bool_)):return "true" if x else "false"
    if isinstance(x,(np.integer,int)) and not isinstance(x,bool):return str(int(x))
    if isinstance(x,(float,np.floating)):
        v=float(x)
        if math.isnan(v):return '(0/0)'
        if math.isinf(v):return 'math.huge' if v>0 else '(-math.huge)'
        return repr(v)
    if isinstance(x,(list,tuple,np.ndarray)):return '{'+','.join(lit(v) for v in x)+'}'
    raise TypeError(type(x))
class Arg:
    def __init__(self,expr,val):self.expr,self.val=expr,val
def A(values,dtype='float64',view=None):
    a=np.array(values,dtype=dtype);expr=f'np.array({lit(values)},"{dtype}")'
    if view=='flip':a=np.flip(a,axis=-1);expr=f'np.flip({expr},{a.ndim})'
    if view=='transpose':a=a.T;expr=f'np.transpose({expr})'
    return Arg(expr,a)
def T(values):return Arg(lit(values),values)
def S(x):return Arg(lit(x),x)
zipf=[
    (A([1.01,1.1,1.5,2.,5.,25.,1025.,math.inf]),),
    (A([[1.2],[2.],[10.]],view='flip'),),
    (A([2.,5.,25.],dtype='float32',view='flip'),),
    (A([[1.5,2.,3.],[4.,10.,25.]],view='transpose'),),
    (T([1.5,5.,1025.]),),
    (A(3.),),(S(2.5),),(S(math.inf),),
    (A([2,3,10],dtype='int64'),),
]
hyp=[
    (A([[4],[11],[100]],dtype='int64'),A([[8,5,40,100]],dtype='int64'),S(3)),
    (A([10,20,30],dtype='int64',view='flip'),S(10),A([1,5,12],dtype='int64',view='flip')),
    (A([[30,40],[100,200]],dtype='int64',view='transpose'),S(10),S(7)),
    (T([4.,5.,6.]),T([5,6,7]),T([1.,2.,3.])),
    (T([4.1,5.9,6.8]),S(10),T([2.0,3.0,4.0])),
    (T([[0],[100],[1000]]),T([[0,5,400]]),S(0)),
    (A(10,dtype='int64'),A(20,dtype='int64'),A(5,dtype='int64')),
    (S(10),S(20),S(5)),
    (S(5),S(6),A([1,2,3],dtype='int64')),
    (S(1_000_000),S(1_000_000),S(1_000_000)),
    (S(50),S(40),S(1)),
    (S(50),S(40),S(89)),
    (T([1.9,4.2,-0.2]),T([0.9,2.5,5.1]),T([1.8,2.2,1.1])),
    (A([True,False,True],dtype='bool'),S(5),S(1)),
]
header='''-- Frozen independently executed NumPy 2.3.5 reference
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
 return a==b
end
local function check(x,shape,expected,tail,r)
 count=count+1
 if #shape==0 then assert(type(x)=='number' and eq(x,expected),'case '..count..' scalar')
 else
  assert(type(x)=='userdata','case '..count..' ndarray')
  assert(x.dtype=='int64','case '..count..' dtype')
  assert(eq(x.shape,shape),'case '..count..' shape')
  assert(eq(x:tolist(),expected),'case '..count..' values')
 end
 assert(r:raw_hex()==tail,'case '..count..' PCG64')
end
'''
lines=[header];count=0
for seed in [0,1,2,3,42,1234,987654321,870087,2**31-1,2**32-1,870001,870002,870003,870004,870005,870006,870007,870008,870009,870010]:
    for name,cases in [('zipf',zipf),('hypergeometric',hyp)]:
        for args in cases:
            shape=np.broadcast_shapes(*(np.shape(v.val) for v in args))
            sizes=[None,(2,)+shape,(0,)+shape]
            for size in sizes:
                rng=np.random.default_rng(seed)
                values=[v.val for v in args]
                with np.errstate(all='ignore'):
                    out=getattr(rng,name)(*values,size=size)
                tail=f'{int(rng.bit_generator.random_raw()):016x}'
                expr=','.join(v.expr for v in args)
                if size is not None:expr+=','+lit(size)
                a=np.asarray(out)
                lines.append(f'do local r=np.random.default_rng({seed}); local x=r:{name}({expr}); check(x,{lit(a.shape)},{lit(a.tolist())},"{tail}",r) end\n')
                count+=1
lines.append(f"print('random87 NumPy differential: '..count..'/{count} passed')\n")
path=root/'tests/random87_differential_generated.lua'
path.write_text(''.join(lines))
print(f'NumPy {np.__version__}: {count} reproducible oracle calls generated')
