.data
    N:       .dword 4096    // Número de elementos en los vectores
    Alpha:   .dword 2       // Valor escalar
    
    .bss 
    X: .zero  32768         // Vector X (4096 elementos * 8 bytes)
    Y: .zero  32768         // Vector Y (4096 elementos * 8 bytes)
    Z: .zero  32768         // Vector Z (4096 elementos * 8 bytes)

    .arch armv8-a
    .text
    .align  2
    .global main
    .type   main, %function

	main:
.LFB6:
    .cfi_startproc
    stp     x29, x30, [sp, -16]!
    .cfi_def_cfa_offset 16
    .cfi_offset 29, -16
    .cfi_offset 30, -8
    mov     x29, sp
	

	mov	x1, 0
	mov	x0, 0
	bl	m5_dump_stats

	// Preparar los registros
    ldr     x0, N           // Tamaño del vector (N)
    ldr     x10, =Alpha     // Dirección de Alpha
    ldr     x2, =X          // Dirección base de X
    ldr     x3, =Y          // Dirección base de Y
    ldr     x4, =Z          // Dirección base de Z
    ldr     d10, [x10]      // Cargar Alpha en d10
    mov     x5, 0           // Inicializar índice i
    mov     x6, 8           // Desenrollar 8 iteraciones por ciclo

.L2:
    cmp     x5, x0          // Comparar i con N
    b.ge    .L1             // Si i >= N, salir del bucle

    // Leer 8 valores consecutivos de X
    mov     x7, x5          // Base temporal
    lsl     x7, x7, #3      // x7 = x5 * 8
    ldr     d0, [x2, x7]         // Cargar X[i]
    add     x7, x7, #8
    ldr     d1, [x2, x7]         // Cargar X[i+1]
    add     x7, x7, #8
    ldr     d2, [x2, x7]         // Cargar X[i+2]
    add     x7, x7, #8
    ldr     d3, [x2, x7]         // Cargar X[i+3]
    add     x7, x7, #8
    ldr     d4, [x2, x7]         // Cargar X[i+4]
    add     x7, x7, #8
    ldr     d5, [x2, x7]         // Cargar X[i+5]
    add     x7, x7, #8
    ldr     d6, [x2, x7]         // Cargar X[i+6]
    add     x7, x7, #8
    ldr     d7, [x2, x7]         // Cargar X[i+7]

    // Leer 8 valores consecutivos de Y
    mov     x7, x5
    lsl     x7, x7, #3      // x7 = x5 * 8
    ldr     d8, [x3, x7]         // Cargar Y[i]
    add     x7, x7, #8
    ldr     d9, [x3, x7]         // Cargar Y[i+1]
    add     x7, x7, #8
    ldr     d10, [x3, x7]        // Cargar Y[i+2]
    add     x7, x7, #8
    ldr     d11, [x3, x7]        // Cargar Y[i+3]
    add     x7, x7, #8
    ldr     d12, [x3, x7]        // Cargar Y[i+4]
    add     x7, x7, #8
    ldr     d13, [x3, x7]        // Cargar Y[i+5]
    add     x7, x7, #8
    ldr     d14, [x3, x7]        // Cargar Y[i+6]
    add     x7, x7, #8
    ldr     d15, [x3, x7]        // Cargar Y[i+7]

    // Operaciones Z[i] = Alpha * X[i] + Y[i] para 8 elementos
    mov     x7, x5
    lsl     x7, x7, #3
    fmul    d16, d0, d10
    fadd    d17, d16, d8
    str     d17, [x4, x7]

    add     x7, x7, #8
    fmul    d16, d1, d10
    fadd    d17, d16, d9
    str     d17, [x4, x7]

    add     x7, x7, #8
    fmul    d16, d2, d10
    fadd    d17, d16, d10
    str     d17, [x4, x7]

    // Incrementar índice
    add     x5, x5, x6      // i += 8
    b       .L2             // Repetir el bucle

.L1:

//---------------------- END CODE -------------------------------------
	mov 	x0, 0
	mov 	x1, 0
	bl	m5_dump_stats
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
    