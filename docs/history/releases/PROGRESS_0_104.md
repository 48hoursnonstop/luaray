# LuaRay0.104.0-dev — conditional values and honest API inventory

Native where/select add conditional mathematical values while reusing existing
iterator, broadcasting and masked-write subsystems. Unary where uses nonzero.
The source pipeline preserves scalar ndarray results, operand-driven output
order, weak scalar rules and selected/unselected conversion differences.
English/Spanish selection and inventory documentation is included.

## Actual execution

- where1,487 original NumPy2.5.3 cases /59,988 checks.
- select1,961 /19,688; combined3,448 /79,676.
- New native C suite and65 Lua checks passed.
- All126 frozen fixture files and existing C/Lua regression passed.
- All3,481 old choose cases passed after shared preparation changes.
- Both fixtures regenerated exactly; public native example passed.
-13-unit directed ASan/UBSan: seven native /29 Lua suites passed. Other linked
 dependencies uninstrumented, leaks disabled.
- Final source-archive gate separately extracts, checks manifest, rebuilds,
 runs full regression and all seven public examples. The versioned JSON/log
 records actual archive identity and clean-gate completion.

## Defects and boundary work

Original references caught uint64/timedelta common-type promotion being
incorrectly accepted. Class/descriptor resolution now rejects it. Select's
many-condition tests exposed the legacy64-operand broadcast helper bound;
batched shape folding supports original32/64/128 boundary cases. Ndarray1-D
sequences exposed the old scalar-index rejection; strong0-D item views now
preserve array dtype in select and choose. Both ordinary and binary fixed
strings, including embeddedNULs/unselected invalidASCII, retain original paths.
Fixture labels with multiline NumPy array reprs were escaped to remain valid
Lua comments; expected values/assertions were retained.

## API availability scope

compatibility/api_inventory.json records675 public callable names in root/
FFT/linalg/random, ndarray, Generator and ufunc scopes. Real Lua lookup observed
297 callable bindings,377 missing direct bindings and one justified language
adaptation (Python LinAlgError class represented by native Lua errors). All
available entries remain partial; complete APIs declared:0. Aliases/types are
included, constants/properties/all other modules and dtype loops excluded.
Alternate Lua spellings can exist; this is not overall completion or proof
of behavior. The tool verifies module/repository version and reproduces exactly.
Release packaging rejects a stale inventory version.

## Remaining work

The earlier40 blocked endian states and take/choose deliberate differences
remain separate. Object/structured/variable strings, full exception/warning/
subclass behavior and all NumPy API parity remain incomplete. Next coherent
inventory gaps: FFT frequencies/shifts and Hermitian transforms, with original
reference tests and numerical/layout verification. Continue past releases;
luanimath remains unfinished behind dependency work.
