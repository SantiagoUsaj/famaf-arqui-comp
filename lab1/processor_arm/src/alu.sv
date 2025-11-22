`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2025 12:27:41
// Design Name: 
// Module Name: alu
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


module alu
    (
        input logic [63:0] a,
        input logic [63:0] b,
        input logic [3:0] ALUControl,
        output logic [63:0] result,
        output logic zero
    );

    always_comb 
    begin
        casez(ALUControl)
            4'b0000: 
                result = a & b;    // AND
            4'b0001: 
                result = a | b;    // OR
            4'b0010: 
                result = a + b;    // ADD
            4'b0110: 
                result = a - b;    // SUB
            4'b0111: 
                result = b;        // PASS
            4'b1000:              
                result = a << b;  //LSL
            4'b1001:
                result= a >> b;  //LSR
            default: 
                result = '1;
        endcase

        zero = result == '0 ? '1 : '0;
    end    

endmodule
