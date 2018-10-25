`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2018 07:03:57 PM
// Design Name: 
// Module Name: CU
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


module CU(input[2:0] opcode, output Branch, output MemRead, output MemToReg, output[1:0] ALUOp, output MemWrite, output ALUSrc, output RegWrite);

    assign Branch = (opcode==6)?1:0;
    assign MemRead = (opcode==0)?1:0;
    assign MemToReg = (opcode==0)?1:0;
    assign ALUOp[1] = (opcode==3)?1:0;
    assign ALUOp[0] = (opcode==6)?1:0;
    assign MemWrite = (opcode==2)?1:0;
    assign ALUSrc = ((opcode==0)||(opcode==2))?1:0;
    assign RegWrite = ((opcode==0)||(opcode==3))?1:0;
endmodule


module AluCu (input[1:0] ALUOp, input[14:12] Inst,input Inst30, output reg[3:0] ALUSelection);
always @(*) begin
    case(ALUOp)
    2'b00: ALUSelection <= 2;
    2'b01: ALUSelection <= 6;
    2'b10: begin
        if(Inst==0) begin
            if(Inst30)
                ALUSelection <= 6;
            else
                ALUSelection <= 2;
        end
        else if(Inst==7)
             ALUSelection <= 0;
        else    
             ALUSelection <= 1;
        end
    default:
        ALUSelection <= 3; // default for alu so res is 0
    endcase
end
endmodule
