# Arquitectura de Computadoras - FAMAF - UNC

## Lab 1: Implementación del procesador LEGv8 con pipeline de 5 etapas

Nombre y apellido
Integrante 1: Angeli Mateo
Integrante 2: Murphy Ronnie
Integrante 3: Usaj Santiago

Codigo con NOPS:

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

Se modifico:

- processor_arm.sv : Se agrego 1 bit para la instancia de imem.
- imem.sv : Se le agrego un bit al input addr para poder direccionar 128 instrucciones.
- regfile : Se implemento el forwading.

### Ej 1

#### Parte 1 - LSL y LSR

Se modifico alu.sv, aludec.sv, signext.sv y maindec.sv para agregar las operaciones LSL y LSR.

- alu.sv :
- aludec.sv :
- signext.sv :
- maindec.sv :

Codigo utilizado para probar:

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

Pudimos ver que el ensamblador acomoda mal las operaciones LSL y LSR.
El ensamblador del lsl te pone el shamt en el rm, y en el lsr te deja el shamt negado.

Hasta decidir que hacer con el ensamblador decidimos escribir las intrucciones del LSL y LSR manualmente siguiendo la greencard

Un compañero descubrio lo mismo:

```
Buenas, con mi grupo estabamos implementando el LSL y el LSR del ejercicio 1 en vivado. Teniamos una duda ya que sucede que al traducir LSL X1, X1, #1 el traductor de assembly que utilizamos desde el practico 2 nos devuelve el hexadecimal: 0xd37ff821.
No nos estaba andando bien el inmediato, por lo cual lo descompusimos en binario, vimos que:
el shamt es igual a 111110 y
el Rm es igual a 11111
Probamos un par de instrucciones mas y vimos que siempre se cumplia lo mismo, el shamt no era el inmediato directo si no el complemento bit a bit y el Rn el complemento a dos del inmediato.

Adaptamos nuestra implementacion en system verilog para eso y funciono, luego probamos para el LSR con la instruccion LSR X2, X2, #1 y nos dio el hexadecimal 0xd341fc42 y nuevamente la implementacion dejo de funcionar. Descompusimos de nuevo y ahora vemos que:
el shamt es igual a 111111
y el Rm es igual a 00001
Probamos nuevamente unos casos mas y siempre resultaba lo mismo, el shamt queda fijo en todos 1, y el Rn es igual al numero directo que queriamos como inmediato (ni complemento, ni complemento a 2).
```

#### Parte 2 - LEDS

Escribimos un programa en assembler para gestionar recurse de E/S.

## Ej 2

Se nos pide implementar un bloque de Hazar Detection y otro de Forwarding, con el fin de aplicar el forwarding-stall estudiado en la materia.

### HDU

Primero se crearon los módulos de systemVerilog para el HDU y el flip flop con enable

- `hazard_unit.sv`
```verilog
module hazard_unit(
    input  logic [4:0] ID_rs1,    
    input  logic [4:0] ID_rs2,    
    input  logic [4:0] EX_rd,     
    input  logic       EX_memRead,
    output logic       stall     
);

    always_comb begin
        if (EX_memRead && ((EX_rd != 5'd31) && ((EX_rd == ID_rs1) || (EX_rd == ID_rs2)))) begin
            stall = 1;
        end else begin
            stall = 0;
        end
    end

endmodule
```

- `flopr_e.sv`
```verilog
module flopr_e #(parameter N = 64)
				(input logic clk, reset, enable,
				input logic [N-1: 0] d,
				output logic [N-1: 0] q);
	
	always_ff @(posedge clk, posedge reset)
		if (reset)       q <= '0;
		else if (enable) q <= d;		

endmodule
```
Luego se cambió en `datapath.sv` el flip flop de la etapa IF_ID por nuestro nuevo flip flop con enable y al igual que en `fetch.sv`. En este último además se agregó una señal de input para el enable. Con estos cambios se logra detener el PC cuando ocurre un stall. 

