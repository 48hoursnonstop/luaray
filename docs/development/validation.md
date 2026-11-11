# Validation

## Released baseline

[LuaRay 0.116.0-dev](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
passed a clean source extraction and rebuild, all **161 differential fixture
files**, and **19 public Lua examples**. The exact release commit also passed
[GitHub CI](https://github.com/48hoursnonstop/luaray/actions/runs/42567717315).

The release added 8,141 cross/meshgrid cases and 787,265 checks. General complex
cross comparisons use fixed budgets of 6e-7 for complex64 and 2e-15 for wider
complex types, scaled by `max(1, abs(component))`. Metadata, ordinary exact
references, and grid state comparisons retain exact assertions. The
[vector/grid reference](../vectors_and_grids.md) describes the contract.

The directed ASan/UBSan audit passed with **38 C units and one C++ unit**,
20 native suites, and 78 Lua suites. Other linked dependencies were not fully
instrumented; leak detection was disabled. This audit does not certify every
algorithm, external BLAS/LAPACK routine, host ABI, or floating-point environment.

## Reproduce checks

```sh
make -j4 full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make examples
make reference-test
```

`full-test` executes the maintained native and Lua regressions. `reference-test`
obtains the immutable 0.116 source archive, verifies SHA-256, and executes its
161 differential fixture files plus extended random and formatting references
against the current engine. The generated data is cached outside the tracked tree.
Both targets run without Python or NumPy.

The complete oracle generators and directed sanitizer tooling remain in the
[released source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
Use that separate workspace to regenerate fixtures or reproduce the historical
`sanitize-vector116` audit. Recent generators assert NumPy 2.5.3; older fixtures
retain their original NumPy 2.3.5 attribution.

`compatibility/current.json` records the release-specific behavioral evidence.
`compatibility/api_inventory.json` records runtime availability. The latter
reports 376 of 675 scoped names as available and classifies all available APIs
as partial; it is not a measure of overall NumPy completion.

## Current source-tree checks

LuaRay **0.128.0-dev** passed **55 native suites**, **98 Lua suites**, seven public
examples and 102 executable documentation blocks. Diagonal references retain **47,886 cases / 4,571,474 checks**. Trace references
passed **20,861 cases / 853,519 exact checks** against NumPy 2.5.3, including
metadata, dtype/output resolution, aliasing, temporal units and backing states.

Triangular references passed **18,142 cases / 1,754,183 exact checks**, including
batch storage order, typed mask conversion, empty axes, and extreme index rules.

Vandermonde references passed **11,584 cases / 441,741 checks**. Ordinary cases
and metadata compare exactly; general random floating/complex values use a fixed
relative3e-15 budget. Observed absolute and relative numerical errors were zero.

Identity/eye references passed **13,335 cases / 261,220 exact checks**, including
C/F order, dtype conversion, offsets, empty axes and temporal unit requirements.

Diagonal-index and scalar-string references passed **1,766 cases / 81,899 exact checks**, including one-based coordinate adaptation, repeated-vector identity, real advanced writes, fixed-width scalar assignment and constructor formatting.

Triangular-index helpers passed **9,908 cases / 487,084 exact checks**, covering independent contiguous vectors, rectangular/empty dimensions, extreme offsets, advanced read/write and backing states across dtypes and views.

Fill-diagonal references passed **29,960 cases / 1,292,460 exact checks**, including logical flat traversal, repetition/wrap, scalar/typed conversion differences, read-only destinations and progressive shared-memory values.

Kronecker/integer-duration references passed **13,776 cases / 1,018,781 checks**. General random complex64 kron values use relative3e-7 and wider values3e-15, with observed error zero. Integer-duration tests cover NaT, coefficient casts, masks, unit-conversion bounds, defined overflow writes and buffer boundaries. In **176 buffered conversion failures**, NumPy produced nondeterministic uninitialized suffixes; those cases compare only the defined prefix and full metadata. The observation log is a separate release asset.

Tensordot executed **22,615 cases / 2,304,132 checks**: **22,461 parity-eligible cases**, plus **154 object-result cases explicitly blocked**. General random contractions use absolute+relative3e-6 for float32/complex64 and2e-12 for wider types. Observed maxima were absolute1.9073486328125e-6 and relative1.3520483676605e-5. BLAS result zeros accept either sign, with44 observed differences; input and non-BLAS result zero signs remain exact. Tests cover the native output-rank guard and legacy duration-dot units/wrapping.

Callback-mask references passed **2,551 cases / 152,065 exact checks**, covering real callback inputs, parameter forwarding, numeric/text/temporal masks, view layouts, one-based coordinates, actual indexed writes and the explicit Lua-sequence adaptation. The API inventory now probes the public Lua entry point, including Lua-composed functions.

Finite differences and join layouts passed **56,404 cases / 2,620,156 exact checks**:34,210 diff/ediff1d cases and22,194 concatenate/stack cases. Scope includes padding, identity, real writable/backing states, Boolean/unsigned/time dtypes, NaT/nonfinite values, empty dimensions and C/F/strided layouts. The maximum Lua order was executed locally; the matching enormous NumPy loop was not run.

The directed ASan/UBSan run instrumented `ln_join`, `ln_condition`, `ln_dot`, `ln_matrix`, `ln_linalg`, `lua_matrix`,
`lua_module`, `ln_time_scale`, `ln_ufunc`, `ln_nditer_multi` and `ln_datetime`, plus the native matrix test and Lua runner. All maintained tests
and all fourteen cumulative matrix corpora passed. Other native dependencies were not fully
instrumented; leak detection was disabled. This is a directed audit, not an
all-dependency memory-safety certification.

## Release integrity

Release assets include a source archive, its SHA-256 checksum, and a separate
verification JSON. The archive contains `PROJECT_SHA256SUMS`, generated during
packaging. This manifest is not kept in the working tree, where ordinary edits
would immediately make it stale.

The release tooling preserved in the source package verifies the embedded
manifest after extracting the archive,
then builds and executes its checks from that clean source directory. Verified
assets and release tags remain immutable.
