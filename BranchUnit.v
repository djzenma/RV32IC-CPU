`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 06:53:37 PM
// Design Name: 
// Module Name: BranchUnit
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


module BranchUnit(  input branch,
                    input s,
                    input z,
                    input c,
                    input v,
                    output branchTaken);
             
    assign EQ = z;
    assign NE = ~z;
    assign LT = (s != v);
    assign GE = (s == v);
    assign LTU = ~c;
    assign GEU = c;
    
    assign branchTaken = (LT || GE || LTU || GEU || EQ || NE) && branch;   
    
endmodule
