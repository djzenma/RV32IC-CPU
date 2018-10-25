`timescale 1ns / 1ps

 //0010, 0110, 0000, and 0001 

module Alu(input [31:0]a, input [31:0]b , input [3:0] select, output zero, output reg[31:0] res);
wire[31:0] sum, sub;

always @* begin
    case(select)
    
    4'b0010: begin
    res = sum; 
    end
    
    4'b0110: begin
    res = sub;
    end
    
    4'b0000: begin
    res =a&b;
    end
    
    4'b0001: begin
    res =a|b;
    end
    
    default: begin
    res = 0;
    end
    
    endcase
end

RCA summation (a,b, 0, sum);
RCA substr (a,b, 1, sub);

assign zero = (res)? 0:1; 

endmodule


module RCA(input[31:0] a, input[31:0] b, input op, output[31:0] res);
genvar i;
wire[31:0] c;

FA fa1 (a[0], b[0]^op, op, res[0], c[0]);

    generate
        for(i=1; i<32; i=i+1) begin :rcaloop
            FA fa (a[i], b[i]^op, c[i-1], res[i], c[i]);
        end
    endgenerate
    
    
endmodule 




module FA(input a, input b, input cin, output sum, output cout);

assign sum = (a^b)^cin;
assign cout = ((a^b)&cin)|(a&b);

endmodule