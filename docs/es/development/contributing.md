# Compilación y contribuciones

LuaRay está dirigido a Lua 5.4 en Linux. Conserva las comprobaciones numéricas,
las reglas de dtype, el comportamiento de memoria compartida y las tolerancias
documentadas. Registra las funciones pendientes: disponibilidad no implica
compatibilidad completa.

## Compilar y probar

Revisa las dependencias en [primeros pasos](../getting-started.md) y ejecuta:

```sh
make -j4 full-test
make examples
make reference-test
```

Los dos primeros comandos usan las pruebas C/Lua y los ejemplos del checkout.
El último obtiene un corpus de referencia de la versión inmutable 0.116,
verifica su SHA-256 y lo ejecuta contra el motor actual. Requiere `curl`, `tar`
y `sha256sum`. Ninguno requiere Python ni NumPy.

Puedes ajustar `CC`, `CXX`, `LUA_SO`, `BLAS_LIBS` y `LAPACK_LIBS`. Para compilar
PocketFFT más rápido durante el desarrollo, usa
`CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'`.
Ejecuta `make clean` al cambiar flags o interfaces nativas.

## Organización

- `lua/`: módulos públicos Lua.
- `src/`: kernels nativos, bindings Lua y código de terceros con sus licencias.
- `tests/`: regresiones mantenidas en C y Lua.
- `examples/`: ejemplos ejecutables por tema.
- `docs/`: documentación en inglés y español.
- `compatibility/`: inventario de APIs, límites y hashes de las fuentes de referencia.
- `tools/`: ejecución opcional de referencias externas.

## Referencias y versiones

Los fixtures grandes, generadores Python y herramientas originales de publicación
se conservan en el [paquete fuente 0.116](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
Regenera referencias con la versión NumPy fijada desde un entorno de desarrollo
separado; ese entorno no es necesario para compilar ni usar LuaRay.

Mantén consistentes `VERSION`, la versión del runtime, las aserciones y los
registros de compatibilidad. Antes de publicar, compila y prueba una extracción
limpia, verifica los ejemplos y referencias y registra el SHA-256 del paquete.
Los cambios de memoria nativa requieren sanitizadores con alcance documentado.
Las versiones publicadas son inmutables. Consulta [verificación](validation.md).

## Sitio de documentación

VitePress necesita Node.js únicamente para desarrollar o compilar el sitio.

```sh
cd docs
npm ci
npm run dev
npm run build
```

Los archivos ingleses están en `docs/` y sus traducciones en `docs/es/`, con
nombres iguales. Actualiza el menú en `.vitepress/config.mts` al añadir páginas.
Usa enlaces Markdown relativos entre páginas y ejecuta los ejemplos Lua nuevos.
Los archivos generados y `node_modules` se ignoran; GitHub Actions publica el
sitio en GitHub Pages.
