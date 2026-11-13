---
docs_examples: true
---
# Sumar cadenas de ancho cero

La suma de cadenas fijas concatena sus operandos. Para `S0` y `U0`, la
concatenación conserva el ancho cero, así que estos descriptores también admiten
`lr.sum`. Las cadenas de ancho distinto de cero siguen rechazando la suma: la
concatenación cambiaría el dtype de la reducción. Esta operación sirve sobre
todo para buffers tipados; los constructores ordinarios normalizan el ancho a uno.

```lua
local lr = require("luaray")
local raw = lr.ndarray({2, 3}, lr.dtype("S0"))
local result = lr.sum(raw, {axis = 1, keepdims = true})
assert(lr.dtype(result.dtype).str == "|S1")
assert(result.shape[1] == 1 and result.shape[2] == 3)
assert(result:get(1, 3) == "")
assert(result.strides[1] == 0 and result.strides[2] == 0)
assert(not result.flags.c_contiguous and result.flags.owndata)
```

La salida nueva normaliza el ancho a uno, pero conserva los strides cero del
iterador de reducción. Sus caracteres inicializados representan cadenas vacías.
Un `out` tipado de ancho cero conserva su descriptor. Un resultado escalar sigue
la convención de cadenas Lua; no conserva una clase bytes/string escalar NumPy.

```lua
local out = lr.ndarray({3}, lr.dtype("S0"))
assert(rawequal(lr.sum(raw, {axis = 1, out = out}), out))
assert(lr.dtype(out.dtype).str == "|S0")
assert(lr.sum(lr.ndarray({1}, lr.dtype("U0"))) == "")
```

La suma de cadenas no tiene identidad de reducción registrada. Un eje reducido
vacío necesita `initial`; las semillas numéricas/booleanas se convierten a ancho
cero. Una máscara ndarray en `where` también necesita `initial`, aunque todos sus
valores sean verdaderos. Se comprueban su forma y dtype normalmente.

```lua
local empty = lr.ndarray({3, 0}, lr.dtype("U0"))
assert(not pcall(lr.sum, empty, {axis = 2}))
local seeded = lr.sum(empty, {axis = 2, initial = 0})
assert(seeded.shape[1] == 3 and seeded[2] == "")
assert(not pcall(lr.sum, raw, {axis = 1, where = lr.array(true)}))
local masked = lr.sum(raw, {axis = 1, where = lr.array(false), initial = 0})
assert(masked[1] == "" and masked[3] == "")
```

El método no permite reordenar la reducción: cada llamada puede reducir como
máximo un eje. Se admite una tabla vacía de ejes. Además, el eje escalar acepta
`1`/`-1` en arrays de dimensión cero, pero una tabla de ejes no vacía es inválida,
como en la distinción upstream entre un eje escalar y una tupla de ejes.

```lua
assert(not pcall(lr.sum, raw)) -- Todos los ejes seleccionarían dos dimensiones.
assert(not pcall(lr.sum, raw, {axis = {1, 2}}))
local unselected = lr.sum(raw, {axis = {}})
assert(unselected.shape[1] == 2 and unselected.shape[2] == 3)
local scalar = lr.array(5)
assert(lr.sum(scalar, 1) == 5)
assert(not pcall(lr.sum, scalar, {axis = {1}}))
```

La referencia aprobó **64 000 casos /734 542 comprobaciones** y 247 comprobaciones Lua permanentes, además de una prueba nativa y una prueba C++ de cabeceras/enlace. Se normalizaron 2 892 retornos escalares de cadenas al contrato Lua. Los 180 grupos de dtype/salida se ejecutaron en procesos NumPy nuevos para aislar variaciones de despacho dependientes del historial; esas variaciones no se emulan. El corpus se regeneró exactamente. Las salidas numéricas disjuntas conservan seeds ya escritos si falla la conversión de una entrada de cadenas no escalar; una entrada escalar falla antes de inicializar la salida. El writeback de fallos con solapamiento general de entrada o máscara sigue sin certificar.

La API de cadenas y reducciones sigue parcial. No hay semillas generales de
cadena, StringDType de ancho variable, arrays object, clases escalares Python
ni despacho externo. Unicode usa el descriptor nativo; otras ABI no están
certificadas.
