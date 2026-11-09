# External reference checks

`reference-tests.sh` is used by `make reference-test`. It verifies the SHA-256 of
the immutable 0.116 source archive, then executes its frozen references against
the current native build. Downloaded data stays under the ignored `.dev/` directory.

Set `LUARAY_REFERENCE_ARCHIVE` to use an existing copy of that exact archive.
The full Python oracle and release tooling is preserved in the published source
package; it is not needed by this checkout.
