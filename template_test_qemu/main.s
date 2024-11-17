	.data
N:       .dword 10	// Número de elementos en los vectores
Alpha:   .double 2.0  // Escalar Alpha en punto flotante
X:       .dword 0x3FF0000000000000, 0x4000000000000000, 0x4008000000000000, 0x4010000000000000, 0x4014000000000000, 0x3FF0000000000000, 0x4000000000000000, 0x4008000000000000, 0x4010000000000000, 0x4014000000000000
Y:       .dword 0x3FF0000000000000, 0x4000000000000000, 0x4008000000000000, 0x4010000000000000, 0x4014000000000000, 0x3FF0000000000000, 0x4000000000000000, 0x4008000000000000, 0x4010000000000000, 0x4014000000000000
Z:       .space 80  // Espacio para los resultados (10 valores * 8 bytes)

	.text
	.global _start

_start:
	// Habilitar el coprocesador flotante (FPU)
	mrs     x1, cpacr_el1
	mov     x0, #(3 << 20)
	orr     x0, x1, x0
	msr     cpacr_el1, x0

	// Inicialización
	ldr     x4, =N          // Dirección de N
	ldr     x4, [x4]        // Cargar el valor de N en x4
	ldr     x10, =Alpha     // Dirección de Alpha
	ldr     d10, [x10]      // Cargar Alpha en d10
	ldr     x1, =X          // Dirección del vector X
	ldr     x2, =Y          // Dirección del vector Y
	ldr     x3, =Z          // Dirección del vector Z

	mov     x5, 0           // Inicializar índice i

.L2:
	cmp     x5, x4          // Comparar i con N
	b.ge    .L1             // Si i >= N, salir del bucle

	// Operación Z[i] = Alpha * X[i] + Y[i]
	ldr     d0, [x1, x5, lsl #3] // Cargar X[i] en d0
	ldr     d1, [x2, x5, lsl #3] // Cargar Y[i] en d1
	fmul    d2, d10, d0     // Multiplicar Alpha * X[i] -> d2
	fadd    d3, d2, d1      // Sumar Y[i] + (Alpha * X[i]) -> d3
	str     d3, [x3, x5, lsl #3] // Guardar Z[i] en memoria

	// Incrementar índice
	add     x5, x5, 1       // i++

	b       .L2             // Repetir el bucle

.L1:
	// Salida del programa
	mov     x8, 93          // syscall: exit
	mov     x0, 0           // Código de salida
	svc     0
