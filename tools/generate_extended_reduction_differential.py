#!/usr/bin/env python3
"""Development-only differential oracle for extended sum/prod/mean options."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'extended_reduction_differential_generated.lua'
rng=random.Random(0xA11CE55)
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']
reduce_dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']
out_dtypes=['int8','int16','int32','int64','float16','float32','float64']

lines=[
 'local np=require("luaray_core")',
 'local function close(a,b)',
 '  if type(a)~=type(b) then return false end',
 '  if type(a)~="table" then',
 '    if type(a)=="number" then',
 '      if a~=a and b~=b then return true end',
 '      if a==b then return true end',
 '      return math.abs(a-b)<=math.max(2e-5,math.abs(b)*8e-6)',
 '    end',
 '    return a==b',
 '  end',
 '  if #a~=#b then return false end',
 '  for i=1,#a do if not close(a[i],b[i]) then return false end end',
 '  return true',
 'end',
 f'-- Generated against development NumPy {np.__version__}.',
]

def ls(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(float,np.floating)):
        f=float(x)
        if math.isnan(f): return '0/0'
        if math.isinf(f): return 'math.huge' if f>0 else '-math.huge'
        return repr(f)
    return str(int(x))

def lt(x):
    if isinstance(x,(list,tuple)): return '{'+','.join(lt(v) for v in x)+'}'
    return ls(x)

def dn(dt):
    n=np.dtype(dt).name
    return 'longdouble' if n in ('float96','float128') else n

def nested(flat,shape):
    if not shape: return flat[0]
    if len(shape)==1: return list(flat)
    step=math.prod(shape[1:])
    return [nested(flat[i*step:(i+1)*step],shape[1:]) for i in range(shape[0])]

def make_values(shape,dt,case):
    n=math.prod(shape)
    if dt=='bool':
        vals=[((i*3+case)%5)!=0 for i in range(n)]
    elif dt.startswith('float'):
        vals=[((i%7)-3)*0.5 + (case%3)*0.125 for i in range(n)]
    elif dt.startswith('uint'):
        vals=[(i*3+case)%7 for i in range(n)]
    else:
        vals=[((i*5+case)%11)-5 for i in range(n)]
    return vals

def make_array(shape,dt,case,transpose=False):
    vals=make_values(shape,dt,case)
    arr=np.array(vals,dtype=dt).reshape(shape)
    if transpose and len(shape)>1:
        arr=arr.T
        shape=list(arr.shape)
        vals=arr.ravel(order='C').tolist()
        # Lua expression builds the original C array then transposes, so return
        # separate expression below rather than the post-transpose flat values.
    if math.prod(shape)==0:
        expr=f'np.zeros({lt(shape)},np.{dt})'
    else:
        # Caller may replace for transpose case.
        expr=f'np.array({lt(nested(make_values(shape,dt,case),shape))},np.{dt})'
    return arr,expr

def mask_expr(mask):
    if mask.ndim==0:
        return 'true' if bool(mask) else 'false'
    if mask.size==0:
        return f'np.zeros({lt(list(mask.shape))},np.bool)'
    return f'np.array({lt(mask.tolist())},np.bool)'

def axis_lua(axis):
    if axis is None: return 'nil'
    if isinstance(axis,tuple): return lt([a+1 if a>=0 else a for a in axis])
    return str(axis+1 if axis>=0 else axis)

count=0
for case in range(320):
    nd=rng.randint(1,4)
    shape=[rng.randint(0,4) for _ in range(nd)]
    dt=rng.choice(dtypes)
    transpose=(rng.random()<0.12 and nd>1 and all(x>0 for x in shape))
    base_vals=make_values(shape,dt,case)
    if math.prod(shape)==0:
        a=np.zeros(shape,dtype=dt)
        aexpr=f'np.zeros({lt(shape)},np.{dt})'
    else:
        base=np.array(base_vals,dtype=dt).reshape(shape)
        baseexpr=f'np.array({lt(nested(base_vals,shape))},np.{dt})'
        if transpose:
            a=base.T
            aexpr=f'({baseexpr}).T'
        else:
            a=base
            aexpr=baseexpr
    nd=a.ndim

    op=rng.choice(['sum','prod','mean'])
    axis_mode=rng.randrange(4)
    if axis_mode==0:
        axis=None
    elif axis_mode==1:
        axis=rng.randrange(nd)
    elif axis_mode==2:
        picks=sorted(rng.sample(range(nd),rng.randrange(nd+1)))
        axis=tuple(picks)
    else:
        # Exercise negative-axis normalization, single or tuple.
        if rng.random()<0.5:
            axis=-rng.randint(1,nd)
        else:
            picks=sorted(rng.sample(range(nd),rng.randrange(nd+1)))
            axis=tuple((x-nd) if rng.random()<0.5 else x for x in picks)
    keepdims=rng.random()<0.45
    dtype_override=None
    if rng.random()<0.28:
        dtype_override=rng.choice(reduce_dtypes)

    where_kind=rng.randrange(5)
    where=True
    wexpr='true'
    if where_kind==1:
        where=False; wexpr='false'
    elif where_kind in (2,3,4):
        if where_kind==2:
            wshape=a.shape
        elif where_kind==3:
            wshape=(a.shape[-1],)
        else:
            # Leading singleton dimensions plus last dim.
            wshape=(1,)*(nd-1)+(a.shape[-1],)
        if math.prod(wshape)==0:
            where=np.zeros(wshape,dtype=bool)
        else:
            mvals=[((i+case)%3)!=0 for i in range(math.prod(wshape))]
            where=np.array(mvals,dtype=bool).reshape(wshape)
        wexpr=mask_expr(where)

    # NaN->integer conversion for an empty mean is implementation/SIMD-path
    # dependent inside NumPy itself.  Keep that non-portable warning-path quirk
    # out of the differential corpus; empty/masked means are still tested in
    # the default inexact dtype.
    maybe_empty_mean = (op=='mean' and (a.size==0 or where is False or isinstance(where,np.ndarray)))
    if maybe_empty_mean and dtype_override is not None and not dtype_override.startswith('float'):
        dtype_override='float32'

    initial_marker=False
    initial=None
    if op!='mean' and rng.random()<0.28:
        initial_marker=True
        init_choices=[-2,-1,0,1,2,3,1.5]
        if (dtype_override is not None and dtype_override.startswith('uint')) or (dtype_override is None and dt.startswith('uint')):
            init_choices=[0,1,2,3,1.5]
        initial=rng.choice(init_choices)

    out_dtype=None
    out_arr=None
    kwargs={'axis':axis,'keepdims':keepdims,'where':where}
    if dtype_override is not None: kwargs['dtype']=np.dtype(dtype_override)
    if initial_marker: kwargs['initial']=initial
    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        with np.errstate(all='ignore'):
            # Determine natural output shape before optionally creating out.
            natural=getattr(np,op)(a,**kwargs)
            if rng.random()<0.24:
                out_dtype=rng.choice(['float32','float64'] if maybe_empty_mean else out_dtypes)
                out_shape=np.shape(natural)
                out_arr=np.zeros(out_shape,dtype=out_dtype)
                kwargs['out']=out_arr
                expected=getattr(np,op)(a,**kwargs)
            else:
                expected=natural

    fields=[f'axis={axis_lua(axis)}',f'keepdims={"true" if keepdims else "false"}',f'where={wexpr}']
    if dtype_override is not None: fields.append(f'dtype=np.{dtype_override}')
    if initial_marker: fields.append(f'initial={ls(initial)}')
    lines.append(f'do -- extended reduction {case}: {op} {dt} shape={list(a.shape)} axis={axis}')
    lines.append(f'  local a={aexpr}')
    if out_arr is not None:
        lines.append(f'  local o=np.zeros({lt(list(out_arr.shape))},np.{out_dtype})')
        fields.append('out=o')
    lines.append(f'  local r=np.{op}(a,{{{",".join(fields)}}})')
    if out_arr is not None:
        lines.append(f'  assert(r==o,"ext reduction {case} out identity")')
        lines.append(f'  assert(r.dtype=="{dn(expected.dtype)}","ext reduction {case} out dtype "..r.dtype)')
        lines.append(f'  assert(close(r:tolist(),{lt(expected.tolist())}),"ext reduction {case} out values")')
    elif isinstance(expected,np.ndarray):
        lines.append(f'  assert(r.dtype=="{dn(expected.dtype)}","ext reduction {case} dtype "..r.dtype)')
        lines.append(f'  assert(close(r.shape,{lt(list(expected.shape))}),"ext reduction {case} shape")')
        lines.append(f'  assert(close(r.strides,{lt(list(expected.strides))}),"ext reduction {case} strides")')
        lines.append(f'  assert(close(r:tolist(),{lt(expected.tolist())}),"ext reduction {case} values")')
    else:
        lines.append(f'  assert(close(r,{ls(expected)}),"ext reduction {case} scalar")')
    lines.append('end')
    count+=1

# Explicit invariants taken from upstream reduction tests / reduction.c semantics.
lines += [
 'do local a=np.reshape(np.arange(6),{2,3}); local r=np.sum(a,{}); assert(close(r:tolist(),a:tolist()),"axis empty tuple copy") end',
 'do local a=np.reshape(np.arange(6),{2,3}); local r=np.sum(a,{axis={},initial=10}); assert(close(r:tolist(),{{10,11,12},{13,14,15}}),"axis empty initial") end',
 'do local a=np.reshape(np.arange(12),{4,3}); local o=np.zeros({1,3},np.float64); local r=np.sum(a,{axis=1,keepdims=true,out=o}); assert(r==o and close(o:tolist(),{{18,22,26}}),"keepdims out exact shape") end',
 'do local a=np.array({100,100},np.int8); local o=np.zeros({},np.int8); np.sum(a,{out=o}); assert(o:tolist()==-56,"out dtype seeds sum accumulator") end',
 'do local a=np.array({1.8,2.8},np.float64); local o=np.zeros({},np.int32); np.mean(a,{out=o}); assert(o:tolist()==2,"mean out does not seed accumulator") end',
]
count += 5
lines.append(f"print('extended reduction differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
