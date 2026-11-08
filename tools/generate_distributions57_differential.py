#!/usr/bin/env python3
"""Generate replayable exact NumPy 2.3.5 differential fixtures (NumPy 2.5.3 source reference)."""
from pathlib import Path
import numpy as np
root=Path(__file__).resolve().parents[1]
out=root/'tests/distributions57_differential_generated.lua'
lines=[f'-- NumPy {np.__version__} oracle; source reference NumPy 2.5.3',
       "local np=require('luaray_core')", "assert(np._version=='0.59.0-dev')",'local cases=0',
       'local function eq(a,b) assert(a==b, tostring(a).." ~= "..tostring(b));cases=cases+1 end',
       'local function eqnum(a,b) assert(a==b or (a~=a and b~=b), tostring(a).." ~= "..tostring(b));cases=cases+1 end']
seeds=[0,1,2,42,99,123456789,1099511627779,4611686018427387909]
shapes=[None,(),(0,),(1,),(2,3),(2,0,4),(3,2,3),(127,)]
params={'pareto':[(0.125,),(1.,),(2.,),(100.,)],
        'power':[(0.125,),(1.,),(2.,),(100.,)],
        'triangular':[(-2.,0.,5.),(0.,0.,1.),(0.,1.,1.),(-20.,-10.,30.)]}
def lit(v):
 v=float(v)
 if np.isnan(v):return '(0/0)'
 if np.isposinf(v):return 'math.huge'
 if np.isneginf(v):return '-math.huge'
 return repr(v)
def shape_repr(s):
 if s is None:return 'nil'
 if len(s)==1:return str(s[0])
 return '{'+','.join(map(str,s))+'}'
def check_value(v,s):
 if s is None:lines.append(f'eqnum(v,{lit(v)})')
 else:
  lines.append('eq(v.dtype,"float64")')
  for j,d in enumerate(s,1):lines.append(f'eq(v.shape[{j}],{d})')
  for ix in np.ndindex(*s):
   loc=','.join(str(j+1) for j in ix)
   lines.append(f'eqnum(v:get({loc}),{lit(v[ix])})')
def state(r):lines.append(f'eq(r:raw_hex(),"{int(r.bit_generator.random_raw()):016x}")')
for seed in seeds:
 for name,ps in params.items():
  for par in ps:
   for shape in shapes:
    r=np.random.default_rng(seed)
    v=getattr(r,name)(*par,size=shape)
    args=','.join([*(lit(x) for x in par),shape_repr(shape)])
    lines.append(f'do local r=np.random.default_rng({seed}); local v=r:{name}({args})')
    check_value(v,shape);state(r);lines.append('end')
# PCG64 interleaving: exact samples AND the next raw word
for seed in seeds:
 r=np.random.default_rng(seed)
 lines.append(f'do local r=np.random.default_rng({seed})')
 for i in range(256):
  j=i%8
  if j==0: v=r.pareto(.125);call='r:pareto(0.125)'
  elif j==1: v=r.power(2.);call='r:power(2)'
  elif j==2: v=r.triangular(-2.,0.,5.);call='r:triangular(-2,0,5)'
  elif j==3: v=r.standard_normal();call='r:standard_normal()'
  elif j==4: v=r.standard_exponential();call='r:standard_exponential()'
  elif j==5: v=r.weibull(3);call='r:weibull(3)'
  elif j==6: v=r.random();call='r:random()'
  else: v=r.gumbel(0.,1.);call='r:gumbel(0,1)'
  lines.append(f'eqnum({call},{lit(v)})')
 state(r);lines.append('end')
# Errors must be rejected before consuming bits
bad=['r:pareto(0)','r:pareto(-1)','r:power(0)','r:power(-1)',
 'r:triangular(1,0,2)','r:triangular(0,3,2)','r:triangular(1,1,1)',
 'r:triangular(0,1,2,-1)','r:pareto(1,{-1})','r:power(1,{-1})',
 'r:pareto(1,{2},3)','r:power(1,{2},3)','r:triangular(0,1,2,{2},3)']
for expr in bad:
 lines.append(f'do local r=np.random.default_rng(42);eq(pcall(function() {expr} end),false);eq(r:raw_hex(),"c621fbcd16d92688") end')
lines.append("print('distributions57 differential approved: '..cases..' comparisons')")
out.write_text('\n'.join(lines)+'\n')
print(f'generated {out} with {len(lines)} lines')
