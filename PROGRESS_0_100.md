# LuaRay 0.100.0-dev — native take

The first gather primitive now has an independently testable C subsystem,
ln_take.{c,h}, public np.take/ndarray:take wrappers, actual functional example,
native/Lua tests and frozen original NumPy 2.5.3 comparisons. This extends the
put/place and masked-write releases; it does not replace general advanced
indexing or claim full NumPy parity.

## Executed evidence

- 6,704 source-oracle cases, 324,615 value/shape/stride/dtype checks.
- Native take tests and 63 Lua checks, including three deliberate hang-class
  rejections classified outside parity totals.
- All 117 frozen fixture files and existing C/Lua regression suites passed.
- Both generated take files regenerated exactly from the pinned oracle.
- Six changed C units passed directed ASan/UBSan, three native/14 Lua suites;
  other dependencies uninstrumented, leaks disabled.
- Public native Lua take example passed. No Python runtime dependency added.
- Release tooling separately performs clean extraction, SHA manifest, native
  rebuild, full regression and all three public writing/gathering examples.
  Final archive verification and any later remote CI have separate records.

## Defects found and corrected

Reference execution caught scalar out identity, empty-shape stride preservation,
chunk-level live output/index aliasing and ASCII error mutation. Shared string
casts now validate all source characters before modifying an output scalar,
even beyond truncation, and preserve embedded NULs. C byte-level regressions
cover both ASCII conversion directions. Fixture functions are split into
400-case chunks to respect Lua's compiled local-variable limit; no cases were
removed to work around that parser limit.

A bounded process confirmed NumPy 2.5.3's empty-axis wrap loop for shape (3,0,0),
axis 1 and index [0]. LuaRay raises instead. The other two retained variants
were not individually executed upstream. Full-width integer wrapping uses
modulo safely, without reproducing upstream repeated-addition runtime costs.

## Remaining work

Numeric non-native endian, object/structured/variable-width strings, exact
Python warnings/exceptions and general fancy indexing remain incomplete.
The earlier 40 blocked endian states remain blocked. Next dependency work:
take_along_axis/put_along_axis with shape broadcasting, real alias semantics
and strict original reference comparisons. English/Spanish API documentation:
docs/{en,es}/take.md. Do not infer an overall completion percentage from tests.
