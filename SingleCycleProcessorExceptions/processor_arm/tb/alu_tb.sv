`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2025 12:39:20
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();

    logic [63:0] a, b;
    logic [3:0] ALUControl;
    logic [63:0] result, resultEspereado;
    logic zero, zeroEspereado;

    alu dut (
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .result(result),
        .zero(zero)
    );

    initial begin
        // Prueba 1: a AND b
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000000;
        ALUControl = 4'b0000;
        resultEspereado = 64'h0000000000000000;
        zeroEspereado = 1;
        #10;
        assert(result == resultEspereado) else $fatal("Test 1 Fallido: Esperado %h, Obtenido %h", resultEspereado, result);
        assert(zero == zeroEspereado) else $fatal("Test 1 Fallido: Esperado zero %b, Obtenido zero %b", zeroEspereado, zero);

        // Prueba 2: a OR b
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000000;
        ALUControl = 4'b0001;
        resultEspereado = 64'hFFFFFFFFFFFFFFFF;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado) else $fatal("Test 2 Fallido: Esperado %h, Obtenido %h", resultEspereado, result);
        assert(zero == zeroEspereado) else $fatal("Test 2 Fallido: Esperado zero %b, Obtenido zero %b", zeroEspereado, zero);

        // Prueba 3: a + b
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000001;
        ALUControl = 4'b0010;
        resultEspereado = 64'h0000000000000000;
        zeroEspereado = 1;
        #10;
        assert(result == resultEspereado) else $fatal("Test 3 Fallido: Esperado %h, Obtenido %h", resultEspereado, result);
        assert(zero == zeroEspereado) else $fatal("Test 3 Fallido: Esperado zero %b, Obtenido zero %b", zeroEspereado, zero);

        // Prueba 4: a - b
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000001;
        ALUControl = 4'b0110;
        resultEspereado = 64'hFFFFFFFFFFFFFFFE;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado) else $fatal("Test 4 Fallido: Esperado %h, Obtenido %h", resultEspereado, result);
        assert(zero == zeroEspereado) else $fatal("Test 4 Fallido: Esperado zero %b, Obtenido zero %b", zeroEspereado, zero);

        // Prueba 5: b
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000001;
        ALUControl = 4'b0111;
        resultEspereado = 64'h0000000000000001;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado) else $fatal("Test 5 Fallido: Esperado %h, Obtenido %h", resultEspereado, result);
        assert(zero == zeroEspereado) else $fatal("Test 5 Fallido: Esperado zero %b, Obtenido zero %b", zeroEspereado, zero);

        // AND: positivos
        a = 64'h00000000000000FF;
        b = 64'h00000000000000F0;
        ALUControl = 4'b0000;
        resultEspereado = 64'h00000000000000F0;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // AND: negativos
        a = -64'd2;
        b = -64'd4;
        ALUControl = 4'b0000;
        resultEspereado = -64'd4 & -64'd2;
        zeroEspereado = (resultEspereado == 0);
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // AND: uno positivo, uno negativo
        a = 64'd5;
        b = -64'd1;
        ALUControl = 4'b0000;
        resultEspereado = 64'd5 & -64'd1;
        zeroEspereado = (resultEspereado == 0);
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // OR: positivos
        a = 64'h00000000000000F0;
        b = 64'h000000000000000F;
        ALUControl = 4'b0001;
        resultEspereado = 64'h00000000000000FF;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // OR: negativos
        a = -64'd8;
        b = -64'd16;
        ALUControl = 4'b0001;
        resultEspereado = -64'd8 | -64'd16;
        zeroEspereado = (resultEspereado == 0);
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // OR: uno positivo, uno negativo
        a = 64'd7;
        b = -64'd1;
        ALUControl = 4'b0001;
        resultEspereado = 64'd7 | -64'd1;
        zeroEspereado = (resultEspereado == 0);
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // SUMA: positivos
        a = 64'd100;
        b = 64'd200;
        ALUControl = 4'b0010;
        resultEspereado = 64'd300;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // SUMA: negativos
        a = -64'd50;
        b = -64'd25;
        ALUControl = 4'b0010;
        resultEspereado = -64'd75;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // SUMA: uno positivo, uno negativo
        a = 64'd100;
        b = -64'd100;
        ALUControl = 4'b0010;
        resultEspereado = 0;
        zeroEspereado = 1;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // RESTA: positivos
        a = 64'd200;
        b = 64'd100;
        ALUControl = 4'b0110;
        resultEspereado = 64'd100;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // RESTA: negativos
        a = -64'd100;
        b = -64'd50;
        ALUControl = 4'b0110;
        resultEspereado = -64'd50;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // RESTA: uno positivo, uno negativo
        a = 64'd50;
        b = -64'd50;
        ALUControl = 4'b0110;
        resultEspereado = 64'd100;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // OVERFLOW: suma de dos grandes positivos
        a = 64'h7FFFFFFFFFFFFFFF;
        b = 64'h7FFFFFFFFFFFFFFF;
        ALUControl = 4'b0010;
        resultEspereado = 64'hFFFFFFFFFFFFFFFE;
        zeroEspereado = 0;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        // OVERFLOW: suma de dos grandes negativos
        a = 64'h8000000000000000;
        b = 64'h8000000000000000;
        ALUControl = 4'b0010;
        resultEspereado = 64'h0000000000000000;
        zeroEspereado = 1;
        #10;
        assert(result == resultEspereado);
        assert(zero == zeroEspereado);

        $stop;
    end

endmodule
