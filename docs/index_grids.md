---
docs_examples: true
---
# Coordinate grids and index locations

`lr.indices` builds coordinate grids. `lr.ix_` builds an open mesh from vectors.
`lr.argwhere` groups nonzero locations into rows. They use the existing native
range, layout, assignment and nonzero engines through a Lua module.

## Coordinate grids

```lua
local lr = require("luaray")
local coordinates = lr.indices({2, 3})
local rows, columns = coordinates:get(1), coordinates:get(2)
assert(rows:tolist()[2][3] == 1)
assert(columns:tolist()[2][3] == 2)
assert(coordinates.shape[1] == 2 and coordinates.flags.owndata)
```

Coordinate **values start at zero**, preserving NumPy's numerical grid data.
Lua array indexing arguments start at one; add one to these values when using
them as Lua indices. The leading output axis selects the coordinate grid. For
`{2,3}`, the result has shape `{2,2,3}`: the first grid varies along rows and the
second along columns. The default dtype is native `intp`.

Use `lr.indices(dimensions, dtype, options)` or put dtype in the options table.
Dimensions are a dense table of Lua integers. Only `dtype` and Boolean `sparse`
are supported options. A dtype string or descriptor is accepted.

```lua
local sparse = lr.indices({2, 3}, {dtype="float32", sparse=true})
assert(sparse[1].shape[1] == 2 and sparse[1].shape[2] == 1)
assert(sparse[2].shape[1] == 1 and sparse[2].shape[2] == 3)
local sum = sparse[1] + sparse[2] -- Native broadcasting to {2,3}.
assert(sum:tolist()[2][3] == 3)
assert(not lr.shares_memory(sparse[1], sparse[2]))
```

Sparse output is a Lua table containing one array per axis. Each is a view of
its own range allocation; other axes have length one. Dense output owns its
allocation. Dense grids can describe up to 63 dimensions because the leading
coordinate axis also counts; sparse grids support 64. Empty dimensions and
rank-zero dimension lists follow the source constructor rules. In the source's
sparse path, negative range stops can reshape into empty axes; dense allocation
rejects negative dimensions. Sparse rank-zero output is `{}` and does not inspect
an unused dtype. Supported dtype behavior follows modern arange, including its
Boolean length restriction and temporal/string restrictions.

## Open index meshes

```lua
local matrix = lr.array({{10,11,12}, {20,21,22}, {30,31,32}})
local mesh = lr.ix_({1, 3}, {false, true, true})
local selected = matrix:get(table.unpack(mesh))
assert(selected:tolist()[1][1] == 11)
assert(selected:tolist()[2][2] == 32)
assert(mesh[1].shape[1] == 2 and mesh[1].shape[2] == 1)
assert(mesh[2]:tolist()[1][1] == 2)
```

Every input must become a one-dimensional array. Numeric values and dtypes are
preserved; Boolean vectors become selected **one-based positions**, following
`lr.nonzero`. Supply Lua positions such as `{1,3}` when using the mesh for array
indexing. The result is a Lua table of reshape views, one active axis per input.
Numeric inputs share storage with their output mesh views. Boolean selections
use new coordinate storage. An ordinary empty Lua table becomes an intp array;
an already typed empty array keeps its dtype. Inputs with other dtypes can form
views, but the array indexer still requires valid index arrays.

## Group nonzero locations

```lua
local locations = lr.argwhere(lr.greater(matrix, 20))
assert(locations.shape[1] == 5 and locations.shape[2] == 2)
assert(locations:get(1,1) == 2 and locations:get(1,2) == 2)
assert(not locations.flags.owndata and locations.flags.f_contiguous)
assert(not lr.shares_memory(locations, matrix))
```

Each row contains the one-based location of a nonzero value, in logical C order.
For input rank N, output shape is `{selected_count,N}`. It is a writable view of
new coordinate storage and does not share input data. A scalar true value gives
shape `{1,0}`; a false scalar gives `{0,0}`. Nil is a false scalar; omitting the
argument is an error. Array truth conversion includes nonzero NaN/NaT values.
Use `lr.nonzero(a)` when you need separate arrays for advanced indexing;
`argwhere` is a matrix of coordinate rows.

```lua
assert(lr.argwhere(true).shape[1] == 1)
assert(lr.argwhere(true).shape[2] == 0)
assert(lr.argwhere(nil).shape[1] == 0)
local values = lr.array({1, 3})
local retained = lr.ix_(values)[1]
values = nil
collectgarbage("collect")
retained:set(2, 1)
assert(retained:tolist()[1] == 2)
```

Views retain their native buffers after collection of the original userdata.
Read-only input views preserve their flags; new Boolean coordinate results are
writable. Normal indexed writes can change input storage through a mesh view.

## Verification and scope

NumPy 2.5.3 references passed **6,063 cases / 474,263 checks**: indices
1,344 / 352,179; ix_ 2,539 / 79,816; argwhere 2,180 / 42,268. They compare
values, dtypes, shape/strides/flags, sharing and real writes/backing states,
including empty, scalar, read-only, strided and high-rank inputs. Numerical grid
values are unchanged. Reference Boolean mesh locations were normalized on
**438 axes**, and **13,671 argwhere coordinate values** were shifted to the
existing one-based Lua location convention. Metadata remains directly compared;
longdouble values omit ABI padding. All three corpora regenerate exactly. The
permanent Lua regression adds 150 checks.

The APIs remain partial. General object/structured/StringDType, foreign array
protocols, every nested sequence coercion, all host ABIs and Python keyword or
shape-object protocols are unsupported or uncertified. These functions do not
claim complete behavior for every operation subsequently applied to their arrays.
