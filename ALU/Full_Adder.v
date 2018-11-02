// file: Full_Adder.v
// author: @cherifsalama

`timescale 1ns/1ns

module Full_Adder (
    input a, 
    input b, 
    input cin,
    output sum, 
    output cout 
);

  assign sum = a ^ b ^ cin;
  assign cout = ((a ^ b) & cin) | (a & b);
endmodule

