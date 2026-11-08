#!/usr/bin/env python3
"""Legacy S/U <-> numeric/temporal cast/discovery differential for LuaRay 0.28.

The uploaded NumPy main tree is source truth. The installed NumPy is used only
as a behavioral serializer for cases whose upstream implementation/tests are
unchanged in the pinned snapshot.
"""
from pathlib import Path
import math
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'string_cast_differential_generated.lua'

def q(s):
    s=str(s)
    return "'"+s.replace('\\','\\\\').replace("'","\\'").replace('\n','\\n').replace('\r','\\r').replace('\t','\\t')+"'"

def lnum(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(np.complexfloating,complex)):
        z=complex(x); return f"np.complex({z.real!r},{z.imag!r})"
    x=float(x) if isinstance(x,np.floating) else x
    if isinstance(x,float):
        if math.isnan(x): return '0/0'
        if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
        return repr(x)
    return str(int(x))

def lstr_list(vals):
    out=[]
    for x in vals:
        if isinstance(x,bytes):
            out.append(q(x.decode('ascii')))
        else: out.append(q(str(x)))
    return '{'+','.join(out)+'}'

def lnum_list(vals): return '{'+','.join(lnum(x) for x in vals)+'}'

def dtype_name(dt): return str(np.dtype(dt))

lines=["local np=require('luaray_core')",r'''
local function eqnum(a,b,eps)
  eps=eps or 1e-6
  if type(a)=='number' and type(b)=='number' then
    if a~=a and b~=b then return true end
    if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
    return math.abs(a-b)<=eps*math.max(1,math.abs(a),math.abs(b))
  end
  return a==b
end
local function check_strings(a,dtype,e,label)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  assert(a.size==#e,label..' size')
  for i=1,#e do assert(a[i]==e[i],label..' value '..i..' '..tostring(a[i])..' ~= '..tostring(e[i])) end
end
local function check_numeric(a,dtype,e,label,eps)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  assert(a.size==#e,label..' size')
  for i=1,#e do assert(eqnum(a[i],e[i],eps),label..' value '..i..' '..tostring(a[i])..' ~= '..tostring(e[i])) end
end
local function check_complex(a,dtype,e,label,eps)
  eps=eps or 1e-5
  assert(a.dtype==dtype,label..' dtype')
  for i=1,#e do local z=a[i]; assert(eqnum(z.real,e[i][1],eps) and eqnum(z.imag,e[i][2],eps),label..' complex '..i) end
end
''',f"-- Development oracle NumPy {np.__version__}; exact source truth is uploaded NumPy main."]
count=0

# numeric/bool -> generic S/U, widths are descriptor-driven upstream.
numeric_cases=[
 ('bool',[True,False]),('int8',[1,-2,127]),('uint8',[0,9,255]),
 ('int16',[1,-2,32767]),('uint16',[0,42,65535]),
 ('int32',[1,-2,2147483647]),('uint32',[0,42,4294967295]),
 ('int64',[1,-2,9223372036854775807]),('uint64',[0,42,9223372036854775807]),
 ('float16',[0.0,1.5,-2.0]),('float32',[1.25,-2.5,float('inf'),float('nan')]),
 ('float64',[1.25,-2.5,float('inf'),float('-inf')]),
 ('complex64',[1+2j,-3+0j,0-2j]),('complex128',[1+2j,-3+0j,0-2j]),
]
for srcdt,vals in numeric_cases:
    a=np.array(vals,dtype=srcdt)
    for dst in ['S','U']:
        r=a.astype(dst)
        exp=[x.decode('ascii') if isinstance(x,bytes) else str(x) for x in r.tolist()]
        lines += ['do',f" local a=np.array({lnum_list(vals)},{q(srcdt)})",f" local r=a:astype({q(dst)})",f" local e={lstr_list(exp)}",f" check_strings(r,{q(str(r.dtype))},e,{q(srcdt+'->'+dst)})",'end']
        count+=1

