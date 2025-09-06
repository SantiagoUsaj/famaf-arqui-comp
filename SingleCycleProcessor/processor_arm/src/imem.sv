`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2025 11:45:50
// Design Name: 
// Module Name: imem
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


module imem
    #(parameter N = 32) 
    (
        input logic [5:0] addr,
        output logic [N-1:0] q
    );

    logic [N-1:0] ROM [0:63] = '{default: 32'h0};

	initial begin
        // Codigo original
        /*
		ROM [0:46] ='{  32'hf8000001,
                        32'hf8008002,
                        32'hf8000203,
                        32'h8b050083,
                        32'hf8018003,
                        32'hcb050083,
                        32'hf8020003,
                        32'hcb0a03e4,
                        32'hf8028004,
                        32'h8b040064,
                        32'hf8030004,
                        32'hcb030025,
                        32'hf8038005,
                        32'h8a1f0145,
                        32'hf8040005,
                        32'h8a030145,
                        32'hf8048005,
                        32'h8a140294,
                        32'hf8050014,
                        32'haa1f0166,
                        32'hf8058006,
                        32'haa030166,
                        32'hf8060006,
                        32'hf840000c,
                        32'h8b1f0187,
                        32'hf8068007,
                        32'hf807000c,
                        32'h8b0e01bf,
                        32'hf807801f,
                        32'hb4000040,
                        32'hf8080015,
                        32'hf8088015,
                        32'h8b0103e2,
                        32'hcb010042,
                        32'h8b0103f8,
                        32'hf8090018,
                        32'h8b080000,
                        32'hb4ffff82,
                        32'hf809001e,
                        32'h8b1e03de,
                        32'hcb1503f5,
                        32'h8b1403de,
                        32'hf85f83d9,
                        32'h8b1e03de,
                        32'h8b1003de,
                        32'hf81f83d9,
                        32'hb400001f};
        */
        
        // TP2 - 2-A
        /*
        ROM [0:8] ='{   32'h8b000002,
                        32'h8b000003,
                        32'hb40000de,
                        32'hf8000043,
                        32'h8b010063,
                        32'hcb0103de,
                        32'h8b080042,
                        32'hb4ffff60,
                        32'hb4000000};
        */

        // TP2 - 2-B
        ROM [0:18] ='{  32'h8b000002,
                        32'h8b000003,
                        32'hb40000de,
                        32'hf8000043,
                        32'h8b010063,
                        32'hcb0103de,
                        32'h8b080042,
                        32'hb4ffff60,
                        32'h8b000002,
                        32'h8b000003,
                        32'h8b000004,
                        32'hb40000c9,
                        32'hf8400043,
                        32'h8b030084,
                        32'h8b080042,
                        32'hcb010129,
                        32'hb4ffff60,
                        32'hf8000044,
                        32'hb4000000};
	end

	always_comb begin
		q = ROM[addr];
	end

endmodule


