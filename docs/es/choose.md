# Selección entre arrays: choose

LuaRay 0.102.0-dev implementa `np.choose` y `ndarray:choose` mediante un módulo
C nativo. Opciones y selectores admiten broadcasting; no utiliza Python al ejecutar.

```lua
local np = require('luaray')
local selector = np.array({1,2,1}, 'int64')
local a = np.choose(selector, {{10,11,12},{20,21,22}})
-- {10,21,12}
local b = selector:choose({10,20}) -- {10,20,10}
```

## Argumentos y modos

`np.choose(selector, choices [, mode_or_options])` y
`selector:choose(choices [, mode_or_options])` admiten un modo o una tabla con
`mode` y `out`. El modo predeterminado es raise. Choices es una secuencia de
1–63 arrays/escalares o un ndarray cuyo primer eje enumera las opciones. Todos
los operandos deben expandirse por broadcasting a una forma común.

Las posiciones positivas empiezan en **1**. Cero es inválido al recorrerlo.
En raise, **los selectores negativos son inválidos**, como en NumPy choose.
Wrap aplica módulo al número de opciones; clip limita al primer/último valor.
Los negativos en wrap seleccionan desde el final y en clip seleccionan el
primero. Esto difiere del modo raise de take.

Los selectores se infieren primero como arrays y después se convierten mediante
safe a enteros nativos del ancho de un puntero. Se rechazan arrays flotantes,
complejos, de cadenas y uint64 aunque contengan enteros pequeños. Se admiten
tablas Lua enteras; una tabla vacía conserva su dtype inferido habitual.

Las opciones resuelven un dtype común y se convierten a arrays escribibles,
alineados y contiguos C. Los números Lua participan como tipos débiles. Su
conversión posterior sigue la de NumPy choose: combinar un array uint8 con el
entero Lua 300 mantiene uint8 y convierte 300 en 44. Esto difiere del control
de desbordamiento de valores directos en put. Los ndarrays fuertes conservan
sus descriptores al resolver el dtype. Se prueban errores de promoción entre
números débiles, cadenas y fechas, además de fallos de conversión reales.

Sin out, un resultado no escalar es un ndarray contiguo C independiente. El
resultado escalar usa las representaciones Lua numérica/booleana/cadena/compleja/
temporal existentes. Con out se devuelve el mismo ndarray, incluso si es de
cero dimensiones.

## Salida y memoria compartida

Out debe ser escribible y tener exactamente la forma resultante. Raise, el
solapamiento con opciones y un dtype diferente utilizan un temporal. A diferencia
de take, choose **no** convierte previamente los valores antiguos de out. La
conversión final puede fallar después de escribir elementos o bloques anteriores.
En wrap/clip, una salida directa compatible puede modificar selectores futuros;
se verifican casos originales con coordenadas negativas compartidas.

NumPy 2.5.3 incrementa directamente el puntero de salida en wrap/clip aunque
out no sea contiguo. LuaRay conserva ese comportamiento **si todo el tramo cabe
en el buffer propietario**. Pueden cambiar celdas fuera de la vista lógica.
En raise, la escritura desde el temporal respeta los strides. Utiliza out
contiguo para una salida directa ordinaria.

LuaRay rechaza un tramo directo que excedería la asignación propietaria. Vistas
invertidas cerca del final y vistas escribibles con stride cero pueden activar
esa protección. Dos variantes, probadas en wrap/clip, se conservan fuera del
conteo de compatibilidad. **No se ejecutaron** llamadas inseguras de NumPy que
podrían corromper memoria. Sí se ejecutaron y compararon salidas no contiguas
que caben en el buffer. Una salida C prestada sin metadatos de propiedad tampoco
puede utilizar esa ruta directa sin comprobación.

## Correcciones compartidas de fechas

La auditoría encontró defectos en conversiones de fechas a cadenas cortas. Ahora
se devuelve un error si la representación ISO no cabe. ASCII conserva el
prefijo real del elemento fallido; Unicode utiliza bloques de 128 elementos
y deja intacto el bloque que falla. Se prueban NaT, 12 unidades de fecha,
anchos límite y las posiciones 127/128/129. Se conserva el resultado observado
del snprintf de Linux cuando solo se imprime el año y la capacidad es exacta.
Las conversiones unsafe entre datetime y timedelta conservan los ticks enteros;
solo se escalan unidades dentro de la misma clase temporal.

## Evidencia y límites

La auditoría original cubrió pruebas C, **69 comprobaciones Lua**, incluidas
variantes protegidas fuera de compatibilidad, y **3,481 casos NumPy 2.5.3 /
101,519 comprobaciones** de valores, forma, strides, dtype, identidad de out y
estado posterior a errores. Ejecuta `make full-test` para las regresiones y
`make reference-test` para el corpus externo. Consulta [verificación](../development/validation.md)
para las herramientas de referencia y el alcance de las auditorías anteriores.

Las pruebas nativas de wrap con enteros extremos usan módulo matemático; no se
ejecutaron los bucles de restas repetidas de NumPy para esos valores enormes.
Object, estructuras, StringDType variable, endianness numérico no nativo y
fidelidad completa de API/errores/advertencias siguen incompletos. Los bloqueos
anteriores y el rechazo del cuelgue de take permanecen separados. Estas cifras
no son un porcentaje global.
