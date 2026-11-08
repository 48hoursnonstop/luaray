#!/usr/bin/env python3
"""Development-only NumPy oracle for inverse trig/hyperbolic + atan2/hypot."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'inverse_math_differential_generated.lua'
rng=random.Random(0x15A51A)
lines=["local np=require('luaray_core')", r'''
local function fsame(a,b,tol,zero_sign)
  if a~=a and b~=b then return true end
  if a==0 and b==0 then
    if not zero_sign then return true end
    return (1/a)==(1/b)
  end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function zsame(a,b,tol,zero_sign)
  return type(a)=='userdata' and type(b)=='userdata' and
         fsame(a.real,b.real,tol,zero_sign) and fsame(a.imag,b.imag,tol,zero_sign)
end
local function list_same(a,b,tol,complex_,zero_sign)
  if #a~=#b then return false end
  for i=1,#a do
    if complex_ then
      if not zsame(a[i],b[i],tol,zero_sign) then return false end
    else
      if not fsame(a[i],b[i],tol,zero_sign) then return false end
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
    if dt==np.dtype('float16'): return 4e-3
    if dt in (np.dtype('float32'),np.dtype('complex64')): return 8e-5
    return 6e-12

uops=[('arcsin',np.arcsin),('arccos',np.arccos),('arctan',np.arctan),
      ('arcsinh',np.arcsinh),('arccosh',np.arccosh),('arctanh',np.arctanh)]
real_dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.int32,np.int64,
             np.float16,np.float32,np.float64,np.longdouble]
real_vals=[-math.inf,-4,-2,-1,-0.0,0.0,0.25,0.75,1,2,4,math.inf,math.nan]
count=0
for dt in real_dtypes:
    kind=np.dtype(dt).kind
    vals=real_vals
    if kind=='b': vals=[False,True]
    elif kind=='u': vals=[0,1,2,4]
    elif kind=='i': vals=[-4,-2,-1,0,1,2,4]
    for opname,fn in uops:
        a=np.array(vals,dtype=dt)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); e=fn(a)
        lines += ["do",f" local a=np.array({table(a.tolist())},np.{dname(dt)})",f" local r=np.{opname}(a)",
                  f" assert(r.dtype=='{dname(e.dtype)}','inv real dtype {count}')",
                  f" assert(list_same(r:tolist(),{table(e.tolist())},{tol(e.dtype)},false,true),'inv real {opname} {count}')","end"]
        count+=1

# Complex branch-cut and non-finite cases plus randomized finite values.
complex_edges=[
    complex(-2.0,0.0),complex(-2.0,-0.0),complex(-1.0,0.0),complex(-1.0,-0.0),
    complex(-0.0,0.0),complex(-0.0,-0.0),complex(0.0,0.0),complex(0.0,-0.0),
    complex(1.0,0.0),complex(1.0,-0.0),complex(2.0,0.0),complex(2.0,-0.0),
    complex(0.0,1.0),complex(0.0,-1.0),complex(0.0,2.0),complex(0.0,-2.0),
    complex(math.inf,0),complex(-math.inf,0),complex(0,math.inf),complex(0,-math.inf),
    complex(math.inf,math.inf),complex(-math.inf,-math.inf),
    complex(math.nan,0),complex(0,math.nan),complex(math.nan,2),complex(2,math.nan),complex(math.nan,math.nan),
]
finite=[complex(r,i) for r in [-5,-2,-1,-0.0,0,0.25,0.75,1,2,5] for i in [-3,-1,-0.0,0,0.5,1,3]]
for dt in [np.complex64,np.complex128]:
    for opname,fn in uops:
        batches=[complex_edges]
        for _ in range(10): batches.append([rng.choice(finite) for _ in range(13)])
        for vals in batches:
            a=np.array(vals,dtype=dt)
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore'); e=fn(a)
            lines += ["do",f" local a=np.array({table(a.tolist(),True)},np.{dname(dt)})",f" local r=np.{opname}(a)",
                      f" assert(r.dtype=='{dname(e.dtype)}','inv complex dtype {count}')",
                      f" assert(list_same(r:tolist(),{table(e.tolist(),True)},{tol(e.dtype)*3},true,true),'inv complex {opname} {count}')","end"]
            count+=1

# aliases are part of NumPy's public spelling surface.
lines += [r'''do
 local a=np.array({0.25},np.float64)
 assert(fsame(np.asin(a)[1],np.arcsin(a)[1],1e-15,true))
 assert(fsame(np.acos(a)[1],np.arccos(a)[1],1e-15,true))
 assert(fsame(np.atan(a)[1],np.arctan(a)[1],1e-15,true))
 assert(fsame(np.asinh(a)[1],np.arcsinh(a)[1],1e-15,true))
 assert(fsame(np.acosh(np.array({2.0},np.float64))[1],np.arccosh(np.array({2.0},np.float64))[1],1e-15,true))
 assert(fsame(np.atanh(a)[1],np.arctanh(a)[1],1e-15,true))
end''']; count+=1

# Binary arctan2/hypot: dtype resolution, broadcasting, weak scalar semantics.
bops=[('arctan2',np.arctan2),('hypot',np.hypot)]
for dt in real_dtypes:
    kind=np.dtype(dt).kind
    av=[-3,-1,-0.0,0.0,0.5,2,4]
    bv=[2,-2,1,-1,4,0.5,3]
    if kind=='b': av=[False,True]; bv=[True,False]
    elif kind=='u': av=[0,1,2,4]; bv=[1,2,4,1]
    elif kind=='i': av=[-3,-1,0,1,3]; bv=[2,-2,1,4,-1]
    for opname,fn in bops:
        a=np.array(av,dtype=dt); b=np.array(bv,dtype=dt)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); e=fn(a,b)
        lines += ["do",f" local a=np.array({table(a.tolist())},np.{dname(dt)})",f" local b=np.array({table(b.tolist())},np.{dname(dt)})",f" local r=np.{opname}(a,b)",
                  f" assert(r.dtype=='{dname(e.dtype)}','binary inv dtype {count}')",
                  f" assert(list_same(r:tolist(),{table(e.tolist())},{tol(e.dtype)},false,true),'binary inv {opname} {count}')","end"]
        count+=1

# Mixed dtype/broadcast batches.
mixes=[(np.int8,np.float32),(np.int16,np.float64),(np.float16,np.float32),(np.float32,np.float64),(np.bool_,np.int16)]
for da,db in mixes:
    for opname,fn in bops:
        a=np.array([[-3],[0],[2]],dtype=da); b=np.array([[0.5,-2,4,1]],dtype=db)
        with np.errstate(all='ignore'): e=fn(a,b)
        lines += ["do",f" local a=np.reshape(np.array({table(a.ravel().tolist())},np.{dname(da)}),{{3,1}})",f" local b=np.reshape(np.array({table(b.ravel().tolist())},np.{dname(db)}),{{1,4}})",f" local r=np.{opname}(a,b)",
                  f" assert(r.dtype=='{dname(e.dtype)}','binary broadcast dtype {count}')",
                  f" assert(list_same(r:tolist()[1],{table(e.tolist()[0])},{tol(e.dtype)},false,true),'binary broadcast {opname} {count}')","end"]
        count+=1

# weak scalars; compare dtype and values.
for dt in [np.bool_,np.int8,np.int16,np.int32,np.float16,np.float32,np.float64]:
    a=np.array([1,2],dtype=dt)
    for scalar,label in [(True,'true'),(2,'2'),(2.0,'2.0')]:
        for opname,fn in bops:
            with np.errstate(all='ignore'): e=fn(a,scalar)
            lines += ["do",f" local a=np.array({table(a.tolist())},np.{dname(dt)})",f" local r=np.{opname}(a,{label})",
                      f" assert(r.dtype=='{dname(e.dtype)}','weak binary dtype {count}')",
                      f" assert(list_same(r:tolist(),{table(e.tolist())},{tol(e.dtype)},false,true),'weak binary {opname} {count}')","end"]
            count+=1

# out/where, including unary complex and binary real paths.
a=np.array([-0.5,0.25,0.75,2.0],dtype=np.float32); mask=np.array([False,True,False,True])
for opname,fn in [('arctan',np.arctan),('arcsinh',np.arcsinh)]:
    out=np.array([9.,8.,7.,6.],dtype=np.float64)
    with np.errstate(all='ignore'): fn(a,out=out,where=mask)
    lines += ["do",f" local a=np.array({table(a.tolist())},np.float32)"," local m=np.array({false,true,false,true},np.bool)"," local o=np.array({9,8,7,6},np.float64)",f" np.{opname}(a,{{out=o,where=m}})",f" assert(list_same(o:tolist(),{table(out.tolist())},8e-5,false,true),'inv out where {count}')","end"]
    count+=1

for opname,fn in bops:
    a=np.array([3.,4.,5.,6.],dtype=np.float32); b=np.array([4.,3.,12.,8.],dtype=np.float32); out=np.array([9.,8.,7.,6.],dtype=np.float64)
    with np.errstate(all='ignore'): fn(a,b,out=out,where=mask)
    lines += ["do",f" local a=np.array({table(a.tolist())},np.float32)",f" local b=np.array({table(b.tolist())},np.float32)"," local m=np.array({false,true,false,true},np.bool)"," local o=np.array({9,8,7,6},np.float64)",f" np.{opname}(a,b,{{out=o,where=m}})",f" assert(list_same(o:tolist(),{table(out.tolist())},8e-5,false,true),'binary out where {count}')","end"]
    count+=1

# Complex arctan2/hypot must reject exactly because generate_umath has only real loops.
lines += [r'''do
 local z=np.array({np.complex(1,2)},np.complex128)
 assert(not pcall(function() np.arctan2(z,z) end),'complex arctan2 must reject')
 assert(not pcall(function() np.hypot(z,z) end),'complex hypot must reject')
end''']; count+=1

lines.append(f"print('inverse math differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
