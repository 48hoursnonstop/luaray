from pathlib import Path
import numpy as np, random, math
random.seed(93)
f=Path(__file__).resolve().parents[1] / 'tests/dtype93_min_scalar_differential_generated.lua'
lines=['local np=require("luaray_core")','local n=0','local function check(value,expected,label) local got=np.min_scalar_type(value);assert(got==expected,label..": "..got.." vs "..expected);n=n+1 end']
def add(x,lua,label):
  try:expected=np.min_scalar_type(x).name
  except Exception as e:return
  lines.append('check('+lua+',"'+expected+'","'+label+'")')
for x in [-2**63,-2**31,-2**15,-129,-128,-127,-1,0,1,127,128,255,256,65535,65536,2**31-1,2**31,2**32-1,2**32,2**63-1]:
 add(x,('-9223372036854775807-1' if x==-2**63 else str(x)),f'i{x}')
for i in range(1600):
 x=random.randrange(-2**63,2**63)
 add(x, str(x), f'rand-int{i}')
vals=[0.,-0.,1.,-1.,1e-10,1e-250,1e-300,1e308,64999.,64999.999999,65000.,65000.001,-65000.,65504.,65505.,3.3999e38,3.4e38,1e39,float('inf'),-float('inf'),float('nan')]
for i in range(1700):
 exp=random.uniform(-310,308); v=random.uniform(-1,1)*10**exp
 vals.append(v)
for i,x in enumerate(vals):
 s='math.huge' if x==float('inf') else '-math.huge' if x==-float('inf') else '(0/0)' if math.isnan(x) else repr(x)
 add(x,s,f'float{i}')
for i in range(1200):
 if i==0:r,j=float('nan'),1
 elif i==1:r,j=float('inf'),0
 elif i==2:r,j=1.,-float('inf')
 else:r,j=(random.choice([-1,1])*10**random.uniform(-30,45) for _ in range(2))
 def lit(v):return '(0/0)' if math.isnan(v) else ('math.huge' if v==float('inf') else '-math.huge' if v==-float('inf') else repr(v))
 add(complex(r,j),f'np.complex({lit(r)},{lit(j)})',f'complex{i}')
for dtype in ['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64','complex64','complex128']:
 a=np.array([0,1],dtype=dtype)
 add(a,f'np.array({{0,1}},"{dtype}")','array'+dtype)
add(True,'true','bool true');add(False,'false','bool false')
lines.append('assert(not pcall(np.min_scalar_type))')
lines.append('assert(not pcall(np.min_scalar_type,{}))')
lines.append('assert(not pcall(np.min_scalar_type,1,2))')
lines.append('print("dtype93 min_scalar_type cases:",n)')
f.write_text('\n'.join(lines)+'\n');print('generated',len(lines)-7)
