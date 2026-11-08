#!/usr/bin/env python3
"""Generate Lua differential tests from a development-only NumPy oracle.

The runtime artifact never imports or invokes Python.  This script is only a
port-development harness, as permitted by the project requirements.
"""
from __future__ import annotations
import json
import random
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "tests" / "differential_generated.lua"
RNG = random.Random(20261006)
DTYPES = ["bool", "int8", "uint8", "int16", "uint16", "int32", "uint32", "int64", "uint64", "float16", "float32", "float64"]
SHAPE_PAIRS = [
    ((3,), (3,)),
    ((2, 3), (3,)),
    ((2, 1, 3), (1, 4, 1)),
    ((1, 3), (2, 1)),
    ((2, 1, 2), (1, 2, 2)),
]

def lua_val(x):
    if isinstance(x, (np.bool_, bool)):
        return "true" if bool(x) else "false"
    if isinstance(x, (np.floating, float)):
        if np.isnan(x): return "0/0"
        if np.isposinf(x): return "1/0"
        if np.isneginf(x): return "-1/0"
        return repr(float(x))
    return str(int(x))

def lua_table(obj):
    if isinstance(obj, list):
        return "{" + ",".join(lua_table(x) for x in obj) + "}"
    return lua_val(obj)

def vals(shape, dtype):
    n = int(np.prod(shape))
    dt = np.dtype(dtype)
    if dt.kind == 'b': data = [bool(RNG.randrange(2)) for _ in range(n)]
    elif dt.kind == 'u': data = [RNG.randrange(0, 6) for _ in range(n)]
    elif dt.kind == 'i': data = [RNG.randrange(-5, 6) for _ in range(n)]
    else: data = [RNG.randrange(-10, 11) / 4 for _ in range(n)]
    return np.array(data, dtype=dt).reshape(shape)

def normalized_dtype_name(dt):
    name=np.dtype(dt).name
    return "longdouble" if name in ("float96","float128") else name

lines = [
    'local np = require("luaray_core")',
    'local function same(a,b)',
    '  if type(a) ~= type(b) then return false end',
    '  if type(a) ~= "table" then',
    '    if type(a)=="number" and a~=a and b~=b then return true end',
    '    return a==b',
    '  end',
    '  if #a ~= #b then return false end',
    '  for i=1,#a do if not same(a[i],b[i]) then return false end end',
    '  return true',
    'end',
    f'-- Generated against NumPy {np.__version__}; upstream source remains primary.',
]

case = 0
for _ in range(220):
    da, db = RNG.choice(DTYPES), RNG.choice(DTYPES)
    sa, sb = RNG.choice(SHAPE_PAIRS)
    a, b = vals(sa, da), vals(sb, db)
    op = RNG.choice(["add", "multiply"])
    with np.errstate(over='ignore', invalid='ignore'):
        expected = np.add(a,b) if op == 'add' else np.multiply(a,b)
    case += 1
    la, lb = lua_table(a.tolist()), lua_table(b.tolist())
    le = lua_table(expected.tolist())
    rd = normalized_dtype_name(expected.dtype)
    sym = "+" if op == "add" else "*"
    lines += [
        f'do -- case {case}: {da}{sa} {op} {db}{sb}',
        f'  local a=np.array({la}, "{da}")',
        f'  local b=np.array({lb}, "{db}")',
        f'  local r=a {sym} b',
        f'  assert(r.dtype=="{rd}", "case {case} dtype "..r.dtype)',
        f'  assert(same(r:tolist(), {le}), "case {case} values")',
        'end',
    ]

# Weak scalar behavior cases, including range failure.
lines += [
    'do local a=np.array({1,2},"int8"); local r=a+2; assert(r.dtype=="int8" and same(r:tolist(),{3,4})) end',
    'do local ok=pcall(function() return np.array({1},"int8")+200 end); assert(not ok) end',
    'do local ok=pcall(function() return np.array({1},"uint8")+(-1) end); assert(not ok) end',
    'do local r=np.array({1,2},"float32")+2.0; assert(r.dtype=="float32") end',
    'do local r=np.array({1,2},"int32")+2.0; assert(r.dtype=="float64") end',
    f'print("differential tests: ok ({case} array-array cases)")',
]
OUT.write_text("\n".join(lines)+"\n")
print(OUT)
