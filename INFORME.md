# Arquitectura de Computadoras - FAMAF - UNC

## Lab 1: Implementación del procesador LEGv8 con pipeline de 5 etapas

### Integrantes:

- Angeli Mateo
- Murphy Ronnie
- Usaj Santiago

Antes de iniciar con los ejercicios del laboratorio se nos pide que integremos el pipeline. Para esto copiamos y reemplazamos los modulos dados por los profesores.
Una vez realizado el reemplazo de los modulos se debia verificar su correcto funcionamiento con el codigo dado, pero se debia agregar instrucciones NOP por los problemas de hazard.

Para poder usar el codigo modificado se debio modificar:

- `imem.sv` - Se agrego un bit al input addr para poder direccionar 128 instrucciones.

```verilog
(
    input logic [6:0] addr, // Agregamos un bit mas para direccionar 128 instrucciones
    output logic [N-1:0] q
);

logic [N-1:0] ROM [0:127] = '{default: 32'h0}; // Se agrega espacio para 128 instrucciones
```

- `regfile` - Se implemento que si alguno, o ambos registros leídos por una instrucción en la etapa #decode, están siendo escritos como resultado de una instrucción anterior en la etapa #writeback se obtenga a la salida de #regfile el valor actualizado del registro.

```verilog
assign rd1 = (we3 && (wa3 == ra1) && (wa3 != 5'd31)) ? wd3 : registers[ra1];

assign rd2 = (we3 && (wa3 == ra2) && (wa3 != 5'd31)) ? wd3 : registers[ra2];
```

- `processor_arm.sv` - Se agrego un bit a la entrada de la instrMem para que coincida con el nuevo tamaño del input.

```verilog
imem    instrMem (  .addr(IM_address[8:2]), // se cambio de 7:2 a 8:2
                    .q(q));
```

Codigo original modificado con NOPS:

```verilog
    .text
    .org 0x0000

STUR X1, [X0, #0] // Almacena el valor de X1 en la dirección de memoria apuntada por X0 con un desplazamiento de 0
STUR X2, [X0, #8] // Almacena el valor de X2 en la dirección de memoria apuntada por X0 con un desplazamiento de 8
STUR X3, [X0, #16] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 16
ADD X3, X4, X5 // Suma los valores de X4 y X5, y almacena el resultado en X3
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X3, [X0, #24] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 24
SUB X3, X4, X5 // Resta el valor de X5 de X4, y almacena el resultado en X3
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X3, [X0, #32] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 32
SUB X4, XZR, X10 // Resta el valor de X10 de 0, y almacena el resultado en X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #40] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 40
ADD X4, X3, X4 // Suma los valores de X3 y X4, y almacena el resultado en X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #48] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 48
SUB X5, X1, X3 // Resta el valor de X3 de X1, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #56] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 56
AND X5, X10, XZR // Realiza una operación AND entre X10 y 0, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #64] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 64
AND X5, X10, X3 // Realiza una operación AND entre X10 y X3, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #72] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 72
AND X20, X20, X20 // Realiza una operación AND entre X20 y X20, y almacena el resultado en X20
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X20, [X0, #80] // Almacena el valor de X20 en la dirección de memoria apuntada por X0 con un desplazamiento de 80
ORR X6, X11, XZR // Realiza una operación OR entre X11 y 0, y almacena el resultado en X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X6, [X0, #88] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 88
ORR X6, X11, X3 // Realiza una operación OR entre X11 y X3, y almacena el resultado en X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X6, [X0, #96] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 96
LDUR X12, [X0, #0] // Carga el valor de la dirección de memoria apuntada por X0 con un desplazamiento de 0 en X12
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X7, X12, XZR // Suma el valor de X12 y 0, y almacena el resultado en X7
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X7, [X0, #104] // Almacena el valor de X7 en la dirección de memoria apuntada por X0 con un desplazamiento de 104
STUR X12, [X0, #112] // Almacena el valor de X12 en la dirección de memoria apuntada por X0 con un desplazamiento de 112
ADD XZR, X13, X14 // Suma los valores de X13 y X14, y almacena el resultado en XZR (efectivamente no hace nada útil)
STUR XZR, [X0, #120] // Almacena el valor de XZR en la dirección de memoria apuntada por X0 con un desplazamiento de 120
CBZ X0, L1 // Compara X0 con 0 y salta a la etiqueta L1 si es igual a 0
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X21, [X0, #128] // Almacena el valor de X21 en la dirección de memoria apuntada por X0 con un desplazamiento de 128
L1: STUR X21, [X0, #136] // Almacena el valor de X21 en la dirección de memoria apuntada por X0 con un desplazamiento de 136
ADD X2, XZR, X1 // Suma el valor de X1 y 0, y almacena el resultado en X2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
L2: SUB X2, X2, X1 // Resta el valor de X1 de X2, y almacena el resultado en X2
ADD X24, XZR, X1 // Suma el valor de X1 y 0, y almacena el resultado en X24
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X24, [X0, #144] // Almacena el valor de X24 en la dirección de memoria apuntada por X0 con un desplazamiento de 144
ADD X0, X0, X8 // Suma el valor de X8 a X0, y almacena el resultado en X0
CBZ X2, L2 // Compara X2 con 0 y salta a la etiqueta L2 si es igual a 0
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X30, [X0, #144] // Almacena el valor de X30 en la dirección de memoria apuntada por X0 con un desplazamiento de 144
ADD X30, X30, X30 // Suma el valor de X30 a sí mismo, y almacena el resultado en X30
SUB X21, XZR, X21 // Resta el valor de X21 de 0, y almacena el resultado en X21
ADD XZR, XZR, XZR // NOP
ADD X30, X30, X20 // Suma el valor de X20 a X30, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LDUR X25, [X30, #-8] // Carga el valor de la dirección de memoria apuntada por X30 con un desplazamiento de -8 en X25
ADD X30, X30, X30 // Suma el valor de X30 a sí mismo, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X30, X30, X16 // Suma el valor de X16 a X30, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X25, [X30, #-8] // Almacena el valor de X25 en la dirección de memoria apuntada por X30 con un desplazamiento de -8
finloop: CBZ XZR, finloop // Bucle infinito
```

