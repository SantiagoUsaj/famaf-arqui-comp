`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2025 09:36:14
// Design Name: 
// Module Name: signext
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


module signext
    (
        input logic [31:0] a,
        output logic [63:0] y
    );

    always_comb
    casez (a[31:21])
        // LDUR
        11'b111_1100_0010:
            y = {{55{a[20]}},a[20:12]};
        // STUR
        11'b111_1100_0000:
            y = {{55{a[20]}},a[20:12]};
        // CBZ
        11'b101_1010_0???:
            y = {{45{a[23]}},a[23:5]};
        // LSL
        11'b110_1001_1011:
            y = {58'd0, a[15:10]};
        // LSR
        11'b110_1001_1010:
            y = {58'd0, a[15:10]};        
        // DEFAULT
        default:
            y = '0;
    endcase   

endmodule



