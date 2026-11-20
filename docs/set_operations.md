---
docs_examples: true
---

# Array set operations

`lr.union1d`, `lr.intersect1d`, `lr.setdiff1d` and `lr.setxor1d` work on
the values of two arrays flattened in C order.

| Operation | Values returned |
| --- | --- |
| `union1d(a, b)` | Values in either input |
| `intersect1d(a, b)` | Values in both inputs |
| `setdiff1d(a, b)` | Values in `a` that are absent from `b` |
| `setxor1d(a, b)` | Values in exactly one input |

```lua
local lr = require("luaray")
local a = lr.array({3, 1, 3, 2})
local b = lr.array({1, 2, 2, 5})
assert(table.concat(lr.union1d(a, b):tolist(), ",") == "1,2,3,5")
assert(table.concat(lr.setdiff1d(a, b):tolist(), ",") == "3")
assert(table.concat(lr.setxor1d(a, b):tolist(), ",") == "3,5")
```

Set `return_indices = true` on `intersect1d` to receive two additional arrays
with the first one-based positions in the original flattened inputs.

```lua
local values, left, right = lr.intersect1d(a, b, {return_indices = true})
assert(table.concat(values:tolist(), ",") == "1,2")
assert(table.concat(left:tolist(), ",") == "2,4")
assert(table.concat(right:tolist(), ",") == "1,2")
```

The three operations with options accept `assume_unique = true` for distinct
inputs. With that option, `setdiff1d` preserves the order of the first input.
The default returns a sorted set.

## Validation

**1,284 cases / 31,299 checks** passed with NumPy 2.5.5. The checks exercise sorted results, first original indices, duplicate and empty inputs, mixed numeric types, fixed text and temporal descriptors.
