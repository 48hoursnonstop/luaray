# Typed memory views and byte export

LuaRay0.115.0-dev adds `a:view(dtype)`, `a:tobytes(order)`, `a.itemsize` and
`a.nbytes`. They operate on the ndarray's actual storage, without Python.

```lua
local lr = require('luaray')
local a = lr.array({1.0}, 'float32')
local bits = a:view('uint32')
assert(bits:tolist()[1] == 1065353216)
assert(lr.shares_memory(a, bits))
assert(a.itemsize == 4 and a.nbytes == 4)
assert(a:tobytes() == string.pack('f', 1.0))
bits:set(0, 1)
assert(a:tolist()[1] == 0.0) -- the same bytes changed
```

`view` reinterprets bytes; `astype` converts values. Omitting dtype or passing
nil creates a distinct ndarray header with the same dtype and shared owner.
Every view keeps storage alive independently of the original Lua userdata and
inherits readonly protection. Changing a temporal unit with view reinterprets
the tick count; it does not rescale it.

## Shape and storage rules

Equal-size dtype changes preserve shape and strides even for reversed,
broadcast or noncontiguous arrays. Changing itemsize adjusts the last axis only.
That axis must be contiguous unless its length is one or the array is empty.
A smaller itemsize must divide the original itemsize; a larger itemsize must
divide the last axis's byte count. Scalar arrays can only change to equal-size
dtypes. Empty arrays still obey last-axis divisibility rules.

Native overflow checks protect dimensions and byte counts. Numeric, complex,
fixed bytes/Unicode and temporal descriptors are supported; string widths remain
explicit rather than inferred from content. Unsized S0/U0 targets are rejected
when their zero itemsize cannot satisfy the source's rules.

A reinterpreted address may be unaligned for its new dtype. Alignment flags are
recomputed from the address and used strides; singleton strides are ignored and
empty arrays are aligned. Scalar numeric loads/stores use memcpy, ufunc/legacy
iterators stage unaligned operands, and reductions/accumulation/reduceat use
aligned working values. Directed tests execute actual Lua operations on byte
offsets one and three. This is separate evidence from the raw view itself.

## Binary strings and traversal

`tobytes()` returns a Lua binary string, including embedded NUL and dtype
padding. It copies data; changing the returned Lua string cannot change the
array. It exports logical elements rather than unused gaps in a strided view.
The optional argument is an order string or `{order='F'}`. Letters are
case-insensitive. Nil/default means C order. Invalid/unknown options raise.

- C: last axis varies fastest.
- F: first axis varies fastest.
- A: F for exclusively Fortran-contiguous input, C otherwise.
- K: matches NumPy2.5.3's dtype-dependent implementation: numeric, fixed bytes
  and temporal arrays export C order; Unicode uses ravel's KEEPORDER traversal.

For example an F-contiguous Unicode array can export different bytes for C and
K. This behavior follows the pinned source rather than assigning a new meaning
to K. Invalid Unicode code points can be viewed/exported as raw bytes without
forcing a conversion to Lua UTF-8 text.

## Verified scope and limitations

Original frozen references cover metadata, C/F/A/K byte strings, aliasing,
readonly behavior and actual backing storage after writes. All backing bytes are
initialized as uint8 before reinterpretation, so floating padding and arbitrary
Unicode bits are tested without converting them to text. Separate mathematical
references compare unaligned arithmetic, reductions and cumulative operations.

Frozen raw-byte references use the oracle's little-endian x86-64 ABI. Arbitrary
host layouts and long-double ABIs are not certified. Export includes padding;
independently constructed long-double values may have different padding bytes
without differing mathematically. Complete ABI portability, SIMD/FP status,
all downstream unaligned algorithms and foreign-memory providers remain pending.

Lua accepts dtype strings or [native descriptors](dtypes.md), without Python ndarray subtype/type arguments. Object,
structured/subarray/void and variable-width StringDType arrays remain unavailable,
as does non-native numeric endian. Fixed Unicode endian is retained. No Python
pickle/file serialization is implied. Runtime availability remains partial;
see compatibility records and [validation results](development/validation.md) for executed checks.

[Swapping bytes](byteswap.md) describes payload mutation without changing the dtype.
