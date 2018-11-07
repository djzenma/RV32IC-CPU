// file: ImmGen.v
// author: @cherifsalama

`timescale 1ns/1ns

module ImmGen (
    input  wire [31:0]  IR,
    output reg  [31:0]  Imm
);

always @(*) begin
	case (`OPCODE)
		`OPCODE_Arith_I   : 	Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] };
		`OPCODE_Store     :     Imm = { {21{IR[31]}}, IR[30:25], IR[11:8], IR[7] };
		`OPCODE_LUI       :     Imm = { IR[31], IR[30:20], IR[19:12], 12'b0 };
		`OPCODE_AUIPC     :     Imm = { IR[31], IR[30:20], IR[19:12], 12'b0 };
		`OPCODE_JAL       : 	Imm = { {12{IR[31]}}, IR[19:12], IR[20], IR[30:25], IR[24:21], 1'b0 };
		`OPCODE_JALR      : 	Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] };
		`OPCODE_Branch    : 	Imm = { {20{IR[31]}}, IR[7], IR[30:25], IR[11:8], 1'b0};
		default           : 	Imm = { {21{IR[31]}}, IR[30:25], IR[24:21], IR[20] }; // IMM_I
	endcase 
end

endmodule


