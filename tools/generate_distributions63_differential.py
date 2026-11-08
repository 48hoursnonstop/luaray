"""Generate NumPy-2.3.5 oracle fixture for Gamma-Poisson negative binomial.
Only used for development tests; LuaRay doesn't load NumPy or Python.
"""
from pathlib import Path
import numpy as np
root=Path(__file__).resolve().parents[1]
out=root/'tests/distributions63_differential_generated.lua'
L=[f'-- Generated with executable NumPy {np.__version__}',
   'local np=require("luaray_core")', 'assert(np._version=="0.63.0-dev")',
   'local total=0',
   'local function eq(a,b) assert(a==b,("case %d: %s ~= %s"):format(total,tostring(a),tostring(b)));total=total+1 end']
def shape_arg(s): return 'nil' if s is None else '{'+','.join(map(str,s))+'}'
def compare(value, shape):
    if shape is None: L.append(f'eq(v,{int(value)})')
    else:
        L.append('eq(v.dtype,"int64")')
        L.append(f'eq(#v.shape,{len(shape)})')
        for j,dim in enumerate(shape,1): L.append(f'eq(v.shape[{j}],{dim})')
        for idx in np.ndindex(*shape):
            L.append(f'eq(v:get({",".join(str(i+1) for i in idx)}),{int(value[idx])})')
seeds=[0,1,42,123456789]
ns=[.125,.5,1,2,3.25,5,10,20,100,1000,100000,1000000]
ps=[.001,.002,.01,.05,.1,.2,.5,.7,.9,.95,.99,.999,1.]
shapes=[None,(),(0,),(2,3),(5,)]
for seed in seeds:
 for n in ns:
  for p in ps:
   for shape in shapes:
    rng=np.random.default_rng(seed)
    sample=rng.negative_binomial(n,p,size=shape)
    L.append(f'do local r=np.random.default_rng({seed});local v=r:negative_binomial({n!r},{p!r},{shape_arg(shape)})')
    compare(sample,shape)
    L.append(f'eq(r:raw_hex(),"{int(rng.bit_generator.random_raw()):016x}") end')
# Interleave samplers across regime boundaries
for seed in seeds:
 rng=np.random.default_rng(seed)
 L.append(f'do local r=np.random.default_rng({seed})')
 for k in range(300):
  mod=k%6
  if mod in (0,2,4):
   n=ns[(k*5//6)%len(ns)];p=ps[(k*7//6)%len(ps)]
   result=int(rng.negative_binomial(n,p));expr=f'r:negative_binomial({n!r},{p!r})'
  elif mod==1:
   result=float(rng.random());expr='r:random()'
  elif mod==3:
   result=int(rng.poisson(6));expr='r:poisson(6)'
  else:
   result=int(rng.binomial(50,.4));expr='r:binomial(50,0.4)'
  L.append(f'eq({expr},{result!r})')
  if k%50==49: L.append(f'eq(r:raw_hex(),"{int(rng.bit_generator.random_raw()):016x}")')
 L.append(f'eq(r:raw_hex(),"{int(rng.bit_generator.random_raw()):016x}") end')
# Invalid arguments must be rejected without advancing the generator.
invalid=['r:negative_binomial(0,0.5)', 'r:negative_binomial(-1,0.5)',
         'r:negative_binomial(0/0,0.5)', 'r:negative_binomial(math.huge,0.5)',
         'r:negative_binomial(1000001,0.5)', 'r:negative_binomial(1,0.0)',
         'r:negative_binomial(1,-0.5)', 'r:negative_binomial(1,1.01)',
         'r:negative_binomial(1,math.huge)', 'r:negative_binomial(1,0/0)',
         'r:negative_binomial(1,0.0001)', 'r:negative_binomial(1,0.5,{-1})',
         'r:negative_binomial(1,0.5,{1.2})','r:negative_binomial(1,0.5,{},42)',
         'r:negative_binomial("hi",0.5)', 'r:negative_binomial(1,"hi")']
for expr in invalid:
 rng=np.random.default_rng(42)
 L.append(f'do local r=np.random.default_rng(42);eq(pcall(function() return {expr} end),false);eq(r:raw_hex(),"{int(rng.bit_generator.random_raw()):016x}") end')
L.append('print("distributions63 differential passed: "..total.." exact checks")')
out.write_text('\n'.join(L)+'\n')
print(out, len(L),'lines',out.stat().st_size,'bytes')
