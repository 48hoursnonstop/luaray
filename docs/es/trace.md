---
docs_examples: true
---
# Trazas de matrices

Una traza suma una diagonal seleccionada. En un lote de matrices devuelve una
suma por cada combinación de las coordenadas restantes.

## Firmas

| Llamada | Valores predeterminados y resultado |
| --- | --- |
| `lr.trace(a, offset, axis1, axis2, dtype, out)` | Offset `0`, ejes `1` y `2`. |
| `lr.trace(a, {offset=0, axis1=1, axis2=2, dtype=..., out=...})` | Forma con tabla de opciones. |
| `a:trace(...)` | Las mismas opciones como método ndarray. |
| `lr.linalg.trace(a, {offset=0, dtype=...})` | Reduce los últimos dos ejes; requiere ndarray. |

Los ejes positivos empiezan en uno; los negativos cuentan desde el final.
Deben ser distintos. Los offsets positivos seleccionan diagonales superiores;
los negativos, inferiores. Una diagonal vacía se reduce a la identidad de la suma.

## Suma una diagonal

```lua
local lr = require("luaray")
local a = lr.array({{1, 2, 3}, {4, 5, 6}}, "int16")
assert(lr.trace(a) == 6)
assert(a:trace(1) == 8)
assert(lr.trace(a, -1) == 4)
```

Sin `out`, una reducción completa devuelve un escalar numérico Lua o temporal
LuaRay. Si quedan ejes, devuelve un ndarray independiente y escribible.
Las entradas enteras y booleanas usan el dtype ampliado habitual de la suma.
Para entradas numéricas ordinarias, `dtype` selecciona el acumulador.

## Trabaja con lotes

```lua
local batch = lr.arange(24):reshape({2, 3, 4})
local first_axes = lr.trace(batch)
assert(first_axes.shape[1] == 4 and first_axes[1] == 16)

local matrices = lr.linalg.trace(batch)
assert(matrices.shape[1] == 2)
assert(matrices[1] == 15 and matrices[2] == 51)
```

`lr.trace` usa los primeros dos ejes; `lr.linalg.trace` interpreta los últimos
dos como cada matriz. Especifica `axis1` y `axis2` para otras disposiciones.
Los ejes restantes conservan su orden.

## Reutiliza un destino

```lua
local out = lr.zeros(4, "float32")
assert(lr.trace(batch, {out=out}) == out)
assert(out[1] == 16 and out[4] == 22)

local scalar_out = lr.zeros({}, "uint64")
assert(lr.trace(a, {out=scalar_out}) == scalar_out)
assert(scalar_out:tolist() == 6)
```

`out` debe ser un ndarray escribible con la forma exacta del resultado; `{}`
es la forma de un escalar. Se admiten destinos con strides y destinos solapados
con la entrada. La reducción usa almacenamiento temporal antes de escribir,
protegiendo los datos pendientes de leer. Las conversiones siguen las reglas
unsafe admitidas. Sin `dtype`, el destino puede influir en la resolución del bucle.

Un destino ndarray conserva la precisión nativa. Úsalo con `uint64` o valores
de precisión ampliada fuera del rango escalar Lua: convertirlos a un número Lua
puede perder precisión. Se devuelve el mismo userdata recibido como `out`.

## Tipos temporales y dtype

Las trazas timedelta conservan unidades y propagan `NaT`. En estas entradas,
`dtype` no cambia las unidades: convierte antes con `lr.asarray` si necesitas
otra unidad. Un `out` temporal selecciona las unidades finales. Esto sigue el
comportamiento de la referencia NumPy, incluido su manejo histórico de dtype.
Datetime y cadenas fijas no tienen una firma de reducción válida para la traza.

En entradas numéricas ordinarias, pedir un dtype timedelta no convierte la
entrada en una duración y puede desactivar la ampliación entera predeterminada.
Usa un dtype numérico para seleccionar un acumulador numérico.

## Compatibilidad

Las trazas raíz y ndarray están disponibles desde **0.118.0-dev**.
`linalg.trace` comparte su kernel nativo. Las referencias exactas comprueban
valores, forma, dtype, strides, identidad, solapamiento y estados tras operaciones
aceptadas o rechazadas. Incluyen unidades temporales, `NaT`, desbordamiento entero,
combinaciones de dtype/destino y cancelación flotante.

Los offsets raíz/ndarray usan el rango C `int` de NumPy. El valor negativo extremo
tiene una salida vacía segura probada localmente; no se ejecuta la ruta upstream
que desborda al negar ese entero. Objetos, estructuras, protocolos externos,
advertencias/excepciones Python completas y todos los ABI siguen fuera del
contrato verificado. Las APIs conservan [compatibilidad parcial](api_inventory.md).
