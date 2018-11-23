// file: AdderSub.v
// author: @cherifsalama

`timescale 1ns/1ns

module AdderSub (
    input sub,
    input [31:0] a,
    input [31:0] b,
    output [31:0] s
);

    wire co;
    wire ci;
    wire [31:0] b2;
    
    assign ci=sub?1:0;
    assign b2=sub?~b:b;
    
    RippleAdder r(a,b2,ci,s,co);
endmodule

