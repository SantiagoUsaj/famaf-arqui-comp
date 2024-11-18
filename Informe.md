# Arquitectura de Computadoras - 2024
## Informe Lab2:  Análisis de microarquitecturas

## Integrantes:

 - Santiago Usaj
 - Federico Di Forte
 - Ronnie Murphy

## Indice 

1. [Ejecricio 1](#1-ejercicio-1)
2. [Ejercicio 2](#3-ejercicio-2)
3. [Ejercicio 3](#2-ejercicio-3)


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
Codigo en assembler ARMv8:
```
	// Inicialización		
	ldr     d10, [x10]      // Cargar Alpha en d10
	
	mov     x5, 0           // Inicializar índice i

.L2:
	cmp     x5, x0          // Comparar i con N
	b.ge    .L1             // Si i >= N, salir del bucle

	// Operación Z[i] = Alpha * X[i] + Y[i]
	ldr     d0, [x2, x5, lsl #3] // Cargar X[i] en d0
	ldr     d1, [x3, x5, lsl #3] // Cargar Y[i] en d1
	fmul    d2, d10, d0     // Multiplicar Alpha * X[i] -> d2
	fadd    d3, d2, d1      // Sumar Y[i] + (Alpha * X[i]) -> d3
	str     d3, [x4, x5, lsl #3] // Guardar Z[i] en memoria

	// Incrementar índice
	add     x5, x5, 1       // i++

	b       .L2             // Repetir el bucle

.L1:
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

### Cantidad de ciclos por cantidad de vias de cachés 

Los **numCycles** representan el número total de ciclos de reloj utilizados por el procesador para ejecutar un programa o conjunto de instrucciones en una simulación o en un entorno real. Cada ciclo de reloj es una unidad básica de tiempo en la cual el procesador puede realizar operaciones, como ejecutar instrucciones, mover datos entre registros, o interactuar con la memoria.

![Gráficos de resultados](./graficos/grafico_numCycles.png)

Podemos observar que al agregar vías a la caché mejora significativamente su rendimiento, en el caso de 2 vías es el que mejor rendimiento obtuvimos. Pero una vez que se complejiza y aumentamos de más la cantidad de vías, el rendimiento es aún peor que el que teníamos en un principio con una única vía.

### Cantidad de ciclos ociosos

Representa el tiempo durante el cual el procesador está inactivo porque está esperando que se completen ciertas operaciones, como el acceso a la memoria principal o la finalización de una instrucción dependiente. 

![Gráficos de resultados 2](./graficos/grafico_idleCycles.png)

Aqui corroboramos lo dicho anteriormente, la caché de 2 vías es la de mejor rendimiento, ya que observamos en la gráfica que la misma es la que tiene menor cantidad de ciclos ociosos.

### Cantidad de hits en la caché

Son todos los accesos exitosos a la caché, tanto los accesos para escritura como lectura.

![Gráficos de resultados 3](./graficos/grafico_overallHits.png)

Se observa que mientras aumente la cantidad de vías, la cantidad de hits aumenta a la par hasta llegar a las 4 vías donde si se agregan más vías, estas siguen haciendo la misma cantidad de hits. Esto puede decir que la caché llegó a su límite de eficiencia.

### Cantidad de hits de lectura en la caché

Son todos los accesos exitosos a la caché, solamente para los accesos de lectura.

![Gráficos de resultados 4](./graficos/grafico_readReq.hits.png)

Podemos ver la misma relación que con los **overallHits**. Segun aumentamos la cantidad de vías a la caché, esta mejora su rendimiento hasta que llega a la 4 vías, donde aquí llega a su límite de eficiencia.

## e)

Reescribir el código utilizando técnicas estáticas de mejora, como loop unrolling, instrucciones condicionales, etc., para mejorar el rendimiento utilizando una caché de mapeo directo (1 vía) y el tamaño de 32KB para obtener rendimientos similares a los de 2 vías.

## f)

Ejecutar la simulación utilizando el procesador out-of-order con las características de la caché utilizada en el punto e) y comparar los resultados.

## 3. Ejercicio 2

## 2. Ejercicio 3