`timescale 1ns / 1ps



module maindec_tb();
	logic clk,Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch;
	logic Reg2LocExp,ALUSrcExp,MemtoRegExp,RegWriteExp,MemReadExp,MemWriteExp,BranchExp;
	logic [10:0] Op;
	logic [1:0] ALUOp,ALUOpExp;
	logic [7:0] index,error;
	logic [19:0] testvector [0:6] = '{
            20'b11111000010_0_1_1_1_1_0_0_00, //LDUR
            20'b11111000000_1_1_0_0_0_1_0_00, //STUR
            20'b10110100000_1_0_0_0_0_0_1_01, //CBZ
            20'b10001011000_0_0_0_1_0_0_0_10, //ADD
            20'b11001011000_0_0_0_1_0_0_0_10, //SUB
            20'b10001010000_0_0_0_1_0_0_0_10, //AND
            20'b10101010000_0_0_0_1_0_0_0_10  //ORR
        }; 												 
												 
	maindec dut(Op,Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp);
	
	always
		begin
			clk = 0; #5ns; clk = 1; #5ns;
		end
		
	initial
		begin
			index = 0; error = 0;
		end
		
	always@(negedge clk)
		begin
			{Op,Reg2LocExp,ALUSrcExp,MemtoRegExp,RegWriteExp,MemReadExp,MemWriteExp,BranchExp,ALUOpExp} = testvector[index];
		end
		
	always@(posedge clk)
		begin
			if(Reg2Loc !== Reg2LocExp && ALUSrc !== ALUSrcExp && MemtoReg !== MemtoRegExp && RegWrite !== RegWriteExp && MemRead !== MemReadExp && MemWrite !== MemWriteExp && Branch !== BranchExp && ALUOp !== ALUOpExp)
				begin
				$display("Error input %b", Op);
				error = error + 1;
				end
			index = index + 1;
			if(index === 7'b0000111)
				begin
					$stop;
				end
		end
												
endmodule