# LuaRay 0.99.0-dev — source-derived masked assignment

## Functional changes

- Move copyto's assignment engine into the host-neutral native write subsystem.
  Preserve destination-stride axis order, negative-stride normalization,
  coalescing, source overlap copies, 1D overlap direction and live mask runs.
- Preserve NumPy's weak numeric scalar resolution, its equiv-casting exception,
  literal versus ndarray mask policies, source leading-singleton dimensions,
  scalar preconversion and redundant non-scalar self-copy shortcut.
- Reproduce legacy text conversion's alignment-dependent 128-element output
  buffers and actual partial/error mutation, rather than imposing atomic writes.
- Expand putmask coercion to numeric/complex/string masks and directly packed
  Lua values, empty values and protected C-order writeback. Keep place's distinct
  selected-position advancement and live compatible values.
- Add complex real-component temporal conversion, including NaT boundaries.
- ASan exposed an overlapping memcpy in the shared identity transfer path;
  use memmove. Direct identity transfers also preserve string storage rather
  than clearing it before repacking, fixing aliased reshape self-copies.
- English/Spanish contract guides, machine-readable current compatibility
  record and a native GitHub CI workflow. CI results must be checked separately;
  local execution does not establish remote CI success.

## Actual validation

- `make full-test`: **116/116 differential fixture files**, all C/Lua regressions.
- NumPy **2.5.3** generated **4,914 copyto** and **1,481 putmask** original cases,
  totaling **175,110 executed comparisons**. Explicit post-error arrays cover
  U1/U3/U4/U8/S3 around the 128-element buffering boundary.
- **77 targeted Lua checks**, new native C tests and both public dynamic-module
  examples passed. Historical numeric reference expectations remain unchanged;
  only release-version assertions advance to 0.99.
- Directed ASan/UBSan passed all three edited C units, both 0.98/0.99 native
  tests and ten Lua suites after fixing the detected overlap. Other dependencies
  are uninstrumented; leak detection disabled. This is not a whole-library audit.
- The refactored 0.98 generator reproduced all three earlier reference files
  byte-for-byte. Both new fixtures were also regenerated identically.
- Final clean extraction, compilation, full regression, actual examples and
  SHA-256 outcomes are recorded in the release verification report/log. A
  verified release archive is immutable; packaging refuses to overwrite one.

## Remaining scope

Numeric descriptors with non-native byte order remain unavailable. The forty
original blocked states recorded in 0.98 are preserved and not counted as parity.
Object/structured dtypes, all warning/exception-class details and full NumPy
compatibility are not claimed. Existing exact-memory work limits remain.

Continue indexing/assignment dependencies after this checkpoint: inspect
NumPy's take/take_along_axis/put_along_axis and reuse actual array/broadcast
semantics rather than introducing wrappers around Python. User requested
dependency completion before further luanimath features.
