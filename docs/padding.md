---
docs_examples: true
---

# Padding arrays

`lr.pad(array, widths, mode, options)` extends one or more axes and
returns a new array with the input's dtype. A single width applies to
both ends of every axis. A pair supplies the before and after widths,
and a list of pairs supplies separate widths for every axis.

```lua
local lr = require("luaray")
local a = lr.array({{1, 2}, {3, 4}}, "int32")
local columns = lr.pad(a, {axes = {[-1] = {1, 2}}})
assert(lr.array_equal(columns, {{0, 1, 2, 0, 0}, {0, 3, 4, 0, 0}}))
```

The `axes` table is an alternative to a full list. Its positive axis
numbers start at one and negative axis numbers count from the end.
Unspecified axes keep their original sizes.

| Mode | How it fills the padded cells | Options |
| --- | --- | --- |
| `constant` | A constant, zero by default | `constant_values` |
| `edge` | Repeats the nearest input value | |
| `wrap` | Repeats the input periodically | |
| `reflect`, `symmetric` | Reflects the data, with the edge repeated in symmetric mode | `reflect_type` |
| `linear_ramp` | Interpolates between an outer value and the input edge | `end_values` |
| `maximum`, `minimum`, `mean`, `median` | Uses a statistic of the values near each edge | `stat_length` |
| `empty` | Leaves the padded cells uninitialized | |

Options that take values or lengths accept a single value, a before/after
pair or a list of pairs. For reflection, `reflect_type = "odd"` subtracts
each reflected sample from twice the edge value. The default is `"even"`.
For statistical modes the default is to use the full axis.

```lua
local x = lr.array({1, 2, 3})
local reflected = lr.pad(x, {2, 1}, "reflect", {reflect_type = "odd"})
assert(lr.array_equal(reflected, {-1, 0, 1, 2, 3, 4}))
local repeated = lr.pad(x, {2, 1}, "wrap")
assert(lr.array_equal(repeated, {2, 3, 1, 2, 3, 1}))
```

To customize padding, pass a Lua function as the mode. The function
receives a writable vector view, its width pair, the one-based axis and the
options table. Assign through the view to update the returned array.

```lua
local custom = lr.pad({1, 2}, 1, function(vector, widths, axis, options)
  vector:set(options.value + axis, lr.s(1, widths[1] + 1))
  vector:set(options.value, lr.s(-widths[2], nil))
end, {value = 10})
assert(lr.array_equal(custom, {11, 1, 2, 10}))
```

## Validation

**5,965 cases / 1,708,673 checks** passed with NumPy 2.5.5. The checks cover all standard modes and Lua callback padding, per-axis widths, strided and Fortran inputs, dtype conversions and repeated reflections. The empty mode is checked for metadata and copying the original interior.
