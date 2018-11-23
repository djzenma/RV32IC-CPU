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

    wire [31:0] sum, difference;
    reg  [31:0] tempA, tempB;
    wire        cout, ci;

    always @ (*) begin
        case (sel)
            
            `ALU_ADD: begin
                result = a + b; 
//                $display("Add result: %d + %d = %d", a, b, result);
            end
            `ALU_SUB: begin
                result = a - b;
                $display("Add result: %d + %d = %d", a, b, result);
            end
            `ALU_PASS:result = result;  
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
                else
                    tempA = tempA;
                if (b[31])
                    tempB = (~b) + 1;
                else
                    tempB = tempB;
                result = ( tempA < tempB ) ? 1 : 0;
            end
            default: result = 0;
        endcase

    end
    
    RippleAdder rca (
        .a(a), 
        .b(b),
        .ci(1'b0),
        .s(sum),
        .co(cout),
        .last_ci(ci)
    );
    assign difference = a - b;
    assign z = (difference == 0) ? 1 : 0;
    assign s = result[31];
    assign c = cout;
    assign v = (ci^cout);
    
endmodule

