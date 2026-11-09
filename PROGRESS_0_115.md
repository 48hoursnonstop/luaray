# LuaRay0.115.0-dev — typed views and actual bytes

Native ndarray:view/tobytes plus itemsize/nbytes share/reinterpret actual storage
and export bytes in source-compatible order. Last-axis shape/itemsize changes,
owner lifetime, readonly state and native overflow are checked. Uniform Unicode
K export follows source ravel behavior; plain numeric/bytes/time K uses C order.

Executed:6,480/332,518 views;4,464/253,875 bytes/layouts;5,850/308,716
unaligned math. Total16,794/895,109 exact checks,27Lua/native C passed.
A binary-string equality counts one check. Deterministic uint8 backing preserves
raw padding/Unicode patterns without interpreting arbitrary floating values.
Full159/159 fixtures passed. ASan36units(35C+1Cpp),19native75Lua passed;
other dependencies uninstrumented, leaks off. Exact three-fixture/inventory
regeneration and public example passed. Inventory350/675,324missing,1N/A,
allpartial. Final source clean-build/regression/18examples is independently gated.

Alignment is recomputed; numeric scalar reads/writes use memcpy. Legacy/generic
iterators and reduction/accumulation/reduceat stage unaligned operands, with
explicitly aligned scalar work buffers. Directed mathematical references cover
byte offsets1/3. All ABIs, downstream algorithms and foreign memory remain
uncertified. Void/subarrays/structured/object/variableStringDType, non-native
numeric endian and Python subtype/type arguments remain pending. EN/ES docs,
eight source pins and original old numerical assertions are retained.
