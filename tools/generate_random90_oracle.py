#!/usr/bin/env python3
"""Differential PCG64 oracle for transposed/Fortran inputs and wide integer boundaries.

Run against NumPy; regenerate deterministically from the execution environment.
"""
from pathlib import Path
import numpy as np
ROOT = Path(__file__).resolve().parents[1]
def lua(x):
    if isinstance(x,(bool,np.bool_)):return 'true' if x else 'false'
    if isinstance(x,(int,np.integer)):return 'math.mininteger' if int(x)==-(2**63) else str(int(x))
    if isinstance(x,(float,np.floating)):return repr(float(x))
    if isinstance(x,np.ndarray):return lua(x.tolist())
    if isinstance(x,(list,tuple)):return '{'+','.join(map(lua,x))+'}'
    raise TypeError(type(x))

def arg(a,kind):
    if kind=='T':
        orig=a.T
        return f'np.transpose(np.array({lua(orig)},"int64"))',a
    if kind=='TF':
        orig=a.T
        return f'np.flip(np.transpose(np.array({lua(orig)},"int64")),{a.ndim})',np.flip(a,axis=-1)
    if kind=='F':
        orig=a.T
        return f'np.transpose(np.array({lua(orig)},"int64"))',a
    if kind=='C':
        return f'np.array({lua(a)},"int64")',a
    if kind=='table':return lua(a),a.tolist()
    raise ValueError(kind)

head='''-- Executed NumPy oracle for transposed/Fortran order and 64-bit integer ranges.
local np=require('luaray_core')
assert(np._version=='0.91.0-dev')
local passed=0
local failures=0
local function eq(a,b)
 if type(a)~=type(b) then return false end
 if type(a)=='table' then
  if #a~=#b then return false end
  for i=1,#a do if not eq(a[i],b[i]) then return false end end
  return true
 end
 return a==b
end
local function check(v,dtype,shape,expect,tail,r,case)
 local ok=true
 if #shape==0 and type(v)~='userdata' then ok=eq(v,expect)
 else
  ok=type(v)=='userdata' and v.dtype==dtype and eq(v.shape,shape) and eq(v:tolist(),expect)
 end
 if not ok or r:raw_hex()~=tail then
  failures=failures+1
  if failures<=8 then
   print('FAIL '..case..' values='..tostring(ok)..' pcg='..tostring(r:raw_hex()==tail))
  end
 else passed=passed+1 end
end
'''
lines=[head]; count=0
# Wide variety of shapes including non-square, singleton and 3D; test layouts
base_shapes=[(2,3),(3,2),(2,2),(1,4),(4,1),(2,3,2),(2,2,3)]
for shape in base_shapes:
    n=int(np.prod(shape)); lo=np.arange(n,dtype=np.int64).reshape(shape)%(7 if n>5 else 3)
    hi=lo+np.arange(n,dtype=np.int64).reshape(shape)%13+4
    for lowkind,hikind in [('T','T'),('T','C'),('C','T'),('TF','C'),('C','TF'),('T','table'),('table','T')]:
        lowexpr,low=arg(lo,lowkind)
        hiexpr,high=arg(hi,hikind)
        for dtype in ('int8','uint8','int16','uint16','int32','uint32','int64','uint64','bool'):
            # numpy bool supports only [0,1] or [0,2) ; vary both endpoints
            if dtype=='bool':
                curlo=np.zeros(shape,dtype=np.int64)
                curhi=np.ones(shape,dtype=np.int64)
                lowexpr,low=arg(curlo,lowkind)
                hiexpr,high=arg(curhi,hikind)
            else:
                lowexpr,low=arg(lo,lowkind)
                hiexpr,high=arg(hi,hikind)
            for sizek in ('none','explicit','zero'):
                size=None if sizek=='none' else (2,)+shape if sizek=='explicit' else (0,)+shape
                for endpoint in (False,True):
                    for seed in (42,890089):
                        rng=np.random.default_rng(seed)
                        try: result=rng.integers(low,high,size=size,dtype=dtype,endpoint=endpoint)
                        except (ValueError,TypeError,OverflowError):continue
                        tail=f'{int(rng.bit_generator.random_raw()):016x}'
                        expr=f'{lowexpr},{hiexpr},'+('nil' if size is None else lua(size))+f',"{dtype}",'+lua(endpoint)
                        lines.append(f'do local r=np.random.default_rng({seed});local v=r:integers({expr});check(v,"{dtype}",{lua(np.shape(result))},{lua(np.asarray(result).tolist())},"{tail}",r,{count+1}) end\n')
                        count+=1
