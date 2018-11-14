`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2018 06:16:18 PM
// Design Name: 
// Module Name: PIC
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


module PIC(input [7:0] intReq, output Int, output[2:0] Int_Num);
    assign Int = (intReq[0] || intReq[1] || intReq[2] || intReq[3] || intReq[4] || intReq[5] || intReq[6] || intReq[7]);
    assign Int_Num =    (intReq[0]) ? 3'b000 :
                        (intReq[1]) ? 3'b001 :   
                        (intReq[2]) ? 3'b010 :
                        (intReq[3]) ? 3'b011 :   
                        (intReq[4]) ? 3'b100 :
                        (intReq[5]) ? 3'b101 :   
                        (intReq[6]) ? 3'b110 :
                        3'b111; 
endmodule
