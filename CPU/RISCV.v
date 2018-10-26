// file: RISCV.v
// author: @cherifsalama

`timescale 1ns/1ns

module RISCV(
    input             clk,
    input             rst,
    input [1:0]       ledSel,
    input [3:0]       ssdSel,
    output reg [15:0] leds,
    output reg [12:0] ssd
);

    /*
    *   Variables Declaration
    */
    wire [31:0] PC_out, PCAdder_out, BranchAdder_out, PC_in,
                RegR1, RegR2, RegW, ImmGen_out, Shift_out, ALUSrcMux_out,
                ALU_out, Mem_out, Inst;
    wire        Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Zero;
    wire [1:0]  ALUOp;
    wire [3:0]  ALUSel;
    wire        PCSrc;

    // IF_ID pipeline reg wires
    wire [31:0] IF_ID_PC, IF_ID_Inst;

    // ID_EX pipeline reg wires
    wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
    wire [7:0]  ID_EX_Ctrl;
    wire [3:0]  ID_EX_Func;
    wire [4:0]  ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;

    // EX_MEM pipeline reg wires
    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2;
    wire [4:0]  EX_MEM_Ctrl;
    wire [4:0]  EX_MEM_Rd;
    wire        EX_MEM_Zero;

    // MEM_WB pipeline reg wires
    wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
    wire [1:0]  MEM_WB_Ctrl;
    wire [4:0]  MEM_WB_Rd;





    /*
    *   Pipeline Registers  
    */

    RegWLoad#(64) IF_ID (.clk      (clk),
                         .rst      (rst),
                         .load     (1'b1),
                         .data_in  ({PC_out, Inst}),
                         .data_out ({IF_ID_PC, IF_ID_Inst})
    );


    RegWLoad#(155) ID_EX (.clk (clk),
                          .rst (rst),
                          .load (1'b1),
                          .data_in ({RegWrite, MemToReg, Branch, MemRead, MemWrite, ALUOp, ALUSrc, // all the control signals
                                   IF_ID_PC, RegR1, RegR2, ImmGen_out,
                                   IF_ID_Inst[30], IF_ID_Inst[14:12], // TODO: Change the 30 to func3 and reg param size
                                   IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7]}), // the 3 regs
                          .data_out ({ID_EX_Ctrl, ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, // ID_EX_Ctrl has all the 8 bits (7) controls
                                   ID_EX_Func, ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd})  // TODO: Change Func to contain all the func3 bits (not only 30th bit) and change the reg param
    );

    RegWLoad#(107) EX_MEM (.clk (clk),
                           .rst (rst),
                           .load (1'b1),
                           .data_in ({ID_EX_Ctrl[7:3], // RegWrite,MemToReg, and Branch,MemRead,MemWrite
                                    BranchAdder_out, Zero, ALU_out,
                                    ID_EX_RegR2, ID_EX_Rd}),
                           .data_out ({EX_MEM_Ctrl, // EX_MEM_Ctrl = RegWrite,MemToReg, and Branch,MemRead,MemWrite
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

    Mux2_1#(32) pcSrcMux (.sel (PCSrc),
                          .in1 (PCAdder_out),
                          .in2 (EX_MEM_BranchAddOut),
                          .out (PC_in)
    );

    RegWLoad PC (.clk      (clk),
                 .rst      (rst),
                 .load     (1'b1),
                 .data_in  (PC_in),
                 .data_out (PC_out));

    InstMem imem (.rst      (rst),
                  .addr     (PC_out[7:2]), // Assuming Word adressable TODO: Correct?
                  .data_out (Inst)
    );


    RippleAdder IncPC (.a  (PC_out),
                       .b  (4),
                       .ci (1'b0),
                       .s  (PCAdder_out),
                       .co ()    // No use for the carry out
    );

    /*
    *   Decode
    */

    RegFile rf (.clk        (~clk),
                .rst        (rst),
                .WriteEn    (MEM_WB_Ctrl[1]),
                .rs1        (IF_ID_Inst[19:15]),
                .rs2        (IF_ID_Inst[24:20]),
                .rd         (MEM_WB_Rd),
                .write_data (RegW),
                .read_data1 (RegR1),
                .read_data2 (RegR2)
    );

    ImmGen ig (.inst  (IF_ID_Inst),
               .d_out (ImmGen_out)
    );

    ControlUnit cu (.opcode   (IF_ID_Inst[6:4]),
                    .Branch   (Branch),
                    .MemRead  (MemRead),
                    .MemToReg (MemToReg),
                    .ALUOp    (ALUOp),
                    .MemWrite (MemWrite),
                    .ALUSrc   (ALUSrc),
                    .RegWrite (RegWrite)
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
            .c   (ALU_out),
            .z   (Zero)
    );

    ShiftLeft1 sh (.d_in  (ID_EX_Imm),
                   .d_out (Shift_out)
    );

    RippleAdder OffsetPC (.a  (ID_EX_PC),
                          .b  (Shift_out),
                          .ci (1'b0),
                          .s  (BranchAdder_out),
                          .co ()       // don't want to use it
    );

    ALUControl acu (.ALUOp (ID_EX_Ctrl[2:1]),
                    .func3 (ID_EX_Func[2:0]),
                    .func7 (ID_EX_Func[3]),
                    .sel   (ALUSel)
    );

    /*
    *   Mem  
    */
    assign PCSrc = EX_MEM_Zero && EX_MEM_Ctrl[2];

    DataMem dmem (.clk      (clk),
                  .rst      (rst),
                  .MemRead  (EX_MEM_Ctrl[1]),
                  .MemWrite (EX_MEM_Ctrl[0]),
                  .addr     (EX_MEM_ALU_out[7:2]),
                  .data_in  (EX_MEM_RegR2),
                  .data_out (Mem_out)
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
                ALUSrc, RegWrite, Zero, PCSrc, ALUSel};
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
            default: ssd <<= 0;
        endcase
    end
endmodule

