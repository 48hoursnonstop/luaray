#!/usr/bin/env python3
"""Development-only differential oracle for LuaRay's native NumPy float16 port."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'half_differential_generated.lua'
rng=random.Random(0xF16A2026)
lines=[
 "local np=require('luaray_core')",
 r'''local function close(a,b,tol)
  tol=tol or 2e-3
  if type(a)~=type(b) then return false end
  if type(a)=='table' then
    if #a~=#b then return false end
    for i=1,#a do if not close(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)~='number' then return a==b end
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function eq(a,b)
  if type(a)~=type(b) then return false end
  if type(a)=='table' then if #a~=#b then return false end; for i=1,#a do if not eq(a[i],b[i]) then return false end end; return true end
  if type(a)=='number' and a~=a and b~=b then return true end
  return a==b
end''',
 f"-- Generated against development NumPy {np.__version__}."
]

def atom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(np.integer,int)): return str(int(x))
    f=float(x)
    if math.isnan(f): return '(0/0)'
    if math.isinf(f): return 'math.huge' if f>0 else '-math.huge'
    if f==0 and math.copysign(1,f)<0:return '-0.0'
    return repr(f)
def lt(x):
    if isinstance(x,np.ndarray):x=x.tolist()
    if isinstance(x,(list,tuple)):return '{'+','.join(lt(v) for v in x)+'}'
    return atom(x)
def sh(x):return '{'+','.join(map(str,x))+'}'
def expr(a):return f"np.array({lt(a.tolist())},np.{a.dtype.name})"
def dn(x):return np.dtype(x).name
count=0

# Construction/packing and casts, including subnormals/boundaries/signed zero.
vals=[-math.inf,-65504.0,-1024.25,-1.0009765625,-1.0,-2**-14,-2**-24,-0.0,0.0,2**-24,2**-14,1.0,1.0009765625,1024.25,65504.0,math.inf,math.nan]
a=np.array(vals,dtype=np.float16)
lines += ["do -- half construction",f" local a=np.array({lt(vals)},np.float16)"," assert(a.dtype=='float16' and a.strides[1]==2,'half dtype/layout')",f" assert(close(a:tolist(),{lt(a.tolist())},0),'half construction values')","end"]
count+=1
for src in ['bool','int8','uint8','int16','uint16','int32','float32','float64']:
    if src=='bool': sv=[False,True,True,False]
    elif src.startswith('uint'): sv=[0,1,3,17]
    elif src.startswith('int'): sv=[-17,-3,0,17]
    else: sv=[-3.25,-0.0,0.125,1.001,17.5]
    x=np.array(sv,dtype=src); e=x.astype(np.float16)
    lines += [f"do -- cast {src}->half {count}",f" local a={expr(x)}", " local h=np.array(a:tolist(),np.float16)", f" assert(close(h:tolist(),{lt(e.tolist())},0),'cast half {count}')","end"]
    count+=1

# Binary half and mixed promotion behavior.
binops=[('add',np.add),('subtract',np.subtract),('multiply',np.multiply),('true_divide',np.true_divide),('floor_divide',np.floor_divide),('remainder',np.remainder),('power',np.power),('maximum',np.maximum),('minimum',np.minimum),('fmax',np.fmax),('fmin',np.fmin),('copysign',np.copysign)]
mixd=['bool','int8','uint8','int16','uint16','float16','float32','float64']
for opname,fn in binops:
    for case in range(25):
        bdt=rng.choice(mixd)
        av=np.array([rng.choice([-3,-1,-0.0,0,0.5,1,2,4]) for _ in range(6)],dtype=np.float16)
        if bdt=='bool': bv=np.array([rng.choice([False,True]) for _ in range(6)],dtype=bdt)
        elif bdt.startswith('uint'): bv=np.array([rng.choice([0,1,2,3,4]) for _ in range(6)],dtype=bdt)
        else: bv=np.array([rng.choice([-3,-1,0,0.5,1,2,3]) for _ in range(6)],dtype=bdt)
        if opname in ('true_divide','floor_divide','remainder'):
            # Zero is meaningful upstream; retain it while ignoring warning state.
            pass
        if opname=='power':
            # Avoid complex-domain promotion and enormous outputs; half exponent may be fractional.
            av=np.abs(av); bv=np.array([rng.choice([0,1,2,3]) for _ in range(6)],dtype=bdt)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); e=fn(av,bv)
        lines += [f"do -- half {opname} {count}",f" local a={expr(av)}",f" local b={expr(bv)}",f" local r=np.{opname}(a,b)",f" assert(r.dtype=='{e.dtype.name}','half {opname} dtype {count} '..r.dtype)",f" assert(close(r:tolist(),{lt(e.tolist())},2e-3),'half {opname} values {count}')","end"]
        count+=1

# Comparisons/logicals and unary/predicates.
for opname,fn in [('equal',np.equal),('not_equal',np.not_equal),('less',np.less),('less_equal',np.less_equal),('greater',np.greater),('greater_equal',np.greater_equal),('logical_and',np.logical_and),('logical_or',np.logical_or),('logical_xor',np.logical_xor)]:
    av=np.array([-math.inf,-2,-0.0,0.0,1,math.inf,math.nan],dtype=np.float16)
    bv=np.array([-math.inf,-1,0.0,-0.0,2,math.inf,math.nan],dtype=np.float16)
    e=fn(av,bv)
    lines += [f"do local a={expr(av)}; local b={expr(bv)}; local r=np.{opname}(a,b); assert(eq(r:tolist(),{lt(e.tolist())}),'half {opname}') end"]
    count+=1
unops=[('negative',np.negative),('absolute',np.absolute),('positive',np.positive),('sign',np.sign),('logical_not',np.logical_not),('isnan',np.isnan),('isinf',np.isinf),('isfinite',np.isfinite),('signbit',np.signbit),('sqrt',np.sqrt),('exp',np.exp),('log',np.log),('sin',np.sin),('cos',np.cos),('tan',np.tan)]
uv=np.array([-math.inf,-4,-1,-0.0,0.0,0.25,1,4,math.inf,math.nan],dtype=np.float16)
for opname,fn in unops:
    uin=uv[:-1] if opname=='signbit' else uv  # NaN sign payload is not portable across Python/Lua literals.
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');e=fn(uin)
    cmp='eq' if e.dtype==np.bool_ else 'close'
    lines += [f"do local a={expr(uin)}; local r=np.{opname}(a); assert(r.dtype=='{e.dtype.name}','half {opname} dtype'); assert({cmp}(r:tolist(),{lt(e.tolist())}{',2e-3' if cmp=='close' else ''}),'half {opname}') end"]
    count+=1

# out/where for half loop and half destination.
for opname,fn in [('add',np.add),('multiply',np.multiply),('exp',np.exp),('sqrt',np.sqrt),('maximum',np.maximum)]:
    av=np.array([0.25,1,4,9],dtype=np.float16); bv=np.array([2,3,4,5],dtype=np.float16); mask=np.array([True,False,True,False])
    out=np.full(4,7,dtype=np.float16)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore')
        if opname in ('exp','sqrt'): fn(av,out=out,where=mask)
        else: fn(av,bv,out=out,where=mask)
    call=f"np.{opname}(a,{{out=o,where=m}})" if opname in ('exp','sqrt') else f"np.{opname}(a,b,{{out=o,where=m}})"
    lines += ["do",f" local a={expr(av)}",f" local b={expr(bv)}",f" local m={expr(mask)}"," local o=np.ones({4},np.float16)*7",f" local r={call}"," assert(r==o,'half out identity')",f" assert(close(o:tolist(),{lt(out.tolist())},2e-3),'half outwhere {opname}')","end"]
    count+=1

# Reductions, accumulate, axis behavior.
for case in range(80):
    shape=rng.choice([(7,),(2,5),(2,3,4)])
    av=np.array([rng.choice([-2,-1,-0.5,0,0.25,1,2,3]) for _ in range(math.prod(shape))],dtype=np.float16).reshape(shape)
    axis=rng.randrange(len(shape))
    for opname,fn in [('sum',np.sum),('prod',np.prod),('mean',np.mean)]:
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore');e=fn(av,axis=axis)
        axis_l=axis+1
        if np.ndim(e)==0:
            lines += [f"do local a={expr(av)}; local r=np.{opname}(a,{axis_l}); assert(close(r,{atom(e.item())},2e-3),'half {opname} scalar {count}') end"]
        else:
            lines += [f"do local a={expr(av)}; local r=np.{opname}(a,{axis_l}); assert(r.dtype=='{e.dtype.name}','half {opname} dtype'); assert(close(r:tolist(),{lt(e.tolist())},2e-3),'half {opname} {count}') end"]
        count+=1
# pairwise stress specifically > block size
av=np.array(([0.1]*10000)+([1.0]*17),dtype=np.float16)
e=np.sum(av)
lines += [f"do local a=np.ones({{10017}},np.float16); for i=1,10000 do a[i]=0.1 end; assert(close(np.sum(a),{atom(e.item())},0),'half pairwise sum') end"]
count+=1
# accumulate
av=np.array([0.5,1.25,-0.75,2.0,0.125],dtype=np.float16);e=np.add.accumulate(av)
lines += [f"do local a={expr(av)}; local r=np.add_accumulate(a); assert(r.dtype=='float16' and close(r:tolist(),{lt(e.tolist())},0),'half accumulate') end"]
count+=1

# dot/matmul exact half accumulator path.
for case in range(60):
    m,n,p=[rng.randint(1,4) for _ in range(3)]
    a=np.array([rng.choice([-2,-1,-0.5,0,0.5,1,2]) for _ in range(m*n)],dtype=np.float16).reshape(m,n)
    b=np.array([rng.choice([-2,-1,-0.5,0,0.5,1,2]) for _ in range(n*p)],dtype=np.float16).reshape(n,p)
    e=np.matmul(a,b)
    lines += [f"do local a={expr(a)}; local b={expr(b)}; local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{lt(e.tolist())},0),'half matmul {count}') end"]
    count+=1
for case in range(25):
    n=rng.randint(1,16);a=np.array([rng.choice([-2,-1,-0.5,0,0.5,1,2]) for _ in range(n)],dtype=np.float16);b=np.array([rng.choice([-2,-1,-0.5,0,0.5,1,2]) for _ in range(n)],dtype=np.float16);e=np.dot(a,b)
    lines += [f"do local a={expr(a)}; local b={expr(b)}; assert(close(np.dot(a,b),{atom(e.item())},0),'half dot {count}') end"]
    count+=1

# Sorting/argsort and searchsorted.
for case in range(50):
    av=np.array([rng.choice([-4,-2,-1,-0.0,0.0,0.5,1,2,4]) for _ in range(12)],dtype=np.float16)
    if case%7==0: av[3]=np.nan
    e=np.sort(av); idx=np.argsort(av)+1
    lines += [f"do local a={expr(av)}; local r=np.sort(a); assert(close(r:tolist(),{lt(e.tolist())},0),'half sort {count}'); local q=np.argsort(a); assert(eq(q:tolist(),{lt(idx.tolist())}),'half argsort {count}') end"]
    count+=1
for case in range(40):
    av=np.sort(np.array([rng.choice([-5,-3,-1,-0.0,0.0,0.5,1,2,4,8]) for _ in range(14)],dtype=np.float16))
    keys=np.array([rng.choice([-6,-2,-0.0,0.0,0.75,3,9]) for _ in range(5)],dtype=np.float16)
    side=rng.choice(['left','right']);e=np.searchsorted(av,keys,side=side)+1
    lines += [f"do local a={expr(av)}; local k={expr(keys)}; local r=np.searchsorted(a,k,'{side}'); assert(eq(r:tolist(),{lt(e.tolist())}),'half searchsorted {count}') end"]
    count+=1

lines.append(f"print('float16 differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