# fixed-width destination truncation for numeric -> strings.
for srcdt,vals,dst in [
 ('int32',[-123,45],'U2'),('int32',[-123,45],'S2'),('float32',[12.5,-3.25],'U3'),
 ('complex64',[1+2j,-3+0j],'U4'),('bool',[True,False],'S3')]:
    r=np.array(vals,dtype=srcdt).astype(dst)
    exp=[x.decode('ascii') if isinstance(x,bytes) else str(x) for x in r.tolist()]
    lines += ['do',f" local r=np.astype(np.array({lnum_list(vals)},{q(srcdt)}),{q(dst)})",f" local e={lstr_list(exp)}",f" check_strings(r,{q(str(r.dtype))},e,{q('fixed '+srcdt+'->'+dst)})",'end'];count+=1

# S/U -> bool/int/float. Strings intentionally exercise spaces and underscores.
string_numeric=[
 ('U8',['','0','False',' ','x'],'bool'),
 ('S8',[b'',b'0',b'False',b' ',b'x'],'bool'),
 ('U8',['1','-2','1_000',' +7 ','01'],'int64'),
 ('S8',[b'1',b'-2',b'1_000',b' +7 ',b'01'],'int32'),
 ('U12',['1.5','-2.25','nan','INF',' 3.0 '],'float64'),
 ('S12',[b'1.5',b'-2.25',b'nan',b'INF',b' 3.0 '],'float32'),
 ('U8',['1.5','-2.25','3'],'float16'),
]
for srcdt,vals,dst in string_numeric:
    a=np.array(vals,dtype=srcdt); r=a.astype(dst)
    py=r.tolist();
    lines += ['do',f" local a=np.array({lstr_list(vals)},{q(srcdt)})",f" local r=a:astype({q(dst)})",f" local e={lnum_list(py)}",f" check_numeric(r,{q(str(r.dtype))},e,{q(srcdt+'->'+dst)},1e-3)",'end'];count+=1

# String -> complex forms.
for srcdt in ['U16','S16']:
    vals=['1+2j','(1+2j)','-3j','j','+j','-j','1_0+2_0j']
    pyvals=[v.encode() for v in vals] if srcdt.startswith('S') else vals
    for dst in ['complex64','complex128']:
        r=np.array(pyvals,dtype=srcdt).astype(dst)
        exp='{' + ','.join('{'+repr(float(complex(z).real))+','+repr(float(complex(z).imag))+'}' for z in r.tolist()) + '}'
        lines += ['do',f" local a=np.array({lstr_list(vals)},{q(srcdt)})",f" local r=a:astype({q(dst)})",f" local e={exp}",f" check_complex(r,{q(str(r.dtype))},e,{q(srcdt+'->'+dst)})",'end'];count+=1

# Expected failures from string parser.
for s,dst in [('1e2','int64'),('nan','int64'),('1+2j','float64'),('xyz','float32'),('-1','uint8')]:
    lines += ['do',f" local a=np.array({{{q(s)}}},'U8')",f" assert(not pcall(function() return a:astype({q(dst)}) end),{q('expected cast failure '+s+'->'+dst)})",'end'];count+=1

# Numeric <-> temporal casts (legacy NumPy cast semantics).
for srcdt,vals,dstdt in [
 ('int64',[1,-2],'timedelta64[D]'),('int32',[1,-2],'timedelta64[h]'),
 ('float64',[1.5,-2.25],'timedelta64[D]'),('int64',[1,-2],'datetime64[D]'),
 ('float64',[1.5,-2.25],'datetime64[h]')]:
    r=np.array(vals,dtype=srcdt).astype(dstdt)
    ints=r.view('i8').tolist()
    lines += ['do',f" local r=np.astype(np.array({lnum_list(vals)},{q(srcdt)}),{q(dstdt)})",f" assert(r.dtype=={q(str(r.dtype))},{q('time dtype '+str(count))})",f" local e={lnum_list(ints)}",f" for i=1,#e do assert(r[i].value==e[i],{q('time value '+str(count))}) end",'end'];count+=1

for srcdt,vals,dstdt in [
 ('timedelta64[D]',[1,-2],'int64'),('timedelta64[D]',[1,-2],'float64'),
 ('datetime64[D]',[1,-2],'int64'),('datetime64[D]',[1,-2],'float64')]:
    r=np.array(vals,dtype=srcdt).astype(dstdt)
    lines += ['do',f" local r=np.astype(np.array({lnum_list(vals)},{q(srcdt)}),{q(dstdt)})",f" local e={lnum_list(r.tolist())}",f" check_numeric(r,{q(str(r.dtype))},e,{q(srcdt+'->'+dstdt)})",'end'];count+=1

