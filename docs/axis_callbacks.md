---
docs_examples: true
---
# Applying a callback along an axis

`lr.apply_along_axis(callback, axis, input, ...)` calls a Lua function on each
one-dimensional slice along an axis. Positive axes start at one; negative axes
count from the end. All other axes are traversed in C order. This is useful when
your calculation is naturally expressed for a vector.

```lua
local lr = require("luaray")
local values = lr.array({{1, 2, 3}, {4, 5, 6}}, "int16")
local rows = lr.apply_along_axis(lr.sum, 2, values)
assert(rows:tolist()[1] == 6 and rows:tolist()[2] == 15)
local columns = lr.apply_along_axis(lr.sum, 1, values)
assert(columns:tolist()[1] == 5 and columns:tolist()[3] == 9)
```

## Result shape and type

The callback's first result determines the output dtype and replacement shape.
A scalar removes the selected axis. A vector replaces it; a matrix inserts two
dimensions in its place. Later results are assigned into the same typed buffer,
using the usual conversion and broadcasting rules. Return a Lua table or ndarray
for a vector: only the first Lua return value is used.

```lua
local diagonal = lr.apply_along_axis(lr.diag, -1, values)
assert(diagonal.ndim == 3 and diagonal.shape[1] == 2)
assert(diagonal:get(2, 3, 3) == 6)
local lengths = lr.apply_along_axis(function(row)
  return {row.size, 123}
end, 1, values)
assert(lengths.shape[1] == 2 and lengths.shape[2] == 3)
assert(lengths:get(2, 3) == 123)
```

Use a typed ndarray return when its precision matters. Lua numbers follow
LuaRay's ordinary scalar dtype inference. A one-dimensional input and scalar
callback result produce a zero-dimensional ndarray, rather than a Lua number.
Output storage is independent of the input; its axes and strides follow the
buffer construction and transpose, so it need not be C contiguous.

```lua
local scalar = lr.apply_along_axis(lr.sum, 1, {2, 3, 4})
assert(scalar.ndim == 0 and scalar:item() == 9)
local copied = lr.apply_along_axis(function(row) return row end, 1, values)
assert(not lr.shares_memory(copied, values))
assert(copied.flags.f_contiguous)
```

## Callback parameters and shared views

Extra arguments are forwarded to every invocation, preserving explicit nil
positions. A context table can replace Python keyword arguments. Callable Lua
tables are accepted too. The slice itself shares input storage; modifying it
changes the input, and changes already made remain if a later callback fails.
Read-only input slices remain read-only. Callback errors propagate unchanged.

```lua
local scaled = lr.apply_along_axis(function(row, scale, context)
  assert(context.label == "scale")
  return row * scale
end, 2, values, 3, {label = "scale"})
assert(scaled:get(2, 3) == 18)
local mutable = lr.array({{1, 2}, {3, 4}})
lr.apply_along_axis(function(row) row:fill(7); return row end, 2, mutable)
assert(mutable:get(1, 1) == 7 and mutable:get(2, 2) == 7)
```

## Empty axes and limits

An empty selected axis still yields empty vectors if the other dimensions allow
iteration. A zero dimension among those other axes prevents any invocation and
raises an error. Invalid axes are rejected before calling the function.

```lua
local calls = 0
local result = lr.apply_along_axis(function(row)
  calls = calls + 1
  assert(row.size == 0)
  return 5
end, 2, lr.empty({2, 0}))
assert(calls == 2 and result:tolist()[2] == 5)
assert(not pcall(lr.apply_along_axis, lr.sum, 1, lr.empty({2, 0})))
```

The reference passed **60,768 cases / 1,226,968 checks**, covering positive and
negative axes, callback order and captured view metadata, first-result shape
insertion, layout, raw payloads, shared writes, read-only data, callback failures,
changing results and invalid inputs across numeric, fixed-string and temporal
dtypes. The corpus regenerated exactly. Permanent regressions add 191 Lua checks,
including explicit nil parameters, error identity and the 64-dimensional boundary.

The API remains partial. Python ndarray subclasses, object/structured dtypes,
foreign array dispatch and NumPy scalar classes are not implemented. Python
keyword arguments become explicit trailing Lua arguments; axes use Lua positions.
All possible callback programs, casting cases and host ABIs are not certified.
For numerical grids passed to a function once, see [fromfunction](fromfunction.md).
