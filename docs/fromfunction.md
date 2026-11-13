---
docs_examples: true
---
# Arrays from a Lua callback

`lr.fromfunction(callback, dimensions, options, ...parameters)` builds dense
coordinate grids and calls the callback **once**, passing one array per
dimension. It returns the callback's results unchanged. Coordinate values start
at zero, as in `lr.indices`; default coordinate dtype is float64.

```lua
local lr = require("luaray")
local calls = 0
local values = lr.fromfunction(function(row, column)
  calls = calls + 1
  return row * 10 + column
end, {2, 3})
assert(calls == 1 and values:get(2,3) == 12)
assert(values.dtype == "float64")
```

The coordinate arrays all have the requested shape. Arithmetic uses LuaRay's
native array operators and broadcasting; the callback is not evaluated once
per element. The callback can be a Lua/C function or a value with a Lua `__call`
metamethod. Only the `dtype` option is supported; choose a string or descriptor.

```lua
local diagonal = lr.fromfunction(function(i, j)
  return lr.equal(i, j)
end, {3, 3}, {dtype="int32"})
assert(diagonal.dtype == "bool")
assert(diagonal:get(2,2) and not diagonal:get(1,2))
```

Use explicit array comparison functions such as `lr.equal` for elementwise
results. The coordinate dtype controls arguments to the callback and does not
force its return dtype or shape.

## Additional parameters and return values

Extra Lua parameters are appended after the coordinate arrays, preserving nil
positions and argument count. This is the Lua interface for callback context;
Python's keyword forwarding is represented by positional Lua parameters. You
can also capture context in a closure or pass a named table as one parameter.

```lua
local shifted = lr.fromfunction(function(i, j, scale, offset)
  return i * scale + j + offset
end, {2, 3}, nil, 3, 0.5)
assert(shifted:get(2,3) == 5.5)
```

There is no conversion or allocation around the callback's return values.
Scalars, tables, functions, arrays, nil and multiple returns keep their Lua
meaning. An empty dimension list passes no coordinate arrays.

```lua
local token = {name="result"}
local a, b, c = lr.fromfunction(function()
  return nil, false, token
end, {})
assert(a == nil and b == false and rawequal(c, token))
local count = lr.fromfunction(function(...) return select('#', ...) end, {})
assert(count == 0)
```

## Views, mutation and errors

Coordinate arguments are views into the newly allocated dense grid. The
callback can modify them, make a view read-only or return one directly. Returned
views retain the native allocation after the call and after garbage collection.

```lua
local axis = lr.fromfunction(function(i) return i end, {3}, {dtype="float32"})
collectgarbage("collect")
assert(not axis.flags.owndata and axis.dtype == "float32")
axis:set(7, 1)
assert(axis:get(1) == 7)
```

Grid construction finishes before the callback runs. Invalid dimensions or an
unsupported coordinate dtype fail before invoking it. Callback errors propagate
without being replaced or converted.

```lua
local ran = false
assert(not pcall(function()
  lr.fromfunction(function() ran = true end, {-1, 3})
end))
assert(not ran)
local marker = {}
local ok, err = pcall(function()
  lr.fromfunction(function() error(marker) end, {1})
end)
assert(not ok and rawequal(err, marker))
```

Dense grids add one leading axis internally, so at most 63 requested dimensions
are supported. Empty axes still produce coordinate arrays and invoke the
callback once. No `like` or foreign array dispatch is implemented; unknown
options are errors. Callback parameter arity and multiple-return behavior follow
Lua's own rules.

## Executed references

The NumPy 2.5.3 reference passed **2,160 cases / 1,172,364 checks**. It covers
coordinate dtypes, invalid/empty/scalar/high-rank shapes, exactly-once invocation,
callable objects, direct scalar/array/multiple results, argument identity and
sharing, mutation, read-only views and errors. Source keyword context was mapped
to trailing Lua parameters; tuple results were compared as Lua multiple returns.
All numerical payloads and metadata compare exactly within those language
conventions; longdouble omits ABI padding. The corpus regenerates exactly, and
the permanent Lua regression adds 103 checks. The API remains partial: foreign
protocols, general object dtypes, every callback interaction and all host ABIs
are unsupported or uncertified.
