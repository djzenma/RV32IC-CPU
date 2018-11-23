`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2018 07:06:58 PM
// Design Name: 
// Module Name: NmiGenerator
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


module TMRGenerator(
    input         clk,
    input         rst,
    input [31:0]  limit,
    output reg    tmrF
);

reg [31:0] count;

always @ (posedge clk) begin
    if(rst) begin
        count <= 32'b0;
        tmrF  <= 1'b0;
    end
    else begin
        if(count == limit) begin
            count <= 32'b0;
            tmrF <= 1'b1;
        end
        if(count == limit + 1) begin
            count <= 32'b0;
            tmrF <= 1'b0;
        end
        else begin
            count <= count + 1;
            tmrF <= 1'b0;
        end
    end
end

endmodule
