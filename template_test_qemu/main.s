.section .data
vector: 
    .space 4000                // Espacio para 1000 elementos (4 bytes cada uno)
    len: .word 1000            // Longitud del vector

.section .rodata
random_const:
    .word 1103515245           // Constante del generador pseudoaleatorio

.section .text
.global _start

_start:
    // Inicialización del vector con valores aleatorios (simulación)
    ldr x0, =vector            // Dirección base del vector
    mov x1, 1000               // Número de elementos
    bl init_vector             // Llama a la función para inicializar el vector

    // Ordenamiento por burbuja
    ldr x0, =vector            // Dirección base del vector
    mov x1, 1000               // Longitud del vector
    bl bubble_sort             // Llama al algoritmo de ordenamiento

    // Finaliza la ejecución
    mov x8, 93                 // syscall exit
    mov x0, 0                  // Código de salida 0
    svc 0

// Función para inicializar el vector con valores aleatorios
init_vector:
    mov x2, 42                 // Semilla inicial
1: 
    ldr w3, random_const       // Carga la constante desde la memoria
    mul x2, x2, x3             // Genera un número pseudoaleatorio
    add x2, x2, 123          // Ajusta la constante aditiva
    and x2, x2, 0x7FFFFFFF     // Limita el valor al rango positivo

    str w2, [x0], #4           // Almacena el valor en el vector y avanza
    sub x1, x1, 1              // Decrementa el contador
    cbnz x1, 1b                // Si x1 != 0, repite el ciclo
    ret

// Algoritmo de ordenamiento por burbuja
bubble_sort:
    sub x1, x1, 1              // Tamaño del vector - 1
1:
    mov x2, x1                 // Resetea el índice del bucle interno
    mov x3, 0                  // Bandera para verificar si hubo intercambios
2:
    sub x4, x2, 1              // Índice para el elemento anterior
    add x5, x0, x2, LSL #2     // Dirección del elemento actual
    add x6, x0, x4, LSL #2     // Dirección del elemento anterior

    ldr w7, [x5]               // Carga el elemento actual
    ldr w8, [x6]               // Carga el elemento anterior
    cmp w7, w8                 // Compara ambos elementos
    bge 3f                     // Si están en orden, salta
    str w8, [x5]               // Intercambia los valores
    str w7, [x6]
    mov x3, 1                  // Marca que hubo un intercambio
3:
    sub x2, x2, 1              // Decrementa el índice interno
    cbnz x2, 2b                // Si no llegó al inicio, repite

    cbz x3, 4f                 // Si no hubo intercambios, termina
    sub x1, x1, 1              // Reduce el rango del bucle externo
    cbnz x1, 1b                // Si no llegó al final, repite
4:
    ret
