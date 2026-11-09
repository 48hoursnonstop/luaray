# Valores condicionales: where y select

LuaRay 0.104.0-dev añade `np.where` y `np.select` nativos. Where utiliza el
iterador general de ndarray; select combina grupos de broadcasting y escritura
con máscara. No ejecutan Python durante el uso normal.

```lua
local np = require('luaray')
local a = np.array({{1,2,3},{4,5,6}}, 'int32')
local resultado = np.where(np.greater(a,3), a, 0)
-- {{0,0,0},{4,5,6}}
local tramos = np.select({np.less(a,3), np.greater(a,4)}, {-1,9}, 0)
-- {{-1,-1,0},{0,9,9}}
```

## where

`np.where(condition, x, y)` aplica broadcasting a los tres operandos y devuelve
un ndarray independiente. X/y determinan el dtype mediante las reglas fuertes/
débiles admitidas. Los números Lua son débiles; los arrays conservan su dtype.
Los escalares débiles se empaquetan con comprobación de rango: un array uint8
junto al entero Lua 300 produce un error; un ndarray int64 con 300 promueve el
resultado a int64.

La condición admite valores de verdad de tipos compatibles: cero/cadenas vacías
son falsos, valores no nulos/cadenas no vacías y NaN son verdaderos. El orden de
memoria sigue KEEPORDER entre todos los operandos, incluidos los no seleccionados.
Puede producir orden Fortran; C resuelve conflictos. No modifica las entradas.
Una llamada con escalares también devuelve un **ndarray de cero dimensiones**;
`np.where(true,1,2):get()` permite leer su valor.

`np.where(condition)` devuelve la tabla de coordenadas con índices desde uno de
[nonzero](condition_selection.md). Esta forma rechaza condiciones escalares.
Proporcionar exactamente dos operandos produce un error.

NumPy distingue rutas por el tamaño del elemento resultante. Con 1/2/4/8/16 bytes,
convierte ambos valores antes de seleccionar; con otros tamaños convierte solo
el elegido. Un byte ASCII inválido no seleccionado de un S1 puede funcionar con
resultado U3 (12 bytes) y fallar con U4 (16 bytes). Se conserva ese comportamiento
real en las referencias.

## select

`np.select(conditions, choices [, default])` exige secuencias no vacías de igual
longitud. Se admiten tablas Lua y ndarrays cuyo primer eje enumera elementos.
Las condiciones deben ser booleanas; se rechazan arrays numéricos. Opciones y
default resuelven el dtype común con las reglas débiles/fuertes compatibles.
Default es el entero Lua cero cuando se omite.

Las condiciones se expanden entre sí; opciones y default forman otro grupo.
Ambas formas se combinan en la salida. El resultado es un nuevo ndarray contiguo
C, incluso en cero dimensiones. Primero se rellena con default y después se
copian opciones en orden inverso: **gana la primera condición verdadera**.
Se prueban 128 condiciones, utilizando lotes para evitar el límite interno de
64 operandos del iterador clásico.

El relleno default utiliza conversión unsafe; las opciones utilizan copyto
same_kind después de expandirse. Un default 300 con opción uint8 puede convertirse
a 44. Una opción Lua entera que se convierte en array int64 puede fallar al
copiar a uint8 mediante same_kind, incluso con condición falsa. Mantener los
grupos separados también conserva la conversión anticipada de fuentes escalares.
Se verifican esos errores originales y los fallos ASCII en valores no elegidos.

Combinar números débiles con cadenas/fechas puede producir errores de promoción.
Para opciones de cadenas, utiliza un default explícito compatible. No se declara
soporte general de promoción object/estructuras.

## Correcciones compartidas y evidencia

La auditoría corrigió la promoción entre uint64 y timedelta: ahora produce el
error original. Los elementos escalares de una secuencia ndarray conservan su
dtype fuerte como vistas 0-D, incluidas opciones ndarray unidimensionales en
choose. Sus 3,481 casos anteriores siguen aprobando.

La auditoría original cubrió pruebas C, **65 comprobaciones Lua**, **1,487 casos de
where / 59,988 comprobaciones** y **1,961 casos de select / 19,688 comprobaciones**
contra NumPy 2.5.3. Total: **3,448 / 79,676**. Incluyen pares de dtypes, valores
débiles, forma/strides, cadenas binarias, escalares ndarray y precedencia.
Ejecuta `make full-test` para las regresiones C/Lua y `make reference-test` para
el corpus congelado externo. Ninguno requiere Python. Consulta
[verificación](../development/validation.md) para los generadores originales y
el alcance de las auditorías de memoria.

El [inventario de API](api_inventory.md) mide disponibilidad por separado. Object,
estructuras, StringDType variable, endianness numérico no nativo, subclases y
compatibilidad completa de API/errores/advertencias siguen incompletos. Los
bloqueos y diferencias deliberadas anteriores permanecen registrados.
