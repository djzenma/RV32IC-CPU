`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2018 06:29:48 PM
// Design Name: 
// Module Name: DataMemTest
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


module DataMemTest();

    reg clk, MemRead, MemWrite; 
    reg [5:0] addr;
    reg [31:0] data_in;
    wire [31:0] data_out;
    
    DataMem Mem( clk,MemRead,MemWrite,addr, data_in,data_out);
    initial begin
    clk=0;
    MemRead=1;
    MemWrite=1;
    addr=0;
    data_in=11;
    end
    
    always
    #10
     clk=~clk;
    
    
endmodule
