---
docs_examples: true
---
# Iterating index positions

`lr.ndindex(shape)` returns a Lua iterator over one-based coordinate tables.
You can also supply dimensions as separate arguments. The last axis changes
fastest, matching C order. Each yielded table is a new snapshot.

```lua
local lr = require("luaray")
local positions = {}
for coordinate in lr.ndindex({2, 3}) do
  positions[#positions+1] = coordinate
end
assert(#positions == 6)
assert(positions[1][1] == 1 and positions[1][2] == 1)
assert(positions[4][1] == 2 and positions[4][2] == 1)
```

Use these positions directly with LuaRay indexing. This differs from the
zero-based numerical data produced by `lr.indices`; ndindex yields Lua array
locations. The shape is copied at construction, so later changes to its table
cannot change the iteration.

```lua
local values = lr.zeros({2, 3}, "int32")
for coordinate in lr.ndindex(values.shape) do
  values:set(coordinate[1] * 10 + coordinate[2], table.unpack(coordinate))
end
assert(values:get(2,3) == 23)
```

## Iterator state and boundaries

An empty shape has one position: `{}`. Any zero dimension makes the iterator
empty. Dimensions must be nonnegative Lua integers; Boolean dimensions map to
zero or one, following the reference range semantics. Sparse shape tables,
negative dimensions and floating dimension arguments are rejected.

```lua
local scalar = lr.ndindex()
assert(#scalar() == 0 and scalar() == nil)
local empty = lr.ndindex(2, 0, 3)
assert(empty() == nil)
local iterator = lr.ndindex(2, 3)
local first = iterator()
first[1] = 99
assert(iterator()[1] == 1) -- The returned table does not control iteration.
```

After exhaustion, subsequent calls keep returning nil. Separate iterators have
independent state. Coordinate tables can be retained or modified safely.
Only the copied shape and current coordinate are stored, using O(rank) memory;
axis values and the full Cartesian product are not allocated in advance.

```lua
local huge = lr.ndindex(math.maxinteger, math.maxinteger)
assert(huge()[2] == 1)
assert(huge()[2] == 2)
local shape = {}
for axis=1,1000 do shape[axis] = 1 end
local high = lr.ndindex(shape)
assert(#high() == 1000 and high() == nil)
```

The iterator itself can handle more dimensions than an ndarray. Array operations
retain their own rank and storage limits. Huge logical spaces can be consumed
as prefixes without an overflowing product counter; traversing the entire space
still requires one call per position. Dimensions remain bounded by Lua integers.

## Executed references and limits

The NumPy 2.5.3 reference passed **1,254 cases / 39,746 checks**, including both
constructor forms, C-order traversal, exhaustion, independent snapshots, scalar,
zero, Boolean and invalid dimensions, and high-rank spaces. **26,626 coordinate
values** were shifted to the existing one-based Lua index convention. Large
Cartesian products compare bounded prefixes; they are not reported as fully
traversed. Individual reference ranges are small to avoid the upstream
constructor's eager range allocation. Native Lua regressions separately verify
lazy construction with `math.maxinteger` dimensions; no upstream allocation of
those huge ranges was attempted. The corpus regenerates exactly; permanent
regressions add 91 Lua checks.

The API remains partial. It uses Lua generic-for/nil exhaustion instead of a
Python iterator/StopIteration object. General Python shape and `__index__`
protocols and integers beyond Lua's range are unsupported. All host ABIs and
resource-limit behavior are not certified. See [coordinate grids](index_grids.md)
for numerical grids and open meshes.
