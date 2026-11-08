#!/usr/bin/env python3
"""Datetime/timedelta differential coverage for LuaRay 0.25.

The uploaded NumPy main tree is the specification.  Installed NumPy is used
only as a convenient oracle for behavior shared with that tree.  Cases whose
behavior changed on main (notably timedelta sign and arithmetic overflow) are
emitted from the inspected upstream C loops/tests instead.
"""
from pathlib import Path
import numpy as np
import warnings

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'datetime_differential_generated.lua'
NAT=np.iinfo(np.int64).min

lines=["local np=require('luaray_core')", r'''
local function time_array(kind, unit, vals)
  local xs={}
  for i,v in ipairs(vals) do
    if v=='NaT' then
      xs[i]=(kind=='M') and np.datetime64('NaT',unit) or np.timedelta64('NaT',unit)
    else
      xs[i]=(kind=='M') and np.datetime64(v,unit) or np.timedelta64(v,unit)
    end
  end
  local root=(kind=='M') and 'datetime64' or 'timedelta64'
  return np.array(xs, root..'['..unit..']')
end
local function assert_time(a,dtype,vals,label)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  assert(a.size==#vals,label..' size')
  for i,v in ipairs(vals) do
    local x=a[i]
    assert(x.dtype==dtype,label..' scalar dtype '..i..' '..x.dtype)
    if v=='NaT' then assert(x.isnat,label..' expected NaT '..i)
    else assert(not x.isnat and x.value==v,label..' value '..i..' '..tostring(x.value)..' ~= '..tostring(v)) end
  end
end
local function assert_plain(a,dtype,vals,label)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  local got=a:tolist()
  assert(#got==#vals,label..' size')
  for i,v in ipairs(vals) do
    if v~=v then assert(got[i]~=got[i],label..' nan '..i)
    else assert(got[i]==v,label..' value '..i..' '..tostring(got[i])..' ~= '..tostring(v)) end
  end
end
''', f"-- Development oracle NumPy {np.__version__}; exact source truth is uploaded NumPy main."]
count=0

def q(s):
    return "'"+s.replace("'","\\'")+"'"

def rawvals(a):
    arr=np.asarray(a)
    if arr.dtype.kind in 'Mm':
        r=arr.astype('int64')
        return ['NaT' if int(x)==NAT else int(x) for x in r.reshape(-1)]
    return arr.reshape(-1).tolist()

def lua_vals(vals):
    parts=[]
    for v in vals:
        if v=='NaT': parts.append("'NaT'")
        elif isinstance(v,(bool,np.bool_)): parts.append('true' if bool(v) else 'false')
        elif isinstance(v,(float,np.floating)) and np.isnan(v): parts.append('(0/0)')
        else: parts.append(repr(int(v)) if isinstance(v,(np.integer,int)) else repr(float(v)))
    return '{'+','.join(parts)+'}'

def emit_time_bin(op,k1,u1,vals1,k2,u2,vals2):
    global count
    a=np.array(vals1,dtype=f'{k1}8[{u1}]')
    b=np.array(vals2,dtype=f'{k2}8[{u2}]')
    try:
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); r=getattr(np,op)(a,b)
    except Exception:
        lines.extend(['do',
          f" local a=time_array({q(k1)},{q(u1)},{lua_vals(rawvals(a))})",
          f" local b=time_array({q(k2)},{q(u2)},{lua_vals(rawvals(b))})",
          f" assert(not pcall(function() return np.{op}(a,b) end),'dt reject {count}')",
          'end'])
        count+=1; return
    rd=str(r.dtype); rv=rawvals(r)
    lines.extend(['do',
      f" local a=time_array({q(k1)},{q(u1)},{lua_vals(rawvals(a))})",
      f" local b=time_array({q(k2)},{q(u2)},{lua_vals(rawvals(b))})",
      f" local r=np.{op}(a,b)"])
    if r.dtype.kind in 'Mm': lines.append(f" assert_time(r,{q(rd)},{lua_vals(rv)},'dt bin {count}')")
    else: lines.append(f" assert_plain(r,{q(str(r.dtype))},{lua_vals(rv)},'dt bin {count}')")
    lines.append('end'); count+=1

# Arithmetic across metadata, including descriptor-only casts (same type_num).
arith_cases=[
 ('add','M','D',[1,2,'NaT'],'m','h',[24,48,1]),
 ('add','m','h',[24,48,'NaT'],'M','D',[1,2,3]),
 ('add','m','2D',[1,-2,'NaT'],'m','3D',[2,1,4]),
 ('add','M','W',[1,2,3],'m','D',[1,-2,4]),
 ('add','M','Y',[1,2,3],'m','M',[6,-12,3]),
 ('subtract','M','D',[2,4,'NaT'],'m','h',[24,12,1]),
 ('subtract','M','D',[2,4,'NaT'],'M','h',[24,48,1]),
 ('subtract','m','2D',[3,-1,'NaT'],'m','3D',[1,2,4]),
 ('subtract','M','Y',[2,4,6],'M','M',[12,24,18]),
]
for c in arith_cases: emit_time_bin(*c)
# Nonlinear timedelta promotion must reject.
emit_time_bin('add','m','Y',[1,2],'m','D',[1,2])
emit_time_bin('subtract','m','M',[1,2],'m','W',[1,2])

# Descriptor-resolution matrix.  Zero payloads avoid overflow so this isolates
# metadata promotion itself across every NumPy datetime base unit.
units=['Y','M','W','D','h','m','s','ms','us','ns','ps','fs','as']
for u1 in units:
    for u2 in units:
        # datetime subtraction is deliberately more permissive across nonlinear units
        emit_time_bin('subtract','M',u1,[0],'M',u2,[0])
        # timedelta addition exercises the strict Y/M vs linear-unit barrier
        emit_time_bin('add','m',u1,[0],'m',u2,[0])

