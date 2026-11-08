#!/usr/bin/env python3
"""Freeze NumPy 2.x split-family results as a Python-free Lua regression suite.

Only this generator requires Python/NumPy. LuaRay's native runtime does not.
NumPy 2.5.3 source in numpy/lib/_shape_base_impl.py is the source contract;
local NumPy 2.3.5 supplies independent executable reference values.
"""
import math
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'split_differential_generated.lua'
lines=["local np=require('luaray_core')",'local n=0', '''
local function eq(a,b)
  if type(b)=='table' then
    assert(type(a)=='table','expected table')
    assert(#a==#b, 'length '..#a..' ~= '..#b)
    for i=1,#b do eq(a[i],b[i]) end
  elseif type(b)=='number' then
    assert(type(a)=='number' and (a==b or
      (a~=a and b~=b) or
      math.abs(a-b)<1e-4*math.max(1,math.abs(b))),tostring(a)..' != '..tostring(b))
  else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function check(got,shapes,values,dtype)
  assert(#got==#shapes, 'number of split parts')
  for j=1,#got do
    local g=got[j]
    assert(g.dtype==dtype,'dtype '..tostring(g.dtype)..' ~= '..dtype)
    assert(g.ndim==#shapes[j],'rank')
    for d=1,#shapes[j] do
      assert(g.shape[d]==shapes[j][d], 'part '..j..' shape axis '..d)
    end
    eq(g:tolist(),values[j])
  end
end
''']

def lit(v):
    if isinstance(v,np.ndarray):return lit(v.tolist())
    if isinstance(v,(list,tuple)):return '{'+','.join(lit(i) for i in v)+'}'
    if isinstance(v,(np.bool_,bool)):return 'true' if bool(v) else 'false'
    if isinstance(v,(np.integer,int)):return str(int(v))
    if isinstance(v,(np.floating,float)):
        if math.isnan(v):return '(0/0)'
        return repr(float(v))
    if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"')+'"'
    raise ValueError(type(v))

count=0
success=0
errors=0

def emit(operation, ar, source_expr, bounds, axis=None, as_numpy_array=False):
    global count,success,errors
    count+=1
    kw={'axis':axis} if operation in ('split','array_split') else {}
    passed=True
    try:
        result=getattr(np,operation)(ar,bounds,**kw)
    except (ValueError,TypeError,ZeroDivisionError,IndexError):
        passed=False
        result=None
    parts=lit(bounds)
    if as_numpy_array:
        parts=f'np.array({parts},"int64")'
    lua_args=f'{source_expr},{parts}'
    if axis is not None:lua_args+=f',{axis+1 if axis>=0 else axis}'
    call=f'np.{operation}({lua_args})'
    lines.append(f'-- case {count}: {operation}, shape={ar.shape}, bounds={bounds}, axis={axis}')
    if passed:
        success+=1
        shapes=[list(t.shape) for t in result]
        vals=[t.tolist() for t in result]
        dtype=result[0].dtype
        if dtype.kind=='U':dt=f'<U{dtype.itemsize//4}'
        elif dtype.kind=='S':dt=f'|S{dtype.itemsize}'
        elif dtype.kind in ('M','m'):dt=dtype.name
        else:dt=dtype.name
        # LuaRay returns names with ABI byte-order prefix for strings.
        if dtype.kind=='S':dt=f'|S{dtype.itemsize}'
        lines.append(f'check({call},{lit(shapes)},{lit(vals)},{lit(dt)})')
    else:
        errors+=1
        lines.append(f'assert(not pcall(function()return {call} end), "expected NumPy rejection {count}")')
    lines.append('n=n+1')

shapes=[(0,), (1,), (2,), (5,), (7,), (8,), (2,3), (3,4), (0,3),(3,0),(2,3,4),(2,4,3)]
for dtype in ('int32','float64','bool','U2'):
    for shape in shapes:
        n=math.prod(shape)
        if dtype=='bool': values=[bool(i%3) for i in range(n)]
        elif dtype=='U2': values=['é','東','a','b','c','d','x','µ'][0:1] if n==1 else ['é','東','a','b','c','d','x','µ']*(n//8+1)
        elif dtype=='float64':values=[i*0.5-1.5 for i in range(n)]
        else: values=[i*3-7 for i in range(n)]
        if dtype=='U2':values=values[:n]
        arr=np.array(values,dtype=dtype).reshape(shape)
        literal=lit(values)
        lua_expr=f'np.reshape(np.array({literal},{lit(dtype)}),{lit(shape)})'
        if len(shape)>1 and shape[-1]>0 and shape[0]>0 and n:
            # Include strides/non-contiguous transposed inputs.
            choices=[('',arr),('T',arr.T),('R',arr[::-1])]
        else:choices=[('',arr)]
        for transform,array in choices:
            src=lua_expr+('.T' if transform=='T' else ':get(np.slice(nil,nil,-1))' if transform=='R' else '')
            axis_options=[0,-1] if array.ndim==1 else [0,1,-1]
            for axis in axis_options:
                for sections in [1,2,3,4,7]:
                    emit('split',array,src,sections,axis)
                    emit('array_split',array,src,sections,axis)
                for cuts in [[],[0],[1],[-1],[2,4],[5,2,20],[-50,50],[-2,-2],[-3,0,3]]:
                    emit('split',array,src,cuts,axis)
                emit('array_split',array,src,[1,-1],axis)
                if array.ndim==1 and axis==0:
                    emit('split',array,src,[0,2],axis,as_numpy_array=True)
            for fun in ('hsplit','vsplit','dsplit'):
                for bounds in (1,2,3,[0,2],[-3,1,50]):
                    emit(fun,array,src,bounds)
# Failures on scalar and invalid axes.
for fun in ('split','array_split','hsplit','vsplit','dsplit'):
    expr='np.reshape(np.array({1},"int64"),{})'
    ary=np.array(1,dtype=np.int64)
    emit(fun,ary,expr,2,0 if fun in ('split','array_split') else None)
for fun in ('split','array_split'):
    ar=np.arange(5,dtype='int64')
    src='np.array({0,1,2,3,4},"int64")'
    for axis in (1,-2):emit(fun,ar,src,2,axis)
    for sections in (0,-1):emit(fun,ar,src,sections,0)
lines.append(f'assert(n=={count}); print("split differential: "..n.."/"..{count})')
OUT.write_text('\n'.join(lines)+'\n')
print('Oracle',np.__version__,'generated',count,'cases:',success,'accepted',errors,'rejected; bytes',OUT.stat().st_size)
