# LuaRay0.111.0-dev — real/imag component views

New independent native/binding modules expose root functions and ndarray
properties. Complex components share storage while remaining disjoint from
each other; noncomplex real retains userdata identity, imaginary zeros are
independent/read-only. Views preserve owner lifetime and source writeability.

Executed:3,300 NumPy2.5.3 cases /273,192 exact checks,33 Lua checks and native C
suite passed. Full147/147 fixtures passed. Inventory338/675 available,336missing,
1N/A,allpartial. ASan/UBSan29units(28C+1Cpp),15native59Lua passed; other dependencies
uninstrumented, leaks off. The final clean archive gate is recorded in
TEST_RESULTS.md and versioned release JSON/log. English/Spanish API references
and five source/test hashes are included. Property replacement setters and full
Python scalar/foreign/subclass/device protocols remain incomplete.

Continue the dependency inventory after publishing: iscomplex/isreal/object
predicates, real_if_close, clip/round and dtype views. LuaRay and luanimath are
not complete. User requested continuous work until actual usage exhaustion.
