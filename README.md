# RV32IC-CPU
Implementation of the RV32IC Processor in Verilog HDL

<h1>Directories</h1>
The Repository contains the following Directories:
<h3>RTL</h3>
Contains all the verilog implementations

<h3>Test</h3>
Contains the testCase.txt file where you can put your own testcases (assembly instructions), and contains a simulation configuration file that you can use to see a nice looking simulation.

<h3>Reports</h3>
Contains a full detailed documentation about the CPU implementation.

<h1>Test it yourself!</h1>
If you want to test your own code on my RISCV32IC CPU, please do the following: <br>
1. convert your code to hex, <br>
2. then go to the file “RTL/TestBench/testCase.txt” in the project directory and paste your code into it. <br>
3. Please make sure to change the path of the "testCase.txt" file in the $readmemh() function in the Memory module according to your own path.


