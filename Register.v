`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2018 04:59:22 PM
// Design Name: 
// Module Name: Mux
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



module Register (input res, input clk, input [31:0] a, input load, output [31:0]out);
genvar i;
wire[31:0] d;

generate 
    for( i = 0; i <= 31; i=i+1 ) begin :loop
       Mux2x1 mux (out[i], a[i], load, d[i]);
       FF ff(res, clk, d[i], out[i]);
    end
endgenerate

endmodule



module FF(input res, input clk, input d, output reg q );

always @(posedge clk)
 begin
 if(res)
    q<=0;
  else 
    q<=d;
  end
 
endmodule
 
 
