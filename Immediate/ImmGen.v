`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2018 06:44:53 PM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen (output [31:0] gen_out, input [31:0] inst);

wire [11:0] imm;     
assign imm = inst[6]?({inst[31],inst[7],inst[30:25],inst[11:8]}):
                      (inst[5]?{inst[31:25],inst[11:7]}:inst[31:20]);     
                                  
assign gen_out = {{20{imm[11]}},imm}; 

endmodule 