# Comparisons: same class only, metadata converted to common instance, NaT rules.
for op in ['equal','not_equal','less','less_equal','greater','greater_equal']:
    emit_time_bin(op,'M','D',[1,2,'NaT',4],'M','h',[24,49,72,'NaT'])
    emit_time_bin(op,'m','2D',[1,-1,'NaT',3],'m','h',[48,-24,1,'NaT'])
# Cross datetime/timedelta comparisons are invalid on exact main.
for op in ['equal','less']:
    emit_time_bin(op,'M','D',[1,2],'m','D',[1,2])

# min/max family has dedicated datetime loops in upstream.  maximum/minimum
# propagate NaT; fmax/fmin ignore NaT in favor of the finite operand.
for op in ['maximum','minimum','fmax','fmin']:
    emit_time_bin(op,'M','D',[1,'NaT',4,3],'M','h',[48,72,'NaT',95])
    emit_time_bin(op,'m','D',[1,'NaT',-2,4],'m','h',[48,72,'NaT',12])

# Unary operations.  sign is source-derived because local 2.3.5 still has old behavior.
unary_cases=[
 ('negative','h',[1,-2,'NaT',0]),('positive','2D',[1,-2,'NaT',0]),('absolute','m',[1,-2,'NaT',0])
]
for op,u,vals in unary_cases:
    a=np.array(vals,dtype=f'm8[{u}]')
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');r=getattr(np,op)(a)
    lines += ['do',f" local a=time_array('m',{q(u)},{lua_vals(rawvals(a))})",f" local r=np.{op}(a)",
              f" assert_time(r,{q(str(r.dtype))},{lua_vals(rawvals(r))},'dt unary {count}')",'end'];count+=1
# exact NumPy main TIMEDELTA_sign loop: output double, NaT -> NaN.
lines += ['do'," local a=time_array('m','h',{1,-2,0,'NaT'})"," local r=np.sign(a)",
          f" assert_plain(r,'float64',{{1.0,-1.0,0.0,0/0}},'dt unary {count}')",'end'];count+=1
for op,k in [('isnat','M'),('isnat','m'),('isfinite','M'),('isfinite','m')]:
    u='D'; a=np.array([1,'NaT',-2],dtype=f'{k}8[{u}]')
    r=np.isnat(a) if op=='isnat' else np.isfinite(a)
    lines += ['do',f" local a=time_array({q(k)},{q(u)},{lua_vals(rawvals(a))})",f" local r=np.{op}(a)",
              f" assert_plain(r,'bool',{lua_vals(rawvals(r))},'dt unary {count}')",'end'];count+=1

# out= + where= with output descriptor different from natural result, exercising same-kind metadata casts.
# Natural D+h result is h; write active positions to datetime64[D] using floor conversion.
lines += ['do',
 " local a=time_array('M','D',{1,2,3,4})",
 " local b=time_array('m','h',{12,24,36,48})",
 " local o=time_array('M','D',{90,80,70,60})",
 " local w=np.array({true,false,true,false},np.bool)",
 " local r=np.add(a,b,{out=o,where=w})",
 " assert(r==o,'dt out identity')",
 f" assert_time(o,'datetime64[D]',{{1,80,4,60}},'dt out {count}')",'end'];count+=1
# where false must suppress an otherwise-overflowing element.
MAX=9223372036854775807
lines += ['do',
 f" local a=time_array('m','ns',{{{MAX},5}})",
 " local b=time_array('m','ns',{1,2})",
 " local o=time_array('m','ns',{77,88})",
 " local w=np.array({false,true},np.bool)",
 " local r=np.add(a,b,{out=o,where=w})",
 " assert(r==o,'dt masked overflow out identity')",
 f" assert_time(o,'timedelta64[ns]',{{77,7}},'dt masked overflow {count}')",'end'];count+=1

# Source-derived overflow boundary behavior from NumPy main loops.
# max-1 + 1 is valid; max + 1 overflows; -max + -1 would land on NaT sentinel and must overflow.
lines += ['do',
 f" local a=time_array('m','ns',{{{MAX-1}}})", " local b=time_array('m','ns',{1})", " local r=np.add(a,b)",
 f" assert_time(r,'timedelta64[ns]',{{{MAX}}},'dt boundary {count}')",'end'];count+=1
lines += ['do',f" local a=time_array('m','ns',{{{MAX}}})"," local b=time_array('m','ns',{1})",
          f" assert(not pcall(function() return np.add(a,b) end),'dt overflow {count}')",'end'];count+=1
lines += ['do',f" local a=time_array('m','ns',{{{-MAX}}})"," local b=time_array('m','ns',{-1})",
          f" assert(not pcall(function() return np.add(a,b) end),'dt NaT-sentinel overflow {count}')",'end'];count+=1
# NaT short-circuits overflow checking.
lines += ['do'," local a=time_array('m','ns',{'NaT'})",f" local b=time_array('m','ns',{{{MAX}}})"," local r=np.add(a,b)",
          f" assert_time(r,'timedelta64[ns]',{{'NaT'}},'dt NaT arithmetic {count}')",'end'];count+=1

# Scalar indexing preserves the full concrete descriptor (including multipliers).
lines += ['do'," local a=time_array('M','2D',{3,'NaT'})"," assert(a[1].dtype=='datetime64[2D]' and a[1].value==3,'dt scalar descriptor')",
          " assert(a[2].dtype=='datetime64[2D]' and a[2].isnat,'dt scalar NaT descriptor')",'end'];count+=1

lines.append(f"print('datetime differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
