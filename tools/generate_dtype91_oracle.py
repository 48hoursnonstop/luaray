#!/usr/bin/env python3
"""Frozen 0.91 native dtype-promotion oracle from executable NumPy 2.3.5.

NumPy is needed to regenerate this fixture, not to execute LuaRay or run tests.
"""
import itertools
from pathlib import Path
import numpy as np
root=Path(__file__).resolve().parents[1]
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64','complex64','complex128']
weak=[('true',True),('4',4),('4.25',4.25),('np.complex(2,3)',2+3j)]
lines=["local np=require('luaray_core')", "assert(np._version=='0.91.0-dev')", "local count=0", "local function eq(a,b) assert(a==b, 'case '..count..' '..tostring(a)..' ~= '..tostring(b)) count=count+1 end"]
for a,b in itertools.product(dtypes, repeat=2):
    expected=np.promote_types(a,b).name
    lines.append(f'eq(np.promote_types("{a}","{b}"),"{expected}")')
for a,b,c in itertools.product(dtypes,repeat=3):
    expected=np.result_type(np.dtype(a),np.dtype(b),np.dtype(c)).name
    lines.append(f'eq(np.result_type("{a}","{b}","{c}"),"{expected}")')
for a in dtypes:
    lines.append(f'eq(np.result_type(np.array({{1}},"{a}")),"{np.result_type(np.array([1],dtype=a)).name}")')
    for expr,val in weak:
        expected=np.result_type(np.dtype(a),val).name
        lines.append(f'eq(np.result_type("{a}",{expr}),"{expected}")')
        lines.append(f'eq(np.result_type(np.array({{1}},"{a}"),{expr}),"{expected}")')
        lines.append(f'eq(np.result_type({expr},"{a}"),"{expected}")')
        lines.append(f'eq(np.result_type("{a}","{a}",{expr}),"{expected}")')
        lines.append(f'eq(np.result_type("{a}",{expr},"{a}"),"{expected}")')
# Parametric/string/date DType pairs are exercised separately; output is a
# canonical LuaRay dtype descriptor name (not NumPy's dtype.name alias).
parametric=['S3','S8','U2','U5','datetime64[D]','datetime64[s]','timedelta64[h]','timedelta64[D]']
def canonical(d):
 if d.kind=='U':return f'<U{d.itemsize//4}'
 if d.kind=='S':return f'|S{d.itemsize}'
 return d.name
for a,b in itertools.product(parametric+dtypes[:3],repeat=2):
 for fn in ['promote_types','result_type']:
  try: result=canonical(getattr(np,fn)(a,b) if fn=='promote_types' else np.result_type(np.dtype(a),np.dtype(b)))
  except (TypeError,ValueError):
   lines.append(f'assert(not pcall(function() np.{fn}("{a}","{b}") end))')
  else:
   lines.append(f'eq(np.{fn}("{a}","{b}"),"{result}")')
for a in weak:
 for b in weak:
  expected=np.result_type(a[1],b[1]).name
  lines.append(f'eq(np.result_type({a[0]},{b[0]}),"{expected}")')
for vals in itertools.product(range(4),repeat=3):
  w=[weak[x] for x in vals]
  expected=np.result_type(*[x[1] for x in w]).name
  lines.append(f'eq(np.result_type({w[0][0]},{w[1][0]},{w[2][0]}),"{expected}")')
lines.extend([
 "assert(not pcall(function()np.promote_types('nope','float32')end))",
 "assert(not pcall(function()np.promote_types('int8',8)end))",
 "assert(not pcall(function()np.result_type()end))",
 "assert(not pcall(function()np.result_type({})end))",
 "assert(not pcall(function()np.result_type('unknown')end))",
 "print('dtype91 differential: '..count..' comparisons passed')"
])
path=root/'tests'/'dtype91_differential_generated.lua'
path.write_text('\n'.join(lines)+'\n')
print(path,len(lines),'checks',len(lines)-10)