## Ej 1

### Parte 1 - LSL y LSR

Se nos pide agregar las instrucciones LSL y LSR. Para poder realizar esto se hicieron las siguientes modificaciones:

- `alu.sv` - Agregamos las operaciones de shift

```verilog
4'b1000:
    result = a << b;  //LSL
4'b1001:
    result= a >> b;  //LSR
```

- `aludec.sv` - Agregamos las señales de control para las operaciones LSL y LSR segun el aluop y sus respectivos opcodes.

```verilog
else if ((aluop == 2'b10) & (funct == 11'b11010011010)) alucontrol = 4'b1001;	//LSR

else if ((aluop == 2'b10) & (funct == 11'b11010011011)) alucontrol = 4'b1000;	//LSL
```

- `signext.sv` - Agregamos para identificar las instrucciones LSL y LSR con sus opcodes y se extiende el shamt a 64 bits para poder operar con el.

```verilog
// LSL
11'b110_1001_1011:
    y = {58'd0, a[15:10]};

// LSR
11'b110_1001_1010:
    y = {58'd0, a[15:10]};
```

- `maindec.sv` - Agregamos la identificacion de las instrucciones LSL y LSR segun sus respectivos opcodes y se asignan las señales de control correspondientes.

```verilog
11'b110_1001_101?: //LSL and LSR CASE
    begin
        Reg2Loc = 0;
        ALUSrc = 1;
        MemtoReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 'b10;
    end
```

Codigo base para probar el funcionamiento de LSL y LSR:

```verilog
.text
    .org 0x0000

STUR X1, [X0, #0] // Almacena el valor de X1 en la dirección de memoria apuntada por X0 con un desplazamiento de 0
STUR X2, [X0, #8] // Almacena el valor de X2 en la dirección de memoria apuntada por X0 con un desplazamiento de 8
STUR X3, [X0, #16] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 16
LSL X4, X4, #2 // Desplaza el valor de X4 a la izquierda 2 bits (equivalente a multiplicar por 4)
LSR X6, X6, #1 // Desplaza el valor de X6 a la derecha 1 bit (equivalente a dividir por 2)
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #24] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 24
STUR X6, [X0, #32] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 32
finloop: CBZ XZR, finloop // Bucle infinito

```

Se nos pidio que probemos el codigo original con los nops y le agreguemos las nuevas instrucciones para ver que las instrucciones nuevas funciones y que las anteriores sigan funcionando correctamente

Codigo original modificado con NOPS y LSL y LSR:

