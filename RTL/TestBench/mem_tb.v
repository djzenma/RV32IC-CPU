`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2018 10:34:55 PM
// Design Name: 
// Module Name: mem_tb
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


module mem_tb();

reg         clk, rst, MemRead, MemWrite;
reg  [1:0]  mode;
    reg  [5:0]  addr;
    reg  [31:0] data_in;
    wire [31:0] data_out;
    
    Memory MEM (clk, rst,MemRead,MemWrite,mode,addr,data_in,data_out);
    
    always begin
    clk=~clk;
    #10;
    
    end
    
    initial begin
    clk=0;
    rst=1;
    MemWrite = 0;
    mode=0;
    addr=0;
    data_in=15;
    
    #20;
    MemRead=1;
    
    end

endmodule
