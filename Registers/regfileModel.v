`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2018 11:02:30 PM
// Design Name: 
// Module Name: regfileModel
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


module regfileModel( input clk, input rst, input en, input[4:0] rs1, input[4:0] rs2, input[4:0] rd, input[31:0] RegW, output[31:0] RegR1, output[31:0] RegR2);
    wire[4:0] regsrc;
    RegFile rf (.clk        (~clk),
                .rst        (rst),
                .WriteEn    (en),
                .rs1_rd     (regsrc),
                .rs2        (rs2),
                .write_data (RegW),
                .read_data1 (RegR1),
                .read_data2 (RegR2)
        );
        Mux2_1#(5) MuxregFile (.sel (en),
                                 .in1 (rs1),
                                 .in2 (rd),
                                 .out (regsrc)
        );
                  
endmodule
