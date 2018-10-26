// file: RegWLoad.v
// author: @cherifsalama

`timescale 1ns/1ns

module RegWLoad(
    clk,
    rst,
    load,
    data_in, 
    data_out 
);

    parameter SIZE=32;

    input clk, rst, load;
    input [SIZE-1:0] data_in; 
    output [SIZE-1:0] data_out;
    
    wire [SIZE-1:0] ds;

    genvar i;
    generate
        for(i=0;i<SIZE;i=i+1) begin
            Mux2_1 m ( .sel(load), .in1(data_out[i]), .in2(data_in[i]), .out(ds[i]));
            FlipFlop f ( .clk(clk), .rst(rst), .d(ds[i]), .q(data_out[i]));
        end
    endgenerate

endmodule

