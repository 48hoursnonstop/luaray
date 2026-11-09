# LuaRay0.107.0-dev — native creation and array conversion

Eleven new root bindings and ndarray:copy implement conversion, C/F layout,
finite checks, copies and filled/like allocation. Existing array/empty/zeros/ones
now handle the options API and scalar shapes. Separate creation bindings use an
explicit Lua/native ownership boundary; the native creation kernel remains
independently testable without Lua or Python. English/Spanish references explain
conditional copying, scalar/array casting and remaining incompatibilities.

## Executed evidence

- Conversion4,726 original NumPy2.5.3 cases /454,982 checks.
- Copy740 /77,978; like constructors5,624 /485,242; dense1,461 /23,546.
- Combined12,551 /1,041,748. Values, actual errors, metadata, object identity,
  sharing queries and real post-conversion writes are checked exactly.
- Native C boundary suite and164 direct Lua checks passed, including strict
  binary-NUL option rejection. Standalone fresh-process rank64 construction and
  tolist passed; the C binding explicitly reserves the necessary Lua stack.
- Full regression136/136 frozen fixture files passed; final invalid-option
  additions passed directed tests. The source archive gate reruns the final suite.
- Four new fixture files regenerated exactly with the pinned interpreter.
- Final23-unit ASan/UBSan audit (22C+1Cpp),11 native and44 Lua suites passed,
  including the final164-check regression, fresh rank64 process and retained
  legacy string-cast regression. Other dependencies uninstrumented; leaks off.
- Final source extraction/manifest/rebuild/full regression/ten public examples
  are independently recorded by the versioned release JSON/log. Remote CI is
  checked separately; it is not inferred from an earlier version.

## Source-derived distinctions and fixes

Never-copy rejects required dtype/layout allocation and ordinary Lua inputs;
if-needed can return the identical userdata. Root copy defaultsK, method copyC;
new copies reset writeability, shared conversions retain read-only state. Like
constructors preserve physical order across equal-rank shape changes and fall
back to C when the rank changes. Empty values are not read until after real fill.

Original references exposed scalar-shaped arguments, generic temporal adaptation,
and the difference between integer scalar setitem and numeric array casts. Raw
array-to-generic-datetime casts retain ticks, whereas scalar integer construction
requires units even for the INT64MIN bit pattern. Typed NaT remains valid. Native
temporal scalar materialization retains its strong dtype; datetime strings infer
actual ISO width, timedelta strings retain width21. Empty fixed strings use width1.

Full regression exposed an old hardcoded LuaRay astype rejection contract. It is
retained at the existing adapter boundary rather than imposed on new array
coercion. The old test was not weakened. This is an explicit partial compatibility
difference from NumPy2.5.3's root Array API astype contract. Constructor and tolist
stack capacity is explicitly reserved; no new crash was observed in the fresh
rank64 probe. The earlier 0.105 reproduced FFT crash remains a separate issue.

## Availability and remaining work

Runtime inventory observed318/675 direct callable names,356 missing bindings and
one justified Lua adaptation. Root NumPy193, ndarray32; every available API stays
partial and complete APIs declared0. Availability is not behavioral completion.
Nested sequences containing arrays/temporal scalar userdata, foreign protocols,
general subclasses, ndarray-shaped arguments, device/like dispatch and complete
coercion remain incomplete. subok is validated within the single native class.
Objects/structured/variable strings, non-native numeric endian and full warning/
exception fidelity remain unavailable. Earlier40 blocked states and take/choose
differences retain classification. Continue beyond releases; luanimath is unfinished.
