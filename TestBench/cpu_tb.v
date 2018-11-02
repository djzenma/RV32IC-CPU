`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2018 09:19:49 PM
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();

reg clk, rst;
reg[3:0] ssdSel;
reg[1:0] ledSel;

wire[15:0] leds;
wire[12:0] ssd;


RISCV cpu (clk, rst, ledSel, ssdSel, leds, ssd);

always begin
clk=~clk;
#10;

end


initial begin
clk=1;
rst=1;

#20;
rst=0;
end

endmodule
