---
docs_examples: true
---
# Complex phases and angles

`lr.unwrap(values, options)` removes jumps caused by wrapping a phase into a fixed
interval. It adds multiples of the period so consecutive samples stay close,
while preserving the first sample along each selected axis.

## Radians

```lua
local lr = require("luaray")
local phase = lr.unwrap({0, math.pi/2, -math.pi, -math.pi/2, 0})
assert(math.abs(phase[3] - math.pi) < 1e-12)
assert(math.abs(phase[5] - 2*math.pi) < 1e-12)
```

The default period is `2*math.pi`. The default discontinuity threshold is half the
period. `unwrap` operates on sampled phase values, not on complex numbers directly.
Complex inputs fail in the remainder step.

| Option | Default | Meaning |
| --- | --- | --- |
| `period` | `2*math.pi` | Range over which the input wraps. |
| `discont` | `period/2` | Ignore corrections for differences smaller than this threshold. |
| `axis` | `-1` | Axis to process; positive Lua axes start at one. |

## Custom periods and thresholds

```lua
local turns = lr.array({0, 1, 2, -1, 0}, "int64")
local continuous = lr.unwrap(turns, {period=4})
assert(continuous.dtype == "int64")
assert(continuous[4] == 3 and continuous[5] == 4)
local unchanged = lr.unwrap(turns, {period=4, discont=4})
assert(unchanged[4] == -1)
```

A threshold below half the period cannot force a correction that would enlarge a
jump. At exactly half an even period, a positive difference keeps its positive
sign. Odd integer periods use an integer half-interval; their boundary is not
ambiguous. Integer differences and cumulative corrections follow native wrapping
arithmetic rather than converting every input to float64.

## Independent results along an axis

```lua
local grid = lr.array({{0, 1, 2, -1}, {0, 1, 2, -1}}, "float32")
local continuous = lr.unwrap(grid, {axis=2, period=4})
assert(continuous.dtype == "float32" and continuous:get(2, 4) == 3)
assert(not lr.shares_memory(continuous, grid))
continuous:set(99, 1, 1)
assert(grid:get(1, 1) == 0)
```

Results are writable copies with the promoted dtype. Fortran, transposed, reversed,
broadcast and read-only inputs are accepted. Empty axes return empty copies;
scalar input is invalid. NaN/nonfinite corrections propagate through the cumulative
sum. The implementation does not impose a positive-period check that the pinned
source does not have; zero and negative periods retain its arithmetic behavior.

Typed periods retain their dtype and broadcasting rules. Floating period vectors
can broadcast against adjacent differences. A multi-element integer period array
raises because the source's boundary-ambiguity decision requires a scalar truth
value. Typed/ordinary scalar promotion is handled by `result_type`.

## Extract the phase of complex values

```lua
local lr = require("luaray")
local complex = lr.array({lr.complex(1, 0), lr.complex(0, 1), lr.complex(1, 1)}, "complex128")
local degrees = lr.angle(complex, {deg=true})
assert(degrees[1] == 0 and degrees[2] == 90 and degrees[3] == 45)
local radians = lr.angle(complex)
assert(math.abs(radians[3] - math.pi/4) < 1e-12)
```

`lr.angle(z, {deg=false})` computes `arctan2(imag(z), real(z))`. It returns radians
between minus pi and pi; `deg=true` converts to degrees. The option requires a Lua
Boolean. Real inputs use positive zero for their imaginary part. Complex zeros
retain both component signs when choosing the angle.

```lua
local negative_real = lr.angle(-1)
assert(negative_real.ndim == 0 and negative_real:tolist() == math.pi)
local single = lr.angle(lr.array({lr.complex(1, 1)}, "complex64"))
assert(single.dtype == "float32")
```

`angle` produces independent writable arrays; scalar input returns a rank-zero
ndarray. Complex64 produces float32, complex128 produces float64 and clongdouble
produces longdouble. Real input follows the promotion rules of `arctan2`.
Noncontiguous and read-only views are accepted.

```lua
local wrapped = lr.angle(lr.array({lr.complex(1, 0), lr.complex(-1, 0), lr.complex(0, -1)}, "complex128"))
local continuous = lr.unwrap(wrapped)
assert(math.abs(continuous[3] - 1.5*math.pi) < 1e-12)
```

Available since **0.132.0-dev**. References check values and signed zeros, dtype,
shape, strides, independent writable storage and unchanged input state. Relative
budgets are2e-3 for half,3e-6 for float32 and2e-12 for wider types. The protocol
and dtype limitations below still apply.

## Compatibility

Available since **0.131.0-dev**, derived from NumPy 2.5.3. Lua uses one options
table and strict integer axes. Value, dtype, shape, stride, writable independence
and unchanged input/backing-state references cover period parity, thresholds,
views, nonfinite values and integer limits. Floating budgets are absolute plus
relative: half `5e-3`, float32 `5e-6`, wider `2e-12`. Object/structured dtypes,
foreign/subclass protocols, all Python scalar classes and exact warning/exception
identity remain unsupported. This API is partially compatible.
