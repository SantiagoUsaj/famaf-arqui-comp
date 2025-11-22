`timescale 1ns / 1ps



module execute 
	#(parameter N = 64) 
	(
		input logic AluSrc,
		input logic [3:0] AluControl,
		input logic [N-1:0] PC_E, 
		input logic [N-1:0] signImm_E, 
		input logic [N-1:0] readData1_E, 
		input logic [N-1:0] readData2_E,
		input logic [1:0] forwardA,
		input logic [1:0] forwardB,
		input logic [N-1:0] aluResult_MEM, // qEX_MEM[68:5]
		input logic [N-1:0] writeData_WB,  // writeData3
		output logic [N-1:0] PCBranch_E, 
		output logic [N-1:0] aluResult_E, 
		output logic [N-1:0] writeData_E,
		output logic zero_E
	);

	logic [N-1:0] srcA, srcB;
	logic [N-1:0] mux2_out;
	logic [N-1:0] sl2_out;

	// Forwarding muxes for ALU operands
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

	mux2 #(N) MUX(.d0(srcB), .d1(signImm_E), .s(AluSrc), .y(mux2_out));
	sl2 #(N) sl2(.a(signImm_E), .y(sl2_out));
	adder #(N) adder(.a(PC_E), .b(sl2_out), .y(PCBranch_E));
	alu alu(.a(srcA), .b(mux2_out), .ALUControl(AluControl), .result(aluResult_E), .zero(zero_E));

	assign writeData_E = srcB;

endmodule