#!/usr/bin/env python3
"""Generate Lua oracle tests for indexing, scalar packing, and reshape.

Python/NumPy is development-only here.  The Lua runtime never imports Python.
The upstream NumPy source/tests remain the implementation specification.
"""
from __future__ import annotations

import math
import random
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parents[1]


def lua_scalar(x):
    if x is None:
        return "nil"
    if isinstance(x, (bool, np.bool_)):
        return "true" if bool(x) else "false"
    if isinstance(x, (float, np.floating)):
        x = float(x)
        if math.isnan(x):
            return "0/0"
        if math.isinf(x):
            return "-1/0" if x < 0 else "1/0"
        return repr(x)
    return str(int(x))


def lua_table(x):
    if isinstance(x, list):
        return "{" + ",".join(lua_table(v) for v in x) + "}"
    return lua_scalar(x)


def prelude():
    return [
        'local np=require("luaray_core")',
        'local function eq(a,b)',
        '  if type(a)~=type(b) then return false end',
        '  if type(a)~="table" then',
        '    if type(a)=="number" and a~=a and b~=b then return true end',
        '    return a==b',
        '  end',
        '  if #a~=#b then return false end',
        '  for i=1,#a do if not eq(a[i],b[i]) then return false end end',
        '  return true',
        'end',
        f'-- Generated against development NumPy {np.__version__}.',
    ]


def py_bound(v):
    if v is None:
        return None
    # Lua positive indexing is 1-based; negative indexing matches NumPy's
    # relative-from-end convention. Slice stop remains exclusive.
    return v - 1 if v > 0 else v


def lua_spec(spec):
    kind = spec[0]
    if kind == "i":
        return str(spec[1])
    if kind == "s":
        return f"np.slice({lua_scalar(spec[1])},{lua_scalar(spec[2])},{lua_scalar(spec[3])})"
    if kind == "n":
        return "np.newaxis"
    if kind == "e":
        return "np.ellipsis"
    raise AssertionError(kind)


def py_spec(spec):
    kind = spec[0]
    if kind == "i":
        return spec[1] - 1 if spec[1] > 0 else spec[1]
    if kind == "s":
        return slice(py_bound(spec[1]), py_bound(spec[2]), spec[3])
    if kind == "n":
        return None
    if kind == "e":
        return Ellipsis
    raise AssertionError(kind)


def generate_indexing():
    rng = random.Random(0xC0FFEE)
    lines = prelude()
    count = 0
    for case in range(250):
        nd = rng.randint(1, 4)
        shape = [rng.randint(0, 5) for _ in range(nd)]
        size = math.prod(shape)
        arr = np.arange(size, dtype=np.int64).reshape(shape)
        specs = []
        used = 0
        has_ellipsis = False
        for _ in range(rng.randint(0, nd + 2)):
            choices = ["n", "s"]
            if not has_ellipsis:
                choices.append("e")
            if used < nd and not has_ellipsis and shape[used] != 0:
                choices.append("i")
            kind = rng.choice(choices)
            if kind == "n":
                specs.append(("n",))
            elif kind == "e":
                specs.append(("e",))
                has_ellipsis = True
            elif kind == "i":
                dim = shape[used]
                pos = rng.randint(1, dim)
                if rng.random() < 0.35:
                    pos = -(dim - pos + 1)
                specs.append(("i", pos))
                used += 1
            else:
                vals = [None, 1, 2, -1, -2, 7, -7]
                specs.append(("s", rng.choice(vals), rng.choice(vals), rng.choice([-3, -2, -1, 1, 2, 3])))
                used += 1
        while sum(s[0] in ("i", "s") for s in specs) > nd:
            for j in range(len(specs) - 1, -1, -1):
                if specs[j][0] in ("i", "s"):
                    specs.pop(j)
                    break
        try:
            out = arr[tuple(py_spec(s) for s in specs)]
        except Exception:
            continue
        args = ",".join(lua_spec(s) for s in specs)
        if np.isscalar(out):
            lines.append(
                f"do local a=np.reshape(np.arange({size}),{lua_table(shape)}); "
                f"local got=a:get({args}); assert(got=={lua_scalar(out)},'index case {case}') end"
            )
        else:
            lines.append(
                f"do local a=np.reshape(np.arange({size}),{lua_table(shape)}); local got=a:get({args}); "
                f"assert(eq(got.shape,{lua_table(list(out.shape))}),'index case {case} shape'); "
                f"assert(eq(got.strides,{lua_table(list(out.strides))}),'index case {case} strides'); "
                f"assert(eq(got:tolist(),{lua_table(out.tolist())}),'index case {case} values') end"
            )
        count += 1
    lines.append(f"print('indexing differential: {count} cases ok')")
    out = ROOT / "tests" / "indexing_differential_generated.lua"
    out.write_text("\n".join(lines) + "\n")
    return out, count


