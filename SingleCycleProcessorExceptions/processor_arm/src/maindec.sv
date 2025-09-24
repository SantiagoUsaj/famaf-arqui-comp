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
        input logic reset, // new
        input logic ExtIRQ, // new
        output logic Reg2Loc,
        output logic MemtoReg,
        output logic RegWrite,
        output logic MemRead,
        output logic MemWrite,
        output logic Branch,
        output logic [1:0] ALUOp, ALUSrc, // update ALUSrc to 2 bits
        output logic Exc, ERet, // new
        output logic [3:0] EStatus // new
    );

    logic NotAnInstr;
    logic [3:0] Status;

    always_comb begin
        if (reset) begin
            Reg2Loc = 0;
            ALUSrc = 'b00;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 'b00;
            NotAnInstr = 0;
            Exc = 0;
            EStatus = 4'b0000;
            Status = 4'b0000;
            ERet = 0;
        end 
        else begin
            logic Reg2Loc_next, MemtoReg_next, RegWrite_next, MemRead_next, MemWrite_next, Branch_next, ERet_next;
            logic [1:0] ALUOp_next, ALUSrc_next;
            logic NotAnInstr_next;
            logic [3:0] Status_next;


            // Default values
            Reg2Loc_next = 0;
            ALUSrc_next = 'b00;
            MemtoReg_next = 0;
            RegWrite_next = 0;
            MemRead_next = 0;
            MemWrite_next = 0;
            Branch_next = 0;
            ALUOp_next = 'b00;
            NotAnInstr_next = 0;
            Status_next = 4'b0000;
            ERet_next = 0;

            casez(Op)
                11'b111_1100__0010:  //LDUR CASE
                        begin
                            Reg2Loc_next = 'x;
                            ALUSrc_next = 'b01;
                            MemtoReg_next = 1;
                            RegWrite_next = 1;
                            MemRead_next = 1;
                            MemWrite_next = 0;
                            Branch_next = 0;
                            ALUOp_next = 'b00;
                            NotAnInstr_next = 0;
                            Status_next = 4'b0000;
                            ERet_next = 0;
                        end
                11'b111_1100_0000: //STUR CASE
                        begin
                            Reg2Loc_next = 1;
                            ALUSrc_next = 'b01;
                            MemtoReg_next = 'x;
                            RegWrite_next = 0;
                            MemRead_next = 0;
                            MemWrite_next = 1;
                            Branch_next = 0;
                            ALUOp_next = 'b00;
                            NotAnInstr_next = 0;
                            Status_next = 4'b0000;
                            ERet_next = 0;
                        end
                11'b101_1010_0???: //CBZ CASE
                        begin
                            Reg2Loc_next = 1;
                            ALUSrc_next = 'b00;
                            MemtoReg_next = 'x;
                            RegWrite_next = 0;
                            MemRead_next = 0;
                            MemWrite_next = 0;
                            Branch_next = 1;
                            ALUOp_next = 'b01;
                            NotAnInstr_next = 0;
                            Status_next = 4'b0000;
                            ERet_next = 0;
                        end
                11'b1?0_0101_1000: //ADD and SUB CASE
                        begin
                            Reg2Loc_next = 0;
                            ALUSrc_next = 'b00;
                            MemtoReg_next = 0;
                            RegWrite_next = 1;
                            MemRead_next = 0;
                            MemWrite_next = 0;
                            Branch_next = 0;
                            ALUOp_next = 'b10;
                            NotAnInstr_next = 0;
                            Status_next = 4'b0000;
                            ERet_next = 0;
                        end
                11'b10?_0101_0000: //AND and ORR CASE
                        begin
                            Reg2Loc_next = 0;
                            ALUSrc_next = 'b00;
                            MemtoReg_next = 0;
                            RegWrite_next = 1;
                            MemRead_next = 0;
                            MemWrite_next = 0;
                            Branch_next = 0;
                            ALUOp_next = 'b10;
                            NotAnInstr_next = 0;
                            Status_next = 4'b0000;
                            ERet_next = 0;
                        end
                11'b110_1011_0100: // ERET CASE
                        begin
                            Reg2Loc_next = 0;
                            ALUSrc_next = 'b00;
                            MemtoReg_next = 'x;
                            RegWrite_next = 0;
                            MemRead_next = 0;
                            MemWrite_next = 0;
                            Branch_next = 1;
                            ALUOp_next = 'b01;
                            NotAnInstr_next = 0;
                            Status_next = 4'b0000;
                            ERet_next = 1;
                        end
                11'b110_1010_1001: // MRS CASE
                        begin
                            Reg2Loc_next = 1;
                            ALUSrc_next = 'b1x;
                            MemtoReg_next = 0;
                            RegWrite_next = 1;
                            MemRead_next = 0;
                            MemWrite_next = 0;
                            Branch_next = 0;
                            ALUOp_next = 'b01;
                            NotAnInstr_next = 0;
                            Status_next = 4'b0000;
                            ERet_next = 0;
                        end
                default // Invalid OpCode
                        begin
                            Reg2Loc_next = 'x;
                            ALUSrc_next = 'bxx;
                            MemtoReg_next = 0;
                            RegWrite_next = 0;
                            MemRead_next = 0;
                            MemWrite_next = 0;
                            Branch_next = 0;
                            ALUOp_next = 'bxx;
                            NotAnInstr_next = 1;
                            Status_next = 4'b0010;
                            ERet_next = 0;
                        end
            endcase

            // Si hay IRQ externa, no modificar señales de control
            if (ExtIRQ) begin
                EStatus = 4'b0001;
                // Las señales de control NO se modifican, se mantienen como estaban
                // (no se actualizan en este ciclo)
            end else begin
                Reg2Loc = Reg2Loc_next;
                ALUSrc = ALUSrc_next;
                MemtoReg = MemtoReg_next;
                RegWrite = RegWrite_next;
                MemRead = MemRead_next;
                MemWrite = MemWrite_next;
                Branch = Branch_next;
                ALUOp = ALUOp_next;
                NotAnInstr = NotAnInstr_next;
                Status = Status_next;
                EStatus = Status_next;
                ERet = ERet_next;
            end
            Exc = ((ExtIRQ | NotAnInstr_next) & ~reset);
        end
    end //always_comb    
endmodule
