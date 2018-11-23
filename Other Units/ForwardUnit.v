// file: ForwardUnit.v
// author: @mobs_11

`timescale 1ns/1ns


<<<<<<< HEAD
module ForwardUnit(
    input [4:0]     ID_EX_Rs1,
    input [4:0]     ID_EX_Rs2,
    input           EX_MEM_RegWrite,
    input [4:0]     EX_MEM_Rd,
    input           MEM_WB_RegWrite,
    input [4:0]     MEM_WB_Rd,
    output reg[1:0] ForwardA,
    output reg[1:0] ForwardB

);  

    always @ (*) begin
        if (EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs1))
            ForwardA = 2'b10;
        else if (MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs1) && !(EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs1) ) )
            ForwardA = 2'b01;
        else 
            ForwardA = 2'b00;
    end
    
    always @ (*) begin
        if (EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs2))
            ForwardB = 2'b10;
        else if (MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs2) && !(EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs2) ) )
            ForwardB = 2'b01;
        else
            ForwardB = 2'b00;
    end
    
endmodule

=======
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
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
