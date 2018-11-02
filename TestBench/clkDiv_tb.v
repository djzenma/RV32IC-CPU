`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2018 12:18:05 AM
// Design Name: 
// Module Name: clkDiv_tb
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


module clkDiv_tb( );
reg clk, rst;
wire clk_o, clk_oRF;

ClkDiv clkD (clk, rst, clk_o);
ClkDivRF clkDRF (clk, rst, clk_oRF);

always begin
clk=~clk;
#10;
end

initial begin
clk = 0;
rst = 1;
#15;
rst = 0;
end

endmodule
