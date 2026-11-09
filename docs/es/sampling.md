# Muestreo lineal, logarítmico y geométrico

El motor nativo combina el iterador ndarray, resolución de tipos, ufuncs y
asignación de memoria de LuaRay. NumPy2.5.3 solo genera referencias de desarrollo;
no se necesita Python durante la ejecución.

```lua
local np = require('luaray')
local muestras, paso = np.linspace(-1, 1, 5, {retstep=true})
-- {-1, -.5, 0, .5, 1}; paso=.5
local potencias = np.logspace(0, 2, 3) -- {1,10,100}
local geometrica = np.geomspace(-1, -16, 3) -- {-1,-4,-16}
local filas = np.linspace(np.array({1,2}, 'float32'), 3,
                          {num=3, axis=-1})
-- {{1,2,3},{2,2.5,3}}, float32
```

## Firmas Lua

Las tres funciones aceptan `(start, stop [, num [, opciones]])` o
`(start, stop, opciones)`. Los extremos admiten arrays numéricos, escalares y
tablas compatibles. Opciones: num (50), endpoint (true), axis (1), dtype (inferido),
retstep (solo linspace) y base (solo logspace,10.0). Se rechazan opciones
desconocidas, conteos duplicados, base/retstep en funciones incorrectas y
argumentos adicionales. No se implementan device ni toda la firma posicional
NumPy; usa la tabla Lua para endpoint/dtype/axis/retstep/base.

num debe ser entero Lua no negativo; false/true conservan el camino upstream
0/1. Se rechazan conteos flotantes, incluso2.0. Los ejes positivos empiezan en1
y los negativos cuentan desde el final del resultado. La dimensión de muestras
se añade al principio por defecto; axis=-1 la coloca al final. El rango máximo
es64. Se comparan broadcasting, formas incompatibles y dimensiones vacías.

## linspace

El dtype de cálculo distingue escalares Lua débiles de arrays fuertes y asegura
aritmética flotante/compleja. Extremos solo enteros suelen calcularse en float64;
arrays float16/32 conservan precisión al combinarse con escalares débiles
compatibles. dtype explícito convierte el resultado, sin sustituir el dtype de
cálculo. LuaRay llama `longdouble` al tipo extendido nativo; NumPy lo llama
float128 en el ABI x86 de16 bytes probado. Las referencias adaptan ese nombre
y comprueban anchura/strides equivalentes.

El motor calcula delta, arange, paso, producto y suma con sus tipos efectivos.
endpoint=true usa count-1 como divisor y asigna el extremo final cuando count>1.
Si cualquier paso es cero, conserva el camino subnormal para todo el array:
divide los índices antes de multiplicar por delta. Se retienen redondeo half,
desbordamiento e IEEE, incluidos conteos65504 y65536.

retstep=true devuelve dos valores Lua. El paso escalar es un número/complejo;
el paso con broadcasting conserva ndarray tipado. count=0, o count=1 con
endpoint=true, produce paso NaN escalar. count=1 con endpoint=false usa delta.
El resultado siempre es ndarray con almacenamiento independiente de las
entradas. Una vista que mueve ejes puede conservar un propietario interno.

Con salida entera, linspace aplica floor antes de convertir:
`linspace(-1,1,5,{dtype='int8'})` produce `{-1,-1,0,0,1}`. Ese camino rechaza
cálculo complejo. Bool, strings fijos y tipos numéricos compatibles usan los
casts nativos. No se admiten objetos/estructuras/StringDType variable ni toda
la inferencia de descriptores paramétricos de salida.

## logspace

Interpola exponentes con linspace y calcula `base ** exponentes`. La base Lua
débil conserva las reglas escalares; la base tipada conserva su dtype. Una base
no escalar participa en el rango/broadcasting y recibe la dimensión de muestras
en axis antes del producto de formas.

dtype convierte después de la potencia. Una potencia float32 convertida a
float64 sigue conteniendo redondeo float32. La conversión final entera trunca,
a diferencia del floor de linspace. Potencias reales inválidas pueden generar
NaN/Inf; no se reproduce toda la configuración de advertencias/error NumPy.

## geomspace

