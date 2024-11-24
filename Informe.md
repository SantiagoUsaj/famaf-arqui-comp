# Arquitectura de Computadoras - 2024
## Informe Lab2:  Análisis de microarquitecturas

## Integrantes:

 - Santiago Usaj
 - Federico Di Forte
 - Ronnie Murphy

## Indice 

1. [Ejecricio 1](#1-ejercicio-1)
2. [Ejercicio 2](#2-ejercicio-2)
3. [Ejercicio 3](#3-ejercicio-3)


## 1. Ejercicio 1

En este ejercicio vamos a prueba a nuestro procesador con Daxpy, la cual es la rutina principal del LINPACK Benchmark, para ver la performance de este segun el tamaño y tipo de memoria cache.

Puntos: 

## a)  

Escribir el código del microbenchmark daxpy en assembler ARMv8 y verificar su funcionamiento con qemu.

Sea alpha una constante, X, Y y Z vectores de longitud N (todos ellos
expresados como valores en punto flotante).

Codigo en C:
```c
const int N;
double X[N], Y[N], Z[N], alpha;

for (int i = 0; i < N; ++i) {
    Z[i] = alpha * X[i] + Y[i];
}
```

## b)

  Correr la simulación para los siguientes tamaños de caché de datos: [8KB, 16KB, 32KB] de mapeo directo (1 vía) y obtener las siguientes métricas: número de ciclos (numCycles), ciclos ociosos (idleCycles), hits totales en la caché de datos (overallHits) y hits de lectura en la caché de datos (ReadReq.hits).

### [Resultados de la simulación con 8kB](./resultados/8kb-1assoc.txt)

* Numero de ciclos: 221389.0

* Ciclos ociosos: 141030.0

* Hits totales en la caché de datos: 798.0

* Hits de lectura en la caché de datos: 477.0


### [Resultados de la simulación con 16kB](./resultados/16kb-1assoc.txt)

* Numero de ciclos: 221433.0

* Ciclos ociosos: 141074.0

* Hits totales en la caché de datos: 798.0

* Hits de lectura en la caché de datos: 477.0

### [Resultados de la simulación con 32kB](./resultados/32kb-1assoc.txt)

* Numero de ciclos: 221453.0

* Ciclos ociosos: 141094.0

* Hits totales en la caché de datos: 798.0

* Hits de lectura en la caché de datos: 477.0

## c) 

Repetir el punto b) pero para cachés asociativas por conjuntos de 2, 4 y 8 vías (parámetro “asoc” en el archivo in_order.py).

### Caché asociativas por conjuntos de 2

#### [Resultados de la simulación con 8kB](./resultados/8kb-2assoc.txt)

* Numero de ciclos: 189261.0

* Ciclos ociosos: 119162.0

* Hits totales en la caché de datos: 4781.0

* Hits de lectura en la caché de datos: 4714.0


#### [Resultados de la simulación con 16kB](./resultados/16kb-2assoc.txt)

* Numero de ciclos: 188833.0

* Ciclos ociosos: 118777.0

* Hits totales en la caché de datos: 4782.0

* Hits de lectura en la caché de datos: 4706.0

#### [Resultados de la simulación con 32kB](./resultados/32kb-2assoc.txt)

* Numero de ciclos: 188756.0

* Ciclos ociosos: 118593.0

* Hits totales en la caché de datos: 4769.0

* Hits de lectura en la caché de datos: 4694.0


### Caché asociativas por conjuntos de 4

#### [Resultados de la simulación con 8kB](./resultados/8kb-4assoc.txt)

* Numero de ciclos: 243159.0

* Ciclos ociosos: 187538.0

* Hits totales en la caché de datos: 10755.0

* Hits de lectura en la caché de datos: 7685.0


#### [Resultados de la simulación con 16kB](./resultados/16kb-4assoc.txt)

* Numero de ciclos: 243071.0

* Ciclos ociosos: 187448.0

* Hits totales en la caché de datos: 10755.0

* Hits de lectura en la caché de datos: 7685.0

#### [Resultados de la simulación con 32kB](./resultados/32kb-4assoc.txt)

* Numero de ciclos: 243071.0

* Ciclos ociosos: 187448.0

* Hits totales en la caché de datos: 10755.0

* Hits de lectura en la caché de datos: 7685.0


### Caché asociativas por conjuntos de 8

#### [Resultados de la simulación con 8kB](./resultados/8kb-8assoc.txt)

* Numero de ciclos: 243023.0

* Ciclos ociosos: 187403.0

* Hits totales en la caché de datos: 10755.0

* Hits de lectura en la caché de datos: 7685.0


#### [Resultados de la simulación con 16kB](./resultados/16kb-8assoc.txt)

* Numero de ciclos: 243071.0

* Ciclos ociosos: 187448.0

* Hits totales en la caché de datos: 10755.0

* Hits de lectura en la caché de datos: 7685.0

#### [Resultados de la simulación con 32kB](./resultados/32kb-8assoc.txt)

* Numero de ciclos: 243071.0

* Ciclos ociosos: 187448.0

* Hits totales en la caché de datos: 10755.0

* Hits de lectura en la caché de datos: 7685.0

## d) 

Graficar las métricas obtenidas en los puntos b) y c), realizar un análisis y justificar estos resultados respecto al código escrito en el punto a).

