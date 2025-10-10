`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2025 09:54:13
// Design Name: 
// Module Name: sl2
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


// SHIFT LEFT 2

module sl2 
    #(parameter N = 64)
    (
        input logic [N-1:0] a,					
        output logic [N-1:0] y
    );

	assign y[0] = 1'b0;
	assign y[1] = 1'b0;
	assign y[N-1:2] = a[N-3:0];
	
endmodule

