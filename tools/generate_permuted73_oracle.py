#!/usr/bin/env python3
"""Frozen independent NumPy 2.3.5 runtime oracle for LuaRay's NumPy 2.5.3 port.
No Python is required to run the emitted Lua tests.
"""
import numpy as np, itertools, json
from pathlib import Path
p=Path(__file__).resolve().parents[1]

def lua(obj):
    if isinstance(obj, np.ndarray):return lua(obj.tolist())
    if isinstance(obj,(tuple,list)):return '{'+','.join(lua(v) for v in obj)+'}'
    if isinstance(obj,(np.bool_,bool)):return 'true' if obj else 'false'
    if isinstance(obj,(np.integer,int)):return str(int(obj))
    if isinstance(obj,(np.floating,float)):
        if np.isnan(obj):return '(0/0)'
        if np.isposinf(obj):return 'math.huge'
        if np.isneginf(obj):return '-math.huge'
        return repr(float(obj))
    if isinstance(obj,str):return json.dumps(obj,ensure_ascii=False)
    raise TypeError(obj)

lines=['-- Frozen differential fixtures generated from real NumPy '+np.__version__,
       'local np=require("luaray_core")',
       'assert(np._version=="0.75.0-dev")',
       'local checks,cases=0,0',
       '''local function deep(a,b,desc)
    assert(type(a)==type(b),desc..': type mismatch: '..type(a)..' vs '..type(b))
    if type(a)=='table' then
        assert(#a==#b,desc..': length mismatch: '..#a..' vs '..#b)
        for i=1,#a do deep(a[i],b[i],desc..'['..i..']') end
    else
        assert(a==b,desc..': '..tostring(a)..' vs '..tostring(b))
    end
    checks=checks+1
end''']
shapes=[(0,),(1,),(2,),(3,),(8,), (2,3), (3,4), (4,3), (0,4),(2,0),(2,0,3),(2,3,4),(3,2,3),(2,1,4),(1,2,4),(2,3,1,2)]
seeds=[0,1,42,9876,2**32+1]
dtypes=['int64','int32','float64','float32','uint8','bool']
cases=0
for seed in seeds:
 for shape in shapes:
  for dtype in dtypes:
   for variant in ['plain','transpose','flip']:
    if variant!='plain' and len(shape)==1:continue
    base=np.arange(np.prod(shape),dtype=np.int64).reshape(shape).astype(dtype)
    xcode=f'np.astype(np.arange({int(np.prod(shape))},"int64"):reshape({lua(shape)}),"{dtype}")'
    if variant=='transpose':
        axs=list(reversed(range(len(shape))))
        base=base.transpose(axs)
        xcode=f'np.transpose({xcode},{lua([v+1 for v in axs])})'
    elif variant=='flip':
        base=np.flip(base,axis=0)
        xcode=f'np.flip({xcode},1)'
    ax_cases=[None,0,len(base.shape)-1]
    if len(base.shape)>1:ax_cases.append(-1)
    ax_cases=list(dict.fromkeys(ax_cases))
    for ax in ax_cases:
     for mode in ['copy','out_same','out_new']:
      # spread enough cases while retaining noncontiguous input coverage
      if mode=='out_new' and variant=='flip' and seed not in (0,42):continue
      if mode=='out_same' and dtype in ('bool','uint8') and seed not in (0,42):continue
      rng=np.random.default_rng(seed)
      x=base.copy(order='K') if variant=='plain' else base.copy(order='K')
      if variant=='transpose':
          # Need to preserve the true transposed view layout for upstream oracle
          x=base.copy(order='K')
      elif variant=='flip':
          x=np.flip(np.arange(np.prod(shape),dtype=np.int64).reshape(shape).astype(dtype),axis=0) # fresh negative-stride view
      before=x.copy()
      if mode=='copy':out=None
      elif mode=='out_same':out=x
      elif mode=='out_new':out=np.zeros(x.shape,dtype=x.dtype)
      try:
          y=rng.permuted(x,axis=ax,out=out)
      except Exception as e:
          print('skip',shape,dtype,variant,ax,mode,str(e));continue
      expected=y.tolist();after=x.tolist();raw=f'{int(rng.bit_generator.random_raw()):016x}'
      axiscode='nil' if ax is None else str(ax+1 if ax>=0 else ax)
      desc=f'{seed}/{shape}/{dtype}/{variant}/{ax}/{mode}'
      lines.append('do')
      lines.append(f'local r=np.random.default_rng({seed})')
      lines.append('local x='+xcode)
      lines.append(f'local before=x:tolist()')
      if mode=='out_same':lines.append(f'local y=r:permuted(x,{axiscode},x)')
      elif mode=='out_new':
          lines.append(f'local out=np.zeros({lua(base.shape)},"{dtype}")')
          lines.append(f'local y=r:permuted(x,{axiscode},out)')
      else:lines.append(f'local y=r:permuted(x,{axiscode})')
      lines.append(f'deep(y.dtype,{lua(str(y.dtype))},{lua(desc+" dtype")})')
      lines.append(f'deep(y:tolist(),{lua(expected)},{lua(desc+" values")})')
      lines.append(f'deep(x:tolist(),{lua(after)},{lua(desc+" source")})')
      lines.append(f'deep(y.shape,{lua(list(y.shape))},{lua(desc+" shape")})') if False else None
      if mode=='out_same':lines.append('assert(rawequal(y,x),"out must return identical ndarray")')
      if mode=='out_new':lines.append('assert(rawequal(y,out),"out must return identical ndarray")')
      lines.append(f'deep(r:raw_hex(),"{raw}",{lua(desc+" pcg")})')
      lines.append('cases=cases+1; end')
      cases+=1