```verilog
.text
    .org 0x0000

STUR X1, [X0, #0] // Almacena el valor de X1 en la dirección de memoria apuntada por X0 con un desplazamiento de 0
STUR X2, [X0, #8] // Almacena el valor de X2 en la dirección de memoria apuntada por X0 con un desplazamiento de 8
STUR X3, [X0, #16] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 16
ADD X3, X4, X5 // Suma los valores de X4 y X5, y almacena el resultado en X3
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X3, [X0, #24] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 24
SUB X3, X4, X5 // Resta el valor de X5 de X4, y almacena el resultado en X3
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X3, [X0, #32] // Almacena el valor de X3 en la dirección de memoria apuntada por X0 con un desplazamiento de 32
SUB X4, XZR, X10 // Resta el valor de X10 de 0, y almacena el resultado en X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #40] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 40
ADD X4, X3, X4 // Suma los valores de X3 y X4, y almacena el resultado en X4
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X4, [X0, #48] // Almacena el valor de X4 en la dirección de memoria apuntada por X0 con un desplazamiento de 48
SUB X5, X1, X3 // Resta el valor de X3 de X1, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #56] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 56
AND X5, X10, XZR // Realiza una operación AND entre X10 y 0, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #64] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 64
AND X5, X10, X3 // Realiza una operación AND entre X10 y X3, y almacena el resultado en X5
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X5, [X0, #72] // Almacena el valor de X5 en la dirección de memoria apuntada por X0 con un desplazamiento de 72
AND X20, X20, X20 // Realiza una operación AND entre X20 y X20, y almacena el resultado en X20
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X20, [X0, #80] // Almacena el valor de X20 en la dirección de memoria apuntada por X0 con un desplazamiento de 80
LSR X6, X11, #2 // Realiza una operación LSR entre X11 y 2, y almacena el resultado en X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X6, [X0, #88] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 88
ORR X6, X11, X3 // Realiza una operación OR entre X11 y X3, y almacena el resultado en X6
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X6, [X0, #96] // Almacena el valor de X6 en la dirección de memoria apuntada por X0 con un desplazamiento de 96
LDUR X12, [X0, #0] // Carga el valor de la dirección de memoria apuntada por X0 con un desplazamiento de 0 en X12
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LSL X7, X12, #4  // Desplaza a la izquierda el valor de X12 en 4 bits, y almacena el resultado en X7
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X7, [X0, #104] // Almacena el valor de X7 en la dirección de memoria apuntada por X0 con un desplazamiento de 104
STUR X12, [X0, #112] // Almacena el valor de X12 en la dirección de memoria apuntada por X0 con un desplazamiento de 112
ADD XZR, X13, X14 // Suma los valores de X13 y X14, y almacena el resultado en XZR (efectivamente no hace nada útil)
STUR XZR, [X0, #120] // Almacena el valor de XZR en la dirección de memoria apuntada por X0 con un desplazamiento de 120
CBZ X0, L1 // Compara X0 con 0 y salta a la etiqueta L1 si es igual a 0
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X21, [X0, #128] // Almacena el valor de X21 en la dirección de memoria apuntada por X0 con un desplazamiento de 128
L1: STUR X21, [X0, #136] // Almacena el valor de X21 en la dirección de memoria apuntada por X0 con un desplazamiento de 136
ADD X2, XZR, X1 // Suma el valor de X1 y 0, y almacena el resultado en X2
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
L2: SUB X2, X2, X1 // Resta el valor de X1 de X2, y almacena el resultado en X2
ADD X24, XZR, X1 // Suma el valor de X1 y 0, y almacena el resultado en X24
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X24, [X0, #144] // Almacena el valor de X24 en la dirección de memoria apuntada por X0 con un desplazamiento de 144
ADD X0, X0, X8 // Suma el valor de X8 a X0, y almacena el resultado en X0
CBZ X2, L2 // Compara X2 con 0 y salta a la etiqueta L2 si es igual a 0
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X30, [X0, #144] // Almacena el valor de X30 en la dirección de memoria apuntada por X0 con un desplazamiento de 144
ADD X30, X30, X30 // Suma el valor de X30 a sí mismo, y almacena el resultado en X30
SUB X21, XZR, X21 // Resta el valor de X21 de 0, y almacena el resultado en X21
ADD XZR, XZR, XZR // NOP
ADD X30, X30, X20 // Suma el valor de X20 a X30, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
LDUR X25, [X30, #-8] // Carga el valor de la dirección de memoria apuntada por X30 con un desplazamiento de -8 en X25
ADD X30, X30, X30 // Suma el valor de X30 a sí mismo, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
ADD X30, X30, X16 // Suma el valor de X16 a X30, y almacena el resultado en X30
ADD XZR, XZR, XZR // NOP
ADD XZR, XZR, XZR // NOP
STUR X25, [X30, #-8] // Almacena el valor de X25 en la dirección de memoria apuntada por X30 con un desplazamiento de -8
finloop: CBZ XZR, finloop // Bucle infinito

```

Como el makefile que genera las instrucciones tenia un problema para armar las instrucciones de LSL y LSR, se utilizo un script que un compañero paso por Zulip. Gracias a el se nos facilito mucho el armar las instrucciones.

### Parte 2 - LEDS y SWITCHES

Escribimos un programa en assembler para gestionar recursos de E/S.

Se realizo una animacion donde los leds se van prendiendo de a uno de derecha a izquierda (Led 0 al 15) y al apretar el Switch 0, se cambia el sentido de la animacion, yendo de izquierda a derecha (led 15 al 0). La animacion se ejecuta en un loop infinito, aunque estamos teniendo problemas en los bordes. Los leds de los bordes permanecen por menos tiempo encendidos.
