## 0.110.0-dev verification (executed)

- Full native/Lua regression passed **146/146 frozen fixture files**.
- NumPy2.5.3 ravel: **2,664 cases /185,920 checks**; flatten:
  **2,640 /185,128**; reshape: **19,830 /1,387,960**. Combined
  **25,134 /1,759,008**, exact values, metadata, sharing and post-write states.
- Native C tests and **61 Lua checks** passed, including owner lifetime after
  collection, reversed/strided no-copy reshapes, C/F/A/K, copy policy, readonly
  propagation, inferred dimensions, invalid options/NUL, rank and size limits.
- Directed ASan/UBSan passed **26C+1Cpp units,14 native and57 Lua suites**.
  Existing dependencies outside that scope were uninstrumented; leaks disabled.
- Three fixtures and runtime inventory are regenerated exactly as a separate
  gate. Inventory observed **336/675** names:338 missing,1N/A,0complete.
- Public native-module example passed. Source extraction/manifest/clean build/
  full regression/thirteen examples and archive integrity are independently
  recorded in the versioned release JSON/log. Remote CI is checked separately.
- All older numerical fixture assertions remain unchanged except version fields.
  The old core C reshape delegates to the new native subsystem. Full NumPy
  compatibility, all protocols and all ABI variants are not claimed.

## 0.109.0-dev verification (executed)

- Full native/Lua regression passed **143/143 frozen fixture files**.
- NumPy2.5.3 fmod: **1,428 cases /189,111 checks**; float_power:
  **1,428 /205,745**; binary coercion **784 /18,244**; string addition and
  logical promotion **1,346 /101,716**. Total **4,986 /514,816**.
- Fmod, coercion and string values/metadata compare exactly, observed error0.
  Float_power and existing power/arctan2/hypot allow relative2e-12; maximum
  observed error in float_power3.1974423109205e-14 absolute and
  3.2300436499022e-15 relative. No tolerance was expanded to hide a failure.
- Native C tests and **303 Lua regression checks** passed, including weak large
  exponents, tiny logical scalar values, embedded NUL, Unicode, shape/mask/
  readonly checks and descriptor overflow without oversized data allocation.
- ASan/UBSan passed **24C+1Cpp units,13 native and53 Lua suites**. The final
  fixtures include integer extremes in both operand positions. Other linked
  dependencies were uninstrumented; leak detection disabled.
- Runtime inventory observed **333/675** names,341 missing,1N/A,0complete.
  Four-fixture/inventory reproducibility and the final source extraction/build/
  regression/twelve-example gate are separately recorded in the versioned
  release verification JSON/log. Remote CI is verified independently.
- Old endian blocked states, take/choose variants, legacy astype restriction and
  all earlier scope limits remain documented; full NumPy compatibility is not claimed.

## 0.108.0-dev verification (executed)

- Full native/Lua regression passed **139/139 frozen fixture files**.
- NumPy2.5.3 rounding: **2,135 cases /176,894 checks**; algebra:
  **1,746 /186,658**; angles: **1,708 /137,512**. Total **5,589 /501,064**.
  All observed errors were zero. General complex square/reciprocal allows
  relative6e-7 (complex64) or2e-15 (wider);38 additional FMA layout/mask/
  overlap cases require exact agreement. Signed zero and special values checked.
- Native C boundary suite and **358 directed Lua checks** passed, including
  ordinary scalar/table coercion for existing unary operations, invalid shapes,
  read-only outputs and exact integer reciprocal/square boundaries.
- Directed ASan/UBSan passed **23C+1Cpp units,12 native and48 Lua suites**.
  Other dependencies uninstrumented; leaks disabled. New math explicitly disables
  implicit FP contraction and selects the eligible complex FMA kernel.
- Runtime inventory observed **331/675** scoped names:343 missing and1 N/A;
  every available API remains partial, zero complete APIs declared.
- New fixture and inventory reproducibility and source archive verification
  are checked as separate gates; their definitive report is the versioned JSON.
  Eleven public examples run again from the extracted archive. Remote CI is
  verified separately. All earlier blocked states and explicit differences remain.

## 0.107.0-dev verification (executed)

- Full native/Lua regression passed **136/136 frozen fixture files**. Final
  binary-NUL validation additions also passed the directed creation suite.
- Original NumPy2.5.3 conversion: **4,726 cases /454,982 checks**; copy:
  **740 /77,978**; like: **5,624 /485,242**; dense: **1,461 /23,546**.
  Total **12,551 /1,041,748**, comparing values, errors, metadata, identity,
  sharing and actual writes exactly. Source input/backing states are retained.
- New native C suite and **164 direct Lua checks** passed. Fresh-process rank64
  construction/tolist passed; the C boundary explicitly reserves Lua stack.
  Empty output contents are compared only after actual writes.
- Final directed ASan/UBSan passed **22 C +1 C++ units**, **11 native /44 Lua
  suites**, including the retained old string-cast contract and rank64 process.
  Other dependencies uninstrumented, leaks off; integer ufunc loops use -fwrapv.
- Four new frozen files and actual runtime inventory reproduced exactly.
  Public native module example passed. Inventory observed **318/675** names,
  356 missing direct bindings and one Lua adaptation; zero complete APIs declared.
- Generic datetime scalar integer packing remains distinct from raw numeric
  array conversion. Native temporal scalars retain units and source string-width
  conventions. The historical LuaRay astype generic-datetime rejection is kept
  at its adapter boundary, documented as partial compatibility. No old assertion
  was weakened or removed to make the new creation tests pass.
- Final source extraction/manifest/build/full regression/ten public examples and
  archive integrity are recorded independently in the versioned release JSON/log.
  Remote CI is separate. Earlier blocked states and explicit differences remain.

## 0.106.0-dev verification (executed)

- Full native/Lua regression passed **132/132 frozen fixture files**.
- Original NumPy2.5.3 linspace: **2,478 cases /504,645 checks**, logspace:
  **1,542 /154,195**, geomspace: **1,392 /150,473**; combined **5,412 /809,313**.
  Linspace values compare exactly, observed error0. Power/log tolerances follow
  compute precision before final dtype casts: half2e-3, float32/complex64 3e-6,
  wider2e-12 absolute+relative. Integer/bool/string values and metadata are exact.
  Output-based tolerance was corrected after source/SVML versus libm audit;
  explicit wide-storage/narrow-computation Lua checks pass exactly.
- Max normalized `abs(error)/max(1,abs(ref))`:1.1393306865162e-7 logspace,
  1.9546212523884e-7 geomspace. Logspace max absolute9.2233720368548e18 occurs
  at large powers; geomspace max absolute9.5367431640625e-7. Both stay within
  the declared precision-scaled bounds. See bilingual sampling reference.
- Native raw-bit formatter reference: **70,828 states /141,656 exact ASCII and
  Unicode comparisons**, including all65,536 half encodings, random wider
  values, complex nonfinites, unaligned buffers and output guards. Eight threads
  executed16,384 additional formatter calls. Primary ABI:Linux x86 extended
  longdouble storage; other native ABI branches remain unexecuted.
- Two new C suites and **154 direct Lua checks** passed. New full sampling
  matrices include stride-zero/3-D views, rank63/64 and half counts65504/65536.
- All three fixtures, raw-bit header, native Dragon4 import and runtime API
  inventory regenerated exactly. Public native example passed.
- Directed ASan/UBSan passed **20 C units +1 C++ unit**, **10 native /37 Lua
  suites**. The final additional direct Lua precision checks also passed with
  the instrumented module. Other dependencies uninstrumented, leaks disabled;
  integer ufunc loops retain -fwrapv. Scope in compatibility/current.json.
- Inventory: **306/675 direct callable names**,368 missing and one Lua adaptation;
  zero complete APIs declared. No overall compatibility percentage is inferred.
- Versioned release JSON/log separately records the final source extraction,
  manifest, clean build/full regression and nine public examples. Remote Ubuntu
  CI is separate. Earlier blocked states/differences retain their classification.

## 0.105.0-dev verification (executed)

- Full native/Lua regression passed **129/129 frozen fixture files**.
- Original NumPy2.5.3 frequencies: **826 cases /28,419 checks**; shifts:
  **1,800 /86,698**; transforms/output behavior: **6,964 /343,993**.
  Total **9,590 /459,110**. Checks include input/output states, real acceptance,
  dtype, strides, shape and destination identity; all three fixtures reproduced.
- New C suite and **111 Lua checks** passed. Known half/float32 precision cases
  use exact expected values. Differential float32/complex64 tolerances are
  absolute+relative3e-6; wider output2e-12. Maximum absolute transform error:
  1.9073486328125e-6; frequency/shift error0. No tolerance was weakened.
- Expanded text/out cases reproduced a NULL dtype normalization crash. Systemd
  core/GDB confirmed it; validation now precedes promotion. The same cases and
  read-only outputs pass rejection tests and sanitizer execution.
- ASan/UBSan passed **15 C units +1 C++ unit**, **8 native /33 Lua suites**.
  C++ PocketFFT integration is instrumented; other linked dependencies are not.
  Leak detection is disabled. Complete scope in compatibility/current.json.
- Inventory observed **303/675** direct callable names,371 missing and one Lua
  exception-class adaptation; FFT18/18 available remains partially compatible.
- Final source archive extraction/rebuild/full regression/eight public examples
  and SHA manifest are recorded by the versioned release JSON/log. Remote CI
  is separate. Earlier blocked states and explicit differences are retained.

## 0.104.0-dev verification (executed)

- Final full native/Lua regression passed **126/126 frozen fixture files**.
- Original NumPy2.5.3 where: **1,487 cases /59,988 checks**; select: **1,961 /
  19,688**. New total **3,448 /79,676**. Values, shape, dtype, strides and where
  input states are checked; scalar ndarray output, weak values, binary strings,
  layouts and many-condition batches are included.
- New C suite and **65 Lua checks** passed. Public module example passed.
  All3,481 existing choose cases passed after shared dtype/item-view changes.
- Both new fixtures and actual runtime API inventory regenerated exactly.
- Directed ASan/UBSan passed **13 C units**, **7 native /29 Lua suites**, including
  new selection, generic iterator and temporal promotion. Other dependencies
  uninstrumented, leak detection off. Full scope in compatibility/current.json.
- Inventory: **297 callable names observed /675 scoped names**,377 missing direct
  bindings and one justified Lua exception-class adaptation. Available entries
  remain partial; inventory itself verifies no complete behavioral API.
- Final source extraction/rebuild/full regression/seven public examples and SHA
  manifest are recorded by the versioned release JSON/log. Remote CI is separate.
  Earlier explicit differences and blocked states retain their classifications.

## 0.103.0-dev verification (executed)

- Full native/Lua regression passed **124/124 frozen fixture files**.
- New original NumPy 2.5.3 corpora: nonzero **168 cases / 10,188 checks**,
  flatnonzero **168 / 7,126**, compress **2,061 / 83,059**, extract **692 / 21,331**.
  Total **3,089 cases / 121,704 value and metadata checks**.
- New native C suite and **95 Lua checks** passed. This includes nonzero
  coordinates fed into actual advanced indexing, exact sharing queries,
  interleaved strides, scalar/rank-64/empty conditions, aliases and real errors.
- All four fixtures regenerated byte-for-byte. Public native example passed.
- Directed ASan/UBSan passed **ten C units**, **six native / 26 Lua suites**:
  ln_condition, ln_choose, ln_write, ln_dtype_transfer, lua_module, ln_random,
  ln_take, ln_string, ln_along and ln_mapping. Other dependencies uninstrumented,
  leaks disabled. This does not claim whole-dependency memory instrumentation.
- Final source extraction/rebuild/full regression/six public examples and SHA
  manifest verification are recorded by the versioned release JSON/log. Remote
  CI is tracked separately. Previous blocked states/differences remain separate.

## 0.102.0-dev verification (executed)

- Final development full-test passed **120/120 frozen fixture files**, native
  tests and Lua regressions after all choose/temporal conversion changes.
- `choose102-test`: native C suite passed; **69 Lua checks** passed, including
  two deliberate unsafe-span variants (each wrap/clip) outside parity.
- Original NumPy 2.5.3 choose corpus: **3,481 cases / 101,519 checks**. Actual
  output/backing states, shape, strides, dtype and out identity checked. This
  includes all output dtype pairs, weak-choice conversion, ISO date widths,
  NaT, 128-element boundaries, noncontiguous safe raw spans and live indices.
- Fixture regenerated byte-for-byte; public native module example passed.
- Directed ASan/UBSan passed **nine C units**, **five native / 21 Lua suites**:
  ln_choose, ln_write, ln_dtype_transfer, lua_module, ln_random, ln_take,
  ln_string, ln_along and ln_mapping. Dependencies uninstrumented, leaks off.
- Unsafe upstream owning-buffer overrun calls were not executed. In-buffer
  strided/transposed/reversed cases were actually executed and compared.
- Extreme wrap values use mathematical native modulo; impractical upstream
  repeated-subtraction loops were not executed for those extremes.
- Final archive extraction/build/full regression/five examples and SHA manifest
  are recorded separately by the versioned release verification JSON/log.
  Remote CI is a separate gate; earlier CI does not prove this version.

## 0.101.0-dev verification (executed)

- Full native/Lua regression passed, including **119/119 frozen fixture files**.
  Final source archive gate rebuilds and executes the same suite separately.
