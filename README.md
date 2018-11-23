RV32IC-CPU

Implementation of the RV32IC processor in verilog.

The Repository contains the following:

RTL: contains all the verilog implementations

Test: contains the testCase.txt file where you can put your own testcases, and contains a simulation configuration file that you can use to see a nice looking simulation.


If you want to test your own code: 
convert your code to hex, 
then go to the file “RTL/TestBench/testCase.txt” in the project directory and paste your code into it. 
Please make sure to change the path of the "testCase.txt" file in the $readmemh() function in the Memory module according to your own path.