En general no encontramos diferencia según el tamaño de la memoria, el procesador se comporta de manera similar para los mismos tamaños de memoria.

### Cantidad de ciclos por cantidad de vias de caché 

Los **numCycles** representan el número total de ciclos de reloj utilizados por el procesador para ejecutar un programa o conjunto de instrucciones en una simulación o en un entorno real. Cada ciclo de reloj es una unidad básica de tiempo en la cual el procesador puede realizar operaciones, como ejecutar instrucciones, mover datos entre registros, o interactuar con la memoria.

![Gráficos de resultados](./graficos/grafico_numCycles.png)

Podemos observar que al agregar vías a la caché mejora significativamente su rendimiento, en el caso de 2 vías es el que mejor rendimiento obtuvimos. Pero una vez que se complejiza y aumentamos de más la cantidad de vías, el rendimiento es aún peor que el que teníamos en un principio con una única vía.

XXX Porque?

### Cantidad de ciclos ociosos

Representa el tiempo durante el cual el procesador está inactivo porque está esperando que se completen ciertas operaciones, como el acceso a la memoria principal o la finalización de una instrucción dependiente. 

![Gráficos de resultados 2](./graficos/grafico_idleCycles.png)

Aqui corroboramos lo dicho anteriormente, la caché de 2 vías es la de mejor rendimiento, ya que observamos en la gráfica que la misma es la que tiene menor cantidad de ciclos ociosos.

### Cantidad de hits en la caché

Son todos los accesos exitosos a la caché, tanto los accesos para escritura como lectura.

![Gráficos de resultados 3](./graficos/grafico_overallHits.png)

Se observa que mientras aumente la cantidad de vías, la cantidad de hits aumenta a la par hasta llegar a las 4 vías donde si se agregan más vías, estas siguen haciendo la misma cantidad de hits. Esto puede decir que la caché llegó a su límite de eficiencia.

XXX Falta explicar esta curva

### Cantidad de hits de lectura en la caché

Son todos los accesos exitosos a la caché, solamente para los accesos de lectura.

![Gráficos de resultados 4](./graficos/grafico_readReq.hits.png)

Podemos ver la misma relación que con los **overallHits**. Segun aumentamos la cantidad de vías a la caché, esta mejora su rendimiento hasta que llega a la 4 vías, donde aquí llega a su límite de eficiencia.

## e)


### Resultados obtenidos

#### [Caché de mapeo directo y tamaño de 32kB](./resultados/32kb-1assoc-opt.txt)


#### [Caché de dos vias y tamaño de 32kB](./resultados/32kb-2assoc-opt.txt)

### Estrategias utilizadas

* **Loop unrolling**: Repetimos múltiples iteraciones del bucle dentro de un único ciclo para reducir las instrucciones de control de bucle.

	Reduce las instrucciones de control del bucle `cmp` y `b`, disminuyendo la sobrecarga. En lugar de procesar una sola iteración por ciclo, el bucle procesa 8 elementos de X, Y, y Z en cada pasada.

