// file: RegFile.v
// author: @cherifsalama

`timescale 1ns/1ns

module RegFile(
    input         clk,
    input         clk_slow,
    input         rst,
    input         WriteEn,
    input  [4:0]  rs1_rd,
    input  [4:0]  rs2,
    input  [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    wire [31:0] xs[31:0];
    wire [31:0] load;
    wire write;
    
    Decoder5_32 dec (   .en(WriteEn),
                        .dec_in(rs1_rd), 
                        .dec_out(load)
    );

    RegWLoad r0 (clk, rst, 1'b0, write_data, xs[0]); //Reg x0 cannot be written (load = 0)
    genvar i;
    generate
        for (i = 1;i < 32; i = i + 1)
            RegWLoad ri (
                .clk(clk),
                .rst(rst),
                .load(load[i] & write),
                .data_in(write_data),
                .data_out(xs[i])
            );
    endgenerate
    
    assign write = (clk ^ clk_slow);
    
    always @(negedge clk) begin
//       if(~WriteEn) begin
            read_data1 = xs[rs1_rd];
            read_data2 = xs[rs2];
//       end
    end
    
endmodule