- `take_along101`: **2,061 original NumPy 2.5.3 cases / 109,722 checks**.
  `put_along101`: **3,599 cases / 430,929 checks**. New total: **5,660 / 540,651**.
- New native C suite and **85 Lua checks** passed. Public module example passed.
  Original fixtures check acceptance, backing data after real errors, result
  independence, shape, dtype and strides, including bidirectional broadcasting,
  operand order, aliases, rank limits and both sides of 8,192-element buffering.
- Both generated files reproduced byte-for-byte with the pinned oracle.
- Directed ASan/UBSan passed **eight C units**, **four native / 19 Lua suites**:
  ln_write, ln_dtype_transfer, lua_module, ln_random, ln_take, ln_string,
  ln_along and ln_mapping. Expanded final fixtures were replayed with the same
  instrumented module and passed. Other dependencies uninstrumented, leaks off.
- Earlier take hang-class rejections and 40 blocked numeric-endian states remain
  outside original parity totals; no overall NumPy completeness is inferred.
- Final clean archive results and actual remote CI are tracked separately.

## 0.100.0-dev verification (executed)

- `make -j4 full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'`:
  **117/117 frozen differential fixture files**, native and Lua suites passed.
- `take100-test`: native suite passed; **63 Lua checks** passed; **6,704 original
  NumPy 2.5.3 cases / 324,615 value and metadata checks** passed. Shapes, strides,
  dtype, independent-copy/output identity and actual post-error backing states
  are checked. Prior frozen references retain their recorded provenance.
- Regeneration of both take fixture/difference files was byte-for-byte exact.
- Directed ASan/UBSan passed **six instrumented C units**: ln_take, ln_string,
  ln_write, ln_dtype_transfer, lua_module and ln_random. Three native and 14 Lua
  suites passed; other linked dependencies uninstrumented, leaks disabled.
- Actual public `require('luaray')` take example passed through Lua 5.4/module.
- Separate NumPy 2.5.3 subprocess reached the representative empty-axis wrap
  call then timed out at three seconds. Three retained Lua variants reject it;
  they are not counted as parity and were not individually executed upstream.
- Final archive extraction/build/regression/examples/manifest results are
  recorded by tools/release.py in its versioned verification JSON and log.
  Remote 0.100 CI is tracked separately; no older run proves this version.

## 0.94.0-dev verification (executed)

- `np.issubdtype`: **1,849/1,849** NumPy 2.3.5 comparisons; `min_scalar_type` Unicode: **94/94**, total **1,943**; five invalid-input checks passed.
- `make -j6 full-test` development tree: **110/110 NumPy differential fixture files**, plus native C and Lua tests: PASS.
- Targeted ASan/UBSan of modified `src/lua_module.c`: new tests PASS with leak detection disabled; other linked objects not instrumented.
- Reference generator: `tools/generate_dtype94_oracle.py`; NumPy 2.5.3 SHA-256 evidence in `NUMPY_2_5_3_DTYPE94_FILE_HASHES.sha256`.

## 0.93.0-dev verification (executed)

- `np.min_scalar_type` **4,557/4,557** NumPy 2.3.5 differential cases; additional `astype` layout audit **1,488/1,488** cases.
- `make -j8 full-test`: **109/109** NumPy fixture files plus prior C/Lua regressions passed.
- Directed ASan/UBSan of the modified Lua module: both new suites passed, leak detection off; remaining dependencies not instrumented.
- Frozen NumPy fixtures reproducible using `tools/generate_dtype93_min_scalar.py` and `tools/generate_dtype93_audit.py`.

## 0.92.0-dev verification (executed)

- `make -j8 full-test`: **107/107** NumPy differential fixture files, plus the earlier C and Lua regression tests: passed.
- `make dtype92-test`: two NumPy-derived fixtures (**2,304 + 2,420 = 4,724** cases), plus the new Lua regression: passed.
- Directed ASan/UBSan with `src/lua_module.c` instrumented and leak detection disabled: the regression and both new differential fixtures passed. Linked dependencies were not instrumented.
- Built-in DTypes only; order/copy semantics not a complete claim of parity with all NumPy subclasses and metadata types.

## 0.91.0-dev verification (executed)

- `make dtype91-test`: passed, **3,468 valid NumPy 2.3.5 comparisons** and
  **88 expected rejections** (3,556 cases total); independent Lua regression passed.
- `make -j8 full-test`: passed, **105/105 frozen differential fixture files**
  and all previous C/Lua native tests.
- New tests include all 2,744 three-way combinations of 14 supported numeric
  DTypes, weak scalars, ndarray operands, selected S/U/date/timedelta pairs.
- Source NumPy 2.5.3 checksums: `NUMPY_2_5_3_DTYPE91_FILE_HASHES.sha256`.
- DType results are names at Lua boundary; custom/structured types remain out of scope.

## 0.90.0-dev verification (executed)

- `make random90-test`: **5,880/5,880** differential comparisons with NumPy
  2.3.5; result, dtype, shape and next PCG64 word checked; 11 additional
  exact-table, negative-input/no-state-change and Fortran-view checks.
- `make -j8 full-test`: PASS; **104/104** frozen differential fixtures,
  including the 103 existing suites, plus previous C/Lua tests.
- Directed AddressSanitizer/UndefinedBehaviorSanitizer instrumentation of
  `src/lua_module.c`: PASS for all 5,880 comparisons and 11 regressions;
  dependency objects were not fully instrumented.
- Direct `uint64` bounds beyond signed Lua integer range remain unsupported.
- Exact NumPy source reference: 2.5.3; executable oracle: NumPy 2.3.5.

# LuaRay 0.89.0-dev — executed verification

- `make random89-test`: PASS; **4,782/4,782** reproducible NumPy 2.3.5 differential cases, checking values, dtype, shape and next PCG64 word. Broad coverage of nine types, endpoint, scalar broadcasting, arrays, tables, high-only bounds, reversed views, zero-sized output, and exact 64-bit integer bounds.
- Rejection/no-state-change tests: **11/11**; standalone native Lua example: PASS.
- `make -j8 full-test`: PASS; **103/103** frozen differential suites, including all prior native C/Lua tests.
- Targeted ASan/UBSan compile of `src/lua_module.c` linked with other ordinary objects: PASS for the 4,782 differential cases, negative tests and Lua example; **not** whole-library instrumentation.
- Known mismatch: Fortran-transposed ndarray bounds can place otherwise identical PCG64 samples differently versus NumPy 2.3.5. These inputs were excluded from the passing fixture. Exact `uint64` bounds above Lua's signed 64-bit scalar range are unsupported.
- Independent source reference: NumPy 2.5.3 `_generator.pyx` and `_bounded_integers.pyx.in`, SHA-256 pinned in `NUMPY_2_5_3_RANDOM89_FILE_HASHES.sha256`.

---

# LuaRay 0.88.0-dev — executed verification

- `make random88-test`: PASS, 1,008 NumPy 2.3.5 differential cases and 14 invalid/no-RNG-advance checks, including C/F-order outputs and float32/float64 `zig`/`inv` methods.
- `make -j8 full-test`: PASS, **102/102 differential fixture files**, all prior C and Lua tests.
- ASan/UBSan **only** on `src/lua_module.c`, linked with uninstrumented dependencies: new regression and 1,008 differential tests PASS. Does not establish whole-project ASan coverage.
- Source NumPy 2.5.3 hash evidence: `NUMPY_2_5_3_RANDOM88_FILE_HASHES.sha256`.

---

# LuaRay 0.87.0-dev — executed verification

- `python3 tools/generate_random87_oracle.py`: NumPy 2.3.5 **1,380 cases**; fixture reproducible on regeneration.
- `make random87-test`: PASS, 1,380/1,380 comparisons (int64 data, shapes and PCG64), 19 invalid argument checks, 20,000 statistical samples, Lua example.
- `make -j8 full-test`: PASS, **101/101 differential fixture files** and prior C/Lua tests.
- Targeted `src/lua_module.c` ASan/UBSan: PASS regression and full new fixture; other linked objects were not instrumented.
- NumPy 2.5.3 pinned source hashes verified against provided source archive.

---

# LuaRay 0.86.0-dev — executed verification

- `make random86-test`: PASS; **990/990** independently generated NumPy 2.3.5 differential cases, including values, `float64` dtype, shape and exact next PCG64 word.
- `tests/random86_regression.lua`: PASS; **24** invalid input/no-draw checks, **30,000** sampled values and output shape/stride checks.
- `examples/random86.lua`: PASS.
- `make -j8 full-test`: PASS; **100/100** differential fixture suites, prior C/Lua regressions.
- Re-generated the new oracle byte-for-byte: SHA-256 unchanged.
- Targeted `src/lua_module.c` ASan/UBSan build: PASS for regression and all 990 differential cases. Other object files linked without instrumentation; not a whole-project audit.
- NumPy 2.5.3 source SHA-256 hashes independently checked against the provided tarball.

---

# LuaRay 0.85.0-dev — executed verification

- `make random85-test`: PASS — **648/648** NumPy 2.3.5 cases comparing results, shape, float64 dtype and exact next PCG64 word.
- `tests/random85_regression.lua`: PASS — **16** invalid calls without PCG64 advancement; **20,000** empirical samples; transposed/negative-stride/empty/0-D checks.
- `examples/random85.lua`: PASS.
- `make -j8 full-test`: PASS — **99/99** differential fixture files plus native C and Lua regressions.
- Independent NumPy oracle regeneration was SHA-256 identical.
- Directed AddressSanitizer / UndefinedBehaviorSanitizer of `src/lua_module.c`: PASS; dependencies linked without instrumentation (not a full-project memory audit).
- NumPy 2.5.3 source hashes checked independently from the provided archive.

---

# LuaRay 0.84.0-dev — executed verification

- `make random84-test`: PASS; NumPy 2.3.5 oracle 750/750 exact cases, shape and dtype and following PCG64 word.
- `tests/random84_regression.lua`: PASS; 25 invalid parameter checks before random consumption; 40,000 sampled values checked.
- `examples/random84.lua`: PASS.
- `make -j8 full-test`: PASS; 98/98 differential fixture files plus C and Lua tests.
- Independent NumPy oracle regeneration: SHA-256 byte-for-byte match.
- Directed ASan/UBSan on `src/lua_module.c` in a hybrid instrumented executable: 750 cases and regressions passed. Other native objects **not** instrumented.
- Source NumPy 2.5.3 `random/_generator.pyx` and `random/src/distributions/distributions.c` hashes checked against supplied tarball; executable reference NumPy 2.3.5.

---

# LuaRay 0.83.0-dev — executed verification

- `make random83-test`: PASS, 1,296 frozen NumPy 2.3.5 oracle cases; checks
  exact int64 samples, shape and the next PCG64 raw word.
- `tests/random83_regression.lua`: PASS, 16 invalid arguments rejected before
  PCG64 draws and 40,000 empirical samples checked.
- `examples/random83.lua`: PASS, executable mixed-sampling example.
- `make -j8 full-test`: PASS after updating 135 historical Lua version
  assertions; **97/97** differential fixture files and native C/Lua regressions.
- Whole-project sanitizer coverage is not claimed.

# LuaRay 0.81.0-dev — execution record

- `make random81-test`: PASS, 1,500 frozen NumPy differential cases, 12 invalid-input/no-PCG64-advance checks, and executed Lua example.
- `make -j12 full-test` in development tree: PASS; **95/95** offline NumPy differential fixture files plus native C and historical Lua tests.
- Directed `src/lua_module.c` ASan/UBSan module build (linked to uninstrumented project objects): PASS for new differential and regression cases. No claim of full native sanitizer coverage.
- NumPy 2.5.3 source is pinned; independently installed NumPy 2.3.5 generated executable reference fixtures.

# LuaRay 0.80.0-dev — execution record

- `make random80-test`: PASS, 1,000 NumPy 2.3.5 cases comparing sample values, shape, dtype and exact next PCG64; seven invalid-input regressions and example also passed.
- `make random80-test`: empirical float32/float64 Gamma(1,2,5) sample means and variances evaluated using 120,000 native LuaRay samples.
- `make -j8 full-test` (development tree): PASS, **94/94** independent NumPy differential fixture files and existing native C/Lua regressions.
- NumPy 2.5.3 remains the pinned implementation reference; NumPy 2.3.5 is used solely to generate frozen offline fixture data.
- The scalar API is kept unchanged. Nonfinite array parameters and the upstream `out` argument are not implemented.
- Whole-project ASan/UBSan coverage is **not claimed**.

# LuaRay 0.79.0-dev — execution record

- `make random79-test`: PASS, 1,040 randomized NumPy 2.3.5 differential cases and 48 additional edge cases; all values, shapes and exact subsequent PCG64 state agree. Lua regression and example: PASS.
- New invalid request tests: 16/16 expected errors with unchanged PCG64 state.
- `make -j6 full-test` (development): PASS, 93/93 independent NumPy differential fixture files plus native C/Lua regressions.
- Reference: NumPy 2.5.3 pinned source archive, NumPy 2.3.5 executable fixture oracle.
- Targeted ASan/UBSan on the modified Lua API source: PASS, regression + 1,040 randomized + 48 edge cases. Other native modules were uninstrumented; whole-project sanitizer coverage is not claimed.

# LuaRay 0.78.0-dev — execution record

- `make random77-test`: PASS, 1,560 NumPy 2.3.5 differential test cases,
  including broadcast shape, output values (4e-13 relative tolerance),
  float32/float64/int64 transposed/reversed parameter views, and exact next
  PCG64 word. Reproducible independent oracle: PASS.