* **Pre-fetching manual**: Aseguramos que los datos futuros sean cargados en la caché antes de usarlos.

	Agregar instrucciones explícitas de prefetch `prfm` para traer datos de memoria principal a la caché antes de que se necesiten.

* **Reorganización de cálculos**: Agrupamos operaciones para explotar mejor los registros del procesador.

    Los cálculos para índices (x7) se realizan en bloques antes de las operaciones de carga.

* **Reducción de dependencias**: Utilizar registros independientes para evitar dependencias de datos entre iteraciones, lo que permite mayor paralelismo en la ejecución.

    Cada registro (d0 a d15) contiene datos independientes de una iteración. No se reutilizan registros en el mismo ciclo del bucle.

* **Acceso eficiente a memoria**: El acceso a memoria para X, Y y Z utiliza desplazamientos efectivos (`lsl #` y #8 para el unrolling) para minimizar cálculos.

### Graficos

!Aclaración: La dimensión "y" de los siguientes graficos son la cantidad de ciclos.

| Cantidad de ciclos ociosos | Cantidad de ciclos |
|-----------------|----------------|
| ![Gráficos de resultados 5](./graficos/grafico_idleCycles_opt.png) | ![Gráficos de resultados 6](./graficos/grafico_numCycles_opt.png) |


!Aclaración: La dimensión "y" de los siguientes graficos son la cantidad de accesos a caché.

| Cantidad de hits en la caché | Cantidad de hits de lectura en la caché |
|-----------------|----------------|
| ![Gráficos de resultados 5](./graficos/grafico_overallHits_opt.png) | ![Gráficos de resultados 6](./graficos/grafico_readReq.hits_opt.png) |

Pudimos optimizar el código de forma que la cantidad de ciclos es casi la misma para la caché de una o dos vías y se hacen muchos menos ciclos que sin optimizar.

En caso de hits a caché, pudimos aumentar la cantidad de hits en los dos casos. Principalmente en el caso de la caché de mapeo directo que sin optimizar el código se hacían alrededor de unos 800, mientras que ahora se generan unos 6900 hits.


## f)

Ejecutar la simulación utilizando el procesador out-of-order con las características de la caché utilizada en el punto e) y comparar los resultados.

#### [Procesador out-of-order](./resultados/out_of_order.txt)

### Graficos

!Aclaración: La dimensión "y" de los siguientes graficos son la cantidad de ciclos.

| Cantidad de ciclos ociosos | Cantidad de ciclos |
|-----------------|----------------|
| ![Gráficos de resultados 5](./graficos/grafico_idleCycles_out-of-order.png) | ![Gráficos de resultados 6](./graficos/grafico_numCycles_out-of-order.png) |


!Aclaración: La dimensión "y" de los siguientes graficos son la cantidad de accesos a caché.

| Cantidad de hits en la caché | Cantidad de hits de lectura en la caché |
|-----------------|----------------|
| ![Gráficos de resultados 5](./graficos/grafico_overallHits_out-of-order.png) | ![Gráficos de resultados 6](./graficos/grafico_readReq.hits_out-of-order.png) |

Se puede observar que el procesador out-of-order hace menos ciclos y sobre todo menos cantidad de ciclos ociosos gracias a la capacidad que tiene de reorganizar las instrucciones, evitando asi cualquier tipo de dependecia de datos o instrucciones.

El procesador in-order accede a la memoria de manera secuencial, lo que permite un mejor rendimiento. Por ejemplo, en un bucle, los datos almacenados contiguamente en memoria pueden ser procesados eficientemente, reutilizando las líneas de caché con alta frecuencia. En contraste, el procesador out-of-order ejecuta las instrucciones de manera no secuencial, lo que puede reducir la eficiencia de la reutilización de la caché.

## 2. Ejercicio 2

En este ejercicio se nos pide simular el flujo de calor en una placa de un material uniforme.

## a) 

A partir del código dado, reescribir el algoritmo de la simulación física en assembler ARMv8 y verificar su funcionamiento en qemu.

* Codigo en C:

