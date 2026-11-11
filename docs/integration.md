---
docs_examples: true
---
# Trapezoidal integration

`lr.trapezoid(y, options)` estimates an integral by adding the areas of trapezoids
between adjacent samples. It removes the selected axis from the output shape.

## Equally spaced samples

```lua
local lr = require("luaray")
local values = lr.array({1, 2, 3}, "float64")
local integral = lr.trapezoid(values)
assert(integral.ndim == 0 and integral:tolist() == 4)
assert(lr.trapezoid(values, {dx=2}):tolist() == 8)
```

| Option | Default | Meaning |
| --- | --- | --- |
| `axis` | `-1` | Axis to integrate; positive Lua axes start at one. |
| `dx` | `1.0` | Sample spacing when coordinates are omitted. |
| `x` | Omitted | Coordinates; overrides `dx`. |

A one-dimensional input produces a typed rank-zero ndarray. Extract its Lua value
with `:tolist()`. The typed result preserves precision and duration units across
the reduction. Scalar input is invalid. Zero or one sample gives a zero integral.

## Coordinates and direction

```lua
local irregular = lr.trapezoid({0, 1, 9}, {x={0, 1, 3}})
assert(irregular:tolist() == 10.5)
local reverse = lr.trapezoid({1, 2, 3}, {x={8, 6, 4}})
assert(reverse:tolist() == -8)
```

Coordinates are used in their given order; they are not sorted. Decreasing
coordinates reverse the sign. A one-dimensional `x` vector is differenced and
reshaped for the selected input axis. Multidimensional coordinates use the
requested axis before broadcasting; standard array shape rules apply. Coordinates
and spacing may be typed arrays or ordinary rectangular Lua sequences.

## Integrate rows or columns

```lua
local grid = lr.arange(6):reshape({2, 3})
local rows = lr.trapezoid(grid)
assert(rows[1] == 2 and rows[2] == 8)
local columns = lr.trapezoid(grid, {axis=1})
assert(columns[1] == 1.5 and columns[3] == 3.5)
assert(not lr.shares_memory(rows, grid))
```

Results are writable and independent of the input. Fortran, transposed, reversed,
broadcast and read-only inputs are supported. The computation follows the pinned
source order: adjacent sums, spacing multiplication, division by `2.0`, then sum.
Integer addition can wrap before division; it is not pre-converted to float64.
Boolean addition uses the native Boolean operation.

## Temporal samples

```lua
local hours = lr.array({1, 2, 3}, "timedelta64[h]")
local accumulated = lr.trapezoid(hours)
assert(accumulated.dtype == "timedelta64[h]")
assert(lr.astype(accumulated, "int64"):tolist() == 3)
```

Duration arithmetic preserves units and truncates fractional ticks at each
intermediate division. The duration sum wraps int64 ticks and propagates NaT.
Datetime coordinates contribute duration differences; datetime sample addition is
unsupported. Calendar/fixed-unit conversion rules still apply.

## Compatibility

Available since **0.130.0-dev**, derived from NumPy 2.5.3. Lua uses one options
table and typed rank-zero outputs. Floating result budgets are absolute plus
relative: half `5e-3`, float32/complex64 `5e-6`, wider `2e-12`; exact metadata and
input/backing states are checked separately. Foreign/subclass dispatch, complete
Python scalar/warning protocols, object/structured dtypes and every possible
layout remain unsupported. This API is partially compatible.
