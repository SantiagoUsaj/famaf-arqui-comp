`timescale 1ns / 1ps



module execute_tb;

    // Parámetro
    parameter N = 64;

    // Entradas
    logic AluSrc;
    logic [3:0] AluControl;
    logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E;

    // Salidas
    logic [N-1:0] PCBranch_E, aluResult_E, writeData_E;
    logic zero_E;

    // Instancia del módulo bajo prueba
    execute #(N) dut (
        .AluSrc(AluSrc),
        .AluControl(AluControl),
        .PC_E(PC_E),
        .signImm_E(signImm_E),
        .readData1_E(readData1_E),
        .readData2_E(readData2_E),
        .PCBranch_E(PCBranch_E),
        .aluResult_E(aluResult_E),
        .writeData_E(writeData_E),
        .zero_E(zero_E)
    );

    initial begin
        // Test 1: ALU suma, AluSrc=0 (readData2_E)
        AluSrc      = 0;
        AluControl  = 4'b0010; // Suma
        PC_E        = 64'd100;
        signImm_E   = 64'd8;
        readData1_E = 64'd15;
        readData2_E = 64'd5;
        #1;
        $display("Test 1: ALU suma, AluSrc=0");
        $display("aluResult_E=%d (esperado 20)", aluResult_E);
        $display("writeData_E=%d (esperado 5)", writeData_E);
        $display("PCBranch_E=%d (esperado 100+8*4=132)", PCBranch_E);
        $display("zero_E=%b (esperado 0)", zero_E);

        // Test 2: ALU suma, AluSrc=1 (signImm_E)
        AluSrc      = 1;
        AluControl  = 4'b0010; // Suma
        PC_E        = 64'd200;
        signImm_E   = 64'd4;
        readData1_E = 64'd10;
        readData2_E = 64'd3;
        #1;
        $display("Test 2: ALU suma, AluSrc=1");
        $display("aluResult_E=%d (esperado 14)", aluResult_E);
        $display("writeData_E=%d (esperado 3)", writeData_E);
        $display("PCBranch_E=%d (esperado 200+4*4=216)", PCBranch_E);
        $display("zero_E=%b (esperado 0)", zero_E);

        // Test 3: ALU resta, resultado cero
        AluSrc      = 0;
        AluControl  = 4'b0110; // Resta
        PC_E        = 64'd0;
        signImm_E   = 64'd0;
        readData1_E = 64'd7;
        readData2_E = 64'd7;
        #1;
        $display("Test 3: ALU resta, resultado cero");
        $display("aluResult_E=%d (esperado 0)", aluResult_E);
        $display("zero_E=%b (esperado 1)", zero_E);

        // Test 4: ALU AND
        AluSrc      = 1;
        AluControl  = 4'b0000; // AND
        PC_E        = 64'd10;
        signImm_E   = 64'hFF00FF00FF00FF00;
        readData1_E = 64'hFFFF0000FFFF0000;
        readData2_E = 64'd0; // Ignorado
        #1;
        $display("Test 4: ALU AND");
        $display("aluResult_E=%h (esperado FF000000FF000000)", aluResult_E);

        // Test 5: ALU OR
        AluSrc      = 1;
        AluControl  = 4'b0001; // OR
        PC_E        = 64'd0;
        signImm_E   = 64'h0000FFFF0000FFFF;
        readData1_E = 64'h00FF00FF00FF00FF;
        readData2_E = 64'd0; // Ignorado
        #1;
        $display("Test 5: ALU OR");
        $display("aluResult_E=%h (esperado 00FFFFFF00FFFFFF)", aluResult_E);

        $display("Fin de los tests de execute_tb.");
        $stop;
    end

endmodule