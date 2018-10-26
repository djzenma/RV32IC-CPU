`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2018 07:27:05 PM
// Design Name: 
// Module Name: aluTest
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


module aluTest();

    reg[31:0] a, b;
    reg clk;
    reg [3:0] select;
    
    wire zero;
    wire[31:0] res;
    
    Alu alu (clk, a, b , select, zero, res);
    
    always @*
    clk=~clk;
    
    initial begin
    #10;
    a=31;
    b=31;
    select= 4'b0110;
    clk=0;

    end
    
    
endmodule
