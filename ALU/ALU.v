// file: ALU.v
// author: Engineer Mazen Amr & Engineer Mohamed Hossam

`timescale 1ns/1ns

module ALU(
    input [3:0]       sel,
    input [31:0]      a,
    input [31:0]      b,
    output reg [31:0] result,
    output            z,
    output            s,
    output            c,
    output            v
);

    wire [31:0] sum_diff, sum;
    reg  [31:0] tempA, tempB;
    wire        sub, cout, ci;

    assign sub = (sel == 6) ?1:0;

    AdderSub a1 (sub, a, b, sum_diff);

    always @ (*) begin
        case (sel)
//            4'b0010: result = sum_diff;
//            4'b0110: result = sum_diff;
            
            `ALU_ADD: result = a + b;
            `ALU_SUB: result = a - b;
            `ALU_PASS:result = b;  
            `ALU_OR:  result = a | b;
            `ALU_AND: result = a & b;
            `ALU_XOR: result = a ^ b;
            `ALU_SRL: result = a >> b;
            `ALU_SRA: result = a >>> b;
            `ALU_SLL: result = a << b;
            `ALU_SLT: result = (a<b) ? 1 : 0;
            `ALU_SLTU: begin
                if (a[31])
                    tempA = (~a) + 1;
                if (b[31])
                    tempB = (~b) + 1;
                result = ( tempA < tempB ) ? 1 : 0;
            end
            default: result = 0;
        endcase

    end
    
    RippleAdder rca (
        .a(a), 
        .b(b),
        .ci(0),
        .s(sum),
        .co(cout),
        .last_ci(ci)
    );
    
    assign z = (c == 0) ? 1:0;
    assign s = result[31];
    assign c = cout;
    assign v = (ci^cout);
    
endmodule

