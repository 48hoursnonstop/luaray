#!/usr/bin/env python3
"""Development-only oracle for LuaRay complex elementary ufuncs."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'complex_math_differential_generated.lua'
rng=random.Random(0xC0FFEE13)
lines=["local np=require('luaray_core')", r'''
local function fsame(a,b,tol)
  if a~=a and b~=b then return true end
  if a==0 and b==0 then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function zsame(a,b,tol)
  return type(a)=='userdata' and type(b)=='userdata' and fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
end
local function list_same(a,b,tol)
  if #a~=#b then return false end
  for i=1,#a do if not zsame(a[i],b[i],tol) then return false end end
  return true
end''', f"-- Generated against development NumPy {np.__version__}."]

def fatom(x):
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    if x==0 and math.copysign(1,x)<0: return '-0.0'
    return repr(x)
def atom(z):
    z=complex(z); return f"np.complex({fatom(z.real)},{fatom(z.imag)})"
def table(vals): return '{'+','.join(atom(v) for v in vals)+'}'
def dtype_name(dt): return np.dtype(dt).name

def tol(dt): return 8e-5 if np.dtype(dt)==np.dtype('complex64') else 3e-12

count=0
finite=[complex(r,i) for r in [-8,-3,-1,-0.0,0,0.25,1,3,8] for i in [-5,-1,-0.0,0,0.5,2,5]]
edges=[
    complex(0.0,0.0), complex(-0.0,0.0), complex(0.0,-0.0), complex(-0.0,-0.0),
    complex(float('inf'),0), complex(float('-inf'),0), complex(0,float('inf')), complex(0,float('-inf')),
    complex(float('inf'),1), complex(float('-inf'),-1), complex(float('nan'),0), complex(float('nan'),2),
    complex(2,float('nan')), complex(float('nan'),float('nan')),
]
ops=[('sqrt',np.sqrt),('exp',np.exp),('log',np.log),('sin',np.sin),('cos',np.cos),('tan',np.tan)]
for dt in [np.complex64,np.complex128]:
    for opname,fn in ops:
        batches=[]
        batches.append(edges)
        for _ in range(12): batches.append([rng.choice(finite) for _ in range(11)])
        for vals in batches:
            a=np.array(vals,dtype=dt)
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore'); e=fn(a)
            lines += ["do",f" local a=np.array({table(a.tolist())},np.{dtype_name(dt)})",f" local r=np.{opname}(a)",f" assert(r.dtype=='{dtype_name(e.dtype)}','complex math dtype {count}')",f" assert(list_same(r:tolist(),{table(e.tolist())},{tol(dt)}),'complex math {opname} {count}')","end"]
            count+=1

# power: integer exponent fast path plus general complex powers and edge zeros.
power_pairs=[
 (0+0j,0+0j),(0+0j,2+0j),(0+0j,-1+0j),(1+1j,2+0j),(1+1j,-3+0j),
 (-1+0j,0.5+0j),(-1-0j,0.5+0j),(2+3j,0.25-1j),(complex(float('inf'),1),2+0j),
]
for dt in [np.complex64,np.complex128]:
    batches=[power_pairs]
    for _ in range(24):
        pairs=[]
        for j in range(9):
            a=rng.choice(finite)
            if j<4: b=complex(rng.choice([-5,-3,-2,-1,0,1,2,3,5]),0)
            else: b=rng.choice(finite)
            pairs.append((a,b))
        batches.append(pairs)
    for pairs in batches:
        aa=np.array([p[0] for p in pairs],dtype=dt); bb=np.array([p[1] for p in pairs],dtype=dt)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); e=np.power(aa,bb)
        lines += ["do",f" local a=np.array({table(aa.tolist())},np.{dtype_name(dt)})",f" local b=np.array({table(bb.tolist())},np.{dtype_name(dt)})"," local r=np.power(a,b)",f" assert(r.dtype=='{dtype_name(e.dtype)}','complex power dtype {count}')",f" assert(list_same(r:tolist(),{table(e.tolist())},{tol(dt)*4}),'complex power {count}')","end"]
        count+=1

# where must suppress problematic 0 ** negative element instead of prevalidating it.
lines += [r'''do
 local a=np.array({np.complex(0,0),np.complex(2,1)},np.complex128)
 local b=np.array({np.complex(-1,0),np.complex(2,0)},np.complex128)
 local out=np.array({np.complex(9,9),np.complex(8,8)},np.complex128)
 local m=np.array({false,true},np.bool)
 np.power(a,b,{out=out,where=m})
 assert(zsame(out[1],np.complex(9,9),1e-12))
 assert(zsame(out[2],np.complex(3,4),1e-12))
end''']
count+=1

lines.append(f"print('complex math differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
