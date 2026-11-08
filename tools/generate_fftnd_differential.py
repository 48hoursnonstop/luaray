#!/usr/bin/env python3
"""Development-only NumPy oracle for LuaRay's n-D PocketFFT wrappers."""
from pathlib import Path
import math, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'fftnd_differential_generated.lua'
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
    assert(r.shape[i]==shape[i],label..' shape '..i..' '..r.shape[i]..' ~= '..shape[i])
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

def ax_table(axes): return '{'+','.join(str(int(a)+1 if a>=0 else int(a)) for a in axes)+'}'

def tol_for(dt):
    dt=np.dtype(dt)
    if dt==np.dtype('float16'): return 1.2e-2
    if dt in (np.dtype('float32'),np.dtype('complex64')): return 2e-4
    return 2e-11

def make_values(dtype, n):
    dt=np.dtype(dtype)
    if dt.kind=='b': return np.array([(i%3)!=0 for i in range(n)],dtype=dt)
    if dt.kind=='u': return np.array([(i*3+1)%11 for i in range(n)],dtype=dt)
    if dt.kind=='i': return np.array([((i*5+2)%13)-6 for i in range(n)],dtype=dt)
    if dt.kind=='f': return np.array([math.sin(i*.37)+math.cos(i*.19)*.3+i*.021-.5 for i in range(n)],dtype=dt)
    return np.array([complex(math.sin(i*.31)+i*.017-.2, math.cos(i*.23)-i*.013+.1) for i in range(n)],dtype=dt)

def lua_base_expr(base,dtype):
    dt=np.dtype(dtype); vals=base.ravel(order='C').tolist()
    return f"np.reshape(np.array({table(vals,dt.kind=='c',dt.kind=='b')},np.{dname(dt)}),{itable(base.shape)})"

def layout_case(dtype, layout):
    base=make_values(dtype,24).reshape(2,3,4)
    expr=lua_base_expr(base,dtype); a=base
    if layout=='T':
        a=base.T; expr=f"({expr}).T"
    elif layout=='rev':
        a=base[:,:,::-1]
        expr=f"({expr}):get(np.slice(nil,nil,1),np.slice(nil,nil,1),np.slice(nil,nil,-1))"
    return a,expr

def emit_result(expr, opname, opts, e, label):
    global count
    c=np.dtype(e.dtype).kind=='c'; vals=e.ravel(order='C').tolist()
    optstr='{' + ','.join(opts) + '}' if opts else ''
    call=f"np.fft.{opname}(a{','+optstr if optstr else ''})"
    lines.extend(["do",f" local a={expr}",f" local r={call}",
        f" check(r,'{dname(e.dtype)}',{itable(e.shape)},{itable(e.strides)},{table(vals,c,False)},{tol_for(e.dtype)},{str(c).lower()},'{label}')","end"])
    count+=1

count=0
fft_dtypes=[np.int32,np.float16,np.float32,np.float64,np.complex64,np.complex128]
layouts=['C','T','rev']
# fftn/ifftn: default-all, subset, repeated axis, and crop/pad s.
for opname,func in [('fftn',np.fft.fftn),('ifftn',np.fft.ifftn)]:
    for dt in fft_dtypes:
        for layout in layouts:
            a,expr=layout_case(dt,layout)
            configs=[
                (None,None,'backward'),
                (None,(0,2),'ortho'),
                (None,(1,1),'forward'),
                ((a.shape[0]+1,max(1,a.shape[2]-1)),(0,2),'backward'),
                ((-1,a.shape[1]+1),(2,1),'ortho'),
            ]
            for s,axes,norm in configs:
                kw={'norm':norm}
                if s is not None: kw['s']=s
                if axes is not None: kw['axes']=axes
                with warnings.catch_warnings(),np.errstate(all='ignore'):
                    warnings.simplefilter('ignore'); e=func(a,**kw)
                opts=[f"norm='{norm}'"]
                if s is not None: opts.append(f"s={itable(s)}")
                if axes is not None: opts.append(f"axes={ax_table(axes)}")
                emit_result(expr,opname,opts,e,f'{opname} {count}')

# fft2 aliases: default and custom axes/s.
for opname,func in [('fft2',np.fft.fft2),('ifft2',np.fft.ifft2)]:
    for dt in fft_dtypes:
        for layout in ['C','T']:
            a,expr=layout_case(dt,layout)
            for s,axes,norm in [(None,None,'backward'),((a.shape[0]+1,a.shape[2]),(0,2),'ortho')]:
                kw={'norm':norm}
                opts=[f"norm='{norm}'"]
                if s is not None: kw['s']=s; opts.append(f"s={itable(s)}")
                if axes is not None: kw['axes']=axes; opts.append(f"axes={ax_table(axes)}")
                with warnings.catch_warnings(),np.errstate(all='ignore'):
                    warnings.simplefilter('ignore'); e=func(a,**kw)
                emit_result(expr,opname,opts,e,f'{opname} {count}')

