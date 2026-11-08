#!/usr/bin/env python3
"""Focused development-only oracle for buffered mixed-DType ufunc execution."""
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "tests" / "mixed_ufunc_differential_generated.lua"

lines = [
    'local np=require("luaray_core")',
    'local function close(a,b)',
    '  if a~=a and b~=b then return true end',
    '  if a==b then return true end',
    '  return math.abs(a-b)<=math.max(1e-6,math.abs(b)*2e-7)',
    'end',
    f'-- Generated against development NumPy {np.__version__}.',
]

def dtype_name(dt):
    n=np.dtype(dt).name
    return 'longdouble' if n in ('float96','float128') else n

def emit(name, lua_a, lua_b, a, b, op, probes):
    with np.errstate(all='ignore'):
        r = np.add(a,b) if op == 'add' else np.multiply(a,b)
    sym='+' if op=='add' else '*'
    lines.append(f'do -- {name}')
    lines.append(f'  local a={lua_a}')
    lines.append(f'  local b={lua_b}')
    lines.append(f'  local r=a {sym} b')
    lines.append(f'  assert(r.dtype=="{dtype_name(r.dtype)}","{name} dtype "..r.dtype)')
    lines.append('  assert(r.size==' + str(r.size) + ',"' + name + ' size")')
    for p in probes:
        v=r[p]
        lua_idx=','.join(str(i+1) for i in p)
        ev=float(v) if np.issubdtype(r.dtype,np.floating) else int(v)
        if np.issubdtype(r.dtype,np.floating):
            lines.append(f'  assert(close(r:get({lua_idx}),{ev!r}),"{name} probe {p}")')
        else:
            lines.append(f'  assert(r:get({lua_idx})=={ev},"{name} probe {p}")')
    lines.append('end')

# Both inputs require conversion to the promoted float64 loop; crosses 8192.
a=np.arange(10000,dtype=np.int64)
b=np.arange(10000,dtype=np.uint64)
emit('both-buffered-10000', 'np.arange(10000,np.int64)', 'np.arange(10000,np.uint64)',
     a,b,'add',[(0,),(8191,),(8192,),(9999,)])

# Mismatched input is reversed: negative transfer stride across the chunk boundary.
a=np.arange(10000,dtype=np.int32)[::-1]
b=np.arange(10000,dtype=np.float64)
emit('negative-stride-buffer', 'np.arange(10000,np.int32):get(np.slice(nil,nil,-1))',
     'np.arange(10000,np.float64)', a,b,'add',[(0,),(8191,),(8192,),(9999,)])

# Non-contiguous inner stride produced by transpose; int16 is transferred to float32.
a=np.arange(20000,dtype=np.int16).reshape(10000,2).T
b=np.arange(20000,dtype=np.float32).reshape(2,10000)
emit('transposed-transfer', 'np.reshape(np.arange(20000,np.int16),{10000,2}).T',
     'np.reshape(np.arange(20000,np.float32),{2,10000})', a,b,'add',
     [(0,0),(0,8191),(0,8192),(1,9999)])

# Broadcasted scalar-like inner stride 0 must fill the cast buffer correctly.
a=np.array([[3],[7]],dtype=np.int16)
b=np.arange(20000,dtype=np.float32).reshape(2,10000)
emit('broadcast-zero-stride', 'np.array({{3},{7}},np.int16)',
     'np.reshape(np.arange(20000,np.float32),{2,10000})', a,b,'multiply',
     [(0,0),(0,8192),(1,8191),(1,9999)])

# 3-D broadcast plus chunk boundary on the inner dimension.
a=np.arange(18000,dtype=np.int32).reshape(2,1,9000)
b=np.arange(27000,dtype=np.float64).reshape(1,3,9000)
emit('3d-broadcast-buffer', 'np.reshape(np.arange(18000,np.int32),{2,1,9000})',
     'np.reshape(np.arange(27000,np.float64),{1,3,9000})', a,b,'add',
     [(0,0,0),(0,2,8191),(0,2,8192),(1,1,8999)])

lines.append("print('mixed ufunc buffered differential: 5 cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(OUT)
