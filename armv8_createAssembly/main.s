    .text
    .org 0x0000

// X0: dirección base de LEDs (0x8000)
// X1: dirección base de switches (0x8008)
// X2: máscara LED encendido
// X3: dirección (0=izq, 1=der)
// X4: retardo parametrizable
// X5: valor leído de switches
// X6: constante 1
// X7: máscara para el límite izquierdo (0x8000)
// X8: máscara para el límite derecho (0x0001)
// X9: variable auxiliar

ADD X6, XZR, X1         // Constante 1
ADD X0, XZR, XZR
ADD X1, XZR, XZR
ADD X2, XZR, XZR
ADD X3, XZR, XZR
ADD X4, XZR, XZR
ADD X5, XZR, XZR
ADD X7, XZR, XZR
ADD X8, XZR, XZR

// X0 = 0x8000
ADD X0, X0, X6          // X0 = 1
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X0, X0, #15         // X0 = 0x8000
// X1 = 0x8008
ADD X1, X1, X6          // X1 = 1
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X1, X1, #15         // X1 = 0x8000
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8001
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8002
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8003
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8004
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8005
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8006
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8007
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X1, X1, X6          // X1 = 0x8008
// X2 = 1 (LED más a la derecha)
ADD X2, XZR, X6
// X3 = 0 (dirección inicial izquierda)
ADD X3, XZR, XZR
// X4 = retardo
ADD X4, XZR, X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X4, X4, #2         // X4 = 0x0004
// X7 = 0x8000 (máscara límite izquierdo)
ADD X7, XZR, X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X7, X7, #15
// X8 = 1 (máscara límite derecho)
ADD X8, XZR, X6

main_loop:
    STUR X2, [X0, #0]   // Escribir LED encendido

    // Leer switches
    LDUR X5, [X1, #0]
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    AND X5, X5, X6      // Solo SW0
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

    CBZ X5, dir_izq     // Si SW0=0, va a la izquierda
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD X3, XZR, X6     // X3=1, derecha
    CBZ XZR, mover
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
dir_izq:
    ADD X3, XZR, XZR    // X3=0, izquierda
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

mover:
    // Mover el LED según dirección
    CBZ X3, mueve_izq
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    // Derecha: LSL
    LSL X2, X2, #1
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    // Si pasa el límite izquierdo, reinicia
    AND X9, X2, X7
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X9, no_limite_izq
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD X2, XZR, X8     // Reinicia al bit derecho
    CBZ XZR, delay
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
no_limite_izq:
    CBZ XZR, delay
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
mueve_izq:
    // Izquierda: LSR
    LSR X2, X2, #1
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    // Si pasa el límite derecho, reinicia
    AND X9, X2, X8
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X9, no_limite_der
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD X2, XZR, X7     // Reinicia al bit izquierdo
    CBZ XZR, delay
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
no_limite_der:
    CBZ XZR, delay
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP

delay:
    // Retardo parametrizable
    ADD X9, XZR, X4
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
delay_loop:
    SUB X9, X9, X6
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ X9, main_loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    CBZ XZR, delay_loop
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
    ADD XZR, XZR, XZR // NOP
