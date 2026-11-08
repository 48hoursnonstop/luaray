#!/usr/bin/env python3
"""Freeze NumPy 2.3.5-oracle dtype promotion/copy behavior into Lua tests.
Only run during development: the resulting Lua fixture has no Python dependency.
"""
from pathlib import Path
import numpy as np

root=Path(__file__).resolve().parents[1]
out=root/'tests/promotion_differential_generated.lua'
lines=["local np=require('luaray_core')", "local n=0", "local function verify(got, dtype, expected)",
       "  assert(got.dtype:gsub('^[<>|=]','') == dtype, tostring(got.dtype)..' != '..dtype)",
       "  local result=got:tolist()", "  local function walk(a,b)",
       "    if type(b)=='table' then assert(type(a)=='table' and #a==#b); for i,v in ipairs(b) do walk(a[i],v) end",
       "    else assert(a==b,tostring(a)..' != '..tostring(b)) end", "  end",
       "  walk(result,expected)", "end"]

def q(s):
    return '"'+str(s).replace('\\','\\\\').replace('"','\\"').replace('\n','\\n')+'"'

def lit(v):
    if isinstance(v,(np.bool_,bool)):return 'true' if v else 'false'
    if isinstance(v,(np.integer,int)):return str(int(v))
    if isinstance(v,(np.complexfloating,complex)):
        return f'np.complex({lit(v.real)},{lit(v.imag)})'
    if isinstance(v,(np.floating,float)):return repr(float(v))
    if isinstance(v,str):return q(v)
    if isinstance(v,bytes):return q(v.decode('utf8'))
    if isinstance(v,(list,tuple)):return '{'+','.join(map(lit,v))+'}'
    raise ValueError(type(v))

def name(dtype):
    dtype=np.dtype(dtype)
    return f'{dtype.kind}{dtype.itemsize//(4 if dtype.kind=="U" else 1)}' if dtype.kind in ('S','U') else dtype.name

samples={
    'bool':[True,False],
    'int8':[-3,17], 'uint8':[3,17],
    'int16':[-3,17], 'uint16':[3,17],
    'int32':[-3,17], 'uint32':[3,17],
    'int64':[-3,17], 'uint64':[3,17],
    'float16':[-1.5,2.25], 'float32':[-1.5,2.25], 'float64':[-1.5,2.25],
    'complex64':[2+3j,-1+0j], 'complex128':[2+3j,-1+0j]
}
count=0; valid=0; rejected=0
for ndt,nums in samples.items():
 for st in ('S','U'):
  for width in (1,3,8):
   sd=f'{st}{width}'
   strings=['x','é' if st=='U' else 'yz']
   for reverse in (False,True):
    for operation in ('concatenate','stack'):
     for shape in ((2,),(1,2),(2,1)):
      for axis in (0,-1):
       # Rebuild arguments independently; all have matching shapes.
       na=np.array(nums,dtype=ndt).reshape(shape)
       sa=np.array(strings,dtype=sd).reshape(shape)
       args=(sa,na) if reverse else (na,sa)
       try:
        result=getattr(np,operation)(args,axis=axis)
        error=None
       except (ValueError,TypeError) as exc:
        error=type(exc).__name__
       es=[f'np.reshape(np.array({lit(values)},{q(dtype)}),{lit(shape)})'
           for values,dtype in ((strings,sd),(nums,ndt)) if False]
       n_expr=f'np.reshape(np.array({lit(nums)},{q(ndt)}),{lit(shape)})'
       s_expr=f'np.reshape(np.array({lit(strings)},{q(sd)}),{lit(shape)})'
       seq=(s_expr,n_expr) if reverse else (n_expr,s_expr)
       # Python axes -> Lua axes are +1 for nonnegative, unchanged if negative.
       laxis=axis if axis<0 else axis+1
       call=f'np.{operation}({{{seq[0]},{seq[1]}}},{{axis={laxis}}})'
       count+=1
       lines.extend([f'-- case {count}: {ndt} + {sd}, {operation}, shape {shape}, axis {axis}, reverse={reverse}', 'do'])
       if error:
        rejected+=1
        lines.extend([f'  local ok=pcall(function() return {call} end)',
                      '  assert(not ok,"expected NumPy rejection")'])
       else:
        valid+=1
        lines.extend([f'  local r={call}',
                      f'  verify(r,{q(name(result.dtype))},{lit(result.tolist())})'])
       lines.extend(['  n=n+1','end'])
# no promotion available between datetime and strings
for d in ('datetime64[D]','timedelta64[s]'):
 for sd in ('S2','U3'):
  count+=1;rejected+=1
  expr=f'np.concatenate({{np.array({{1,2}},{q(d)}),np.array({{"x","y"}},{q(sd)})}})'
  lines.extend(['do',f'  local ok=pcall(function() return {expr} end)', '  assert(not ok,"unsupported temporal/text promotion")','  n=n+1','end'])
lines.append(f"assert(n=={count});print('promotion differential: '..n..' cases ok')")
out.write_text('\n'.join(lines)+'\n')
print('generated',count,'valid',valid,'expected rejected',rejected,'at',out)