def generate_casting():
    rng = random.Random(12345)
    dtypes = ["bool", "int8", "uint8", "int16", "uint16", "int32", "uint32", "int64", "uint64", "float16", "float32", "float64"]
    vals = [-1, 0, 1, 127, 128, 200, 255, 256, 32767, 32768, -128, -129, -32768, -32769,
            1.5, 127.9, 128.0, -128.9, -129.0, 1e20, -1e20, float("nan"), float("inf"), -float("inf")]
    lines = prelude()
    for case in range(260):
        dtype = rng.choice(dtypes)
        value = rng.choice(vals)
        try:
            with np.errstate(all="ignore"):
                arr = np.array([value], dtype=dtype)
            expected = arr[0]
            ok = True
        except Exception:
            ok = False
        expr = lua_scalar(value)
        if not ok:
            lines.append(
                f"do local ok=pcall(function() return np.array({{{expr}}},np.{dtype}) end); "
                f"assert(not ok,'cast case {case} expected error') end"
            )
            continue
        if dtype == "bool":
            check = f"got=={'true' if bool(expected) else 'false'}"
        elif np.issubdtype(arr.dtype, np.integer):
            check = f"got=={int(expected)}"
        else:
            f = float(expected)
            if math.isnan(f):
                check = "got~=got"
            elif math.isinf(f):
                check = "got==math.huge" if f > 0 else "got==-math.huge"
            elif dtype == "float32":
                check = f"math.abs(got-({f!r}))<=math.max(1e-6,math.abs({f!r})*2e-7)"
            else:
                check = f"got=={f!r}"
        lines.append(
            f"do local got=np.array({{{expr}}},np.{dtype})[1]; assert({check},'cast case {case}') end"
        )
    lines.append("print('casting differential: 260 cases ok')")
    out = ROOT / "tests" / "casting_differential_generated.lua"
    out.write_text("\n".join(lines) + "\n")
    return out, 260


