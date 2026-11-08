"""Regenerate the checked-in NumPy Dirichlet oracle (development only).

Requires NumPy; LuaRay's runtime and its regular test target do not.
Cases exercise both source algorithms and PCG64 state consumption.
"""
from pathlib import Path
import math
import numpy as np

root = Path(__file__).resolve().parents[1]
seeds = [0, 1, 2, 17, 42, 1234, 2**32-1, 2**63-1]
alphas = [[], [0.0], [1.0], [0.01], [0.0,0.0], [1.0,2.0],
    [1.,2.,3.], [0.01,0.02,0.03], [0.099,0.09999],
    [0.1,0.001,0.02], [0.099999,0.1], [0.0,0.01,0.02],
    [0.04,0.0,0.0], [0.01,0.0,0.04], [0.0,0.0,0.1],
    [0.0,0.0,0.0], [0.5,1.0,10.], [1e-9,2e-9,3e-9],
    [0.00001,0.2], [0.03]*8, [1.,2.,3.,4.,5.]]
sizes = [None, (), (0,), (1,), (2,3), (2,1,3)]

def lua_alpha(a): return '{' + ','.join(repr(x) for x in a) + '}'
def lua_size(v): return 'nil' if v is None else '{' + ','.join(map(str,v)) + '}'
def next_raw(r): return format(int(r.bit_generator.random_raw()), '016x')
def check_value(x):
    x=float(x)
    if math.isnan(x): return 'eqnan(v:get(%s))'
    if math.isinf(x): return f'eq(v:get(%s),{"math.huge" if x>0 else "-math.huge"})'
    return f'eq(v:get(%s),{repr(x)})'
lines = [f'-- Independent NumPy {np.__version__} oracle for Generator.dirichlet',
    'local np=require("luaray_core")', 'assert(np._version=="0.69.0-dev")',
    'local checks=0',
    'local function eq(a,b) assert(a==b,("comparison %d: %s ~= %s"):format(checks,tostring(a),tostring(b))); checks=checks+1 end',
    'local function eqnan(a) assert(a~=a, "expected NaN at "..checks); checks=checks+1 end']
for seed in seeds:
    for t, alpha in enumerate(alphas):
        for si, size in enumerate(sizes):
            if (seed+t+si)%3==2 and size in ((2,3),(2,1,3)):
                continue
            r=np.random.default_rng(seed)
            expected=r.dirichlet(alpha,size=size)
            vec=lua_alpha(alpha)
            if alpha and (seed+t+si)%5==0:
                vec=f'np.array({vec},"float64")'
            size_literal=lua_size(size)
            if size and len(size)==1 and (seed+t+si)%4==0:
                size_literal=str(size[0])
            lines.append(f'do local r=np.random.default_rng({seed}); local v=r:dirichlet({vec},{size_literal})')
            lines.append('eq(v.dtype,"float64")')
            lines.append(f'eq(#v.shape,{expected.ndim})')
            for d,j in enumerate(expected.shape):
                lines.append(f'eq(v.shape[{d+1}],{j})')
            for idx in np.ndindex(expected.shape):
                ix=','.join(str(i+1) for i in idx)
                lines.append(check_value(expected[idx]).replace('%s',ix))
            lines.append(f'eq(r:raw_hex(),"{next_raw(r)}") end')
# Interleaved calls: drawing a sample changes later results. Validated state word.
for seed in seeds:
    r=np.random.default_rng(seed)
    lines.append(f'do local r=np.random.default_rng({seed})')
    for alpha in [[1.,2.,3.],[0.05,0.02,0.01],[0.,0.],[0.0,0.01,0.4]]:
        v=r.dirichlet(alpha)
        lines.append(f'local v=r:dirichlet({lua_alpha(alpha)})')
        for i,x in enumerate(v):
            lines.append(check_value(x).replace('%s',str(i+1)))
        xx=float(r.random())
        lines.append(f'eq(r:random(),{repr(xx)})')
    lines.append(f'eq(r:raw_hex(),"{next_raw(r)}") end')
# Validation happens before advancing the generator state.
for seed in [0,42]:
    for a in ['{-1,1}', '{0/0,1}', '{math.huge,1}', '{0.2,-0.1}', '{"x",2}', '{1,2,3}']:
        if a=='{1,2,3}': sz='{-1}'
        else: sz='nil'
        r=np.random.default_rng(seed)
        lines.extend([f'do local r=np.random.default_rng({seed})',
                      f'eq(pcall(function()r:dirichlet({a},{sz})end),false)',
                      f'eq(r:raw_hex(),"{next_raw(r)}") end'])
lines.append('print("distributions69 differential passed",checks,"checks")')
out=root/'tests/distributions69_differential_generated.lua'
out.write_text('\n'.join(lines)+'\n')
print('NumPy',np.__version__,'oracle:', len(lines),'lines,',out.stat().st_size,'bytes')
