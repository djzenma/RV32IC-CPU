`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2018 06:34:31 PM
// Design Name: 
// Module Name: Interrupt_Detector
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


module Interrupt_Detector(
        input       nmi,
        input       ecall,
        input       ebreak,
        input       int,
        input       tmr,
        
        input       en_inter,
        
        input       en_nmi,
        input       en_ecall,
        input       en_ebreak,
        input       en_int,
        input       en_tmr,
        
        output      interFlag,
        output [2:0] interSel 
);

assign interFlag = (en_nmi && nmi) || (en_int && int && en_inter) || (en_tmr && tmr && en_inter) || (en_ecall && ecall) || (en_ebreak && ebreak && en_inter);

assign interSel =   (nmi)    ? `NMI:
                    (ebreak) ? `EBREAK :
                    (tmr)    ? `TMR:
                    (int)    ? `INT:
                    `ECALL;
endmodule
