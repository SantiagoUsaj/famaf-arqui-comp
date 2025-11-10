`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 11:57:18
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit(
    input  logic [4:0] ID_rs1,    // rs1 de la instrucción en ID (fuente 1)
    input  logic [4:0] ID_rs2,    // rs2 de la instrucción en ID (fuente 2, relevante para instrucciones tipo R y STUR)
    input  logic [4:0] EX_rd,     // rd de la instrucción en EX (destino)
    input  logic       EX_memRead,// 1 si la instrucción en EX es un LDUR (load)
    output logic       stall      // 1 si hay que frenar el pipeline
);
    
    always_comb begin
        if (EX_memRead && ((EX_rd != 5'd31) && ((EX_rd == ID_rs1) || (EX_rd == ID_rs2)))) begin
            stall = 1;
        end else begin
            stall = 0;
        end
    end

endmodule
