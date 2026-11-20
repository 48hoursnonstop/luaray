# Verificación

## LuaRay 0.192.0-dev

| Prueba | Alcance |
| --- | --- |
| Regresiones mantenidas | 82 suites nativas y 164 suites Lua |
| Ejemplos públicos | 7 programas Lua |
| Documentación | 635 bloques Lua en 196 páginas en inglés y español |
| Corpus diferencial congelado | 161 archivos de pruebas, más referencias de aleatoriedad y formato |
| Corpus diferencial acumulado | 102 archivos de pruebas, incluidos 19 añadidos desde la 0.173 |
| ASan y UBSan | 105 objetos instrumentados, suites mantenidas y los 102 archivos acumulados |

Los 19 archivos nuevos de referencia NumPy 2.5.5 reúnen **35 427 casos**
y **2 442 877 comprobaciones**. Los [cambios en 0.192](../release_192.md)
enlazan cada función con su guía y alcance probado. El
[inventario de API](../api_inventory.md) registra la disponibilidad de
675 nombres.

Los sanitizadores instrumentaron 73 unidades de biblioteca, 31 pruebas
nativas y el ejecutor de Lua. Las dependencias enlazadas recibieron
instrumentación parcial. La detección de fugas estaba desactivada.
El JSON de verificación registra el alcance exacto y la huella del código
ejecutable.

## Repetir las pruebas

Desde el directorio del código fuente, ejecuta:

```sh
make -j4 full-test
make examples
node docs/scripts/check-examples.mjs
make reference-test
```

El comprobador de ejemplos usa Node.js para extraer el código Lua y ejecutarlo
con el módulo compilado. `reference-test` descarga el paquete 0.116, verifica su
SHA-256 y guarda las pruebas en caché. El parche
`compatibility/numpy254-reference.patch` actualiza 40 rechazos históricos de
cuantiles a resultados válidos con NumPy 2.5.4 y conserva las aserciones
numéricas originales.

El paquete opcional de referencias contiene los 102 archivos acumulados en Lua
y sus generadores. Para ejecutar un archivo del paquete extraído con tu
compilación, sustituye la ruta de este comando:

```sh
LUA_PATH='./lua/?.lua;;' LUA_CPATH='./build/?.so;;' \
  lua5.4 /ruta/a/references/matrix192-business-day-count.lua
```

La regeneración requiere la versión NumPy fijada por cada generador. Las
pruebas históricas conservan su versión de referencia original. Cada guía
documenta las tolerancias de sus operaciones.

## Integridad de la entrega

La verificación compara todos los archivos de una extracción limpia con
`PROJECT_SHA256SUMS`, compila y repite las regresiones, los ejemplos y las
pruebas diferenciales. Los archivos publicados incluyen las sumas de los
paquetes y el informe de verificación. Los informes históricos siguen
disponibles en sus respectivas versiones.
[Entrega 0.192](https://github.com/48hoursnonstop/luaray/releases/tag/v0.192.0-dev)
· [Historial de verificación 0.173](https://github.com/48hoursnonstop/luaray/blob/v0.173.0-dev/docs/es/development/validation.md)
· [Base 0.116](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
