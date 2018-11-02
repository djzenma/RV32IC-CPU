// file: RegFile.v
// author: @cherifsalama

`timescale 1ns/1ns

module RegFile(
    input         clk,
    input         rst,
    input         WriteEn,
    input  [4:0]  rs1_rd,
    input  [4:0]  rs2,
    input  [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

    wire [31:0] xs[31:0];
    wire [31:0] load;

    Decoder5_32 dec (WriteEn, rs1_rd, load);

    RegWLoad r0 (clk, rst, 1'b0, write_data, xs[0]); //Reg x0 cannot be written (load = 0)
    RegWLoad r1 (clk, rst, 1'b1, 16, xs[1]); //For debugging
    genvar i;
    generate
        for (i = 2;i < 32; i = i + 1) //TODO: reg 1
            RegWLoad ri (clk, rst, load[i], write_data, xs[i]);
    endgenerate
    
   

    assign read_data1 = xs[rs1_rd];
    assign read_data2 = xs[rs2];
endmodule