- `datapath.sv`
```verilog
flopr_e 	#(96)		IF_ID 	(.clk(clk),
										.reset(reset),
										.enable(~stall),
										.d({IM_addr, IM_readData}),
										.q(qIF_ID));
										
```

- `fetch.sv`
```verilog
module fetch
    #(parameter N = 64) 
    (
        input logic PCSrc_F,
        input logic clk,
        input logic reset,
        input logic enable, // Agregado para flip flop con enable
        input logic [N-1:0] PCBranch_F,
        output logic [N-1:0] imem_addr_F
    );

    logic [N-1:0] add_out;
	logic [N-1:0] mux2_out; 			  
				  
	mux2 #(64) MUX(.d0(add_out),.d1(PCBranch_F),.s(PCSrc_F),.y(mux2_out));
	flopr_e #(64) PC(.clk(clk),.reset(reset),.enable(enable),.d(mux2_out),.q(imem_addr_F));
	adder #(64) Add(.a(imem_addr_F),.b(64'h4),.y(add_out));

endmodule
```

Seguimos instanciando el HDU en datapath para poder generar el output stall. Este output es utliza en flopr_e y en fetch
```verilog
hazard_unit		HDU		(	.ID_rs1(qIF_ID[9:5]),
								.ID_rs2(reg2loc ? qIF_ID[4:0] : qIF_ID[20:16]),
								.EX_rd(qID_EX[4:0]),
								.EX_memRead(qID_EX[264]),
								.stall(stall));		
```
Se agregó un MUX para forzar todas las señales de control a 0 si hay un stall.
```verilog
	assign AluSrc_ID_mux     = stall ? 1'b0 : AluSrc;
	assign AluControl_ID_mux = stall ? 4'b0000 : AluControl;
	assign Branch_ID_mux     = stall ? 1'b0 : Branch;
	assign memRead_ID_mux    = stall ? 1'b0 : memRead;
	assign memWrite_ID_mux   = stall ? 1'b0 : memWrite;
	assign regWrite_ID_mux   = stall ? 1'b0 : regWrite;
	assign memtoReg_ID_mux   = stall ? 1'b0 : memtoReg;		
```

Por último, para que todo siga en sincronía al detectar un stall se reemplazo en el archivo `processor_arm.sv` el flip flop IF_ID_TOP por uno con enable y se le agrego la señal stall proveniente del datapath
```verilog
flopr_e #(11)		IF_ID_TOP(.clk(mclk),
									.reset(i_reset),
									.enable(~stall_dp),
									.d(q[31:21]), 
									.q(instr));
```

#### Testeos
Hicimos una primera prueba para verificar el funcionamiento del HDU con el código en `hazard_detection.s` y observamos que se activa el stall. 
![test1](/img/test1.png)

Luego agregamos mas casos de hazard con el código en `full_hazard_detection.s`. Podemos observar que solo tenemos 2 stalls, que es lo esperado. En este punto todavía no se implemento el forwarding.
![test2](/img/test2.png)

### FU

Primero creamos la FU
- `forwarding_unit.sv`
```verilog
module forwarding_unit(
    input  logic [4:0] ID_EX_rs1,
    input  logic [4:0] ID_EX_rs2,
    input  logic [4:0] EX_MEM_rd,
    input  logic       EX_MEM_regWrite,
    input  logic [4:0] MEM_WB_rd,
    input  logic       MEM_WB_regWrite,
    output logic [1:0] forwardA,
    output logic [1:0] forwardB
);

    // Forwarding logic for source operand A
    always_comb begin
        if (EX_MEM_regWrite && (EX_MEM_rd != 5'd31) && (EX_MEM_rd == ID_EX_rs1)) begin
            forwardA = 2'b10; // Forward from EX/MEM
        end else if (MEM_WB_regWrite && (MEM_WB_rd != 5'd31) &&
                 (MEM_WB_rd == ID_EX_rs1)) begin
            forwardA = 2'b01; // Forward from MEM/WB
        end else begin
            forwardA = 2'b00; // No forwarding
        end
    end

    // Forwarding logic for source operand B
    always_comb begin
        if (EX_MEM_regWrite && (EX_MEM_rd != 5'd31) && (EX_MEM_rd == ID_EX_rs2)) begin
            forwardB = 2'b10; // Forward from EX/MEM
        end else if (MEM_WB_regWrite && (MEM_WB_rd != 5'd31) &&
                 (MEM_WB_rd == ID_EX_rs2)) begin
            forwardB = 2'b01; // Forward from MEM/WB
        end else begin
            forwardB = 2'b00; // No forwarding
        end
    end

endmodule
```