- Native Lua regression: PASS, nine malformed/invalid broadcast calls leaving
  the RNG state unchanged. Runnable Lua example: PASS.
- `make -j6 full-test`: PASS on development tree; **91/91** differential
  fixtures plus historic C/Lua suites.
- Complete sanitizer coverage is not claimed.

# LuaRay 0.76.0-dev — execution record

- `make random76-test`: PASS; 2,200 Lua oracle checks against independently generated NumPy 2.3.5 samples, including byte output, float32/float64 values, shape, dtype, object identity for `out`, and next PCG64 state. Lua validation regression and executable example: PASS.
- `make full-test`: PASS in development tree, **90/90 differential fixtures** plus historical native/Lua suites.
- Differential fixture regenerated byte-identically from included Python generator (SHA-256 reproducibility verified).
- Target source is NumPy 2.5.3 (upstream file hashes recorded); NumPy 2.3.5 only supplies the installed executable reference. No Python runtime dependency.
- Whole-project AddressSanitizer/UndefinedBehaviorSanitizer coverage is **not claimed**.

# LuaRay 0.75.0-dev — execution record

- `make mvn75-test`: PASS (1,020 NumPy differential samples, deterministic golden outputs, 30,000-sample empirical check, validation, and native C factor tests).
- Native LAPACK factor C test with `-fsanitize=address,undefined`: PASS, including leak detection.
- `make full-test`: PASS, 89/89 differential fixtures, prior native and Lua tests.
- Full project ASan/UBSan instrumentation: not claimed.

# Historical: LuaRay 0.74.0-dev — executed verification

- `make choice74-test`: passed; **4,650** frozen NumPy 2.3.5 comparison cases, all matching data, shapes, dtypes and subsequent PCG64 draws, plus input-validation and example tests.
- `make full-test`: passed; **88/88** independent differential fixture files plus existing C/Lua regression suites.
- ASan/UBSan applied to the native Lua API module and run against 4,650 differential samples with uninstrumented backend objects: passed. An attempted **fully instrumented** rebuild timed out while compiling, so a complete sanitizer pass is **not** claimed.
- NumPy 2.5.3 source verified by hashes in `NUMPY_2_5_3_CHOICE74_FILE_HASHES.sha256`; installed NumPy 2.3.5 is the independent executable fixture oracle. Python is not required at runtime.

---

# LuaRay 0.73.0-dev — executed verification

- `make permuted73-test`: passed Lua regression and runnable example;
  **11,244** independent NumPy 2.3.5 cases, comparing results, dtypes,
  source immutability, and subsequent PCG64 output. A separate **120**
  NumPy-derived cases verify Unicode, byte strings, float16, complex64 and
  datetime64[D] exactly with their subsequent PCG64 state.
- `make full-test`: native C regressions, existing Lua suites, and all
  **87** differential fixture files passed (including both new fixtures).
- An ASan/UBSan build of the entire project timed out before compilation
  finished; no full-project sanitizer success is claimed.
- Executable oracle is NumPy 2.3.5; source target NumPy 2.5.3.
  No Python/NumPy runtime dependency.

---

# LuaRay 0.72.0-dev — executed verification (2026-10-09)

- `make shuffle72-test`: passed 60 native C reference permutations + 20
  high-range 64-bit mask tests, Lua regressions, 2,948 NumPy 2.3.5
  differential cases with 74,552 Lua comparisons (result values, dtypes,
  source immutability, PCG64 state, multidimensional empty/strided inputs),
  and the independent executable example.
- `make full-test`: all **85/85** differential fixture files and the
  historical native C/Lua suite passed.
- Directed ASan/UBSan native C test passed (`ln_random.c` and new C fixture).
  A whole-project instrumented rebuild exceeded the execution timeout;
  it is not claimed as a passed sanitizer run.
- NumPy **2.5.3** is the source reference, NumPy **2.3.5** the independently
  executed oracle. No Python/NumPy runtime dependency.

---

# LuaRay 0.71.0-dev — executed verification (2026-10-09)

- `make distributions71-test`: passed new C regression and 100,000 sample
  statistical checks for each of Student's t and von Mises; Lua regression,
  NumPy oracle fixture and runnable example also passed.
- Independent executable NumPy **2.3.5** reference:
  **2,538 cases / 16,074 exact assertions**, covering result values,
  dtype, shape, NaN/infinity, zero-dimensional/empty arrays, concentration
  branch boundaries and subsequent PCG64 raw output.
- `make -j5 full-test`: passed **84/84 differential fixture files** and
  previous full C and Lua regression suite.
- Directed Clang `-fsanitize=address,undefined` with leak detection:
  `src/ln_random.c` and `tests/test_distributions71_core.c` passed.
  Sanitizer coverage does not extend to the entire project.
- Upstream **NumPy 2.5.3** source archives provided for algorithm inspection;
  NumPy 2.3.5 is the independently executed oracle. LuaRay uses no Python
  runtime. Current Lua adapter does not broadcast array-valued parameters.

---

# LuaRay 0.70.0-dev — executed verification (2026-10-09)

- `make distributions70-test`: passed native C test, Lua regression,
  generated NumPy reference fixture and runnable Lua example.
- New independent NumPy 2.3.5 fixture: **10,144 exact comparisons**.
- `make full-test`: passed **83/83** differential fixture files; previous
  regression, algorithmic, and native test targets passed.
- Statistical native validation: **100,000 draws per distribution**, observed
  means Wald **1.701796** (expected **1.700000**), logseries **2.496120**
  (expected **2.485340**).
- Directed ASan/UBSan with leak detection: `ln_random.c` and the 0.70
  native tests passed. Lua binding was tested through compiled Lua runner,
  **not** under sanitizers in this test.
- The source implementation refers to NumPy **2.5.3**; the independent
  executable oracle uses NumPy **2.3.5**. The LuaRay runtime has no Python
  or NumPy dependency.

---

# LuaRay 0.69.0-dev — executed verification (2026-10-09)

- `make -j5 full-test`: PASS. **82/82** differential fixture files passed;
  native C and Lua regressions, including all previous distribution suites,
  completed successfully.
- `make distributions69-test` included in `full-test`: native C regression,
  Lua regression, independent NumPy 2.3.5 differential fixture,
  and literal `examples/random_distributions69.lua` passed.
- **9,582/9,582 exact comparisons** for the Dirichlet oracle (8 scalar
  PCG64 seeds; beta stick-breaking and gamma normalization; zero/empty
  cases; sample shape and dtype; post-sample state; interleaved samplers;
  rejected arguments that do not consume RNG state).
- Native C expectations for both algorithms were generated independently
  with NumPy 2.3.5 (36 sample values and both post-state words).
- `clang -fsanitize=address,undefined` with `ASAN_OPTIONS=detect_leaks=1`
  ran the instrumented Dirichlet sampler, native random core and
  C regression: PASS. This does **not** assert sanitizer coverage for
  the remaining native codebase or the Lua adapter.
- Source algorithm reference: supplied NumPy 2.5.3; executable oracle:
  installed NumPy 2.3.5. NumPy is not linked into the LuaRay runtime.
- Explicit limitations: finite/nonnegative 1-D alpha, at most 1e6
  categories, no NumPy object/structured DTypes, no cross-platform
  bitwise guarantee outside the validated environment.

---

## 0.68.0-dev — multinomial (2026-10-09)

- NumPy 2.5.3 source: sequential `random_binomial` calls in
  `random_multinomial` (`distributions.c`). No Python runtime dependency.
- Independent NumPy 2.3.5 reference fixture:
  **58,790/58,790 exact comparisons**. Regenerator:
  `python3 tests/generate_distributions68_oracle.py` (test-time only).
- Full regression: **81/81 differential fixture suites**, 80 previous
  fixtures passing. New native C regression and Lua regression passed.
- Example `examples/random_distributions68.lua` executed literally.
- Directed ASan/UBSan with leak checking: modified native random sampler,
  new multinomial module and Lua adapter tested with differential fixture,
  regression and example; previously existing modules uninstrumented.
- Known limits: scalar Lua integer `n` <= 1e12, one-dimensional numeric
  probabilities, no broadcasting of `n` or `pvals`, no cross-platform
  exact-bit guarantee.

## 0.67 — Multivariate hypergeometric (2026-10-09)

- Public native C API: `Generator.multivariate_hypergeometric`, with
  the NumPy `marginals` and `count` algorithms.
- NumPy 2.3.5 oracle: **41,492/41,492 exact comparisons** passed, including
  next PCG64 values. Generator: `tests/generate_distributions67_oracle.py`;
  fixture: `tests/distributions67_differential_generated.lua`.
- **80/80** differential fixtures passed under `make full-test` (79 historical
  fixtures plus new 0.67 fixture). Native tests and the literal executable
  example passed.
- Directed ASan/UBSan with leak detection passed on the new sampler, PCG64,
  hypergeometric core, Lua adapter and tests. Other modules were not fully
  instrumented, so this is not an all-project sanitizer claim.
- Known limitations: count population cap, no broadcasting of parameters,
  compatibility only demonstrated for tested inputs and this platform.

## 0.66 — Hypergeometric (2026-10-09)

- New API: `rng:hypergeometric(ngood, nbad, nsample, size)`, C-native,
  direct and HRUA samplers ported from NumPy 2.5.3.
- NumPy 2.3.5 differential oracle: **63,544/63,544 exact comparisons** passed.
  Script: `tests/generate_distributions66_oracle.py`, generated fixture:
  `tests/distributions66_differential_generated.lua`. The generated fixture
  was regenerated and its SHA-256 remained identical.
- `make full-test`: **79/79 differential fixture files** passed, including
  all 78 prior fixture files.
- Native C test, Lua regression and the literal `examples/random_distributions66.lua`
  passed. The native test exercises 16,000 deterministic samples plus
  separately pinned golden NumPy results and following PCG64 raw words.
- Directed ASan/UBSan with leak checks: **passed** for the random core,
  hypergeometric implementation, Lua adapter, and native test. Other C/C++
  objects were linked without instrumentation; this is not a whole-project
  sanitizer claim.
- Source reference NumPy 2.5.3; runnable oracle NumPy 2.3.5.
  No Python dependency at runtime; no cross-platform bit identity guarantee.
- Known restriction: scalar integral arguments only, no parameter broadcasting.

# LuaRay 0.65.0-dev — Zipf validation

- Added `Generator.geometric(p, size)` natively in C, with NumPy-compatible
  direct search (`p >= 1/3`) and standard-exponential inversion (`p < 1/3`).
- NumPy 2.3.5 executable oracle: **7,280/7,280 exact comparisons** including
  int64 values, shape, dtype, next PCG64 raw word, interleaved samplers and
  extreme probabilities. Fixture: `tests/distributions64_differential_generated.lua`;
  reproducer: `tests/generate_distributions64_oracle.py`.
- `make full-test`: **77/77 differential fixture files** passed, including
  all 76 historic fixtures. Native C test includes 64,000 deterministic draws.
- The exact example `examples/random_distributions64.lua` was executed.
- Directed ASan/UBSan with leak detection passed for `ln_random.c`,
  `lua_module.c`, the 0.64 C test and Lua tests. Other native objects
  were linked without sanitizer instrumentation.
- The executable comparator was NumPy 2.3.5; NumPy 2.5.3 is source reference.
- Limits: finite scalar p in (0,1], no broadcasting of parameters,
  no cross-platform bitwise reproducibility guarantee.

---

# LuaRay 0.63.0-dev — Negative binomial verification

- Implemented `Generator.negative_binomial` in native C with NumPy 2.5.3
  Gamma–Poisson ordering, including state consumption for `p=1`.
- NumPy 2.3.5 executable oracle: **19,980/19,980 exact comparisons** of
  values, dtype, shape, next PCG64 word, interleaved samplers and error paths.
  Regenerate with `python tools/generate_distributions63_differential.py`.
- `make full-test`: **76/76 differential fixtures** passed (75 historical).
- Native C test: **64,000 deterministic draws**, plus state assertions.
- Literal executable example and Lua regression passed.
- Directed ASan/UBSan, with leak checking: **passed** for modified
  `ln_random.c`, `lua_module.c` and the new C test. Other objects were linked
  uninstrumented, including PocketFFT; this was not a whole-project pass.
- Upstream reference: supplied NumPy 2.5.3 source archive; executable
  differential oracle: NumPy 2.3.5. No Python dependency at runtime.
- Limits: finite scalar `n` in `(0,1e6]`, `p` in `[0.001,1]`, no parameter
  broadcasting or cross-platform bitwise equivalence guarantee.

---

# LuaRay 0.62.0-dev — Binomial validation

- `rng:binomial(n,p,size=nil)` implemented natively using NumPy inversion and BTPE.
- NumPy 2.3.5 differential fixture: **41,342/41,342 exact comparisons passed**;
  results, shapes, DTypes, PCG64 next raw word, boundary cases and invalid
  inputs. Generator: `tools/generate_distributions62_differential.py`.
- `make full-test`: **75/75** differential fixture files passed (74 historical).
- C native tests, Lua regression and literal executable example passed.
- Directed ASan/UBSan and leak detection passed for modified `ln_random.c`,
  `lua_module.c`, the new native C test and the new Lua checks; unmodified
  components including PocketFFT were not instrumented.
- Source: NumPy 2.5.3 release. Executable oracle: NumPy 2.3.5.
- Known limits: scalar probability, signed Lua integer n up to 1e12;
  no parameter broadcasting or platform-wide bitwise portability guarantee.

