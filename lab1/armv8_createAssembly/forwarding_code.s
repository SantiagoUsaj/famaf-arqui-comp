.text
    .org 0x0000

ADD X4, X1, X2   // X4 = 3
ADD X5, X3, X1   // X5 = 4
ADD X6, X4, X5   // X6 = 7
SUB X3, X6, X2   // X3 = 5

finloop: CBZ XZR, finloop // Bucle infinito

/*
ROM [0:4] ='{32'h8b020024,
32'h8b010065,
32'h8b050086,
32'hcb0200c3,
32'hb400001f};

 */