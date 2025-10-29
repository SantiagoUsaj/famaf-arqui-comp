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
// X1 = 0x8008
ADD X1, X1, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X1, X1, #15
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X8

// X3 = 0xFFFF (todos los LEDs)
ADD X3, XZR, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X3, X3, #16
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
SUB X3, X3, X4

loop:
    LDUR X2, [X1, #0]
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    AND X2, X2, X4      // Solo SW0
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X2, leds_off
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    STUR X3, [X0, #0]   // Prende todos los LEDs
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ XZR, loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
leds_off:
    STUR XZR, [X0, #0]  // Apaga todos los LEDs
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ XZR, loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP


/*
ROM [0:46] ='{
32'h8b0103e4,
32'h8b1f03e0,
32'h8b1f03e1,
32'h8b1f03e2,
32'h8b1f03e3,
32'h8b040000,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f3c00,
32'h8b040021,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f3c21,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b080021,
32'h8b0403e3,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f4063,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb040063,
32'hf8400022,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8a040042,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000162,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000003,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fffe7f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf800001f,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fffd9f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff};

 */


