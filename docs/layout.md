# Array layout, reshape, ravel and flatten

LuaRay 0.110.0-dev implements NumPy 2.5.3 layout rules in an independent native
subsystem. Public Lua bindings compile separately through the existing ownership
bridge. Internal C-order reshape delegates to the same implementation.

```lua
local lr = require('luaray')
local a = lr.array({{0,1,2},{3,4,5}}, 'float64')
local columns = lr.ravel(a, 'F') -- {0,3,1,4,2,5}
local rows = a:ravel() -- shares a's buffer
local independent = a:flatten() -- always copies
assert(lr.shares_memory(rows, a))
assert(not lr.shares_memory(independent, a))

local transpose = lr.transpose(a)
local view = transpose:reshape(6, {order='F', copy=false})
assert(lr.shares_memory(view, a))
local copied = lr.reshape(a, {3,2}, {order='F', copy=true})
```

| Lua call | Default | Storage contract |
| --- | --- | --- |
| `lr.reshape(a, shape, options)` | C, copy if needed | Reuse compatible strides or copy in the requested logical order |
| `a:reshape(shape, options)` | Same | Same native implementation |
| `lr.ravel(a, order)` / `a:ravel(order)` | C | Contiguous rank-one view when possible; otherwise a copy |
| `a:flatten(order)` | C | Independent writable rank-one copy |

`shape` is an integer or a Lua table of dimensions, including an empty table
for rank zero. A single negative dimension infers the missing extent; multiple
negative dimensions, ambiguous zero-size inference and size mismatches fail.
The supported maximum rank is 64. Size/stride products are checked for overflow.
This API uses one shape argument rather than NumPy's historical variadic method
arguments.

Reshape options are `{order='C', copy='if_needed'}`. `copy=false` rejects a
necessary buffer copy; `copy=true` always creates independent storage, even for
an unchanged shape. A string order can replace the options table. For reshape,
C/F/A are accepted and K is rejected. A chooses F only when the input is
Fortran-contiguous without also being C-contiguous; otherwise it chooses C.
Order changes element traversal, not merely a metadata label. Ordinary Lua
inputs use the existing constructor before reshaping; `copy=false` applies to
that reshape step, so it does not forbid initial table-to-array conversion.

Ravel/flatten accept C/F/A/K either as an order string or `{order='K'}`.
C visits the last logical axis fastest, F the first. K follows stable physical
stride ordering while retaining logical traversal along negative strides;
broadcast zero strides remain ambiguous and retain the iterator's stable
ordering. Ravel's view check also requires truly contiguous positive storage.
A one-dimensional strided/reversed input can therefore reshape as a view while
ravel needs a copy. A fully contiguous permuted multidimensional input can
ravel as a K-order view even when neither its C nor F flag is set.

## Sharing, ownership and writeability

```lua
local reversed = lr.flip(a:ravel(), 1)
local view = reversed:reshape({2,3}, {copy=false})
assert(lr.shares_memory(view, a)) -- strides {-24,-8}
assert(not lr.shares_memory(reversed:ravel('K'), a))
```

Returned arrays have their own headers. Views retain the buffer independently
of the original Lua userdata's lifetime. Views preserve read-only status; new
copies are writable. Writing through a view changes the original storage;
writing through a copy does not. Zero-size arrays have no shared bytes even
when their headers retain the same owner, so `shares_memory` returns false.
Empty flatten allocations and empty reshape views can legitimately have
different strides; the reference tests check those exact constructor rules.

## Executed references and scope

Original NumPy 2.5.3 fixtures cover **25,134 cases / 1,759,008 checks**:
ravel 2,664 / 185,920; flatten 2,640 / 185,128; reshape 19,830 / 1,387,960.
Values, dtype, shape, strides, sharing, new object identity, actual writeability
and post-write input/backing states compare exactly. Inputs include twelve
dtypes (numeric, fixed S/U, non-native Unicode and temporal units), scalar and
empty arrays, singleton axes, transposes, multidimensional permutations,
reverse/strided views and read-only broadcasts. C/F/A/K, all reshape copy modes,
negative inference and invalid/overflowing shapes are exercised.

A native C suite and 61 directed Lua checks cover ownership after collection,
negative-stride views, invalid options including embedded NUL, maximum rank,
read-only propagation and the ravel/reshape distinction. Fixture generation
explicitly creates ndarray inputs: a NumPy scalar produced by 0-D arithmetic
must not accidentally stand in for a 0-D ndarray sharing reference.

All APIs remain `implemented_partial`. Complete subclass/device/foreign array
protocols, object/structured dtypes, every host integer/ABI variant, warnings and
all Python positional signatures remain unsupported or uncertified. Existing
constructor coercion limitations still apply. A successful layout audit does
not certify overall NumPy compatibility.

```sh
make -j4 full-test
make reference-test
```

Eight source/test hashes are pinned in [pinned source hashes](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256).
See [creation](creation.md) for array conversion and copying,
[binary mathematics](binary_math.md) for ordinary inputs, and the
[API inventory](api_inventory.md) for measured callable availability.

[Resizing arrays](resize.md) covers repeated copies and in-place allocation changes.
