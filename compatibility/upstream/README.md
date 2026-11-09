# Pinned upstream files

The manifests in this directory identify NumPy and PocketFFT source files used
as implementation references. Paths inside each manifest are relative to the
corresponding upstream source tree, not to the LuaRay checkout.

`UPSTREAM_FILE_HASHES.sha256` records the original import snapshot. The
`NUMPY_2_5_3_*` files record subsystem-specific references; version suffixes mark
the LuaRay milestone that inspected them. `POCKETFFT_FILE_HASHES.sha256` records
the vendored FFT reference.

[Upstream provenance and notices](../../docs/development/upstream.md)
