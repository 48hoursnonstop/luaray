---
docs_examples: true
---
# Escalar duraciones

Multiplica arrays `timedelta64` por coeficientes enteros o flotantes. El resultado
conserva la unidad temporal. Los enteros usan aritmética int64 exacta; los flotantes
calculan en double y truncan los ticks finitos.

## Multiplicación por enteros

```lua
local lr = require("luaray")
local hours = lr.array({1, 2, 3}, "timedelta64[h]")
local doubled = lr.multiply(hours, 2)
assert(doubled.dtype == "timedelta64[h]")
assert(lr.astype(doubled, "int64")[3] == 6)
```

Se admiten ambos órdenes de operandos. Los arrays booleanos y enteros con/sin signo
usan la firma de coeficiente int64. Los uint64 se convierten a int64, incluida su
convención de wrapping. Un coeficiente es un entero: sus bits pueden coincidir con
el centinela NaT sin representar una duración ausente. Una **duración** NaT sí se
propaga, incluso al multiplicarse por cero.

## Multiplicación y división flotantes

```lua
local fractional = lr.multiply(hours, 0.5)
assert(lr.astype(fractional, "int64")[1] == 0)
assert(lr.astype(fractional, "int64")[3] == 1)
local divided = lr.true_divide(hours, 2.0)
assert(lr.astype(divided, "int64")[2] == 1)
```

Los coeficientes float16/32/64/longdouble usan el bucle double de referencia. Un
resultado flotante no finito o fuera de rango se convierte en NaT en la plataforma
x86 auditada. La multiplicación entera, en cambio, falla si desborda o si el producto
coincide con el centinela NaT. La aritmética temporal completa sigue siendo parcial.

## División entera y razones entre duraciones

```lua
local ticks = lr.array({7, -7}, "timedelta64[h]")
local quotient = lr.true_divide(ticks, 2)
assert(lr.astype(quotient, "int64")[1] == 3)
assert(lr.astype(quotient, "int64")[2] == -3)
local ratio = lr.true_divide(lr.array({1, 2}, "timedelta64[D]"),
  lr.array({12, 24}, "timedelta64[h]"))
assert(ratio.dtype == "float64" and ratio[1] == 2 and ratio[2] == 2)
```

Desde **0.129.0-dev**, los divisores enteros usan división int64 exacta y truncan
hacia cero sin convertir los ticks a double. Una entrada NaT o un divisor entero
cero produce NaT. Los divisores booleanos y complejos se rechazan. Los enteros sin
signo siguen las reglas de conversión int64 de la referencia.

Al dividir dos duraciones se convierten ambas a una unidad común y se calcula una
razón float64. NaT produce NaN; los denominadores cero dan infinito o NaN IEEE.
Las unidades de calendario/fijas incompatibles producen un error. Se admiten
broadcasting, máscaras y vistas float64 de salida que comparten la entrada. Las
conversiones de unidad conservan sus comprobaciones de rango.

## Máscaras y destinos

```lua
local out = lr.full({3}, 99, "timedelta64[h]")
assert(rawequal(lr.multiply(hours, 3, {
  out=out, where=lr.array({true, false, true}, "bool"),
}), out))
assert(lr.astype(out, "int64")[1] == 3)
assert(lr.astype(out, "int64")[2] == 99)
assert(lr.astype(out, "int64")[3] == 9)
```

Las unidades del destino se convierten después de multiplicar. La conversión
comprueba los límites int64 de la multiplicación intermedia y el ajuste negativo
para redondear hacia abajo. Puede fallar aunque el cociente matemático quepa si
un paso intermedio desbordaría. Los valores false de la máscara no se escriben ni
se comprueban para desbordamientos aritméticos.

## Estado del destino tras un error

Un error entero puede ocurrir después de escrituras válidas. Las operaciones sin
máscara conservan el prefijo completado en orden de recorrido. Una vista invertida
in-place puede recorrer la memoria física hacia delante y cambiar qué posiciones
lógicas se modifican primero. Los bucles legacy con máscara pueden continuar con
grupos true posteriores aunque uno anterior desborde. Una operación que falla
puede haber cambiado `out`.

