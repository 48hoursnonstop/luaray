# LuaRay0.105.0-dev — native FFT helpers and precision fixes

Six new native public bindings supply frequency grids, spectrum shifts and
Hermitian transforms. C helpers reuse typed ufuncs, KEEPORDER iteration and roll;
C++ PocketFFT executes the actual transforms. No Python runtime is introduced.
The FFT API reference is provided in English and Spanish.

## Actual execution

- Original NumPy2.5.3 frequencies:826 cases /28,419 checks, maximum error0.
- Spectrum shifts:1,800 /86,698, exact values and metadata, maximum error0.
- Hermitian/old FFT precision and output cases:6,964 /343,993, maximum absolute
  error1.9073486328125e-6 within explicit float32 tolerances.
- Total9,590 /459,110;111 direct Lua checks and new native C tests passed.
- All129 frozen differential fixture files and existing C/Lua regression passed.
- All three new fixtures regenerate exactly with the pinned oracle.
- Directed ASan/UBSan passed15 C units plus the changed C++ FFT integration,
  eight native and33 Lua suites. Other dependencies uninstrumented, leaks off.
- Final versioned release JSON/log separately records source manifest integrity,
  actual clean extraction/build/full regression and eight public examples.
  Remote Ubuntu CI is separate from local verification.

## Defects reproduced and corrected

Zero-stride shift cases exposed roll's incorrect sorting of zero strides as
largest. KEEPORDER allocation now preserves the actual NumPy strides. Hermitian
conjugation uses native NpyIter allocation, preserving layout and bool's int8
intermediate. Positional nil n no longer drops subsequent axis/norm/out values.

Original out cases exposed extra half rounding for explicit float32 output and
unwanted widening of exact float32/complex64 FFT computation. Half normalization
is retained; actual exact input loop precision is retained for wider destinations.
The direct Lua suite checks known corrected values exactly; original differential
tolerances were not weakened. Read-only output is rejected before writing.

Expanded unsupported text/out tests reproduced a SIGSEGV in ln_fft_fft:
output-driven promotion accepted a NULL natural dtype, then normalization
received NULL. The systemd core and GDB showed real_dt=NULL, Unicode input and
complex64 output. Dtype validation now precedes promotion. Related irfft
validation was reordered during source audit before executing that unsafe path.
The failing public calls now raise Lua errors; native and instrumented tests
exercise them. No system configuration was changed. Only the privately extracted
diagnostic core was deleted; the symbolized log stays in local artifacts.

## Availability and remaining work

Actual runtime inventory:303 available/675 scoped callable names,371 missing
bindings and one justified Lua exception adaptation. FFT has18/18 names available;
every available API remains partial. Availability is not full behavioral coverage
or overall completion. Fixed reference tolerance:3e-6 absolute+relative for
float32/complex64,2e-12 for wider output; shift values/metadata remain exact.

Earlier40 blocked endian states and explicit take/choose differences remain
separate. Device arguments, objects/structured/variable strings, complete warnings,
subclasses and all dtype-length-output combinations remain uncertified. Continue
with remaining coherent numerical/API gaps after release; luanimath is unfinished.
