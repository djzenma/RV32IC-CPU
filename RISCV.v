// file: RISCV.v
<<<<<<< HEAD
// author: @mazenAmr
=======
// author: @cherifsalama
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2

`timescale 1ns/1ns



<<<<<<< HEAD
=======


>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
module RISCV(
    input             clk_i,
    input             rst,
    input             en_inter,
    input             int,
    input             int_num,
    input             nmi,
<<<<<<< HEAD
    input             en_nmi,
    input             en_ecall,
    input             en_ebreak,
=======
    input             en_ecall,
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    input             en_int,
    input             en_tmr,
    input   [31:0]    limit
);
    /*
    *   Variables Declaration
    */
<<<<<<< HEAD
    wire [31:0] PC_out, PCAdder_out, BranchAdder_out, PC_Or_Branch,
=======
    wire [31:0] PC_out, PCAdder_out, BranchAdder_out, PC_in, PC_Or_Branch,
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
                RegR1, RegR2, RegW, ImmGen_out, Shift_out, ALUSrcMux_out,
                ALU_out, Mem_out, Inst, PC_Or_Jal, decompressedInstr;
    wire        Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Zero;
    wire [1:0]  ALUOp, Jump;
    wire [3:0]  ALUSel;
    wire        branchTaken, clk_RF, clk_inv, clk, memSelect;
<<<<<<< HEAD
    reg [31:0]  PC_in;
=======
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
 
    
    // IF_ID pipeline reg wires
    wire [31:0] IF_ID_PC, IF_ID_Inst, jump_address, jal_branch_address, jalR_address, PC4_Or_Branch, IF_ID_InstOut;
    wire [2:0]  IF_ID_Mode;
    wire [4:0]  rs2;
<<<<<<< HEAD
    wire [1:0]  fwdA, fwdB;
    wire        IF_ID_luiControl, CompressedFlag, ECall, EBreak, MRET, CSRWrite, CSRSet, CSRClear, CSRI;
    

    // ID_EX pipeline reg wires
    reg  [31:0] ALU_OprandA, ALU_OprandB;
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, ID_EX_interAddr, PC_in_wo_inter, ID_EX_Inst, csr_read;
=======
    wire        IF_ID_luiControl, CompressedFlag, ECall, EBreak;
    

    // ID_EX pipeline reg wires
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, ID_EX_interAddr, PC_in_wo_inter;
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    wire [12:0] ID_EX_Ctrl;
    wire [9:0]  ID_EX_Func;
    wire [4:0]  ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd, regsrc;
    wire [2:0]  ID_EX_Mode;
    wire [31:0] memMuxOut;
    wire [2:0]  interSel;
<<<<<<< HEAD
    wire        ID_EX_luiControl, interF, tmr, ID_EX_ECall, ID_EX_EBreak, ID_EX_MRET, ID_EX_CSRWrite, ID_EX_CSRSet, ID_EX_CSRClear, ID_EX_CSRI;
    wire [11:0] csrAddr, csrAddrR;
   
    // EX_MEM pipeline reg wires
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_PC, EX_MEM_Imm, EX_MEM_csr_read, EX_MEM_RegR1, EX_MEM_Inst;
    wire [9:0]  EX_MEM_Ctrl;
    wire [4:0]  EX_MEM_Rd, EX_MEM_Rs1;
    wire        EX_MEM_Zero, sFlag, vFlag, cFlag, EX_MEM_luiControl, EX_MEM_CSRWrite, EX_MEM_CSRSet, EX_MEM_CSRClear, EX_MEM_CSRI;
    
    // MEM_WB pipeline reg wires
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_PC, RegData, MEM_WB_Imm, MEM_WB_csr_read, RegW_No_Inter, MEM_WB_RegR1, MEM_WB_Inst, MEM_WB_CSRData;
    wire [3:0]  MEM_WB_Ctrl;
    wire [4:0]  MEM_WB_Rd, MEM_WB_Rs1;
    wire        regMuxSelection, jalSel, MEM_WB_luiControl, MEM_WB_CSRWrite, MEM_WB_CSRSet, MEM_WB_CSRClear, MEM_WB_CSRI;


=======
    wire        ID_EX_luiControl, interF, tmr, ID_EX_ECall, ID_EX_EBreak;
   
    // EX_MEM pipeline reg wires
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_PC, EX_MEM_Imm;
    wire [9:0]  EX_MEM_Ctrl;
    wire [4:0]  EX_MEM_Rd;
    wire        EX_MEM_Zero, sFlag, vFlag, cFlag, lt_flag, ge_flag, ltu_flag, geu_flag, eq_flag, ne_flag, EX_MEM_luiControl;
    
    // MEM_WB pipeline reg wires
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_PC, RegData, MEM_WB_Imm;
    wire [3:0]  MEM_WB_Ctrl;
    wire [4:0]  MEM_WB_Rd;
    wire        regMuxSelection, jalSel, MEM_WB_luiControl;

    
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    ClkDiv clkDiv (.clk(clk_i), .rst(rst), .clk_o(clk));
        //ClkDivRF clkDivRF (.clk(clk_i), .rst(rst), .clk_o(clk_RF));
        
    ClkInverter clkInv (
                        .clk_i(clk),
                        .clk_o(clk_inv)
    );
    
    /*
    *   Pipeline Registers  
    */

    RegWLoad#(64) IF_ID (.clk      (~clk),
                         .rst      (rst),
                         .load     (1'b1),
                         .data_in  ({PC_out, Mem_out}),
                         .data_out ({IF_ID_PC, IF_ID_InstOut})
    );


<<<<<<< HEAD
    RegWLoad#(206) ID_EX (.clk (clk),
=======
    RegWLoad#(169) ID_EX (.clk (clk),
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
                          .rst (rst),
                          .load (1'b1),
                          .data_in ({ Jump, IF_ID_Mode, RegWrite, MemToReg, Branch, MemRead, MemWrite, ALUOp, ALUSrc,// all the control signals
                                   IF_ID_PC, RegR1, RegR2, ImmGen_out,
                                   IF_ID_Inst[31:25], IF_ID_Inst[14:12],
<<<<<<< HEAD
                                   IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7], IF_ID_luiControl, ECall, EBreak, MRET, IF_ID_InstOut, CSRWrite, CSRSet, CSRClear, CSRI}), // the 3 regs
                          .data_out ({ID_EX_Ctrl, ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, // ID_EX_Ctrl has all the 11 bits (7) controls
                                   ID_EX_Func, ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd, ID_EX_luiControl, ID_EX_ECall, ID_EX_EBreak, ID_EX_MRET, ID_EX_Inst, ID_EX_CSRWrite, ID_EX_CSRSet, ID_EX_CSRClear, ID_EX_CSRI}) 
    );

    RegWLoad#(282) EX_MEM (.clk (~clk),
=======
                                   IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7], IF_ID_luiControl, ECall, EBreak}), // the 3 regs
                          .data_out ({ID_EX_Ctrl, ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, // ID_EX_Ctrl has all the 11 bits (7) controls
                                   ID_EX_Func, ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd, ID_EX_luiControl, ID_EX_ECall, ID_EX_EBreak}) 
    );

    RegWLoad#(177) EX_MEM (.clk (~clk),
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
                           .rst (rst),
                           .load (1'b1),
                           .data_in ({ID_EX_Ctrl[12:3], // Jump, IF_ID_Mode, RegWrite,MemToReg, and Branch,MemRead,MemWrite
                                    BranchAdder_out, Zero, ALU_out,
<<<<<<< HEAD
                                    ID_EX_RegR2, ID_EX_Rd, ID_EX_PC, ID_EX_Imm, ID_EX_luiControl, csr_read, ID_EX_CSRWrite, ID_EX_RegR1, ID_EX_Inst, ID_EX_CSRSet, ID_EX_CSRClear, ID_EX_Rs1, ID_EX_CSRI}),
                           .data_out ({EX_MEM_Ctrl, // EX_MEM_Ctrl = Jump, IF_ID_Mode, RegWrite,MemToReg, and Branch,MemRead,MemWrite
                                    EX_MEM_BranchAddOut, EX_MEM_Zero,
                                    EX_MEM_ALU_out,
                                    EX_MEM_RegR2, EX_MEM_Rd, EX_MEM_PC, EX_MEM_Imm, EX_MEM_luiControl, EX_MEM_csr_read, EX_MEM_CSRWrite, EX_MEM_RegR1, EX_MEM_Inst, EX_MEM_CSRSet, EX_MEM_CSRClear, EX_MEM_Rs1, EX_MEM_CSRI})
    );


    RegWLoad#(243) MEM_WB (.clk (clk),
                          .rst (rst),
                          .load (1'b1),
                          .data_in ({ {EX_MEM_Ctrl[9:8], EX_MEM_Ctrl[4:3]}, // RegWrite,MemToReg
                                   Mem_out, EX_MEM_ALU_out, EX_MEM_Rd, EX_MEM_PC, EX_MEM_Imm, EX_MEM_luiControl, EX_MEM_csr_read, EX_MEM_CSRWrite, EX_MEM_RegR1, EX_MEM_Inst, EX_MEM_CSRSet, EX_MEM_CSRClear, EX_MEM_Rs1, EX_MEM_CSRI}),
                          .data_out ({MEM_WB_Ctrl, MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd, MEM_WB_PC, MEM_WB_Imm, MEM_WB_luiControl, MEM_WB_csr_read, MEM_WB_CSRWrite, MEM_WB_RegR1, MEM_WB_Inst, MEM_WB_CSRSet, MEM_WB_CSRClear, MEM_WB_Rs1, MEM_WB_CSRI})
=======
                                    ID_EX_RegR2, ID_EX_Rd, ID_EX_PC, ID_EX_Imm, ID_EX_luiControl}),
                           .data_out ({EX_MEM_Ctrl, // EX_MEM_Ctrl = Jump, IF_ID_Mode, RegWrite,MemToReg, and Branch,MemRead,MemWrite
                                    EX_MEM_BranchAddOut, EX_MEM_Zero,
                                    EX_MEM_ALU_out,
                                    EX_MEM_RegR2, EX_MEM_Rd, EX_MEM_PC, EX_MEM_Imm, EX_MEM_luiControl})
    );



    RegWLoad#(138) MEM_WB (.clk (clk),
                          .rst (rst),
                          .load (1'b1),
                          .data_in ({ {EX_MEM_Ctrl[9:8], EX_MEM_Ctrl[4:3]}, // RegWrite,MemToReg
                                   Mem_out, EX_MEM_ALU_out, EX_MEM_Rd, EX_MEM_PC, EX_MEM_Imm, EX_MEM_luiControl}),
                          .data_out ({MEM_WB_Ctrl, MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd, MEM_WB_PC, MEM_WB_Imm, MEM_WB_luiControl})
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    );

    /*
    *   Fetch
    */

<<<<<<< HEAD
=======
 
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    RegWLoad PC (.clk      (clk),
                 .rst      (rst),
                 .load     (1'b1),
                 .data_in  (PC_in),
                 .data_out (PC_out)
    );


<<<<<<< HEAD
=======

    RippleAdder IncPC (.a  (PC_out),
                       .b  (4),
                       .ci (1'b0),
                       .s  (PCAdder_out),
                       .co (),    // No use for the carry out
                       .last_ci()
    );

>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    /*
    *   Decode
    */
 
    Decompression decUnit (
        .IF_Instr_16(IF_ID_InstOut[15:0]),
        .IF_Dec_32(decompressedInstr)
    );
    assign CompressedFlag = (IF_ID_InstOut[1:0] != 2'b11) ? 1 : 0;
    assign IF_ID_Inst = (CompressedFlag == 1'b1) ? decompressedInstr : IF_ID_InstOut;
    
    assign rs2 = IF_ID_Inst[24:20];
<<<<<<< HEAD
    
    
=======
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
   
    RegFile rf (.clk    (clk_i),
            .clk_slow   (clk),
            .rst        (rst),
            .WriteEn    (MEM_WB_Ctrl[1]), // RegWrite
            .rs1_rd     (regsrc),
            .rs2        (rs2),
            .write_data (RegW),
            .read_data1 (RegR1),
            .read_data2 (RegR2)
    );
    
    RegSrcUnit regSrcUnit (
            .clk(clk),
            .regWrite(MEM_WB_Ctrl[1]), // RegWrite
            .regMuxSelect(regMuxSelection)
    );

    Mux2_1#(5) MuxregFile (.sel (clk), // RegWrite
                             .in1 (IF_ID_Inst[19:15]),  // rs1
                             .in2 (MEM_WB_Rd),
                             .out (regsrc)
    );
                             
    ImmGen ig (.IR  (IF_ID_Inst),
               .Imm (ImmGen_out)
    );
    
    // jal: address + PC
    RippleAdder JalAddressAdder (   .a  (ID_EX_Imm),
                                    .b  (ID_EX_PC),
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
                    .Mode     (IF_ID_Mode),
                    .Lui      (IF_ID_luiControl),
                    .ECall    (ECall),
<<<<<<< HEAD
                    .EBreak   (EBreak),
                    .MRET     (MRET),
                    .CSRWrite (CSRWrite),
                    .CSRSet   (CSRSet),
                    .CSRClear (CSRClear),
                    .CSRI     (CSRI)
=======
                    .EBreak   (EBreak)
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    );

    /*
    *   Execute  
    */
<<<<<<< HEAD
    ForwardUnit FwdUnit (
        .ID_EX_Rs1(ID_EX_Rs1),
        .ID_EX_Rs2(ID_EX_Rs2),
        .EX_MEM_RegWrite(EX_MEM_Ctrl[4]),
        .EX_MEM_Rd(EX_MEM_Rd),
        .MEM_WB_RegWrite(MEM_WB_Ctrl[1]),
        .MEM_WB_Rd(MEM_WB_Rd),
        .ForwardA(fwdA),
        .ForwardB(fwdB)
    );
    
    // Forwarding MUX A & MUX B
    always @ (*) begin
        case(fwdA)
            2'b00:
                ALU_OprandA = ID_EX_RegR1;
            2'b10:
                ALU_OprandA = EX_MEM_ALU_out;
            2'b01:
                ALU_OprandA = RegW;
        endcase
        
        case(fwdB)
            2'b00:
                ALU_OprandB = ALUSrcMux_out;
            2'b10:
                ALU_OprandB = EX_MEM_ALU_out;
            2'b01:
                ALU_OprandB = RegW;
        endcase
    
    end
     
=======

>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    Mux2_1#(32) aluSrcBMux (.sel (ID_EX_Ctrl[0]),
                            .in1 (ID_EX_RegR2),
                            .in2 (ID_EX_Imm),
                            .out (ALUSrcMux_out)
    );

    ALU a1 (
            .sel (ALUSel),
<<<<<<< HEAD
            .a   (ALU_OprandA),
            .b   (ALU_OprandB),
=======
            .a   (ID_EX_RegR1),
            .b   (ALUSrcMux_out),
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
            .prevRes(ALU_out),
            .result   (ALU_out),
            .z   (Zero),
            .s   (sFlag),
            .c   (cFlag),
            .v   (vFlag)
    );
    
    
    BranchUnit branchUnit ( 
                .branch(ID_EX_Ctrl[5]),     // BRANCH
                .s(sFlag),
                .z(Zero),
                .c(cFlag),
                .v(vFlag),
                .func3(ID_EX_Func[2:0]),
                .branchTaken (branchTaken)
    );

    ShiftLeft1 sh (.d_in  (ID_EX_Imm),
                   .d_out (Shift_out)
    );

    RippleAdder OffsetPC (.a  (ID_EX_PC),
                          .b  (ID_EX_Imm),
                          .ci (1'b0),
                          .s  (BranchAdder_out),
                          .co (),       // don't want to use it
                          .last_ci()
    );
    // beq: PC + imm
    Mux2_1#(32) BranchOrPCMux (.sel (branchTaken),
                                  .in1 (IF_ID_PC + 4),      // TODO
                                  .in2 (BranchAdder_out),
                                  .out (PC4_Or_Branch)
    );
    
    Mux2_1#(32) BranchOrPCPlus4OrPcPlus2Mux (   .sel (CompressedFlag),
                                  .in1 (PC4_Or_Branch),      
                                  .in2 (IF_ID_PC + 2),      // TODO
                                  .out (PC_Or_Branch)
    );
    
    Mux4_1 #(32) srcOfPC(
         .sel(ID_EX_Ctrl[12:11]),   // Jump
         .in1(PC_Or_Branch),
         .in2(jal_branch_address),
         .in3(jalR_address),
         .in4(),
         .out(PC_in_wo_inter)
     );
     
      
    // jalr: reg + imm
    RippleAdder jalRAdder (.a  (ID_EX_RegR1),
                            .b  (ID_EX_Imm),
                            .ci (1'b0),
                            .s  (jalR_address),
                            .co (),       // don't want to use it
                            .last_ci()
      );

    ALUControl acu (.clk (clk),
                    .ALUOp (ID_EX_Ctrl[2:1]),     //  ALUOp
                    .func3 (ID_EX_Func[2:0]),
                    .func7 (ID_EX_Func[9:3]),
                    .sel   (ALUSel)
    );

<<<<<<< HEAD

    
    /*********************************************************************/
    
    assign csrAddrR = (ID_EX_MRET) ? `MEPC_ADDR : ID_EX_Inst[31:20];
    assign csrAddr = (clk) ? MEM_WB_Inst[31:20]: csrAddrR;
    
    assign MEM_WB_CSRData = (MEM_WB_CSRI)? {27'b0, MEM_WB_Rs1} : MEM_WB_RegR1;
    
   CSRRegFile csrFile(
        .clk(clk_i),
        .clk_slow(clk),
        .rst(rst),
        .pc(ID_EX_PC),
        .nmi(nmi),
        .ecall(ID_EX_ECall),
        .ebreak(ID_EX_EBreak),
        .int(int),
        .en_inter(en_inter), 
        .en_ecall(en_ecall), 
        .en_int(en_int), 
        .en_tmr(en_tmr),
        .addr(csrAddr),
        .CSR_Write(MEM_WB_CSRWrite),
        .CSR_Write_Data(MEM_WB_CSRData),
        .Set(MEM_WB_CSRSet),
        .Clear(MEM_WB_CSRClear),
        .CSR_Read_Data(csr_read),
        .interF(interF),
        .interAddr(ID_EX_interAddr)
    );

    /**********************************************************************/
    always @(*) begin
        if(ID_EX_MRET)
            PC_in = csr_read + 4 ;
        else if(interF)
            PC_in = ID_EX_interAddr;
        else
            PC_in = PC_in_wo_inter;
    end
=======
    TmrGenerator tmrGen (
            .clk(clk),
            .rst(rst),
            .limit(limit),
            .tmrF(tmr)
    );
    
    Interrupt_Detector interUnit (
                .nmi(nmi),
                .ecall(ID_EX_ECall),
                .ebreak(ID_EX_EBreak),
                .int(int),
                .tmr(tmr),
                
                .en_inter(en_inter),
                
                .en_ecall(en_ecall),
                .en_int(en_int),
                .en_tmr(en_tmr),
                
                .interFlag(interF),
                .interSel(interSel) 
    );
    
    InterruptAddressGenerator intrAdrrGen(          // TODO :: save PC in mepc
                .interruptF(interF),
                .interSel(interSel),
                .intNum(int_num),
                .addr(ID_EX_interAddr)
    );
    
    assign PC_in = (interF) ? ID_EX_interAddr : PC_in_wo_inter;
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
    
    /*
    *   Mem  
    */
   
    Memory Mem(
        .clk(clk),
        .clk_i(clk_i),
        .rst(rst),
        .MemRead(EX_MEM_Ctrl[1]),
        .MemWrite(EX_MEM_Ctrl[0]),
        .mode(EX_MEM_Ctrl[7:5]),
        .addr(memMuxOut),
        .data_in(EX_MEM_RegR2),
        .data_out(Mem_out)
    );
    
    memAddressSelectUnit MemSrcAddress (
        .clk_fast(clk_i),
        .clk_slow(clk),
        .select(memSelect)
    );
        
    Mux2_1 #(32) MemMux (.sel (memSelect),      // ~clk_i
                        .in1 (PC_out),
                        .in2 (EX_MEM_ALU_out),
                        .out (memMuxOut)
    );
    

    /*
    *   Write Back  
    */
    Mux2_1#(32) regWSrcMux1 (.sel (MEM_WB_Ctrl[0]),  // MemToReg
                            .in1 (MEM_WB_ALU_out),
                            .in2 (MEM_WB_Mem_out),
                            .out (RegData)
    );
    
    assign jalSel = (MEM_WB_Ctrl[2] || MEM_WB_Ctrl[3]);
    Mux2_1#(32) regWSrcMux2 (    .sel (jalSel),  // Jump
                                .in1 (RegData),
                                .in2 (MEM_WB_PC + 4),
                                .out (PC_Or_Jal)
    );

    Mux2_1#(32) regWSrcMux3 (    .sel (MEM_WB_luiControl),  // Jump
                                    .in1 (PC_Or_Jal),
                                    .in2 (MEM_WB_Imm),
<<<<<<< HEAD
                                    .out (RegW_No_Inter)
    );
    assign RegW = (MEM_WB_CSRWrite) ? MEM_WB_csr_read : RegW_No_Inter;
=======
                                    .out (RegW)
    );
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2

endmodule