Luego la instanciamos en `datapath.sv` 
```verilog
forwarding_unit FU (
							.ID_EX_rs1(qID_EX[275:271]), // rs1 de la instrucción en EX
							.ID_EX_rs2(FU_rs2),   // rs2 de la instrucción en EX
							.EX_MEM_rd(qEX_MEM[4:0]),  // rd de la instrucción en MEM
							.EX_MEM_regWrite(qEX_MEM[199]), // regWrite de la instrucción en MEM
							.MEM_WB_rd(qMEM_WB[4:0]),  // rd de la instrucción en WB
							.MEM_WB_regWrite(qMEM_WB[134]), // regWrite de la instrucción en WB
							.forwardA(forwardA),
							.forwardB(forwardB)
	);				
```
Agregamos en `execute.sv` los MUX para manejar correctamente el forward
```verilog
always_comb begin
		case (forwardA)
			2'b00: srcA = readData1_E;
			2'b10: srcA = aluResult_MEM;
			2'b01: srcA = writeData_WB;
			default: srcA = readData1_E;
		endcase
		case (forwardB)
			2'b00: srcB = readData2_E;
			2'b10: srcB = aluResult_MEM;
			2'b01: srcB = writeData_WB;
			default: srcB = readData2_E;
		endcase
	end
```
Además, se tuvieron que agregar 10 bits al flip flop ID_EX para poder pasar que registros se estan utilizando y que la FU pueda utilizarlo.
```verilog
flopr 	#(281)	ID_EX 	(	.clk(clk),
								.reset(reset), 
								.d({qIF_ID[20:16],qIF_ID[9:5],AluSrc_ID_mux, AluControl_ID_mux, Branch_ID_mux, memRead_ID_mux, memWrite_ID_mux, regWrite_ID_mux, memtoReg_ID_mux,	
									qIF_ID[95:32], signImm_D, readData1_D, readData2_D, qIF_ID[4:0]}),
								.q(qID_EX));
```
Por último, se modificó en `datapath.sv` la FU para que en las entrada reciba el registro correcto segun el tipo de instruccion, ya que no es lo mismo una tipo R, tipo D o tipo CB
```verilog
// Cálculo de rs1 y rs2 para la unidad de forwarding
	assign rs2_R  = qID_EX[280:276]; // Rn para tipo R
	assign rs2_D  = qID_EX[4:0];     // Rt para tipo D (STUR/LDUR)
	assign rs2_CB = qID_EX[4:0];     // Rt para tipo CB (CBZ)
```
#### Testeos
Se probó el código de `forwarding_code.s` para testear un caso básico y simple de forward y funciona bien.
![testf1](/img/testf1.png)

Luego se probó el código de `full_hazard_detection.s` donde además de forwarding tambien se prueba la deteccion de hazard.
![testf2](/img/testf2.png)

Se implemento un test mas general en `test_HDU_FU.s` para verificar que ambas implementaciones funcionen juntas y lo pasa sin problemas.
![testg](/img/testg.png)

### Resultados

En la siguiente imagen se puede ver la síntesis del procesador final y marcados con un círculo rojo los módulos agregados para el forwarding-stall.
![sintesis](/img/sintesis.png)

