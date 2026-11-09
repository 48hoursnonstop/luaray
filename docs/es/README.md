# LuaRay

**Cómputo numérico al estilo NumPy para Lua.**

[English](../../README.md) · [Documentación](../README.md) · [Versiones](https://github.com/48hoursnonstop/luaray/releases)

LuaRay ofrece arrays multidimensionales tipados, broadcasting, vistas de memoria,
operaciones matemáticas y estadísticas, FFT, álgebra lineal y generación de
números aleatorios. La API usa Lua 5.4 y los kernels están escritos en C y C++.
Compilar y ejecutar LuaRay no requiere un intérprete Python.

```lua
local np = require("luaray")
local values = np.array({1, 2, 3}, "float64")
assert(np.sum(np.square(values)) == 14)
```

## Compilar y ejecutar

La plataforma principal es Linux. Se necesitan Lua 5.4 con su biblioteca
compartida, compiladores C11 y C++11, Make, BLAS/CBLAS y LAPACK. `pkg-config`
ayuda a localizar las bibliotecas instaladas.

```sh
git clone --depth 1 https://github.com/48hoursnonstop/luaray.git
cd luaray
make -j4 build/luaray_core.so
LUA_PATH='./lua/?.lua;;' LUA_CPATH='./build/?.so;;' lua5.4 examples/quickstart.lua
```

Los índices y ejes positivos empiezan en **1**. Los negativos cuentan desde el
final. Las convenciones de argumentos, vistas y copias están en las
[guías de referencia](../README.md).

## Estado

La versión publicada es [0.116.0-dev](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
El proyecto está en desarrollo y usa NumPy 2.5.3 como referencia principal.
La compatibilidad depende de la operación, el dtype y las opciones utilizadas.

El [inventario de APIs](api_inventory.md) distingue disponibilidad y
compatibilidad; las APIs disponibles siguen clasificadas como parciales.
Entre las funciones pendientes están arrays de objetos y estructuras, strings de
ancho variable y endian numérico no nativo.

## Verificación

```sh
make -j4 full-test
```

La suite ejecuta las regresiones mantenidas en C y Lua. `make examples` ejecuta
los ejemplos. Ninguno de estos comandos requiere Python ni NumPy.

`make reference-test` obtiene el archivo de una versión publicada, comprueba su
SHA-256 y ejecuta **161 archivos diferenciales** y referencias adicionales de
aleatoriedad y formato contra el motor actual. Los datos generados y sus
herramientas se conservan fuera del árbol principal.

Consulta los [resultados y tolerancias](../development/validation.md), las
[instrucciones de desarrollo](../../CONTRIBUTING.md) y el
[historial de cambios](../../CHANGELOG.md).
