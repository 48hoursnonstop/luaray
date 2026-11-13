---
docs_examples: true
---
# Rangos de fechas y duraciones

Desde **0.144.0-dev**, `lr.arange` construye rangos datetime64 y timedelta64
con resolución de unidades y conversión de calendario nativas. El resultado
tiene memoria propia y excluye el valor final.

## Recorrer fechas del calendario

```lua
local lr = require("luaray")
local dates = lr.arange("2020-02-28", "2020-03-02", {dtype="datetime64[D]"})
local labels = lr.datetime_as_string(dates)
assert(dates.size == 3)
assert(labels[1] == "2020-02-28" and labels[2] == "2020-02-29")
assert(labels[3] == "2020-03-01")
```

Un dtype temporal selecciona el motor temporal. Sin dtype explícito, lo
seleccionan los argumentos temporales; las cadenas ISO por sí solas requieren
un dtype temporal. Los rangos de fechas necesitan inicio y final. Un dtype
concreto fija unidad y multiplicador. Un dtype genérico conserva su clase y
detecta las unidades de los argumentos. Los enteros usados como fechas
necesitan una unidad concreta al convertirse.

```lua
local months = lr.arange(
  lr.datetime64("2020-01"), lr.datetime64("2020-06"), lr.timedelta64(2, "M")
)
assert(months.dtype == "datetime64[M]" and months.size == 3)
assert(lr.datetime_as_string(months)[2] == "2020-03")
```

`Y` y `M` representan años y meses del calendario. Las otras unidades van de
semanas a atosegundos. Un dtype explícito convierte cada argumento con las
reglas same-kind del original antes de calcular el conteo. Sin dtype concreto,
se resuelve una unidad común. Una fecha no puede utilizarse como paso. Mezclar
unidades no lineales de duración con unidades lineales puede producir un error.

## Elegir el paso de duración

```lua
local durations = lr.arange(
  lr.timedelta64(0, "h"), lr.timedelta64(3, "h"), lr.timedelta64(30, "m")
)
local ticks = lr.astype(durations, "int64")
assert(durations.dtype == "timedelta64[m]" and durations.size == 6)
assert(ticks[1] == 0 and ticks[2] == 30 and ticks[6] == 150)
```

El paso predeterminado es un tick de la unidad resuelta. Un único argumento
de duración empieza en cero: `lr.arange(lr.timedelta64(3, "h"))` devuelve 0, 1
y 2 horas. Los enteros y las cadenas decimales completas pueden proporcionar
conteos de ticks. El constructor temporal rechaza números flotantes, incluido
`1.0`; utiliza un entero Lua o un paso timedelta.

## Usar un final relativo

```lua
local start = lr.datetime64("2020-01-01")
local relative = lr.arange(start, 3)
assert(relative.dtype == "datetime64[D]" and relative.size == 3)
assert(lr.datetime_as_string(relative)[3] == "2020-01-03")
```

En un rango de fechas, un final entero o timedelta es un desplazamiento sumado
al inicio después de convertir unidades. Una fecha o cadena ISO es un final
absoluto. Los ticks resultantes son int64. Se rechazan pasos cero y ticks NaT
después de normalizar finales relativos. El orden original permite que algunos
desplazamientos NaT pierdan su marcador y produzcan un rango vacío; las
regresiones conservan esa particularidad. Los finales NaT normales son inválidos.

La forma de dos argumentos `lr.arange(integer_stop, positional_dtype)` conserva
su [contrato de conversión heredado](./arange.md#seleccionar-el-dtype-de-salida).
Usa una tabla de opciones para las reglas temporales de un único argumento.

## Salida numérica con argumentos temporales

```lua
local start_ns = lr.timedelta64(0, "ns")
local stop_ns = lr.timedelta64(5, "ns")
local truncated = lr.arange(start_ns, stop_ns, 2, {dtype="int64"})
local ratio = lr.arange(start_ns, stop_ns, lr.timedelta64(2, "ns"), {dtype="int64"})
assert(truncated.size == 2 and truncated[2] == 2)
assert(ratio.size == 3 and ratio[3] == 4)
```

Un dtype numérico explícito selecciona el motor numérico, como en NumPy. Una
duración dividida por un entero se trunca a ticks de duración; dividida por otra
duración produce una razón numérica. La conversión de longitud y salida también
depende de la representación item del original. Las duraciones genéricas,
años/meses y resoluciones finas pueden tener items enteros; las duraciones
normales de días/microsegundos no. Los arrays originales y escalares temporales
conservan sus reglas diferentes de conversión entera. Estas reglas siguen el
código de referencia fijado.

## Memoria de entrada e interfaz nativa

```lua
local bound = lr.array(3, "timedelta64[h]")
bound:setflags(false)
local independent = lr.arange(bound)
assert(independent.flags.owndata and independent.flags.writeable)
assert(not bound.flags.writeable and not lr.shares_memory(bound, independent))
```

Se aceptan escalares temporales y arrays datetime/timedelta de rango cero. Los
buffers temporales de solo lectura o desalineados permanecen intactos. Se
rechazan arrays de rango mayor y arrays numéricos normales entregados al
conversor temporal. Siguen vigentes los límites de dtype, endianness y objetos
externos.

`ln_array_arange_time` recibe inicio/paso opcionales, final obligatorio y dtype
opcional. Los escalares temporales se representan como arrays temporales de
rango cero; cadenas y enteros conservan sus etiquetas. La interfaz numérica
retiene la procedencia escalar mediante `scalar_object` cuando el binding usa
un array de rango cero para representar un escalar. Recompila los consumidores
nativos con las cabeceras de la misma versión de desarrollo.

## Verificación y límites

La compatibilidad con NumPy 2.5.3 es parcial. Se comparan ticks, unidades,
multiplicadores, forma, flags, errores y memoria de entrada intacta. Las
referencias de promoción y aritmética se separan porque sus reglas de conversión
difieren. Las salidas longdouble numéricas comparan bytes significativos y
omiten padding del ABI. No se certifican políticas de advertencias flotantes,
protocolos Python datetime/externos ni todas las combinaciones de valores y ABI.

Las sumas de finales relativos y numeradores de longitud se comprueban antes
de reservar. Se rechazan explícitamente estados que desbordan la aritmética
int64 original; el oráculo excluye esos estados inseguros y reservas excesivas.
También se rechazan multiplicadores de unidad cero antes de convertir. Las
exclusiones se registran aparte y no cuentan como compatibilidad aprobada.
