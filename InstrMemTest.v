`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2018 06:17:44 PM
// Design Name: 
// Module Name: InstrMemTest
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


module InstrMemTest();
    reg [5:0] addr;
    wire [31:0] data_out;
    
    InstMem instM (addr, data_out);    
    
    initial
        addr=1;
        
    
endmodule
