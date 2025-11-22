`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2025 12:56:11
// Design Name: 
// Module Name: imem_tb
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


module imem_tb();
	parameter N = 32;
	logic [5:0] addr;
	logic clk;
	logic [N-1:0] q,qexpect;
	logic [63:0] index,errors;
	logic [39:0] testvector [0:49] = '{
        40'h00_f8000001,
        40'h01_f8008002,
        40'h02_f8000203,
        40'h03_8b050083,
        40'h04_f8018003,
        40'h05_cb050083,
        40'h06_f8020003,
        40'h07_cb0a03e4,
        40'h08_f8028004,
        40'h09_8b040064,
        40'h0A_f8030004,
        40'h0B_cb030025,
        40'h0C_f8038005,
        40'h0D_8a1f0145,
        40'h0E_f8040005,
        40'h0F_8a030145,
        40'h10_f8048005,
        40'h11_8a140294,
        40'h12_f8050014,
        40'h13_aa1f0166,
        40'h14_f8058006,
        40'h15_aa030166,
        40'h16_f8060006,
        40'h17_f840000c,
        40'h18_8b1f0187,
        40'h19_f8068007,
        40'h1A_f807000c,
        40'h1B_8b0e01bf,
        40'h1C_f807801f,
        40'h1D_b4000040,
        40'h1E_f8080015,
        40'h1F_f8088015,
        40'h20_8b0103e2,
        40'h21_cb010042,
        40'h22_8b0103f8,
        40'h23_f8090018,
        40'h24_8b080000,
        40'h25_b4ffff82,
        40'h26_f809001e,
        40'h27_8b1e03de,
        40'h28_cb1503f5,
        40'h29_8b1403de,
        40'h2A_f85f83d9,
        40'h2B_8b1e03de,
        40'h2C_8b1003de,
        40'h2D_f81f83d9,
        40'h2E_b400001f,
        40'h2F_00000000,
        40'h30_00000000,
        40'h31_00000000};
	imem #(32) dut(addr,q);
	
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
			{addr,qexpect} = testvector[index];
		end
	
	always@(posedge clk)
		begin
			if(q !== qexpect)
				begin
					errors = errors +1;
				end
			index = index +1;
			if(testvector[index] === 'hx)
				begin
					$display("test finish");
					$stop;
				end
		end
	
endmodule