```c
const int n_iter, fc_x, fc_y;
float fc_temp,sum, x[N*N], x_tmp[N*N], t_amb;

// Esta parte inicializa la matriz, solo es necesaria para verificar el código
for (int i = 0; i < N*N; ++i)
	x[i] = t_amb;

x[fc_x*N+fc_y] = fc_temp;

// -------------------------------------------------------------------------------

for(int k = 0; k < n_iter; ++k) {
	for(int i = 0; i < N; ++i) {
		for(int j = 0; j < N; ++j) {
			if((i*N+j) != (fc_x*N+fc_y)){
				sum = 0;
				if(i + 1 < N)
					sum = sum + x[(i+1)*N + j];
				else
					sum = sum + t_amb;
				if(i - 1 >= 0)
					sum = sum + x[(i-1)*N + j];
				else
					sum = sum + t_amb;
				if(j + 1 < N)
					sum = sum + x[i*N + j+1];
				else
					sum = sum + t_amb;
				if(j - 1 >= 0)
					sum = sum + x[i*N + j-1];
				else
					sum = sum + t_amb;
				x_tmp[i*N + j] = sum / 4;
			}
		}
	}
	for (int i = 0; i < N*N; ++i)
		if(i != (fc_x*N+fc_y))
			x[i] = x_tmp[i];
}
```

## b) 

Ejecutar en gem5 la simulación considerando una caché de datos de mapeo directo de 32KB y predictor de saltos local (configurado por defecto).

#### [Caché de mapeo directo y tamaño de 32kB](./resultados/ej2/32kb_1assoc.txt)

## c) 

Evaluar la cantidad de ciclos que toma su ejecución utilizando cachés asociativa por conjuntos de 2, 4 y 8 vías. Determinar en qué caso se obtiene la mejor performance y explicar por qué.

### Resultados

#### [Caché asociativa por conjunto de 2 vias y tamaño de 32kB](./resultados/ej2/32kb_2assoc.txt)

* Ciclos de ejecución: 3413403.0

* Ciclos ociosos: 170388.0

#### [Caché asociativa por conjunto de 4 vias y tamaño de 32kB](./resultados/ej2/32kb_4assoc.txt)

* Ciclos de ejecución: 3456970.0

* Ciclos ociosos: 212025.0

#### [Caché asociativa por conjunto de 8 vias y tamaño de 32kB](./resultados/ej2/32kb_8assoc.txt)

* Ciclos de ejecución: 3457622.0

* Ciclos ociosos: 212421.0

### Comparación de métricas

| Cantidad de ciclos ociosos | Cantidad de ciclos por vías de caché | Cantidad de hits en la caché | Cantidad de hits de lectura en la caché |
|-----------------|----------------|-----------------|----------------|
| ![Gráficos de resultados 5](./graficos/grafico_idleCycles_ej2.png) | ![Gráficos de resultados 6](./graficos/grafico_numCycles_ej2.png) | ![Gráficos de resultados 7](./graficos/grafico_overalHits_ej2.png) | ![Gráficos de resultados 8](./graficos/grafico_ReadReq.hits_ej2.png) |


Llegamos a la conclusión que el mejor caso es donde utilizamos una caché asociativa de dos vías. Esto se debe a que con dos vías, con poca diferencia con cuatro u ocho vías, se logra un equilibrio óptimo entre la complejidad del hardware y la eficiencia en la tasa de aciertos de la caché, reduciendo significativamente los ciclos de ejecución y los ciclos ociosos en comparación con la configuración de mapeo directo.

## d) 

En este punto se pretende analizar la diferencia al usar dos predictores de saltos distintos: local y predictor por torneos (que está compuesto por un predictor local y uno global). En primer lugar se debe analizar el código e intentar deducir qué tipo de predictor (local o global) funcionará mejor en cada tipo de salto y cuánto podría mejorar usar el de torneo. Correr el código con el predator local por defecto y obtener el miss rate calculado como: 

	condIncorrect / (condPredicted + condIncorrect) 

