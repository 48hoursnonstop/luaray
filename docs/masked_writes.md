# Copying and positional masked writes

LuaRay 0.99 corrects the native `copyto` and `putmask` behavior introduced in
0.97. See also [indexed and selected writes](writing.md). Runtime remains Lua
and native libraries; NumPy/Python are development references only.

## `lr.copyto(destination, source, casting, where)`

`source` accepts an ndarray, rectangular Lua table or scalar and broadcasts to
the destination. Extra leading singleton source dimensions are stripped.
`casting` defaults to `same_kind`; supported strings are `no`, `equiv`, `safe`,
`same_kind` and `unsafe`. Pass `nil` to keep that default while supplying `where`.
`same_value` is not a supported copyto mode in the pinned NumPy release.
Returns `nil`.

```lua
local lr = require('luaray')
local matrix = lr.zeros({3,4}, 'float32')
lr.copyto(matrix, 1.5, 'no', {1,0,1,0})
assert(matrix:get(1,1) == 1.5 and matrix:get(1,2) == 0)
```

Numeric literals keep weak-scalar promotion: integers can materialize in an
existing numeric dtype; floating literals follow existing floating/complex
dtypes. Thus copying 1.5 to float32 under `no` succeeds; `equiv` rejects changing
the default scalar descriptor to float32. Explicit ndarrays obey their actual
dtype's casting policy. Narrow scalar integer bounds are checked even with an
all-false mask. Weak timedelta scalars follow direct construction rules and
reject floats/complex values even when an unsafe array conversion could work.

Masks broadcast independently. Lua inputs construct boolean masks directly and
accept numeric lists, strings and complex values. Explicit ndarray masks require
safe conversion to bool, rejecting integer/floating arrays. Boolean views retain
their storage and strides. An omitted mask selects all elements.

### Traversal and errors

The C loop follows destination-stride axis order, normalizes negative strides,
coalesces dimensions, protects overlapping sources and reverses suitable 1D
overlaps. It scans mask runs during execution; an aliased mask may observe earlier
writes. Shared zero-stride views have original reference cases.

Errors can leave earlier writes applied. Legacy text conversions needing aligned
temporary storage follow upstream's 128-element buffers: completed blocks remain,
a failing block is discarded. Descriptor width/alignment/traversal determine
buffering. Actual post-error arrays are tested for U1/U3/U4/U8/S3 around positions
127, 128 and 129.

Scalar conversion can precede masking: an invalid scalar string copied to a
multi-element integer array fails even with `where=false`; at size one the
unselected conversion is skipped. There is no universal atomicity guarantee.

Exact non-scalar array self-copy returns immediately even for read-only arrays,
following upstream's redundant-assignment shortcut. Other read-only writes fail;
zero-dimensional self-copy still follows scalar assignment. Unsafe complex-array
conversion to datetime/timedelta uses the real component, with nonfinite or
out-of-range real values producing NaT.

## `lr.putmask(destination, mask, values)`

Operands flatten in logical C order. The destination must be writable; the mask
must have the same element count, but need not have the same shape. Array and Lua
masks are force-converted to bool. Nonzero numbers, nonzero complex values and
nonempty strings are true.

Values repeat by **destination position**, advancing even at false positions.
`place` instead advances only at selected positions:

```lua
local a = lr.arange(4, 'int32')
lr.putmask(a, {1,0,1,0}, {9,8}) -- {9,1,9,3}
```

Ndarray values require safe dtype conversion; Lua scalar/table values are packed
directly with normal bounds checks. An empty Lua table is a no-op even if the
mask selects positions. An empty float64 ndarray still fails safe conversion to
integers. Overlapping values/masks and noncontiguous destinations use protected
C-order destination copies and writeback, unlike place's live compatible values.
Returns `nil`.

## Evidence and scope

Run `make full-test` for maintained C/Lua regressions and `make reference-test`
for the external frozen corpus. NumPy 2.5.3 generated 4,914 copyto and 1,481
putmask cases: 175,110 comparisons, plus 77 targeted Lua checks and C tests.
The original directed audit instrumented three changed C units; external
dependencies were not fully instrumented and leak detection was disabled.

No complete NumPy compatibility is claimed. Non-native numeric descriptors,
object/structured dtypes and full warning/exception-class fidelity remain pending.
The 40 recorded byte-order states remain explicitly blocked, outside parity totals.
