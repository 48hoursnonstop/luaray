"""Generate deterministic NumPy reference fixtures for Wald and logseries.

Source algorithms are copied from the supplied NumPy 2.5.3 tarball;
NumPy 2.3.5 on the build machine is the independent executable oracle.
No Python is required to run the generated Lua fixture or LuaRay.
"""
from pathlib import Path
import math
import numpy as np

root = Path(__file__).resolve().parents[1]
seeds = [0, 1, 2, 17, 42, 1234, 2**32-1, 2**63-1]
wald = [(1., 1.), (1., 2.), (2., 1.), (3., 5.), (0.01, 0.1),
        (100., 2.), (0.125, 0.3), (1e-12, 1e12), (1e-9, 1e-4),
        (1e6, 1e5), (10., 1e-12), (1., math.inf), (math.inf, 1.)]
logseries = [0., 1e-300, 0.001, 0.01, 0.2, 0.5, 0.8,
             0.9, 0.99, 0.9999, 0.999999, math.nextafter(1., 0.)]
sizes = [None, (), (0,), (1,), (2, 3), (8,), (2, 1, 3)]

def lua_float(x):
    if math.isnan(x): return '0/0'
    if x == math.inf: return 'math.huge'
    if x == -math.inf: return '-math.huge'
    return x.hex()

def lua_size(size):
    if size is None: return 'nil'
    return '{' + ','.join(str(s) for s in size) + '}'

def raw(r): return f'{int(r.bit_generator.random_raw()):016x}'

lines = [f'-- Wald/logseries independent NumPy {np.__version__} differential oracle',
         'local np=require("luaray_core")',
         'assert(np._version=="0.70.0-dev")',
         'local checks=0',
         'local function eq(a,b) assert(a==b,("check %d: %s ~= %s"):format(checks,tostring(a),tostring(b))); checks=checks+1 end',
         'local function eqnum(a,b) if b~=b then assert(a~=a,"expected NaN "..checks) else assert(a==b,("check %d: %.17g ~= %.17g"):format(checks,a,b)) end; checks=checks+1 end']

for seed in seeds:
    for name, params in [('wald', p) for p in wald] + [('logseries', (p,)) for p in logseries]:
        for size in sizes:
            rng = np.random.default_rng(seed)
            with np.errstate(all='ignore'):
                expected = getattr(rng, name)(*params, size=size)
            args = ','.join(map(lua_float, params))
            lines.append(f'do local r=np.random.default_rng({seed}); local v=r:{name}({args},{lua_size(size)})')
            if size is None:
                lines.append(f'eqnum(v,{lua_float(expected)})' if name == 'wald' else f'eq(v,{int(expected)})')
            else:
                lines.append(f'eq(v.dtype,"{"float64" if name=="wald" else "int64"}")')
                lines.append(f'eq(#v.shape,{len(size)})')
                for i, extent in enumerate(size): lines.append(f'eq(v.shape[{i+1}],{extent})')
                for ix in np.ndindex(np.shape(expected)):
                    index = ','.join(str(i+1) for i in ix)
                    x = expected[ix]
                    lines.append(f'eqnum(v:get({index}),{lua_float(float(x))})' if name == 'wald' else f'eq(v:get({index}),{int(x)})')
            lines.append(f'eq(r:raw_hex(),"{raw(rng)}") end')

# Consuming the same generator across several distinct distributions exercises
# the normal RNG rejection path and the logseries two-uniform branch.
for seed in seeds:
    r = np.random.default_rng(seed)
    lines.append(f'do local r=np.random.default_rng({seed})')
    for name, args in [('wald', (1.,1.)), ('logseries',(0.999,)),
                       ('wald',(3.,5.)), ('logseries',(0.,)),
                       ('wald',(0.01,0.1)),('logseries',(0.99,))]:
        with np.errstate(all='ignore'): x=getattr(r,name)(*args)
        argstr=','.join(map(lua_float,args))
        lines.append(f'eqnum(r:{name}({argstr}),{lua_float(float(x))})' if name=='wald' else f'eq(r:{name}({argstr}),{int(x)})')
        y=float(r.random())
        lines.append(f'eqnum(r:random(),{lua_float(y)})')
    lines.append(f'eq(r:raw_hex(),"{raw(r)}") end')

for seed in [0, 42]:
    for name, args in [('wald','0,1'),('wald','1,0'),('wald','-1,2'),
                       ('wald','0/0,1'),('wald','2,0/0'),('wald','1,-math.huge'),
                       ('logseries','-0.01'),('logseries','1'),
                       ('logseries','math.huge'),('logseries','0/0')]:
        rr = np.random.default_rng(seed)
        lines += [f'do local r=np.random.default_rng({seed})',
                  f'eq(pcall(function()r:{name}({args})end),false)',
                  f'eq(r:raw_hex(),"{raw(rr)}") end']

lines.append('print("distributions70 differential passed",checks,"checks")')
out=root/'tests/distributions70_differential_generated.lua'
out.write_text('\n'.join(lines)+'\n')
print('NumPy',np.__version__,'fixture',len(lines),'lines',out.stat().st_size,'bytes')
