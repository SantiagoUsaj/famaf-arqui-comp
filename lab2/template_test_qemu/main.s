.data
N:       .dword 1000
Array:   .space 8000  // 1000 elementos de 8 bytes (double)

.text
.global _start

_start:
    // Inicializar el arreglo
    ldr     x0, =Array
    ldr     x6, =N
    ldr     x6, [x6]
    mov     x1, 1234
    mov     x5, 0

    // Parámetros LCG
    movz    x2, 0x19, lsl 16
    movk    x2, 0x660D, lsl 0
    movz    x3, 0x3C6E, lsl 16
    movk    x3, 0xF35F, lsl 0
    movz    x4, 0xFFFF, lsl 16
    movk    x4, 0xFFFF, lsl 0

random_array:
    // Calculate the next pseudorandom value
    mul x1, x1, x2          // x1 = x1 * multiplier
    add x1, x1, x3          // x1 = x1 + increment
    and x1, x1, x4          // x1 = x1 % modulus

    str x1, [x0, x5, lsl #3] // Store the updated seed back to memory
    add x5, x5, 1           // Increment array counter
    cmp x5, x6              // Verify if process ended
    b.lt random_array

    // Ordenamiento por burbuja
    ldr x0, =Array          // Load array base address to x0
    ldr x6, =N              // Load the number of elements into x6
    ldr x6, [x6]
    sub x6, x6, 1           // N - 1

bubble_sort:
    mov x1, #0              // i = 0

outer_loop:
    cmp x1, x6              // Compare i with N-1
    cset x7, lt             // Set x7 to 1 if i < N-1, otherwise 0
    cbz x7, end_sort        // If x7 is 0, end sorting

    mov x2, #0              // j = 0

inner_loop:
    cmp x2, x6              // Compare j with N-1
    cset x7, lt             // Set x7 to 1 if j < N-1, otherwise 0
    cbz x7, next_outer      // If x7 is 0, go to next outer loop

    lsl x3, x2, #3          // j * 8
    add x4, x0, x3          // Address of Array[j]
    ldr x8, [x4]            // Load Array[j] into x8
    ldr x9, [x4, #8]        // Load Array[j+1] into x9

    cmp x8, x9              // Compare Array[j] with Array[j+1]
    csel x10, x8, x9, le    // Select the smaller value
    csel x11, x9, x8, le    // Select the larger value

    str x10, [x4]           // Store the smaller value in Array[j]
    str x11, [x4, #8]       // Store the larger value in Array[j+1]

    add x2, x2, 1           // Increment j
    b inner_loop            // Repeat inner loop

next_outer:
    add x1, x1, 1           // Increment i
    b outer_loop            // Repeat outer loop

end_sort:
    // Fin del programa
    mov     x0, #0                  // Código de salida 0
    mov     x8, #93                 // syscall: exit
    svc     #0