Luego elegir el predictor por torneos (similar al utilizado en el procesador alpha 21264) y obtener nuevamente el miss rate. En ambos casos utilizar las características de la caché que obtuvo la mejor performance en el punto c). Analizar si los resultados se corresponden con lo esperado y justificar. e) Ejecutar la simulación utilizando el procesador out-of-order con l

### Resultados

#### [Predictor de salto local](./resultados/ej2/32kb-2assoc-local.txt)

* MissRate = 2031.0 / (336530.0 + 2031.0) = 0.00598

#### [Predictor de salto por torneo](./resultados/ej2/32kb-2assoc-torneo.txt)

* MissRate = 735.0 / (334559.0 + 735.0) = 0.00219

### Predictores de salto

* **Predictor Local**: Este predictor utiliza el historial de saltos de una instrucción específica para predecir el resultado de futuros saltos. Es efectivo en bucles y patrones de saltos repetitivos.

* **Predictor por Torneos**: Este predictor combina un predictor local y un predictor global. El predictor global utiliza el historial de saltos de todo el programa, mientras que el predictor local utiliza el historial de una instrucción específica. Un selector de torneos decide cuál predictor usar en función de cuál ha sido más preciso en el pasado.

### Analisis

En el código podemos observar varios bucles que son predecibles, por ejemplo:

* Bucle de Inicialización (initialize_loop): Este bucle es altamente predecible ya que itera un número fijo de veces (N*N).

* Bucle de Iteración (outer_loop, row_loop, column_loop): Estos bucles también son predecibles ya que iteran un número fijo de veces (N y n_iter).

El predictor por torneos es mejor que el local porque combina las ventajas de los predictores locales y globales, adaptándose dinámicamente a diferentes patrones de saltos. Mientras que el predictor local se basa en los últimos saltos hechos por una instrucción, en este código tenemos múltiples tipos de instrucciones de saltos generando así múltiples ramas, dificultando la precisión de la predicción. También afecta a la baja precisión de predicción tener saltos condicionales con dependencia de datos ya que se deberán calcular previamente, si estas se modifican frecuentemente, esto llevará a múltiples fallos en la predicción.

## e)

Ejecutar la simulación utilizando el procesador out-of-order con las características de la caché que obtuvo la mejor performance en el punto c) y un predictor de saltos por torneos. Comparar los resultados obtenidos con el punto d).

### Resultados

#### [Mejor optimización de procesador in-order](./resultados/ej2/32kb-2assoc-torneo.txt)

#### [Procesador out-of-order](./resultados/ej2/out-of-order.txt)

### Graficos

!Aclaración: La dimensión "y" de los siguientes graficos son la cantidad de ciclos.

| Cantidad de ciclos ociosos | Cantidad de ciclos |
|-----------------|----------------|
| ![Gráficos de resultados 5](./graficos/grafico_idleCycles_out-of-order_ej2.png) | ![Gráficos de resultados 6](./graficos/grafico_numCycles_out-of-order_ej2.png) |


!Aclaración: La dimensión "y" de los siguientes graficos son la cantidad de accesos a caché.

| Cantidad de hits en la caché | Cantidad de hits de lectura en la caché |
|-----------------|----------------|
| ![Gráficos de resultados 5](./graficos/grafico_overallHits_out-of-order_ej2.png) | ![Gráficos de resultados 6](./graficos/grafico_readReq.hits_out-of-order_ej2.png) |

Se puede observar que obtenemos una cantidad similar de hits a la memoria, pero al ver los ciclos ociosos, el procesador out-of-order es ampliamente mejor que el in-order ya que apenas genera ciclos ociosos.

XXX El ejercicio pide comprar los hits del predictor de salto

Esto se debe a la capacidad que tiene el procesador out-of-order de ejecutar las instrucciones en un orden diferente al que fue escrito, evitando así secuencias de instrucciones con dependencias de valores (hazards) dejando la menor cantidad de de ciclos de espera.

## 3. Ejercicio 3

## c) 
### Tabla comparativa: Código Base vs Código optimizado

