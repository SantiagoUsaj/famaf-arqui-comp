	.data
	N:       .dword 4096	// Number of elements in the vectors
	Alpha:   .dword 2      // scalar value
	Cero:    .dword 0      // Constante 0
	Uno:     .dword 1      // Constante 1
	
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
    	ldr     d10, =Alpha
    	ldr     x2, =X
    	ldr     x3, =Y
	ldr     x4, =Z

//---------------------- CODE HERE ------------------------------------

// En el vide de presentación dice usar instrucciones flotantes pero qsy ya esta todo con registros enteros

	ldr 	x5, =Cero      // Cargar el valor de Cero en x5
	ldr 	x11, =Uno      // Cargar el valor de Uno en x11
	ldr 	x7, = N        // Cargar el valor de N en x7
.L2:
	cmp x5, x7          // Comparar x5 con N
	b.ge .L1            // Si x5 >= N, salir del bucle

	ldr 	d6, [x2, x5, lsl #3] // Cargar el valor de X[i] en x6
	ldr 	d8, [x3, x5, lsl #3] // Cargar el valor de Y[i] en x8
	fmul 	d6, d6, d10     // Multiplicar X[i] por Alpha
	fadd 	d8, d8, d6      // Sumar Y[i] + Alpha*X[i]
	str 	d8, [x4, x5, lsl #3] // Guardar el valor en Z[i]

	add x5, x5, x11     // Incrementar x5
	b .L2               // Volver al bucle
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
