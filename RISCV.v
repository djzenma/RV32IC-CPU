// file: RISCV.v
// author: @cherifsalama

`timescale 1ns/1ns





module RISCV(
    input             clk_i,
    input             rst,
    input [1:0]       ledSel,
    input [3:0]       ssdSel,
    output reg [15:0] leds,
    output reg [12:0] ssd
);

    /*
    *   Variables Declaration
    */
    wire [31:0] PC_out, PCAdder_out, BranchAdder_out, PC_in, PC_Or_Branch,
                RegR1, RegR2, RegW, ImmGen_out, Shift_out, ALUSrcMux_out,
                ALU_out, Mem_out, Inst;
    wire        Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Zero;
    wire [1:0]  ALUOp, Jump;
    wire [3:0]  ALUSel;
    wire        branchTaken, clk_RF, clk_inv, clk;

    
    // IF_ID pipeline reg wires
    wire [31:0] IF_ID_PC, IF_ID_Inst, jump_address, jal_branch_address, jalR_address;
    wire [2:0]  IF_ID_Mode;

    // ID_EX pipeline reg wires
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
    wire [10:0] ID_EX_Ctrl;
    wire [9:0]  ID_EX_Func;
    wire [4:0]  ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd, regsrc;
    wire [2:0]  ID_EX_Mode;
    wire [31:0] memMuxOut;
   
    // EX_MEM pipeline reg wires
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2;
    wire [7:0]  EX_MEM_Ctrl;
    wire [4:0]  EX_MEM_Rd;
    wire        EX_MEM_Zero, sFlag, vFlag, cFlag, lt_flag, ge_flag, ltu_flag, geu_flag, eq_flag, ne_flag;
    
    // MEM_WB pipeline reg wires
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
    wire [1:0]  MEM_WB_Ctrl;
    wire [4:0]  MEM_WB_Rd;

    
    ClkDiv clkDiv (.clk(clk_i), .rst(rst), .clk_o(clk));
        //ClkDivRF clkDivRF (.clk(clk_i), .rst(rst), .clk_o(clk_RF));
        
    ClkInverter clkInv (
                        .clk_i(clk),
                        .clk_o(clk_inv)
    );
    
    /*
    *   Pipeline Registers  
    */

    RegWLoad#(64) IF_ID (.clk      (clk_inv),
                         .rst      (rst),
                         .load     (1'b1),
                         .data_in  ({PC_out, Mem_out}),
                         .data_out ({IF_ID_PC, IF_ID_Inst})
    );


    RegWLoad#(164) ID_EX (.clk (clk),
                          .rst (rst),
                          .load (1'b1),
                          .data_in ({ IF_ID_Mode, RegWrite, MemToReg, Branch, MemRead, MemWrite, ALUOp, ALUSrc,// all the control signals
                                   IF_ID_PC, RegR1, RegR2, ImmGen_out,
                                   IF_ID_Inst[31:25], IF_ID_Inst[14:12],
                                   IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7]}), // the 3 regs
                          .data_out ({ID_EX_Ctrl, ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, // ID_EX_Ctrl has all the 11 bits (7) controls
                                   ID_EX_Func, ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd}) 
    );

    RegWLoad#(110) EX_MEM (.clk (clk_inv),
                           .rst (rst),
                           .load (1'b1),
                           .data_in ({ID_EX_Ctrl[10:3], // IF_ID_Mode, RegWrite,MemToReg, and Branch,MemRead,MemWrite
                                    BranchAdder_out, Zero, ALU_out,
                                    ID_EX_RegR2, ID_EX_Rd}),
                           .data_out ({EX_MEM_Ctrl, // EX_MEM_Ctrl = IF_ID_Mode, RegWrite,MemToReg, and Branch,MemRead,MemWrite
                                    EX_MEM_BranchAddOut, EX_MEM_Zero,
                                    EX_MEM_ALU_out,
                                    EX_MEM_RegR2, EX_MEM_Rd})
    );



    RegWLoad#(71) MEM_WB (.clk (clk),
                          .rst (rst),
                          .load (1'b1),
                          .data_in ({EX_MEM_Ctrl[4:3], // RegWrite,MemToReg
                                   Mem_out, EX_MEM_ALU_out, EX_MEM_Rd}),
                          .data_out ({MEM_WB_Ctrl, MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd})
    );

    /*
    *   Fetch
    */

 
    RegWLoad PC (.clk      (clk),
                 .rst      (rst),
                 .load     (1'b1),
                 .data_in  (PC_in),
                 .data_out (PC_out)
    );



    RippleAdder IncPC (.a  (PC_out),
                       .b  (4),
                       .ci (1'b0),
                       .s  (PCAdder_out),
                       .co (),    // No use for the carry out
                       .last_ci()
    );

    /*
    *   Decode
    */

    RegFile rf (.clk    (clk),
            .rst        (rst),
            .WriteEn    (MEM_WB_Ctrl[1]),
            .rs1_rd     (regsrc),
            .rs2        (IF_ID_Inst[24:20]),
            .write_data (RegW),
            .read_data1 (RegR1),
            .read_data2 (RegR2)
    );
    Mux2_1#(5) MuxregFile (.sel (MEM_WB_Ctrl[1]),
                             .in1 (IF_ID_Inst[19:15]),
                             .in2 (MEM_WB_Rd),
                             .out (regsrc)
    );
                             
    ImmGen ig (.IR  (IF_ID_Inst),
               .Imm (ImmGen_out)
    );
    
        
    RippleAdder JalAddressAdder (    .a  (ImmGen_out),
                              .b  (PCAdder_out),
                              .ci (1'b0),
                              .s  (jal_branch_address),
                              .co (),       // don't want to use it
                              .last_ci()
    );
        
    

    ControlUnit cu (.instr    (IF_ID_Inst),
                    .opcode   (IF_ID_Inst[6:2]), 
                    .Branch   (Branch),
                    .Jump     (Jump),
                    .MemRead  (MemRead),
                    .MemToReg (MemToReg),
                    .ALUOp    (ALUOp),
                    .MemWrite (MemWrite),
                    .ALUSrc   (ALUSrc),
                    .RegWrite (RegWrite),
                    .Mode     (IF_ID_Mode)
    );

    /*
    *   Execute  
    */

    Mux2_1#(32) aluSrcBMux (.sel (ID_EX_Ctrl[0]),
                            .in1 (ID_EX_RegR2),
                            .in2 (ID_EX_Imm),
                            .out (ALUSrcMux_out)
    );

    ALU a1 (.sel (ALUSel),
            .a   (ID_EX_RegR1),
            .b   (ALUSrcMux_out),
            .result   (ALU_out),
            .z   (Zero),
            .s   (sFlag),
            .c   (cFlag),
            .v   (vFlag)
    );
    
    BranchUnit branchUnit ( 
                .branch(ID_EX_Ctrl[5]),          // ID_EX_Ctrl[5] = BRANCH
                .s(sFlag),
                .z(Zero),
                .c(cFlag),
                .v(vFlag),
                .branchTaken (branchTaken)
    );    

    ShiftLeft1 sh (.d_in  (ID_EX_Imm),
                   .d_out (Shift_out)
    );

    RippleAdder OffsetPC (.a  (ID_EX_PC),
                          .b  (Shift_out),
                          .ci (1'b0),
                          .s  (BranchAdder_out),
                          .co (),       // don't want to use it
                          .last_ci()
    );
    
    Mux2_1#(32) BranchOrPCMux (.sel (branchTaken),
                                  .in1 (ID_EX_PC + 4),      // TODO
                                  .in2 (BranchAdder_out),
                                  .out (PC_Or_Branch)
    );
    
      // jal: address + PC
      // jalr: reg + imm
    RippleAdder jalRAdder (.a  (RegR1),
                            .b  (ImmGen_out),
                            .ci (1'b0),
                            .s  (jalR_address),
                            .co (),       // don't want to use it
                            .last_ci()
      );

    Mux4_1 #(32) srcOfPC(
            .sel(Jump),
            .in1(PC_Or_Branch),
            .in2(jal_branch_address),
            .in3(jalR_address),
            .in4(),
            .out(PC_in)
        );
            
        //    Mux2_1 #(32) PCMux (   .sel (Jump),
        //                            .in1 (PC_Or_Branch),
        //                            .in2 (ImmGen_out),
        //                            .out (PC_in)
        //    );

    ALUControl acu (.ALUOp (ID_EX_Ctrl[2:1]),
                    .func3 (ID_EX_Func[2:0]),
                    .func7 (ID_EX_Func[9:3]),
                    .sel   (ALUSel)
    );

    /*
    *   Mem  
    */
//    assign branchTaken = EX_MEM_Zero && EX_MEM_Ctrl[2];
   
    Memory Mem(
        .clk(clk),
        .rst(rst),
        .MemRead(EX_MEM_Ctrl[1]),
        .MemWrite(EX_MEM_Ctrl[0]),
        .mode(EX_MEM_Ctrl[7:5]),
        .addr(memMuxOut),
        .data_in(EX_MEM_RegR2),
        .data_out(Mem_out)
    );
    Mux2_1 #(32) MemMux (.sel (clk_inv),
                        .in1 (PC_out),
                        .in2 (EX_MEM_ALU_out),
                        .out (memMuxOut)
    );
    
    

    /*
    *   Write Back  
    */
    Mux2_1#(32) regWSrcMux (.sel (MEM_WB_Ctrl[0]),
                            .in1 (MEM_WB_ALU_out),
                            .in2 (MEM_WB_Mem_out),
                            .out (RegW)
    );



    /*
    *   Debugging on FPGA
    */
    always @ (* ) begin
        case (ledSel)
            0: leds <= Inst[15:0];
            1: leds <= Inst[31:16];
            2: leds <= {Branch, MemRead, MemToReg, ALUOp, MemWrite,
                ALUSrc, RegWrite, Zero, branchTaken, ALUSel};
            default: leds <= 0;
        endcase

        case (ssdSel)
            0: ssd <= PC_out[12:0];
            1: ssd <= PCAdder_out[12:0];
            2: ssd <= BranchAdder_out[12:0];
            3: ssd <= PC_in[12:0];
            4: ssd <= RegR1[12:0];
            5: ssd <= RegR2[12:0];
            6: ssd <= RegW[12:0];
            7: ssd <= ImmGen_out[12:0];
            8: ssd <= Shift_out[12:0];
            9: ssd <= ALUSrcMux_out[12:0];
            10: ssd <= ALU_out[12:0];
            11: ssd <= Mem_out[12:0];
            default: ssd <= 0;
        endcase
    end
endmodule