real_dtypes=[np.int32,np.float16,np.float32,np.float64]
# rfftn/rfft2.
for opname,func in [('rfftn',np.fft.rfftn),('rfft2',np.fft.rfft2)]:
    for dt in real_dtypes:
        for layout in ['C','T','rev']:
            a,expr=layout_case(dt,layout)
            configs=[(None,None,'backward')]
            if opname=='rfftn':
                configs += [(None,(0,2),'ortho'),((a.shape[1]+1,a.shape[0]),(1,0),'forward')]
            else:
                configs += [((a.shape[0]+1,a.shape[2]),(0,2),'ortho')]
            for s,axes,norm in configs:
                kw={'norm':norm}; opts=[f"norm='{norm}'"]
                if s is not None: kw['s']=s;opts.append(f"s={itable(s)}")
                if axes is not None: kw['axes']=axes;opts.append(f"axes={ax_table(axes)}")
                with warnings.catch_warnings(),np.errstate(all='ignore'):
                    warnings.simplefilter('ignore');e=func(a,**kw)
                emit_result(expr,opname,opts,e,f'{opname} {count}')

# irfftn/irfft2 on complex inputs, including shapeless default and explicit odd final sizes.
for opname,func in [('irfftn',np.fft.irfftn),('irfft2',np.fft.irfft2)]:
    for dt in [np.complex64,np.complex128]:
        for layout in ['C','T','rev']:
            a,expr=layout_case(dt,layout)
            configs=[(None,None,'backward')]
            if opname=='irfftn':
                configs += [(None,(0,2),'ortho'),((a.shape[1]+1,5),(1,2),'forward')]
            else:
                configs += [((a.shape[-2]+1,5),None,'ortho')]
            for s,axes,norm in configs:
                kw={'norm':norm};opts=[f"norm='{norm}'"]
                if s is not None: kw['s']=s;opts.append(f"s={itable(s)}")
                if axes is not None: kw['axes']=axes;opts.append(f"axes={ax_table(axes)}")
                with warnings.catch_warnings(),np.errstate(all='ignore'):
                    warnings.simplefilter('ignore');e=func(a,**kw)
                emit_result(expr,opname,opts,e,f'{opname} {count}')

# Explicit out= on shape-preserving n-D transforms and real transforms.
out_cases=[]
base=np.arange(24,dtype=np.float32).reshape(2,3,4)/7
out_cases.append(('fftn',np.fft.fftn,base,{'axes':(0,2),'norm':'ortho'},np.complex64))
out_cases.append(('fftn',np.fft.fftn,base,{'axes':(0,2)},np.complex128))
out_cases.append(('rfftn',np.fft.rfftn,base,{'axes':(0,2)},np.complex64))
cbase=(base+1j*(base*.2-.3)).astype(np.complex128)
out_cases.append(('irfftn',np.fft.irfftn,cbase,{'s':(2,6),'axes':(0,2)},np.float64))
for opname,func,a,kw,outdt in out_cases:
    expr=lua_base_expr(a,a.dtype)
    # compute shape first without out, then allocate output exactly
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); tmp=func(a,**kw)
    out=np.empty(tmp.shape,dtype=outdt)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); ret=func(a,out=out,**kw)
    opts=[]
    if 's' in kw:opts.append(f"s={itable(kw['s'])}")
    if 'axes' in kw:opts.append(f"axes={ax_table(kw['axes'])}")
    if 'norm' in kw:opts.append(f"norm='{kw['norm']}'")
    opts.append('out=o')
    c=out.dtype.kind=='c';vals=out.ravel(order='C').tolist()
    lines.extend(["do",f" local a={expr}",f" local o=np.empty({itable(out.shape)},np.{dname(outdt)})",
                  f" local r=np.fft.{opname}(a,{{{','.join(opts)}}})"," assert(r==o,'fftnd out identity')",
                  f" check(o,'{dname(out.dtype)}',{itable(out.shape)},{itable(out.strides)},{table(vals,c,False)},{tol_for(out.dtype)},{str(c).lower()},'fftnd out {count}')","end"])
    count+=1

# Empty transform sequence returns the original input; repeated axes and -1 are already covered above.
lines += [r'''do
 local a=np.reshape(np.arange(24,np.float64),{2,3,4})
 assert(np.fft.fftn(a,{s={}})==a,'empty fftn transform sequence must return input')
 assert(np.fft.ifftn(a,{axes={}})==a,'empty ifftn axis sequence must return input')
 local ok=pcall(function() np.fft.fftn(a,{s={2},axes={1,2}}) end)
 assert(not ok,'shape/axes length mismatch must fail')
 local ok2=pcall(function() np.fft.fft2(np.array({1,2,3},np.float64)) end)
 assert(not ok2,'fft2 on 1-D input must fail')
 local ok3=pcall(function() np.fft.fftn(a,{axes={0}}) end)
 assert(not ok3,'Lua axis zero must fail')
end''']
count += 5

lines.append(f"print('fftnd differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
