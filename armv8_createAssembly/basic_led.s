.text
    .org 0x0000

// X0: dirección base de LEDs (0x8000)
// X1: dirección base de switches (0x8008)
// X2: valor leído de switches
// X3: máscara para todos los LEDs encendidos (0xFFFF)
// X4: constante 1

ADD X4, XZR, X1
ADD X0, XZR, XZR
ADD X1, XZR, XZR
ADD X2, XZR, XZR
ADD X3, XZR, XZR

// X0 = 0x8000
ADD X0, X0, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X0, X0, #15

// X3 = 0xFFFF (todos los LEDs)
ADD X3, XZR, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X3, X3, #16
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
SUB X3, X3, X4
 
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X3, [X0, #0]   // Prende todos los LEDs
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
   
finloop: CBZ XZR, finloop // Bucle infinito


/*
ROM [0:21] ='{
32'h8b0103e4,
32'h8b1f03e0,
32'h8b1f03e1,
32'h8b1f03e2,
32'h8b1f03e3,
32'h8b040000,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f3c00,
32'h8b0403e3,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f4063,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb040063,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000003,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400001f};


 */

