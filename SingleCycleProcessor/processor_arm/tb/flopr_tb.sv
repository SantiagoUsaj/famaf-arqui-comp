`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2025 15:43:18
// Design Name: 
// Module Name: flopr_tb
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



module flopr_tb();
	parameter N = 64;
	logic clk, reset;
	logic [N-1:0]d, qexpected;
	logic [N-1:0]q;
	logic [31:0] vectornum, errors;	
	logic [2*N-1:0] testvectors [0:9] = '{
        128'h0000000000000000_0000000000000000,
        128'h0000000000000001_0000000000000000,
        128'h0000000000000002_0000000000000000,
        128'h0000000000000003_0000000000000000,
        128'h0000000000000004_0000000000000000,
        128'h0000000000000005_0000000000000005,
        128'h0000000000000006_0000000000000006,
        128'h0000000000000007_0000000000000007,
        128'h0000000000000008_0000000000000008,
        128'h0000000000000009_0000000000000009
    };
	// 10 elements of 128 bits each
	// Each element is a pair of 64-bit values
	// The first 64 bits are the input data, and the second 64 bits are the expected output
	
	flopr #(64) flop(clk, reset, d, q);
	
	always
		begin
			clk = 0; #5ns; clk = 1; #5ns;
		end
		
	initial 
		begin
			vectornum = 0; errors = 0; reset = 1; #50ns;
			reset = 0; 
		end
		
	always @(negedge clk)
		begin
			{d, qexpected} = testvectors[vectornum];		
		end
		
	always @(posedge clk)
			begin 
				#1ns;
				if (q !== qexpected)
					begin
						$display("Error: inputs = %h", d);
						$display("outputs = %h (%h expected)",q,qexpected);
						errors = errors + 1;
					end
				vectornum = vectornum + 1;
				if (testvectors[vectornum] === 'hx)
					begin
						$display("%d tests completed with %d errors",vectornum, errors);
						$finish;
					end
			end
endmodule