---

# LuaRay 0.61.0-dev — Poisson validation

- `rng:poisson(lam, size)` implemented natively, reusing 0.60 Poisson kernels.
- New NumPy 2.3.5 generated oracle: **8,492/8,492 exact comparisons** passed.
  Covers eight PCG64 seeds, empty and multidimensional shapes, scalar and
  zero-dimensional results, values across `lam=10` and up to `1e12`,
  invalid-argument rejection, long mixed sampler sequences, next raw state.
- All **74/74** differential fixtures passed `make full-test`; 73 historic
  differential fixtures remain passing.
- Independent C golden tests, 20-seed deterministic state invariants, Lua
  regression and literal `examples/random_distributions61.lua` passed.
- Directed ASan/UBSan with leak detection passed on modified `ln_random.c`
  and `lua_module.c`, native test, new Lua differential fixture and example;
  unmodified native components were linked without sanitizer instrumentation.
- Upstream source: supplied NumPy 2.5.3. Executable oracle: NumPy 2.3.5.
- Known limitation: `lam` finite, scalar, 0..1e12. No parameter broadcasting.

---

# Test results — LuaRay 0.60.0-dev

## 0.59 — Chi-square / Fisher F distributions

- Implemented native PCG64 `chisquare(df, size)` and `f(dfnum, dfden, size)`.
- New independently generated NumPy 2.3.5 oracle: **36,792 / 36,792** exact
  comparisons, including output values, dtype/shape, invalid-parameter
  rejection without state consumption, and observable subsequent PCG64 raw word.
- **72/72** checked-in differential files approved, including all 71 older files.
- Native C tests cover 32,000 additional compositional draws plus PCG64 state.
- `examples/random_distributions59.lua` was executed literally and succeeded.
- Directed ASan/UBSan instrumented the changed `ln_random.c`, Lua adapter, and
  native test, with leak checking enabled; existing unmodified objects were
  linked uninstrumented. The new Lua regression, oracle and example passed.
- Source: NumPy 2.5.3 release archive. Executable oracle: NumPy 2.3.5.
- Limitations: no parameter arrays/broadcasting or infinite degrees of freedom;
  cross-platform rounding may differ.

---

# Test results — LuaRay 0.58.0-dev

## 0.58 — Gamma, Beta, standard_gamma

- New oracle: **51,886/51,886** checks (see `tools/generate_distributions58_differential.py`).
- **71/71** checked-in differential fixture files approved (`make full-test`).
- The preceding **70** differential fixture files passed without regression.
- Numeric values in float64 compared exactly (including NaN semantics); float32
  standard-gamma compared with relative tolerance **3e-5**; all observable
  subsequent PCG64 64-bit words compared exactly.
- Native C tests, Lua regressions, invalid-argument state invariance, and
  literal `examples/random_distributions58.lua` passed.
- AddressSanitizer and UndefinedBehaviorSanitizer with leak checking were
  applied to modified `ln_random.c`, `lua_module.c` and the native test;
  the new differential fixture and Lua regression also passed under this
  directed instrumentation. Other objects, including PocketFFT, were not
  instrumented in this run.
- Upstream reference: NumPy 2.5.3. Executed oracle: NumPy 2.3.5.

---

# Test results for LuaRay 0.57.0-dev

## 0.57 — Pareto II, power and triangular

- 19,362/19,362 exact differential comparisons against NumPy 2.3.5.
- 70/70 checked-in differential fixtures passed `make full-test` (69 previous).
- Native C sampler assertions (including 10,000 mixed repetitions), Lua
  regression and literal Lua example passed.
- Directed ASan/UBSan with leak detection passed with `ln_random.c` and
  `lua_module.c` instrumented, as well as the new native test; unchanged
  objects (including PocketFFT) were uninstrumented.
- The executable example is `examples/random_distributions57.lua`.
- Reference code NumPy 2.5.3; oracle executed against NumPy 2.3.5.
- Cross-platform bitwise identity and vectorized distribution parameters
  remain outside this release's coverage.

---


## 0.56 — four additional PCG64 distributions

- Added Gumbel, logistic, Rayleigh and Weibull native C samplers with
  NumPy 2.5.3 source semantics and scalar parameters.
- **25,124/25,124 differential comparisons** against executable NumPy
  2.3.5: eight seeds, scalar/0D/empty/multidimensional shapes, zero scale
  and zero Weibull shape, interleaved draws, and next PCG64 raw words.
- **69/69 checked-in differential suites** passed with `make full-test`.
- Native C test, Lua regression and literal example passed.
- Directed ASan/UBSan with leak detection passed the instrumented
  `ln_random.c` and `lua_module.c` adapter and the new fixture; the rest of
  the native project was linked without instrumentation.
- Source references are SHA-256-pinned NumPy 2.5.3 release files; the
  executable NumPy oracle is 2.3.5. No Python dependency at runtime.
- Limitations: only scalar parameters, no parameter broadcasting, exact
  libm rounding may vary across platforms.

---

## 0.55 — three distributions, tested against NumPy

- Added C implementation of lognormal, standard_cauchy and laplace with scalar
  parameters and native float64 output; reference NumPy 2.5.3.
- **14,772/14,772 exact oracle comparisons** against executable NumPy 2.3.5
  covering eight PCG64 seeds, 0D/multidimensional/empty shapes, degenerate
  scales, interleaved sampling and subsequent PCG64 raw words.
- **68/68 checked-in differential fixtures** passed as part of
  `make full-test`, including all 67 preceding fixtures.
- The new C test, Lua regression and literal example all passed; the latter
  is included under `examples/random_distributions55.lua`.
- Directed ASan/UBSan/leak check passed on new C samplers, native test and
  Lua differential test. Unmodified objects including PocketFFT were not
  instrumented in this check. Not a whole-project instrumentation claim.
- Python is required only to regenerate the NumPy oracle; no Python or
  NumPy is required at LuaRay runtime.

---

## 0.54 — standard_exponential and exponential

- NumPy-compatible PCG64 exponential Ziggurat (float32/float64),
  inverse-CDF (`inv`) method, and scale-based double `exponential` in native C.
- **17,376/17,376 exact comparisons** to NumPy 2.3.5 across eight seeds,
  both algorithms and dtypes, empty/0D/multidimensional shapes, large
  sequences, mixed RNG calls, output dtypes and subsequent 64-bit states.
- **67/67** stored differential suites passed `make full-test`,
  including all **66 previous fixtures**. An existing cumulative
  fixture's hardcoded `_version` was updated to 0.54; it was not a
  numerical regression.
- Native PCG64, random, normal and exponential test approved; Lua
  exponential regression passed.
- Directed ASan/UBSan with `detect_leaks=1` passed the native test,
  exponential regression, new differential fixture, and normal differential
  fixture, instrumenting `ln_random.c` and `lua_module.c` only.
  Unmodified objects, including PocketFFT, were not instrumented.
- Referenced source NumPy 2.5.3; executed oracle NumPy 2.3.5.
  Exact cross-platform libm rounding is not guaranteed.

---

## 0.53 — standard_normal and normal

- Implemented NumPy-compatible 256-table Ziggurat sampling in native C,
  with independent float32 and float64 paths, and scalar-parameter normal
  scaling. NumPy BSD-3-Clause Ziggurat tables are retained with attribution.
- **11,768/11,768 exact NumPy 2.3.5 comparisons** approved across eight
  seeds: scalar/ndarray calls, float32, float64, shapes including 0D and empty,
  long batches including Ziggurat rejection paths, normal(loc,scale), and
  interleaved `standard_normal`, `integers`, `random`, and `raw_hex` calls.
- **66/66 historical and new differential fixture files** passed, including
  the 65 sets delivered with 0.52. `make full-test` passed, including all
  native and Lua regressions. No tolerance needed for the new fixture.
- Directed ASan and UBSan instrumentation of `ln_random.c`, `lua_module.c`
  and the native random core test passed with `detect_leaks=1` for the new
  Lua differential fixture. The rest of LuaRay remained uninstrumented.
- Source NumPy 2.5.3 is pinned as an implementation reference; executable
  NumPy 2.3.5 generated the oracle. No NumPy dependency at LuaRay runtime.
- Scalar `loc`/`scale` only; supported standard normal dtypes float32/64;
  arbitrary vectorized parameter broadcasting remains future work.

---

## New: native `Generator.integers` (NumPy PCG64 reproducibility)

- **5,250/5,250 exact oracle comparisons** against executable NumPy 2.3.5
  spanning int8/16/32/64, uint8/16/32/64 and bool, sizes, upper-bound
  inclusion, zero-length arrays, and distinct fixed seeds.
- 65/65 checked-in differential fixture files passed (`make full-test`),
  including all 64 previous fixtures. Existing native and Lua tests passed.
- Added native tests for bounded 8/16/32/64-bit sampling and PCG64 buffered
  state reset; added Lua regression tests for bad bounds, shapes, dtype and
  mixed use of `integers`, `raw_hex`, and `advance`.
- **Directed AddressSanitizer/UndefinedBehaviorSanitizer** and leak detection
  passed native and Lua integer tests with instrumented `ln_random.c` and
  `lua_module.c`. Unmodified objects were linked without instrumentation,
  so no claim of whole-project ASan coverage is made for 0.52.
- NumPy 2.5.3 was inspected as *source*, and NumPy 2.3.5 supplied *executed*
  expected outputs. NumPy/Python are not needed to execute LuaRay or its
  checked-in tests.
- Limitations: exact scalar Lua signed-64-bit bound arguments only; no
  vectorized low/high arrays and no uint64 bounds above INT64_MAX.

---

## 0.51 reproducible PCG64 random Generator

- Implemented SeedSequence(pool_size=4) mixing and NumPy PCG64 XSL-RR in
  `src/ln_random.c`, and the `np.random.default_rng(seed)` Lua userdata API.
- `random()`, `random(size)`, `uniform(low,high,size)`, `raw_hex`, `reseed`,
  and `advance` are covered by native and Lua regression tests.
- Five independently checked scalar seeds were compared with NumPy 2.3.5 raw
  PCG64 hexadecimal output; advance-by-1000 matches 1000 native draws.
- The new differential fixture contains **1,080/1,080 exact comparisons**
  across 8 seeds, raw uint64 output, random scalar/vector/multi-dimensional
  outputs, zero-size dimensions, shapes, dtypes, and scalar-bound uniform.
- **64/64 differential fixtures** passed alongside all existing C and Lua
  tests (63 historical fixtures plus the new random fixture).
- Directed AddressSanitizer/UndefinedBehaviorSanitizer with leak detection
  passed `test_random_core`, `random_regression.lua`, and the random differential
  fixture using instrumented `ln_random.c`/`lua_module.c`. Other modules were
  not recompiled with sanitizers for this step.
- Confirm the exact package and hash count with `sha256sum -c PROJECT_SHA256SUMS`;
  no compiled binaries are included in the delivery.

# Test results for LuaRay 0.50.0-dev

## 0.50 — native weighted average

- Added `np.average()` as a C-core operation with Lua option tables, axes,
  weights (whole-array or 1D per selected axis), `keepdims`, and two-value
  `returned=true` results.
- **1,500/1,500 new cases** compared with executable NumPy 2.3.5:
  727 matching numeric results and 773 expected rejections. Covers complex,
  signed/unsigned ints, floats, reversed/transposed views, empty shapes,
  zero weight totals, dtype and output shape.
- Native C precision and memory tests cover `uint64`, complex weights,
  reversed strides and independent returned buffers.
- `make full-test` passed with **63/63 checked-in differential fixtures**
  (the previous 62 plus the 1,500-case average fixture), Lua regressions,
  and native C tests.
- Directed ASan/UBSan with leak detection passed on `ln_average.c`,
  `lua_module.c`, native average test, Lua regression and 1,500 differential
  cases. Unchanged native objects were linked **without** instrumentation.
  No whole-project sanitized run is claimed.
- Release source NumPy 2.5.3 is for implementation reading, not an executed oracle.

---

# Test results for LuaRay 0.49.0-dev

## 0.49.0-dev — any, all, count_nonzero

- Native C kernel and Lua public methods for the three truth/population
  reductions, with 1-based axes, empty-slice identities and strided views.
- **3,200/3,200 new NumPy 2.3.5 differential cases passed**, including
  numeric and text DTypes, zero/negative strides, arbitrary axes, empty
  shapes, booleans, NaNs, complex, and broadcasted boolean `where`.
- **62/62 checked-in differential fixture files passed**, in addition to all
  previous Lua and native regressions; `make full-test` was successful.
- Native C regression verified uint64 precision, reversed views, scalar
  masks, wide empty Unicode DTypes, and floating-point NaN truthiness.
- Directed ASan/UBSan and leak checks passed for `ln_truth.c`, `lua_module.c`,
  native truth regression and 3,200 differential cases, with unchanged objects
  linked uninstrumented. **Not** a whole-project instrumented run.
- `count_nonzero` excludes `where` and `out` by design. `any`/`all` accept
  both, and stage into a temporary result before writing `out` to avoid
  overwriting input while iterating.
- NumPy 2.5.3 was the source reference; NumPy 2.3.5 was executed as oracle.

---

# Test results for LuaRay 0.49.0-dev

## 0.49.0-dev — native cumulative functions

- Added `cumsum`, `cumprod`, `nancumsum`, `nancumprod` with default C-order
  flattening, one-based explicit axes, dtype and output support.
