// file: DataMem.v
// author: @cherifsalama

`timescale 1ns/1ns

module DataMem (
    input clk, 
    input rst, 
    input MemRead, 
    input MemWrite, 
    input [5:0] addr, 
    input [31:0] data_in, 
    output [31:0] data_out
);

    reg [31:0] mem [0:63];
    
    always @(posedge rst or posedge clk) 
    begin
        if(rst==1) begin
            mem[0]<=32'd17;
            mem[1]<=32'd9;
            mem[2]<=32'd25;
        end
        else begin
            if (MemWrite)
                mem[addr] <= data_in;
        end
    end
    
    assign  data_out = MemRead?mem[addr]:0;
endmodule


