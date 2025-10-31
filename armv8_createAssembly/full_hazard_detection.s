.text
    .org 0x0000

STUR X1, [X0, #0] // Almacena el valor de X1 en la dirección de memoria apuntada por X0 con un desplazamiento de 0
STUR X2, [X0, #8] // Almacena el valor de X2 en la dirección de memoria apuntada por X0 con un desplazamiento de 8
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

// Hazards de tipo load-use (RAW)
LDUR X1, [X0, #0]
ADD X2, X1, X3   // Hazard: X1 recién cargado
SUB X4, X5, X1   // Hazard: X1 recién cargado

// Hazards con instrucciones que no requieren stall
ADD X1, X2, X3
ADD X4, X1, X5   // No debería haber stall, solo forwarding

// Hazards con instrucciones independientes
LDUR X1, [X0, #0]
ADD X2, X3, X4   // Instrucción independiente
ADD X5, X1, X6   // No debería haber stall aquí

// Hazards con branches (CBZ)
LDUR X1, [X0, #0]
CBZ X1, etiqueta   // Debería haber stall si tu HDU lo contempla

etiqueta:
finloop: CBZ XZR, finloop // Bucle infinito


/*
ROM [0:15] ='{
32'hf8000001,
32'hf8008002,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8400001,
32'h8b030022,
32'hcb0100a4,
32'h8b030041,
32'h8b050024,
32'hf8400001,
32'h8b040062,
32'h8b060025,
32'hf8400001,
32'hb4000021,
32'hb400001f};

 */