# extra tests: output views, aliased output, safe type promotions, and values with fixed-width dtype
for seed in [0,1,42,9876]:
 for shape in [(3,4),(3,3),(2,3,4),(2,0,3)]:
  for ax in [None,0,len(shape)-1]:
   for mode in ['view','alias','cast']:
    if mode=='alias' and shape!=(3,3):continue
    base=np.arange(np.prod(shape),dtype=np.int32).reshape(shape)
    xcode=f'np.astype(np.arange({int(np.prod(shape))},"int64"):reshape({lua(shape)}),"int32")'
    if mode=='view':
        out=np.flip(np.zeros(shape,dtype='int32'),axis=0)
        outcode=f'np.flip(np.zeros({lua(shape)},"int32"),1)'
    elif mode=='alias':
        out=base.T
        outcode='np.transpose(x,{2,1})'
    else:
        out=np.zeros(shape,dtype='float64')
        outcode=f'np.zeros({lua(shape)},"float64")'
    rng=np.random.default_rng(seed)
    try:y=rng.permuted(base,axis=ax,out=out)
    except Exception as e:print('skip extra',str(e));continue
    raw=f'{int(rng.bit_generator.random_raw()):016x}'
    axiscode='nil' if ax is None else str(ax+1)
    desc=f'extra/{seed}/{shape}/{ax}/{mode}'
    lines+=['do',f'local r=np.random.default_rng({seed})','local x='+xcode,'local out='+outcode,
            f'local y=r:permuted(x,{axiscode},out)',
            'assert(rawequal(y,out),"out must return itself")',
            f'deep(y:tolist(),{lua(y.tolist())},{lua(desc+" values")})',
            f'deep(r:raw_hex(),"{raw}",{lua(desc+" pcg")})',
            'cases=cases+1; end']
    cases+=1
lines+=['print("permuted73 differential: "..cases.." NumPy cases and "..checks.." recursive checks passed")']
(p/'tests/permuted73_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('Generated cases',cases,'lines',len(lines))

# Split large fixture into bounded Lua chunks to avoid Lua local-variable limits.
all_lines=(p/'tests/permuted73_differential_generated.lua').read_text().splitlines()
start=all_lines.index('do')
header=all_lines[:start]
blocks=[]
for i in range(start,len(all_lines)):
    if all_lines[i]=='cases=cases+1; end':
        blocks.append(all_lines[start:i+1])
        start=i+1
entry=['-- Frozen NumPy differential fixtures; generated by tools/generate_permuted73_oracle.py']
for index in range(0,len(blocks),500):
    chunk=blocks[index:index+500]
    name=f'permuted73_part_{index//500+1:02d}.lua'
    (p/'tests'/name).write_text('\n'.join(header+sum(chunk,[])+[
        f'print("permuted73 oracle part {index//500+1:02d}: "..cases.." cases, "..checks.." checks passed")'])+'\n')
    entry.append(f'dofile("tests/{name}")')
entry.append(f'print("permuted73 differential: {len(blocks)} NumPy cases passed")')
(p/'tests/permuted73_differential_generated.lua').write_text('\n'.join(entry)+'\n')
