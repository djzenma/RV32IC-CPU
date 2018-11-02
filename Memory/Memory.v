// file: DataMem.v
// author: @cherifsalama

`timescale 1ns/1ns

module Memory(
    input         clk,
    input         rst,
    input         MemRead,
    input         MemWrite,
    input  [2:0]  mode,
    input  [31:0]  addr,
    input  [31:0] data_in,
    output reg [31:0] data_out
);

    reg [7:0] mem [4095:0];
    wire [31:0] extended16, extended24;
    
    always @(posedge clk) begin
        case(mode)
            3'b000: data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}; 
            3'b001: data_out = {16'b0, mem[addr+1], mem[addr]};   // loading unsigned HW
            3'b010: data_out = {24'b0,mem[addr]};                // loading unsigned  B
            3'b011: data_out = extended16;                        // loading signed HW
            3'b100: data_out = extended24;                        // loading signed  B
        endcase
    end
    
    SignExtend #(16) x16 ( .in( {mem[addr+1], mem[addr]} ), .out(extended16));
    SignExtend #(24) x24 ( .in(mem[addr]) , .out(extended24));
     
    genvar i;
    always @(posedge rst or posedge clk)
        begin
            if (rst == 1) begin 
//                mem[0] = 8'b0_0100011 ; //sw x1, 12(x0) 
//                mem[1] = 8'b0_010_0110;
//                mem[2] = 8'b0001_0000;
//                mem[3] = 8'b0000000_0;
                $readmemh("C:/Users/eidma/project_1/project_1.srcs/sources_1/new/testCase.txt",mem);
                    
            end
            else begin
              if (MemWrite)
               case(mode)
                     3'b000: begin 
                        mem[addr] =  data_in[7:0];
                        mem[addr+1] =  data_in[15:8];
                        mem[addr+2] =  data_in[23:16];
                        mem[addr+3] =  data_in[31:24];
                     end 
                     3'b001: begin
                      mem[addr] =  data_in[7:0];
                      mem[addr+1] =  data_in[15:8];
                      end
                     3'b010: mem[addr] = data_in[7:0]; 
                 endcase                
            end
        end
   
endmodule


