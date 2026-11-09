# Indexed gathering: take

LuaRay 0.100.0-dev implements `np.take` and `ndarray:take` in its native C engine.
Python is used only to generate development reference fixtures.

```lua
local np = require('luaray')
local a = np.array({{1,2,3},{4,5,6}}, 'int32')
local ends = a:take({1,-1}, {axis=2}) -- {{1,3},{4,6}}
local last = np.take(a, -1)          -- 6, after C-order flattening
local out = np.zeros({2,3}, 'float64')
assert(np.take(a, {-1,1}, {axis=1,out=out}) == out)
```

## Signature and coordinates

`np.take(input, indices [, axis_or_options])` and
`input:take(indices [, axis_or_options])` share the same implementation.
The third argument is a positive/negative axis or a table with `axis`, `mode`
and `out` fields. Omitted, nil or false `axis` flattens the input in C order.
Positive axes and indices start at **1**; negative coordinates count from the
end. Axis/index zero is invalid. Index zero is rejected when traversed; an
empty result may skip traversal. Negative axes are normalized before gathering.

For an explicit axis, the result shape replaces that axis with `indices.shape`.
A scalar index removes the selected axis. With flattening, the result shape is
`indices.shape`. A zero-dimensional result without `out` becomes a Lua scalar
(or the existing complex/date/timedelta scalar representation). With `out`,
the same ndarray is returned, including a zero-dimensional output.

The source can be an ndarray or supported Lua scalar/nested table. Ordinary
Lua index values are packed into native signed pointer-width integers. Strongly
typed index ndarrays use NumPy's **same_kind**, rather than put's safe, casting:
floating index arrays are rejected; supported integer arrays, including uint64,
are converted. Full-width unsigned values can be constructed through native
astype; a Lua integer cannot directly represent every uint64 value.

## Bounds modes

- `raise` (default): negative indices count from the end; out-of-range indices
  raise an error.
- `wrap`: coordinates are translated to zero-based internally, then reduced
  modulo the selected axis size. Negative coordinates wrap too.
- `clip`: translated coordinates are clamped to the first/last element.
  Negative indices select the first element, as in NumPy clip mode.

Scalar/table indices, multidimensional indices, empty shapes, transposed,
reversed and zero-stride sources are included in the frozen reference corpus.
A returned ndarray without `out` is an independent C-contiguous copy.

## Output, overlap and errors

`out` must be writable and have the exact result shape. Source and output dtype
may differ under the supported legacy unsafe conversion rules. Noncontiguous,
unaligned, overlapping or differently typed output uses temporary storage;
raise mode also stages its output. Existing output values are converted to the
source dtype **before** gathering. Thus an output filled with invalid numeric
strings can fail even though gathering would replace every value.

Invalid indices in raise mode leave staged output unchanged. A later cast-back
failure can partially update output: successfully converted elements remain,
while the scalar with an ASCII encoding failure retains its previous bytes.
String conversion validates the whole source, including characters beyond the
destination's truncation boundary, and preserves embedded NUL characters.

Compatible contiguous output in wrap/clip mode can share memory with indices.
Each selected index is read once before its entire trailing chunk is copied.
Writing that chunk can change a later index. Tests preserve this upstream
behavior rather than assuming all inputs are snapshotted. Source overlap is
protected separately.

## Evidence and limits

The original audit covered a native C suite, 63 Lua checks and **6,704 NumPy
2.5.3 cases / 324,615 value and metadata checks**, including real errors and
post-error states. Run `make full-test` for maintained C/Lua regressions and
`make reference-test` for the external frozen corpus. These counts measure the
tested behavior, not overall completion.

A separate probe confirmed that NumPy 2.5.3 does not return within three seconds
for `take(zeros((3,0,0),int32), [0], axis=1, mode='wrap')`, after reaching the call.
LuaRay rejects this empty-axis situation with an error. Three Lua-coordinate
variants are retained outside the parity totals; only the representative call
was actually executed upstream. The bounded diagnostic is preserved with the
original development tooling in the [released source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).

Object/structured/new variable-width StringDType support, Python exception
classes, complete warning fidelity and non-native numeric byte order are not
claimed. The earlier 40 blocked numeric-endian states remain separate. See
`compatibility/current.json`, [validation results](../development/validation.md) and [historical release notes](https://github.com/48hoursnonstop/luaray/blob/v0.116.0-dev/PROGRESS_0_100.md).
