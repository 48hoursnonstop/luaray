# LuaRay0.113.0-dev — typed decimal rounding

Native round/around and ndarray method preserve source composition, integer copy,
negative-integer float64 work, output-dependent precision, complex component
assignment, and actual partial writes. Root TypeError retry is distinct from
method execution. Independent native/binding modules reuse the shared engines.

Executed: rounding2,780/141,112checks; outputs2,346/189,964; floating timedelta
scaling3,100/150,416. Total8,226/481,492 exact,42Lua andnative C passed.
Full153/153 fixtures passed. ASan32units(31C+1Cpp),17native67Lua passed;
other dependencies uninstrumented, leaks off. Inventory346/675,328missing,1N/A,
allpartial. Final archive clean-build/regression/16examples is independently gated.

New floating temporal signatures compute in double, including longdouble
coefficients, and retain units/NaT/output masks. Integer scaling and ratios remain
pending. Internal ln_error classification supports wrapper retries; all native
objects were rebuilt after its dev C-layout change and aggregate initializers
updated. Ufunc same_kind now uses the existing full descriptor casting engine.
The native true_divide signature count increased7 to8, with explicit class checks.

Source factor multiplication is preserved to exponent308, then stabilizes at
infinity. INT_MIN/MAX native tests pass without running huge source loops.
Nine hashes and EN/ES references document scope and remaining ABI/FP/protocol
limits. No old numerical reference assertion was weakened. Continue missing
clip, dtype views and temporal integer arithmetic after release.
