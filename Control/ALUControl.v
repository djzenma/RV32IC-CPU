// file: ALUControl.v
// author: @cherifsalama

`timescale 1ns/1ns

module ALUControl(
    input [1:0]      ALUOp,
    input [2:0]      func3,
    input [6:0]      func7,
    output reg [3:0] sel
);

    always @(*) begin
        case (ALUOp)
            `ALUOP_ADD: sel = `ALU_ADD; //add
            `ALUOP_SUB: sel = `ALU_SUB;  //sub
            `ALUOP_OTHER: begin
                sel =   (func3 == `F3_SLL) ? `ALU_SLL:      // TODO :: convert to case
                        (func3 == `F3_SLT) ? `ALU_SLT:
                        (func3 == `F3_SLTU) ? `ALU_SLTU:
                        (func3 == `F3_XOR) ? `ALU_XOR:
                        (func3 == `F3_SRL) ? `ALU_SRL:
                        (func3 == `F3_OR) ? `ALU_OR:
                        (func3 == `F3_AND) ? `ALU_AND:
                        (func3 == `F3_SRL && func7 == `F7_SRA) ? `ALU_SRA:
                        `ALU_ADD;
            end
            default : sel = `ALU_ADD;
        endcase
    end

endmodule

