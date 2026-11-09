# LuaRay 0.97.0-dev — ndarray memory and masked writing

## Provenance and scope

Reconstructed from the verified 0.94.0-dev source archive. The actual 0.95 and 0.96 release archives were unavailable; the memory APIs from the previous development descriptions have been reimplemented. This release is **not verified byte-for-byte equivalent** to either unavailable archive.

## Native functionality

- `shares_memory(a,b)`: byte-accurate overlap test for supported views, including strided arrays, with explicit work and span limits.
- `may_share_memory(a,b)`: conservative byte-bounds overlap detection.
- `copyto(dst,src,casting,where)`: in-place broadcasting, DType policy, mask and source snapshots, all conversions staged before mutation.
- `putmask(dst,mask,values)`: C-order flattened mask, cyclic source values by positional index, and snapshots preventing alias corruption.

All are implemented in native C and exposed from `luaray_core`.

## Behavioral limits

- `shares_memory` rejects overly large noncontiguous exact-overlap queries (>1 million elements per input or >64 MiB intersection span) rather than risking excessive computation.
- LuaRay's public API accepts a positional `casting` argument and positional `where` for `copyto`. Python keyword arguments are not implemented in Lua.
- `putmask` currently requires an explicitly boolean `ndarray`/Lua boolean table mask and does not implement every NumPy coercion for heterogeneous Python lists.
- Views with repeated physical locations (e.g. writeable zero-stride views) have not been exhaustively validated against NumPy's in-place traversal order.
- The LLVM/ASan instrumented module only covers the edited module, not the whole library.

## Test methodology

The reference generator scripts under `tools/` execute NumPy 2.3.5 (the installed oracle). Outputs are stored as Lua fixtures for execution without Python.

This release continues from a 0.94 baseline and does not claim a complete NumPy 2.5.3 port.
