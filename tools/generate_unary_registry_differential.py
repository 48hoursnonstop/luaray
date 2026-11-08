#!/usr/bin/env python3
"""Differential coverage for transcendental unary ufuncs migrated in 0.23.

The uploaded NumPy main tree is the implementation source of truth.  Installed
NumPy is used only as a development oracle to materialize values/dtypes for the
same legacy numeric loops pinned from generate_umath.py.
"""
from pathlib import Path
import math, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'unary_registry_differential_generated.lua'
lines=["local np=require('luaray_core')",r'''
local function fsame(a,b,tol)
  if type(a)=='userdata' or type(b)=='userdata' then
    if type(a)~='userdata' or type(b)~='userdata' then return false end
    return fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
  end
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function same(a,b,tol)
  if type(a)~='table' or type(b)~='table' then return fsame(a,b,tol) end
  if #a~=#b then return false end
  for i=1,#a do if not same(a[i],b[i],tol) then return false end end
  return true
end
local function seqeq(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end
''',f"-- Development oracle NumPy {np.__version__}; semantics pinned to uploaded NumPy main."]

def atom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(complex,np.complexfloating)):
        return f"np.complex({atom(float(np.real(x)))},{atom(float(np.imag(x)))})"
    if isinstance(x,(np.integer,int)): return str(int(x))
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    if x==0 and math.copysign(1,x)<0:return '-0.0'
    return repr(x)

def table_obj(x):
    if isinstance(x,np.ndarray): x=x.tolist()
    if isinstance(x,(list,tuple)): return '{'+','.join(table_obj(v) for v in x)+'}'
    return atom(x)

def dname(dt):
    n=np.dtype(dt).name
    if n in ('float128','longdouble'): return 'longdouble'
    if n in ('complex256','clongdouble'): return 'complex256'
    return n

def tol(dt):
    dt=np.dtype(dt)
    if dt==np.dtype('float16'): return 8e-3
    if dt in (np.dtype('float32'),np.dtype('complex64')): return 2e-5
    if dt.kind in 'biu': return 0.0
    return 6e-12

ops=['sqrt','exp','log','sin','cos','tan','sinh','cosh','tanh','exp2','log2','log10','expm1','log1p','cbrt',
     'arcsin','arccos','arctan','arcsinh','arccosh','arctanh']
real_dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,np.float16,np.float32,np.float64]
complex_dtypes=[np.complex64,np.complex128]
real_vals=np.array([-2.5,-0.0,0.25,2.0])
unsigned_vals=np.array([0.0,1.0,2.0,7.0])
complex_vals=np.array([-2.0-0.0j,-0.0+0.0j,0.25+0.75j,2.0-1.5j])
count=0

for opname in ops:
    f=getattr(np,opname)
    for dt in real_dtypes:
        a=(unsigned_vals if np.dtype(dt).kind=='u' else real_vals).astype(dt)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore');r=f(a)
        lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",f" local r=np.{opname}(a)",
                  f" assert(r.dtype=='{dname(r.dtype)}','unary-reg dtype {opname} {count} '..r.dtype)",
                  f" assert(same(r:tolist(),{table_obj(r)},{tol(r.dtype)}),'unary-reg values {opname} {count}')","end"]
        count+=1
    for dt in complex_dtypes:
        a=complex_vals.astype(dt)
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore');r=f(a)
        except Exception:
            lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",
                      f" assert(not pcall(function() return np.{opname}(a) end),'unary-reg reject {opname} {count}')","end"]
            count+=1;continue
        lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",f" local r=np.{opname}(a)",
                  f" assert(r.dtype=='{dname(r.dtype)}','unary-reg cdtype {opname} {count}')",
                  f" assert(same(r:tolist(),{table_obj(r)},{tol(r.dtype)}),'unary-reg cvalues {opname} {count}')","end"]
        count+=1

# Every migrated unary must use generic out=/where= writeback.  Choose inputs
# that remain finite for all real-domain functions where practical.
mask=np.array([True,False,True,False])
safe=np.array([0.25,0.5,1.0,1.5],dtype=np.float32)
for opname in ops:
    f=getattr(np,opname)
    o0=np.array([90.,80.,70.,60.],dtype=np.float64);o=o0.copy()
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');f(safe,out=o,where=mask)
    lines += ["do",f" local a=np.array({table_obj(safe)},np.float32)",f" local m=np.array({table_obj(mask)},np.bool)",
              f" local o=np.array({table_obj(o0)},np.float64)",f" local r=np.{opname}(a,{{out=o,where=m}})",
              " assert(r==o,'unary-reg out identity')",f" assert(same(o:tolist(),{table_obj(o)},3e-5),'unary-reg out {opname} {count}')","end"]
    count+=1

# KEEPORDER for non-contiguous/transposed views through the generic iterator.
base=np.arange(24,dtype=np.float64).reshape(2,3,4)
t=base.transpose()
for opname in ('sqrt','exp','sin','arcsin','arcsinh'):
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');r=getattr(np,opname)(t)
    lines += ["do"," local v={} for i=1,24 do v[i]=i-1 end"," local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()",
              f" local r=np.{opname}(t)",f" assert(seqeq(r.strides,{table_obj(r.strides)}),'unary-reg KEEPORDER {opname} {count}')","end"]
    count+=1

# Signed-zero observability from the upstream real loops.
for opname in ('sqrt','sin','tan','sinh','tanh','expm1','log1p','cbrt','arcsin','arctan','arcsinh','arctanh'):
    f=getattr(np,opname);a=np.array([-0.0],dtype=np.float64)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');r=f(a)
    if float(r[0])==0.0 and math.copysign(1.0,float(r[0]))<0:
        lines += ["do"," local a=np.array({-0.0},np.float64)",f" local r=np.{opname}(a)",
                  f" assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero {opname} {count}')","end"]
        count+=1

# Aliases should hit the same registered canonical ufunc.
for alias,canonical in [('asin','arcsin'),('acos','arccos'),('atan','arctan'),('asinh','arcsinh'),('acosh','arccosh'),('atanh','arctanh')]:
    a=np.array([0.25,0.5],dtype=np.float64)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');r=getattr(np,canonical)(a)
    lines += ["do"," local a=np.array({0.25,0.5},np.float64)",f" local r=np.{alias}(a)",
              f" assert(same(r:tolist(),{table_obj(r)},1e-12),'unary-reg alias {alias} {count}')","end"]
    count+=1

lines.append(f"print('unary registry differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