| Métrica                                                   | Código Base | Código optimizado | Cambio (%)                        |
|-----------------------------------------------------------|-------------|--------------------------|------------------------------------|
| simInsts                                                 | 479.0       | 479.0                    | 0.00%                             |
| system.cpu_cluster.cpus.numCycles                        | 14501.0     | 14132.0                  | -2.54%                            |
| system.cpu_cluster.cpus.cpi                              | 30.27       | 29.50                    | -2.54%                            |
| system.cpu_cluster.cpus.branchPred.lookups              | 342.0       | 358.0                    | 4.68%                             |
| system.cpu_cluster.cpus.branchPred.condPredicted        | 213.0       | 221.0                    | 3.76%                             |
| system.cpu_cluster.cpus.branchPred.condIncorrect        | 62.0        | 59.0                     | -4.84%                            |
| system.cpu_cluster.cpus.branchPred.BTBLookups           | 203.0       | 167.0                    | -17.73%                           |
| system.cpu_cluster.cpus.branchPred.BTBUpdates           | 50.0        | 53.0                     | 6.00%                             |
| system.cpu_cluster.cpus.branchPred.BTBHits              | 33.0        | 20.0                     | -39.39%                           |
| system.cpu_cluster.cpus.commitStats0.committedInstType::IntAlu | 372.0  | 372.0                    | 0.00%                             |
| system.cpu_cluster.cpus.commitStats0.committedInstType::MemRead | 94.0   | 94.0                     | 0.00%                             |
| system.cpu_cluster.cpus.commitStats0.committedInstType::MemWrite | 96.0  | 96.0                     | 0.00%                             |
| system.cpu_cluster.cpus.dcache.overallHits::total       | 182.0       | 189.0                    | 3.85%                             |
| system.cpu_cluster.cpus.dcache.overallMisses::total     | 16.0        | 17.0                     | 6.25%                             |
| system.cpu_cluster.cpus.dcache.overallAccesses::total   | 198.0       | 206.0                    | 4.04%                             |
| system.cpu_cluster.cpus.dcache.replacements             | 3.0         | 3.0                      | 0.00%                             |
| system.cpu_cluster.cpus.dcache.ReadReq.hits::total      | 96.0        | 103.0                    | 7.29%                             |
| system.cpu_cluster.cpus.dcache.ReadReq.accesses::total  | 112.0       | 120.0                    | 7.14%                             |
| system.cpu_cluster.cpus.dcache.WriteReq.hits::total     | 86.0        | 86.0                     | 0.00%                             |
| system.cpu_cluster.cpus.dcache.WriteReq.accesses::total | 86.0        | 86.0                     | 0.00%                             |
| system.cpu_cluster.cpus.icache.overallHits::total       | 275.0       | 248.0                    | -9.82%                            |
| system.cpu_cluster.cpus.icache.overallMisses::total     | 45.0        | 46.0                     | 2.22%                             |
| system.cpu_cluster.cpus.icache.overallAccesses::total   | 320.0       | 294.0                    | -8.13%                            |
| system.cpu_cluster.cpus.icache.replacements             | 16.0        | 26.0                     | 62.50%                            |
| system.cpu_cluster.l2.overallMisses::total              | 59.0        | 61.0                     | 3.39%                             |
| system.cpu_cluster.l2.overallAccesses::total            | 61.0        | 63.0                     | 3.28%                             |
| system.cpu_cluster.l2.replacements                      | 0.0         | 0.0                      | 0.00%                             |
| system.cpu_cluster.cpus.idleCycles                      | 13197.0     | 12839.0                  | -2.71%                            |


### Mejoras introducidas:
# Optimización con Instrucciones Condicionales (CSET, CSEL, CBZ)

## Uso de Instrucciones Condicionales

En el código optimizado, se emplean instrucciones como `CSET` y `CSEL`, que permiten manejar condiciones de manera más eficiente al reducir la necesidad de ramas explícitas (`b` o `b.lt`). 

Por ejemplo, en lugar de utilizar varias instrucciones para comparar valores y realizar intercambios, se usa `CSEL` para seleccionar directamente los valores mayor o menor, optimizando la operación de intercambio en el ordenamiento burbuja.

### Impacto

- **Menor número de predicciones de ramas (`branchPred.lookups`)** debido a la reducción de ramas explícitas.
- **Mejora en la precisión de las predicciones de ramas (`branchPred.condIncorrect`)**, ya que el uso de `CSET` y `CBZ` reduce la cantidad de bifurcaciones ambiguas.