def generate_reshape():
    rng = random.Random(777)
    lines = prelude()
    for case in range(180):
        nd = rng.randint(1, 4)
        shape = [rng.randint(1, 5) for _ in range(nd)]
        size = math.prod(shape)
        arr = np.arange(size, dtype=np.int64).reshape(shape)
        lua_expr = f"np.reshape(np.arange({size}),{lua_table(shape)})"
        mode = rng.randrange(3)
        if mode == 1 and nd >= 2:
            arr = arr.T
            lua_expr = f"({lua_expr}).T"
        elif mode == 2:
            py_slices, lua_slices = [], []
            for _ in shape:
                step = rng.choice([1, 1, 2, -1])
                py_slices.append(slice(None, None, step))
                lua_slices.append("np.slice()" if step == 1 else f"np.slice(nil,nil,{step})")
            arr = arr[tuple(py_slices)]
            lua_expr = f"({lua_expr}):get({','.join(lua_slices)})"
        size2 = arr.size
        if rng.randrange(3) == 0:
            target = list(arr.shape)
        elif size2 == 0:
            target = [0]
        elif rng.randrange(2) == 0:
            target = [size2]
        else:
            divisors = [d for d in range(1, size2 + 1) if size2 % d == 0]
            d = rng.choice(divisors)
            target = [d, size2 // d]
        out_arr = np.reshape(arr, target, order="C")
        lines.append(
            f"do local v={lua_expr}; local got=np.reshape(v,{lua_table(target)}); "
            f"assert(eq(got.shape,{lua_table(list(out_arr.shape))}),'reshape {case} shape'); "
            f"assert(eq(got.strides,{lua_table(list(out_arr.strides))}),'reshape {case} strides'); "
            f"assert(eq(got:tolist(),{lua_table(out_arr.tolist())}),'reshape {case} values') end"
        )
    lines.append("print('reshape differential: 180 cases ok')")
    out = ROOT / "tests" / "reshape_differential_generated.lua"
    out.write_text("\n".join(lines) + "\n")
    return out, 180


def generate_assignment():
    rng = random.Random(0xA5516E)
    lines = prelude()
    dtypes = ["bool", "int8", "uint8", "int16", "uint16", "int32", "uint32", "int64", "float16", "float32", "float64"]
    values = [-129, -128, -1, 0, 1, 2, 127, 128, 200, 255, 256,
              -128.9, 1.5, 127.9, 1e20, float("nan"), float("inf")]
    count = 0
    for case in range(240):
        nd = rng.randint(1, 4)
        shape = [rng.randint(1, 5) for _ in range(nd)]
        size = math.prod(shape)
        dtype = rng.choice(dtypes)
        arr = np.zeros(shape, dtype=dtype)
        before = arr.copy()

        specs = []
        used = 0
        has_ellipsis = False
        for _ in range(rng.randint(0, nd + 2)):
            choices = ["n", "s"]
            if not has_ellipsis:
                choices.append("e")
            if used < nd and not has_ellipsis:
                choices.append("i")
            kind = rng.choice(choices)
            if kind == "n":
                specs.append(("n",))
            elif kind == "e":
                specs.append(("e",))
                has_ellipsis = True
            elif kind == "i":
                dim = shape[used]
                pos = rng.randint(1, dim)
                if rng.random() < 0.35:
                    pos = -(dim - pos + 1)
                specs.append(("i", pos))
                used += 1
            else:
                vals = [None, 1, 2, -1, -2, 7, -7]
                specs.append(("s", rng.choice(vals), rng.choice(vals),
                              rng.choice([-3, -2, -1, 1, 2, 3])))
                used += 1
        while sum(s[0] in ("i", "s") for s in specs) > nd:
            for j in range(len(specs) - 1, -1, -1):
                if specs[j][0] in ("i", "s"):
                    specs.pop(j)
                    break

        value = rng.choice(values)
        py_idx = tuple(py_spec(s) for s in specs)
        try:
            with np.errstate(all="ignore"):
                arr[py_idx] = value
            ok = True
        except Exception:
            ok = False
            arr = before

        args = ",".join(lua_spec(s) for s in specs)
        call = f"a:set({lua_scalar(value)}" + (f",{args}" if args else "") + ")"
        initial = f"np.zeros({lua_table(shape)},np.{dtype})"
        if ok:
            lines.append(
                f"do local a={initial}; {call}; "
                f"assert(eq(a:tolist(),{lua_table(arr.tolist())}),'assignment {case} values') end"
            )
        else:
            lines.append(
                f"do local a={initial}; local before=a:tolist(); local ok=pcall(function() {call} end); "
                f"assert(not ok,'assignment {case} expected error'); "
                f"assert(eq(a:tolist(),before),'assignment {case} error mutated dst') end"
            )
        count += 1

    lines.append(f"print('assignment differential: {count} cases ok')")
    out = ROOT / "tests" / "assignment_differential_generated.lua"
    out.write_text("\n".join(lines) + "\n")
    return out, count


if __name__ == "__main__":
    for path, count in (generate_indexing(), generate_casting(), generate_reshape(), generate_assignment()):
        print(f"{path} ({count} cases)")
