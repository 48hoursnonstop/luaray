# Upstream provenance and third-party code

NumPy 2.5.3 is LuaRay's primary behavioral reference. Earlier differential
fixtures generated with NumPy 2.3.5 retain that version in their headers.
The original imported implementation also records NumPy source commit
`286e698f1dcf601648b165f48485ceaeec9c6231`.

Pinned source-file checksums live in
[`compatibility/upstream/`](../../compatibility/upstream/README.md).
They identify the source files inspected for individual subsystems and releases.
Reference generators are development tools; the running Lua library does not
execute Python or upstream NumPy.

## Notices

- NumPy-derived components retain the
  [NumPy BSD notice](../../THIRD_PARTY_NUMPY_LICENSE.txt).
- Vendored PocketFFT retains its
  [license](../../src/third_party/pocketfft/LICENSE.md).
- BLAS/CBLAS and LAPACK are external native dependencies.

Preserve these notices when redistributing source or binaries. Detailed original
source notes remain in the [upstream history](../history/upstream-notes.md).