---

## Reducción de Instrucciones y Ramas

En el código base, el manejo de ramas y comparaciones introduce más instrucciones de control de flujo, aumentando la probabilidad de fallos en predicciones de ramas (más `branchPred.condIncorrect`). 

En el código optimizado, se reduce el uso de ramas mediante condiciones directas (`CBZ`) y selecciones condicionales (`CSEL`), eliminando ramas innecesarias.

### Impacto

- **Menor uso del Branch Target Buffer (BTB)**, reflejado en métricas como:
  - Reducción de `branchPred.BTBLookups`.
  - Cambios en `branchPred.BTBHits` y `branchPred.BTBUpdates` debido a menos accesos y actualizaciones al BTB.

---

## Simplificación de los Bucles Internos

El uso de `CSET` y `CBZ` disminuye la complejidad del bucle interno en el ordenamiento burbuja, permitiendo que cada iteración consuma menos ciclos.

### Impacto

- **Reducción de ciclos totales de CPU (`system.cpu_cluster.cpus.numCycles`)**.
- **Mejora del CPI (Ciclos por Instrucción)**, reflejando una mayor eficiencia.

---

## Menor Repetición de Cálculos

En el código optimizado, ciertos valores (como `N`) se cargan o calculan una sola vez, mientras que en el código base algunos cálculos se realizan de forma redundante.

### Impacto

- **Reducción en accesos a memoria y uso de registros**, lo que mejora el rendimiento general.

## impacto en metricas especifics:

| Métrica                           | Efecto Directo                                                        |
|-----------------------------------|------------------------------------------------------------------------|
| branchPred.lookups               | Menor número de ramas explícitas reduce el total de predicciones.      |
| branchPred.condIncorrect         | Menor cantidad de fallos en predicción debido al uso de condiciones directas. |
| branchPred.BTBLookups y BTBHits  | Reducción en el uso del BTB por menos ramas y bifurcaciones.           |
| dcache.overallAccesses::total    | Menor número de accesos redundantes a memoria.                         |
| system.cpu_cluster.cpus.numCycles | Reducción por bucles más eficientes.                                   |
| system.cpu_cluster.cpus.cpi      | Mejora al reducir el costo por instrucción ejecutada.                  |

## Conclusión

El código optimizado aprovecha mejor las capacidades de la arquitectura ARM mediante el uso de instrucciones condicionales avanzadas (`CSET`, `CSEL`, `CBZ`), lo que reduce la cantidad de ramas explícitas y mejora la eficiencia de los bucles. Esto se traduce en:

- **Menor uso del BTB** y **mayor precisión en las predicciones de ramas**.
- **Menor consumo de ciclos de CPU** y **mejor CPI**.
- **Menor cantidad de accesos redundantes a memoria**.

Estas mejoras son el resultado de un diseño más eficiente del flujo de control y una reducción de instrucciones innecesarias

## impacto en metricas especifics:

| Métrica                           | Efecto Directo                                                        |
|-----------------------------------|------------------------------------------------------------------------|
| branchPred.lookups               | Menor número de ramas explícitas reduce el total de predicciones.      |
| branchPred.condIncorrect         | Menor cantidad de fallos en predicción debido al uso de condiciones directas. |
| branchPred.BTBLookups y BTBHits  | Reducción en el uso del BTB por menos ramas y bifurcaciones.           |
| dcache.overallAccesses::total    | Menor número de accesos redundantes a memoria.                         |
| system.cpu_cluster.cpus.numCycles | Reducción por bucles más eficientes.                                   |
| system.cpu_cluster.cpus.cpi      | Mejora al reducir el costo por instrucción ejecutada.                  |

## Conclusión

El código optimizado aprovecha mejor las capacidades de la arquitectura ARM mediante el uso de instrucciones condicionales avanzadas (`CSET`, `CSEL`, `CBZ`), lo que reduce la cantidad de ramas explícitas y mejora la eficiencia de los bucles. Esto se traduce en:

