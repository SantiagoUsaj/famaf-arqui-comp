.data
	N:       .dword 4096	// Number of elements in the vectors
	Alpha:   .dword 2      // scalar value
	
	.bss 
	X: .zero  32768        // vector X(4096)*8
	Y: .zero  32768        // Vector Y(4096)*8
        Z: .zero  32768        // Vector Y(4096)*8

	.arch armv8-a
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	mov	x1, 0
	mov	x0, 0
	bl	m5_dump_stats

	ldr     x0, N
    	ldr     x10, =Alpha
    	ldr     x2, =X
    	ldr     x3, =Y
	ldr     x4, =Z

//---------------------- CODE HERE ------------------------------------

// Cargar Alpha en d10
ldr     d10, [x10]

// Inicializar índice y tamaño del desenrollado
mov     x5, 0               // Índice i
mov     x6, 8               // Desenrollar 8 iteraciones por ciclo

.L2:
    cmp     x5, x0          // Comparar i con N
    b.ge    .L1             // Si i >= N, salir del bucle

    // Prefetch para minimizar conflictos
    prfm    pldl1strm, [x2, x5, lsl #3] // Prefetch X
    prfm    pldl1strm, [x3, x5, lsl #3] // Prefetch Y
    prfm    pldl1strm, [x4, x5, lsl #3] // Prefetch Z

    // Procesar la primera iteración del bucle
    ldr     d0, [x2, x5, lsl #3]
    ldr     d1, [x3, x5, lsl #3]
    fmul    d2, d10, d0
    fadd    d3, d2, d1
    str     d3, [x4, x5, lsl #3]

    // Procesar la segunda iteración
    add     x7, x5, 1       // Calcular índice i + 1
    ldr     d4, [x2, x7, lsl #3]
    ldr     d5, [x3, x7, lsl #3]
    fmul    d6, d10, d4
    fadd    d7, d6, d5
    str     d7, [x4, x7, lsl #3]

    // Procesar la tercera iteración
    add     x8, x5, 2       // Calcular índice i + 2
    ldr     d8, [x2, x8, lsl #3]
    ldr     d9, [x3, x8, lsl #3]
    fmul    d10, d10, d8
    fadd    d11, d10, d9
    str     d11, [x4, x8, lsl #3]

    // Incrementar índice
    add     x5, x5, x6       // i += 8

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
	