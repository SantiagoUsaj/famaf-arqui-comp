`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2025 18:55:26
// Design Name: 
// Module Name: maindec
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


module maindec (
        input logic [10:0] Op,
        output logic Reg2Loc,
        output logic ALUSrc,
        output logic MemtoReg,
        output logic RegWrite,
        output logic MemRead,
        output logic MemWrite,
        output logic Branch,
        output logic [1:0] ALUOp
    );
	
	always_comb begin
        casez(Op)
            11'b111_1100__0010:  //LDUR CASE
                        begin
                            Reg2Loc = 0;
                            ALUSrc = 1;
                            MemtoReg = 1;
                            RegWrite = 1;
                            MemRead = 1;
                            MemWrite = 0;
                            Branch = 0;
                            ALUOp = 'b00;
                        end
            11'b111_1100_0000: //STUR CASE
                        begin
                            Reg2Loc = 1;
                            ALUSrc = 1;
                            MemtoReg = 0;
                            RegWrite = 0;
                            MemRead = 0;
                            MemWrite = 1;
                            Branch = 0;
                            ALUOp = 'b00;
                        end
            11'b101_1010_0???: //CBZ CASE
                        begin
                            Reg2Loc = 1;
                            ALUSrc = 0;
                            MemtoReg = 0;
                            RegWrite = 0;
                            MemRead = 0;
                            MemWrite = 0;
                            Branch = 1;
                            ALUOp = 'b01;
                        end
            11'b1?0_0101_1000: //ADD and SUB CASE
                        begin
                            Reg2Loc = 0;
                            ALUSrc = 0;
                            MemtoReg = 0;
                            RegWrite = 1;
                            MemRead = 0;
                            MemWrite = 0;
                            Branch = 0;
                            ALUOp = 'b10;
                        end
            11'b10?_0101_0000: //AND and ORR CASE
                        begin
                            Reg2Loc = 0;
                            ALUSrc = 0;
                            MemtoReg = 0;
                            RegWrite = 1;
                            MemRead = 0;
                            MemWrite = 0;
                            Branch = 0;
                            ALUOp = 'b10;
                        end
            default 
                        begin
                            Reg2Loc = 0;
                            ALUSrc = 0;
                            MemtoReg = 0;
                            RegWrite = 0;
                            MemRead = 0;
                            MemWrite = 0;
                            Branch = 0;
                            ALUOp = 'b00;
                        end
							
        endcase
    end
endmodule
