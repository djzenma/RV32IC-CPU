`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2018 12:15:23 AM
// Design Name: 
// Module Name: ClkDiv
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


module ClkDiv(input clk, input rst, output reg clk_o);

always @(posedge clk, posedge rst) begin
    if(rst)
        clk_o = 1'b1;
    else
        clk_o = ~clk_o;
end
endmodule