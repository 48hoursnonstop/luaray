#!/usr/bin/env python3
"""Reproducible NumPy oracle for gumbel, logistic, rayleigh, weibull."""
from pathlib import Path
import numpy as np
root=Path(__file__).resolve().parents[1]
out=root/'tests/distributions56_differential_generated.lua'
lines=[f'-- NumPy {np.__version__} oracle; no Python required to replay',
       "local np=require('luaray_core')", "assert(np._version=='0.57.0-dev')",
       'local cases=0',
       'local function eq(a,b) assert(a==b, tostring(a).." ~= "..tostring(b));cases=cases+1 end',
       'local function eqnum(a,b) assert(a==b or (a~=a and b~=b), tostring(a).." ~= "..tostring(b));cases=cases+1 end']
seeds=[0,1,2,42,99,123456789,1099511627779,4611686018427387909]
shapes=[None,(),(0,),(1,),(2,3),(2,0,4),(3,2,3),(127,)]
params={'gumbel':[(0.,1.),(0.,0.),(-2.5,0.25),(2.25,3.)],
        'logistic':[(0.,1.),(0.,0.),(-2.5,0.25),(2.25,3.)],
        'rayleigh':[(1.,),(0.,),(.125,),(3.,)],
        'weibull':[(1.,),(0.,),(.125,),(3.,)]}
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
 if s is None:
  lines.append(f'eqnum(v,{lit(v)})')
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
# Long interleaved samples: sample and state checked exactly
for seed in seeds:
 r=np.random.default_rng(seed)
 lines.append(f'do local r=np.random.default_rng({seed})')
 for i in range(256):
  j=i%8
  if j==0: v=r.gumbel(-2.5,.25);call='r:gumbel(-2.5,0.25)'
  elif j==1: v=r.logistic(2.25,3.);call='r:logistic(2.25,3)'
  elif j==2: v=r.rayleigh(.125);call='r:rayleigh(0.125)'
  elif j==3: v=r.weibull(3.);call='r:weibull(3)'
  elif j==4: v=r.weibull(0.);call='r:weibull(0)'
  elif j==5: v=r.standard_normal();call='r:standard_normal()'
  elif j==6: v=r.standard_exponential();call='r:standard_exponential()'
  else: v=r.random();call='r:random()'
  lines.append(f'eqnum({call},{lit(v)})')
 state(r);lines.append('end')
# rejected arguments must not alter random state
bad=['r:gumbel(0,-1)','r:logistic(0,-1)','r:rayleigh(-1)','r:weibull(-1)',
 'r:gumbel(0,0/0)','r:logistic(0,0/0)','r:rayleigh(1,-2)','r:weibull(1,-2)',
 'r:gumbel(0,1,-2)','r:logistic(0,1,-2)','r:gumbel(0,1,2,3)','r:logistic(0,1,2,3)',
 'r:rayleigh(1,2,3)','r:weibull(1,2,3)']
for expr in bad:
 lines.append(f'do local r=np.random.default_rng(42);eq(pcall(function() {expr} end),false);eq(r:raw_hex(),"c621fbcd16d92688") end')
lines.append("print('distributions56 differential approved: '..cases..' comparisons')")
out.write_text('\n'.join(lines)+'\n')
print('generated',out, 'Lua lines',len(lines))
