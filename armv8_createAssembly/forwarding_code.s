.text
    .org 0x0000

// Inicialización (puedes cargar valores en X1, X2, X3 desde el testbench o memoria)
ADD X4, X1, X2      // X4 = X1 + X2
ADD X5, X4, X3      // X5 = X4 + X3 (debe hacer forwarding de X4)
SUB X6, X5, X1      // X6 = X5 - X1 (debe hacer forwarding de X5)
AND X7, X6, X2      // X7 = X6 & X2 (debe hacer forwarding de X6)
ORR X8, X7, X3      // X8 = X7 | X3 (debe hacer forwarding de X7)
ADD X9, X8, X4      // X9 = X8 + X4 (debe hacer forwarding de X8 y X4)
LSL X10, X9, #1     // X10 = X9 << X1 (debe hacer forwarding de X9)
LSR X11, X10, #2    // X11 = X10 >> X2 (debe hacer forwarding de X10)

finloop: CBZ XZR, finloop // Bucle infinito

/*
ROM [0:8] ='{
32'h8b020024,
32'h8b030085,
32'hcb0100a6,
32'h8a0200c7,
32'haa0300e8,
32'h8b040109,
32'hd37f052a,
32'hd35f094b,
32'hb400001f};

 */