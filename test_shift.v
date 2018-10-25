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


module test_shift();

    reg [31:0] a;
    wire [31:0]out;
 
    Shifter shift (a, out);  
    
    initial begin
    a=3;#10;
    a=5;
    end
    

       
          
endmodule
