// file: ShiftLeft1.v
// author: @cherifsalama

`timescale 1ns/1ns

module ShiftLeft1 (
    input [31:0] d_in,
    output [31:0] d_out 
);

    assign d_out = {d_in,1'b0};
endmodule

module ShiftLeft2 (
    input [25:0] d_in,
    output [31:0] d_out 
);

    assign d_out = {d_in,2'b0};
endmodule


module ShiftLeft #(parameter shamt=0) (
    input [31:0] d_in,
    output [31:0] d_out 
);

assign d_out = d_in << shamt;

endmodule