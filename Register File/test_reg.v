`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2018 05:20:40 PM
// Design Name: 
// Module Name: test_reg
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


module test_reg();
reg res, clk;
reg [31:0] a;
reg load;
wire [31:0]out;

    Register reg1 (res, clk, a, load, out);     
    
    initial begin
    clk=0;
    a=3;
    load=0;
    res=1;
    end
    
    always #5 clk=~clk;
    
    always begin 
    #10 
    res = 0;
    end
       
          
endmodule
