`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2018 04:59:22 PM
// Design Name: 
// Module Name: Mux
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


module Mux(input [31:0] a, input[31:0] b, input sel, output [31:0]out);
assign out= sel? b:a;

endmodule


module Mux2x1(input a, input b, input sel, output out);
assign out= sel? b:a;

endmodule
