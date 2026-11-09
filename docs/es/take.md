# Extracción por índices: take

LuaRay 0.100.0-dev implementa `np.take` y `ndarray:take` en su motor C nativo.
Python solo se utiliza durante el desarrollo para generar referencias.

```lua
local np = require('luaray')
local a = np.array({{1,2,3},{4,5,6}}, 'int32')
local extremos = a:take({1,-1}, {axis=2}) -- {{1,3},{4,6}}
local ultimo = np.take(a, -1)           -- 6, aplanado en orden C
local out = np.zeros({2,3}, 'float64')
assert(np.take(a, {-1,1}, {axis=1,out=out}) == out)
```

## Firma y coordenadas

`np.take(input, indices [, axis_or_options])` e
`input:take(indices [, axis_or_options])` comparten implementación. El tercer
argumento admite un eje o una tabla con `axis`, `mode` y `out`. Sin eje, o con
nil/false, se aplana la entrada en orden C. Ejes e índices positivos empiezan
en **1**. Los negativos cuentan desde el final. Cero es inválido; para índices,
se rechaza al recorrerlos, por lo que un resultado vacío puede omitir esa
comprobación. Los ejes negativos se normalizan antes de la extracción.

Con eje explícito, su dimensión se sustituye por `indices.shape`. Un índice
escalar elimina el eje. En modo aplanado, la forma es `indices.shape`. Sin
`out`, un resultado de dimensión cero se convierte en escalar Lua o en el tipo
escalar complejo/temporal existente. Con `out` siempre se devuelve el mismo
ndarray, incluso si tiene dimensión cero.

La entrada admite ndarray, escalar o tabla Lua compatible. Los índices Lua
se convierten directamente a enteros nativos del ancho de un puntero. Los
ndarrays de índices usan la regla **same_kind** de NumPy: se rechazan arrays
flotantes; se convierten los enteros admitidos, incluido uint64. Esto difiere
de la regla safe de put. El rango completo uint64 se puede construir mediante
astype nativo; un entero Lua no representa directamente todo ese rango.

## Modos de límites

- `raise`, predeterminado: acepta negativos desde el final y rechaza índices
  fuera de rango.
- `wrap`: traduce las coordenadas internamente y aplica módulo al tamaño del
  eje; también envuelve negativos.
- `clip`: limita al primer/último elemento. Los negativos seleccionan el
  primero, siguiendo a NumPy en este modo.

Las referencias incluyen índices escalares y multidimensionales, vacíos,
fuentes transpuestas/invertidas y strides cero. Sin `out`, un ndarray devuelto
es una copia independiente y contigua en orden C.

## Salida, memoria compartida y errores

`out` debe ser escribible y tener exactamente la forma del resultado. Se
permiten conversiones legacy unsafe compatibles. Salidas no contiguas,
desalineadas, solapadas o con otro dtype utilizan almacenamiento temporal;
raise también lo utiliza. **Antes** de extraer se convierten los valores
previos de out al dtype de entrada. Por eso una salida con cadenas numéricas
inválidas puede fallar aunque todos sus valores fueran a sustituirse.

Un índice inválido en raise deja intacta la salida temporal. Un fallo posterior
al convertir de regreso puede modificar parte de out: se conservan los
valores ya convertidos y los bytes previos del elemento que falla al codificar
ASCII. Se valida toda la cadena, incluidos caracteres fuera del límite de
truncamiento, y se conservan caracteres NUL internos.

En wrap/clip, out contiguo compatible puede compartir memoria con los índices.
Cada índice se lee una vez antes de copiar su bloque completo; esa escritura
puede modificar índices siguientes. Las pruebas conservan ese comportamiento
real. El solapamiento con la fuente se protege por separado.

## Evidencia y límites

La auditoría original cubrió pruebas C, **63 comprobaciones Lua** y **6,704
casos NumPy 2.5.3 / 324,615 comprobaciones** de valores y metadatos, incluidos
errores y estado posterior. Ejecuta `make full-test` para las regresiones C/Lua
y `make reference-test` para el corpus congelado externo. Estas cifras no
representan un porcentaje de avance global.

Una prueba acotada confirmó que NumPy no regresa en tres segundos después de
entrar a `take(zeros((3,0,0),int32), [0], axis=1, mode='wrap')`. LuaRay rechaza
esa situación con un error. Se conservan tres variantes fuera del conteo de
compatibilidad; solo se ejecutó en NumPy la llamada representativa. El diagnóstico
acotado se conserva con las herramientas originales en el [paquete publicado](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).

No se declara soporte completo para object, estructuras, StringDType variable,
clases de excepciones Python, advertencias ni endianness numérico no nativo.
Los 40 estados bloqueados anteriores siguen separados. Consulta
`compatibility/current.json`, [resultados de verificación](../development/validation.md) y [historical release notes](https://github.com/48hoursnonstop/luaray/blob/v0.116.0-dev/PROGRESS_0_100.md).
