# Productos vectoriales y mallas de coordenadas

LuaRay0.116.0-dev añade `np.cross` y `np.meshgrid` nativos. El `np.linalg.cross`
existente comparte el motor corregido: promoción antes de multiplicar y strides
de salida compatibles con los ejes de NumPy.

```lua
local np = require('luaray')
assert(np.cross({1,0,0},{0,1,0}):tolist()[3] == 1)
local x = np.array({0.,1.}, 'float32')
local y = np.array({0.,1.,2.}, 'float64')
local g = np.meshgrid({x,y}, {indexing='xy'})
assert(g[1].shape[1] == 3 and g[1].shape[2] == 2)
```

`np.cross(a,b,{axisa=-1,axisb=-1,axisc=-1,axis=nil})` acepta ndarrays o entradas
Lua del constructor. Ambos ejes vectoriales deben tener tres componentes, como
NumPy2.5.3: esa versión eliminó los vectores de dos componentes. Las otras
dimensiones usan broadcasting. Los ejes positivos empiezan en uno; negativos
cuentan desde el final; cero y ejes no enteros se rechazan. `axis` sobreescribe
los tres ejes individuales. El wrapper linalg existente exige ndarrays y un eje
compartido. La salida se crea con el eje vectorial al final y luego se permuta,
por lo que `axisc` puede producir strides no contiguos. No modifica las entradas.

Los productos complejos generales usan el backend ufunc nativo. Las rutas
baseline/SIMD FMA pueden diferir del wheel NumPy; los presupuestos prefijados
son6e-7 para complex64 y2e-15 para complejos mayores, multiplicados por
`max(1,abs(componente))`. Metadatos, casos exactos, ceros con signo, NaN e
infinitos se comprueban aparte. No se declara igualdad binaria de todo CPU/FP.

La firma Lua es **`np.meshgrid({x1,x2,...}, opciones)`**, que devuelve una tabla
de ndarrays. Usa una lista explícita de entradas; sin entradas devuelve `{}`.
Admite hasta64. Las opciones son `copy=true`, `sparse=false`, `indexing='xy'`;
copy/sparse deben ser booleanos y indexing acepta xy/ij. Se rechazan claves
desconocidas, NUL y listas mal formadas.

Cada entrada se aplana en C y conserva su dtype. `ij` asigna el eje i a la
entrada i; `xy` intercambia los primeros dos ejes. Sparse deja longitud uno en
los demás ejes; dense hace broadcasting a la forma completa. Escalares y ejes
vacíos conservan las reglas de reshape inferido y strides del código fuente.

Copy crea arrays C independientes y escribibles. Con `copy=false` se comparte
memoria si el reshape lo permite; un aplanado incompatible aún puede copiar.
Las vistas broadcast pueden ser escribibles y solapadas: escribir una celda
puede cambiar la entrada y otras celdas. Sin copia intermedia, una entrada de
solo lectura conserva su protección. Las pruebas verifican valores, strides,
tipos, aliasing, escrituras constantes/variables y vida útil tras recolectar Lua.

Siguen pendientes subclases/dispatch Python, warnings/clases de error completas,
objetos y tipos estructurados/subarray/void/StringDType variable, endian numérico
no nativo y todos los ABI. Todas las APIs siguen clasificadas como parciales.
La [referencia inglesa](../en/vectors_and_grids.md) detalla el contrato; los
resultados ejecutados y el inventario están en [resultados de verificación](../development/validation.md) y compatibility/.
