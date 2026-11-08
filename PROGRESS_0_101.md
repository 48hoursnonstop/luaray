# LuaRay 0.101.0-dev — along-axis gather and assignment

Native np.take_along_axis/np.put_along_axis share the existing C MapIter engine
through a separate orthogonal-index preparation subsystem. Lua public interfaces
accept one-based coordinates and table operands without a Python runtime.
English/Spanish contracts and executable examples are included.

## Actual validation

- take: 2,061 NumPy 2.5.3 cases / 109,722 checks.
- put: 3,599 NumPy 2.5.3 cases / 430,929 checks.
- 85 direct Lua checks and native C tests passed.
- Full native/Lua regression: 119 frozen differential files passed.
- Both generated reference files regenerated exactly.
- Directed ASan/UBSan: eight C units, four native / 19 Lua suites passed;
  expanded final references replayed successfully. Dependencies uninstrumented,
  leak detection disabled. Public native Lua example passed.
- Release tooling separately extracts source, checks the manifest, rebuilds,
  runs full regression and all four public writing/gathering examples. Its
  versioned verification JSON/log records that final gate and archive hash.

## Findings corrected

The initial differential audit exposed actual Fortran result-stride and ASCII
conversion error-state mismatches in the inherited advanced-index engine.
KEEPORDER allocation/iteration now considers index/value strides; full-fancy
assignment stages dtype conversion in 8,192-element buffers. Earlier buffers
remain written on later failure. Indices overlapping the destination are copied
before assignment, matching upstream. Ordinary Lua values are packed directly
into the destination dtype, preserving integer overflow checks separately from
strong ndarray conversion. Scalar, empty, rank-63/64, signed/unsigned endpoint,
F/reversed and duplicate-index behavior is exercised.

The initial fixture constructor also needed to preserve Fortran singleton-axis
strides even when both C/F contiguity flags are true. Expected source strides
were retained; only construction was corrected. No strict metadata comparison
was removed. Bidirectional broadcasting from singleton source dimensions was
checked using upstream examples and seeded multidimensional samples.

## Limits / next work

This is not full NumPy parity. General mixed slice/fancy subspace buffering,
non-native numeric byte order, object/structured/variable-width strings,
Python warnings/exceptions and subclasses remain incomplete. The earlier 40
blocked dtype states and three deliberate empty-axis take hang variants remain
separate. Next coherent work: additional selection primitives and broadening
advanced-index assignment compatibility, with original reference tests.
