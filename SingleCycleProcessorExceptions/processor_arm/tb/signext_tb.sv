`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2025 10:07:28
// Design Name: 
// Module Name: signext_tb
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


module signext_tb();
	logic clk;
	logic [31:0]a,index,errors;
	logic [63:0]b,bexpected;
	logic [95:0] testvector [0:5] = '{
        96'b11111000000_100000000_00_00001_00000__1111111111111111111111111111111111111111111111111111111100000000, //STUR -
        96'b11111000000_000000001_00_00001_00000__0000000000000000000000000000000000000000000000000000000000000001, //STUR +
        96'b11111000010_000000001_00_00001_00000__0000000000000000000000000000000000000000000000000000000000000001, //LDUR +
        96'b11111000010_100000000_00_00001_00000__1111111111111111111111111111111111111111111111111111111100000000, // LDUR - 
        96'b10110100_1000000000000000000_00000__1111111111111111111111111111111111111111111111000000000000000000, //CBZ -
        96'b10110100_0000000000000000001_00000__0000000000000000000000000000000000000000000000000000000000000001 //CBZ +
    };

	signext dut(a,b);
	always 
		begin
			clk = 0; #5ns; clk = 1; #5ns;
		end
		
	initial
		begin
			index = 0; errors = 0; 
		end
		
	always@(negedge clk)
		begin
			{a,bexpected} = testvector[index];
		end
		
	always@(posedge clk)
		begin
			#1ns;
			if(b !== bexpected)
				begin
					$display("Error: inputs = %b", a);
					$display("outputs = %b (%b expected)",b,bexpected);
					errors = errors + 1;
					end
				index = index + 1;
				if (testvector[index] === 'hx)
					begin
						$display("%d tests completed with %d errors",index, errors);
						$stop;
					end
		end										
endmodule												
												