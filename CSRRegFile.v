`timescale 1ns / 1ps
/*******************************************************************
*
* Module: module_name.v
* Project: Project_Name
* Author: name and email
* Description: put your description here
*
* Change history: 01/01/17 – Did something
* 10/29/17 – Did something else
*
**********************************************************************/



`define MEPC 3'b000
`define MCYCLE 3'b001
`define MTIME 3'b010
`define MINSTRET 3'b011
`define MTIMECMP 3'b100
`define MIE 3'b101
`define MIP 3'b110

 
module CSRRegFile(
    input clk,
    input clk_slow,
    input rst,
    input [11:0] addr,
    input CSR_Write,
    input [31:0] CSR_Write_Data,
    output reg [31:0] CSR_Read_Data
);

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
always @(posedge clk, posedge clk_slow) begin
    if(rst) begin
    //TODO: INIT THE REST OF THE CSRs
        CSR[`MTIME] = 32'b0;
        CSR[`MIP] = 32'b0;
        CSR[`MIE] = 32'b0;
    end
    else if(CSR_Write) begin
        CSR[Selected_Addr] = CSR_Write_Data;
    end
end

//Read with negedge of clk
always @(negedge clk) begin
    CSR_Read_Data = CSR[Selected_Addr] ;
end

endmodule
