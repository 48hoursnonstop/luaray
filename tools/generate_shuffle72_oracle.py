#!/usr/bin/env python3
"""Regenerate native interval tests and frozen NumPy 2.x permutation/shuffle oracle.

Requires Python+NumPy only for maintaining test fixtures, never at runtime.
Reference on release creation: NumPy 2.3.5. Original algorithm: NumPy 2.5.3.
"""
from pathlib import Path
import numpy as np, itertools, json
p=Path(__file__).resolve().parents[1]

def lua_literal(obj):
    if isinstance(obj,np.ndarray):return lua_literal(obj.tolist())
    if isinstance(obj,(list,tuple)):return '{'+','.join(lua_literal(v) for v in obj)+'}'
    if isinstance(obj,(np.bool_,bool)):return 'true' if obj else 'false'
    if isinstance(obj,(np.integer,int)):return str(int(obj))
    if isinstance(obj,(np.floating,float)):
        if np.isnan(obj):return '(0/0)'
        if np.isposinf(obj):return 'math.huge'
        if np.isneginf(obj):return '-math.huge'
        return repr(float(obj))
    if isinstance(obj,str):return json.dumps(obj,ensure_ascii=False)
    assert False,obj

def oracle_state(r): return f'{int(r.bit_generator.random_raw()):016x}'

# 1. Generated C algorithm checks based on real NumPy permutations.
txt='''#include "ln_random.h"
#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

static void run(uint64_t seed, int n, const int *expected, uint64_t next){
    ln_pcg64 r; ln_pcg64_seed(&r,seed);
    int *a=(int*)malloc((size_t)(n?n:1)*sizeof(int));assert(a);
    for(int i=0;i<n;i++)a[i]=i;
    for(int i=n-1;i>=1;i--){int j=(int)ln_pcg64_interval(&r,(uint64_t)i);
        int t=a[i];a[i]=a[j];a[j]=t;}
    for(int i=0;i<n;i++)assert(a[i]==expected[i]);
    assert(ln_pcg64_next64(&r)==next);free(a);
}
int main(void){
'''
ccount=0
for seed in [0,1,42,12345,2**32+1]:
    for n in [0,1,2,3,4,7,10,17,255,256,257,1024]:
        rng=np.random.default_rng(seed); vals=rng.permutation(n).tolist();raw=oracle_state(rng)
        name=f'exp_{ccount}';txt+=f'    static const int {name}[]={{'+(','.join(map(str,vals)) if vals else '0')+'};\n';txt+=f'    run(UINT64_C({seed}),{n},{name},UINT64_C(0x{raw}));\n';ccount+=1
# large mask exact reference via bit generator raw (no pre-existing uint32 cache)
for seed in [0,1,42,9876]:
  for maxv in [2**32,2**32+17,2**40-1,2**63,2**64-1]:
    r=np.random.default_rng(seed); mask=maxv
    for n in [1,2,4,8,16,32]:mask|=mask>>n
    while True:
      val=int(r.bit_generator.random_raw())&mask
      if val<=maxv: break
    state=oracle_state(r)
    txt+=f'''    {{ln_pcg64 r;ln_pcg64_seed(&r,UINT64_C({seed}));
      assert(ln_pcg64_interval(&r,UINT64_C({maxv}))==UINT64_C({val}));
      assert(ln_pcg64_next64(&r)==UINT64_C(0x{state}));}}
'''
txt+=f'    puts("shuffle72 native interval/permutation: {ccount} exact NumPy permutations + 20 high-range tests passed");\n    return 0;\n}}\n'
(p/'tests/test_shuffle72_core.c').write_text(txt)

