---
docs_examples: true
---
# Numerical gradients

`lr.gradient(values, options)` estimates first derivatives with centered differences
inside each selected axis and one-sided differences at its endpoints. Unlike
[finite differences](differences.md), its outputs keep the input shape.

## Differentiate sampled values

```lua
local lr = require("luaray")
local values = lr.array({0, 1, 4, 9}, "float64")
local derivative = lr.gradient(values, {edge_order=2})
assert(derivative[1] == 0 and derivative[2] == 2)
assert(derivative[3] == 4 and derivative[4] == 6)
```

Spacing defaults to one. `edge_order=1` uses first-order endpoint estimates;
`edge_order=2` uses second-order endpoints and requires at least three samples
along every selected axis. Interior estimates are second order in both modes.

| Option | Meaning |
| --- | --- |
| `axis` | One Lua integer, a sequence of axes, or omitted for all axes. |
| `spacing` | One scalar for all selected axes, or a sequence of scalar/coordinate spacings in axis order. |
| `edge_order` | One by default; two selects second-order endpoints. |

Positive axes start at one; negative axes count from the end. Integer options
must be actual Lua integers. With one selected axis the result is an ndarray;
with multiple axes it is a Lua sequence of ndarrays in the requested order.
No selected axes, including scalar input, returns an empty sequence.

## Uneven coordinates

```lua
local coordinates = lr.array({0, 1, 3, 6, 10}, "int64")
local quadratic = lr.square(coordinates)
local slope = lr.gradient(quadratic, {spacing=coordinates, edge_order=2})
assert(math.abs(slope[3] - 6) < 1e-12)
assert(math.abs(slope[5] - 20) < 1e-12)
```

A coordinate vector must be one-dimensional and match its axis length. A typed
vector can be passed directly when selecting one axis. An ordinary Lua coordinate
sequence needs an outer table: `spacing={{0, 1, 3, 6, 10}}`. This distinguishes it
from a list of per-axis spacings. Integer coordinate arrays convert to float64
before subtraction. Repeated coordinates can produce nonfinite values.

## Multiple axes and independent outputs

```lua
local grid = lr.arange(12):reshape({3, 4})
local derivatives = lr.gradient(grid, {axis={2, 1}, spacing={2, 4}})
assert(#derivatives == 2)
assert(derivatives[1]:get(2, 3) == 0.5)
assert(derivatives[2]:get(2, 3) == 1)
assert(not lr.shares_memory(derivatives[1], grid))
```

Each derivative is writable and independent of the source and other outputs.
Fortran, transposed, reversed, broadcast and read-only input views are accepted.
Native `empty_like` layout rules determine output strides. Integer data converts
to float64; floating and complex data retains its dtype. Boolean subtraction is
unsupported and raises.

## Dates and durations

```lua
local dates = lr.array({0, 2, 8}, "datetime64[ms]")
local elapsed = lr.gradient(dates, {spacing=2})
assert(elapsed.dtype == "timedelta64[ms]")
assert(lr.astype(elapsed, "int64")[2] == 2)
```

Datetime data is viewed as durations with the same unit before differentiation.
Duration arithmetic keeps its unit and truncates fractional ticks toward zero.
An integer spacing uses exact integer duration division; floating spacing uses
the double loop. Duration coordinate vectors follow NumPy's integer-subtype
classification and convert their raw ticks to float64. See [duration scaling](temporal_scaling.md).

## Compatibility

Available since **0.129.0-dev**, using NumPy 2.5.3's stencil and operation order.
The Lua options table replaces Python's variadic spacings. Typed scalar spacings
remain strong; ordinary Lua numbers and complex values use weak scalar arithmetic.
One-dimensional float64 input with ordinary complex spacing and second-order
endpoints follows the pinned source's scalar-assignment rejection.

References cover shape, dtype, strides, writable independence, input state,
axes, endpoint orders, uniform/uneven coordinates, nonfinite and temporal values.
Numerical budgets are absolute plus relative: float16 `5e-3`, float32/complex64
`5e-6`, wider types `2e-12`; observed errors in the new corpus were zero. Object
and structured dtypes, foreign/subclass protocols, complete Python scalar classes,
warning objects and exception identity remain unsupported. This API is partially compatible.