# Generic datetime only accepts NaT from numeric; generic timedelta accepts counts.
lines += ['do'," assert(not pcall(function() return np.astype(np.array({1},'int64'),'datetime64') end),'generic datetime numeric reject')",'end'];count+=1
lines += ['do'," local x=-9223372036854775807-1; local r=np.astype(np.array({x},'int64'),'datetime64'); assert(r[1].isnat,'generic datetime NaT')",'end'];count+=1
lines += ['do'," local r=np.astype(np.array({1,-2},'int64'),'timedelta64'); assert(r.dtype=='timedelta64' and r[1].value==1 and r[2].value==-2,'generic timedelta numeric')",'end'];count+=1

# Legacy S/U <-> datetime/timedelta.
for srcdt in ['U10','S10']:
    vals=['2011-03-16','1920-01-01','NaT']
    pvals=[v.encode() for v in vals] if srcdt.startswith('S') else vals
    r=np.array(pvals,dtype=srcdt).astype('M8')
    ints=r.view('i8').tolist()
    lines += ['do',f" local a=np.array({lstr_list(vals)},{q(srcdt)})",f" local r=a:astype('datetime64')",f" assert(r.dtype=={q(str(r.dtype))},'generic datetime inferred dtype')",f" local e={lnum_list(ints)}",f" for i=1,#e do assert(r[i].value==e[i],'generic datetime value') end",'end'];count+=1

for srcdt in ['U4','S4']:
    vals=['1','-2','NaT']; pvals=[v.encode() for v in vals] if srcdt.startswith('S') else vals
    r=np.array(pvals,dtype=srcdt).astype('m8[D]'); ints=r.view('i8').tolist()
    lines += ['do',f" local r=np.astype(np.array({lstr_list(vals)},{q(srcdt)}),'timedelta64[D]')",f" local e={lnum_list(ints)}",f" for i=1,#e do assert(r[i].value==e[i],'string timedelta') end",'end'];count+=1

for srcdt,vals in [('datetime64[D]',[1,-2]),('timedelta64[D]',[1,-2])]:
    a=np.array(vals,dtype=srcdt)
    for dst in ['S','U']:
        r=a.astype(dst); exp=[x.decode() if isinstance(x,bytes) else str(x) for x in r.tolist()]
        lines += ['do',f" local r=np.astype(np.array({lnum_list(vals)},{q(srcdt)}),{q(dst)})",f" local e={lstr_list(exp)}",f" check_strings(r,{q(str(r.dtype))},e,{q(srcdt+'->'+dst)})",'end'];count+=1

# Mixed discovery without explicit dtype follows legacy promotion to U sized by
# the discovered numeric dtype, not current value length.
mixed=[
 ([1,'x'],['1','x']),([1.25,'x'],['1.25','x']),([True,'x'],['True','x']),
 ([1+2j,'x'],['(1+2j)','x']),
]
for vals,expvals in mixed:
    a=np.array(vals)
    lua='{' + ','.join(q(v) if isinstance(v,str) else lnum(v) for v in vals) + '}'
    lines += ['do',f" local a=np.array({lua})",f" local e={lstr_list(expvals)}",f" check_strings(a,{q(str(a.dtype))},e,{q('mixed discovery '+str(count))})",'end'];count+=1

# Explicit unsized S/U uses actual formatted values, not dtype maximum width.
for vals,dst in [([1,-22],'U'),([1.25,-2.5],'S'),([True,False],'U'),([1+2j,-3+0j],'S')]:
    a=np.array(vals,dtype=dst); exp=[x.decode() if isinstance(x,bytes) else str(x) for x in a.tolist()]
    lua='{' + ','.join(lnum(v) for v in vals) + '}'
    lines += ['do',f" local a=np.array({lua},{q(dst)})",f" local e={lstr_list(exp)}",f" check_strings(a,{q(str(a.dtype))},e,{q('explicit unsized '+dst+' '+str(count))})",'end'];count+=1

lines.append(f"print('string cast/discovery differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
