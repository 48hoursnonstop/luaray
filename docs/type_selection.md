---
docs_examples: true
---
# Classifying and selecting types

`lr.isdtype(dtype, kind)` tests an actual dtype descriptor against a scalar
class or a named category. `lr.common_type(...)` chooses an inexact dtype from
ndarrays. It returns a descriptor that can be passed to array constructors.

```lua
local lr = require("luaray")
local single = lr.dtype("float32")
assert(lr.isdtype(single, "real floating"))
assert(not lr.isdtype(single, "integral"))
local selected = lr.common_type(lr.ones({2}, "float32"), lr.ones({2}, "int16"))
assert(selected == lr.dtype("float64"))
```

## Categories

The recognized names are `bool`, `signed integer`, `unsigned integer`,
`integral`, `real floating`, `complex floating`, and `numeric`. Integral includes
signed and unsigned integers. Numeric includes integers and real/complex floats;
it excludes Boolean, text, datetime and timedelta formats.

```lua
assert(lr.isdtype(lr.dtype("uint64"), "integral"))
assert(lr.isdtype(lr.dtype("complex64"), "numeric"))
assert(not lr.isdtype(lr.dtype("bool"), "numeric"))
assert(not lr.isdtype(lr.dtype("timedelta64[h]"), "integral"))
```

## Scalar classes versus equivalent storage

A descriptor selector compares scalar classes. It ignores fixed-width string
lengths and temporal units, as the pinned source does. Equal storage width does
not imply the same class: on the tested Linux host, int64 and longlong use
different scalar classes. This differs from descriptor equality.

```lua
assert(lr.isdtype(lr.dtype("S3"), lr.dtype("S8")))
assert(lr.isdtype(lr.dtype("datetime64[D]"), lr.dtype("datetime64[ns]")))
assert(lr.dtype("int64") == lr.dtype("longlong"))
assert(not lr.isdtype(lr.dtype("int64"), lr.dtype("longlong")))
```

The first argument must be a descriptor: use `lr.dtype(values.dtype)` for an
array. A string selector means a category, never a dtype name; use a descriptor
when selecting a concrete type. Supported dtype aliases follow the existing
constructor, with the same foreign/endian limitations.

## Several selectors

A dense Lua sequence represents the source tuple. The result is true when any
selector matches; an empty sequence gives false. All entries are validated,
including entries after a match. Nested sequences and unknown categories raise
errors. Lua nil cannot be an element of a dense selector sequence.

```lua
local single = lr.dtype("float32")
assert(lr.isdtype(single, {"integral", "real floating"}))
assert(not lr.isdtype(single, {}))
assert(not pcall(lr.isdtype, single, {"real floating", "invalid"}))
assert(not pcall(lr.isdtype, "float32", "numeric"))
assert(not pcall(lr.isdtype, single, "float32"))
```

## Common inexact precision

`common_type` chooses among float16, float32, float64 and longdouble, or the
corresponding complex format when any argument is complex. Integer inputs force
at least float64; float32 mixed with complex64 remains complex64 unless another
argument needs wider precision. It examines dtype metadata rather than values,
so shape, emptiness, strides and writability do not affect the result.

```lua
local half = lr.ones({2}, "float16")
local single = lr.ones({2}, "float32")
local complex = lr.ones({2}, "complex64")
assert(lr.common_type(half) == lr.dtype("float16"))
assert(lr.common_type(single, complex) == lr.dtype("complex64"))
assert(lr.common_type(complex, lr.empty({0}, "int8")) == lr.dtype("complex128"))
assert(lr.common_type() == lr.dtype("float16"))
```

The zero-argument float16 result follows the source. Boolean, text and datetime
arrays are rejected. Timedelta follows a distinct source rule: its scalar class
is an integer subclass for `common_type`, so it selects at least float64, even
though `isdtype` excludes it from the integral/numeric categories.

```lua
local duration = lr.zeros({0}, "timedelta64[h]")
assert(lr.common_type(duration) == lr.dtype("float64"))
assert(not lr.isdtype(lr.dtype(duration.dtype), "numeric"))
assert(not pcall(lr.common_type, lr.zeros({0}, "bool")))
assert(not pcall(lr.common_type, {1, 2}))
```

The Lua common-type result is a descriptor rather than a Python scalar class.
Arguments must be actual ndarrays; Python scalar instances, subclass/foreign
dispatch, structured/object/variable StringDType and every ABI are not certified.
The APIs remain classified as partially compatible.

## 0.161.0-dev verification

Type classification and selection passed **5,468 cases /18,625 checks** against NumPy2.5.4:4,320 valid inputs and1,148 expected rejections. Another39 permanent Lua checks, a native harness and C++ header/link execution passed. Exact checks cover scalar classes/categories, complete selector validation, empty/invalid tuples, inexact precision, duration subclass rules and input states. Dense Lua sequences represent source tuples; common-type results are dtype descriptors. Both corpora regenerated exactly.

