`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2018 06:27:17 PM
// Design Name: 
// Module Name: regFileTest
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


module regFileTest();

reg clk, rst, regWrite;
reg[4:0] reg1, reg2, regDest;
reg[31:0] writeData;

wire[31:0] read1, read2;

RegFile regFile (clk, rst, reg1, reg2, regDest, writeData, regWrite, read1, read2);

always
#10 clk=~clk;
    
    
initial begin
    clk=0;
    rst=1;
    regWrite=0;
    
    #15
    rst=0;
    reg1=0;
    reg2=2;
    regDest=2;
    regWrite=0;
    
    #20
    writeData=5;
    regWrite=1;
    
    #20
    regWrite=0;
end



endmodule