- NaN-aware accumulations use an independent native C buffer and do not
  round `int64` or `uint64` values through floating-point conversion.
- Generated **1,180/1,180** differential cases with NumPy 2.3.5, across
  numerical and complex DTypes, empty shapes, transpositions, reverse-stride
  views, positive/negative axes and expected rejections.
- Native C regression tests cover uint64 near its maximum value, negative
  strides, NaN in both complex components and source immutability.
- Final `make full-test` passed: **61/61 differential fixture files**,
  with all 60 historical suites passing unchanged. Native and Lua regression
  tests, including alias-safe `out` and reverse-stride views, also passed.
- Directed AddressSanitizer/UndefinedBehaviorSanitizer checks passed for
  `ln_stats.c`, `lua_module.c`, the native cumulative C regression and the
  1,180-case differential fixture with leak detection. Other native objects,
  including PocketFFT, were not instrumented in this pass.
- `numpy-2.5.3` is pinned by three specific upstream SHA-256 references;
  NumPy 2.3.5 was the *executable* comparison target. Floating-point
  comparisons use relative tolerance 0.001 or 0.005 where applicable.


## 0.47.0-dev — native nanmin/nanmax/nanargmin/nanargmax

- Four new C-backed module operations and ndarray methods. Unlike the original
  extrema, these skip NaN values within each reduction slice while retaining
  exact DType comparisons, arbitrary strides and LuaRay 1-based arg indices.
- Fixed-seed, independently regenerated NumPy 2.3.5 differential fixture:
  **15,040 cases** (11,040 valid and 4,000 matched rejections), covering
  float16/32/64, complex64/128, integers, bool, empty and all-NaN slices,
  transposed arrays, negative strides, flattened and axis-wise reductions.
- Native C regression tests cover uint64 precision above 2^63, overlapping
  output buffers, complex NaNs, negative strides, and all-NaN behavior.
- Final `make full-test` passed with **60/60** differential fixture files,
  including **59/59 historical suites**. Native and Lua regression tests passed.
- Targeted ASan/UBSan (leak detection enabled) passed for the modified C
  statistics implementation, Lua adapter, native regression and 15,040-case
  differential fixture. PocketFFT and other unchanged objects were linked
  without sanitizer instrumentation; **not** a whole-project instrumented audit.
- NumPy's runtime warnings are not emitted; an all-NaN float/complex slice
  returns its first encountered NaN payload. Empty slices still error, and
  `nanarg*` errors for slices containing no non-NaN values.
- `nanptp` was deliberately NOT added because NumPy 2.3.5 does not expose it.
- NumPy 2.5.3 is the source reference, NumPy 2.3.5 the executable oracle.

## 0.46.0-dev — NaN-aware sum/product/mean/variance/std

- Implemented native `nansum`, `nanprod`, `nanmean`, `nanvar`, `nanstd` and
  ndarray methods via a C-generated broadcast-aware NaN/where mask and the
  existing reduction/statistics engines. No Python or NumPy runtime linkage.
- **2,400/2,400** new fixed-seed differential cases against the executable
  NumPy **2.3.5** oracle (**2,396 valid**, **4 expected rejections**).
  Compared values, dtypes of array outputs and error behavior. The test
  generator uses dtype-dependent tolerances up to **0.025** for float16.
- **59/59** differential fixture files and the full native/Lua regression
  suite pass. The historical 58 fixture files were not regenerated.
- Native C tests validate masks on negative-stride views, boolean `where`
  broadcasting, complex NaNs, exact uint64 input preservation and zero
  denominator handling.
- Targeted **ASan/UBSan** with leak detection: native C, Lua regression,
  and all 2,400 differential cases pass. Only the changed statistics kernel,
  Lua adapter and new test files were instrumented; dependencies including
  PocketFFT were linked uninstrumented. Not a whole-project ASan audit.
- Corrected `nanvar/nanstd` behavior for NaN-filtered floating/complex
  inputs when `ddof >= count`, preserving the earlier `var/std` behavior and
  NumPy's distinct behavior for integer inputs.
- Caveats: NumPy warning emission is not implemented, and numeric identity
  is approximate for some float16/float32 reductions. Additional
  unsupported computation dtypes remain explicitly rejected.
- NumPy **2.5.3** source files are pinned by
  `NUMPY_2_5_3_NANREDUCTIONS_FILE_HASHES.sha256`; the executable oracle was
  NumPy **2.3.5**.

# Test results for LuaRay 0.45.0-dev

## 0.45.0-dev — NaN-ignoring median, quantile and percentile

- Introduced three native C APIs: `nanmedian`, `nanquantile`, `nanpercentile`,
  also exposing `nanmedian` on ndarray instances. Each reduced slice filters
  NaNs without altering input and writes to an independent result or `out`.
- New fixed-seed differential fixture: **3,000/3,000** against executable
  NumPy **2.3.5**: **2,932 successful value/dtype/shape comparisons** and
  **68 matching rejected inputs**. Numerical comparison uses **0.002 relative
  tolerance**, not bitwise equality.
- `make full-test`: **58/58 differential fixture files passed** (57 historical
  plus the new fixture). C-native and Lua regression tests passed.
- Directed ASan/UBSan, with leak detection active: native core regression,
  Lua regression and 3,000-case differential fixture passed. Only the changed
  quantile kernel, Lua adapter, and new test translation units were instrumented;
  dependencies such as PocketFFT reused ordinary objects. This is **not** a
  whole-project sanitized run.
- Special cases: all-NaN slices, completely empty input, q vectors on empty
  arrays, input DType preservation in all-NaN leading slices, views with
  negative strides, `out` overlap, and invalid fractions/methods.
- Known limitations: NumPy runtime warnings are not emitted, additional
  quantile methods, complex/temporal/text DTypes, weighted/2D q, and exact
  floating-point bitwise results are not implemented.
- NumPy **2.5.3** source archive remains the implementation reference;
  NumPy **2.3.5** was executed as oracle.

# Test results for LuaRay 0.44.0-dev

## 0.44.0-dev — native median, quantile, percentile

- Added strided native quantile reduction `src/ln_quantile.c`, registered
  in the Lua adapter. Supports six quantile methods, scalar/vector q, axis
  tuples, `keepdims`, `out`, read-only input and dtype handling for real
  numeric and boolean arrays (boolean median and discrete quantiles).
- NumPy 2.3.5 executable oracle: **2,700/2,700 cases passed**:
  **2,347 valid outputs**, including DTypes and values, plus **353 expected
  failures**. The generator is reproducible with fixed seed 440044.
  Numerical comparisons use 0.002 relative tolerance; this is not bitwise
  identity and does not establish complete NumPy 2.5.3 compatibility.
- `make full-test`: **57/57 differential fixtures passed**, including all
  56 earlier fixtures, existing C/Lua regressions and new quantile tests.
- New native C precision test checks uint64 values beyond 2^63 exactly,
  negative-stride input, unchanged input storage and invalid arguments.
- Targeted **ASan/UBSan with leak detection** passed the C precision test,
  Lua regression and all 2,700 differential cases with the quantile kernel
  and Lua adapter instrumented. Other dependencies, including PocketFFT,
  reused normal objects; this is not a project-wide sanitized build.
- Exclusions: complex, text, datetime, higher-dimensional or empty q arrays,
  weighted quantiles, additional NumPy quantile methods, full floating-point
  bitwise parity, `overwrite_input` and advanced `out` casting paths.
- Source reference: the supplied NumPy 2.5.3 tarball; pinned source file
  checksums in `NUMPY_2_5_3_QUANTILE_FILE_HASHES.sha256`. Executable oracle:
  locally installed NumPy 2.3.5.

# Test results for LuaRay 0.43.0-dev

## 0.43.0-dev — native argmin / argmax / ptp

- Implemented three reductions in the native C statistics core and exposed
  module functions and ndarray methods.
- NumPy 2.3.5 fixture: **9,360/9,360 cases passed**: 7,308 successful
  value/shape comparisons and 2,052 intentionally rejected invalid inputs,
  across ten DTypes, 13 base shapes, zero-sized/scalar arrays, reversals,
  transposes, negative axes and keepdims. NumPy index outputs were translated
  to LuaRay's one-based convention in the oracle generator.
- `make full-test`: **56/56 differential fixture files passed** (55 prior
  sets plus the new one), with C-native and Lua regression tests passing.
- Directed ASan and UBSan: `ln_stats.c`, `lua_module.c` and the new C test
  were instrumented; the remaining native core (including PocketFFT) was
  linked from the regular build. `detect_leaks=1`, no issues detected in
  the native selection test, Lua selection regression or all 9,360 cases.
  This **is not** a new whole-project sanitizer audit.
- Known limits: no custom, temporal or text DTypes for these reductions.
  The oracle is NumPy 2.3.5, with NumPy 2.5.3 used as source reference.


## Current release validation (0.42.0-dev)

- Added C-native `min` / `amin` / `max` / `amax` extrema reductions, with
  `ndarray` methods, multi-axis selection, `where`/`initial`, `keepdims`,
  `out` with alias-safe writeback, strided arrays and preserved numeric DTypes.
- New executable NumPy **2.3.5** oracle battery: **2,400/2,400 passed**
  (**1,838** valid outputs, **562** expected errors). NumPy **2.5.3**
  serves as the source-code reference; the 2.5.3 release was not executed.
- `make full-test`: **55/55 fixture files** passed, including 54 earlier
  differential suites, native C tests, Lua smoke and dedicated regression.
- ASan/UBSan with `detect_leaks=1` passed for `test_extrema_core`,
  `extrema_regression.lua` and all 2,400 new differential cases. Most native
  objects were instrumented, but PocketFFT was reused uninstrumented because
  the complete sanitized recompilation timed out. This is a partial audit.
- Known differences: unsupported string/temporal/custom DTypes,
  complex initial scalar, exact output memory order in exceptional layouts.

## Archived validation (0.41.0-dev)

- Introduced the C-native `var` / `std` kernel (`ln_stats.c`) and public
  Lua wrappers with `axis`, `keepdims`, `ddof` / `correction`, `where`, `dtype`
  and `out` support. `ndarray:var()` and `ndarray:std()` are also available.
- Added **1,600/1,600** NumPy 2.3.5 differential comparisons and directed
  stride, aliasing and argument regression tests. Float16 comparisons use a
  5e-3 relative tolerance and other tests use 5e-4, rather than bit equality.
- `make full-test` passed all **54/54** differential fixture files, including
  the 53 historical suites. All historical fixtures were executed as stored,
  not regenerated against a new upstream version.
- Directed ASan/UBSan compilation of `ln_stats.c` and `lua_module.c` passed
  with `detect_leaks=1` for the new regression and differential tests.
  The other object files were reused without instrumentation; this is not
  a whole-project sanitizer audit.
- NumPy 2.5.3 source hash references are pinned separately. Python and NumPy
  are required only to generate new development oracles, not to run LuaRay.
- Known gaps: exact intermediate floating-point rounding, high-precision
  complex arithmetic, explicit integral calculation DTypes (rejected),
  `mean=` optimization parameter (rejected), and full output stride/order parity.

## Archived validation (0.40.0-dev)

- Core consolidation: fixed legacy builtin numeric + S/U common-DType promotion and width selection; no new public functions.
- Corrected bounded broadcasting diagnostic shape formatting for high-rank errors; native C test covers the rank-64 path.
- Added 2,020 new, generated differential comparisons against installed NumPy **2.3.5**: **2,020/2,020 passed** (2,016 matching results and four expected rejection cases). Source reference remains user-supplied NumPy **2.5.3** and previously pinned main-tree sources.
- `make full-test` **passed** including native C tests, Lua regressions and all **53 checked-in differential fixture files** (not just the recent subset). Historical fixtures were rerun, not freshly regenerated.
- Directed ASan/UBSan build passed for modified `ln_core.c`, `ln_string.c`, `lua_module.c` and native `test_core.c`; native core tests, the new promotion differential and Lua joining regression passed without reported sanitizer errors. Other object files were reused without instrumentation; `detect_leaks=0` was set. Not a whole-project sanitizer audit.
- NumPy/Python are **development-only** oracle dependencies. LuaRay execution remains native.
- Remaining gaps: full exotic float/complex textual conversion parity, custom/object DTypes, temporal/text common promotion and some NumPy F-order output layouts.

## Archived validation (0.39.0-dev)

## Current release validation (0.39.0-dev)

- Native `np.insert` implemented in `src/ln_insert.c`, including stable
  duplicates, scalar-vs-length-one-vector broadcasting, 1-based positions,
  negative positions, boolean/array/slice positions and independent copying.
- `make full-test` **passed**: native C tests, Lua smoke and regression,
  and the differential suites in the Makefile. The standalone native
  insertion test also verifies ownership after its input is freed.
- New NumPy 2.3.5 oracle comparisons **10,256/10,256 passed** (9,102 valid
  NumPy matches; 1,154 expected failures). Cases include 0-D to 3-D,
  noncontiguous/transposed/negative-stride sources, repeated indices,
  scalar/list differences, Unicode, empty arrays and boolean masks.
- **53/53 generated differential fixture files** in `tests/` executed
  successfully (52 retained files + the new insertion file). This count
  reflects actual files run rather than inferring from previous milestone
  labels. Prior reported cumulative count: 78,359 cases; adding the
  10,256 newly generated cases yields 88,615 by prior accounting.
