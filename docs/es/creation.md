# Creación, conversión y copia de arrays

LuaRay crea almacenamiento y vistas ndarray reales mediante un núcleo nativo y
bindings Lua compilados por separado. La frontera interna documenta propiedad y
vida de los objetos. Python solo proporciona referencias de desarrollo; los
casts y copyto existentes realizan conversión y llenado.

```lua
local np = require('luaray')
local a = np.array({{1,2,3},{4,5,6}}, 'int32')
assert(np.asarray(a) == a)
local independiente = a:copy()
independiente:set(99, 1, 1) -- primero valor; a no cambia
local vista = np.array(a, {copy=false, ndmin=3})
local lleno = np.full_like(a, 7, {dtype='float32', shape={3,2}, order='F'})
local finito = np.asarray_chkfinite({1,2,3})
```

## Firmas Lua

Las conversiones aceptan entrada, un dtype opcional o tabla de opciones y otra
tabla opcional después del dtype posicional. Por ejemplo:
`np.asarray(a, 'float32', {order='C'})` o
`np.asarray(a, {dtype='float32', order='C'})`.

| Función | Opciones | Valores predeterminados |
| --- | --- | --- |
| array | dtype, order, copy, ndmin, subok | K, copy=true, ndmin=0 |
| asarray / asanyarray | dtype, order, copy | K, copiar si hace falta |
| ascontiguousarray / asfortranarray | dtype, orden fijo | C / F, rango mínimo1 |
| asarray_chkfinite | dtype, order | K |
| copy / ndarray:copy | order; copy global también subok | global K / método C |
| empty_like / zeros_like / ones_like | dtype, order, shape, subok | dtype/forma del prototipo, K |
| full_like | las mismas; valor tras prototipo | dtype/forma del prototipo, K |
| empty / zeros / ones | dtype, order | float64, C |
| full | dtype, order; valor tras forma | dtype del valor, C |

También se aceptan `np.copy(a, 'F')` y `a:copy('F')`. La forma puede ser entero
Lua o tabla de dimensiones; `{}` significa escalar. Los constructores like
admiten shape en opciones. empty/zeros/ones/full solo aceptan C/F. Se rechazan
opciones desconocidas, duplicadas o inválidas. No se implementan device/like,
formas dadas como ndarray ni toda la firma posicional NumPy.

## Copias e identidad

copy admite true, false o `'if_needed'`. Este último representa copy=None:
en Lua nil elimina el campo y selecciona el valor predeterminado. array copia
siempre por defecto; asarray/asanyarray solo cuando es necesario.

Un array compatible devuelve el mismo userdata con política de no copiar o
copiar si hace falta. Cambiar dtype o exigir contigüidad C/F requiere asignación;
copy=false falla entonces. Escalares/tablas Lua y escalares temporales nativos
requieren crear almacenamiento array y rechazan copy=false. Una copia de entrada
de solo lectura es independiente y escribible; una vista reutilizada sigue
siendo de solo lectura.

ndmin solo aplica a array. Las dimensiones iniciales de longitud1 son una vista
de los datos elegidos. Se ignora ndmin negativo, como en la referencia ejecutada;
el rango máximo es64. Constructor profundo y tolist reservan explícitamente
espacio Lua y se prueban en un proceso nuevo.

copy global usa KEEPORDER; el método usa C. K conserva el orden físico de ejes
con strides positivos densos: transpuestas, invertidas, secciones, broadcasts
con stride cero y permutaciones3-D. Al asignar, A elige F para entrada solo F y C
en los demás casos. Con order=A, una conversión sin copia puede conservar strides
no contiguos; ese camino no obliga contigüidad. C/F sí la exigen.
ascontiguousarray/asfortranarray promueven escalares a rango1.

## Llenado y constructores like

Los constructores like crean almacenamiento independiente. K conserva la
permutación del prototipo si no cambia el rango; si cambia, usa C. Se prueban
formas vacías y unitarias. Los strings sin anchura explícita usan mínimo un
carácter. El constructor escalar/tablas también finaliza strings vacíos con
anchura1; la conversión de arrays puede inferir una anchura mayor según origen.

zeros/zeros_like ponen a cero la memoria real, incluidos strings vacíos,
complejos y ticks temporales. ones/ones_like y full/full_like usan copyto unsafe.
Los valores se difunden a la forma pedida. full sin dtype materializa primero
el valor para inferir tipo; los like usan el tipo del prototipo salvo override.

Un escalar débil300 no cabe en uint8 y `np.full(2,300,'uint8')` falla. Un valor
fuerte sí usa conversión array:

```lua
local resultado = np.full(2, np.array(300, 'int64'), 'uint8') -- {44,44}
```

La distinción también aplica a full_like. empty/empty_like asignan memoria sin
inicializar. Las referencias inspeccionan metadatos y escriben datos válidos
antes de comparar valores; no usan basura inicial como resultado esperado.
Las entradas de constructores independientes no cambian.

## Finitud y tipos temporales

asarray_chkfinite convierte primero y rechaza NaN/Inf en tipos flotantes o
complejos. Enteros, bool, strings y temporales conservan el camino upstream sin
esa comprobación. Se prueban vacíos y entradas de solo lectura sin mutación.

Los escalares datetime/timedelta nativos conservan su descriptor fuerte. Un
dtype temporal genérico solicitado hereda unidades del origen temporal, incluso
entre ambas clases. El string sin anchura de un escalar datetime usa su longitud
ISO real; timedelta conserva la anchura heredada21. Se prueban NaT escalar,
multiplicadores y conversión numérica/textual.

Los casts de arrays numéricos a datetime genérico conservan ticks enteros.
Construirlo desde un entero escalar requiere unidad explícita, incluso con el
patrón de bits del entero mínimo. Un datetime NaT tipado sí es válido. Empaquetar
escalares y convertir arrays son caminos distintos. No se reproducen todas las
advertencias temporales ni todo el protocolo de tipos escalares Python.

Se conserva la restricción histórica de np.astype/ndarray:astype LuaRay para
números→datetime genérico como incompatibilidad parcial documentada. La creación
usa su camino independiente de casts array. Las regresiones históricas se
mantuvieron. Esto no declara equivalencia con la función raíz astype Array API
NumPy2.5.3, limitada a tipos numéricos, ni paridad total del método ndarray.

## Evidencia y alcance

Referencias originales NumPy2.5.3: conversión4,726 casos /454,982 comprobaciones;
copia740 /77,978; like5,624 /485,242; creación densa1,461 /23,546. Total
**12,551 /1,041,748**. Se comparan valores, dtype, forma, strides, errores reales,
identidad, memoria compartida y escrituras efectivas, incluida propagación hacia
vistas compartidas y rechazo de escritura de solo lectura. También se ejecutan
pruebas C,164 comprobaciones Lua y rango64 en proceso nuevo. El generador
reproduce exactamente los cuatro archivos con el intérprete fijado.

TEST_RESULTS.md y el JSON/log de entrega separan regresión, sanitizadores y
reconstrucción limpia. El inventario mide nombres disponibles; todos siguen
parcialmente compatibles. Objetos/estructuras/strings variables, endian numérico
no nativo, protocolos externos, subclases generales, todas las advertencias/
excepciones y coerción completa siguen sin certificar. No se implementan por
completo secuencias anidadas con ndarrays o escalares temporales. Se valida
subok, pero solo existe la clase array nativa. Se mantienen los estados bloqueados
y diferencias explícitas anteriores.
