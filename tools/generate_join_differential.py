#!/usr/bin/env python3
"""Freeze independent NumPy-oracle joining results as LuaRay differential tests.

Development-only: Python/NumPy is never loaded by the LuaRay shared module.
NumPy 2.5.3 upstream sources are reviewed separately; this generator uses
whatever local NumPy oracle is available (2.3.5 in the development sandbox).
"""
from __future__ import annotations
import itertools
import math
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'join_differential_generated.lua'
lines=["local np=require('luaray_core')", "local n=0", """
local function same(a,b)
  if type(b)=='table' then
    assert(type(a)=='table','expected nested list')
    for k,v in ipairs(b) do same(a[k],v) end
    assert(#a==#b,'list length')
  elseif type(b)=='number' then
    if type(a)=='userdata' then
      assert(math.abs(a.real-b)<=1e-5 and math.abs(a.imag)<=1e-5)
    else
      assert(type(a)=='number' and (a==b or (a~=a and b~=b) or
             math.abs(a-b)<=1e-5 * math.max(1,math.abs(b))),tostring(a)..' != '..tostring(b))
    end
  elseif type(b)=='userdata' then
    assert(type(a)=='userdata' and math.abs(a.real-b.real)<=1e-5 and
           math.abs(a.imag-b.imag)<=1e-5,'complex mismatch')
  elseif type(b)=='string' then
    assert(a==b,'string '..tostring(a)..' != '..b)
  elseif type(b)=='boolean' then
    assert(a==b,'boolean mismatch')
  end
end
local function check(x, dtype, shape, values)
  local actual_dtype=x.dtype:gsub('^[<>|=]','')
  assert(actual_dtype==dtype,('dtype '..tostring(x.dtype)..' != '..dtype))
  assert(x.ndim==#shape,'rank')
  for i=1,#shape do assert(x.shape[i]==shape[i], 'shape axis '..i) end
  same(x:tolist(),values)
end
"""]


def lit(x):
    if isinstance(x,np.ndarray):return lit(x.tolist())
    if isinstance(x,(list,tuple)):return '{'+','.join(lit(v) for v in x)+'}'
    if isinstance(x,(np.bool_,bool)):return 'true' if x else 'false'
    if isinstance(x,(np.integer,int)):return str(int(x))
    if isinstance(x,(np.floating,float)):
        x=float(x)
        if math.isnan(x):return '(0/0)'
        if math.isinf(x):return '(1/0)' if x>0 else '(-1/0)'
        return repr(x)
    if isinstance(x,(np.complexfloating,complex)):
        return f'np.complex({lit(x.real)},{lit(x.imag)})'
    if isinstance(x,(bytes,bytearray)):return lit(x.decode('latin1'))
    if isinstance(x,str):
        return '"'+x.replace('\\','\\\\').replace('"','\\"').replace('\n','\\n')+'"'
    raise ValueError(type(x))


def typename(dtype):
    dtype=np.dtype(dtype)
    if dtype.kind in ('U','S'):return f'{dtype.kind}{dtype.itemsize//4 if dtype.kind=="U" else dtype.itemsize}'
    return dtype.name


def expr(values, dtype, shape=None, transform=None):
    # Explicit reshape from a flat sequence makes zero-dimensional and empty
    # shapes unambiguous to Lua array construction.
    flat=np.array(values).reshape(-1).tolist()
    src=f'np.array({lit(flat)},{lit(dtype)})'
    if shape is not None:src=f'np.reshape({src},{lit(list(shape))})'
    if transform=='T':src=f'({src}).T'
    if transform=='reverse':src=f'({src}):get(np.slice(nil,nil,-1))'
    return src


