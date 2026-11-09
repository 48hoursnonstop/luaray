# LuaRay 0.103.0-dev — nonzero and conditional extraction

Four namespace APIs and the nonzero/compress ndarray methods now execute in
a separate native condition subsystem. Nonzero returns a Lua table of integer
coordinate arrays; flatnonzero returns one integer array. Compress/extract
resolve selection positions and reuse the verified native take engine.
English/Spanish API contracts and an actual public module example are included.

## Executed gates

- nonzero:168 cases /10,188 checks; flatnonzero:168 /7,126.
- compress:2,061 /83,059; extract:692 /21,331.
- New total:3,089 original NumPy2.5.3 cases /121,704 value/metadata checks.
- New C suite and95 direct Lua checks passed.
- All124 frozen differential files and existing C/Lua regression passed.
- All four generated fixture files reproduced exactly.
- Directed ASan/UBSan: ten C units, six native /26 Lua suites passed; other
  linked dependencies uninstrumented, leak detection disabled.
- Public native Lua example passed. The final source-archive gate separately
  extracts, verifies manifest, rebuilds, runs full regression and six public
  examples. Actual final results are in its verification JSON/log.

## Verified contracts

Coordinates are stored interleaved in a new owned native buffer and retain
upstream stride metadata, including empty views and rank64. Lua positions
start at1. Coordinate lanes have disjoint element bytes but potentially
intersecting enclosing spans; exact/may-sharing queries and actual advanced-
index composition are tested. Regular nonzero rejects0-D; flatnonzero accepts
scalars. C-order traversal is preserved for F/reversed/zero-stride sources.

Compress condition rank is checked, short masks truncate selected positions
and overlong false tails remain allowed. A selected out-of-range position
raises. Shared condition/source/output uses snapshotted index positions.
Extract accepts flattened multidimensional/scalar conditions. NaN, complex,
fixed strings, temporal zero and NaT truth are covered. Existing output dtype,
identity and take-style preconversion/errors are checked against originals.

## Limits and next work

Object/structured/variable-width strings, non-native numeric byte order,
subclasses and full warning/exception fidelity remain incomplete. Earlier40
blocked endian states, three take hang variants and two choose unsafe-span
variants remain separate; no overall percentage is inferred.

Next selection primitives: where/select and a reproducible broader API
inventory distinguishing availability from proven behavior. Continue past
this development milestone; luanimath remains unfinished behind dependency work.
