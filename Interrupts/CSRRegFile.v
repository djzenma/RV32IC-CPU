`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 05:27:41 PM
// Design Name: 
// Module Name: CSRRegFile
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

module CSRRegFile(
    input    clk,
    input    clk_slow,
    input    rst,
    input [31:0] pc,
    input    nmi,
    input    ecall,
    input    ebreak,
    input    int,
    input    en_inter, 
    input    en_ecall, 
    input    en_int, 
    input    en_tmr,
    input [11:0] addr,
    input    CSR_Write,
    input [31:0] CSR_Write_Data,
    input    Set,
    input    Clear,
    output reg [31:0] CSR_Read_Data,
    output   interF,
    output [31:0] interAddr
);

`define MEPC 3'b000
`define MCYCLE 3'b001
`define MTIME 3'b010
`define MINSTRET 3'b011
`define MTIMECMP 3'b100
`define MIE 3'b101
`define MIP 3'b110

/**
 CRS Registers
 0. 0x341 mepc 
 1. 0xB00 mcycle 
 2. 0xB01 mtime 
 3. 0xB02 minstret 
 4. 0xB03 mtimecmp 
 
 5. 0x304 mie [0] 0 => 1 To Enable TMR, [1] 0 => 1 To Enable  EX_INTERRUPT, [2] 0 => 1 TO Enable ECALL, [3] TO GLOBALLY DISABLE/ENABLE
 6. 0x344 mip 0 => 1 iff TMR IS HIGH, 0 => 1 iff NMI || EX_INTERRUPT IS HIGH, 0 => 1 iff EBREAK OR ECALL IS HIGH WITH EACH CLOCK CYCLE
*/

/**
  CSR Registers Classifications
  
  Standard Read-Write
  MEPC //STORES ADDRESS OF PC AS IS WITHOUT INCREMENT
  MIE
  MIP
  Read-Write Shadows
  MCYCLE
  MTIME
  MINSTRET
  MTIMECMP
*/

reg [31:0] CSR [6:0];
reg [2:0] Selected_Addr;
reg [31:0] count;

reg tmr;
wire [2:0] interSel, int_num;
wire load;


//Convert Incoming RISC V standard addr to selected address
always @(*) begin
    Selected_Addr = (addr == 12'h341) ? `MEPC :
                   (addr == 12'hb00) ? `MCYCLE :
                   (addr == 12'hb01) ? `MTIME :
                   (addr == 12'hb02) ? `MINSTRET :
                   (addr == 12'hb03) ? `MTIMECMP :
                   (addr == 12'h304) ? `MIE :
                   `MIP ;
end


//rst or write with posedge of clk
always @(posedge clk) begin
    if(rst) begin
        CSR[`MTIME] = 32'd22000;
        CSR[`MTIMECMP] = 32'd22010;
        CSR[`MEPC] = 32'b0;
        CSR[`MINSTRET] = 32'b01;
        CSR[`MCYCLE] = 32'b0;
        CSR[`MIP] = 32'b0;
        CSR[`MIE] = 32'b01111;
        count = 0;
    end
end

//Read with negedge of clk
always @(negedge clk) begin
    CSR_Read_Data = CSR[Selected_Addr] ;
end

always @(posedge clk_slow) begin
    // MCYCLES Reg Handling
    CSR[`MCYCLE] = CSR[`MCYCLE] + 1;
    
    // MTIME && MTIMECMP Regs Handling
    if(count == 10) begin
        CSR[`MTIME] = CSR[`MTIME] + 1;
    end
    else if(count == 10 + 1) begin
        count = 0;
    end
    else
        count = count + 1;
        
    if(CSR[`MTIME] == CSR[`MTIMECMP]) begin
        CSR[`MTIMECMP] = CSR[`MTIMECMP] + 10;
        tmr = 1'b1;
    end
    else begin
        CSR[`MTIMECMP] = CSR[`MTIMECMP];
        tmr = 1'b0;
    end
    
    
end

assign load = clk ^ clk_slow;

always @(load) begin
// Writing
    if(CSR_Write) begin
        if(Set) // CSRS
            CSR[Selected_Addr] = CSR[Selected_Addr] | CSR_Write_Data;
        else if(Clear)  // CSRC
            CSR[Selected_Addr] = CSR[Selected_Addr] & ~CSR_Write_Data;
        else    // CSRW
            CSR[Selected_Addr] = CSR_Write_Data;
    end
    else
        CSR[Selected_Addr] = CSR[Selected_Addr];
end

always @ (posedge clk) begin
    CSR[`MIE] = {28'b0, en_inter, en_ecall, en_int, en_tmr};
    CSR[`MIP] = {29'b0, (ecall || ebreak), int, tmr};
    
    
    if(interF && pc >= `CODE_SEGMENT)
        CSR[`MEPC] = pc;
end


Interrupt_Detector interUnit (
                .nmi(nmi),
                .ecall(ecall),
                .ebreak(ebreak),
                .int(int),
                .tmr(tmr),
                
                .en_inter(en_inter),
                
                .en_ecall(en_ecall),
                .en_int(en_int),
                .en_tmr(en_tmr),
                
                .interFlag(interF),
                .interSel(interSel) 
);

InterruptAddressGenerator intrAdrrGen(
                .interruptF(interF),
                .interSel(interSel),
                .intNum(int_num),
                .addr(interAddr)
);


endmodule