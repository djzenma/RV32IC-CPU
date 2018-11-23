`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2018 10:28:16 PM
// Design Name: 
// Module Name: memAddressSelectUnit
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


module memAddressSelectUnit(
    input clk_fast,
    input clk_slow,
    output reg select
    );
    
    always @ (posedge clk_fast) begin
        if(clk_slow == 0)
            select = 0;
        else
            select = 1;
    end
    
endmodule