count=0
def emit(label, exprs, py_arrays, operation, axis, options=None, expects_failure=None):
    global count
    count+=1
    opts=options or {}
    py_kwargs={}
    if axis is False:
        py_kwargs['axis']=None
        lua_axis='false'
    else:
        py_kwargs['axis']=(axis-1) if axis>0 else axis
        lua_axis=str(axis)
    if 'dtype' in opts:py_kwargs['dtype']=opts['dtype']
    if 'casting' in opts:py_kwargs['casting']=opts['casting']
    # 'out' is synthesized as a fresh array for each individual test.
    if 'out' in opts:
        try:
            probe=getattr(np,operation)(py_arrays,**py_kwargs)
            py_out=np.zeros(probe.shape,dtype=opts['out'])
            py_kwargs['out']=py_out
        except (ValueError,TypeError):
            py_out=np.zeros((1,),dtype=opts['out'])
            py_kwargs['out']=py_out
    try:
        result=getattr(np,operation)(py_arrays,**py_kwargs)
        expected_failure=False
    except (ValueError,TypeError):
        result=None
        expected_failure=True
    if expects_failure is not None:assert expected_failure==expects_failure,label
    lines.append(f'-- case {count}: {label}')
    lines.append('do')
    for i,e in enumerate(exprs):lines.append(f' local a{i+1}={e}')
    join_args='{'+','.join(f'a{i+1}' for i in range(len(exprs)))+'}'
    lua_opts={k:v for k,v in opts.items() if k!='out'}
    opt_fields=[f'{k}={lit(v)}' for k,v in lua_opts.items()]
    if 'out' in opts:
        lines.append(f' local dst=np.zeros({lit(list(py_out.shape))},{lit(opts["out"])})')
        opt_fields.append('out=dst')
    args=f'{join_args},{lua_axis}'
    if opt_fields:args+=',{' + ','.join(opt_fields)+'}'
    code=f'np.{operation}({args})'
    if expected_failure:
        lines.append(f' local ok=pcall(function()return {code} end)')
        lines.append(' assert(not ok,"expected oracle rejection")')
    else:
        lines.append(f' local got={code}')
        if 'out' in opts: lines.append(' assert(got==dst,"must return supplied out")')
        lines.append(f' check(got,{lit(typename(result.dtype))},{lit(list(result.shape))},{lit(result)})')
    lines.append(' n=n+1')
    lines.append('end')

values_by_dtype={
    'bool':[False,True,True,False,True,False],
    'int8':[-2,1,3,4,5,-1], 'uint8':[0,1,3,4,5,6],
    'int16':[-2,1,3,4,5,-1], 'int32':[-2,1,3,4,5,-1],
    'int64':[-2,1,3,4,5,-1], 'float16':[-2.5,1,3,4.5,5,-1],
    'float32':[-2.5,1,3,4.5,5,-1], 'float64':[-2.5,1,3,4.5,5,-1],
    'complex64':[-2,1,3,4,5,-1], 'complex128':[-2,1,3,4,5,-1]
}

pairs=[('int8','int16'),('int32','float64'),('float16','float32'),
       ('bool','int8'),('uint8','int8'),('float64','complex64'),
       ('complex64','complex128'),('int64','uint8'),('float16','int64'),
       ('float32','int8'),('uint8','uint8')]
for first,second in pairs:
    for shape in [(3,), (2,3), (1,2,3)]:
        total=math.prod(shape)
        xs=np.array(values_by_dtype[first][:total],dtype=first).reshape(shape)
        ys=np.array(values_by_dtype[second][:total],dtype=second).reshape(shape)
        ex=[expr(values_by_dtype[first][:total],first,shape),expr(values_by_dtype[second][:total],second,shape)]
        axes=[1,-1,False] if len(shape)>1 else [1,False]
        for axis in axes:
            emit(f'{first}+{second} concat shape={shape}, axis={axis}',ex,[xs,ys],'concatenate',axis)
        for axis in [1,len(shape)+1,-1]:
            emit(f'{first}+{second} stack shape={shape}, axis={axis}',ex,[xs,ys],'stack',axis)
    # Explicit casting checks (accepted and rejected according to upstream).
    xs=np.array(values_by_dtype[first][:3],dtype=first)
    ys=np.array(values_by_dtype[second][:3],dtype=second)
    ex=[expr(values_by_dtype[first][:3],first,(3,)),expr(values_by_dtype[second][:3],second,(3,))]
    for casting in ('no','equiv','safe','same_kind','unsafe'):
        emit(f'{first}+{second} dtype float32 casting={casting}',ex,[xs,ys],
             'concatenate',1,{'dtype':'float32','casting':casting})
    for outtype in ('float64','int8'):
        for casting in ('same_kind','unsafe'):
            emit(f'{first}+{second} out={outtype} casting={casting}',ex,[xs,ys],
                 'concatenate',1,{'out':outtype,'casting':casting})

