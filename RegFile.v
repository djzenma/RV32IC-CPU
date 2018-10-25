`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2018 05:38:25 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile(input clk, input rst, input[4:0] reg1, input[4:0] reg2, input[4:0] regDest, input[31:0] writeData, input regWrite,
            output[31:0] read1, output[31:0] read2);
    wire[31:0] A[31:0];
    wire[31:0] regIndex;
    genvar i;
    
    assign read1 = A[reg1];
    assign read2 = A[reg2];
    
    assign regIndex = regWrite ? (1<<regDest) : 0;

   generate
         for(i=0; i<32; i=i+1) begin :rcaloop
             Register register (rst, clk, writeData, regIndex[i], A[i]);
         end
   endgenerate
            
endmodule
