`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2025 14:06:30
// Design Name: 
// Module Name: execute
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module execute 
    #(parameter N = 64) 
    (
		input logic AluSrc,
		input logic [3:0] AluControl,
		input logic [N-1:0] PC_E, 
        input logic [N-1:0] signImm_E, 
        input logic [N-1:0] readData1_E, 
        input logic [N-1:0] readData2_E,
		output logic [N-1:0] PCBranch_E, 
        output logic [N-1:0] aluResult_E, 
        output logic [N-1:0] writeData_E,
		output logic zero_E
	);

	logic [N-1:0] mux2_out;
	logic [N-1:0] sl2_out;

	mux2 #(N) MUX(.d0(readData2_E), .d1(signImm_E), .s(AluSrc), .y(mux2_out));
	sl2 #(N) sl2(.a(signImm_E), .y(sl2_out));
	adder #(N) adder(.a(PC_E), .b(sl2_out), .y(PCBranch_E));
	alu alu(.a(readData1_E), .b(mux2_out), .ALUControl(AluControl), .result(aluResult_E), .zero(zero_E));

	assign writeData_E = readData2_E;

endmodule