# include 64-bit extremes with ndarray bounds (not convertible to float exactly)
wide=[
  ([-2**63,-2**63+1],[-2**63+1,2**63-1], 'int64'),
  ([2**63-10000,2**63-9999],[2**63-5,2**63-1], 'int64'),
  ([-2**62,2**62],[-2**62+100,2**62+1000], 'int64'),
  ([2**53+1,2**53+7],[2**53+2000,2**53+5000], 'int64'),
  ([0,2**62],[2**63-1,2**63-1], 'uint64'),
]
for lower,upper,dtype_in in wide:
 for dtype in ('int64','uint64'):
  for endpoint in (False,True):
   for seed in (0,42,999):
    for arrayshape in ('flat','column','transpose'):
     la=np.array(lower,dtype=dtype_in);ha=np.array(upper,dtype=dtype_in)
     le=f'np.array({lua(la)},"{dtype_in}")';he=f'np.array({lua(ha)},"{dtype_in}")'
     if arrayshape=='column':
      la=la.reshape((2,1));ha=ha.reshape((2,1))
      le=f'np.array({lua(la)},"{dtype_in}")';he=f'np.array({lua(ha)},"{dtype_in}")'
     elif arrayshape=='transpose':
      la=la.reshape((2,1)).T;ha=ha.reshape((2,1)).T
      le=f'np.transpose(np.array({lua(la.T)},"{dtype_in}"))';he=f'np.transpose(np.array({lua(ha.T)},"{dtype_in}"))'
     r=np.random.default_rng(seed)
     try:out=r.integers(la,ha,dtype=dtype,endpoint=endpoint)
     except (ValueError,OverflowError,TypeError):continue
     tail=f'{int(r.bit_generator.random_raw()):016x}'
     lines.append(f'do local r=np.random.default_rng({seed});local v=r:integers({le},{he},nil,"{dtype}",{lua(endpoint)});check(v,"{dtype}",{lua(np.shape(out))},{lua(np.asarray(out).tolist())},"{tail}",r,{count+1}) end\n')
     count+=1
# Large *Lua integer table* parameters: these must not be routed through
# float64 ndarray conversion, which loses low-order bits beyond 2**53.
large_pairs=[
 ([2**53+1,2**53+7,2**53+15],[2**53+2,2**53+17,2**53+100]),
 ([-2**53-123,-2**53-5,-2**53-1],[-2**53-120,-2**53+77,-2**53+13]),
 ([2**63-1001,2**63-999,2**63-500],[2**63-1,2**63-10,2**63-1]),
 ([-2**63,-2**63+1,-2**63+500],[-2**63+9,-2**63+999,-2**63+600]),
 ([0,2**53+1,2**62+13],[2**63-1,2**53+3,2**63-1]),
]
for low,high in large_pairs:
 for struct in ('plain','column','rows'):
  if struct=='plain':la,ha=low,high
  elif struct=='column':la,ha=[[x] for x in low],[[x] for x in high]
  else:la,ha=[low,low[::-1]],[high,high[::-1]]
  for dtype in ('int64','uint64'):
   if dtype=='uint64' and np.any(np.array(low,dtype=object)<0):continue
   for seed in (0,42,890089):
    for endpoint in (False,True):
     for size in (None,(2,)+np.shape(la),(0,)+np.shape(la)):
      rng=np.random.default_rng(seed)
      try:result=rng.integers(la,ha,size=size,dtype=dtype,endpoint=endpoint)
      except (ValueError,TypeError,OverflowError):continue
      tail=f'{int(rng.bit_generator.random_raw()):016x}'
      expr=f'{lua(la)},{lua(ha)},'+('nil' if size is None else lua(size))+f',"{dtype}",'+lua(endpoint)
      lines.append(f'do local r=np.random.default_rng({seed});local v=r:integers({expr});check(v,"{dtype}",{lua(np.shape(result))},{lua(np.asarray(result).tolist())},"{tail}",r,{count+1}) end\n')
      count+=1
# The high-only case also uses integer tables, including full int64 widths.
for upper in ([2**53+1,2**53+101], [2**63-1,2**63-200]):
 for seed in (0,42,890089):
  for dtype in ('int64','uint64'):
   rng=np.random.default_rng(seed);result=rng.integers(upper,dtype=dtype)
   tail=f'{int(rng.bit_generator.random_raw()):016x}'
   lines.append(f'do local r=np.random.default_rng({seed});local v=r:integers({lua(upper)},nil,nil,"{dtype}");check(v,"{dtype}",{lua(np.shape(result))},{lua(np.asarray(result).tolist())},"{tail}",r,{count+1}) end\n')
   count+=1
lines.append(f"print('random90 oracle: '..passed..' passed, '..failures..' failed, {count} total');assert(failures==0,'random90 mismatches')\n")
p=ROOT/'tests/random90_differential_generated.lua';p.write_text(''.join(lines))
print('NumPy '+np.__version__+': generated '+str(count)+' cases ('+str(p.stat().st_size)+' bytes)')
