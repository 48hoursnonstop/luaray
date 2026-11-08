from pathlib import Path
import numpy as np
p=Path(__file__).resolve().parents[1]
out=p/'tests/distributions60_differential_generated.lua'
lines=[f'-- NumPy {np.__version__} independent oracle; exact value and PCG64 state checks',"local np=require('luaray_core')","assert(np._version=='0.61.0-dev')","local n=0","local function eq(x,y) assert(x==y or (x~=x and y~=y), tostring(n)..' '..tostring(x)..' != '..tostring(y));n=n+1 end"]
def lit(x):
 x=float(x)
 if np.isnan(x):return '(0/0)'
 if np.isposinf(x):return 'math.huge'
 if np.isneginf(x):return '-math.huge'
 return repr(x)
def args(a):return ','.join(lit(x) for x in a)
def outvalue(a,shape):
 if shape is None:lines.append(f'eq(v,{lit(a)})');return
 lines.extend(['eq(v.dtype,"float64")',f'eq(#v.shape,{len(shape)})'])
 for i,x in enumerate(shape,1):lines.append(f'eq(v.shape[{i}],{x})')
 for ix in np.ndindex(*shape):lines.append('eq(v:get('+','.join(str(y+1) for y in ix)+'),'+lit(a[ix])+')')
seeds=[0,1,2,42,99,314159,123456789,1099511627779]
chis=[(.01,0),(.125,.125),(.5,1.),(1,2.),(.125,19.9),(.25,20),(.125,20.1),(.5,200),(1,1_000),(1.001,1.),(2.,0.),(2.,.125),(2.,5.),(2.,100.),(10.,5.),(100.,30.),(200.,100.)]
fpars=[(.1,.1,0.),(.125,.5,.5),(.5,1.,10.),(1,1,20.),(1.1,3.,4.),(2.,3.,0.),(2.,3.,.2),(5.,8.,25.),(100.,30.,100.),(500.,700.,0.1)]
shapes=[None,(),(0,),(1,),(2,3),(5,), (2,0,3)]
for seed in seeds:
 for name,params in [('noncentral_chisquare',chis),('noncentral_f',fpars)]:
  for pars in params:
   for shape in shapes:
    r=np.random.default_rng(seed)
    v=getattr(r,name)(*pars,size=shape)
    shp='nil' if shape is None else '{'+','.join(map(str,shape))+'}'
    lines.append(f'do local r=np.random.default_rng({seed});local v=r:{name}({args(pars)},{shp})')
    outvalue(v,shape)
    lines.append(f'eq(r:raw_hex(),"{int(r.bit_generator.random_raw()):016x}")')
    lines.append('end')
for seed in seeds:
 r=np.random.default_rng(seed);lines.append(f'do local r=np.random.default_rng({seed})')
 for j in range(480):
  if j%6==0: expr='r:noncentral_chisquare(.5,20)'; v=r.noncentral_chisquare(.5,20)
  elif j%6==1:expr='r:noncentral_f(4,5,6)';v=r.noncentral_f(4,5,6)
  elif j%6==2:expr='r:standard_normal()';v=r.standard_normal()
  elif j%6==3:expr='r:noncentral_chisquare(1.5,.1)';v=r.noncentral_chisquare(1.5,.1)
  elif j%6==4:expr='r:random()';v=r.random()
  else:expr='r:chisquare(3)';v=r.chisquare(3)
  lines.append(f'eq({expr},{lit(v)})')
 lines.append(f'eq(r:raw_hex(),"{int(r.bit_generator.random_raw()):016x}")');lines.append('end')
for expr in ['r:noncentral_chisquare(0,1)','r:noncentral_chisquare(1,-1)','r:noncentral_chisquare(math.huge,1)','r:noncentral_chisquare(1,math.huge)','r:noncentral_chisquare(1,1e13)','r:noncentral_chisquare(2,2,{-1})','r:noncentral_f(0,1,2)','r:noncentral_f(1,0,2)','r:noncentral_f(1,1,-1)','r:noncentral_f(math.huge,1,1)','r:noncentral_f(1,1,1e13)','r:noncentral_f(1,1,1,{-1})']:
 r=np.random.default_rng(42)
 lines.append(f'do local r=np.random.default_rng(42);eq(pcall(function(){expr} end),false);eq(r:raw_hex(),"{int(r.bit_generator.random_raw()):016x}") end')
lines.append("print('distributions60 differential approved: '..n..' exact comparisons')")
out.write_text('\n'.join(lines)+'\n')
print('generated',len(lines),'lines,',out.stat().st_size,'bytes')
