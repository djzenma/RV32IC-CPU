// file: ImmGen.v
// author: @cherifsalama

`timescale 1ns/1ns

module ImmGen (
    input [31:0] inst,
    output [31:0] d_out 
);

    wire [11:0] imm;
    assign imm = inst[6]?({inst[31],inst[7],inst[30:25],inst[11:8]}):
                            (inst[5]?{inst[31:25],inst[11:7]}:inst[31:20]);
    assign d_out = {{20{imm[11]}},imm};
endmodule


