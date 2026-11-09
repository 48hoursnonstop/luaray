# Gathering and writing along an axis

LuaRay 0.101.0-dev implements `np.take_along_axis` and `np.put_along_axis`
through its C ndarray and advanced-indexing engines. No Python runtime is used.

```lua
local np = require('luaray')
local a = np.array({{10,30,20},{60,40,50}}, 'int32')
local order = np.argsort(a, {axis=2})
local sorted = np.take_along_axis(a, order, 2)
-- sorted: {{10,20,30},{40,50,60}}
np.put_along_axis(a, {{2},{1}}, 99, 2)
-- a: {{10,99,20},{99,40,50}}
```

## Signatures

`np.take_along_axis(input, indices [, axis])` returns an independent ndarray.
The default axis is the last, matching NumPy since 2.3. An explicitly supplied
nil or false axis selects the flat-iterator path. `np.put_along_axis(input,
indices, values, axis)` requires that fourth argument, writes in place and
returns nil. These are namespace functions, matching NumPy's public functions.

Positive axes and indices start at **1**; negative coordinates count from the
end. Zero is invalid when traversed. Both functions use bounds checking rather
than wrap/clip modes. Use [take](take.md) for a common index list on an axis.

For an explicit axis, indices and input must have the same rank. Other
index/source dimensions broadcast **in both directions**; the selected result
dimension comes from the index array. For example, input shape `{3,4,1}` and
indices shape `{1,2,5}` on axis 2 produce result shape `{3,2,5}`. The native
implementation constructs orthogonal integer index arrays and uses MapIter.

Indices must have an integer dtype. Boolean, floating, complex and string
arrays are rejected, even if their contents look like integers. Compatible
Lua nested tables are inferred by the native constructor; an empty table has
its usual inferred dtype, so use an explicitly typed integer empty ndarray.
Unsigned pointer-width values follow native intp conversion before coordinate
normalization. Values outside the signed Lua range need native array casts.

## Values, memory order and overlap

Put values broadcast to the indexed shape. Typed ndarrays retain their dtype
and are converted by the assignment iterator. Ordinary Lua values are packed
into the destination dtype before assignment. In particular, an out-of-range
Lua integer fails instead of silently wrapping, whereas a strong typed integer
array can use unsafe conversion. Lua strings follow the existing S/U storage
contracts; full Python scalar and warning fidelity is not claimed.

Gathered results retain the iterator's memory-order decision. Fortran indices
can produce a Fortran result; C order resolves conflicting operand orders.
Values, shapes, dtypes **and strides** are checked against the original oracle.
Writing follows the same operand-driven order, including negative strides and
duplicate destinations. Do not assume a C-order loop for every assignment.

When indices or values overlap the destination, assignment protects them with
copies. This differs from the live index/output behavior of compatible take
output in wrap/clip mode. Duplicate target indices remain legal. For dtype
conversion, the all-fancy assignment path buffers up to **8,192 elements**;
a conversion error discards the current input buffer, while earlier committed
buffers remain written. Tests cover both sides of this boundary.

## Flattening and read-only views

The explicit nil/false axis follows NumPy 2.5.3's `np.array(input.flat)` behavior.
A C-contiguous source produces a shared flat view, preserving write permission.
A noncontiguous source produces a **read-only copy**. Gather works on either;
put rejects the latter, including transposed or reversed noncontiguous inputs.
A read-only contiguous source also rejects writes. Flattening requires a
one-dimensional index array. Scalar input is supported through explicit
flattening; an explicit/default ordinary axis on a scalar is invalid.

## Verification and limitations

The original audit covered native C tests, **85 Lua checks**, **2,061 original
NumPy 2.5.3 gather cases / 109,722 checks**, and **3,599 assignment cases /
430,929 checks**. This includes actual error acceptance and post-error backing
states, multidimensional/bidirectional broadcasting, F/reversed indices,
shared operands, empty shapes, scalar/table values and integer bounds.
The 63/64-index operand limit is also checked against upstream.

Run `make full-test` for maintained C/Lua regressions and `make reference-test`
for the external frozen corpus. Neither requires Python. Original generators and
directed sanitizer tooling remain in the [released source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev);
see [validation](development/validation.md) for audit limitations.

The general mixed slice/fancy-index iterator remains a separate compatibility
area; the new buffered path specifically covers all-fancy indexing. Numeric
non-native byte order, object/structured and variable-width StringDType arrays,
Python subclass behavior, complete exceptions/warnings and all NumPy API parity
remain incomplete. Earlier blocked states and deliberate take hang rejection
remain documented separately. These test counts are not an overall completion
percentage.
