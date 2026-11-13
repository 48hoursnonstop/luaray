# FFT frequencies, spectrum shifts and Hermitian transforms

The `lr.fft` namespace executes through native LuaRay arrays, C helpers and the
bundled C++ PocketFFT engine. Python/NumPy are development oracles only.

```lua
local lr = require('luaray')
local frequencies = lr.fft.fftfreq(4, 0.5) -- {0, .5, -1, -.5}
local centered = lr.fft.fftshift(frequencies)
local restored = lr.fft.ifftshift(centered)
local spectrum = lr.fft.hfft({1, 2, 3}) -- {8, -2, 0, -2}
local samples = lr.fft.ihfft(spectrum)
```

## Frequencies

`fftfreq(n, spacing)` returns integer bins multiplied by `1/(n*spacing)`.
Even lengths place the negative Nyquist bin at the start of the negative half;
odd lengths contain equal positive/negative bin counts. `rfftfreq` returns
`n//2+1` nonnegative bins, including the positive Nyquist bin for even lengths.
Spacing defaults to1.0. `n` must be a Lua integer; lengths and bins are native
signed pointer-width integers. An explicit device argument is not implemented.

Ordinary numeric/complex Lua spacing follows scalar division-by-zero rejection.
Typed ndarray spacing executes native multiply/divide ufuncs with weak n and1.0
operands; dtype overflow, rounding, broadcasting and IEEE NaN/Inf follow the
array operations rather than forced float64 arithmetic. Thus zero-dimensional
float32 spacing differs from ordinary Lua floating spacing at intermediate
rounding points. Bin multiplication determines the final dtype. Spacing tables
are rejected; construct an ndarray for supported array spacing.

Boundary behavior is intentionally source-derived: fftfreq rejects negative n;
rfftfreq with negative n can be empty. Raw finite spacing rejects n=0, while
typed spacing can produce empty fftfreq or a one-bin NaN rfftfreq. Nonfinite raw
spacing uses IEEE arithmetic. Boolean n is rejected by fftfreq's allocation;
rfftfreq accepts its integer-like boolean path. Full warning fidelity is not
claimed, including IEEE divide warnings and all scalar types.

## Shifts

`fftshift(input, axes)` and `ifftshift(input, axes)` copy into newly owned arrays.
The input may be an ndarray or an array-like Lua table. Omitted/nil axes select
all dimensions; one integer or a table of integers select explicit dimensions.
Axes use Lua's1-based positive coordinates or negative coordinates from the
end. An empty axes table copies without shifting. Duplicate axes accumulate
shifts. For odd lengths, forward and inverse shifts differ by one element;
composing them restores the original values. Empty axes/dimensions are tested.
Zero-dimensional inputs are rejected, matching the pinned upstream path.

The native roll engine supplies KEEPORDER allocation and actual strides for
transposes, reversed/sliced arrays, zero-stride broadcasts and3-D permutations.
Fixed strings, temporal arrays, booleans and complex values retain their bytes.
Inputs remain unchanged and the result does not share their storage.

## Hermitian transforms

`hfft(a, options)` transforms a Hermitian time-domain signal to a real spectrum.
It composes a KEEPORDER conjugate copy with irfft and a swapped normalization.
`ihfft(a, options)` composes rfft and output conjugation. Both support:

```lua
lr.fft.hfft(a, {n=8, axis=-1, norm='ortho', out=destination})
lr.fft.ihfft(a, 8, -1, 'backward', destination)
lr.fft.fft(a, nil, 1, 'forward') -- nil n retains subsequent arguments
```

Options: n, axis, norm and out. Default axis is the last. Default hfft n is
`2*(axis_length-1)`; default ihfft n is the input axis length. Supply an explicit
odd n when needed to retain the odd-length interpretation. Norm accepts
backward (default), forward or ortho. Positive/negative axes follow the shift
convention. Invalid lengths, axes, norms and extra positional arguments raise
Lua errors. Array-like inputs are supported by the1-D FFT entry points.

`out` returns the original destination identity and supports tested positive
strided views and hfft real input/output aliasing. Read-only destinations are
rejected before writing. Shape/dtype conversion and input errors are tested
against actual NumPy execution; every possible alias, multidimensional output
broadcast, dtype and exception ordering is not certified.

The input dtype controls normalization precision, including float16 rounding.
Exact complex FFT and exact real rfft input loops keep their compute precision
even with a wider destination. Non-exact inputs can select a wider loop. An
explicit float32 irfft/hfft destination avoids a second float16 rounding. Invalid
text input is rejected before output-driven promotion/normalization. Complex
input to ihfft/rfft is rejected. Bool hfft conjugation follows the upstream
int8 intermediate.

## Evidence and limits

Original NumPy2.5.3 fixtures:826 frequency cases /28,419 checks,1,800 shift
cases /86,698 checks and6,964 transform/output cases /343,993 checks. The last
corpus also tests existing fft/ifft/rfft/irfft precision and positional nil n.
Result/input/output values, shape, dtype, strides, actual acceptance and output
identity are checked. Native boundary tests and111 direct Lua checks add
regressions for zero-stride order, half rounding, widened float32 computation,
read-only outputs and unsupported text input.

Shifts compare values exactly. Frequency numeric checks use absolute/relative
2e-12 (or3e-6 for float32/complex64 output); the observed maximum error is zero.
Transforms use3e-6 absolute plus relative tolerance for float32/complex64 and
2e-12 for wider output. Observed transform maximum absolute error is
1.9073486328125e-6 within the explicit float32 tolerance; wider-output regression
values are also checked exactly for the known compute-precision defects. These
tolerances permit arithmetic/FFT implementation rounding, not dtype/layout drift.
Run `make reference-test` for the external frozen corpus. Original generators
are preserved in the [released source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).

All18 scoped FFT callable names are available; all remain partially compatible
in the machine-readable inventory. Name availability is separate from complete
behavior. Object/structured/variable-width strings, non-native numeric endian,
complete warnings/subclasses/device API, every out alias and every dtype-length
combination remain outside the verified contract. See `compatibility/current.json`
and the API inventory. Earlier explicit differences retain their classifications.
