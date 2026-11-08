#!/usr/bin/env python3
"""Development-only NumPy oracle for LuaRay extended unary math tranche."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'extended_math_differential_generated.lua'
rng=random.Random(0x1400BEEF)
lines=["local np=require('luaray_core')", r'''
local function fsame(a,b,tol)
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==0 and b==0 then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function zsame(a,b,tol)
  return type(a)=='userdata' and type(b)=='userdata' and
         fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
end
local function list_same(a,b,tol,complex)
  if #a~=#b then return false end
  for i=1,#a do
    if complex then
      if not zsame(a[i],b[i],tol) then return false end
    else
      if not fsame(a[i],b[i],tol) then return false end
    end
  end
  return true
end''', f"-- Generated against development NumPy {np.__version__}."]

def fatom(x):
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    if x==0 and math.copysign(1,x)<0: return '-0.0'
    return repr(x)

def catom(z):
    z=complex(z); return f"np.complex({fatom(z.real)},{fatom(z.imag)})"

def table(vals, complex_=False):
    fn=catom if complex_ else fatom
    return '{'+','.join(fn(v) for v in vals)+'}'

def dname(dt):
    n=np.dtype(dt).name
    if n in ('longdouble','float128'): return 'longdouble'
    if n in ('clongdouble','complex256'): return 'complex256'
    return n

def tol(dt):
    dt=np.dtype(dt)
    if dt in (np.dtype('float16'),): return 4e-3
    if dt in (np.dtype('float32'),np.dtype('complex64')): return 5e-5
    return 4e-12

ops=[('sinh',np.sinh),('cosh',np.cosh),('tanh',np.tanh),
     ('exp2',np.exp2),('log2',np.log2),('log10',np.log10),
     ('expm1',np.expm1),('log1p',np.log1p),('cbrt',np.cbrt)]
real_dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.int32,np.int64,
             np.float16,np.float32,np.float64,np.longdouble]
base=[-8,-3,-1.5,-1,-0.0,0.0,1e-4,0.25,0.75,1,2,5,8]
count=0
for dt in real_dtypes:
    for opname,fn in ops:
        vals=base[:]
        if np.dtype(dt).kind in 'biu':
            vals=[-3,-1,0,1,2,5] if np.dtype(dt).kind!='u' else [0,1,2,5,8]
        a=np.array(vals,dtype=dt)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); e=fn(a)
        lines += ["do",f" local a=np.array({table(a.tolist())},np.{dname(dt)})",f" local r=np.{opname}(a)",
                  f" assert(r.dtype=='{dname(e.dtype)}','ext math dtype {count}')",
                  f" assert(list_same(r:tolist(),{table(e.tolist())},{tol(e.dtype)},false),'ext math {opname} {count}')","end"]
        count+=1

# More randomized real batches and out/where, including strided transpose.
for dt in [np.float16,np.float32,np.float64]:
    for opname,fn in ops:
        for rep in range(4):
            vals=[rng.uniform(-4,4) for _ in range(12)]
            a=np.array(vals,dtype=dt).reshape(3,4).T
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore'); e=fn(a)
            flat=a.T.ravel().tolist() # build C table then transpose in Lua
            lines += ["do",f" local a=np.reshape(np.array({table(flat)},np.{dname(dt)}),{{3,4}}).T",f" local r=np.{opname}(a)",
                      f" assert(r.dtype=='{dname(e.dtype)}','ext strided dtype {count}')",
                      f" assert(list_same(r:tolist()[1],{table(e.tolist()[0])},{tol(e.dtype)},false),'ext strided row {count}')","end"]
            count+=1

# Complex funcs.inc + NumPy-derived hyperbolic kernels. cbrt intentionally has no complex loop.
complex_ops=[('sinh',np.sinh),('cosh',np.cosh),('tanh',np.tanh),
             ('exp2',np.exp2),('log2',np.log2),('log10',np.log10),
             ('expm1',np.expm1),('log1p',np.log1p)]
finite=[complex(r,i) for r in [-5,-2,-1,-0.0,0,0.25,1,3,5] for i in [-3,-1,-0.0,0,0.5,2,3]]
edges=[0j,complex(-0.0,0),complex(0,-0.0),complex(float('inf'),0),
       complex(float('-inf'),0),complex(0,float('inf')),complex(float('nan'),0),
       complex(1,float('nan')),complex(float('nan'),2)]
for dt in [np.complex64,np.complex128]:
    for opname,fn in complex_ops:
        batches=[edges]
        for _ in range(8): batches.append([rng.choice(finite) for _ in range(9)])
        for vals in batches:
            a=np.array(vals,dtype=dt)
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore'); e=fn(a)
            lines += ["do",f" local a=np.array({table(a.tolist(),True)},np.{dname(dt)})",f" local r=np.{opname}(a)",
                      f" assert(r.dtype=='{dname(e.dtype)}','ext complex dtype {count}')",
                      f" assert(list_same(r:tolist(),{table(e.tolist(),True)},{tol(e.dtype)*3},true),'ext complex {opname} {count}')","end"]
            count+=1

# out/where must preserve masked slots and cast through the normal ufunc executor.
a=np.array([-1.0,0.25,2.0,4.0],dtype=np.float32)
mask=np.array([False,True,False,True])
for opname,fn in [('exp2',np.exp2),('sinh',np.sinh),('log1p',np.log1p)]:
    out=np.array([9.0,8.0,7.0,6.0],dtype=np.float64)
    with np.errstate(all='ignore'): fn(a,out=out,where=mask)
    lines += ["do",f" local a=np.array({table(a.tolist())},np.float32)"," local m=np.array({false,true,false,true},np.bool)",
              " local o=np.array({9,8,7,6},np.float64)",f" np.{opname}(a,{{out=o,where=m}})",
              f" assert(list_same(o:tolist(),{table(out.tolist())},5e-5,false),'ext out where {count}')","end"]
    count+=1

# Complex cbrt is intentionally unsupported, exactly as NumPy's ufunc loop table.
lines += [r'''do
 local a=np.array({np.complex(1,1)},np.complex128)
 local ok=pcall(function() np.cbrt(a) end)
 assert(not ok,'complex cbrt must be rejected')
end''']
count+=1

lines.append(f"print('extended math differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
