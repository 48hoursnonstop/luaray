"""Regenerate the NumPy 2.3.5 multinomial oracle fixture (test-time only)."""
from pathlib import Path
import numpy as np
p=Path(__file__).resolve().parents[1]
seeds=[0,1,2,17,42,1234,2**32-1,2**63-1]
probs=[[1.0],[0.5,0.5],[0.2,0.3,0.5],[0.0,0.0,0.0],[0.0,0.0,1.0],[1.0,0.0,0.0],
       [0.1,0.2,0.3,0.4],[0.4,0.1,0.0,0.0],[0.8,0.0,0.0,0.0],[0.123,0.234,0.321,0.0],
       [1/6]*6,[0.02,0.97,0.01],[0.55,0.44999999999,0.0],[0.3,0.3,0.3,0.3],
       [0.99999999,0.00000001],[1e-7,1e-7,1e-7],[0.0,1.0]]
ns=[0,1,2,5,20,100,1000]
sizes=[None,(),(0,),(1,),(2,3),(3,2,1)]

def fnum(x):return repr(x)
def lvals(vals):return '{'+','.join(map(fnum,vals))+'}'
def szlua(sz):return 'nil' if sz is None else '{'+','.join(map(str,sz))+'}'
def expected_raw(r):return format(int(r.bit_generator.random_raw()),'016x')
lines=['-- Deterministic NumPy %s oracle for Generator.multinomial; test-only Python'%np.__version__,
       'local np=require("luaray_core")','assert(np._version=="0.68.0-dev")','local checks=0',
       'local function eq(a,b) assert(a==b,("comparison %d: %s ~= %s"):format(checks,tostring(a),tostring(b))); checks=checks+1 end']
for seed in seeds:
  for ii,prob in enumerate(probs):
    for n in ns:
      for size in sizes:
        if (seed+ii+n)%3==2 and size in ((2,3),(3,2,1)):continue
        r=np.random.default_rng(seed)
        expected=r.multinomial(n,prob,size)
        inputvals=lvals(prob)
        if (seed+n+ii)%4==0:inputvals='np.array('+inputvals+',"float64")'
        lines.append(f'do local r=np.random.default_rng({seed}); local v=r:multinomial({n},{inputvals},{szlua(size)})')
        lines.append('eq(v.dtype,"int64")')
        lines.append(f'eq(#v.shape,{expected.ndim})')
        for d,j in enumerate(expected.shape):lines.append(f'eq(v.shape[{d+1}],{j})')
        for ix in np.ndindex(expected.shape):
          args=','.join(str(i+1) for i in ix)
          lines.append(f'eq(v:get({args}),{int(expected[ix])})')
        lines.append(f'eq(r:raw_hex(),"{expected_raw(r)}") end')
# Interleaved calls to exercise PCG64 state and draw count
for seed in seeds:
 r=np.random.default_rng(seed)
 lines.append(f'do local r=np.random.default_rng({seed})')
 for n,prob in [(25,[.25,.25,.5]),(200,[.03,.37,.6]),(0,[.1,.9]),(100,[1.0,0.0])]:
  expected=r.multinomial(n,prob)
  lines.append(f'local v=r:multinomial({n},{lvals(prob)})')
  for i,x in enumerate(expected):lines.append(f'eq(v:get({i+1}),{int(x)})')
  x=float(r.random());lines.append(f'eq(r:random(),{repr(x)})')
 lines.append(f'eq(r:raw_hex(),"{expected_raw(r)}") end')
# Validation must precede all state mutation
for seed in [0,42]:
 for n,prob in [(10,[]),(-1,[0.5,0.5]),(10,[.7,.4,.1]),(10,[float('nan'),1]),(10,[-0.1,1]),(10,[.5,1.1]),(10,[float('inf'),1])]:
  p_lua='{0/0,1}' if prob and np.isnan(prob[0]) else '{math.huge,1}' if prob and np.isinf(prob[0]) else lvals(prob)
  r=np.random.default_rng(seed)
  lines.extend([f'do local r=np.random.default_rng({seed})',
    f'local ok=pcall(function() r:multinomial({n},{p_lua}) end)',
    'eq(ok,false)',f'eq(r:raw_hex(),"{expected_raw(r)}") end'])
lines.append('print("distributions68 differential passed",checks,"checks")')
(p/'tests/distributions68_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('fixture',len(lines),'lines', 'size MB', round((p/'tests/distributions68_differential_generated.lua').stat().st_size/1e6,2))
