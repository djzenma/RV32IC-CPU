`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 10:23:44 PM
// Design Name: 
// Module Name: RegSrcUnit
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


module RegSrcUnit(
        input clk,
        input regWrite,
        output reg regMuxSelect
);

    always @(negedge clk) begin
        if(!regWrite && !clk)
        if(regWrite)
            regMuxSelect = 1'b1;
        else
            regMuxSelect = 1'b0;
    end
    
    always @(posedge clk) begin
        regMuxSelect = 1'b0;
     end
        
    
    
endmodule
