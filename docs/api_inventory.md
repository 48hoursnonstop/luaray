# API availability inventory

`compatibility/api_inventory.json` records actual Lua callable lookups against
NumPy 2.5.3 public names. It was generated from the pinned NumPy interpreter
and the compiled native Lua module. This is a development reference record;
reading it requires neither Python nor NumPy.

The current scope contains **675 names**, including aliases and callable Python
types: root/fft/linalg/random `__all__` callables, and public ndarray, Generator
and ufunc methods. It excludes constants, properties, every other submodule,
all dtype-loop combinations and signature/corner-case coverage.

| Group | Scoped names | Lua callables | Missing bindings | Lua adaptation |
| --- | ---: | ---: | ---: | ---: |
| numpy | 462 | 280 | 182 | 0 |
| numpy.fft | 18 | 18 | 0 | 0 |
| numpy.linalg | 32 | 31 | 0 | 1 |
| numpy.ndarray | 53 | 49 | 4 | 0 |
| numpy.random | 60 | 1 | 59 | 0 |
| numpy.random.Generator | 44 | 43 | 1 | 0 |
| numpy.ufunc | 6 | 0 | 6 | 0 |
| Total | 675 | 422 | 252 | 1 |

**422 callable names observed does not establish full compatibility.**
Available names are classified `implemented_partial`; behavior is assessed
separately through original fixtures and release-specific contracts. The
inventory declares zero APIs completely compatible. Missing names use
`not_implemented` pending review; alternate Lua spellings can exist, such as
`lr.add_accumulate` for an operation exposed differently by NumPy ufunc objects.
The table measures direct names in its stated scope, not all mathematical
capabilities or overall NumPy completion.

`numpy.linalg.LinAlgError` is explicitly `not_applicable_to_lua`: it is a Python
exception class; the native Lua library raises Lua errors and does not reproduce
a Python exception-class hierarchy. The record includes that justification.
Other callable types are not automatically exempted. Full Python warning,
subclass and exception-class fidelity is not claimed.

The inventory generator is preserved in the
[0.116 source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
for use in a separate NumPy reference workspace. It queries module fields and real
ndarray/Generator/ufunc prototypes, including callable userdata. It does not execute
every discovered operation. Regression and differential suites provide the separate
evidence for tested behavior.
