`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2018 06:41:27 PM
// Design Name: 
// Module Name: SignExtend
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


module SignExtend #(parameter size=16) (input [size:0] in, output [31:0] out);

wire[size-1:0] temp;

genvar i;

generate
    for(i=0; i<size; i=i+1) 
        assign temp[i] = in[size-1];
endgenerate

assign out = {temp, in};

endmodule
