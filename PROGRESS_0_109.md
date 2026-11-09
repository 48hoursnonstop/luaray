# LuaRay 0.109.0-dev — binary mathematics and Lua coercion

Fmod and float_power are native typed ufuncs. Existing binary calls accept
ordinary Lua scalars/tables through rooted constructor coercion while preserving
weak scalar strength when paired with an ndarray. Scalar outputs are typed
rank-zero arrays. Options are parsed before temporary stack allocation.

## Executed evidence

- Fmod1,428 cases /189,111 checks; float_power1,428 /205,745; binary coercion
  784 /18,244; string/logical1,346 /101,716. Total4,986 /514,816.
- Native C boundary tests and303 Lua checks passed. Full143/143 fixtures passed.
- Directed ASan/UBSan25units(24C+1Cpp),13native/53Lua passed. Other dependencies
  uninstrumented; leaks off. New fixtures include integer extremes on both sides.
- Fmod/coercion/string values and metadata are exact. Float_power relative budget
  2e-12, observed3.23e-15 (absolute3.20e-14). Existing numeric assertions were not
  weakened; only version assertions and intended registry73 count were updated.
- Runtime inventory333/675,341missing,1N/A; all partial, zero complete APIs.
- Four fixtures and inventory are reproduced separately; the versioned release
  JSON/log records the actual clean source build/regression/twelve-example gate.

## Source-derived fixes

Fmod keeps the dividend's sign and guards integer zero/min%-1 without UB.
Float_power forces at least double/complex128 before weak scalar conversion.
Original coercion tests found missing S/U add and incorrect early logical casts.
Native string addition now resolves summed widths, canonical byte order, padding
and embedded NUL, with staged output conversion and descriptor overflow guards.
Binary logical promotion converts supported inputs to bool first, retaining tiny
weak real/imaginary values and fixed-string content truth. Full regression passes.

## Remaining work

Full ufunc object/signature/warning/device/subclass behavior, every ABI/CPU path,
all input protocols and complete string operations remain incomplete. Lua raw
strings default to Unicode; an explicit S/U array supplies the class context for
a weak string. No variable StringDType or Python bytes/str scalar hierarchy.
Next coherent work: ravel/flatten and array view/layout operations, then continue
the missing dependency inventory. English/Spanish references describe tested
contracts and limitations. LuaRay and luanimath are not declared complete.
