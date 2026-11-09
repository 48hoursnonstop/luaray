# Portabilidad numérica

LuaRay 0.99.1 corrige la exponencial inversa float32 y conserva la entrada
uniforme de 24 bits y el consumo exacto de PCG64. Algunas implementaciones
antiguas de `log1pf` difieren en una ULP float32. En glibc 2.39 de Ubuntu, el
sorteo 11 de semilla cero produjo 1.0481541156768799; la referencia congelada
es 1.0481542348861694. Un cálculo Decimal de 80 dígitos confirma esta última.
Los sorteos 14 y 16 mostraron dos diferencias adicionales.

Ahora se calcula la misma expresión `-log1p(-u)` en doble precisión y se
redondea a float32. No cambiaron resultados esperados ni tolerancias. Pasaron
las 17,376 comparaciones existentes y regresiones explícitas de los tres valores
y la siguiente palabra PCG64. La ejecución GitHub 42526947924 pasó las 116 suites
y ambos ejemplos públicos en Ubuntu 24.04; también pasó la regresión en Arch.
La extracción limpia y los siguientes CI de la versión se registran por separado.

El diagnóstico acotado original de libm se conserva en el
[paquete publicado](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).

La corrección cubre esta ruta de exponencial inversa. No promete identidad de
bits para todas las funciones trascendentales, bibliotecas, CPU o plataformas.
Se conservan los límites de API/dtype y las diferencias originales registradas.
