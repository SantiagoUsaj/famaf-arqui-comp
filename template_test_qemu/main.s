.data
N:      .word 64                    // Tamaño de la matriz
n_iter: .word 10                    // Número de iteraciones
fc_x:   .word 32                    // Fila central
fc_y:   .word 32                    // Columna central
fc_temp:.double 100.0               // Temperatura del centro
t_amb:  .double 20.0                // Temperatura ambiente
x:      .space 32768                // Matriz x (64x64 = 4096 elementos, cada uno de 8 bytes)
x_tmp:  .space 32768                // Matriz temporal (igual tamaño que x)
zero:   .double 0.0                 // Constante para inicialización
four:   .double 4.0                 // Constante para división

    .text
    .global _start

_start:
    // Habilitar el coprocesador flotante (FPU)
	mrs     x1, cpacr_el1
	mov     x0, #(3 << 20)
	orr     x0, x1, x0
	msr     cpacr_el1, x0
    // Inicializar la matriz
    LDR     X0, =N                  // Tamaño de la matriz (64)
    LDR     X1, =t_amb              // Dirección de t_amb
    LDR     D1, [X1]                // Cargar t_amb en D1
    LDR     X2, =x                  // Dirección de x
    MOV     X3, #0                  // i = 0
    MUL     X4, X0, X0              // N*N

