---
docs_examples: true
---
# Finite differences

`diff` subtracts adjacent values along an axis. `ediff1d` flattens the input in
logical C order first. Both use native typed arithmetic and accept ndarrays or
ordinary rectangular Lua sequences.

## First and repeated differences

```lua
local lr = require("luaray")
local values = lr.array({1, 4, 9}, "int64")
local first = lr.diff(values)
assert(first[1] == 3 and first[2] == 5)
assert(lr.diff(values, 2)[1] == 2)
```

Each pass computes `out[i] = a[i+1] - a[i]`. The default order is one; order two
repeats the operation on the first differences. Orders must be nonnegative Lua
integers. A selected axis eventually becomes empty when there are no pairs left.
The implementation returns that stable empty result without performing redundant
passes for very large orders.

| Signature | Defaults |
| --- | --- |
| `lr.diff(a, n, axis)` | `n=1`, `axis=-1`. |
| `lr.diff(a, {n=..., axis=..., prepend=..., append=...})` | Options-table form. |
| `lr.ediff1d(a, {to_begin=..., to_end=...})` | Both padding options omitted by default. |

Positive axes start at one; negative axes count from the end. `ediff1d` takes an
options table rather than Python's positional padding arguments.

## Choose an axis and add boundary values

```lua
local matrix = lr.arange(6):reshape({2, 3})
local rows = lr.diff(matrix, {axis=1})
assert(rows.shape[1] == 1 and rows.shape[2] == 3)
assert(rows:get(1, 3) == 3)
local bounded = lr.diff(values, {prepend=0, append=16})
assert(bounded.size == 4 and bounded[1] == 1 and bounded[4] == 7)
```

Scalar boundary values expand to a one-element slice along the selected axis.
Array boundaries must have the same rank and match every other axis. Concatenation
promotes the dtype before subtraction. Fortran, transposed, reversed and broadcast
inputs are supported; native concatenation/ufunc rules determine output strides.

`n=0` returns the original input immediately, preserving identity and writeability.
It also preserves an ordinary Lua table as a table and ignores axis and padding
values. Positive orders require at least one dimension and produce independent,
writable arrays.

## Flatten and pad the differences

```lua
local flat = lr.ediff1d({{1, 4}, {9, 16}}, {to_begin=0, to_end=99})
assert(flat.size == 5)
assert(flat[1] == 0 and flat[2] == 3 and flat[4] == 7 and flat[5] == 99)
local narrow = lr.ediff1d(lr.array({1, 4}, "int8"), {to_begin=256})
assert(narrow.dtype == "int8" and narrow[1] == 0 and narrow[2] == 3)
```

`ediff1d` computes differences before adding the boundary values to the output.
It flattens boundary arrays too. With padding, the result keeps the input dtype;
padding must satisfy `same_kind` casting. Integer narrowing can therefore wrap.
Floating padding for an integer input raises instead of promoting it. An empty
padding array still participates in dtype validation.

## Boolean, unsigned and temporal values

```lua
local events = lr.diff({true, true, false})
assert(events.dtype == "bool" and not events[1] and events[2])
local wrapped = lr.diff(lr.array({1, 0}, "uint8"))
assert(wrapped[1] == 255)
local dates = lr.array({1, 3, 8}, "datetime64[ms]")
local elapsed = lr.diff(dates)
assert(elapsed.dtype == "timedelta64[ms]")
assert(lr.astype(elapsed, "int64")[2] == 5)
```

Boolean `diff` detects changes using inequality. `ediff1d` uses subtraction and
rejects Boolean inputs. Unsigned differences retain their dtype and wrap rather
than becoming signed. Complex subtraction does not conjugate. Datetime differences
produce timedelta with the corresponding unit; duration subtraction preserves its
unit. Padded datetime `ediff1d` can fail because its enforced datetime output
cannot accept timedelta subtraction under `same_kind` casting.

## Compatibility

Available since **0.128.0-dev**. NumPy 2.5.3 references cover values, dtype, layout,
empty axes, orders, axes, padding, Boolean/unsigned/complex/time behavior, NaT,
nonfinite values, identity and actual post-write backing states. Local tests also
exercise the native maximum integer order; upstream's enormous loop is not run.
Object/structured dtypes, foreign/subclass protocols and complete Python argument,
warning and exception identity remain unsupported. The APIs remain partially compatible.
