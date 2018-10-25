`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2018 06:44:46 PM
// Design Name: 
// Module Name: testSignXtender
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



module testSignXtender(
    );
        reg [11:0] a;
        wire[31:0] out;
        
        Sign_Extend mobs( a, out);
        
        initial begin
         a=-3;#10;
        
        end
 
endmodule
