.text
    .org 0x0000

ADD X1, X2, X3         // Instrucción independiente
STUR X1, [X0, #0]      
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LDUR X2, [X0, #0]      

    finloop: CBZ XZR, finloop // Bucle infinito

/*
ROM [0:6] ='{32'h8b030041,
32'hf8000001,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8400002,
32'hb400001f};

 */