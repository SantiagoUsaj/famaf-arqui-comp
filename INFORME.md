# Arquitectura de Computadoras - FAMAF - UNC

## Lab 1: Implementación del procesador LEGv8 con pipeline de 5 etapas

Nombre y apellido
Integrante 1: Angeli Mateo
Integrante 2: Murphy Ronnie
Integrante 3: Usaj Santiago

Codigo con NOPS:

    .text
    .org 0x0000

STUR X1, [X0, #0] // Almacena el valor de X1 en la dirección de memoria apuntada por X0 con un desplazamiento de 0
STUR X2, [X0, #8] // Almacena el valor de X2 en la dirección de memoria apuntada por X0 con un desplazamiento de 8
STUR X3, [X0, #16] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 16
ADD X3, X4, X5 // Suma los valores de X4 y X5, y almacena el resultado en X3
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X3, [X0, #24] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 24
SUB X3, X4, X5 // Resta el valor de X5 de X4, y almacena el resultado en X3
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X3, [X0, #32] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 32
SUB X4, XZR, X10 // Resta el valor de X10 de 0, y almacena el resultado en X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #40] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 40
ADD X4, X3, X4 // Suma los valores de X3 y X4, y almacena el resultado en X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #48] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 48
SUB X5, X1, X3 // Resta el valor de X3 de X1, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #56] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 56
AND X5, X10, XZR // Realiza una operación AND entre X10 y 0, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #64] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 64
AND X5, X10, X3 // Realiza una operación AND entre X10 y X3, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #72] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 72
AND X20, X20, X20 // Realiza una operación AND entre X20 y X20, y almacena el resultado en X20
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X20, [X0, #80] // Almacena el valor de X20 en la dirección de memoria apuntada por X0 con un desplazamiento de 80
ORR X6, X11, XZR // Realiza una operación OR entre X11 y 0, y almacena el resultado en X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X6, [X0, #88] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 88
ORR X6, X11, X3 // Realiza una operación OR entre X11 y X3, y almacena el resultado en X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X6, [X0, #96] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 96
LDUR X12, [X0, #0] // Carga el valor de la dirección de memoria apuntada por X0 con un desplazamiento de 0 en X12
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X7, X12, XZR // Suma el valor de X12 y 0, y almacena el resultado en X7
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X7, [X0, #104] // Almacena el valor de X7 en la dirección de memoria apuntada por X0 con un desplazamiento de 104
STUR X12, [X0, #112] // Almacena el valor de X12 en la dirección de memoria apuntada por X0 con un desplazamiento de 112
ADD XZR, X13, X14 // Suma los valores de X13 y X14, y almacena el resultado en XZR (efectivamente no hace nada útil)
STUR XZR, [X0, #120] // Almacena el valor de XZR en la dirección de memoria apuntada por X0 con un desplazamiento de 120
CBZ X0, L1 // Compara X0 con 0 y salta a la etiqueta L1 si es igual a 0
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X21, [X0, #128] // Almacena el valor de X21 en la dirección de memoria apuntada por X0 con un desplazamiento de 128
L1: STUR X21, [X0, #136] // Almacena el valor de X21 en la dirección de memoria apuntada por X0 con un desplazamiento de 136
ADD X2, XZR, X1 // Suma el valor de X1 y 0, y almacena el resultado en X2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
L2: SUB X2, X2, X1 // Resta el valor de X1 de X2, y almacena el resultado en X2
ADD X24, XZR, X1 // Suma el valor de X1 y 0, y almacena el resultado en X24
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X24, [X0, #144] // Almacena el valor de X24 en la dirección de memoria apuntada por X0 con un desplazamiento de 144
ADD X0, X0, X8 // Suma el valor de X8 a X0, y almacena el resultado en X0
CBZ X2, L2 // Compara X2 con 0 y salta a la etiqueta L2 si es igual a 0
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X30, [X0, #144] // Almacena el valor de X30 en la dirección de memoria apuntada por X0 con un desplazamiento de 144
ADD X30, X30, X30 // Suma el valor de X30 a sí mismo, y almacena el resultado en X30
SUB X21, XZR, X21 // Resta el valor de X21 de 0, y almacena el resultado en X21
ADD XZR, XZR, XZR // NOP
ADD X30, X30, X20 // Suma el valor de X20 a X30, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LDUR X25, [X30, #-8] // Carga el valor de la dirección de memoria apuntada por X30 con un desplazamiento de -8 en X25
ADD X30, X30, X30 // Suma el valor de X30 a sí mismo, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X30, X30, X16 // Suma el valor de X16 a X30, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X25, [X30, #-8] // Almacena el valor de X25 en la dirección de memoria apuntada por X30 con un desplazamiento de -8
finloop: CBZ XZR, finloop // Bucle infinito

Se modifico processor_arm.sv, imem.sv y regfile para implementar el funcionamiento del codigo con los NOPS
