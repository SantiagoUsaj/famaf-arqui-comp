.text
    .org 0x0000

STUR X1, [X0, #0]
STUR X0, [X0, #8]
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP

// Test de forwarding y hazard detection completo
// 1. Hazards tipo load-use (requiere stall)
LDUR X1, [X0, #0]      // X1 = Mem[X0 + 0]
ADD X2, X1, X3         // RAW hazard, requiere stall
SUB X4, X5, X1         // RAW hazard, requiere stall

// 2. Forwarding desde EX/MEM y MEM/WB
ADD X6, X2, X4         // Forwarding desde EX/MEM y MEM/WB
ADD X7, X6, X1         // Forwarding desde MEM/WB
ADD X8, X7, X6         // Forwarding desde EX/MEM

// 3. Hazards con instrucciones independientes (no stall, no forwarding)
ADD X9, X10, X11       // Independiente
ADD X12, X13, X14      // Independiente

// 4. Hazards con branch (CBZ)
LDUR X15, [X0, #8]
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
CBZ X15, etiqueta      // Si HDU contempla branch, debe haber stall
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X16, X15, X17      // RAW hazard con branch

etiqueta:
// 5. Secuencia de stores y loads para verificar forwarding y stalls
STUR X18, [X0, #16]
LDUR X19, [X0, #16]
ADD X20, X19, X18      // Forwarding y RAW hazard

// 6. NOPs para limpiar pipeline
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

finloop: CBZ XZR, finloop // Bucle infinito

/*
ROM [0:22] ='{
32'hf8000001,
32'hf800800f,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8400001,
32'h8b030022,
32'hcb0100a4,
32'h8b040046,
32'h8b0100c7,
32'h8b0600e8,
32'h8b0b0149,
32'h8b0e01ac,
32'hf840800f,
32'hb400004f,
32'h8b1101f0,
32'hf8010012,
32'hf8410013,
32'h8b120274,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400001f};

 */