`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2025 09:56:45
// Design Name: 
// Module Name: fetch
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


module fetch
    #(parameter N = 64) 
    (
        input logic PCSrc_F,
        input logic clk,
        input logic reset,
        input logic [N-1:0] PCBranch_F,
        output logic [N-1:0] imem_addr_F
    );

    logic [N-1:0] add_out;
	logic [N-1:0] mux2_out; 			  
				  
	mux2 #(64) MUX(.d0(add_out),.d1(PCBranch_F),.s(PCSrc_F),.y(mux2_out));
	flopr #(64) PC(.clk(clk),.reset(reset),.d(mux2_out),.q(imem_addr_F));
	adder #(64) Add(.a(imem_addr_F),.b(64'h4),.y(add_out));

endmodule
