.text
    .org 0x0000

SUB X1, X1, X1         // Instrucción independiente
CBZ X1, etiqueta
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X2, X2         // Instrucción independiente

etiqueta:
ADD X1, X3, X3         // Instrucción independiente
    finloop: CBZ XZR, finloop // Bucle infinito

/*
ROM [0:7] ='{32'hcb010021,
32'hb40000a1,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b020041,
32'h8b030061,
32'hb400001f};
 */