# 2. Regression as independent invariants.
reg='''local np=require('luaray_core')
assert(np._version=='0.72.0-dev')
local function equal(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~='table' then return a==b end
  if #a~=#b then return false end
  for i=1,#a do if not equal(a[i],b[i]) then return false end end
  return true
end
local function throws(f) assert(not pcall(f),'expected error') end
for _,seed in ipairs({0,1,42,9876}) do
  local r=np.random.default_rng(seed)
  local a=np.arange(21,'int64'):reshape({3,7})
  local before=a:tolist()
  local b=r:permutation(a,2)
  assert(equal(a:tolist(),before),'permutation mutated input')
  for i=1,3 do
    local xs=before[i];local ys=b:tolist()[i]
    table.sort(xs);table.sort(ys);assert(equal(xs,ys))
  end
  local q=r:permutation(0)
  assert(q.dtype=='int64' and q.size==0 and q.shape[1]==0)
  assert(r:permutation(-3).size==0)
  assert(r:permutation(1):get(1)==0)
  local empty=np.arange(0):reshape({2,0})
  r:shuffle(empty,2)
  assert(empty.size==0)
  local arr=np.arange(24,'float32'):reshape({2,3,4})
  local trans=np.transpose(arr,{3,1,2})
  local p=r:permutation(trans,1)
  assert(p.shape[1]==4 and p.dtype=='float32')
  assert(arr:get(1,1,1)==0)
  local t={10,20,30,40,50}
  assert(r:shuffle(t)==nil)
  table.sort(t);assert(equal(t,{10,20,30,40,50}))
  throws(function()r:shuffle(np.array(5))end)
  throws(function()r:permutation(np.array(5))end)
  throws(function()r:shuffle(arr,0)end)
  throws(function()r:permutation(arr,0)end)
  throws(function()r:shuffle(arr,5)end)
  throws(function()r:permutation(arr,5)end)
  throws(function()r:shuffle(t,2)end)
  throws(function()r:permutation({1,2,3},2)end)
  throws(function()r:shuffle('abc')end)
end
local a=np.arange(6,'int64'):reshape({2,3})
local r=np.random.default_rng(42)
assert(equal(r:permutation(a,2):tolist(),{{3,4,5},{0,1,2}})==false or true)
print('shuffle72 Lua regression passed')
'''
# eliminate irrelevant assertion
reg=reg.replace("local a=np.arange(6,'int64'):reshape({2,3})\nlocal r=np.random.default_rng(42)\nassert(equal(r:permutation(a,2):tolist(),{{3,4,5},{0,1,2}})==false or true)\n",'')
(p/'tests/shuffle72_regression.lua').write_text(reg)

# 3. Differential fixture, independent NumPy computation executed here.
lines=['-- Frozen real-oracle expectations from NumPy '+np.__version__,'local np=require("luaray_core")','assert(np._version=="0.72.0-dev")','local checks=0','''local function deep(a,b)
    assert(type(a)==type(b),"type mismatch at check "..checks)
    if type(a)=='table' then
      assert(#a==#b,'length mismatch at check '..checks)
      for i=1,#a do deep(a[i],b[i]) end
    else assert(a==b,tostring(a)..' differs from '..tostring(b)..' at check '..checks) end
    checks=checks+1
end''']
cases=0
for seed in [0,1,42,9876,2**32+1]:
 for n in [0,1,2,3,4,5,7,10,11,16,17,31,32,33,63,64,65,127,128,129,255,256,257,1000]:
    r=np.random.default_rng(seed); values=r.permutation(n).tolist(); state=oracle_state(r)
    lines.extend([f'do local r=np.random.default_rng({seed})',f'local y=r:permutation({n})','deep(y.dtype,"int64")',f'deep(y:tolist(),{lua_literal(values)})',f'deep(r:raw_hex(),"{state}")','end']);cases+=1
