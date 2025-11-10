# Arquitectura de Computadoras - FAMAF - UNC

## Lab 1: Implementación del procesador LEGv8 con pipeline de 5 etapas

### Integrantes:

- Angeli Mateo
- Murphy Ronnie
- Usaj Santiago

### Preliminares

Antes de comenzar con los ejercicios del laboratorio se nos pide integrar el pipeline y verificar su funcionamiento con un código en assembler al cual se le deben agregar los NOPS.

Para integrar el pipeline se reemplazaron los archivos dados por los profesores.

Para poder probar el código se debieron modificar los siguientes módulos:

- `imem.sv` - Se agregó un bit al input addr para poder direccionar 128 instrucciones.

```verilog
(
    input logic [6:0] addr, // Agregamos un bit mas para direccionar 128 instrucciones
    output logic [N-1:0] q
);

logic [N-1:0] ROM [0:127] = '{default: 32'h0}; // Se agrega espacio para 128 instrucciones
```

- `regfile` - Si alguno o ambos registros leídos por una instrucción en la etapa #decode, están siendo escritos como resultado de una instrucción anterior en la etapa #writeback se obtiene a la salida de #regfile el valor actualizado del registro.

```verilog
assign rd1 = (we3 && (wa3 == ra1) && (wa3 != 5'd31)) ? wd3 : registers[ra1];

assign rd2 = (we3 && (wa3 == ra2) && (wa3 != 5'd31)) ? wd3 : registers[ra2];
```

- `processor_arm.sv` - Se agregó un bit a la entrada de la instrMem para que coincida con el nuevo tamaño del input.

```verilog
imem    instrMem (  .addr(IM_address[8:2]), // se cambio de 7:2 a 8:2
                    .q(q));
```

Código de prueba modificado con NOPS:

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

Se nos pide agregar las instrucciones LSL y LSR. Para poder implementarlas se realizaron las siguientes modificaciones:

- `alu.sv` - Se agregaron las operaciones de shift

```verilog
4'b1000:
    result = a << b;  //LSL
4'b1001:
    result= a >> b;  //LSR
```

- `aludec.sv` - Se agregaron las señales de control para LSL y LSR junto a la identificación segun sus aluop y opcode.

```verilog
else if ((aluop == 2'b10) & (funct == 11'b11010011010)) alucontrol = 4'b1001;	//LSR

else if ((aluop == 2'b10) & (funct == 11'b11010011011)) alucontrol = 4'b1000;	//LSL
```

- `signext.sv` - Se identifican las operaciones LSL y LSR para extender a 64 bits el valor de shamt y poder operar con él.

```verilog
// LSL
11'b110_1001_1011:
    y = {58'd0, a[15:10]};

// LSR
11'b110_1001_1010:
    y = {58'd0, a[15:10]};
```

- `maindec.sv` - Se agregó la identificacion y decodificación de las instrucciones LSL y LSR.

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

Código utilizado para probar el funcionamiento de LSL y LSR:

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

Se nos pidió probar el código original con los NOPS y agregarle las nuevas instrucciones para comprobar el correcto funcionamiento de estas y que las anteriormentes sigan funcionando.

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

Como el makefile que genera las instrucciones tenía un problema para armar las instrucciones de LSL y LSR, se utilizó un script que un compañero paso por Zulip (`script_shifts.py`). Gracias a él se nos facilitó mucho el armar las instrucciones.

### Parte 2 - LEDS y SWITCHES

Escribimos programas en assembler para gestionar recursos de E/S.

Fuimos creando distintos programas y experimentando el funcionamiento de los LEDs y switches.

Primero creamos en `expansion.s` un loop en el que se encienden los LEDs del centro y se van expandiendo hacia los costados hasta llegar a estar las 16 luces encendidas, luego vuelven a estar unicamente las del centro. Si durante el loop se enciende la señal del switch 0 este se interrumpe y vuelve a iniciar.

Este es un ejemplo donde la primera iteración del loop es interrumpida por la señal del switch.
![expansion](/img/expansion.png)

Luego probamos implementar distintos comportamientos segun que switch está encendido. En el archivo `off_on_even.s` creamos un programa con el cual los LEDs permanecen apagados si todos los switches estan en la posición 0. Si únicamente se activa el switch 0 se encienden todas las luces y si únicamente se activa el switch 1 se encienden solo las luces de posiciones pares.
![off_on_even](/img/off_on_even.png)

Finalmente `leds_and_switches.s` combina estos códigos. Nuevamente el switch 0 enciende todos los LEDs y el switch 1 solo las posiciones pares. Además, el switch 2 comienza el loop infinito de expansion, el cual puede únicamente ser interrumpido con el switch 0.
![l_and_s](/img/leds_and_switches.png)

Este es el código en assembler:

```verilog
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
```
