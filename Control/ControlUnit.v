// file: ControlUnit.v
// author: @cherifsalama

`timescale 1ns/1ns

module ControlUnit(
    input [31:0] instr,
    input  [4:0] opcode,
    output       Branch,
    output [1:0] Jump,
    output       MemRead,
    output       MemToReg,
    output [1:0] ALUOp,
    output       MemWrite,
    output       ALUSrc,
    output       RegWrite, 
    output [2:0] Mode
);
    
    assign Jump = (opcode == `OPCODE_JAL) ? 2'b01: 
                  (opcode == `OPCODE_JALR) ? 2'b10:
                  2'b00;
    assign Branch = (opcode == `OPCODE_Branch) ? 1:0;
    assign MemRead = (opcode == `OPCODE_Load) ? 1 :0;
    assign MemToReg = (opcode == `OPCODE_Load) ? 1:0;
    assign MemWrite = (opcode == `OPCODE_Store) ? 1:0;
    assign ALUSrc = ((opcode == `OPCODE_Arith_I) || (opcode == `OPCODE_Store) || (opcode == `OPCODE_Load)) ? 1:0;
    assign RegWrite = ((opcode == `OPCODE_Load) || (opcode == `OPCODE_Arith_R)) ? 1:0;
    
    assign Mode = (opcode == `OPCODE_Store && instr[14:12] == `S_SW) ? `MEM_W:
                    (opcode == `OPCODE_Store && instr[14:12] == `S_SH) ? `MEM_HW:
                    (opcode == `OPCODE_Store && instr[14:12] == `S_SB) ? `MEM_B:
                    (opcode == `OPCODE_Load && instr[14:12] == `L_LW) ? `MEM_W:
                    (opcode == `OPCODE_Load && instr[14:12] == `L_LH) ? `MEM_HW:
                    (opcode == `OPCODE_Load && instr[14:12] == `L_LB) ? `MEM_B:
                    (opcode == `OPCODE_Load && instr[14:12] == `L_LBU) ? `MEM_B:
                    (opcode == `OPCODE_Load && instr[14:12] == `L_LHU) ? `MEM_HW:
                    `MEM_W;      // Default reading mode is word
                    
    assign ALUOp =  (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_ADD)?  `ALUOP_ADD :      // R aluOps
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_ADD && instr[31:25] == `F7_SUB)?  `ALUOP_SUB :
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_SLL)?  `ALUOP_OTHER :
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_SLT)?  `ALUOP_OTHER :
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_SLTU)? `ALUOP_OTHER :
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_XOR)?  `ALUOP_OTHER :
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_SRL)?  `ALUOP_OTHER :
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_OR) ?  `ALUOP_OTHER :
                    (opcode == `OPCODE_Arith_R && instr[14:12] == `F3_AND)?  `ALUOP_OTHER :
                    
                    (opcode == `OPCODE_Branch && instr[14:12] == `BR_BEQ) ? `ALUOP_SUB :
                    (opcode == `OPCODE_Branch && instr[14:12] == `BR_BNE) ? `ALUOP_SUB :
                    (opcode == `OPCODE_Branch && instr[14:12] == `BR_BLT) ? `ALUOP_SUB :
                    (opcode == `OPCODE_Branch && instr[14:12] == `BR_BGE) ? `ALUOP_SUB :
                    (opcode == `OPCODE_Branch && instr[14:12] == `BR_BLTU)? `ALUOP_SUB :     // TODO
                    (opcode == `OPCODE_Branch && instr[14:12] == `BR_BGEU)? `ALUOP_SUB :     // TODO
                    `ALU_PASS;              // Default Value if opcode not defined

endmodule
