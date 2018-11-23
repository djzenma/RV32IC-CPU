// file: ForwardUnit.v
// author: @mobs_11

`timescale 1ns/1ns


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

