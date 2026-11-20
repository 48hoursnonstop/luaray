---
docs_examples: true
---

# Matrix and vector products

`lr.matvec(a, b)` contracts a matrix with a vector. The last two dimensions
of `a` are its rows and columns. The last dimension of `b` matches the
columns. Leading dimensions broadcast.

```lua
local lr = require("luaray")
local matrix = lr.array({{1, 2}, {3, 4}})
local result = lr.matvec(matrix, {2, 1})
assert(result[1] == 4 and result[2] == 10)
local repeats = lr.empty({3, 2}, "float64")
assert(rawequal(lr.matvec(matrix, {2, 1}, {out = repeats}), repeats))
assert(repeats[3][2] == 10)
```

`lr.vecmat(a, b)` contracts the last dimension of a vector with the
penultimate dimension of a matrix. `lr.vecdot(a, b)` contracts the last
dimension of both inputs. Both conjugate the first input for complex dtypes.
`lr.vdot(a, b)` also conjugates the first input and flattens both arrays in
C order before the contraction.

```lua
local a = lr.array({lr.complex(1, 2)})
local b = lr.array({lr.complex(3, 4)})
assert(lr.vecdot(a, b) == lr.complex(11, -2))
assert(lr.vdot(a:reshape({1, 1}), b) == lr.complex(11, -2))
```

`matvec`, `vecmat` and `vecdot` accept an output ndarray or a table with an
`out` field. Its core dimensions must match, and leading output dimensions may
extend the broadcast batch. A supplied output is returned. Scalar results
without an output array use LuaRay scalar conventions. Use `lr.linalg.vecdot`
with a one-based or negative axis to contract another dimension.

## Validation

**2,326 cases / 25,300 checks** passed with NumPy 2.5.5. The tests compare typed conjugation, batch broadcasting, strided and overlapping outputs, empty contractions, scalar products and rank-64 inputs. The existing linalg matrix corpus also ran against the new contraction path.
