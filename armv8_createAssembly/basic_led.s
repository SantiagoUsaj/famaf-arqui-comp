    .text
    .org 0x0000

// X10: dirección base de LEDs (0x8000)
// X11: dirección base de switches (0x8008)
// X12: máscara LED encendido
// X13: dirección (0=izq, 1=der)
// X14: retardo parametrizable
// X15: valor leído de switches
// X17: máscara para el límite izquierdo (0x8000)
// X18: máscara para el límite derecho (0x0001)
// X19: variable auxiliar

LSL X10, X1, #15      // X10 = 0x8000
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

ADD X11, X10, #8      // X11 = 0x8008
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

ADD X12, X0, X1      // Prendo primer led
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

STUR X12, [X10, #0]   // Escribir LED encendido
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

ADD X12, X12, X2      // Prendo siguiente led
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

STUR X12, [X10, #0]   // Escribir LED encendido
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

finloop: CBZ XZR, finloop // Bucle infinito

/*
ROM [0:18] ='{
32'hd37f3c2a,
32'h8b1f03ff,
32'h8b1f03ff,
32'h9100214b,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b01000c,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf800014c,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b02018c,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf800014c,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400001f};
 */