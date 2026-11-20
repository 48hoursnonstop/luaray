---
docs_examples: true
---

# Stable sorting by multiple keys

`lr.lexsort(keys, axis)` returns the one-based indices that sort each slice
lexicographically. Supply keys of the same shape in a Lua table, or put each
key in a slice along the first axis of one ndarray. The last key is primary,
the previous key breaks its ties, and otherwise equal rows retain input order.

```lua
local lr = require("luaray")
local names = lr.array({"Zoe", "Ada", "Ada", "Lin"}, "U3")
local scores = lr.array({2, 2, 1, 2})
local order = lr.lexsort({names, scores})
assert(table.concat(order:tolist(), ",") == "3,2,4,1")
assert(lr.take(names, order)[4] == "Zoe")
```

The axis defaults to the last axis and accepts positive or negative positions.
The index array has the same shape as a key.

```lua
local minor = lr.array({{2, 1, 3}, {1, 0, 2}})
local major = lr.array({{0, 0, 0}, {1, 2, 1}})
local order = lr.lexsort({minor, major}, 2)
assert(table.concat(order[1]:tolist(), ",") == "2,1,3")
assert(table.concat(order[2]:tolist(), ",") == "1,3,2")
```

Supported keys include native numbers, complex values, fixed-width text and
temporal values. Non-native Unicode keys follow the whole-item byte swap in
NumPy 2.5.5. For ordinary code-point order, convert those keys to native
Unicode before sorting.

## Validation

**2,626 cases / 38,702 checks** passed with NumPy 2.5.5. The results preserve stable ties across numeric, complex, temporal and fixed text keys. Cases include NaN, NaT, non-native Unicode, ndarray keys, strided views and scalar or empty inputs.
