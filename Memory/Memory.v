// file: DataMem.v
// author: @cherifsalama

`timescale 1ns/1ns

 module Memory(
    input         clk,
    input         clk_i,
    input         rst,
    input         MemRead,
    input         MemWrite,
    input  [2:0]  mode,
    input  [31:0] addr,
    input  [31:0] data_in,
    output reg [31:0] data_out
);

    reg [7:0] mem [4095:0];
    wire [31:0] extended16, extended24;
    
    always @(*) begin
        if (clk)
            data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}; 
        else begin
                case(mode)
                    3'b000: data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}; 
                    3'b001: data_out = {16'b0, mem[addr+1], mem[addr]};   // loading unsigned HW
                    3'b010: data_out = {24'b0,mem[addr]};                // loading unsigned  B
                    3'b011: data_out = extended16;                        // loading signed HW
                    3'b100: data_out = extended24;                        // loading signed  B
                endcase
            end
    end
    
    SignExtend #(16) x16 ( .in( {mem[addr+1], mem[addr]} ), .out(extended16));
    SignExtend #(24) x24 ( .in(mem[addr]) , .out(extended24));
     

    always @(posedge rst or negedge clk)
        begin
            if (rst == 1) begin 
<<<<<<< HEAD
                $readmemh("C:/Users/eidma/Desktop/PrjSim/testCase.txt",mem);
//                // CSRC
//                mem[8] = 8'h73;
//                mem[9] = 8'he2;
//                mem[10] = 8'h24;
//                mem[11] = 8'hb0;
//                // MRET
//                mem[32] = 8'b01110011;
//                mem[33] = 8'b00000000;
//                mem[34] = 8'b00100000;
//                mem[35] = 8'b00110000;
=======
                $readmemh("C:/Users/eidma/Desktop/Project/Project/src/testCase.txt",mem);
>>>>>>> a89a1fd4b6a0ba4c10a618539485cdb2fe01a9f2
            end
            else begin
                if (MemWrite && clk_i) begin
                    case(mode)
                        3'b000: begin 
                            mem[addr] =  data_in[7:0];
                            mem[addr+1] =  data_in[15:8];
                            mem[addr+2] =  data_in[23:16];
                            mem[addr+3] =  data_in[31:24];
                        end 
                        3'b001: begin
                            $display("address = %d", addr);
                            mem[addr] =  data_in[7:0];
                            mem[addr+1] =  data_in[15:8];
                        end
                            3'b010: mem[addr] = data_in[7:0]; 
                    endcase                
                end
            end
            
    end
   
endmodule


