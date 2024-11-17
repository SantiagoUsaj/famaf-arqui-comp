	.data
	N:       .dword 64	
	t_amb:   .dword 25   
	n_iter:  .dword 10    
	fc_x:   .dword 32                    // Fila central
	fc_y:   .dword 32                    // Columna central
	fc_temp:.double 100.0                // Temperatura del centro
	four:   .double 4.0                  // Constante para división
	
	.bss 
	x: .zero  3072        
	x_tmp: .zero  3072    

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

//---------------------- CODE HERE ------------------------------------

    // Inicializar la matriz
    ldr     x0, =N                  // Tamaño de la matriz (64)
    ldr     x0, [x0]                // Cargar el valor de N
    ldr     x1, =x                  // Dirección de x
    ldr     x2, =x_tmp              // Dirección de x_tmp
    ldr     x3, =n_iter             // Dirección de n_iter
    ldr     x3, [x3]                // Cargar el valor de n_iter
    ldr     x4, =t_amb              // Dirección de t_amb
    ldr     d1, [x4]                // Cargar t_amb en d1
    mov     x5, #0                  // i = 0
    mul     x6, x0, x0              // N*N

/* initialize_loop:
    cmp     x5, x6                  // Comparar i con N*N
    bge     end_initialize          // Salir si i >= N*N
    str     d1, [x1, x5, lsl #3]    // Almacenar t_amb en x[i] (8 bytes por celda)
    add     x5, x5, #1              // Incrementar i
    b       initialize_loop         // Repetir */

end_initialize:
    // Establecer x[fc_x*N + fc_y] = fc_temp
    ldr     x16, =fc_x              // Dirección de fc_x
    ldr     x16, [x16]              // Cargar fc_x en x16
    ldr     x17, =fc_y              // Dirección de fc_y
    ldr     x17, [x17]              // Cargar fc_y en x17
    ldr     x18, =N                 // Dirección de N
    ldr     x18, [x18]              // Cargar N en x18
    mul     x16, x16, x18           // fc_x * N
    add     x16, x16, x17           // fc_x * N + fc_y
    ldr     x19, =fc_temp           // Dirección de fc_temp
    ldr     d5, [x19]               // Cargar fc_temp en d5
    ldr     x20, =x                 // Dirección de x
    str     d5, [x20, x16, lsl #3]  // Almacenar fc_temp en x[fc_x * N + fc_y]

iterate_matrix:
    mov     x7, #0                  // k = 0

outer_loop:
    cmp     x7, x3                  // Comparar k con n_iter
    bge     end_iterate             // Salir si k >= n_iter
    mov     x8, #0                  // i = 0

row_loop:
    cmp     x8, x0                  // Comparar i con N
    bge     next_iteration          // Salir si i >= N
    mov     x9, #0                  // j = 0

column_loop:
    cmp     x9, x0                  // Comparar j con N
    bge     next_row                // Salir si j >= N
    mul     x10, x8, x0             // i * N
    add     x10, x10, x9            // i * N + j
    mul     x11, x16, x0            // fc_x * N
    add     x11, x11, x17           // fc_x * N + fc_y
    cmp     x10, x11                // Comparar (i*N + j) con (fc_x*N + fc_y)
    beq     skip_cell               // Saltar si son iguales

    // Calcular la suma de los vecinos
    fmov    d2, d0                  // sum = 0
    add     x12, x8, #1             // i + 1
    cmp     x12, x0                 // Comparar i + 1 con N
    bge     add_t_amb1              // Si i + 1 >= N, usar t_amb
    mul     x13, x12, x0            // (i + 1) * N
    add     x13, x13, x9            // (i + 1) * N + j
    ldr     d3, [x1, x13, lsl #3]   // Cargar x[(i + 1)*N + j]
    b       add_sum1

add_t_amb1:
    ldr     d3, [x4]                // Cargar t_amb en d3

add_sum1:
    fadd    d2, d2, d3              // sum = sum + x[(i + 1)*N + j] o t_amb

    sub     x12, x8, #1             // i - 1
    cmp     x12, #0                 // Comparar i - 1 con 0
    blt     add_t_amb2              // Si i - 1 < 0, usar t_amb
    mul     x13, x12, x0            // (i - 1) * N
    add     x13, x13, x9            // (i - 1) * N + j
    ldr     d3, [x1, x13, lsl #3]   // Cargar x[(i - 1)*N + j]
    b       add_sum2

add_t_amb2:
    ldr     d3, [x4]                // Cargar t_amb en d3

add_sum2:
    fadd    d2, d2, d3              // sum = sum + x[(i - 1)*N + j] o t_amb

    add     x12, x9, #1             // j + 1
    cmp     x12, x0                 // Comparar j + 1 con N
    bge     add_t_amb3              // Si j + 1 >= N, usar t_amb
    mul     x13, x8, x0             // i * N
    add     x13, x13, x12           // i * N + (j + 1)
    ldr     d3, [x1, x13, lsl #3]   // Cargar x[i*N + j + 1]
    b       add_sum3

add_t_amb3:
    ldr     d3, [x4]                // Cargar t_amb en d3

add_sum3:
    fadd    d2, d2, d3              // sum = sum + x[i*N + j + 1] o t_amb

    sub     x12, x9, #1             // j - 1
    cmp     x12, #0                 // Comparar j - 1 con 0
    blt     add_t_amb4              // Si j - 1 < 0, usar t_amb
    mul     x13, x8, x0             // i * N
    add     x13, x13, x12           // i * N + (j - 1)
    ldr     d3, [x1, x13, lsl #3]   // Cargar x[i*N + j - 1]
    b       add_sum4

add_t_amb4:
    ldr     d3, [x4]                // Cargar t_amb en d3

add_sum4:
    fadd    d2, d2, d3              // sum = sum + x[i*N + j - 1] o t_amb

    // Dividir la suma por 4 y almacenar en x_tmp
    ldr     x14, =x_tmp             // Dirección de x_tmp
    ldr     x15, =four              // Dirección de la constante 4.0
    ldr     d4, [x15]               // Cargar 4.0 en d4
    fdiv    d2, d2, d4              // sum / 4
    str     d2, [x14, x10, lsl #3]  // Almacenar sum / 4 en x_tmp[i*N + j]

skip_cell:
    add     x9, x9, #1              // Incrementar j
    b       column_loop             // Repetir para la siguiente columna

next_row:
    add     x8, x8, #1              // Incrementar i
    b       row_loop                // Repetir para la siguiente fila

next_iteration:
    ldr     x1, =x                  // Dirección de x
    ldr     x14, =x_tmp             // Dirección de x_tmp
    mov     x15, #0                 // i = 0

copy_loop:
    cmp     x15, x6                 // Comparar i con N*N
    bge     end_copy                // Salir si i >= N*N
    mul     x10, x8, x0             // fc_x * N
    add     x10, x10, x9            // fc_x * N + fc_y
    cmp     x15, x10                // Comparar i con fc_x*N + fc_y
    beq     skip_copy               // Saltar si son iguales
    ldr     d2, [x14, x15, lsl #3]  // Cargar x_tmp[i]
    str     d2, [x1, x15, lsl #3]   // Almacenar en x[i]

skip_copy:
    add     x15, x15, #1            // Incrementar i
    b       copy_loop               // Repetir

end_copy:
    add     x7, x7, #1              // Incrementar k
    b       outer_loop              // Repetir para la siguiente iteración

end_iterate:  
    

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
