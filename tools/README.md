# Development tools

These scripts support development and release verification. They are not needed
by a running LuaRay application.

- `generate_*`: regenerate original NumPy reference fixtures. Each script states
  its required oracle version; generated fixtures are checked into `tests/`.
- `inventory_api.py`: probe the compiled Lua module and produce the scoped API
  availability inventory.
- `sanitize_write98.py`: compile and run the progressively extended directed
  ASan/UBSan audit. Use its Makefile targets rather than assembling flags manually.
- `release.py`: build a source archive and verify it through a clean rebuild.
- `fetch_pinned_numpy.sh`: fetch the original pinned source snapshot into
  `.dev/upstream/` by default, or into an explicitly supplied directory.

See [Contributing](../CONTRIBUTING.md) for build settings and validation rules.
