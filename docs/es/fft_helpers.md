# Frecuencias FFT, desplazamiento de espectros y transformadas hermitianas

`lr.fft` utiliza arrays nativos de LuaRay, auxiliares C y PocketFFT C++ incluido.
Python/NumPy solo intervienen como referencia durante el desarrollo.

```lua
local lr = require('luaray')
local frecuencias = lr.fft.fftfreq(4, 0.5) -- {0, .5, -1, -.5}
local centrado = lr.fft.fftshift(frecuencias)
local original = lr.fft.ifftshift(centrado)
local espectro = lr.fft.hfft({1, 2, 3}) -- {8, -2, 0, -2}
local muestras = lr.fft.ihfft(espectro)
```

## Frecuencias

`fftfreq(n, spacing)` multiplica posiciones enteras por `1/(n*spacing)`. Con n
par, Nyquist aparece negativo; con n impar hay la misma cantidad de posiciones
positivas y negativas. `rfftfreq` devuelve `n//2+1` posiciones no negativas,
incluido Nyquist positivo para n par. spacing vale1.0 por defecto. n debe ser
un entero Lua; se usa el ancho nativo de puntero con signo. No se implementa
el argumento device explícito.

El espaciado numérico/complejo Lua conserva el rechazo de división escalar por
cero. Un ndarray tipado ejecuta las ufuncs nativas de multiplicación/división con
n y1.0 débiles, conservando desbordamiento, redondeo, broadcasting y NaN/Inf de
los arrays. Un espaciado float32 tipado puede redondear pasos intermedios de
forma distinta a un número Lua. El producto con las posiciones determina el
dtype final. Las tablas de espaciado se rechazan; usa un ndarray explícito.

Los límites siguen la fuente: fftfreq rechaza n negativo; rfftfreq negativo
puede estar vacío. Un escalar finito rechaza n=0, pero el espaciado tipado puede
generar fftfreq vacío o rfftfreq con un NaN. Espaciado escalar no finito sigue
IEEE. fftfreq rechaza n booleano por su ruta de asignación; rfftfreq conserva
la ruta booleana similar a entero. No se declara fidelidad total de advertencias
ni de todos los tipos escalares.

## Desplazamientos

`fftshift(input, axes)` e `ifftshift(input, axes)` crean arrays con memoria propia.
input acepta ndarray o tabla Lua. Sin axes o con nil se usan todas las dimensiones;
un entero o una tabla de enteros seleccionan dimensiones. Los ejes positivos
empiezan en1; los negativos cuentan desde el final. Una tabla vacía copia sin
desplazar. Los ejes repetidos acumulan desplazamiento. Para longitudes impares,
ambas direcciones difieren en un elemento y su composición recupera los valores.
Se prueban dimensiones y selecciones vacías; el camino upstream rechaza arrays0-D.

El motor roll conserva la asignación KEEPORDER y los strides reales de vistas
transpuestas, invertidas, seccionadas, broadcasts de stride cero y permutaciones
3-D. Strings fijos, tipos temporales, booleanos y complejos conservan sus bytes.
La entrada no cambia y el resultado no comparte su almacenamiento.

## Transformadas hermitianas

`hfft(a, options)` combina una copia conjugada KEEPORDER con irfft y normalización
invertida para producir un espectro real. `ihfft` combina rfft con conjugación
final. Admiten estas formas:

```lua
lr.fft.hfft(a, {n=8, axis=-1, norm='ortho', out=destino})
lr.fft.ihfft(a, 8, -1, 'backward', destino)
lr.fft.fft(a, nil, 1, 'forward') -- nil n conserva los argumentos siguientes
```

Opciones: n, axis, norm y out. El eje predeterminado es el último. hfft usa
`2*(longitud_del_eje-1)` como n predeterminado; ihfft usa la longitud del eje.
Indica n impar explícitamente para conservar esa interpretación. norm admite
backward, forward y ortho; backward es el predeterminado. Los ejes siguen la
convención de desplazamientos. Longitudes, ejes, normas y argumentos adicionales
inválidos producen errores Lua. Las FFT1-D aceptan entradas similares a arrays.

out devuelve el mismo destino y admite las vistas con stride positivo probadas
y alias real entrada/salida de hfft. Un destino de solo lectura se rechaza antes
de escribir. Se comparan errores, forma y conversión contra ejecuciones reales
de NumPy; no se certifican todos los alias, broadcasts multidimensionales de
salida, dtypes ni todos los órdenes posibles de errores.

El dtype de entrada controla la precisión de normalización, incluido float16.
Los bucles con entrada compleja exacta y rfft con entrada real exacta conservan
su precisión aunque el destino sea más ancho. Otras entradas pueden elegir un
bucle más ancho. Un destino explícito float32 en irfft/hfft evita un segundo
redondeo float16. El texto inválido se rechaza antes de la promoción por salida
y de normalizar. ihfft/rfft rechazan entrada compleja. La conjugación booleana
de hfft conserva el intermediario int8 upstream.

## Evidencia y límites

Referencias originales NumPy2.5.3:826 casos de frecuencias /28,419 comprobaciones;
1,800 de desplazamiento /86,698;6,964 de transformadas y salidas /343,993. Estos
últimos también cubren precisión de fft/ifft/rfft/irfft y argumentos nil. Se
comparan valores y estados de entrada/salida, forma, dtype, strides, aceptación
real e identidad del destino. Las pruebas C y111 comprobaciones Lua añaden
regresiones de orden con stride cero, precisión half/float32, destinos de solo
lectura y rechazo seguro de texto.

Los desplazamientos comparan valores exactos. Las frecuencias usan tolerancia
absoluta/relativa2e-12, o3e-6 para float32/complex64; error máximo observado:0.
Las transformadas usan3e-6 absoluta más relativa para float32/complex64 y2e-12
para salidas más anchas. Error absoluto máximo observado:1.9073486328125e-6,
dentro de la tolerancia float32 explícita. Las regresiones de precisión ampliada
también comparan valores exactos. Esto permite redondeo aritmético, sin tolerar
cambios de dtype/disposición. El generador requiere NumPy2.5.3.

Están disponibles los18 nombres FFT del inventario; todos conservan clasificación
parcial. Disponibilidad no significa compatibilidad completa. Objetos, estructuras,
strings variables, endian numérico no nativo, advertencias/subclases/device y
todas las combinaciones de dtype/longitud/alias siguen fuera del contrato
verificado. Consulta `compatibility/current.json` y el inventario. Se mantienen
las diferencias explícitas anteriores.
