#!/usr/bin/env python3
"""Executable NumPy 2.3.5 oracle for vectorized Generator.integers."""
from pathlib import Path
import numpy as np
ROOT=Path(__file__).resolve().parents[1]
def literal(x):
    if isinstance(x,(np.bool_,bool)):return 'true' if x else 'false'
    if isinstance(x,(int,np.integer)):return str(int(x))
    if isinstance(x,(float,np.floating)):
        if not np.isfinite(x):raise ValueError(x)
        return repr(float(x))
    if isinstance(x,np.ndarray):return literal(x.tolist())
    if isinstance(x,(list,tuple)):return '{'+','.join(map(literal,x))+'}'
    raise TypeError(type(x))
class Arg:
    def __init__(self,expr,val):self.expr,self.val=expr,val

def A(vals,dtype='int64',transform=None):
    a=np.array(vals,dtype=dtype)
    expr=f'np.array({literal(vals)},"{dtype}")'
    if transform=='flip':a=np.flip(a,axis=-1);expr=f'np.flip({expr},{a.ndim})'
    if transform=='transpose':a=a.T;expr=f'np.transpose({expr})'
    return Arg(expr,a)
def T(v):return Arg(literal(v),v)
def S(v):return Arg(literal(v),v)

common=[
  (T([1,2,3]),T([10,20,30])),
  (A([1,2,3]),A([10,20,30])),
  (A([[1],[3]]),A([[10,15,20]])),
  (T([[1],[3]]),T([[10,15,20]])),
  (S(0),A([[10,20,30],[40,50,60]])),
  (A([1,3,5],transform='flip'),S(10)),
  (A([1,2,3],dtype='int16'),T([5,9,15])),
  (A([True,False,True],dtype='bool'),A([5,6,7],dtype='int64')),
  (A([1.9,2.1,3.7],dtype='float32'),T([5.4,9.9,15.1])),
  (T([1.2,2.3]),T([5.9,9.1])),
  (A(1),A(5)),
  (A(1),S(5)),
  (S(1),A(5)),
]
special={
 'int8':[(T([-50,-10,0]),T([3,10,127]))],
 'int16':[(T([-25000,-10]),T([123,30000]))],
 'int32':[(T([-2000000000,-1]),T([100,2000000000]))],
 'int64':[(A([9007199254740993,4503599627370511],dtype='int64'),A([9007199254746999,4503599627371000],dtype='int64')),
          (A([-(2**62),-3],dtype='int64'),A([2**62,2**62-1],dtype='int64'))],
 'uint8':[(T([0,50,200]),T([5,100,256]))],
 'uint16':[(T([1,5000]),T([65536,60000]))],
 'uint32':[(T([0,1000000000]),T([2**32,2**32-1]))],
 'uint64':[(A([2**62,2**62+10],dtype='int64'),A([2**63-1000,2**63-1],dtype='int64'))],
 'bool':[(T([0,0,1]),T([1,2,2])),(A([0,1,0],dtype='int64'),S(2))],
}
header='''-- Generated from executable NumPy 2.3.5 results; do not edit directly.
local np=require('luaray_core')
assert(np._version=='0.91.0-dev')
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
local function check(v,dtype,shape,expected,tail,r)
 count=count+1
 if #shape==0 and type(v)~='userdata' then
  assert(eq(v,expected),'case '..count..' scalar')
 else
  assert(type(v)=='userdata','case '..count..' missing ndarray')
  assert(v.dtype==dtype,'case '..count..' dtype '..tostring(v.dtype))
  assert(eq(v.shape,shape),'case '..count..' shape')
  assert(eq(v:tolist(),expected),'case '..count..' values')
 end
 assert(r:raw_hex()==tail,'case '..count..' PCG64')
end
'''
lines=[header];count=0
for seed in (0,1,42,1234,4294967295,890089,987654321):
 for dtype in ('int8','uint8','int16','uint16','int32','uint32','int64','uint64','bool'):
  cases=(special.get(dtype,[]) if dtype=='bool' else common+special.get(dtype,[]))
  for low,high in cases:
   bshape=np.broadcast_shapes(np.shape(low.val),np.shape(high.val))
   for mode in (0,1,2):
    if mode==0:size=None
    elif mode==1:size=(2,)+bshape
    else:size=(0,)+bshape
    for endpoint in (False,True):
     if dtype=='bool' and endpoint and (np.asarray(high.val)==2).any():continue
     r=np.random.default_rng(seed)
     try:output=r.integers(low.val,high.val,size=size,dtype=dtype,endpoint=endpoint)
     except (ValueError,TypeError):continue
     raw=f'{int(r.bit_generator.random_raw()):016x}'
     v=np.asarray(output)
     vexp=literal(v.tolist())
     shape=literal(v.shape)
     args=low.expr+','+high.expr+','+('nil' if size is None else literal(size))+f',"{dtype}",'+literal(endpoint)
     lines.append(f'do local r=np.random.default_rng({seed}); local v=r:integers({args}); check(v,"{dtype}",{shape},{vexp},"{raw}",r) end\n')
     count+=1
# NumPy also supports the single positional (high) argument as a broadcast array.
for seed in (42,1234,890089):
 for dtype in ('int16','int32','int64','uint32'):
  high=A([[3,7,15],[4,8,12]],dtype='int64',transform='flip')
  for size in (None,(2,2,3),(0,2,3)):
   r=np.random.default_rng(seed)
   v=r.integers(high.val,size=size,dtype=dtype)
   raw=f'{int(r.bit_generator.random_raw()):016x}'
   expr=f'{high.expr},nil,'+('nil' if size is None else literal(size))+f',"{dtype}",false'
   lines.append(f'do local r=np.random.default_rng({seed});local v=r:integers({expr});check(v,"{dtype}",{literal(np.shape(v))},{literal(np.asarray(v).tolist())},"{raw}",r) end\n')
   count+=1
lines.append(f"print('random89 NumPy differential: '..count..'/{count} passed')\n")
out=ROOT/'tests/random89_differential_generated.lua'
out.write_text(''.join(lines))
print(f'NumPy {np.__version__}: generated {count} reference cases ({out.stat().st_size} bytes)')
