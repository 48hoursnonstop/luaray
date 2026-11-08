from pathlib import Path
import numpy as np
names=['lognormal','laplace','gumbel','logistic','rayleigh','weibull','pareto','power']
def num(x):
 if np.isnan(x):return '(0/0)'
 if np.isposinf(x):return '(1/0)'
 if np.isneginf(x):return '(-1/0)'
 return repr(float(x))
lines=['''local np=require('luaray_core')
local function eq(a,b) return a==b or (a~=a and b~=b) end
''']
n=0
for ki,k in enumerate(names):
 for ai,a in enumerate([0., float('nan'), float('inf'), 1e-300, 1e100]):
  if k in ('pareto','power') and a==0:continue
  for size in [None,(0,), (2,)]:
   args=([.75,a] if k in ('lognormal','laplace','gumbel','logistic') else [a])
   if k in ('pareto','power') and a<=0:continue
   seed=42+ki*20+ai
   rng=np.random.default_rng(seed)
   try:out=getattr(rng,k)(*args,size=size)
   except ValueError:continue
   outarr=np.asarray(out).reshape(-1)
   raw=f'{int(rng.bit_generator.random_raw()):016x}'
   luaargs=['{'+num(x)+'}' for x in args]
   sz='nil' if size is None else '{'+','.join(str(x) for x in size)+'}'
   call=', '.join(luaargs+[sz]); v='{'+','.join(num(x) for x in outarr)+'}'
   lines.append(f'do local r=np.random.default_rng({seed});local x=r:{k}({call});\n')
   if size is None:
    lines.append(f'  assert(eq(x:tolist()[1],{num(outarr[0])}),"{k} value {n}")\n')
   else:
    lines.append(f'  local e={v};local t=x:tolist(); assert(#t==#e,"length {n}");for i=1,#e do assert(eq(t[i],e[i]),"{k} value {n}") end\n')
   lines.append(f'  assert(r:raw_hex()=="{raw}","{k} PCG64 {n}")\nend\n')
   n+=1
lines.append(f'print("random78 edge oracle passed: {n} cases")')
out=Path(__file__).resolve().parents[1]/'tests/random78_edge_generated.lua'
out.write_text(''.join(lines));print(n)