NumPy 2.5.3 puede volcar sufijos no inicializados de su buffer de salida cuando
falla el bucle entero y el destino también convierte unidades. Las ejecuciones
repetidas produjeron sufijos distintos y, en ocasiones, mensajes de error distintos.
LuaRay conserva las celdas que no ha escrito. En esos casos se comparan el prefijo
definido y los metadatos; no se declara compatibilidad completa del sufijo indefinido.

## Desplazamientos enteros y escrituras parciales

```lua
local dates = lr.array({0, 1}, "datetime64[D]")
local shifted = lr.add(dates, 2)
assert(lr.astype(shifted, "int64")[2] == 3)
```

Desde **0.134.0-dev**, sumar/restar enteros usa ticks de la unidad temporal.
Se admiten booleanos, enteros con signo y sin signo en aritmética. La suma admite
ambos órdenes; entero menos datetime se rechaza, mientras entero menos timedelta
está permitido. uint64 puede participar en aritmética aunque no en la firma de
comparación. NaT se propaga. Si sumar/restar desborda, se conservan los elementos
y bloques de máscara completados antes del error; no se garantiza atomicidad.

Desde **0.135.0-dev**, los casts datetime con años/meses pasan por el calendario
en lugar de usar promedios de duración. Las referencias directas cubren años
negativos, límites bisiestos, multiplicadores y reglas de desbordamiento entero
de la referencia. Los casts de duración conservan sus reglas de unidades promedio.

## Compatibilidad

El escalado flotante existe desde **0.113.0-dev** y la multiplicación entera desde
**0.125.0-dev**. Las pruebas cubren valores nativos, unidades, NaT, broadcasting,
coeficientes tipados/ordinarios, máscaras, identidad del destino, vistas invertidas,
escrituras previas al error y el límite de 8192 elementos del iterador. Siguen sin
certificar los escalares externos, la identidad de excepciones/advertencias Python,
todas las disposiciones de buffers y la conversión flotante fuera de x86.
Consulta la [verificación](development/validation.md).

## Suma, media y acumulación de duraciones

Las reducciones conservan la unidad de entrada. NaT se propaga en los valores
seleccionados; una máscara puede excluirlo. La suma vacía es cero y la media
vacía es NaT. La media divide ticks enteros truncando hacia cero. La adición
comprobada falla al desbordar o alcanzar el tick reservado de NaT sin entradas NaT.

```lua
local lr = require("luaray")
local duration_type = lr.dtype("timedelta64[D]")
local durations = lr.array({1, 2, 3}, duration_type)
assert(lr.astype(lr.array(lr.sum(durations)), "int64"):tolist() == 6)
assert(lr.astype(lr.array(lr.mean(durations)), "int64"):tolist() == 2)
assert(lr.astype(lr.cumsum(durations), "int64")[3] == 6)
local with_nat = lr.array({math.mininteger, 1}, duration_type)
assert(lr.sum(with_nat).isnat)
```

El dtype de una reducción selecciona una **clase general**, sin detalles de ancho,
endian o unidad. Strings con ancho y unidades temporales específicas fallan,
incluso en entradas vacías. El resolver heredado puede conservar el descriptor
de duración original aunque se solicite otra clase general. `cumsum`/`cumprod`
descartan detalles mediante su adaptador de número de tipo; accumulate/reduceat
directos de ufunc conservan la comprobación estricta.

```lua
assert(not pcall(function() lr.sum(durations, {dtype = duration_type}) end))
local cumulative = lr.cumsum(durations, {dtype = lr.dtype("timedelta64[h]")})
assert(cumulative.dtype == "timedelta64[D]")
assert(not pcall(function()
  lr.add_accumulate(durations, {dtype = lr.dtype("timedelta64[h]")})
end))
assert(not pcall(function()
  lr.sum(lr.array({math.maxinteger, 1}, duration_type))
end))
```

No hay bucle para sumar datetimes absolutos ni multiplicar duraciones. Las
reducciones de adición de strings también fallan según el resolver, incluso
vacías. Se comprueban unidades, NaT, desbordamiento, máscaras, initial, dtypes
generales/específicos, acumulaciones y reduceat. No se certifican todos los aliases,
salidas de otra unidad ni estados de salida tras error; la compatibilidad es parcial.