- Directed AddressSanitizer + UndefinedBehaviorSanitizer validation
  **passed** for `src/ln_insert.c`, `src/lua_module.c`, and
  `tests/test_insert_core.c`: native C test, Lua regression, 10,256
  differential cases. Other objects, including PocketFFT, were not
  instrumented; `detect_leaks=0` was used for this partial build.
- NumPy 2.5.3 **source archive reference**, NumPy 2.3.5 **executable
  development oracle**; neither is required to run LuaRay.
- Known gaps: NumPy Fortran-order output strides; unsupported DType
  cross-family transfers and large-rank RHS values; edge-case behavior
  of negative insertion indices on an empty axis.

## Archived validation (0.38.0-dev)

## Current release validation (0.38.0-dev)

- Added `np.append` and `np.delete`, sharing the native `ln_join_arrays` copy kernel and a new `src/ln_delete.c` host-independent deletion kernel.
- `make full-test`: **passed** (native core, dedicated deletion core, Lua smoke/regressions and recent differential fixtures).
- **53/53 differential fixture suites passed, 78,359/78,359 cases total**: 52 historical suites (67,676 cases) + **10,683 new comparisons** against installed NumPy 2.3.5 (**7,767 successful comparisons and 2,916 expected errors**). The 52 older generated fixtures were executed without wholesale regeneration. The new 0.38 fixture was regenerated.
- New cases cover C-order flattening; rank 0–3; empty/scalar arrays; negative-stride/transposed views; bool, integer, float, Unicode DTypes; axis handling; indices as scalars/lists/ndarrays; boolean masks; slices; and invalid input rejection. They compare shapes, values and DTypes, **not complete output stride/order compatibility**.
- Directed ASan/UBSan on the new `src/ln_delete.c`, modified `src/lua_module.c` and native deletion test: **passed**, including the new 10,683-case fixture and regression. Unchanged native components (especially PocketFFT) were **not instrumented**; LeakSanitizer was disabled for this partial-instrumentation run.
- Source-only package, no CPython or NumPy runtime dependency. Source reference NumPy **2.5.3**, executed oracle NumPy **2.3.5**. Numeric/Unicode promotion remains a pre-existing shared join limitation.

## Archived validation (0.37.0-dev)

## Current release validation (0.37.0-dev)

