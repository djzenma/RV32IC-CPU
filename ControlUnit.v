// file: ControlUnit.v
// author: @cherifsalama

`timescale 1ns/1ns

module ControlUnit (
    input [2:0] opcode,
    output Branch,
    output MemRead,
    output MemToReg,
    output [1:0] ALUOp,
    output MemWrite,
    output ALUSrc,
    output RegWrite
);
    
    assign Branch = (opcode==6)?1:0;
    assign MemRead = (opcode==0)?1:0;
    assign MemToReg = (opcode==0)?1:0;
    assign ALUOp[1] = (opcode==3)?1:0;
    assign ALUOp[0] = (opcode==6)?1:0;
    assign MemWrite = (opcode==2)?1:0;
    assign ALUSrc = ((opcode==0)||(opcode==2))?1:0;
    assign RegWrite = ((opcode==0)||(opcode==3))?1:0;
endmodule

