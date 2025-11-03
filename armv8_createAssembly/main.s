.text
    .org 0x0000

// Inicialización (puedes cargar valores en X1, X2, X3 desde el testbench o memoria)
ADD X4, X1, X2      // X4 = X1 + X2
ADD X5, X4, X3      // X5 = X4 + X3 (debe hacer forwarding de X4)
ADD X6, X5, X1      // X6 = X5 + X1 (debe hacer forwarding de X5)
ADD X9, X8, X4      // X9 = X8 + X4 (debe hacer forwarding de X8 y X4)

finloop: CBZ XZR, finloop // Bucle infinito
