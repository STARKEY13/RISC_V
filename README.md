# RISC_V
Solve a set of linear equations using the Gaussian elimination method In RISC-V
ELL 782: Computer Architecture
Assignment-1
Submission Deadline: September 3, 2023
Released: 2 August, 2023
1 Introduction
The Gaussian elimination method, alternatively referred to as row reduction, is
a computational procedure employed to solve systems of linear equations. The
process involves a series of operations conducted on the matrix of coefficients.
In this assignment, you need to solve a set of linear equations using the
Gaussian elimination method. You have to create an assembly code using RISCV ISA. This assignment needs to be done individually.
2 Implementation
You are given a set of five linear equations represented as AX = B, where A is
a 5 × 5 matrix, X is a 5 × 1 matrix.
a11x1 + a12x2 + a13x3 + a14x4 + a15x5 = b1
a21x1 + a22x2 + a23x3 + a24x4 + a25x5 = b2
a31x1 + a32x2 + a33x3 + a34x4 + a35x5 = b3
a41x1 + a42x2 + a43x3 + a44x4 + a45x5 = b4
a51x1 + a52x2 + a53x3 + a54x4 + a55x5 = b5
You need to find the value of X = x1, x2, x3, x4, x5 that satisfy this system.
2.1 Inputs
Two matrices A and B are given as inputs. These matrices need to be stored in
the row-major format in the memory. Since, RISC-V does not support floatingpoint operations, use the fixed-point notation for storing the values (format:
12.16) where 12-bits are used for integer part, 16 bits for the decimal part, and
rest 4 MSB bits for the sign (refer to Figure 1).
1
2.2 Outputs
The elements of the output matrix X should also follow the fixed-point notation (12.16). There are various possible solutions for a given system of linear
equations and the format of the output for each of those cases is as follows:
• No solution: Print ”No solution exists”
• Unique solution: Print the value of X.
• Infinitely many solutions: Print ”Infinitely many solution exist”.
4 bits 12 bits
32-bit Register
16 bits
Sign bits Integer bits Floating-point bits
Figure 1: Fixed-point representation of a floating point number
2.3 Setup
• A quick start to RISC V assembly language programming is available here.
• You have to use the Microsoft VS-CODE-based locally installed RISC-V
simulator for assembly language code development, execution, and debugging.
• First, you need to install the VS code. You can install the RISC-V Venus
Simulator using the Link
3 Code Verification
In this section, you will implement a simple Python script to test the code you
created. Your program should generate random test cases and then solve the
Gaussian elimination problem. Python will generate the solutions in a floatingpoint format. You need to convert it to the fixed point format. Compare the
results generated from your RISC-V code and your Python script. Report the
error percentage.
• Be prepared to explain the fine details of your sanity test.
• Make sure your script covers all possible cases.
• Make sure to report the average error percentage.
You are free to use any in-built libraries for this part.
2
4 Report
The report should clearly mention the implementation methodology for all the
parts of the assignment. Small code snippets are alright, additionally, the
pseudo-code should also suffice.
• Details that are relevant to the implementation.
• Say what you have done that is extra (this should be the last section in
the document).
• Limit of 10 pages (A4 size) and must be in PDF format (name: report.pdf).
5 Submission Guidelines
• We will run MOSS on the submissions. Any cheating will result in a zero
in the assignment, a penalty as per the course policy and possibly much
stricter penalties (including a fail grade and/or a DISCO).
• There will be demos for assignment 1.
• We will be evaluating your submission with a different set of input numbers. So, make sure your implementation works for all the possible cases.
• You need to submit your RISC-V code, report, and the Python script.
How to submit:
Create a tar ball using:
1 tar czvf assignment1_<entryNumber1>.tar.gz *
This will create a tar ball with name, assignment1 <entryNumber1>.tar.gz.
Submit this tar ball on Moodle. Entry number format: 2019EEZ8358
The submission deadline is 23:59, 03 September 2023.
3
