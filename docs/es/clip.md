# Recorte de valores

LuaRay 0.114.0-dev incorpora `np.clip(a, inferior, superior, opciones)` y
`a:clip(inferior, superior, opciones)` con un kernel nativo de tres entradas.
`nil` deja abierto un límite. Las opciones admiten `out` y `where`; también puede
pasarse directamente el ndarray de salida y después la máscara opcional. Las
opciones desconocidas o con NUL se rechazan. Los resultados escalares conservan
la convención de ndarray tipado de rango cero.

```lua
local np = require('luaray')
local a = np.array({-2, 0, 4}, 'float32')
assert(a:clip(0, 3):tolist()[3] == 3)
local out = np.full({3}, 7, 'float32')
np.clip(a, nil, 2, {out=out, where=np.array({true,false,true})})
assert(out:tolist()[2] == 7)
```

Las tres entradas usan broadcasting. La salida debe tener la forma resultante,
ser escribible y aceptar conversión `same_kind`; la máscara ndarray debe ser
booleana. Se preservan posiciones enmascaradas y se protegen las copias solapadas.
Hay pruebas con vistas invertidas, transpuestas, Fortran y compartidas.

Los límites enteros Lua que ya abarcan el rango del dtype entero se descartan
antes de promover tipos; los límites que son arrays tipados no se descartan.
Se resuelven todos los tipos antes de convertir valores débiles: otro límite
flotante puede evitar un overflow entero. Los enteros restantes fuera de rango
se rechazan incluso sobre entradas vacías.

Los kernels incluyen booleanos, enteros, float16/32/64/long double, complejos y
fechas/duraciones. Los metadatos temporales compatibles se combinan, NaT se
propaga y las mezclas inválidas se rechazan. Los resolutores compartidos
minimum/maximum/fmin/fmax también admiten combinaciones compatibles de arrays
enteros y duraciones. La multiplicación temporal entera sigue pendiente.
Un límite abierto usa minimum/maximum; ambos abiertos usan positive, por lo que
booleanos y datetime pueden rechazarse.

El cálculo conserva las diferencias de NumPy entre límites escalares y arrays,
incluidos ceros con signo, NaN y comparaciones complejas. El plan de buffering
uniforme deriva del criterio de coste de NumPy2.5.3, con límite predeterminado
8192; las pruebas cubren cambios alrededor de 4096/8192, conversiones y máscaras.
Este plan se utiliza actualmente para clip; no certifica todos los iteradores.

La interfaz usa límites posicionales; no incorpora los alias de argumentos Python
ni opciones dtype/casting/order/signature/subok. Objetos, tipos estructurados,
StringDType variable y endian numérico no nativo siguen pendientes. No se declara
fidelidad completa de warnings, clases de error, payloads NaN, configuración de
búfer Python ni plataformas. La disponibilidad del nombre sigue clasificada
como parcial. La [referencia inglesa](../en/clip.md) detalla estas reglas.
