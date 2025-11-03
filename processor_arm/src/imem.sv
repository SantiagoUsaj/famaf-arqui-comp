`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2025 11:25:10
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
        input logic [6:0] addr, // Agregamos un bit mas para direccionar 128 instrucciones
        output logic [N-1:0] q
    );

    logic [N-1:0] ROM [0:127] = '{default: 32'h0}; // Se agrega espacio para 128 instrucciones

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

        // Codigo modificado para los hazards
              /*
        ROM [0:87] ='{  32'hf8000001,
                        32'hf8008002,
                        32'hf8010003,
                        32'h8b050083,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8018003,
                        32'hcb050083,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8020003,
                        32'hcb0a03e4,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8028004,
                        32'h8b040064,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8030004,
                        32'hcb030025,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8038005,
                        32'h8a1f0145,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8040005,
                        32'h8a030145,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8048005,
                        32'h8a140294,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8050014,
                        32'haa1f0166,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8058006,
                        32'haa030166,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8060006,
                        32'hf840000c,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'h8b1f0187,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8068007,
                        32'hf807000c,
                        32'h8b0e01bf,
                        32'hf807801f,
                        32'hb40000a0,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8080015,
                        32'hf8088015,
                        32'h8b0103e2,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hcb010042,
                        32'h8b0103f8,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8090018,
                        32'h8b080000,
                        32'hb4ffff42,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf809001e,
                        32'h8b1e03de,
                        32'hcb1503f5,
                        32'h8b1f03ff,
                        32'h8b1403de,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf85f83d9,
                        32'h8b1e03de,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'h8b1003de,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf81f83d9,
                        32'hb400001f};
        */

        // Codigo con LSL y LSR
        /*
        ROM [0:9] ='{   32'hf8000001,
                        32'hf8008002,
                        32'hf8010003,
                        32'hd3620884,
                        32'hd34104c6,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8018004,
                        32'hf8020006,
                        32'hb400001f};
        */ 

        // Codigo base probar deteccion hazards   
        /*
        ROM [0:8] ='{   32'hf8000001,
                        32'hf8008002,
                        32'h8b050083,
                        32'h8b0800a4,
                        32'hf8400006,
                        32'h8b0800c7,
                        32'h8b030041,
                        32'h8b0a0122,
                        32'hb400001f};   
        */
        // Codigo mas completo para detectar hazards
        /*
        ROM [0:15] ='{
                        32'hf8000001,
                        32'hf8008002,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'h8b1f03ff,
                        32'hf8400001,
                        32'h8b030022,
                        32'hcb0100a4,
                        32'h8b030041,
                        32'h8b050024,
                        32'hf8400001,
                        32'h8b040062,
                        32'h8b060025,
                        32'hf8400001,
                        32'hb4000021,
                        32'hb400001f
                    };     
                    */

        // Codigo para ver el forwarding
        ROM [0:8] ='{
                        32'h8b020024,
                        32'h8b030085,
                        32'hcb0100a6,
                        32'h8a0200c7,
                        32'haa0300e8,
                        32'h8b040109,
                        32'hd37f052a,
                        32'hd35f094b,
                        32'hb400001f
                    };

    end      
       

	always_comb begin
		q = ROM[addr];
	end

endmodule