initialize_loop:
    CMP     X3, X4                  // Comparar i con N*N
    BGE     end_initialize          // Salir si i >= N*N
    STR     D1, [X2, X3, LSL #3]    // Almacenar t_amb en x[i] (8 bytes por celda)
    ADD     X3, X3, #1              // Incrementar i
    B       initialize_loop         // Repetir

end_initialize:
    // Establecer x[fc_x*N + fc_y] = fc_temp
    LDR     X0, =fc_x               // Dirección de fc_x
    LDR     X1, [X0]                // Cargar fc_x en X1
    LDR     X0, =fc_y               // Dirección de fc_y
    LDR     X2, [X0]                // Cargar fc_y en X2
    LDR     X3, =N                  // Tamaño de la matriz
    MUL     X1, X1, X3              // fc_x * N
    ADD     X1, X1, X2              // fc_x * N + fc_y
    LDR     X4, =fc_temp            // Dirección de fc_temp
    LDR     D0, [X4]                // Cargar fc_temp en D0
    LDR     X5, =x                  // Dirección de x
    STR     D0, [X5, X1, LSL #3]    // Almacenar fc_temp en x[fc_x * N + fc_y]

iterate_matrix:
    LDR     X6, =n_iter             // Dirección de n_iter
    LDR     X6, [X6]                // Cargar n_iter en X6
    MOV     X7, #0                  // k = 0

outer_loop:
    CMP     X7, X6                  // Comparar k con n_iter
    BGE     end_iterate             // Salir si k >= n_iter
    MOV     X8, #0                  // i = 0

row_loop:
    CMP     X8, X0                  // Comparar i con N
    BGE     next_iteration          // Salir si i >= N
    MOV     X9, #0                  // j = 0

column_loop:
    CMP     X9, X0                  // Comparar j con N
    BGE     next_row                // Salir si j >= N
    MUL     X10, X8, X0             // i * N
    ADD     X10, X10, X9            // i * N + j
    MUL     X11, X8, X0             // fc_x * N
    ADD     X11, X11, X9            // fc_x * N + fc_y
    CMP     X10, X11                // Comparar (i*N + j) con (fc_x*N + fc_y)
    BEQ     skip_cell               // Saltar si son iguales

    // Calcular la suma de los vecinos
    FMOV    D2, D0                  // sum = 0
    ADD     X12, X8, #1             // i + 1
    CMP     X12, X0                 // Comparar i + 1 con N
    BGE     add_t_amb1              // Si i + 1 >= N, usar t_amb
    MUL     X13, X12, X0            // (i + 1) * N
    ADD     X13, X13, X9            // (i + 1) * N + j
    LDR     D3, [X2, X13, LSL #3]   // Cargar x[(i + 1)*N + j]
    B       add_sum1

add_t_amb1:
    LDR     D3, [X1]                // Cargar t_amb en D3

add_sum1:
    FADD    D2, D2, D3              // sum = sum + x[(i + 1)*N + j] o t_amb

    SUB     X12, X8, #1             // i - 1
    CMP     X12, #0                 // Comparar i - 1 con 0
    BLT     add_t_amb2              // Si i - 1 < 0, usar t_amb
    MUL     X13, X12, X0            // (i - 1) * N
    ADD     X13, X13, X9            // (i - 1) * N + j
    LDR     D3, [X2, X13, LSL #3]   // Cargar x[(i - 1)*N + j]
    B       add_sum2

add_t_amb2:
    LDR     D3, [X1]                // Cargar t_amb en D3

add_sum2:
    FADD    D2, D2, D3              // sum = sum + x[(i - 1)*N + j] o t_amb

    ADD     X12, X9, #1             // j + 1
    CMP     X12, X0                 // Comparar j + 1 con N
    BGE     add_t_amb3              // Si j + 1 >= N, usar t_amb
    MUL     X13, X8, X0             // i * N
    ADD     X13, X13, X12           // i * N + (j + 1)
    LDR     D3, [X2, X13, LSL #3]   // Cargar x[i*N + j + 1]
    B       add_sum3

add_t_amb3:
    LDR     D3, [X1]                // Cargar t_amb en D3

add_sum3:
    FADD    D2, D2, D3              // sum = sum + x[i*N + j + 1] o t_amb

    SUB     X12, X9, #1             // j - 1
    CMP     X12, #0                 // Comparar j - 1 con 0
    BLT     add_t_amb4              // Si j - 1 < 0, usar t_amb
    MUL     X13, X8, X0             // i * N
    ADD     X13, X13, X12           // i * N + (j - 1)
    LDR     D3, [X2, X13, LSL #3]   // Cargar x[i*N + j - 1]
    B       add_sum4

add_t_amb4:
    LDR     D3, [X1]                // Cargar t_amb en D3

add_sum4:
    FADD    D2, D2, D3              // sum = sum + x[i*N + j - 1] o t_amb

    // Dividir la suma por 4 y almacenar en x_tmp
    LDR     X14, =x_tmp             // Dirección de x_tmp
    LDR     X15, =four              // Dirección de la constante 4.0
    LDR     D4, [X15]               // Cargar 4.0 en D4
    FDIV    D2, D2, D4              // sum / 4
    STR     D2, [X14, X10, LSL #3]  // Almacenar sum / 4 en x_tmp[i*N + j]

skip_cell:
    ADD     X9, X9, #1              // Incrementar j
    B       column_loop             // Repetir para la siguiente columna

next_row:
    ADD     X8, X8, #1              // Incrementar i
    B       row_loop                // Repetir para la siguiente fila

next_iteration:
    LDR     X2, =x                  // Dirección de x
    LDR     X14, =x_tmp             // Dirección de x_tmp
    MOV     X15, #0                 // i = 0

copy_loop:
    CMP     X15, X4                 // Comparar i con N*N
    BGE     end_copy                // Salir si i >= N*N
    MUL     X10, X8, X0             // fc_x * N
    ADD     X10, X10, X9            // fc_x * N + fc_y
    CMP     X15, X10                // Comparar i con fc_x*N + fc_y
    BEQ     skip_copy               // Saltar si son iguales
    LDR     D2, [X14, X15, LSL #3]  // Cargar x_tmp[i]
    STR     D2, [X2, X15, LSL #3]   // Almacenar en x[i]

skip_copy:
    ADD     X15, X15, #1            // Incrementar i
    B       copy_loop               // Repetir

end_copy:
    ADD     X7, X7, #1              // Incrementar k
    B       outer_loop              // Repetir para la siguiente iteración

end_iterate:
    // Fin del programa
    MOV     X0, #0                  // Código de salida 0
    MOV     X8, #93                 // syscall: exit
    SVC     #0
	