`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2018 07:00:40 PM
// Design Name: 
// Module Name: CPU
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


module RISCV (     
    input rst, 
    input clk, 
    input d_clk, 
    input[1:0] ledSel, 
    input[3:0] ssdSel, 
    output reg[15:0] leds, 
    output[3:0] anode, 
    output[6:0] segmentDisp
);
/**
 * Declaration
 */
 
 wire[31:0] instr, PC_out, PC_mux_out, branch_addr, PC_4, shifted_addr, gen_addr, reg1, reg2, aluRes, alu_secondOperand, memDataOut, wb_out;
 wire branch_c, memRead_c, memToReg_c, memWrite_c, aluSrc_c, regWrite_c, zflag;
 wire[1:0] aluOp_c;
 wire[3:0] aluSelect_aluC;
 reg [12:0] disp;



wire [31:0] BranchAdder_out, ALU_out, Mem_out;        
wire [31:0] IF_ID_PC, IF_ID_Inst,
            ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm,          
            EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2,          
            MEM_WB_Mem_out, MEM_WB_ALU_out;     
wire [7:0] ID_EX_Ctrl;     
wire [4:0] EX_MEM_Ctrl;     
wire [1:0] MEM_WB_Ctrl;     
wire [3:0] ID_EX_Func;     
wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd, EX_MEM_Rd, MEM_WB_Rd;     
wire EX_MEM_Zero; 

/*
 * Fetch
 */
Register PC (rst, clk, PC_mux_out, 1, PC_out);
RCA PC_Adder (PC_out, 4, 0, PC_4);
assign branchFlag = branch_c & zflag;
Mux PC_MUX (PC_4, branch_addr, branchFlag, PC_mux_out);
InstMem Instruction_Memory (.addr(PC_out[7:2]), .data_out(instr)); 
RegWLoad #(64) IF_ID (clk, rst, 1'b1, {PC_out,instr}, {IF_ID_PC,IF_ID_Inst});

/*
 * Decode
 */
RegFile Register_File (.clk(clk), .rst(rst), .reg1( instr[19:15] ), .reg2( instr[24:20] ), .regDest( instr[11:7] ), .writeData(wb_out), .regWrite(regWrite_c),
           .read1(reg1), .read2(reg2));
ImmGen Immediate_Generator (.gen_out(gen_addr), .inst(instr));
CU Control_Unit (.opcode(instr[6:4]), .Branch(branch_c), .MemRead(memRead_c), .MemToReg(memToReg_c), .ALUOp(aluOp_c), .MemWrite(memWrite_c), .ALUSrc(aluSrc_c), .RegWrite(regWrite_c));
RegWLoad #(155) ID_EX (
    clk,rst,1'b1, 
    {regWrite_c,memToReg_c,branch_c,memRead_c,memWrite_c,aluOp_c,aluSrc_c, 
    IF_ID_PC,reg1,reg2,gen_addr, 
    IF_ID_Inst[30],
    IF_ID_Inst[14:12],                                 
    IF_ID_Inst[19:15],IF_ID_Inst[24:20],IF_ID_Inst[11:7]},                             
    {ID_EX_Ctrl,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,ID_EX_Imm,                                 
    ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd}                             
);
/*
 * Execute
 */
AluCu ALU_ControlUnit (.ALUOp(aluOp_c), .Inst(instr[14:12]), .Inst30(instr[30]), .ALUSelection(aluSelect_aluC));
Mux ALU_OperandMUX (.a(reg2), .b(gen_addr),.sel(aluSrc_c), .out(alu_secondOperand));
Alu ALU (.a(reg1), .b(alu_secondOperand) , .select(aluSelect_aluC), .zero(zflag), .res(aluRes));
RCA AddressCalculator ( .a(PC_out), .b(shifted_addr) , .op(0), .res(branch_addr));
Shifter AddressShifter (.a(gen_addr), .out(shifted_addr));
RegWLoad #(107) EX_MEM (clk,rst,1'b1,{ID_EX_Ctrl[7:3], 
    BranchAdder_out,Zero,ALU_out, ID_EX_RegR2,ID_EX_Rd}, 
    {EX_MEM_Ctrl,EX_MEM_BranchAddOut,EX_MEM_Zero,EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd});    
/*
 * Mem
 */
DataMem DataMemory ( .clk(clk), .MemRead(memRead_c), .MemWrite(memWrite_c), .addr(aluRes[7:2]), .data_in(reg2), .data_out(memDataOut)); 
RegWLoad #(71) MEM_WB (clk, rst, 1'b1,                             
{EX_MEM_Ctrl[4:3],                                 
Mem_out,EX_MEM_ALU_out,EX_MEM_Rd},                             
{MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd}                             
);

/*
 * WB
 */
Mux WB_MUX (.a(aluRes), .b(memDataOut), .sel(memToReg_c), .out(wb_out));


/*
 * Debugging on FPGA
 */
 always @(posedge d_clk) begin
    case(ledSel)
        2'b00:
            leds <= instr[15:0];
        2'b01:
            leds <= instr[31:16];
        2'b10:
            leds <= { 2'b00, branch_c,memRead_c, memToReg_c, aluOp_c, memWrite_c, aluSrc_c, regWrite_c, aluSelect_aluC, zflag, branchFlag };
        default:
            leds = 0;
    endcase
 
 end
 
 always @(clk) begin
    case(ssdSel)
    4'b0000:
        disp = PC_out[12:0];
        
    4'b0001:
        disp = PC_4[12:0];
        
    4'b0010:
        disp = branch_addr[12:0];
    
    4'b0011:
        disp = PC_mux_out[12:0];
    
    4'b0100:
        disp = reg1[12:0];
        
    4'b0101:
        disp = reg2[12:0];
        
    4'b0110:
        disp = wb_out[12:0];
        
    4'b0111:
        disp = gen_addr[12:0];
        
    4'b1000:
        disp = shifted_addr[12:0];
        
    4'b1001:
        disp = alu_secondOperand[12:0];
        
    4'b1010:
        disp = aluRes[12:0];    
        
    4'b1011:
        disp = memDataOut[12:0];
        
    endcase 
 end 
 
 SSD SegmentDisplay (.clk(d_clk), .num(disp), .Anode(anode), .LED_out(segmentDisp));          
endmodule 
