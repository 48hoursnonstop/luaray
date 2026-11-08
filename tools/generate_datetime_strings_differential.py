#!/usr/bin/env python3
"""ISO datetime parsing/formatting differential for LuaRay 0.26.

Source truth: uploaded NumPy main datetime_strings.c + test_datetime.py.
Installed NumPy is used only to serialize expectations for unchanged cases.
"""
from pathlib import Path
import warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'datetime_strings_differential_generated.lua'
NAT=np.iinfo(np.int64).min

def q(s): return "'"+str(s).replace('\\','\\\\').replace("'","\\'")+"'"

def scalar_value(x): return int(x.astype('int64'))

lines=["local np=require('luaray_core')", r'''
local function check_scalar(s, unit, dtype, value, iso, label)
  local x
  if unit==nil then x=np.datetime64(s) else x=np.datetime64(s,unit) end
  assert(x.dtype==dtype,label..' dtype '..x.dtype..' ~= '..dtype)
  if value == -9223372036854775808 then assert(x.isnat,label..' expected NaT')
  else assert(not x.isnat and x.value==value,label..' value '..tostring(x.value)..' ~= '..tostring(value)) end
  assert(tostring(x)==iso,label..' iso '..tostring(x)..' ~= '..iso)
end
''', f"-- Development oracle NumPy {np.__version__}; exact source truth is uploaded NumPy main."]
count=0

# Unit inference exactly follows NpyDatetime_ParseISO8601Datetime bestunit.
infer=[
 '2010','2010-03','2010-03-15','2010-03-15T12','2010-03-15T12:30','2010-03-15T12:30:45',
 '2010-03-15T12:30:45.1','2010-03-15T12:30:45.123','2010-03-15T12:30:45.1234',
 '2010-03-15T12:30:45.123456','2010-03-15T12:30:45.1234567','2010-03-15T12:30:45.123456789',
 '1970-01-01T00:00:00.123456789012','1970-01-01T00:00:00.123456789012345',
 '1970-01-01T00:00:05.789012345678901234','1969-12-31T23:34:56.789012345678901234',
 '-1980-02-29','+10000-01-01T00','NaT',''
]
for s in infer:
    with warnings.catch_warnings():
        warnings.simplefilter('ignore'); x=np.datetime64(s)
    dtype=str(x.dtype); val=scalar_value(x); iso=str(x)
    lines.append(f"check_scalar({q(s)},nil,{q(dtype)},{val},{q(iso)},{q('infer '+str(count))})")
    count+=1

# Explicit target units: constructor truncation/wrap follows upstream conversion.
explicit_strings=['2010-03-15T12:30:45.123456789','1969-12-31T23:59:59.999999999','2032-07-18T12:23:34.123456','-0044-03-15T12:00:00']
units=['Y','M','W','D','h','m','s','ms','us','ns','ps','fs','as']
for s in explicit_strings:
    for u in units:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            try: x=np.datetime64(s,u)
            except Exception: continue
        lines.append(f"check_scalar({q(s)},{q(u)},{q(str(x.dtype))},{scalar_value(x)},{q(str(x))},{q('explicit '+str(count))})")
        count+=1

# Parser variants copied from upstream test_string_parser_variants.
variants=[
 ('1980-02-29 01:02:03','s'),('+1980-02-29 01:02:03','s'),('-1980-02-29 01:02:03','s'),
 ('+1980-02-29 01:02:03Z','s'),('-1980-02-29 01:02:03Z','s'),
 ('1980-02-29 00:32:03-0130','s'),('1980-02-29 00:02:03+01:30','s'),
 ('1980-02-29 00:32:03.506-02','ms'),('1977-03-02T12:30-0230','m'),
 ('  2010-01-02T03:04:05  ','s')
]
for s,u in variants:
    with warnings.catch_warnings():
        warnings.simplefilter('ignore'); x=np.datetime64(s,u)
    lines.append(f"check_scalar({q(s)},{q(u)},{q(str(x.dtype))},{scalar_value(x)},{q(str(x))},{q('variant '+str(count))})")
    count+=1

# String arrays into an explicit datetime dtype.
arr_cases=[
 ('s',['1980-02-29T01:02:03','1980-02-29 00:02:03+01:30','NaT']),
 ('D',['1970-01-01','1969-12-31','2000-02-29','1900-02-28']),
 ('ns',['2010-01-01T00:00:00.123456789','2010-01-01T00:00:00.000000001'])
]
for u,vals in arr_cases:
    with warnings.catch_warnings():
        warnings.simplefilter('ignore'); a=np.array(vals,dtype=f'M8[{u}]')
    raw=[int(v) for v in a.astype('int64')]
    tbl='{'+','.join(q(v) for v in vals)+'}'
    rv='{'+','.join(str(v) for v in raw)+'}'
    lines += ['do',f" local a=np.array({tbl},{q(str(a.dtype))})",f" local expected={rv}",
              f" assert(a.dtype=={q(str(a.dtype))},{q('array dtype '+str(count))})",
              " for i=1,#expected do assert(a[i].value==expected[i] or (a[i].isnat and expected[i]==-9223372036854775808),'array parse '..i) end",'end']
    count+=1