Rechaza extremos cero, incluso con cero muestras. Promueve los arrays con dtype
solicitado (float64 si se omite) y un conteo flotante débil. Copia extremos en
KEEPORDER, rota el primero al eje real positivo usando sign, interpola log10
mediante logspace, corrige extremos antes de deshacer la rotación y convierte
el resultado. Conserva caminos reales negativos y complejos probados. Extremos
reales de signos opuestos pueden generar NaN interiores, sin promoción compleja
automática.

Por defecto calcula al menos en float64/complex128. dtype explícito float32/
complex64 puede conservar cálculo más estrecho con arrays fuertes. La rotación
inversa conserva el redondeo upstream: con FMA, una componente original8 puede
quedar7.9999995 y convertirse a entero7. La corrección ocurre antes de deshacer
la rotación, igual que en la implementación de referencia.

## Correcciones compartidas

El asignador nativo de creación centraliza el orden físico NewLikeArray
KEEPORDER, incluidos strides cero y permutaciones3-D. Roll lo reutiliza. Los
casts de muestreo usan ese orden. Los bucles ufunc con entrada contigua exacta
y pareja escalar asignan salidas C/F canónicas, incluidos ejes unitarios.

Los casts complejo→real conservan el tipo de la componente original, evitando
un intermediario longdouble. Una componente complex64 de38935.516 se convierte
a int8=23 en el ABI probado. La multiplicación complex64/128 sin reducción usa
el orden fusionado upstream cuando el host tiene FMA; las reducciones y el
tipo extendido conservan el camino base. Esto no completa SIMD ni todos los
casts/alias dependientes del hardware.

Los casts reales/complejos a strings fijos usan el núcleo numérico Dragon4 de
NumPy con licencia, tipos ABI nativos, memoria temporal por hilo y salida del
llamador. No hay wrappers, excepciones ni cabeceras Python. El texto más corto
conserva precisión, cero con signo, no finitos y umbrales científicos:1e3 half,
1e6 float32 y1e16 double/extendido. Se preservan atribución BSD de NumPy y MIT de
Dragon4. El adaptador incluye representaciones extendidas, quad y longdouble
igual a double; solo se ejecutó Linux x86 extendido en este entorno. Las demás
ramas siguen sin verificar.

## Evidencia ejecutada y límites

Referencias NumPy2.5.3: **2,478 casos linspace /504,645 comprobaciones**, **1,542
logspace /154,195**, **1,392 geomspace /150,473**: **5,412 /809,313**. Se comparan
valores, errores reales, forma, dtype, strides, paso y estados de extremos.
Incluyen escalares/tipos fuertes, complejos, casts, vacíos, rango64, subnormales,
conteos half grandes, vistas invertidas/seccionadas/F/broadcast/3-D y bases array.

Linspace compara exactamente, error observado0. Logspace/geomspace usan la
precisión de cálculo antes del cast: tolerancia absoluta+relativa2e-3 half,
3e-6 float32/complex64 y2e-12 para cálculo más ancho. Enteros, bool, strings y
metadatos comparan exactamente. La fuente confirma potencia SVML en NumPy frente
a powf libm nativo; ampliar el destino no elimina esa diferencia. La tolerancia
inicial basada solo en dtype de salida se corrigió por ese motivo.

Máximo `abs(error)/max(1,abs(referencia))`:1.1393306865162e-7 logspace y
1.9546212523884e-7 geomspace. El máximo absoluto logspace,9.2233720368548e18,
corresponde a potencias grandes; el error normalizado aporta la escala útil.
Geomspace tuvo máximo absoluto9.5367431640625e-7.

La referencia C cubre **70,828 estados de bits**: todos los65,536 half,2,063
float32,2,063 float64,576 complex64,576 complex128 y14 extendidos x86. Pasaron
**141,656 comparaciones ASCII/Unicode exactas**, buffers desalineados y guardas.
Ocho hilos ejecutaron16,384 llamadas adicionales. También pasaron pruebas nativas
y154 comprobaciones Lua. TEST_RESULTS.md y el JSON/log de entrega registran
regresión completa, sanitizadores y extracción limpia. El corpus de bits depende
del ABI y se regenera con el intérprete NumPy fijado en ese mismo ABI.

Todas las APIs disponibles mantienen clasificación parcial. No se certifican
todos los tipos/conteos/bases, endian numérico no nativo, advertencias/subclases/
excepciones ni todo redondeo/cast específico del hardware. Se conservan diferencias
y estados bloqueados anteriores. La disponibilidad del inventario no equivale
a un porcentaje global de finalización.
