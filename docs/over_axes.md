---
docs_examples: true
---
# Applying a callback over several axes

`lr.apply_over_axes(callback, input, axes)` calls a function repeatedly on the
whole intermediate array and one axis at a time. `axes` is a nonzero Lua integer
or a dense table of axes. Positive axes start at one; negative axes count from
the end. Axes are processed in the supplied order, including repeats.

```lua
local lr = require("luaray")
local values = lr.arange(24):reshape({2, 3, 4})
local totals = lr.apply_over_axes(lr.sum, values, {1, 3})
assert(totals.shape[1] == 1 and totals.shape[3] == 1)
assert(totals:get(1, 1, 1) == 60)
assert(totals:get(1, 3, 1) == 124)
```

## Restoring reduced axes

The callback receives `(array, axis)`. If its result has one fewer dimension,
a singleton is inserted at that axis. A result with the same rank is used
directly, even if its shape changes. Other rank changes raise an error. Each
subsequent call sees the preceding result with its restored dimensions.

```lua
local order = {}
local kept = lr.apply_over_axes(function(array, axis)
  order[#order+1] = axis
  return lr.sum(array, {axis = axis, keepdims = true})
end, values, {1, -1})
assert(order[1] == 1 and order[2] == 3)
assert(kept:get(1, 2, 1) == 92)
local invalid = pcall(lr.apply_over_axes, function() return 5 end, values, 1)
assert(not invalid) -- A scalar loses more than one of these three axes.
```

The callback controls axis validation for its own operation. Negative axes are
normalized once against the original rank before invocation, following the
reference; bounds are not checked by an additional global validation step.
Callback results are coerced to ndarrays. For a scalar result, a typed ndarray
preserves an explicit dtype; ordinary Lua numbers use scalar dtype inference.

## Identity, mutation and empty selections

An empty axes table returns the coerced input without calling the function.
Returning the input unchanged preserves its identity. New storage is allocated
only by operations that require it. Mutating an intermediate view can therefore
modify the original input. Errors propagate unchanged and retain earlier writes.
Callable Lua tables are accepted.

```lua
assert(rawequal(lr.apply_over_axes(7, values, {}), values))
local unchanged = lr.apply_over_axes(function(array) return array end, values, 2)
assert(rawequal(unchanged, values))
local reduced = lr.apply_over_axes(lr.sum, {1, 2, 3}, 1)
assert(reduced.shape[1] == 1 and reduced[1] == 6)
```

`squeeze()` now also preserves its input identity when no axes are removed,
including an explicitly empty axis selection. Removing singleton axes still
returns a shared view.

```lua
local matrix = lr.ones({2, 3})
assert(rawequal(lr.squeeze(matrix), matrix))
local singleton = lr.ones({1, 3})
assert(rawequal(lr.squeeze(singleton, {}), singleton))
local squeezed = lr.squeeze(singleton)
assert(not rawequal(squeezed, singleton))
assert(lr.shares_memory(squeezed, singleton))
```

## Compatibility

The reference passed **129,600 cases /4,188,479 checks** and 196 permanent Lua checks. Another 8,774 callback scalar results were explicitly normalized to rank-zero arrays with Lua dtype inference and writeability; this does not claim Python scalar-object parity. Array values/metadata and callback execution compare after that adaptation. The corpus regenerated exactly.

The API is partial. Axes use Lua integers and tables; ndarray-valued axes,
Python Boolean/float axis protocols and foreign dispatch are unsupported. Lua
sequences are converted before reading their rank. Lua scalar callback results
are converted to ndarrays instead of reproducing Python scalar class protocols.
Full subclass, dtype, callback and host ABI compatibility is not certified.

For callbacks on individual one-dimensional slices, use
[apply_along_axis](axis_callbacks.md). For a single reduction over multiple axes,
the reducer's own axis/keepdims options can be more direct.
