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
                    input [2:0] func3,
                    output reg branchTaken);
                    
    always @ * begin
        case(func3)
            `BR_BEQ:  branchTaken = z & branch;         
			`BR_BNE:  branchTaken = ~z & branch;        
			`BR_BLT:  branchTaken = (s != v) & branch;
			`BR_BGE:  branchTaken = (s == v) & branch;  
			`BR_BLTU: branchTaken = (~c) & branch;      
			`BR_BGEU: branchTaken = (c) & branch; 
			default:  branchTaken = 1'b0;
		endcase
    end
    
endmodule


