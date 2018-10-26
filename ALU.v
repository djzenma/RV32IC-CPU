// file: ALU.v
// author: @cherifsalama

`timescale 1ns/1ns

module ALU(
    input [3:0] sel,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] c,
    output z
);
    
    wire [31:0] sum_diff;
    wire sub;
    
    assign sub = (sel==6)?1:0;

    AdderSub a1(sub,a,b,sum_diff);

    always @(*) begin
        case(sel)
            4'b0010: c=sum_diff;
            4'b0110: c=sum_diff;
            4'b0000: c=a&b;
            4'b0001: c=a|b;
            default: c=0;
        endcase
        
    end
    assign z=(c==0)?1:0;
endmodule

