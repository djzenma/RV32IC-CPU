`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2018 06:48:56 PM
// Design Name: 
// Module Name: ImmGenTest
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


module ImmGenTest();
wire [31:0] gen_out;
reg [31:0] inst;

ImmGen gen (gen_out, inst);

initial 
    inst = 32'b0000000_00001_00000_010_00011_0100011;
    
endmodule
