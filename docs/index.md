---
docs_examples: true
---
# LuaRay

**Typed arrays and numerical computing for Lua 5.4.**

Create multidimensional arrays, broadcast compatible shapes, and calculate with
native C/C++ kernels. LuaRay includes real and complex mathematics, views,
FFT, linear algebra, and random number generation.

**[Get started →](getting-started.md)** · [Array fundamentals](arrays.md) · [API reference](creation.md)

## A small example

```lua
local np = require("luaray")

local samples = np.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local totals = np.sum(samples, 2)
assert(totals[1] == 6 and totals[2] == 15)

local shifted = samples + np.array({10, 20, 30})
assert(shifted:get(2, 3) == 36)
```

Positive indices and axes start at **1**. Functions keep familiar numerical names;
the [array guide](arrays.md) explains where Lua conventions change how you call them.

## Where to go next

- **New to LuaRay?** [Build it and run your first program](getting-started.md).
- **Working with data?** Learn [shapes, indexing, and broadcasting](arrays.md).
- **Looking up an operation?** Browse the reference in the sidebar or search its name.
- **Moving from NumPy?** Check [API availability and limitations](api_inventory.md).

::: info Development version · 0.136.0-dev
LuaRay uses NumPy 2.5.3 as its primary behavioral reference. Compatibility varies
by operation and dtype. The [API inventory](api_inventory.md) records supported
names and remaining gaps; available functions are still classified as partial.
:::