# Generic datetime64 dtype discovery across strings, matching NumPy descriptor discovery.
for vals,edtype,eraw in [
    (['2010','2010-01-02'],'datetime64[D]',[14610,14611]),
    (['2010-01','2010-01-02T03:04'],'datetime64[m]',[21038400,21040024]),
]:
    tbl='{'+','.join(q(v) for v in vals)+'}'
    rv='{'+','.join(str(v) for v in eraw)+'}'
    lines += ['do',f" local a=np.array({tbl},'datetime64')",f" local expected={rv}",
              f" assert(a.dtype=={q(edtype)},{q('generic discovery '+str(count))})",
              " for i=1,#expected do assert(a[i].value==expected[i],'generic discovery value '..i) end",'end']
    count+=1

# Formatting: exact upstream test_datetime_as_string unit matrix.
fmt_inputs=[
 ('1959-10-13','Y'),('1959-10-13','M'),('1959-10-13','D'),
 ('1959-10-13T12:34:56.789012345678901234','h'),('1959-10-13T12:34:56.789012345678901234','m'),
 ('1959-10-13T12:34:56.789012345678901234','s'),('1959-10-13T12:34:56.789012345678901234','ms'),
 ('1959-10-13T12:34:56.789012345678901234','us'),
 ('1969-12-31T23:34:56.789012345678901234','ns'),('1969-12-31T23:34:56.789012345678901234','ps'),('1969-12-31T23:34:56.789012345678901234','fs'),
 ('1970-01-01T00:00:05.789012345678901234','as')]
for s,u in fmt_inputs:
    x=np.datetime64(s,u); expected=np.datetime_as_string(x)
    lines += ['do',f" local x=np.datetime64({q(s)},{q(u)})",f" assert(np.datetime_as_string(x)=={q(str(expected))},{q('fmt default '+str(count))})",'end']
    count+=1

x=np.datetime64('2032-07-18T12:23:34.123456','us')
for u in ['Y','M','W','D','h','m','s','ms','us','ns','ps','fs','as']:
    expected=np.datetime_as_string(x,unit=u,casting='unsafe')
    lines += ['do'," local x=np.datetime64('2032-07-18T12:23:34.123456','us')",
              f" assert(np.datetime_as_string(x,{{unit={q(u)},casting='unsafe'}})=={q(str(expected))},{q('fmt unit '+str(count))})",'end']
    count+=1
for s in ['2032-07-18T12:23:34.123456','2032-07-18T12:23:34.12','2032-07-18T12:23:34','2032-07-18T12:23:00','2032-07-18T12:00:00','2032-07-18T00:00:00','2032-07-01T00:00:00','2032-01-01T00:00:00']:
    x=np.datetime64(s,'us');expected=np.datetime_as_string(x,unit='auto')
    lines += ['do',f" local x=np.datetime64({q(s)},'us')",f" assert(np.datetime_as_string(x,{{unit='auto'}})=={q(str(expected))},{q('fmt auto '+str(count))})",'end'];count+=1
# UTC suffix.
x=np.datetime64('2010-03-15T06:30','m');expected=np.datetime_as_string(x,timezone='UTC')
lines += ['do'," local x=np.datetime64('2010-03-15T06:30','m')",f" assert(np.datetime_as_string(x,{{timezone='UTC'}})=={q(str(expected))},{q('fmt UTC '+str(count))})",'end'];count+=1
# Lua-native integer offset analogue of NumPy TZInfo path: -300 = UTC-05:00.
lines += ['do'," local x=np.datetime64('2010-03-15T06:30','m')",
          f" assert(np.datetime_as_string(x,{{timezone=-300}})=='2010-03-15T01:30-0500',{q('fmt numeric offset '+str(count))})",'end'];count+=1
# same_value and safe must reject precision loss; same_kind allows it.
lines += ['do'," local x=np.datetime64('2032-07-18T12:23:34.123456','us')",
          f" assert(not pcall(function() return np.datetime_as_string(x,{{unit='Y',casting='same_value'}}) end),{q('same_value reject '+str(count))})",'end'];count+=1
lines += ['do'," local x=np.datetime64('2032-07-18T12:23:34.123456','us')",
          f" assert(not pcall(function() return np.datetime_as_string(x,{{unit='Y',casting='safe'}}) end),{q('safe reject '+str(count))})",'end'];count+=1

# Error corpus adapted directly from upstream test_string_parser_error_check.
bad=[
 'badvalue','1980X','1980-','1980-00','1980-13','1980-1','1980-1-02','1980-Mor','1980-01-',
 '1980-01-0','1980-01-00','1980-01-32','1979-02-29','1980-02-30','1980-03-32','1980-04-31','1980-05-32','1980-06-31','1980-07-32','1980-08-32','1980-09-31','1980-10-32','1980-11-31','1980-12-32',
 '1980-02-03%','1980-02-03 q','1980-02-03 25','1980-02-03T25','1980-02-03 24:01','1980-02-03T24:01','1980-02-03 -1','1980-02-03 01:','1980-02-03 01:-1','1980-02-03 01:60','1980-02-03 01:02:','1980-02-03 01:02:-1','1980-02-03 01:02:60',
 '1980-02-03T01:02:03.1234567890123456789','1980-02-03T01:02:03+25','1980-02-03T01:02:03+01:60','1980-02-03T01:02:03Zx'
]
for s in bad:
    lines += ['do',f" assert(not pcall(function() return np.datetime64({q(s)},'us') end),{q('bad parser '+str(count))})",'end'];count+=1

lines.append(f"print('datetime strings differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
