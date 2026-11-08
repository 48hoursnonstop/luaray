import numpy as np
from pathlib import Path
p=Path(__file__).resolve().parent.parent/'tests/distributions71_differential_generated.lua'
seeds=(0,1,2,17,42,1234,1234567,4294967297)
sizes=(None, (), (0,), (1,), (2,3), (2,1,3))
stds=(float('nan'),float('inf'),1e-10,.01,.2,1.,2.,5.,100.,1e5)
vons=((mu,k) for mu in (-3.7,0,1.25,3.141592653589793,1e100, float('nan'),float('inf')) for k in (0.,1e-9,1e-8,1.01e-8,1e-6,1e-5,0.2,1.,17.,1000.,1e6,1000001.,float('inf'),float('nan')))
vons=list(vons)
lines=['-- Generated independent reference expectations from installed NumPy '+np.__version__,
       'local np=require("luaray_core")', 'assert(np._version=="0.72.0-dev")', 'local checks=0',
       'local function eq(a,b) assert(a==b,("check %d: %s ~= %s"):format(checks,tostring(a),tostring(b))); checks=checks+1 end',
       'local function num(a,b) if b~=b then assert(a~=a,"expected NaN "..checks) elseif b==math.huge or b==-math.huge then assert(a==b) else assert(a==b,("check %d %.17g vs %.17g"):format(checks,a,b)) end; checks=checks+1 end']

def lit(x):
 x=float(x)
 if np.isnan(x):return '(0/0)'
 if np.isposinf(x):return 'math.huge'
 if np.isneginf(x):return '-math.huge'
 return x.hex()

def size_lit(shape):
 if shape is None:return 'nil'
 return '{'+','.join(str(i) for i in shape)+'}'

def sample(method,seed,args,shape):
 rng=np.random.default_rng(seed)
 params=', '.join(lit(x) for x in args)
 lines.append(f'do local r=np.random.default_rng({seed}); local v=r:{method}({params},{size_lit(shape)})')
 try: expected=getattr(rng,method)(*args,size=shape)
 except Exception as e:
  lines.pop()
  return False
 if shape is None: lines.append('num(v,'+lit(expected)+')')
 else:
  a=np.asarray(expected)
  lines.append('eq(v.dtype,"float64")')
  lines.append('eq(#v.shape,'+str(a.ndim)+')')
  for ix,d in enumerate(a.shape,1):lines.append(f'eq(v.shape[{ix}],{d})')
  for ind in np.ndindex(a.shape):
   indices=','.join(str(k+1) for k in ind)
   lines.append(f'num(v:get({indices}),{lit(a[ind])})')
 next_raw=rng.bit_generator.random_raw()
 lines.append(f'eq(r:raw_hex(),"{int(next_raw):016x}") end')
 return True

ncases=0
for seed in seeds:
 for df in stds:
  for shape in sizes:
   if sample('standard_t',seed,(df,),shape):ncases+=1
 for idx,(mu,k) in enumerate(vons):
  # keep wide param coverage but spread seeds; complete thresholds for two main seeds
  if seed not in (0,42) and idx%4!=seed%4:continue
  for shape in sizes:
   if sample('vonmises',seed,(mu,k),shape):ncases+=1
lines.append(f'print("distributions71 differential passed: {ncases} cases, "..checks.." assertions")')
p.write_text('\n'.join(lines)+'\n')
print('generated',ncases,'cases,',len(lines),'lines',p.stat().st_size,'bytes')
