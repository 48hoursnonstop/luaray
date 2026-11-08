from pathlib import Path
import numpy as np,json
p=Path(__file__).resolve().parents[1]
base={
'U3':[['é','猫','xyz'],['ab','☃','']],
'S3':[['a','b','xy'],['xyz','m','']],
'complex64':[[1+2j,3+4j,5-1j],[-2+0.5j,8+7j,1-3j]],
'float16':[[0.25,1.5,-2.0],[3.75,5.0,6.5]],
'datetime64[D]':[['2024-01-01','2024-02-02','2024-03-03'],['2023-11-11','2025-07-01','2026-10-09']]
}
def literal(x):
 if isinstance(x,(np.ndarray,list,tuple)):return '{'+','.join(literal(z) for z in x)+'}'
 if isinstance(x,complex):return 'np.complex('+str(x.real)+','+str(x.imag)+')'
 if isinstance(x,(np.float16,np.float32,np.float64,float)):return repr(float(x))
 if isinstance(x,(np.int64,np.int32,int)):return str(x)
 if isinstance(x,str):return json.dumps(x,ensure_ascii=False)
 raise TypeError(type(x))
def expected(a,kind):
 if kind=='complex64':return [[[float(z.real),float(z.imag)] for z in row] for row in a]
 if kind=='S3':return [[z.decode('ascii') for z in row] for row in a]
 if kind=='datetime64[D]':return a.astype('U').tolist()
 return a.tolist()
header='''local np=require('luaray_core')
local checks=0
local function deep(a,b)
 assert(type(a)==type(b),'type '..tostring(a)..' vs '..tostring(b))
 if type(a)=='table' then
  assert(#a==#b,'length '..#a..' vs '..#b)
  for i=1,#a do deep(a[i],b[i]) end
 else assert(a==b,tostring(a)..' differs from '..tostring(b)) end
 checks=checks+1
end
local function normalized(a,kind)
 local function walk(x)
  if type(x)=='table' then
   local out={};for i,v in ipairs(x) do out[i]=walk(v) end;return out
  end
  if kind=='complex64' then return {x.real,x.imag} end
  if kind=='datetime64[D]' then return tostring(x) end
  return x
 end
 return walk(a:tolist())
end
'''
lines=[header];c=0
for kind,values in base.items():
 for seed in [0,1,42,9876]:
  for axis in [None,0,1]:
   for mode in ['copy','out_same']:
    ref=np.array(values,dtype=kind)
    rng=np.random.default_rng(seed)
    dst=ref if mode=='out_same' else None
    y=rng.permuted(ref,axis=axis,out=dst)
    state=f'{int(rng.bit_generator.random_raw()):016x}'
    ax='nil' if axis is None else str(axis+1)
    lines.extend(['do',f'local r=np.random.default_rng({seed})',f'local x=np.array({literal(values)},{literal(kind)})',
      f'local y=r:permuted(x,{ax}'+(',x)' if mode=='out_same' else ')'),
      f'deep(normalized(y,{literal(kind)}),{literal(expected(y,kind))})',
      f'deep(r:raw_hex(),"{state}")',
      'cases=cases+1; end'])
    c+=1
lines.insert(1,'local cases=0')
lines.append('print("permuted73 dtypes differential: "..cases.." cases and "..checks.." comparisons passed")')
(p/'tests/permuted73_dtypes_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print(c)
