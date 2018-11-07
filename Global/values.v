`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2018 07:51:20 PM
// Design Name: 
// Module Name: values
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`define     IR_rs1          19:15
`define     IR_rs2          24:20
`define     IR_rd           11:7
`define     IR_opcode       6:2
`define     IR_funct3       14:12
`define     IR_funct7       31:25
`define     IR_shamt        24:20
`define     IR_csr          31:20


`define     OPCODE_Branch   5'b11_000
`define     OPCODE_Load     5'b00_000
`define     OPCODE_Store    5'b01_000
`define     OPCODE_JALR     5'b11_001
`define     OPCODE_JAL      5'b11_011
`define     OPCODE_Arith_I  5'b00_100
`define     OPCODE_Arith_R  5'b01_100
`define     OPCODE_AUIPC    5'b00_101
`define     OPCODE_LUI      5'b01_101
`define     OPCODE_SYSTEM   5'b11_100 
`define     OPCODE_Custom   5'b10_001

// FUNC3
`define     F3_ADD          3'b000
`define     F3_SLL          3'b001
`define     F3_SLT          3'b010
`define     F3_SLTU         3'b011
`define     F3_XOR          3'b100
`define     F3_SRL          3'b101
`define     F3_OR           3'b110
`define     F3_AND          3'b111

// FUNC7
`define     F7_SRA          7'b0100000
`define     F7_SUB          7'b0100000

`define     BR_BEQ          3'b000
`define     BR_BNE          3'b001
`define     BR_BLT          3'b100
`define     BR_BGE          3'b101
`define     BR_BLTU         3'b110
`define     BR_BGEU         3'b111

`define     S_SW            3'b010
`define     S_SH            3'b001
`define     S_SB            3'b000

`define     L_LW            3'b010
`define     L_LH            3'b001
`define     L_LB            3'b000
`define     L_LBU           3'b100
`define     L_LHU           3'b101

`define     OPCODE          IR[`IR_opcode]

// ALUOp R Format
`define     ALUOP_ADD       2'b00
`define     ALUOP_SUB       2'b01
`define     ALUOP_OTHER     2'b10

// ALUOp R Format
`define     ALU_ADD         4'b00_00
`define     ALU_SUB         4'b00_01
`define     ALU_PASS        4'b00_11
`define     ALU_OR          4'b01_00
`define     ALU_AND         4'b01_01
`define     ALU_XOR         4'b01_11
`define     ALU_SRL         4'b10_00
`define     ALU_SRA         4'b10_10
`define     ALU_SLL         4'b10_01
`define     ALU_SLT         4'b11_01
`define     ALU_SLTU        4'b11_11


`define     MEM_W           3'b000
`define     MEM_HW          3'b001
`define     MEM_B           3'b010

`define     SYS_EC_EB       3'b000
`define     SYS_CSRRW       3'b001
`define     SYS_CSRRS       3'b010
`define     SYS_CSRRC       3'b011
`define     SYS_CSRRWI      3'b101
`define     SYS_CSRRSI      3'b110
`define     SYS_CSRRCI      3'b111
