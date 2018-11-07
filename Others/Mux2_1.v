// file: Mux2_1.v
// author: @cherifsalama

`timescale 1ns/1ns

module Mux2_1 (
    sel,
    in1,
    in2,
    out
);
    parameter N=1;
    output [N-1:0] out;
    input [N-1:0] in1, in2;
    input sel;
    
    assign out = (sel) ? in2 : in1;
endmodule

