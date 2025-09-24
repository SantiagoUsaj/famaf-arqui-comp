// CONTROLLER

	module controller(
	    input logic [10:0] instr,
	    input logic reset,
	    input logic ExtIRQ,
	    input logic ExcAck,
	    output logic [3:0] AluControl,
	    output logic reg2loc, regWrite, Branch,
	    output logic memtoReg, memRead, memWrite,
	    output logic ExtIAck,
	    output logic ERet,
	    output logic Exc,
	    output logic [3:0] EStatus,
	    output logic [1:0] AluSrc // nuevo, salida de 2 bits
	);
											
		logic [1:0] AluOp_s,;
											
		maindec decPpal (
			.Op(instr),
			.reset(reset),
			.ExtIRQ(ExtIRQ),
			.Reg2Loc(reg2loc),
			.MemtoReg(memtoReg),
			.RegWrite(regWrite),
			.MemRead(memRead),
			.MemWrite(memWrite),
			.Branch(Branch),
			.ALUOp(AluOp_s),
			.ALUSrc(AluSrc),
			.Exc(Exc),
			.ERet(ERet),
			.EStatus(EStatus)
		);
		

		aludec decAlu (
			.funct(instr),
			.aluop(AluOp_s),
			.alucontrol(AluControl)
		);

		// ExtIAck: ‘1’ cuando ExcAck = ‘1’ y ExtIRQ = ‘1’, caso contrario ‘0’
		assign ExtIAck = (ExcAck & ExtIRQ) & ~reset;

endmodule

