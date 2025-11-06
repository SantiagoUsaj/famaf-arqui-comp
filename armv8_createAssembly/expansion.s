.text
    .org 0x0000

// X0: dirección base de LEDs (0x8000)
// X1: dirección base de switches (0x8008)
// X2: valor leído de switches
// X3: máscara de LEDs encendidos
// X4: constante 1
// X5: retardo
// X6: variable auxiliar
// X7: variable auxiliar
// X8: variable auxiliar
// X10: contador de retardo

ADD X4, XZR, X1
ADD X0, XZR, XZR
ADD X1, XZR, XZR
ADD X2, XZR, XZR
ADD X3, XZR, XZR
ADD X5, XZR, XZR
ADD X6, XZR, XZR
ADD X10, XZR, XZR

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

// X5 = retardo
ADD X5, XZR, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
//LSL X5, X5, #13 // 0x2000
LSL X5, X5, #2 // 0x0002


// Máscara inicial: dos LEDs del centro (0x0180)
ADD X3, XZR, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X3, X3, #1
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X3, X3, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X3, X3, #7
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP


loop:
    STUR X3, [X0, #0]   // Mostrar LEDs encendidos

    // Espera
    ADD X10, XZR, X5
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
wait:
    SUB X10, X10, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X10, check_switch
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ XZR, wait
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

check_switch:
    LDUR X2, [X1, #0]
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    AND X2, X2, X4    // Solo SW0
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X2, expand    // Si no se aprieta, sigue expandiendo
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    // Si se aprieta, reinicia la expansión
    ADD X3, XZR, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    LSL X3, X3, #1
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD X3, X3, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    LSL X3, X3, #7
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ XZR, loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

expand:
    // Expande hacia los extremos
    LSL X7, X3, #1      // X7 = X3 << 1
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    LSR X8, X3, #1      // X8 = X3 >> 1
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ORR X3, X3, X7      // X3 = X3 | X7
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ORR X3, X3, X8      // X3 = X3 | X8
    // Si todos los LEDs están encendidos, reinicia
    ADD X6, XZR, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    LSL X6, X6, #16    // X6 = 0x10000
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    SUB X6, X6, X4     // X6 = 0xFFFF
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    SUB X7, X3, X6     // X7 = X3 - 0xFFFF
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X7, reiniciar  // Si X3 == 0xFFFF, reinicia
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ XZR, loop      // Si no, sigue
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

reiniciar:
    ADD X3, XZR, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    LSL X3, X3, #1
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD X3, X3, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    LSL X3, X3, #7
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ XZR, loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP


/*
ROM [0:121] ='{
32'h8b0103e4,
32'h8b1f03e0,
32'h8b1f03e1,
32'h8b1f03e2,
32'h8b1f03e3,
32'h8b1f03e5,
32'h8b1f03e6,
32'h8b1f03ea,
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
32'h8b0403e5,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f08a5,
32'h8b0403e3,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f0463,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b040063,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f1c63,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000003,
32'h8b0503ea,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb04014a,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400010a,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4ffff3f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8400022,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8a040042,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000282,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0403e3,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f0463,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b040063,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f1c63,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fffb7f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f0467,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd35f0468,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa070063,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa080063,
32'h8b0403e6,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f40c6,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb0400c6,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb060067,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000107,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fff7bf,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0403e3,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f0463,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b040063,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f1c63,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fff5bf,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff};
*/













































