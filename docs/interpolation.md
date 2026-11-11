---
docs_examples: true
---
# Linear interpolation

`lr.interp(x, xp, fp, options)` estimates values between one-dimensional sample
points. `xp` supplies coordinates and `fp` supplies corresponding real or complex
values. Queries can have any shape; the output keeps that shape.

## Samples and queries

```lua
local lr = require("luaray")
local values = lr.interp({-0.5, 0.5, 1.5, 3}, {0, 1, 2}, {0, 2, 3})
assert(values[1] == 0 and values[2] == 1)
assert(values[3] == 2.5 and values[4] == 3)
local scalar = lr.interp(0.5, {0, 1}, {0, 2})
assert(scalar.ndim == 0 and scalar:tolist() == 1)
```

Sample points and values must be one-dimensional and have equal lengths. Without
`period`, supply increasing sample coordinates. The function follows the source's
search behavior rather than validating or sorting a nonperiodic grid. Exact
sample queries return their sample value directly, avoiding nonfinite slope math.
A scalar query returns a typed rank-zero ndarray.

## Boundaries

```lua
local filled = lr.interp({-1, 3}, {0, 1, 2}, {0, 2, 3}, {left=-7, right=9})
assert(filled[1] == -7 and filled[2] == 9)
```

| Option | Default | Meaning |
| --- | --- | --- |
| `left` | First sample value | Value below the sample range. |
| `right` | Last sample value | Value above the sample range. |
| `period` | Omitted | Normalize and sort a periodic sample grid. |

Empty sample vectors are allowed only for empty queries. Empty queries bypass
boundary-value conversion. A single sample uses boundary values outside its point;
as in the pinned source, even a NaN query returns that sample in the one-point case.
For longer grids, NaN queries propagate. Nonfinite slope results retry the opposite
endpoint, then preserve a common value when both samples are equal.

## Periodic coordinates

```lua
local periodic = lr.interp({0, 90, 360, 450}, {0, 180}, {0, 1}, {period=360})
assert(periodic[1] == 0 and periodic[2] == 0.5)
assert(periodic[3] == 0 and periodic[4] == 0.5)
```

A nonzero real scalar period normalizes coordinates modulo its absolute value,
sorts sample points and extends the grid across the wrap boundary. `left` and
`right` are ignored. Lua accepts real numbers or typed rank-zero real periods.

Periodic sorting uses LuaRay's portable NumPy-derived quicksort. **Repeated
normalized coordinates can select different sample values from a CPU-optimized
NumPy wheel because neither quicksort promises stable ties.** The new corpus
contains68 portable-sort cases;12 differ from the reference wheel's default CPU
sort. All68 are checked against NumPy's actual interpolation kernel after its
portable generic quicksort. CPU-specific tied ordering is not certified.

## Complex samples and conversions

```lua
local samples = lr.array({lr.complex(0, 1), lr.complex(2, 3)}, "complex64")
local value = lr.interp({0.5}, {0, 1}, samples)
assert(value.dtype == "complex128")
assert(value[1].real == 1 and value[1].imag == 2)
```

Real results use float64; complex samples use complex128. Component slopes follow
the source's separate real/imaginary calculations. Results are writable and
independent of queries, coordinates and samples. Read-only, reversed, strided and
broadcast inputs are accepted through typed conversion; output storage is C order.

Without a period, typed inputs must safely cast to the target dtype. Extended
float arrays, complex query/coordinate arrays and temporal arrays can therefore
raise. The periodic path performs the source's explicit dtype conversions instead,
which can accept these inputs. Ordinary Lua input coercion follows the library's
constructor rules; full Python scalar and foreign-array protocols are not reproduced.

## Compatibility

Available since **0.133.0-dev**, derived from NumPy 2.5.3's Python dispatcher and
native interpolation kernels. Lua uses one options table and typed scalar output.
Numerical references allow absolute plus relative `2e-12`; metadata and input/
backing states compare exactly. Periodic sort differences above remain explicit.
Object/structured dtypes, complete CPU dispatch, warning objects and Python
exception identity remain unsupported. This API is partially compatible.
