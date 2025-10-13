.text
    .org 0x0000

STUR X1, [X0, #0] // Almacena el valor de X1 en la dirección de memoria apuntada por X0 con un desplazamiento de 0
STUR X2, [X0, #8] // Almacena el valor de X2 en la dirección de memoria apuntada por X0 con un desplazamiento de 8
STUR X3, [X0, #16] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 16
LSL X4, X4, #2 // Desplaza el valor de X4 a la izquierda 2 bits (equivalente a multiplicar por 4)
LSR X6, X6, #1 // Desplaza el valor de X6 a la derecha 1 bit (equivalente a dividir por 2)
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #24] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 24
STUR X6, [X0, #32] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 32
finloop: CBZ XZR, finloop // Bucle infinito


/*
ROM [0:9] ='{32'hf8000001,
32'hf8008002,
32'hf8010003,
32'hd3620884,
32'hd34104c6,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8018004,
32'hf8020006,
32'hb400001f};
 */

/*
LSL X4, X4, #2
11010011011_00010_000010_00100_00100,
opcode(11) | Rm(5) | shamt(6) | Rn(5) | Rd(5)

1101_0011_0110_0010_0000_1000_1000_0100,

LSR X6, X6, #1
11010011010_00001_000001_00110_00110,
opcode(11) | Rm(5) | shamt(6) | Rn(5) | Rd(5)

1101_0011_0100_0001_0000_0100_1100_0110,
*/
