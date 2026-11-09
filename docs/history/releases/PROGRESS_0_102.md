# LuaRay 0.102.0-dev — choose and shared temporal corrections

A separate native C choose subsystem now supports namespace/method forms,
common dtype, broadcasting, modes, output identity and observable alias/error
behavior. Choices can be arrays or a Lua sequence. Runtime remains Lua/native
C/C++, with Python only for development references. English/Spanish API
contracts and a real public module example are included.

## Executed gates

- 3,481 original NumPy 2.5.3 cases / 101,519 value/metadata checks.
- New C suite and 69 Lua checks passed.
- Final development full-test: all 120 frozen fixture files and C/Lua suites.
- Frozen choose fixture reproduced exactly; public module example passed.
- Directed ASan/UBSan: nine C units, five native and 21 Lua suites passed;
  other linked dependencies uninstrumented, leak detection disabled.
- Final archive gate separately extracts, verifies the SHA manifest, rebuilds,
  executes full regression and all five public writing/gathering/selection
  examples. Its verification JSON/log records archive identity and completion.

## Actual defects resolved

The first choose corpus passed 1,530 cases, then expanded temporal references
found date-to-Unicode short widths silently truncating. Shared transfer now
returns the actual error, preserves direct ASCII failed-cell prefixes and stages
Unicode casts in 128-element blocks. Width/unit/NaT and 127/128/129 boundaries
are compared against original output. The Linux year-only exact-capacity
snprintf result is retained. Cross-kind datetime/timedelta output testing found
incorrect unit scaling; unsafe cross-kind casts now preserve integer ticks.

Weak-choice tests also established that choose wraps an out-of-range numeric
Lua choice when a strong uint8 array determines the dtype. This is distinct
from direct put values and is preserved rather than assigned an idealized
scalar overflow policy. Safe selector conversion still rejects float/uint64.

A fixture construction issue for NaT's int64-min sentinel was fixed by spelling
that value as math.mininteger. Original expected states were retained. No
failed date or metadata assertions were removed.

## Intentional differences and limits

Two unsafe direct-output span variants are guarded before writing; each is
tested in wrap/clip outside original parity. Source indicates a raw write past
the owning allocation; those unsafe NumPy calls were not executed. In-bounds
noncontiguous spans were actually executed and compared. Native extreme wrap
uses modulo, without running the upstream repeated-subtraction loop for those
huge values. Neither is presented as an original passing reference case.

Previous 40 numeric-endian blocks and three take hang-class variants remain
separate. General mixed slice/fancy subspace buffering, object/structured/
variable-width dtypes, complete exception/warning and full NumPy parity remain
incomplete. Next selection work: compress/extract using the verified take engine
and source-derived condition/index conversion. Continue beyond release gates.
