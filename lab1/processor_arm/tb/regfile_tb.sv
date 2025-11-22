`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 17:57:06
// Design Name: 
// Module Name: regfile_tb
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

module regfile_tb();
    logic clk, we3;
    logic [4:0] ra1, ra2, wa3;
    logic [63:0] wd3, rd1, rd2;
    int error = 0;

    regfile dut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);

    // Generador de reloj 100MHz
    initial clk = 0;
    always #5 clk = ~clk;

    // Test principal
    initial begin
        // Verificar inicialización de todos los registros
        for (int i = 0; i < 32; i++) begin
            ra1 = i;
            ra2 = i;
            #1;
            if (i == 31) begin
                assert(rd1 == 0) else begin
                    $display("Error: XZR (reg 31) no es cero en rd1");
                    error++;
                end
                assert(rd2 == 0) else begin
                    $display("Error: XZR (reg 31) no es cero en rd2");
                    error++;
                end
            end else begin
                assert(rd1 == i) else begin
                    $display("Error: reg %0d incorrecto en rd1, esperado %0d, obtenido %0d", i, i, rd1);
                    error++;
                end
                assert(rd2 == i) else begin
                    $display("Error: reg %0d incorrecto en rd2, esperado %0d, obtenido %0d", i, i, rd2);
                    error++;
                end
            end
        end

        // Escribir en registro 4 y leerlo
        wa3 = 5'd4;
        wd3 = 64'hFFF;
        we3 = 1;
        ra1 = 5'd4;
        @(posedge clk);
        #2;
        assert(rd1 == 64'hFFF) else begin
            $display("Error: Escritura/lectura en reg 4 fallida");
            error++;
        end

        // Verificar que no se altera si we3=0
        wa3 = 5'd5;
        wd3 = 64'h123456789ABCDEF0;
        we3 = 0;
        ra1 = 5'd5;
        @(posedge clk);
        #2;
        assert(rd1 == 5) else begin
            $display("Error: reg 5 alterado con we3=0");
            error++;
        end

        // Escribir en XZR (reg 31) y verificar que siempre es cero
        wa3 = 5'd31;
        wd3 = 64'hFFFFFFFFFFFFFFFF;
        we3 = 1;
        ra1 = 5'd31;
        @(posedge clk);
        #2;
        assert(rd1 == 0) else begin
            $display("Error: XZR (reg 31) alterado tras escritura");
            error++;
        end

        // Lectura asíncrona de XZR en cualquier momento
        ra1 = 5'd31;
        ra2 = 5'd31;
        #1;
        assert(rd1 == 0 && rd2 == 0) else begin
            $display("Error: XZR (reg 31) no es cero en lectura asíncrona");
            error++;
        end

        if (error == 0)
            $display("Todos los tests pasaron correctamente.");
        else
            $display("Testbench finalizado con %0d errores.", error);

        $finish;
    end

endmodule
