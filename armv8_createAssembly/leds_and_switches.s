.text
    .org 0x0000

// X0: dirección base de LEDs (0x8000)
// X1: dirección base de switches (0x8008)
// X2: valor leído de switches
// X3: máscara para todos los LEDs encendidos (0xFFFF)
// X4: constante 1
// X5: máscara para todos los LEDs pares (0x5555)
// X6: variable auxiliar
// X7: variable auxiliar
// X8: variable auxiliar
// X9: variable auxiliar
// X10: retardo
// X11: máscara de LEDs encendidos auxiliar (para expansión)
// X12: máscara SW1 (0x0002)
// X13: mascara SW2 (0x0004)

// Inicialización
ADD X4, XZR, X1
ADD X12, XZR, X2
ADD X13, XZR, X4
ADD X0, XZR, XZR
ADD X1, XZR, XZR
ADD X2, XZR, XZR
ADD X3, XZR, XZR
ADD X5, XZR, XZR
ADD X6, XZR, XZR
ADD X7, XZR, XZR
ADD X9, XZR, XZR
ADD X10, XZR, XZR
ADD X11, XZR, XZR

// X0 = 0x8000
LSL X0, X4, #15

// X1 = 0x8008
LSL X1, X4, #15
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X8

// X3 = 0xFFFF (todos los LEDs)
LSL X3, X4, #16
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
SUB X3, X3, X4

// X5 = 0x5555 (pares)
LSL X5, X4, #2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X5, X5, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X5, X5, #2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X5, X5, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X5, X5, #2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X5, X5, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X5, X5, #2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X5, X5, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X5, X5, #2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X5, X5, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X5, X5, #2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X5, X5, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X5, X5, #2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X5, X5, X4

// X10 = retardo
LSL X10, X4, #2 // 0x0004

// X11 = máscara inicial expansión (0x0180)
LSL X11, X4, #1
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X11, X11, X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X11, X11, #7
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

main_loop:
    LDUR X2, [X1, #0]
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    // Chequear SW0 (bit 0)
    AND X6, X2, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X6, check_sw1
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    STUR X3, [X0, #0] // Todos los LEDs
    CBZ XZR, main_loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

check_sw1:
    // Chequear SW1 (bit 1)
    AND X6, X2, X12
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X6, check_sw2
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    STUR X5, [X0, #0] // Pares
    CBZ XZR, main_loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

check_sw2:
    // Chequear SW2 (bit 2)
    AND X6, X2, X13
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X6, leds_off
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    // Animación expansión
    ADD X8, XZR, X11 // X8 = máscara expansión actual
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

exp_loop:
        STUR X8, [X0, #0]
        // Retardo
        ADD X9, XZR, X10
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
exp_wait:
            SUB X9, X9, X4
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
            CBZ X9, exp_check_sw
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP    
            CBZ XZR, exp_wait
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
exp_check_sw:
        LDUR X2, [X1, #0]
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        AND X6, X2, X4 // SW0
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        CBZ X6, exp_expand
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        // Si se aprieta SW0, salir de animación
        CBZ XZR, main_loop
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
exp_expand:
        LSL X7, X8, #1        
        LSR X9, X8, #1
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        ORR X8, X8, X7
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        ORR X8, X8, X9
        // Si todos los LEDs están encendidos, mostrar y reiniciar
        LSL X6, X4, #16
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        SUB X6, X6, X4 // X6 = 0xFFFF
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        SUB X7, X8, X6
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        CBZ X7, exp_all_on
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        CBZ XZR, exp_loop
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
exp_all_on:
        STUR X8, [X0, #0]
        // Retardo especial
        ADD X9, XZR, X10
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
exp_wait_all:
            SUB X9, X9, X4
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
            CBZ X9, exp_restart
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
            CBZ XZR, exp_wait_all
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
            ADD XZR, XZR, XZR // NOP
exp_restart:
        ADD X8, XZR, X11 // Reiniciar máscara
        CBZ XZR, exp_loop
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP
        ADD XZR, XZR, XZR // NOP

leds_off:
    STUR XZR, [X0, #0]
    CBZ XZR, main_loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

/*
ROM [0:187] ='{
32'h8b0103e4,
32'h8b0203ec,
32'h8b0403ed,
32'h8b1f03e0,
32'h8b1f03e1,
32'h8b1f03e2,
32'h8b1f03e3,
32'h8b1f03e5,
32'h8b1f03e6,
32'h8b1f03e7,
32'h8b1f03e9,
32'h8b1f03ea,
32'h8b1f03eb,
32'hd37f3c80,
32'hd37f3c81,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b080021,
32'hd37f4083,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb040063,
32'hd37f0885,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0400a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f08a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0400a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f08a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0400a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f08a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0400a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f08a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0400a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f08a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0400a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f08a5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0400a5,
32'hd37f088a,
32'hd37f048b,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b04016b,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f1d6b,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8400022,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8a040046,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000126,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000003,
32'hb4fffebf,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8a0c0046,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000126,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000005,
32'hb4fffd3f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8a0d0046,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000a26,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0b03e8,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000008,
32'h8b0a03e9,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb040129,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000109,
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
32'h8a040046,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000106,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fff85f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37f0507,
32'hd35f0509,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa070108,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa090108,
32'hd37f4086,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb0400c6,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb060107,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000107,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fff9df,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000008,
32'h8b0a03e9,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb040129,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4000109,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4ffff3f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0b03e8,
32'hb4fff75f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf800001f,
32'hb4fff21f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff};
 */


 










