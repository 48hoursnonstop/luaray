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

`python3 tools/probe_libm.py /ruta/libm.so.6` compara las tres entradas exactas
contra aritmética de 80 dígitos, cargando esa biblioteca solo en el proceso.
No necesita NumPy. Se inspeccionó el paquete oficial Ubuntu
`libc6_2.39-0ubuntu8.9_amd64.deb`, SHA-256
`ff5557d99b51f761c4b7c92368b9cc45565eda17df9bf9eb4b134d09825008be`.
Se extrajo en `.dev` sin instalar ni sustituir bibliotecas del sistema.
El binario completo de Arch no es compatible con la ABI de esa libc antigua;
la validación Ubuntu aprobada es CI remoto real, no una emulación local completa.

La corrección cubre esta ruta de exponencial inversa. No promete identidad de
bits para todas las funciones trascendentales, bibliotecas, CPU o plataformas.
Se conservan los límites de API/dtype y las diferencias originales registradas.
