`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2018 06:13:20 PM
// Design Name: 
// Module Name: RISCV_TOP
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


module RISCV_TOP(    
    input       clk,
    input       rst,
    input       en_inter,
    input [7:0] intReq,
    input       nmi,
    output [31:0] out
);

wire int; 
wire [2:0] int_num;

PIC pic (.intReq(intReq), .Int(int), .Int_Num(int_num));

RISCV CPU (
        .clk_i(clk),
        .rst(rst),
        .en_inter(1'b1),
        .int(int),
        .int_num(int_num),
        .nmi(nmi),
        .en_nmi(1'b0),
        .en_ecall(1'b1),
        .en_ebreak(1'b0),
        .en_int(1'b0),
        .en_tmr(1'b1),
        .limit(0),
        .out(out)
);          

endmodule
