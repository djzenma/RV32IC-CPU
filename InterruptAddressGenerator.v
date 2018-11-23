`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2018 08:05:36 PM
// Design Name: 
// Module Name: InterruptAddressGenerator
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


module InterruptAddressGenerator(
    input             interruptF,
    input      [2:0]  interSel,
    input             intNum,
    output reg [31:0] addr
);

always @(*) begin
    if(interruptF) begin
        case(interSel)
            `NMI:   addr = 32'h10;
            `ECALL: addr = 32'h20;
            `EBREAK:addr = 32'h30;
            `TMR:   addr = 32'h40;
            `INT:   addr = 32'h100 + (intNum * 32'h10);
        endcase
    end
end

endmodule
