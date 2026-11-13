---
docs_examples: true
---
# Primeros pasos

Compila LuaRay, cárgalo desde Lua y calcula con tu primer array.
Los comandos siguientes se ejecutan desde el código fuente en Linux.

## 1. Revisa las dependencias

Necesitas Lua 5.4 con su biblioteca compartida, compiladores C11 y C++11,
Make, BLAS/CBLAS y LAPACK. `pkg-config` ayuda a localizar las bibliotecas instaladas.
Compilar y ejecutar la biblioteca no requiere Python, NumPy ni Node.js.

En Arch Linux los paquetes son `lua`, `base-devel`, `cblas`, `blas` y `lapack`.
En Debian/Ubuntu: `lua5.4`, `liblua5.4-dev`, `build-essential`, `libblas-dev`,
`liblapack-dev` y `pkg-config`. Instala únicamente las dependencias que falten.

## 2. Compila el módulo nativo

```sh
git clone --depth 1 https://github.com/48hoursnonstop/luaray.git
cd luaray
make -j4
```

Se genera `build/luaray_core.so`. La entrada pública está en `lua/luaray.lua`.
Para cambiar rutas de bibliotecas o flags del compilador, consulta la
[guía de compilación](../development/contributing.md).

## 3. Escribe un programa

Guarda esto como `first.lua` en el checkout:

```lua
local lr = require("luaray")

local temperatures = lr.array({18, 21, 24}, "float64")
local fahrenheit = temperatures * 1.8 + 32

assert(math.abs(fahrenheit[1] - 64.4) < 1e-12)
assert(lr.mean(temperatures) == 21)
print(fahrenheit:tolist()[1]) -- 64.4
```

Las operaciones conservan forma y dtype según sus reglas de promoción.
`tolist()` convierte los valores en datos Lua ordinarios.

## 4. Ejecútalo

```sh
LUA_PATH='./lua/?.lua;;' LUA_CPATH='./build/?.so;;' lua5.4 first.lua
```

`LUA_PATH` localiza el módulo Lua público. `LUA_CPATH` localiza el módulo
compartido compilado. Los ajustes se aplican a este comando y no modifican
la configuración del sistema. Conserva `;;` para incluir las rutas normales de Lua.

## 5. Explora

```sh
make examples
make -j4 full-test
```

Los ejemplos cubren matemáticas, vistas, FFT, muestreo aleatorio, geometría y
álgebra lineal. Las pruebas ejecutan las regresiones mantenidas en C y Lua.
`make reference-test` obtiene y verifica un corpus congelado de referencia NumPy;
consulta [verificación](../development/validation.md).

Continúa con [formas, índices y broadcasting](arrays.md).

## Solución de problemas

| Síntoma | Qué revisar |
| --- | --- |
| `module 'luaray' not found` | Ejecuta desde el checkout y configura `LUA_PATH` como en el ejemplo. |
| `module 'luaray_core' not found` | Ejecuta `make` y apunta `LUA_CPATH` al directorio de compilación. |
| Fallo al enlazar símbolos Lua | Usa Lua 5.4 y ajusta `LUA_SO` si está en una ruta personalizada. |
| Fallo al enlazar BLAS/LAPACK | Revisa las bibliotecas de desarrollo; ajusta `BLAS_LIBS` o `LAPACK_LIBS` si hace falta. |
| PocketFFT consume demasiada memoria al compilar | Limpia la compilación y usa los flags de desarrollo de la [guía](../development/contributing.md). |
