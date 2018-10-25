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



module Shifter(input [31:0] a, output [31:0]out);

assign out = {a[30:0],1'b0};

endmodule


module Sign_Extend(input [11:0] a, output [31:0]out);
wire[19:0] sign;
genvar i;

generate 
    for( i = 0; i <= 19; i=i+1) begin :signX
        assign sign[i]=a[11];
    end
endgenerate

assign out = {sign, a};

endmodule