- **Menor uso del BTB** y **mayor precisión en las predicciones de ramas**.
- **Menor consumo de ciclos de CPU** y **mejor CPI**.
- **Menor cantidad de accesos redundantes a memoria**.

Estas mejoras son el resultado de un diseño más eficiente del flujo de control y una reducción de instrucciones innecesarias

## D)
### Tabla comparativa: Código Base vs Código optimizado

| Métrica                           | Código Base | Código Optimizado | Cambio (%) |
|-----------------------------------|-------------|-------------------|------------|
| simInsts                          | 478.0       | 478.0             | 0.0%       |
| system.cpu_cluster.cpus.numCycles | 9858.0      | 11351.0           | +15.1%     |
| system.cpu_cluster.cpus.cpi       | 20.62       | 23.75             | +15.2%     |
| branchPred.lookups                | 295.0       | 248.0             | -15.9%     |
| branchPred.condPredicted          | 189.0       | 159.0             | -15.9%     |
| branchPred.condIncorrect          | 73.0        | 65.0              | -11.0%     |
| branchPred.BTBLookups             | 168.0       | 104.0             | -38.1%     |
| branchPred.BTBHits                | 50.0        | 20.0              | -60.0%     |
| branchPred.BTBUpdates             | 60.0        | 60.0              | 0.0%       |
| dcache.overallHits::total         | 192.0       | 182.0             | -5.2%      |
| dcache.overallMisses::total       | 20.0        | 22.0              | +10.0%     |
| dcache.overallAccesses::total     | 212.0       | 204.0             | -3.8%      |
| icache.overallHits::total         | 356.0       | 295.0             | -17.1%     |
| icache.overallMisses::total       | 56.0        | 53.0              | -5.4%      |
| icache.overallAccesses::total     | 412.0       | 348.0             | -15.5%     |
| idleCycles                        | 7464.0      | 8986.0            | +20.4%     |

XXX Estos resultados tienen varias cosas raras.... los CPI son muy altos. Los numCycles del optimizado OOO es peor que el no optimizado.

# Análisis de los Cambios

## Aumento en los Ciclos Totales y CPI

El código optimizado hace un mayor uso de condicionales (`CSET`, `CSEL`, `CBZ`), lo que introduce más dependencias en la ejecución. Aunque estas instrucciones eliminan ramas explícitas, estas dependencias pueden retrasar la ejecución en una arquitectura *out-of-order*. Esto se refleja en:

- **Mayor número de ciclos totales (`system.cpu_cluster.cpus.numCycles`)**.
- **Incremento en los ciclos por instrucción (CPI)**, reflejando una penalización por las dependencias.

---

## Reducción de Predicciones de Ramas y Uso del BTB

La eliminación de ramas explícitas contribuye a:

- **Reducción significativa en búsquedas de predicciones (`branchPred.lookups`)** y en los aciertos del BTB (`branchPred.BTBHits`).
- **Mejora en la precisión de las predicciones (`branchPred.condIncorrect`)**, debido a menos bifurcaciones ambiguas.

---

## Impacto en las Cachés

### Datos (D-Cache)
- **Menos accesos totales** a la caché de datos, lo que refleja un código más compacto.
- **Ligeros aumentos en los fallos de caché**, posiblemente indicativos de un patrón de acceso más disperso o menos predecible.

### Instrucciones (I-Cache)
- **Reducción en los accesos totales** a la caché de instrucciones, gracias al menor espacio requerido por el código optimizado.
- **Ligeras mejoras en los fallos de caché**, lo que puede deberse a una mejor reutilización del espacio en caché.

---

## Ciclos Inactivos

El incremento significativo en **ciclos inactivos (`idleCycles`)** se debe a latencias introducidas por las dependencias entre instrucciones condicionales. Esto refleja un impacto negativo en la efiiencia general del procesador.

## Conclusion:

Aunque el codigo optimizado mejora el flujo de control al reducir ramas explícitas y el uso del BTB, esto introduce nuevas dependencias en la ejecución que resultan en mayores latencias y ciclos totales en una arquitectura out-of-order. El código base, aunque más simple, aprovecha mejor la capacidad de ejecución de esta arquitectura.
