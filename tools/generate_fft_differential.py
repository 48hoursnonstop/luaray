#!/usr/bin/env python3
"""Development-only NumPy oracle for LuaRay's first native PocketFFT tranche."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'fft_differential_generated.lua'
rng=random.Random(0xF17F700D)
lines=["local np=require('luaray_core')", r'''
local function fsame(a,b,tol)
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==0 and b==0 then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function vsame(a,b,tol,complex)
  if complex then
    return type(a)=='userdata' and type(b)=='userdata' and
           fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
  end
  return fsame(a,b,tol)
end
local function check(r,dtype,shape,strides,vals,tol,complex,label)
  assert(r.dtype==dtype,label..' dtype '..r.dtype..' ~= '..dtype)
  assert(r.ndim==#shape,label..' ndim')
  for i=1,#shape do
    assert(r.shape[i]==shape[i],label..' shape '..i)
    assert(r.strides[i]==strides[i],label..' stride '..i..' '..r.strides[i]..' ~= '..strides[i])
  end
  local n=1 for i=1,#shape do n=n*shape[i] end
  assert(#vals==n,label..' value count')
  local idx={}
  for k=0,n-1 do
    local rem=k
    for d=#shape,1,-1 do idx[d]=(rem%shape[d])+1; rem=math.floor(rem/shape[d]) end
    local got=r:get(table.unpack(idx))
    assert(vsame(got,vals[k+1],tol,complex),label..' value '..(k+1))
  end
end
''', f"-- Generated against development NumPy {np.__version__}."]

def dname(dt):
    n=np.dtype(dt).name
    if n in ('float128','longdouble'): return 'longdouble'
    if n in ('complex256','clongdouble'): return 'complex256'
    return n

def fatom(x):
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    if x==0 and math.copysign(1,x)<0: return '-0.0'
    return repr(x)

def atom(x, complex_=False, bool_=False):
    if bool_: return 'true' if bool(x) else 'false'
    if complex_:
        z=complex(x); return f"np.complex({fatom(z.real)},{fatom(z.imag)})"
    return fatom(x)

def table(vals, complex_=False, bool_=False):
    return '{'+','.join(atom(v,complex_,bool_) for v in vals)+'}'

def itable(vals): return '{'+','.join(str(int(v)) for v in vals)+'}'

def tol_for(dt):
    dt=np.dtype(dt)
    if dt==np.dtype('float16'): return 8e-3
    if dt in (np.dtype('float32'),np.dtype('complex64')): return 8e-5
    return 1e-11

def make_values(dtype, n):
    dt=np.dtype(dtype)
    if dt.kind=='b': return np.array([(i%3)!=0 for i in range(n)],dtype=dt)
    if dt.kind=='u': return np.array([(i*3+1)%7 for i in range(n)],dtype=dt)
    if dt.kind=='i': return np.array([((i*5+2)%9)-4 for i in range(n)],dtype=dt)
    if dt.kind=='f': return np.array([math.sin(i*0.73)+0.17*i-0.4 for i in range(n)],dtype=dt)
    return np.array([complex(math.sin(i*.61)+.13*i, math.cos(i*.47)-.09*i) for i in range(n)],dtype=dt)

def lua_base_expr(base, dtype):
    dt=np.dtype(dtype); vals=base.ravel(order='C').tolist()
    return f"np.reshape(np.array({table(vals,dt.kind=='c',dt.kind=='b')},np.{dname(dt)}),{itable(base.shape)})"

def layout_case(dtype, shape, layout):
    base=make_values(dtype,int(np.prod(shape))).reshape(shape)
    expr=lua_base_expr(base,dtype)
    a=base
    if layout=='T':
        a=base.T; expr=f"({expr}).T"
    elif layout=='rev':
        a=base[...,::-1]
        slices=','.join(['np.slice(nil,nil,1)']*(base.ndim-1)+['np.slice(nil,nil,-1)'])
        expr=f"({expr}):get({slices})"
    elif layout=='step':
        if base.ndim!=2: raise AssertionError
        a=base[:,::2]
        expr=f"({expr}):get(np.slice(nil,nil,1),np.slice(1,nil,2))"
    return a,expr

count=0
# Broad coverage of dtype resolution, K-order, crop/pad, axes, and norms.
fft_dtypes=[np.bool_,np.int8,np.int32,np.int64,np.float16,np.float32,np.float64,np.longdouble,np.complex64,np.complex128,np.clongdouble]
real_dtypes=[np.bool_,np.int8,np.int32,np.int64,np.float16,np.float32,np.float64,np.longdouble]
layouts=['C','T','rev','step']
for opname,func,dtypes in [('fft',np.fft.fft,fft_dtypes),('ifft',np.fft.ifft,fft_dtypes),('rfft',np.fft.rfft,real_dtypes)]:
    for dt in dtypes:
        for layout in layouts:
            shape=(3,4) if layout!='step' else (3,6)
            a,expr=layout_case(dt,shape,layout)
            for ax in [0,1]:
                # default n and one crop/pad variant spread across cases
                n=None
                if (count%3)==1: n=max(1,a.shape[ax]-1)
                elif (count%3)==2: n=a.shape[ax]+2
                norm=['backward','ortho','forward'][count%3]
                with warnings.catch_warnings(),np.errstate(all='ignore'):
                    warnings.simplefilter('ignore'); e=func(a,n=n,axis=ax,norm=norm)
                opts=[f"axis={ax+1}",f"norm='{norm}'"]
                if n is not None: opts.append(f"n={n}")
                complex_out=np.dtype(e.dtype).kind=='c'
                vals=e.ravel(order='C').tolist()
                lines += ["do",f" local a={expr}",f" local r=np.fft.{opname}(a,{{{','.join(opts)}}})",
                    f" check(r,'{dname(e.dtype)}',{itable(e.shape)},{itable(e.strides)},{table(vals,complex_out,False)},{tol_for(e.dtype)},{str(complex_out).lower()},'fft {count}')","end"]
                count+=1

# irfft has its own public dtype resolver, including float16 output.
irfft_dtypes=[np.bool_,np.int8,np.int64,np.float16,np.float32,np.float64,np.longdouble,np.complex64,np.complex128,np.clongdouble]
for dt in irfft_dtypes:
    for layout in layouts:
        shape=(3,4) if layout!='step' else (3,6)
        a,expr=layout_case(dt,shape,layout)
        for ax in [0,1]:
            default_n=2*(a.shape[ax]-1)
            n=default_n if count%2==0 else max(1,default_n+1)
            norm=['backward','ortho','forward'][count%3]
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore'); e=np.fft.irfft(a,n=n,axis=ax,norm=norm)
            opts=f"axis={ax+1},norm='{norm}',n={n}"
            vals=e.ravel(order='C').tolist(); complex_out=np.dtype(e.dtype).kind=='c'
            lines += ["do",f" local a={expr}",f" local r=np.fft.irfft(a,{{{opts}}})",
                f" check(r,'{dname(e.dtype)}',{itable(e.shape)},{itable(e.strides)},{table(vals,complex_out,False)},{tol_for(e.dtype)},{str(complex_out).lower()},'irfft {count}')","end"]
            count+=1

# Explicit out= tests, including non-contiguous/transposed outputs.
out_specs=[
    ('fft',np.fft.fft,np.float64,np.complex64),
    ('fft',np.fft.fft,np.float32,np.complex128),
    ('rfft',np.fft.rfft,np.float64,np.complex64),
    ('irfft',np.fft.irfft,np.complex128,np.float32),
    ('irfft',np.fft.irfft,np.complex64,np.complex128),
]
for opname,func,indt,outdt in out_specs:
    for transposed in [False,True]:
        base=make_values(indt,8).reshape(2,4); a=base
        expr=lua_base_expr(base,indt)
        ax=1; n=4
        nout=(n//2+1) if opname=='rfft' else n
        outshape=(2,nout)
        if transposed:
            # Allocate reversed shape then transpose to requested shape.
            out_expr=f"np.empty({itable(outshape[::-1])},np.{dname(outdt)}).T"
            out=np.empty(outshape[::-1],dtype=outdt).T
        else:
            out_expr=f"np.empty({itable(outshape)},np.{dname(outdt)})"
            out=np.empty(outshape,dtype=outdt)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); ret=func(a,n=n,axis=ax,out=out)
        vals=out.ravel(order='C').tolist(); c=np.dtype(out.dtype).kind=='c'
        lines += ["do",f" local a={expr}",f" local o={out_expr}",f" local r=np.fft.{opname}(a,{{n={n},axis=2,out=o}})",
                  " assert(r==o,'fft out identity')",
                  f" check(o,'{dname(out.dtype)}',{itable(out.shape)},{itable(out.strides)},{table(vals,c,False)},{tol_for(out.dtype)},{str(c).lower()},'fft out {count}')","end"]
        count+=1

# Public errors and boundary semantics.
lines += [r'''do
 local ok,err=pcall(function() np.fft.fft(np.array({1,2},np.float64),{n=0}) end)
 assert(not ok and tostring(err):find('Invalid number of FFT data points',1,true))
 local ok2=pcall(function() np.fft.rfft(np.array({np.complex(1,1)},np.complex128)) end)
 assert(not ok2,'rfft complex must fail')
 local ok3=pcall(function() np.fft.fft(np.array({1,2},np.float64),{norm='bad'}) end)
 assert(not ok3,'invalid norm must fail')
 local ok4=pcall(function() np.fft.fft(np.array({1,2},np.float64),{axis=0}) end)
 assert(not ok4,'Lua axis zero must fail')
 local ok5=pcall(function() np.fft.irfft(np.array({np.complex(1,0)},np.complex128)) end)
 assert(not ok5,'default irfft n=0 must fail')
end''']
count+=5

lines.append(f"print('fft differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
