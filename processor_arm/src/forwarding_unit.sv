`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 12:11:47
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
    input  logic [4:0] ID_EX_rs1,
    input  logic [4:0] ID_EX_rs2,
    input  logic [4:0] EX_MEM_rd,
    input  logic       EX_MEM_regWrite,
    input  logic [4:0] MEM_WB_rd,
    input  logic       MEM_WB_regWrite,
    output logic [1:0] forwardA,
    output logic [1:0] forwardB
);

    // Forwarding logic for source operand A (revised)
    always_comb begin
        if (EX_MEM_regWrite && (EX_MEM_rd != 5'd31) && (EX_MEM_rd == ID_EX_rs1)) begin
            forwardA = 2'b10; // Forward from EX/MEM
        end else if (MEM_WB_regWrite && (MEM_WB_rd != 5'd31) &&
                 !(EX_MEM_regWrite && (EX_MEM_rd != 5'd31) && (EX_MEM_rd != ID_EX_rs1)) &&
                 (MEM_WB_rd == ID_EX_rs1)) begin
            forwardA = 2'b01; // Forward from MEM/WB
        end else begin
            forwardA = 2'b00; // No forwarding
        end
    end

    // Forwarding logic for source operand B (revised)
    always_comb begin
        if (EX_MEM_regWrite && (EX_MEM_rd != 5'd31) && (EX_MEM_rd == ID_EX_rs2)) begin
            forwardB = 2'b10; // Forward from EX/MEM
        end else if (MEM_WB_regWrite && (MEM_WB_rd != 5'd31) &&
                 !(EX_MEM_regWrite && (EX_MEM_rd != 5'd31) && (EX_MEM_rd != ID_EX_rs2)) &&
                 (MEM_WB_rd == ID_EX_rs2)) begin
            forwardB = 2'b01; // Forward from MEM/WB
        end else begin
            forwardB = 2'b00; // No forwarding
        end
    end

endmodule