- Added native wrappers for `hstack`, `vstack`, `dstack`, `column_stack`, and `row_stack` (NumPy's deprecated alias for `vstack`); these reuse native rank views and native join transfers.
- `make full-test`: **passed**, including the 2,875-case generated Lua differential fixture, core tests and Lua regressions.
- **52/52 frozen differential suites passed, 67,676/67,676 cumulative cases**. The 51 historical suites comprise 64,801 cases; 0.37 adds 2,875 (1,219 successful results; 1,656 expected input rejections). The new fixture was freshly regenerated against NumPy 2.3.5. Historical fixtures were executed but were *not all regenerated*.
- Regression verifies scalar/vector/matrix combinations, 3-D stacking, independent output allocations, dtype promotion, Unicode, empty dimensions, `dtype` and `casting`, error paths and NumPy keyword acceptance differences.
- ASan/UBSan targeted build passed on `src/lua_module.c`, `src/ln_join.c` and `src/ln_axis.c` with the regression and 2,875-case differential suite. All other objects (notably PocketFFT) were reused uninstrumented. LeakSanitizer was disabled for this partial-instrumentation run. **Not a whole-project sanitizer certification.**
- Known pre-existing limitation: the shared join DType promoter does not yet support cross-family numeric/Unicode promotion, so cases needing that path are excluded from the new differential fixture. Other unsupported NumPy DTypes (object/custom extension DTypes) are likewise outside the current subset.
- NumPy 2.5.3 from the user-provided tarball is the code/reference specification; NumPy 2.3.5 is the executable oracle, not a LuaRay runtime dependency.

## Archived validation (0.36.0-dev)

## Current release validation (0.36.0-dev)

- `make full-test`: passed (native core, native `atleast`, repeat/roll tests, Lua smoke, regression, and seven recent frozen differential suites).
- **51/51 frozen differential suites passed; 64,801/64,801 cases**. Historical 0.35: 50 suites/64,318 cases; 0.36 adds **483/483** real NumPy comparisons (shapes, values, DTypes and strides for nonempty inputs).
- New functions: `atleast_1d`, `atleast_2d`, `atleast_3d` in C, one or multiple arguments; existing ndarray inputs produce allocation-sharing views. Supports 0-D/scalars, 1-D/2-D and higher-rank arrays, read-only arrays, noncontiguous/negative strides, empty arrays and parameterized DTypes. Zero-argument calls return an empty Lua table.
- Fixed pre-existing empty-array DType discovery: `np.array({})` now defaults to float64 like NumPy rather than bool.
- Native `test_atleast_core` and Lua `atleast_regression.lua`: passed. `tools/generate_atleast_differential.py` regenerated the new 483-case suite and it passed.
- ASan + UBSan passed with `src/ln_axis.c`, `src/lua_module.c`, and native `test_atleast_core.c` instrumented; the native test, Lua regression and 483 new differential cases were executed. **Other native objects, including PocketFFT, were not instrumented**.
- Full historical differential oracle *regeneration* was not performed; **all 51 frozen files were run**. The NumPy 2.5.3 archive was a source reference; the NumPy 2.3.5 Python installation supplied executable oracle results. No Python runtime dependency.

## Archived validation (0.35.0-dev)

## Current release validation (0.35.0-dev)

- `make full-test`: passed (native core, native repetition and rolling tests, smoke, regressions, six recent frozen differential suites).
- **50/50 differential suites executed, 64,318/64,318 cases**. All 49 historical suites account for 43,673 cases; `roll`/`rollaxis` adds 20,645 (18,230 valid NumPy matches, 2,415 expected input rejections).
- NumPy 2.5.3, supplied as a source tarball, was read as the implementation reference; installed NumPy 2.3.5 was the executable comparison oracle. The frozen current 0.35 generator was rerun, not a complete regeneration of the historical 49 suites.
- Explicit native C tests cover copying, view lifetime and shared ownership, row/column and C-order flat rolling, Fortran-layout outputs and empty Unicode shapes.
- Directed `-fsanitize=address,undefined` on `src/ln_roll.c`, `src/lua_module.c` and the new native test passed, including the 20,645 new differential cases. Unchanged objects, particularly PocketFFT, were reused **without** sanitizers.
- Source-only package, no binary artifacts or Python runtime dependency.

## Archived validation from 0.34.0-dev

## Current release validation (0.34.0-dev)

- `make full-test`: passed (native core, new repeat/tile native C test, Lua smoke and regression, and five recent differential suites).
- **49/49 differential suites executed, 43,673/43,673 cases**. The 48 previous suites account for 35,643; the new repeat/tile suite adds 8,030 (7,176 positive and 854 negative cases).
- The source oracle was **NumPy 2.5.3**; the runnable oracle used to freeze expectations was **NumPy 2.3.5**.
- The complete `make oracle-test` (including regeneration of all historical oracles) was interrupted by its execution timeout after partially regenerating fixtures. Every historical and new generated Lua suite was then run directly and passed. This is *not* a claim that the full generator target completed.
- Directed `-fsanitize=address,undefined` builds of `src/ln_repeat.c` and `src/lua_module.c` passed: native test, regression, 8,030 differential cases. Other unchanged object files, including PocketFFT, were not instrumented.
- Packaging is source-only; LuaRay never needs NumPy/Python at runtime.

## Archived validation from 0.31.0-dev

Upstream source archive commit pin: `286e698f1dcf601648b165f48485ceaeec9c6231` (`main`, NumPy `2.6.0.dev0`). The supplied `numpy-main.zip` matches the pinned upstream file set. The direct audit now also pins `numpy/_core/src/multiarray/descriptor.c`, `numpy/_core/tests/test_strings.py`, and `numpy/_core/tests/test_unicode.py` alongside the already-pinned legacy string transfer/arraytype sources, and now `numpy/_core/tests/test_casting_unittests.py`, and the 0.29 casting-policy sources/tests, bringing the exact verified set to **102/102** upstream source/test files.

## Native + Lua smoke

```text
core tests: ok
lua smoke tests: ok
```

The smoke/core suite covers ndarray allocation/views/broadcasting, indexing/assignment, DType class/descriptor identity and promotion, DType packing/casting, the legacy buffered ufunc path, the generic ufunc registry/N-input-N-output iterator, multi-output `out`/`where`, reductions, accumulate/reduceat, products, sorting/searching, native float16/complex paths, elementary math, real/complex BLAS selectors, PocketFFT, and LAPACK-backed linalg including QR, eigenvalue decomposition, SVD, GELSD least squares, pseudo-inverse, rank, norm, condition numbers, tensor solvers, matrix powers, optimized matrix chains, contractions, diagonal/trace, cross products, transpose wrappers, and conjugating `vecdot`.

## Development-only differential oracle

`make oracle-test` regenerates expectations with development Python NumPy where appropriate and executes them through the native Lua runtime. NumPy `main` source semantics override the installed oracle when they differ (notably the current-main complex return DType for real `eig`/`eigvals`). The current tree passes **22,110/22,110** generated differential cases across **44 generated suites**.

Key suite counts:

```text
differential add/multiply: 220
buffered mixed-DType stress: 5
basic indexing/casting/reshape/assignment: 930
basic reductions/mean: 323
advanced indexing/assignment: 480
subtract/true_divide: 393
NpyIter out/where: 355
extended reductions: 325
accumulate: 264
reduceat: 286
matmul: 306
dot/inner/outer: 486
sorting/selection: 565
searchsorted: 366
comparison/logical/minmax/unary catalogue: 1382
numeric floor-divide/remainder/power/bitwise/minmax: 1360
base math ufuncs: 663
float16: 755
complex core: 929
complex math: 207
extended real/complex math: 346
inverse trig/hyperbolic + atan2/hypot: 270
PocketFFT 1-D: 335
PocketFFT n-D/2-D: 327
DType promotion: 256
LAPACK solve/inv/det/slogdet/cholesky: 474
LAPACK QR: 149
LAPACK eig/eigh/SVD: 618
advanced linalg (`lstsq`/`pinv`/`matrix_rank`/`norm`/`cond`): 609
linalg public-surface closure: 723
casting policy + same_value astype: 4553
generic ufunc registry / multi-output (`frexp`/`modf`/`divmod`/`ldexp`): 329
registry migration / KEEPORDER: 215
weak-scalar resolver + second binary migration: 1065
unary transcendental registry closure: 338
```


### Generic ufunc engine coverage

The new **329-case** suite validates the first operations routed exclusively through `ln_ufunc` + `ln_nditer_multi`: `frexp`, `modf`, `divmod`, and `ldexp`. Coverage includes all currently supported real numeric DTypes where upstream exposes a loop, input promotion/registered-signature selection, `frexp`'s integer exponent output, integer and floating `divmod` floor/remainder rules, heterogeneous `ldexp` exponent signatures, broadcasting, negative strides, signed zero, complete and partial multi-output `out`, `where` preservation, output casting, and expected complex/unsafe-signature rejections.

The architectural invariant is checked in native core tests: registry metadata reports `frexp`/`modf` as `1->2`, `divmod` as `2->2`, and `ldexp` as `2->1`. None of these operations was added to the legacy `LN_OP_*` enum, which remains at 56 values.

### Registry migration coverage

The new **215-case** migration suite covers `add`, `subtract`, `multiply`, `true_divide`, all six migrated comparisons, and the nine migrated unary/predicate operations through the generic registry. It exercises DType promotion, exact `int64`/`uint64` comparison behavior, complex paths where exposed by upstream, `out=`, `where=`, output casting, ndarray arithmetic operators, negative strides, and observable KEEPORDER output strides for transposed and mixed-sign-stride views.

Native registry metadata tests also verify representative arity/signature tables. The four 0.20 operations remain registry-only, the newly migrated operations do not add enum values, and the legacy `LN_OP_*` enum remains exactly **56 values** while migration proceeds incrementally.


### Weak-scalar and second-wave registry coverage

The **1,065-case** 0.22 suite exercises host-language weak booleans/integers/floats/complex scalars on both operand sides across registered arithmetic, comparison, logical, min/max, floor/remainder/power, bitwise, `copysign`, `arctan2`, and `hypot` paths. It checks value-sensitive integer fitting and overflow rejection, inexact/complex weak promotion, exact mixed signed/unsigned 64-bit comparisons, `out=`, `where=`, Lua operators, and explicit NEP-50 regressions translated from the pinned upstream tests. The scalar is not assigned a concrete ndarray DType until the generic resolver has selected the loop.

The same tranche migrates 16 more binary ufunc families to the registry and adds a generic iterator validation callback used by integer `power` to reject active negative integer exponents while respecting a broadcast `where` mask.


### Unary transcendental registry coverage

The **338-case** 0.23 suite covers all 21 migrated transcendental/inverse unary ufuncs through `ln_ufunc` + `ln_nditer_multi`. It validates NumPy's safe integer/bool-to-inexact loop selection (`int8 -> float16`, `int16 -> float32`, wider integers -> float64), float/complex exact-loop selection, the absence of a complex `cbrt` loop, generic `out=`/`where=` writeback, KEEPORDER result strides for transposed inputs, signed-zero preservation, and the Lua aliases for inverse trig/hyperbolic names. Core metadata checks require a **60-entry** registry and representative 7-loop inexact signatures / 4-loop real-only `cbrt`. Public unary and binary ufunc wrappers no longer execute a legacy fallback path.

### Eigenvalue/SVD coverage

The new **618-case** suite covers `eig`, `eigvals`, `eigh`, `eigvalsh`, `svd`, and `svdvals` across integer/float/complex DType resolution, stacked matrices, transposed/strided inputs, both `UPLO` choices, full/reduced SVD, `compute_uv=false`, Hermitian SVD, empty matrices, shape/error paths, and NumPy-main DType behavior. Because eigenvectors and singular vectors can differ by valid sign/phase choices, tests compare spectra/singular values and validate `A @ V = V * W`, `A = (U * S[..., None, :]) @ Vh`, and relevant shape/DType invariants rather than demanding byte-identical vector columns.

The empty full-SVD path is explicitly tested: NumPy initializes the corresponding `U`/`Vh` outputs to identities because LAPACK can leave those buffers untouched for zero-size dimensions, and LuaRay reproduces that observable behavior.

### Advanced linalg coverage

The **609-case** advanced suite covers `lstsq`, `pinv`, `matrix_rank`, `norm`, and `cond` across real/complex/integer inputs, empty systems, vector/matrix right-hand sides, stacks, Hermitian paths, scalar and ndarray tolerances, tolerance broadcasting, result-shape expansion for `matrix_rank`, arbitrary norm axes, `keepdims`, singular matrices, and NaN/Inf condition-number behavior. It also translates the upstream regressions for signed-int minimum p-norms and `longdouble`/`clongdouble` p-norms.

The development oracle is NumPy 2.3.5, but the supplied NumPy `main` source remains authoritative. One intentional override is the upstream fix for empty integer `pinv`: current main returns `float64`, while the older local oracle returns `int64`. LuaRay follows current main.


### Linalg public-surface closure coverage

The new **723-case** suite covers `matrix_power`, `tensorinv`, `tensorsolve`, `multi_dot`, strict 1-D `outer`, last-two-axis `diagonal`/`trace`, broadcast 3-vector `cross`, integer-count and explicit-axis `tensordot`, the restricted-signature `linalg.matmul` alias, `matrix_transpose`, `matrix_norm`, `vector_norm`, and conjugating `vecdot`. It includes stacks, mixed numeric DTypes, vector endpoints, output arrays, negative powers, tensor axis permutations, empty tensor/norm cases, non-last vector axes, complex conjugation, read-only diagonal views, and error paths translated from the pinned upstream tests.

During this suite the first `tensorsolve` implementation exposed a real porting bug: `a.ndim - b.ndim` had been treated as a starting axis rather than as the number of solution axes. The implementation now follows upstream's `a.shape[-(a.ndim-b.ndim):]` rule, including the `(0, 3, 3, 0)` zero-sized regression case.

### Earlier math/FFT/linalg coverage

The inverse-math oracle contributes **270** cases, PocketFFT contributes **335** 1-D plus **327** n-D/2-D cases, and the first linalg tranche contributes **474** solve/inv/det/slogdet/cholesky plus **149** QR cases. Existing generated suites continue to pass unchanged.

## Sanitizers

Core tests, Lua smoke, the **338-case** unary-registry suite, the **1,065-case** weak-scalar registry suite, the **215-case** registry-migration suite, the **329-case** generic-ufunc suite, and the **474-case** first linalg, **149-case** QR, **618-case** eigen/SVD, **609-case** advanced-linalg, and **723-case** linalg-surface suites pass with ASan + UBSan and `halt_on_error=1`. All C objects involved in those paths are sanitizer-instrumented. The existing normal PocketFFT object is reused uninstrumented in this targeted run because recompiling the large header-only PocketFFT translation unit with sanitizers exceeds the execution limit in this environment; no claim is made that the PocketFFT translation unit itself was sanitizer-instrumented in that targeted run.

The signed-integer translated ufunc loop translation unit remains compiled with `-fwrapv` so intended modular integer arithmetic does not rely on C signed-overflow UB.

## Runtime dependency check

The canonical runtime artifact is `build/luaray_core.so`. `ldd` resolves Lua 5.4, BLAS, LAPACK, libstdc++, libm, libc, libgcc and the LAPACK Fortran runtime only; there is **no Python/CPython shared-library dependency**.

The module has unresolved dynamic LAPACK references for the implemented paths, including `d/zgesv`, `d/zgetrf`, `d/zpotrf`, `d/zgeqrf`, `dorgqr`/`zungqr`, `d/zgeev`, `dsyevd`/`zheevd`, `d/zgesdd`, and `d/zgelsd`. Python/NumPy remains development-only test tooling and is never loaded or invoked by `luaray_core.so` or the Lua runtime path.

The clean release payload contains **138 files covered by `PROJECT_SHA256SUMS`**; build products are intentionally excluded from the archive.


### DType class / descriptor architecture coverage

The 0.24 native core tests now assert the NumPy-2-style split directly: builtin descriptors point to stable DType classes, class lookup and default-descriptor lookup are inverses for singleton numerics, class flags identify the current non-parametric builtin set, `common_dtype` is resolved at class level, and `common_instance`/common-descriptor resolution returns the correct concrete singleton for current numerics. Representative ufunc registry signatures are also checked to contain `ln_dtype_class *` entries rather than descriptor pointers.

The 0.24 representation-only baseline was **16,654/16,654 across 39 generated suites**. In 0.25 all 39 prior suites still pass unchanged and the new temporal suite adds **386/386**, for **17,040/17,040 across 40 suites**. The 0.25 sanitizer pass instruments all changed datetime/DType/iterator/registry/Lua-boundary objects and is clean for core/smoke, datetime (386), weak-scalar registry (1,065), unary registry (338), registry migration (215), multi-output registry (329), and base linalg (474). Large unchanged `ln_ufunc_loops`, PocketFFT, and linalg objects are reused uninstrumented when their sanitizer compilation exceeds the execution window; normal clean release builds compile all of them from source.


## 0.25 datetime/timedelta parameterized-DType validation

The new generated suite contains **386/386** passing cases. It exhaustively crosses all 13 NumPy temporal base units for zero-valued datetime subtraction and timedelta addition, isolating concrete-descriptor promotion (including the nonlinear timedelta barrier), and also covers nonzero/multiplier arithmetic, all six comparisons, NaT propagation, timedelta unary/sign, `isnat`, `isfinite`, temporal min/max/fmin/fmax, metadata-changing `out=` casts, `where=`, masked overflow suppression, valid signed-int64 boundaries, overflow-to-NaT-sentinel rejection, and scalar indexing preserving multiplier metadata.

ASan+UBSan found and fixed one masked-overflow UB in the first draft: a masked element could still execute raw signed `a+b` inside the kernel even though validation correctly skipped it. The final kernel uses defined unsigned two's-complement arithmetic internally while the source-derived validator raises overflow only for active elements. With that fix, `halt_on_error=1` passes core/smoke plus datetime **386/386**, weak-scalar **1,065/1,065**, unary registry **338/338**, registry migration **215/215**, multi-output **329/329**, and base linalg **474/474**. The unchanged large `ln_ufunc_loops`/PocketFFT/linalg objects may be reused uninstrumented when sanitizer compile windows are exceeded; all changed datetime/DType/iterator/registry/Lua-boundary objects are instrumented.


## 0.26 ISO datetime string validation

The new ISO-datetime differential suite contributes **165/165** passing cases. It checks inferred descriptors from year/month/day/time/fraction precision, explicit conversion targets from `Y` through `as`, signed/negative years, leap-day behavior, `NaT` and empty-string NaT, parser variants translated from the pinned upstream datetime tests, UTC `Z` and numeric-offset normalization, arrays of Lua strings into explicit datetime DTypes, common-descriptor discovery for generic `datetime64` array construction, scalar `datetime_as_string`, `unit="auto"`, explicit UTC/manual-offset formatting, casting rejection, and the upstream parser error corpus.

A deliberately preserved NumPy quirk is covered at attosecond precision: the calendar conversion can wrap the int64 payload and therefore format back to a seemingly unrelated time near the epoch. LuaRay reproduces the exact int64 result using defined unsigned/two's-complement arithmetic rather than C signed-overflow UB. For example, the pinned behavior for `1969-12-31T23:34:56.789012345678901234` at `datetime64[as]` yields payload `-9024717683847417870` and formats with the same wrapped result as NumPy.

All **40 prior differential suites** continue to pass unchanged, bringing the total to **17,205/17,205 across 41 generated suites**. The targeted ASan+UBSan pass is clean for core/smoke, temporal metadata arithmetic **386/386**, ISO datetime strings **165/165**, weak-scalar registry **1,065/1,065**, unary registry **338/338**, registry migration **215/215**, multi-output registry **329/329**, and base linalg **474/474**. PocketFFT may be reused uninstrumented only in this targeted sanitizer build because its instrumented compilation exceeds the execution window; normal clean release builds compile PocketFFT from source.


## 0.27 fixed-width string/unicode validation

The new legacy string/unicode suite contributes **275/275** passing cases. It covers Unicode-width discovery by code point, explicit `S1..S6` / `U1..U4` truncation and zero padding, little/big-endian UCS4 round-trips, multidimensional storage and transposed views, all six comparison ufuncs across a systematic `S1..S4` and `U1..U4` descriptor-width matrix, weak Lua-string scalar comparisons, broadcasting, `out=`/`where=`, same-family assignment/casts, Unicode endian transfers, ASCII `S -> U`, raw-byte `S` truncation, strict UTF-8 rejection at the `U` host boundary, current-main mixed `S`/`U` comparison rejection, and ndarray-valued `datetime_as_string` output including keep-order behavior.

All **41 prior generated suites** pass unchanged. The resulting baseline is **17,480/17,480 across 42 generated suites**, plus core and Lua smoke tests. The targeted ASan+UBSan pass is clean for core/smoke, strings/unicode **275/275**, ISO datetime strings **165/165**, weak-scalar registry **1,065/1,065**, unary registry **338/338**, registry migration **215/215**, and generic multi-output registry **329/329**. PocketFFT is reused uninstrumented only in this targeted sanitizer build; normal clean release builds compile it from source.


## 0.28 legacy string/numeric/temporal cast validation

The new cast/discovery suite contributes **77/77** passing cases. It covers numeric/bool to generic and fixed-width `S`/`U`, source-DType-driven generic output widths, fixed-width truncation, `S`/`U` parsing to bool/integer/float/complex (including whitespace and numeric underscores), complex text forms, parser failures, numeric ↔ datetime/timedelta count transfers, generic-datetime rejection/NaT handling, string ↔ temporal conversion, mixed Lua string/numeric discovery, and explicit unsized `S`/`U` construction from formatted scalar values.

All **42 prior generated suites** pass unchanged. The resulting baseline is **17,557/17,557 across 43 generated suites**, plus core and Lua smoke. Targeted ASan+UBSan is clean for core/smoke, cast/discovery **77/77**, legacy strings/unicode **275/275**, and ISO datetime strings **165/165**; PocketFFT is reused uninstrumented only in that targeted sanitizer build. During this tranche differential testing found and fixed two real transfer bugs: complex legacy-string formatting had to match NumPy's compact `(1+2j)` forms exactly, and float normalization changed a buffer without updating its byte count, which truncated `0.0` to `0`. A partial-branch `float16 -> integer` memcpy-size regression was also removed by restoring typed conversion.

## 0.29 descriptor casting-policy validation

The new casting-policy suite contributes **4,553/4,553** cases. Its main matrix crosses 30 concrete supported descriptors against each other under all five normal policies (`no`, `equiv`, `safe`, `same_kind`, `unsafe`), for **4,500 descriptor-policy checks**, plus source-derived boundary assertions, ndarray-source behavior, `astype` enforcement, and NumPy-main-only `same_value` cases. The latter cover integer overflow, exact/inexact integer↔float conversions around the 2^53 boundary, float→integer integrality, float narrowing, NaN/Inf, complex→real imaginary-part rejection, boolean exactness, and temporal safe-metadata conversion. `np.can_cast(..., "same_value")` is explicitly rejected because upstream supports that mode only on `ndarray.astype`.

All **43 prior generated suites** pass unchanged. The resulting baseline is **22,110/22,110 across 44 generated suites**, plus core and Lua smoke. The targeted ASan+UBSan pass is clean for core/smoke, casting policy **4,553/4,553**, cast/discovery **77/77**, legacy strings/unicode **275/275**, and ISO datetime strings **165/165**. The sanitizer pass instruments the changed transfer/Lua-boundary code while reusing unchanged normal objects (including PocketFFT); the clean release build recompiles all objects from source.

The final clean export was rebuilt from an empty `build/` directory, including PocketFFT, and then ran core, Lua smoke, and all **44/44 frozen generated suites** successfully. `ldd` on that clean module reports Lua, BLAS/LAPACK and system runtimes only, with no Python/CPython dependency. The exact supplied NumPy source tree verifies **102/102** entries in `UPSTREAM_FILE_HASHES.sha256`.


## 0.30 array-joining validation

The new `ln_join_arrays` host-neutral native implementation adds
`np.concatenate` and `np.stack`, including inserted/existing axes, optional
C-order flattening, concrete-DType promotion, explicit `dtype`/`casting`,
`out` with noncontiguous strides, and alias-safe temporary staging. The
joining code and Lua adapter compile with `-Wall -Wextra -Wpedantic` without
new compilation warnings.

The frozen new differential suite passes **355/355** cases. The cases compare
NumPy 2.3.5 and LuaRay across heterogeneous numeric types, casting safety
policies, explicit output descriptors, 0-D/1-D/2-D/3-D shapes, transposes,
negative strides, complex arrays, fixed-width `S`/`U` Unicode, empty inputs,
flattening, and invalid shapes/casts. Additional non-generated Lua and native
C regressions validate strided `out`, output/input aliasing, exact identity
of returned `out`, temporal descriptor promotion, and failure conditions.

Every earlier generated differential suite was run against the rebuilt
native module and all **44/44** passed unchanged. Prior baseline:
**22,110/22,110** cases; new total: **22,465/22,465 across 45 suites**, plus
native core, Lua smoke, and joining regression tests. Exact sha256 records
for the six additionally inspected NumPy **2.5.3** source/test files are in
`NUMPY_2_5_3_JOIN_FILE_HASHES.sha256`. The original 2.6-main pinned file
hashes remain unmodified. NumPy 2.5.3 was used as *source reference*, while
local NumPy 2.3.5 was the executable development oracle; neither is used at
LuaRay runtime.

No all-object sanitizer pass is claimed for the 0.30 tranche. The old
sanitizer results elsewhere in this report refer to the earlier snapshots.


## 0.31 zero-copy split-family validation

Added the native C `ln_split_view` storage/view kernel and Lua APIs
`split`, `array_split`, `hsplit`, `vsplit`, and `dsplit`. The new frozen
NumPy 2.3.5 differential suite verifies **5,557/5,557** cases, including
4,432 successful operations and 1,125 correctly rejected inputs. Its
shape/axis/sections matrix covers exact and ragged subdivisions, ordered
and unordered boundary sequences, limits outside the source shape, negative
boundaries, zero-sized dimensions, 1-D/2-D/3-D arrays, noncontiguous
transposes and negative-stride views, and numeric/bool/Unicode DTypes.
Additional Lua regressions verify write-through aliasing, ownership after
collecting the original ndarray, temporal descriptors, and the full API's
rank/argument rejection behavior. Native C tests cover shared ownership
after original release and extreme boundary values.

All **45/45 earlier generated suites** were regenerated or run through
`make oracle-test` and pass unchanged, bringing the total to
**28,022/28,022 cases across 46 generated suites**. `make full-test` also
passes core, smoke, join and split regressions. A targeted ASan+UBSan run
is clean for C core, split Lua regressions and all 5,557 split differential
cases, with changed `ln_split.c`, `lua_module.c` and the C test harness
instrumented. Unchanged modules (including PocketFFT) were linked from the
normal build, and therefore an all-object sanitizer clean bill is **not**
claimed. NumPy 2.5.3 served as a hashed source reference; the executable
oracle is installed local NumPy 2.3.5.


## 0.32 zero-copy axis manipulation validation

Nine array-axis APIs were added: `transpose` with arbitrary permutation,
`swapaxes`, `moveaxis`, `expand_dims`, `squeeze`, `flip`, `flipud`, `fliplr`,
and `rot90`. New `tools/generate_axis_differential.py` freezes **4,544**
reference cases against the installed NumPy 2.3.5 (4,320 successful outputs,
224 correctly rejected inputs). The oracle checks values, shapes, DTypes,
and strides for nonempty arrays. Four concrete DTypes, rank 0–4, zero and
singleton dimensions, C/F/negative-stride views, axis lists, rotation counts,
and invalid axis inputs are represented. The complementary Lua regression
validates bidirectional write-through, garbage collection/owner lifetime,
and temporal/Unicode descriptors.

All **46/46 previous frozen suites** passed and the complete new result is
**32,566/32,566 differential cases across 47 suites**. The normal native
C core, Lua smoke, joining/splitting regressions, and axis regressions passed.
ASan+UBSan were run over the native modules and adapter with the unchanged
PocketFFT object linked uninstrumented; this limitation prevents claiming
that PocketFFT or *all* linked code was sanitizer-clean. The 2.5.3 source
archive, not an installed executable NumPy 2.5.3, supplied source semantics.
## 0.99.1 — float32 inverse-exponential portability (2026-11-08)

- Initial Ubuntu CI failed an unchanged exact float32 inverse-exponential value.
  Direct old-libm loading reproduced it; 80-digit Decimal calculations confirmed
  three glibc 2.39 rounding differences on exact PCG64 uniforms.
- Double evaluation followed by float32 rounding preserves every existing test
  value and next-PCG64 state. The 17,376 exponential comparisons pass unchanged;
  four explicit three-value/next-word assertions were added.
- Corrected-code Ubuntu CI **42526947924**, commit **965203b**, passed all 116
  fixture files and both public examples. Local Arch full-test also passed.
- Release checks and the added ln_random sanitizer scope are recorded in their
  actual logs/reports. No full old-libc ABI execution was claimed locally.

## 0.99 — source-derived masked assignment (2026-11-08)

- Complete local `make full-test` passed **116/116 differential fixture files**
  plus old/new native C and Lua regression suites.
- **4,914 copyto + 1,481 putmask cases**, **175,110 comparisons** against actual
  NumPy 2.5.3; **77 targeted Lua regression checks** and public examples passed.
- Actual post-error output, live shared masks, raw stride traversal, overlapping
  source direction, zero-stride views, scalar promotion, empty values and legacy
  text buffer boundaries are covered.
- ASan initially found overlapping memcpy in identity transfers. After memmove
  and identity-string fixes, the instrumented three changed C units passed both
  native tests and ten Lua suites. Other dependencies uninstrumented; leaks off.
- Refactored 0.98 fixtures and new 0.99 fixtures reproduced byte-for-byte.
  Numeric historical expectations were preserved; release assertions now use 0.99.
- Forty original numeric-byte-order states remain blocked, outside parity totals.
  Clean source build/test/example/integrity results belong to the final release
  verification JSON/log; remote GitHub CI is a separate check.

## 0.98 — native put/place and assignment conversions (2026-11-08)

- Imported 0.97 archive matched the supplied SHA-256 and all 603 source hashes.
  The recovered baseline passed 112 differential fixture files on this machine.
- New `make full-test` passed **114/114 fixture files** and existing/new C/Lua
  regressions after correcting discovery of Arch's already-installed CBLAS.
- Real **NumPy 2.5.3** generated **1,002 put + 733 place cases**, with **42,754
  actual Lua comparisons**. Additional targeted Lua regression: **94 checks**;
  native C tests and the public dynamic-module example passed.
- Covers dtype conversions, arrays versus Lua scalars/tables, repetition,
  error-state mutation, C-order traversal, inverted/transposed/strided/shared
  zero-stride views, aliased indices/values/masks, scalars and empty inputs.
- Forty original non-native numeric-byte-order cases are retained separately
  and blocked at descriptor construction; they are excluded from passing totals.
- Directed ASan/UBSan passed all three changed C translation units plus native
  test and seven Lua suites. Other native objects were not instrumented; leak
  detection disabled. Full sanitizer scope is recorded by tools/sanitize_write98.py.
- Regeneration compared the fixtures byte-for-byte. Final source integrity,
  extraction, fresh compilation, complete test and public example outcomes
  are recorded in the release verification JSON and clean-build log.
- Historical tests' release-version assertions now require 0.98. Their numerical
  reference outputs were preserved, alongside the original oracle provenance.

The 0.31 internal version-string bug was fixed to `0.32.0-dev`.

## 0.33 zero-copy broadcasting validation

Three NumPy-native APIs were added: `broadcast_to`, `broadcast_arrays`, and
`broadcast_shapes`. They use shared storage, zero strides for repeated axes,
shape-based iteration and preserved concrete DType metadata. In keeping with
NumPy 2.5.3's stride-tricks implementation, `broadcast_to` is read-only,
whereas `broadcast_arrays` inherits base writeability; an unchanged input to
`broadcast_arrays` keeps its original byte strides.

The new frozen NumPy 2.3.5 executable-oracle suite contains **3,077/3,077**
passing comparisons: **1,034** valid outputs and **2,043** expected rejections.
The source matrix checks dimensions, actual nested values, concrete dtype,
and byte strides, including empty/singleton/zero-dimensional arrays,
negative and transposed strides, `int32`, `float64`, `bool`, Unicode, shape
merging of two/three inputs, invalid shapes and impossible broadcasts.
Lua regressions additionally check read-only assignments, write-through for
`broadcast_arrays`, garbage-collection survival, overflow rejection and
parameterized temporal descriptors. This tranche also fixed `flip` of an
*empty-length axis*: its byte stride must remain unchanged, matching NumPy
slice normalization.

All **47 earlier generated suites** pass unchanged alongside the new suite:
**35,643/35,643 differential cases across 48 generated suites**, plus
native core, Lua smoke, and join/split/axis/broadcast regressions. A targeted
ASan/UBSan run instruments `src/ln_axis.c` and `src/lua_module.c` and executes
broadcast regressions plus generated cases; the other linked objects,
including PocketFFT, are reused uninstrumented. This is not an all-object
sanitizer audit. NumPy 2.5.3 serves as the source reference, with five file
hashes recorded separately; NumPy 2.3.5 serves as the runnable oracle.


## 0.60 — noncentral chi-square / F validation (2026-10-09)

* 73/73 frozen differential Lua fixture files passed (`make full-test`).
* New independent NumPy 2.3.5 differential fixture: 12,728/12,728 exact
  value, shape, dtype, next-PCG64-word and rejection comparisons passed.
* Native C golden bit patterns / PCG64 state and 20,000 central-consistency
  iterations passed.
* The literal Lua example completed with exit status 0.
* Targeted AddressSanitizer+UndefinedBehaviorSanitizer with leak checking:
  instrumented `ln_random.c` and `lua_module.c`, native test, new regression
  and 12,728-case fixture passed. Other linked objects were not instrumented.
* Reference NumPy 2.5.3 source code; executable NumPy 2.3.5 oracle.
* Intentional domain restriction: only finite scalar noncentrality <= 1e12
  and finite positive scalar df. No platform-independent bit-for-bit claim.



## 0.78 — Additional random parameter broadcasting (2026-10-11)

- Eight vectorized distributions: `lognormal`, `laplace`, `gumbel`, `logistic`, `rayleigh`, `weibull`, `pareto`, `power`.
- 2,000/2,000 randomized and 114/114 extreme-case comparisons against NumPy 2.3.5; numeric results, shapes and exact subsequent PCG64 word.
- 11/11 invalid cases rejected without advancing the generator.
- 92/92 differential suites plus C and Lua tests passed (`make -j6 full-test`).
- Reproducible NumPy oracle generation confirmed byte-for-byte.
- Targeted ASan/UBSan on the modified Lua module passed the new tests, with leak checking. Not a full-project sanitization claim.
- Upstream pinned to NumPy 2.5.3 (`NUMPY_2_5_3_RANDOM78_FILE_HASHES.sha256`).


## 0.65 — Zipf validation (2026-10-09)

- `make full-test`: **78/78** frozen differential fixture files pass,
  including the 77 historical suites.
- `distributions65_differential_generated.lua`: **11,336/11,336** exact
  comparisons to NumPy 2.3.5 (value, dtype, shape, next raw PCG64 value,
  errors and mixed calls), from 8 seeded streams and scalar shapes including
  empty, zero-dimensional and multidimensional results.
- `test_distributions65_core.c`: 32,000 native deterministic draws +
  PCG64-state checks, including a >=1025 no-consumption behavior.
- ASan and UBSan with leak checking: the changed `ln_random.c`,
  `lua_module.c` and the C test were instrumented; the new differential
  fixture, Lua regression and literal example all passed. Other linked
  objects were **not** instrumented.
- Literal `examples/random_distributions65.lua`: successful exit.
- NumPy 2.5.3 source reference; NumPy 2.3.5 executable oracle. No
  requirement for NumPy/Python at runtime.
- Not a proof of all-platform bit identity or all-API compatibility;
  parameter broadcasting remains unimplemented.


## 0.82 — Broadcasted Wald and logseries (2026-10-11)

- `tests/random82_differential_generated.lua`: 483/483 independently generated NumPy 2.3.5 comparisons passed, including output values, shape, dtype and exact subsequent PCG64 raw word.
- `tests/random82_regression.lua`: 16 invalid-input checks with unchanged PRNG state; 40,000 sampled values checked for valid range and broad statistical mean; passed.
- `examples/random82.lua`: passed, printed two matrices' sample elements and PCG64 tail.
- Development-tree `make -j8 full-test`: all 96 differential fixtures and C/Lua regressions passed.
- Directed ASan+UBSan build of `src/lua_module.c` passed both new suites (other objects uninstrumented).
- NumPy 2.5.3 is a source reference; NumPy 2.3.5 is the executable oracle. Numerical values use 1e-12 relative comparison tolerance.

## LuaRay 0.97.0-dev (reconstructed from 0.94)

- Built the Lua native module and runner successfully.
- `make full-test` passed, including 112 differential fixture files (110 inherited, two new).
- New NumPy 2.3.5 differential fixtures: 274 cases for `copyto` / `putmask`, 162 cases for `shares_memory` / `may_share_memory`, totaling 436 cases.
- `tests/memory97_regression.lua` passed for masked/overlapping copies, scalar bounds, and rejected casts with unchanged destination.
- The modified `lua_module.c` was compiled with ASan/UBSan and passed the three 0.97 test files, with leak detection disabled. All dependency modules were not instrumented.
- Build uses an unoptimized pocketfft C++ compilation for manageable compile time; optimized C functionality preserved.
- Clean tarball verification: record separately after execution.