# Source views: transposes, negative strides, multiple inputs and empty arrays.
for dtype in ('int8','float32','complex128','U2','S2'):
    original=['ab','cd','é','fg','hi','jk'] if dtype=='U2' else (
             ['ab','cd','ef','gh','ij','kl'] if dtype=='S2' else [1,2,3,4,5,6])
    x=np.array(original,dtype=dtype).reshape(2,3)
    y=np.array(original,dtype=dtype).reshape(2,3).T
    xexpr=expr(original,dtype,(2,3)); yexpr=expr(original,dtype,(2,3),'T')
    for operation,ax in (('concatenate',1),('concatenate',2),('stack',1),('stack',-1)):
        emit(f'{dtype} regular matrices {operation} {ax}',[xexpr,xexpr],[x,x],operation,ax)
    for operation,ax in (('concatenate',1),('concatenate',2),('stack',2)):
        emit(f'{dtype} transpose {operation} {ax}',[yexpr,yexpr],[y,y],operation,ax)
    emit(f'{dtype} transpose with flatten',[xexpr,yexpr],[x,y],'concatenate',False)
    if dtype in ('S2','U2'):continue
    rev=x[::-1,:]; revexpr=f'({xexpr}):get(np.slice(nil,nil,-1),np.slice(nil,nil,1))'
    for operation,ax in (('concatenate',1),('concatenate',2),('stack',-1)):
        emit(f'{dtype} reverse {operation} {ax}',[revexpr,xexpr],[rev,x],operation,ax)
    zero=np.empty((0,3),dtype=dtype)
    emit(f'{dtype} empty join',[expr([],dtype,(0,3)),xexpr],[zero,x],'concatenate',1)

# Explicit widths and concrete temporal descriptor promotion.
for dtype_a,dtype_b,vals_a,vals_b in [
    ('S1','S4',['a','b'],['test','zoo']),
    ('U1','U4',['α','β'],['東京','аб']),
    ('S2','U3',['ab','cd'],['猫','わ']),
]:
    a=np.array(vals_a,dtype=dtype_a);b=np.array(vals_b,dtype=dtype_b)
    e=[expr(vals_a,dtype_a,(2,)),expr(vals_b,dtype_b,(2,))]
    emit(f'{dtype_a} + {dtype_b} concatenate',e,[a,b],'concatenate',1)
    emit(f'{dtype_a} + {dtype_b} stack',e,[a,b],'stack',1)

for dtype in ('int8','float64'):
    a=np.array(9,dtype=dtype);b=np.array(5,dtype=dtype)
    e=[expr([9],dtype,()),expr([5],dtype,())]
    emit('scalar stack '+dtype,e,[a,b],'stack',1)
    emit('scalar concat none '+dtype,e,[a,b],'concatenate',False)
    emit('scalar concat axis rejected '+dtype,e,[a,b],'concatenate',1)

# Explicit shape incompatibilities rejected by the oracle.
for a_shape,b_shape,axis,op in [
    ((2,3),(4,2),1,'concatenate'),
    ((2,3),(3,3),2,'concatenate'),
    ((2,3),(3,3),1,'stack'),
    ((2,3),(3,),1,'stack'),
    ((2,3),(3,),1,'concatenate'),
]:
    a=np.arange(math.prod(a_shape),dtype='int32').reshape(a_shape)
    b=np.arange(math.prod(b_shape),dtype='int32').reshape(b_shape)
    emit('shape error', [expr(a.ravel().tolist(),'int32',a_shape),expr(b.ravel().tolist(),'int32',b_shape)],
         [a,b],op,axis)

lines.append("print(('join differential: %d/%d'):format(n,n))")
OUT.write_text('\n'.join(lines)+'\n')
print('Wrote',OUT,'with',count,'cases (NumPy',np.__version__,')')