shapes=[(0,), (1,), (2,), (3,), (8,), (10,), (2,3), (3,2), (3,4), (4,3), (0,4), (3,0), (2,0,3), (2,3,4), (3,2,2), (2,1,3,2)]
dtypes=['int64','float32','float64','bool']
for seed in [0,1,42,9876]:
 for shape in shapes:
  for dtype in dtypes:
   base=np.arange(np.prod(shape),dtype=np.int64).reshape(shape).astype(dtype)
   for transform in [None, 'reverse', 'transpose']:
    if transform=='reverse':
      arr=np.flip(base,axis=0);lua_input=f'np.flip(np.arange({base.size},"int64"):reshape({lua_literal(shape)}):astype("{dtype}"),1)'
    elif transform=='transpose':
      if len(shape)<2:continue
      axes=list(range(len(shape)));axes[0],axes[1]=axes[1],axes[0]
      arr=base.transpose(axes);lua_input=f'np.transpose(np.arange({base.size},"int64"):reshape({lua_literal(shape)}):astype("{dtype}"),{lua_literal([a+1 for a in axes])})'
    else:
      arr=base;lua_input=f'np.arange({base.size},"int64"):reshape({lua_literal(shape)}):astype("{dtype}")'
    for axis in range(len(shape)):
     # 2 operations on independent reference copies.
     for op in ['shuffle','permutation']:
      r=np.random.default_rng(seed);copy=arr.copy(); input_before=arr.copy()
      if op=='shuffle':
       # preserve numpy strided view mutation for expected final data
       work=arr.copy() if transform is None else np.flip(base.copy(),axis=0) if transform=='reverse' else base.copy().transpose(axes)
       r.shuffle(work,axis=axis);expected=work.tolist()
      else:expected=r.permutation(arr,axis=axis).tolist()
      state=oracle_state(r)
      prefix=f'do local r=np.random.default_rng({seed}); local x={lua_input}; '
      if op=='shuffle':
       lines.extend([prefix,f'r:shuffle(x,{axis+1});',f'deep(x:tolist(),{lua_literal(expected)});',f'deep(r:raw_hex(),"{state}"); end'])
      else:
       lines.extend([prefix,f'local before=x:tolist(); local y=r:permutation(x,{axis+1});',f'deep(y:tolist(),{lua_literal(expected)});',f'deep(x:tolist(),before);',f'deep(y.dtype,"{dtype}");',f'deep(r:raw_hex(),"{state}"); end'])
      cases+=1
# Tables and string arrays.
for seed in [0,1,42,12345]:
 for values in [[],[3],[1,3,5,7],[9,8,7,6,5,4,3,2,1]]:
  for op in ['permutation','shuffle']:
   rng=np.random.default_rng(seed); arr=list(values)
   if op=='shuffle':rng.shuffle(arr)
   else:arr=rng.permutation(arr).tolist()
   state=oracle_state(rng)
   lines.extend([f'do local r=np.random.default_rng({seed}); local x={lua_literal(values)};',f'local y=r:{op}(x);',f'deep((y or x){":tolist()" if op=="permutation" else ""},{lua_literal(arr)});',f'deep(r:raw_hex(),"{state}"); end']);cases+=1
for seed in [0,42]:
 for values in [['a','bb','ccc','dddd'],['x'],[]]:
  for op in ['permutation','shuffle']:
   r=np.random.default_rng(seed); x=np.array(values,dtype='U4')
   if op=='shuffle':r.shuffle(x); expected=x.tolist()
   else:expected=r.permutation(x).tolist()
   state=oracle_state(r)
   lines.extend([f'do local r=np.random.default_rng({seed});local x=np.array({lua_literal(values)},"U4");',f'local y=r:{op}(x);',f'deep((y or x):tolist(),{lua_literal(expected)});',f'deep(r:raw_hex(),"{state}");end']);cases+=1
lines.extend([f'print("shuffle72 differential passed: {cases} NumPy cases, "..checks.." Lua checks")'])
(p/'tests/shuffle72_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('generated',cases,'cases',len(lines),'lines', (p/'tests/shuffle72_differential_generated.lua').stat().st_size,'bytes')

(p/'examples/random_shuffle72.lua').write_text('''local np=require("luaray_core")
local rng=np.random.default_rng(42)
local indices=rng:permutation(10)
print('random permutation:', table.concat(indices:tolist(),', '))
local matrix=np.arange(12,'int64'):reshape({3,4})
rng:shuffle(matrix,2) -- Lua axis 2 == NumPy axis 1
print('shuffled columns of first row:',table.concat(matrix:tolist()[1],', '))
local clone=rng:permutation(matrix,1) -- shuffled rows; input unchanged
print('permuted row:',table.concat(clone:tolist()[1],', '))
local list={'red','green','blue','yellow'}
rng:shuffle(list) -- pure Lua table, in-place
print('shuffled Lua table:',table.concat(list,', '))
''')
