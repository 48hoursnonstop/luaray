---
docs_examples: true
---
# Random generators

Create a PCG64 generator with `lr.random.default_rng(seed)`. Each generator
keeps its own state. Pass the same seed and make the same calls to reproduce a
sequence in the same LuaRay version. Generator methods use Lua's `:` syntax.

```lua
local lr = require("luaray")
local rng = lr.random.default_rng(42)
local samples = rng:random({2, 3})
local replay = lr.random.default_rng(42)
assert(lr.array_equal(samples, replay:random({2, 3})))
```

## Sample bounded integers

`integers(low, high, size, dtype, endpoint)` includes `low` and excludes
`high` by default. Set `endpoint` to `true` to include both. Pass a shape
table for an ndarray or omit size for a scalar draw.

```lua
local dice = rng:integers(1, 7, {10}, "int32")
for _, face in ipairs(dice:tolist()) do
  assert(face >= 1 and face <= 6)
end
```

Search the [API inventory](api_inventory.md) for `numpy.random.Generator`
to look up distribution and sampling methods. See [numerical portability](portability.md)
for the effect of floating-point math on sampled values.
