// file: Decoder5_32.v
// author: @cherifsalama

`timescale 1ns/1ns

module Decoder5_32 (
    input en,
    input [4:0] dec_in, 
    output [31:0] dec_out
);

    assign dec_out = en?(1<<dec_in):0;
endmodule

