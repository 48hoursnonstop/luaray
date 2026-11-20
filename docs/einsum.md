---
docs_examples: true
---

# Einstein summation

`lr.einsum(subscripts, operands..., options)` evaluates a tensor
contraction. Each letter labels one axis. Axes whose labels are
absent from the output are summed. If the output is omitted, labels
that appear exactly once are kept in alphabetical order.

```lua
local lr = require("luaray")
local a = lr.array({{1, 2}, {3, 4}})
local b = lr.array({{5, 6}, {7, 8}})
local product = lr.einsum("ij,jk->ik", a, b)
assert(lr.array_equal(product, {{19, 22}, {43, 50}}))
assert(lr.einsum("ii", a) == 5)
```

Repeated labels within one operand select a diagonal and require equal
axis lengths. An ellipsis matches unnamed axes, which broadcast from the
right. Include its ellipsis in the output when it represents one or
more axes. A single-operand permutation or diagonal without a sum
returns a view when `out` is omitted.

```lua
local diagonal = lr.einsum("ii->i", a)
assert(lr.shares_memory(diagonal, a))
local batch = lr.stack({a, b})
assert(lr.array_equal(lr.einsum("...ij,jk->...ik", batch, b), lr.matmul(batch, b)))
```

Pass `dtype` to choose the calculation dtype, `casting` to choose the
conversion rule and `order` to choose the result layout. The defaults
are safe casting and keep-order layout. Pass a writable ndarray as `out`
to store the result in that array. When no calculation dtype is given,
the output dtype participates in promotion. Contractions use the direct
native path. The supported subscript form is the string form.
