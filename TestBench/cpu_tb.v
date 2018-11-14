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


RISCV_TOP cpuTest (    
    .clk(clk),
    .rst(rst),
    .en_inter(1'b0),
    .intReq(8'b0),
    .nmi(1'b0)
);

always begin
clk=~clk;
#10;
end

initial begin
clk=0;
rst=1;

#20;
rst=0;
end

endmodule
