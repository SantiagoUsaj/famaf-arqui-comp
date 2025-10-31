.text
    .org 0x0000

STUR X1, [X0, #0] // Almacena el valor de X1 en la dirección de memoria apuntada por X0 con un desplazamiento de 0
STUR X2, [X0, #8] // Almacena el valor de X2 en la dirección de memoria apuntada por X0 con un desplazamiento de 8
ADD X3, X4, X5 // Suma los valores de X4 y X5, y almacena el resultado en X3
ADD X4, X5, X8 // Suma los valores de X5 y X8, y almacena el resultado en X4
LDUR X6, [X0, #0] // Carga el valor de la dirección de memoria apuntada por X0 con un desplazamiento de 0 en X6
ADD X7, X6, X8 // Suma los valores de X6 y X8, y almacena el resultado en X7
ADD X1, X2, X3 // Suma los valores de X2 y X3, y almacena el resultado en X1
ADD X2, X9, X10 // Suma los valores de X9 y X10, y almacena el resultado en X2

finloop: CBZ XZR, finloop // Bucle infinito


/*
ROM [0:8] ='{32'hf8000001,
32'hf8008002,
32'h8b050083,
32'h8b0800a4,
32'hf8400006,
32'h8b0800c7,
32'h8b030041,
32'h8b0a0122,
32'hb400001f};

 */