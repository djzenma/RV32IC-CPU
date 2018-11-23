// file: Mux4_1.v
// author: @cherifsalama

`timescale 1ns/1ns

module Mux4_1 (
    sel,
    in1,
    in2,
    in3,
    in4,
    out
);

    parameter N=1;
    input [1:0] sel;
    input [N-1:0] in1, in2, in3, in4;
    output reg [N-1:0] out;
    
    always @(*) begin
        case(sel)
            2'b00: out = in1;
            2'b01: out = in2;
            2'b10: out = in3;
            2'b11: out = in4;
        endcase
    end
    
endmodule

