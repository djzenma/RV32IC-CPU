// file: ForwardUnit.v
// author: @mobs_11

`timescale 1ns/1ns


module ForwardUnit(input EXMEMWB,input MEMWB,input [4:0]EXMEMRD, input [4:0]MEMWBRD, input [4:0]RS1, input [4:0]RS2,output [1:0]FWDA,output [1:0]FWDB);

forward A(.EXMEMWB(EXMEMWB),.MEMWB(MEMWB),.EXMEMRD(EXMEMRD),.MEMWBRD(MEMWBRD),.RS(RS1),.FWDA(FWD));                                                                                                                
forward B(.EXMEMWB(EXMEMWB),.MEMWB(MEMWB),.EXMEMRD(EXMEMRD),.MEMWBRD(MEMWBRD),.RS(RS2),.FWDB(FWD));
endmodule


module forward(input EXMEMWB,input MEMWB,input [4:0]EXMEMRD, input [4:0]MEMWBRD, input [4:0]RS,output reg [1:0]FWD);
always @ (*) begin
if ((EXMEMRD!=0)&EXMEMWB&!(EXMEMRD~^RS))
FWD[1]=1;
if ((MEMWBRD!=0)&MEMWB&!(MEMWBRD~^RS))
FWD[0]=1;
end
endmodule