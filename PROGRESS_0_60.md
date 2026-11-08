# LuaRay — reporte de progreso (0.60.0-dev)

Fecha: 9 de octubre de 2026.

## Resumen

LuaRay sigue siendo un port nativo de NumPy a Lua en desarrollo, sin ejecutar
Python. Estimación de avance del proyecto completo: **aproximadamente 40–45%**;
núcleo numérico esencial: **75–85%**. Son estimaciones de ingeniería, no
porcentajes obtenidos de una matriz exhaustiva de paridad de NumPy.

## Métricas verificadas en 0.60

- 168 entradas registradas en el módulo LuaRay principal.
- 31 entradas en `linalg` y 12 en `fft`.
- 27 métodos registrados en `Generator` (incluidos controles de estado).
- **238 entradas registradas en esas cuatro tablas**; el total incluye
  alias y funciones auxiliares, no representa 238 funciones independientes
  de NumPy ni cobertura exhaustiva.
- 73/73 archivos diferenciales pasaron con `make full-test`.
- 12 728/12 728 comparaciones exactas nuevas con NumPy 2.3.5.
- Prueba nativa, ejemplo real y pruebas ASan/UBSan dirigidas aprobados.

## Avance funcional por áreas

| Área | Evaluación |
| --- | --- |
| `ndarray`, memoria, broadcasting, indexación y strides | Avanzado, casos límite pendientes |
| Ufuncs y aritmética | Avanzado, paridad parcial |
| `linalg` (BLAS/LAPACK) | Avanzado, paridad parcial |
| `fft` (PocketFFT) | Avanzado, paridad parcial |
| Estadística / reducciones y NaN | Avanzado, falta cobertura de API |
| `random` / PCG64 | Funcional con varias distribuciones, incompleto |
| DTypes especiales / extensiones | Parcial |
| Lectura/escritura `.npy`, `.npz` y APIs I/O | Pendiente |

## 0.60: nuevas funcionalidades

- `rng:noncentral_chisquare(df, nonc, size)`.
- `rng:noncentral_f(dfnum, dfden, nonc, size)`.
- Port de Poisson multiplicativo y PTRS para mezclar muestras de chi-cuadrado.
- Reproducción de estado PCG64 comprobada para semillas y parámetros ensayados.

## Riesgos y próximos pasos

1. Completar parámetros vectorizados/broadcasting en `random`.
2. Incorporar Poisson como API independiente, con validación de valores
   extremos y DTypes enteros (el núcleo escalar ya sirve a 0.60).
3. Ampliar distribuciones discretas y herramientas de `SeedSequence`.
4. Implementar persistencia `.npy`/`.npz` y fortalecer compatibilidad de DTypes.
5. Ejecutar fuzzing, rendimiento y sanitización total periódica.

## Cautelas

El éxito de 73 suites verifica únicamente los escenarios incluidos; no
implica 100% de compatibilidad. `noncentral_chisquare`/`noncentral_f` exigen
parámetros escalares finitos y rechazan ciertos casos con NaN/Inf que NumPy
acepta. La prueba con sanitizadores instrumentó solo los archivos nuevos y
modificados, no la totalidad del código nativo.
