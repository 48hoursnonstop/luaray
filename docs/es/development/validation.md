# Verificación y tolerancias

## Versión publicada

[LuaRay 0.116.0-dev](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
aprobó la extracción y compilación limpias, **161 archivos diferenciales** y
**19 ejemplos públicos**. Su commit exacto aprobó [CI](https://github.com/48hoursnonstop/luaray/actions/runs/42567717315).

La versión añadió 8,141 casos cross/meshgrid y 787,265 comprobaciones. Las
comparaciones complejas generales usan tolerancias 6e-7 para complex64 y 2e-15
para tipos complejos más anchos, escaladas por `max(1, abs(component))`.
Metadatos, referencias exactas ordinarias y estados de mallas conservan aserciones
exactas. Consulta [vectores y mallas](../vectors_and_grids.md).

Gradientes y división de duraciones aprobaron **31 024 casos /1 250 944 comprobaciones**:25 750 casos de gradient y5 274 de división. Las tolerancias absolutas más relativas son5e-3 para half,5e-6 para float32/complex64 y2e-12 para tipos más amplios; el error numérico observado fue cero. Se comprueban metadatos exactos, entradas intactas, salidas independientes/escribibles, unidades comunes, NaT, máscaras y vistas de salida compartidas. Las42 comprobaciones Lua permanentes incluyen la API y errores de argumentos.

La integración trapezoidal aprobó **7 341 casos /260 004 comprobaciones** y31 comprobaciones Lua permanentes. Incluye coordenadas regulares/irregulares/decrecientes, ejes y broadcasting, vistas, vacíos, desbordamiento entero, NaT y unidades temporales. Las tolerancias absolutas más relativas son5e-3 para half,5e-6 para float32/complex64 y2e-12 para tipos más amplios. Máximos observados: absoluto8.8817841970013e-16 y relativo2.6737044432591e-16. Metadatos y estados de entrada/memoria son exactos.

El desenvolvimiento de fases aprobó **5 462 casos /291 583 comprobaciones**, con28 comprobaciones Lua permanentes. Incluye periodos pares/impares/cero/negativos, promoción débil/tipada, umbrales y broadcasting, vistas, NaN y extremos int64. Se verifican salidas independientes y escribibles. Tolerancias absolutas más relativas:5e-3 para half,5e-6 para float32 y2e-12 para tipos más amplios; error observado cero.

Los ángulos de fase aprobaron **3 212 casos /307 602 comprobaciones**, con22 comprobaciones Lua permanentes. Incluyen ceros complejos con signo, grados/radianes, promoción real/compleja, vistas y no finitos. Tolerancias relativas:2e-3 para half,3e-6 para float32 y2e-12 para tipos más amplios. Máximos observados: absoluto1.52587890625e-05 y relativo1.4020190897517e-07. Ceros con signo, metadatos y estados de entrada/memoria se comparan exactamente.

La interpolación lineal aprobó **1 531 casos /137 255 comprobaciones**, con37 comprobaciones Lua permanentes. Incluye salidas reales/complejas, consultas escalares/vacías, conversiones, límites, mallas periódicas, vistas, no finitos y búsqueda con estimación previa. De ellos,68 casos con empates periódicos usan el kernel NumPy tras su quicksort genérico portable;12 difieren de la ruta CPU predeterminada y no se declaran equivalentes. Tolerancia absoluta más relativa2e-12; error observado cero contra la referencia declarada. Metadatos y estados de entrada/memoria exactos.

Igualdad, tolerancias y núcleo temporal aprobaron **27 384 casos /1 186 383 comprobaciones exactas**:8 482 de igualdad,4 478 de tolerancias y14 424 temporales. Las48 comprobaciones Lua permanentes y la nueva prueba C verifican formas, broadcasting, promoción débil/tipada, NaN/NaT, identidad, escritura independiente, umbrales de precisión extendida, offsets enteros, máscaras y escrituras completadas antes de desbordar. Los valores extendidos se serializan sin pasar por float64; se normaliza el padding x87. No se certifican objetos de avisos/estado de error ni todas las ABI flotantes.

Elementos, relleno y casts de calendario aprobaron **26 844 casos /684 401 comprobaciones exactas**: 11 813 de item, 10 801 de fill y 4 230 de casts y resolución de metadatos. Las 56 comprobaciones Lua permanentes y la nueva prueba C incluyen índices C lógicos, coordenadas, valores separados sin pérdida, GC, memoria no alineada, alias escalares, booleanos, vacíos, NaT, conversiones escalares temporales y límites de calendario. Los factores de unidades se validan antes de iterar, incluso con cero elementos; se conservan los atajos distintos de máscaras falsas para escalares y arrays. Las 161 referencias históricas vuelven a pasar sin modificar sus aserciones.

La auditoría dirigida ASan/UBSan aprobó con **38 unidades C y una C++**, 20 suites
nativas y 78 suites Lua. Las otras dependencias no estaban completamente
instrumentadas y la detección de fugas estaba desactivada. No certifica todos
los algoritmos, rutinas externas BLAS/LAPACK, ABI ni entornos de punto flotante.

## Repetir las comprobaciones

```sh
make -j4 full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make examples
make reference-test
```

`full-test` ejecuta las regresiones mantenidas C/Lua. `reference-test` obtiene el
paquete inmutable 0.116, comprueba su SHA-256 y ejecuta 161 archivos diferenciales
y referencias adicionales de aleatoriedad y formato contra el motor actual.
Los datos se guardan fuera del árbol versionado. Ningún comando requiere Python.

Los generadores originales y herramientas de sanitización siguen en el
[paquete publicado](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
Usa ese entorno separado para regenerar fixtures o repetir `sanitize-vector116`.
Los generadores recientes usan NumPy 2.5.3; los anteriores conservan su atribución
NumPy 2.3.5.

El registro `compatibility/current.json` contiene evidencia de comportamiento.
`compatibility/api_inventory.json` registra disponibilidad: 423 de 675 nombres
incluidos son invocables y todos siguen clasificados como parciales. No mide
el porcentaje global de compatibilidad NumPy.

## Comprobaciones del árbol actual

LuaRay **0.156.0-dev** aprobó **71 suites nativas**, **128 suites Lua**, siete ejemplos
y 378 bloques ejecutables de documentación. Las referencias de diagonales
conservan **47,886 casos / 4,571,474 comprobaciones**. Las trazas aprobaron
**20,861 casos / 853,519 comprobaciones exactas** contra NumPy 2.5.3, incluidos
metadatos, dtype/destino, solapamiento, unidades temporales y estados del original.

Las matrices triangulares aprobaron **18,142 casos / 1,754,183 comprobaciones
exactas**, incluidos orden de memoria, dtypes, ejes vacíos e índices extremos.

Vandermonde aprobó **11,584 casos / 441,741 comprobaciones**. Los metadatos y casos
ordinarios se comparan exactamente; los aleatorios flotantes/complejos usan una
tolerancia relativa fija3e-15. Los errores absolutos y relativos observados fueron cero.

Identidad/eye aprobó **13,335 casos / 261,220 comprobaciones exactas**, incluidos
orden C/F, dtypes, offsets, ejes vacíos y requisitos de unidades temporales.

Los índices diagonales y las conversiones de escalares a strings aprobaron **1,766 casos / 81,899 comprobaciones exactas**, incluidas coordenadas en base uno, identidad de vectores repetidos, escrituras avanzadas reales y formato de asignaciones y constructores.

Los helpers de índices triangulares aprobaron **9,908 casos / 487,084 comprobaciones exactas**, incluidos vectores contiguos independientes, dimensiones rectangulares/vacías, offsets extremos y lecturas/escrituras sobre vistas.

El relleno diagonal aprobó **29,960 casos / 1,292,460 comprobaciones exactas**, incluidos recorrido plano lógico, repetición/wrap, conversiones de escalares y arrays tipados, destinos de solo lectura y valores compartidos durante la escritura.

Kronecker y duraciones enteras aprobaron **13,776 casos / 1,018,781 comprobaciones**. Los productos complejos64 aleatorios usan tolerancia relativa3e-7; los tipos más anchos,3e-15. El error observado fue cero. Las duraciones cubren NaT, coeficientes, máscaras, conversión de unidades, escrituras previas al error y límites de buffer. En **176 fallos de conversión con buffer**, NumPy produjo sufijos no inicializados variables: solo se comparan el prefijo definido y los metadatos completos. Las observaciones se publican como archivo separado.

Tensordot ejecutó **22,615 casos / 2,304,132 comprobaciones**: **22,461 casos aptos para comparación** y **154 resultados object bloqueados explícitamente**. Las contracciones aleatorias usan tolerancia absoluta+relativa3e-6 para float32/complex64 y2e-12 para tipos más anchos. Los máximos observados fueron absoluto1.9073486328125e-6 y relativo1.3520483676605e-5. Se aceptan ambos signos de cero en resultados BLAS, con44 diferencias observadas; los ceros de entradas y resultados no BLAS siguen siendo exactos. Se verificaron el límite de rango nativo y las unidades/wrapping de productos de duraciones.

Las máscaras con callbacks aprobaron **2,551 casos / 152,065 comprobaciones exactas**, incluidas entradas reales, parámetros, máscaras numéricas/textuales/temporales, vistas, coordenadas en base uno, escrituras reales y adaptación de secuencias Lua. El inventario inspecciona ahora la entrada pública Lua, incluidas funciones compuestas en Lua.

Las diferencias finitas y las disposiciones de unión aprobaron **56,404 casos / 2,620,156 comprobaciones exactas**:34,210 de diff/ediff1d y22,194 de concatenate/stack. Se cubren padding, identidad, escritura y almacenamiento reales, tipos especiales, NaT/no finitos, vacíos y disposiciones C/F/vistas. El orden Lua máximo se ejecutó localmente; no se ejecutó el enorme bucle equivalente NumPy.

Gradientes y división de duraciones aprobaron **31 024 casos /1 250 944 comprobaciones**:25 750 casos de gradient y5 274 de división. Las tolerancias absolutas más relativas son5e-3 para half,5e-6 para float32/complex64 y2e-12 para tipos más amplios; el error numérico observado fue cero. Se comprueban metadatos exactos, entradas intactas, salidas independientes/escribibles, unidades comunes, NaT, máscaras y vistas de salida compartidas. Las42 comprobaciones Lua permanentes incluyen la API y errores de argumentos.

La integración trapezoidal aprobó **7 341 casos /260 004 comprobaciones** y31 comprobaciones Lua permanentes. Incluye coordenadas regulares/irregulares/decrecientes, ejes y broadcasting, vistas, vacíos, desbordamiento entero, NaT y unidades temporales. Las tolerancias absolutas más relativas son5e-3 para half,5e-6 para float32/complex64 y2e-12 para tipos más amplios. Máximos observados: absoluto8.8817841970013e-16 y relativo2.6737044432591e-16. Metadatos y estados de entrada/memoria son exactos.

El desenvolvimiento de fases aprobó **5 462 casos /291 583 comprobaciones**, con28 comprobaciones Lua permanentes. Incluye periodos pares/impares/cero/negativos, promoción débil/tipada, umbrales y broadcasting, vistas, NaN y extremos int64. Se verifican salidas independientes y escribibles. Tolerancias absolutas más relativas:5e-3 para half,5e-6 para float32 y2e-12 para tipos más amplios; error observado cero.

Los ángulos de fase aprobaron **3 212 casos /307 602 comprobaciones**, con22 comprobaciones Lua permanentes. Incluyen ceros complejos con signo, grados/radianes, promoción real/compleja, vistas y no finitos. Tolerancias relativas:2e-3 para half,3e-6 para float32 y2e-12 para tipos más amplios. Máximos observados: absoluto1.52587890625e-05 y relativo1.4020190897517e-07. Ceros con signo, metadatos y estados de entrada/memoria se comparan exactamente.

La interpolación lineal aprobó **1 531 casos /137 255 comprobaciones**, con37 comprobaciones Lua permanentes. Incluye salidas reales/complejas, consultas escalares/vacías, conversiones, límites, mallas periódicas, vistas, no finitos y búsqueda con estimación previa. De ellos,68 casos con empates periódicos usan el kernel NumPy tras su quicksort genérico portable;12 difieren de la ruta CPU predeterminada y no se declaran equivalentes. Tolerancia absoluta más relativa2e-12; error observado cero contra la referencia declarada. Metadatos y estados de entrada/memoria exactos.

Igualdad, tolerancias y núcleo temporal aprobaron **27 384 casos /1 186 383 comprobaciones exactas**:8 482 de igualdad,4 478 de tolerancias y14 424 temporales. Las48 comprobaciones Lua permanentes y la nueva prueba C verifican formas, broadcasting, promoción débil/tipada, NaN/NaT, identidad, escritura independiente, umbrales de precisión extendida, offsets enteros, máscaras y escrituras completadas antes de desbordar. Los valores extendidos se serializan sin pasar por float64; se normaliza el padding x87. No se certifican objetos de avisos/estado de error ni todas las ABI flotantes.

Elementos, relleno y casts de calendario aprobaron **25 314 casos /645 992 comprobaciones exactas**: 11 813 de item, 10 801 de fill y 2 700 de casts. Las 51 comprobaciones Lua permanentes y la nueva prueba C incluyen índices C lógicos, coordenadas, valores separados sin pérdida, GC, memoria no alineada, alias escalares, booleanos, vacíos, NaT, conversiones escalares temporales y límites de calendario. La representación Lua de item conserva valores/unidades y usa ndarrays de rango cero cuando el número nativo no cabe en un escalar Lua.

Los buffers aprobaron **17 290 casos /229 717 comprobaciones exactas** de bytes, dtype, forma, strides, rangos, errores, memoria compartida y escrituras. Las 48 comprobaciones Lua permanentes y la nueva prueba C incluyen GC, recolección de la corrutina creadora, liberación final, fuentes inmutables, alineación y propietarios externos solapados. La instrumentación ampliada detectó y permitió corregir un buffer temporal anterior insuficiente para asignar complex256.

Los flags aprobaron **12 510 casos /1 684 290 comprobaciones exactas** de disposición, propiedad, aliases, bits, permisos de raíz/vistas, alineación, instantáneas y restauración tras errores. Las 46 comprobaciones Lua permanentes y la nueva prueba C incluyen vida útil del array retenido y permisos de raíces cuyo encabezado ya no está expuesto. `uic`/WRITEBACKIFCOPY permanece sin implementar.

Los requisitos y la creación aprobaron **18 430 casos /1 116 960 comprobaciones exactas**, con 36 comprobaciones Lua permanentes y regresiones C ampliadas. Se verifican identidad, flags, disposición, conversiones, memoria compartida y estados después de escribir, incluidos buffers inmutables y físicamente no alineados. Los cambios de dtype ANYORDER conservan su orden de ejes; las copias ANYORDER del mismo dtype mantienen su contrato separado.

Las consultas de metadatos aprobaron **892 casos /50 182 comprobaciones exactas**, con 35 comprobaciones Lua permanentes. Se verifican formas, rangos, totales enteros, aceptación de ejes y estados intactos, incluidos rango 64 y vistas de broadcasting enormes sin recorrer datos. Las restricciones de creación/protocolos de entradas Lua siguen siendo explícitas.

Los descriptores dtype y sus dependencias aprobaron **12 398 casos /294 470 comprobaciones**: 1 208 de propiedades/relaciones, 2 790 de argumentos, 7 680 de selección/reducción temporal y 720 de uniones sin ancho. Las 64 comprobaciones Lua permanentes y la nueva prueba C cubren Unicode inicializado, aliases, casts, NaT y desbordamiento. También pasó una prueba C++ de cabecera/enlace. Duraciones y metadatos son exactos; valores numéricos de muestreo usan tolerancia relativa 2e-3 para half, 3e-6 para float32/complex64 y 2e-12 para tipos más amplios. Las reducciones usan 3e-6 para float32/complex64 y 2e-12 para tipos amplios; cero se comprueba exactamente. Todos los casos históricos siguen aprobando sin cambiar sus aserciones.

El constructor ndarray aprobó **24 204 casos /240 870 comprobaciones exactas** de aceptación, bytes, dtype, forma, strides, flags, memoria compartida y escrituras. Se omitieron 2 420 estados de parámetros inseguros o no verificados del original; no cuentan como aprobaciones. Las alineaciones de cuerpos de cadenas mayores a ocho bytes dependen del host y se omiten; la de arrays y reservas propias se comprueba exactamente. Las 62 comprobaciones Lua permanentes y la prueba C cubren GC, corrutinas, permisos y rechazos seguros. La regeneración del corpus fue exacta y pasó una prueba C++ de cabecera/enlace.

Los rangos arange numéricos aprobaron **12 901 casos /129 151 comprobaciones exactas**, más 125 comprobaciones Lua permanentes y una prueba C. Se comparan bytes significativos, conversión inicial, incrementos efectivos, wrap, longitudes complejas, errores y metadatos. Se excluyeron 138 entradas excesivas o fuera del dominio entero Lua. En el ABI x86 probado se comprueban los diez bytes significativos de cada componente longdouble y se omiten seis de padding. La regeneración fue exacta y pasó una prueba C++ de cabecera/enlace. Los argumentos ndarray y rangos temporales siguen pendientes.

Los argumentos tipados de rango cero para arange aprobaron **17 508 casos /250 603 comprobaciones exactas**, 35 comprobaciones Lua nuevas y una prueba C. Las fuentes de solo lectura/desalineadas conservan datos y permisos; se prueban precisión intermedia, conversión inicial, límites enteros y selección de longitud compleja. Se excluyeron 56 reservas excesivas y 70 errores de construcción de argumentos antes de ejecutar arange. El padding longdouble se pone a cero en las entradas de fixtures y se omite al comparar; sus diez bytes significativos se comprueban exactamente. La regeneración fue exacta y pasó la prueba C++ de cabecera/enlace. Los rangos temporales siguen pendientes.

Los rangos temporales y sus dependencias aprobaron **65 082 casos /301 408 comprobaciones exactas**: 28 086 de rangos/despacho numérico, 33 124 de promoción de unidades y 3 872 de operaciones/casting. También pasaron 98 comprobaciones Lua nuevas, la prueba C y la prueba C++ de cabecera/enlace. Los ticks temporales comparan sus ocho bytes; longdouble numérico omite seis bytes de padding por componente y comprueba diez significativos. Se excluyeron 1 190 estados inseguros/excesivos y 308 errores de construcción antes de ejecutar el rango. No cuentan como compatibilidad. Se conservan las particularidades verificadas de NaT relativo y conversión escalar/array. La regeneración de los tres corpus fue exacta.

Resize y las regresiones de disposición/Unicode aprobaron **18 248 casos /313 948 comprobaciones exactas**: 7 776 copias con repetición, 7 128 casos del método y 3 344 regresiones. También pasaron 156 comprobaciones Lua nuevas, la prueba C de propiedad/reasignación y la prueba C++ de cabecera/enlace. Solo se comparan bytes inicializados; las colas indefinidas de crecimiento en solo lectura no se leen. Longdouble omite padding de la ABI. Los tres corpus se regeneraron exactamente.

Byteswap y las consultas de memoria de ancho cero aprobaron **45 504 casos /262 320 comprobaciones exactas**: 9 504 intercambios y 36 000 pares de consultas exactas/de límites. También pasaron 108 comprobaciones Lua nuevas, la prueba nativa y la ejecución C++ de cabecera/enlace. Se comprueban todos los bytes inicializados, incluido padding longdouble, sin decodificar esos datos brutos. Ambos corpus se regeneraron exactamente.

Getfield/setfield aprobaron **233 460 casos /2 680 078 comprobaciones exactas**: 79 632 vistas y 153 828 asignaciones. También pasaron 104 comprobaciones Lua nuevas, la prueba nativa y la ejecución C++ de cabecera/enlace. Se comparan bytes inicializados, estados base completos, errores parciales, diferencias entre escalares/arrays y metadatos. Ambos corpus se regeneraron exactamente.

Los métodos conj/conjugate aprobaron **28 140 casos /340 632 comprobaciones** y 82 comprobaciones Lua permanentes. Se contrastaron identidad, salidas explícitas, casting, alias, solo lectura y estados posteriores, incluidos NaN/inf/ceros con signo. Veinticuatro resultados escalares NumPy se normalizaron expresamente a la convención unaria de arrays Lua de rango cero; sus bytes/dtypes son exactos y las comprobaciones de representación/escritura siguen esa adaptación, sin declarar paridad de objetos escalares. Longdouble omite padding de ABI. El corpus se regeneró exactamente.

Indices/ix_/argwhere aprobaron **6 063 casos /474 263 comprobaciones** y 150 comprobaciones Lua permanentes: 1 344 rejillas, 2 539 mallas y 2 180 búsquedas de posiciones. Se compararon valores, metadatos, memoria compartida y escrituras/estados base, incluidas entradas vacías, escalares, de solo lectura y de hasta 64 dimensiones. Las rejillas conservan datos desde cero. Se normalizaron 438 ejes booleanos y 13 671 valores de argwhere a posiciones Lua desde uno; los metadatos siguen comparándose directamente. Longdouble omite padding de ABI. Los tres corpus se regeneraron exactamente.

Fromfunction aprobó **2 160 casos /1 172 364 comprobaciones** y 103 comprobaciones Lua permanentes: número de llamadas/argumentos/retornos, valores, metadatos, identidad, memoria compartida, cambios y errores. El contexto keyword original se mapeó a parámetros Lua extra y las tuplas a retornos múltiples; el motor no convierte los resultados. Las coordenadas conservan valores desde cero. Longdouble omite padding de ABI. El corpus se regeneró exactamente.

Ndindex aprobó **1 254 casos /39 746 comprobaciones** y 91 comprobaciones Lua permanentes: recorrido C, instantáneas independientes, agotamiento, formas escalares/vacías/booleanas/inválidas y alto rango. Se normalizaron 26 626 coordenadas a posiciones Lua desde uno. Los productos cartesianos grandes comprueban prefijos acotados; no se recorrieron completos. Las pruebas nativas verifican dimensiones enormes perezosas sin intentar su asignación upstream. El corpus se regeneró exactamente.

Apply_along_axis aprobó **60 768 casos /1 226 968 comprobaciones** y 191 comprobaciones Lua permanentes: ejes y orden de callbacks, vistas compartidas, bytes/metadatos, dtype/forma del primer resultado, inserción de dimensiones y broadcasting, escrituras, solo lectura y fallos. Los ejes positivos se normalizaron a posiciones Lua y el parámetro Python con nombre a un argumento Lua. El corpus se regeneró exactamente; el padding longdouble se omite explícitamente.

Apply_over_axes y sumas de cadenas de ancho cero aprobaron **193 600 casos /4 923 021 comprobaciones**, 443 comprobaciones Lua permanentes, una prueba nativa y una prueba C++ de cabeceras/enlace. Comprueban orden/ejes/retención de dimensiones, identidad/vistas, seeds, máscaras, dtypes/salidas y estados después de fallos. Se normalizaron 8 774 resultados escalares de callbacks y 2 892 cadenas escalares a la representación Lua declarada. La referencia de cadenas aísla 180 grupos dtype/salida en procesos NumPy nuevos por cambios de despacho dependientes del historial observados. Ambos corpus se regeneraron exactamente. El padding longdouble se omite; el writeback de fallos con solapamiento general sigue sin certificar.

Las operaciones enteras y sus correcciones del núcleo aprobaron **144 844 casos /3 318 010 comprobaciones**, 6 242 comprobaciones Lua permanentes, una prueba nativa y ejecución de cabeceras/enlace C++. Incluyen dtype.char/num, máscaras, alias/salidas solapadas, escalares débiles, límites con signo y todos los 256 bytes Boolean. Se normalizaron explícitamente 2 120 retornos escalares ufunc a ndarrays tipados Lua de dimensión cero. Ambos corpus se regeneraron exactamente; el padding longdouble se omite.

Las conversiones de índices aprobaron **40 822 casos /391 028 comprobaciones**: 32 128 ravel y 8 694 unravel, con 168 comprobaciones Lua permanentes, una prueba nativa y cabeceras/enlace C++. Se verifican posiciones, dtype, forma, strides, flags, C/F y KEEPORDER, modos de límites, broadcasting, vistas compartidas, escrituras e independencia de la entrada. El corpus se regeneró exactamente. Se adaptaron 105 704 valores de entrada a posiciones Lua, se ampliaron 11 312 arrays estrechos/Boolean y se normalizaron 4 932 retornos escalares. Se excluyeron otros 1 472 casos (3 136 operandos) que no permiten representar la posición intp máxima al sumar uno, además de entradas inseguras del origen; no cuentan como aprobados.

Bincount aprobó **6 937 casos /50 126 comprobaciones**, 93 comprobaciones Lua permanentes, una prueba nativa y cabeceras/enlace C++. Se comprueban bytes, dtype, forma, strides, flags, memoria independiente, entradas intactas, conversiones, valores extremos, acumulación secuencial, entradas vacías y layouts sin alinear/de solo lectura. Se excluyeron 48 casos de reserva enorme/desbordamiento del origen; no cuentan como aprobados. El corpus se regeneró exactamente. Los seis bytes de padding longdouble se normalizan al serializar, incluidos los buffers sin alinear; se conservan sus diez bytes significativos.

La auditoría dirigida ASan/UBSan instrumentó `ln_write`, `lua_elements`, `ln_dtype_transfer`, `ln_datetime_strings`, `ln_join`, `ln_condition`, `ln_dot`, `ln_matrix`, `ln_linalg`, `lua_matrix`, `lua_module`, `ln_time_scale`, `ln_ufunc`, `ln_nditer_multi`, `ln_datetime`, `ln_core`, `lua_buffers`, `ln_mapping`, `ln_nditer`, `ln_take`, `ln_choose`, `lua_flags`, `ln_components`, `ln_creation`, `lua_metadata`, `ln_dtype_info`, `lua_dtype`, `ln_string`, `lua_creation`, `lua_bytes`, `ln_sampling`, `ln_constructor`, `lua_constructor`, `ln_arange`, `lua_arange`, `ln_arange_time`, `ln_resize`, `lua_resize`, `ln_layout`, `ln_bytes`, `lua_components`, `ln_integer_math`, `ln_order`, `ln_index_math`, `lua_index_math`, `ln_bincount`, `lua_bincount`, además del runner Lua y dieciocho pruebas nativas. Aprobaron todas las suites mantenidas y los 60 corpus acumulados. Otras dependencias no estaban completamente instrumentadas; la detección de fugas estaba desactivada. El empaquetado verifica la huella del código ejecutado.

Se verificaron símbolos de inicialización ASan en los 66 objetos declarados (47 unidades de biblioteca, runner y 18 pruebas nativas). El driver reconstruye los objetos desde la misma lista que registra. El informe inicial de la 0.153 contaba una prueba instrumentada de más; su [reauditoría corregida](https://github.com/48hoursnonstop/luaray/releases/download/v0.153.0-dev/luaray-0.153.0-dev-sanitizers-corrected.json) del mismo código aprobó todas las pruebas y 56 corpus, sin modificar sus paquetes.

## Integridad de las entregas

Las entregas incluyen archivo fuente, SHA-256 y un JSON de verificación separado.
El archivo contiene `PROJECT_SHA256SUMS`, generado al empaquetar. El manifiesto
no se conserva en el árbol de trabajo porque cada edición lo volvería obsoleto.

Las herramientas originales verifican el manifiesto tras extraer el paquete,
compilan y ejecutan las pruebas desde esa fuente limpia. Los archivos y tags
publicados son inmutables.
