---
docs_examples: true
---
# Inspect layout and control write permission

`array.flags` reports the native array's layout, alignment, ownership and write
permission. `array:setflags` changes write permission or the alignment flag
without copying storage or rearranging elements.

## Read flags

```lua
local lr = require("luaray")
local matrix = lr.arange(6):reshape({2, 3}):copy()
assert(matrix.flags.c_contiguous and matrix.flags.owndata)
assert(not matrix.flags.f_contiguous)
local column_major = lr.asfortranarray(matrix)
assert(lr.isfortran(column_major))
assert(not lr.isfortran(lr.array({1, 2})))
```

C- and F-contiguous can both be true for scalars, vectors, singleton dimensions
and empty arrays. `lr.isfortran(array)` means F-contiguous and **not** C-contiguous.
It accepts an ndarray, without implicitly converting other Lua values.

The flags object exposes `c_contiguous`/`contiguous`, `f_contiguous`/`fortran`,
`owndata`, `aligned`, `writeable`, `writebackifcopy`, `fnc`, `forc`, `behaved`,
`carray`, `farray` and the native bitmask `num`. Uppercase NumPy mapping names
and short aliases such as `flags["C"]`, `flags["W"]` and `flags["A"]` are accepted.
Lua attributes and string indexing share one namespace. Unknown keys raise.
Composite predicates follow the pinned source, including its FARRAY predicate.
`writebackifcopy` is false: this engine does not expose that ownership protocol.

## Lock a root and its views

```lua
local view = matrix:view()
assert(matrix:setflags({write = false}) == nil)
assert(not matrix.flags.writeable and view.flags.writeable)
view[1][1] = 9
assert(matrix[1][1] == 9)
view:setflags(false)
assert(not pcall(function() view:setflags(true) end))
matrix:setflags(true)
view:setflags(true)
assert(view.flags.writeable)
```

A lock applies to that array header. Earlier writable views keep their own
permission. Re-enabling a locked view consults the owning root's current logical
permission, retained even if its original Lua userdata is collected. An owning
array can re-enable its writable allocation. String-backed storage is physically
immutable and cannot be made writable. Buffer-backed array views obey their
storage root. A read-only imaginary array for real input begins with a locked
owning root; its views cannot unlock until that root does.

## Alignment and failed changes

```lua
local bytes = string.pack("i4i4", 1, 2)
local unaligned = lr.frombuffer("x" .. bytes, "int32", 2, 1)
assert(not unaligned.flags.aligned)
assert(not pcall(function() unaligned:setflags(nil, true) end))
local readonly = lr.frombuffer(bytes, "int32")
local previous = readonly.flags.num
assert(not pcall(function() readonly:setflags(true, false) end))
assert(readonly.flags.num == previous)
```

`setflags(write, align)` accepts optional Boolean values; nil leaves an option
unchanged. The options form is `setflags({write = false, align = false})`.
Clearing ALIGNED is allowed even when storage is aligned. Setting it checks the
actual address and used strides; empty arrays are aligned. When enabling write
permission fails, preceding alignment changes are rolled back. Re-enabling a
flag does not copy or realign memory. Both operations return nil.

## Saved flag objects are snapshots

```lua
local saved = matrix.flags
saved.writeable = false
assert(saved.writeable and not matrix.flags.writeable)
saved.writeable = true
assert(matrix.flags.writeable)
```

Following NumPy 2.5.3, each flags object keeps the bits captured at creation.
Writing its `writeable` or `aligned` field modifies the referenced array, while
the saved snapshot stays unchanged. Read `array.flags` again for current bits.
The flags object retains its array through garbage collection. Equality compares
snapshot bits. The Lua text representation is descriptive rather than Python's
multiline representation.

Other flags are read-only. `uic`/WRITEBACKIFCOPY mutation is explicitly unsupported;
its Python base-detachment/writeback protocol is not approximated. Flag options
must be Lua Booleans rather than arbitrary Python truth-convertible objects.
Object/subclass warning protocols and full Python flag-object behavior remain
uncertified. This API is partially compatible, with differential evidence for
layout, state changes, saved snapshots, alignment and failure rollback.
