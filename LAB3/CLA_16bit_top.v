`include "CLA_4bit.v" 

module CLA_16bit_top 
    (
        input   [15:0]          A,
        input   [15:0]          B,
        input                   mode, // 0 --> addition , 1 --> subtraction
        output  [15:0]          S,
        output                  Cout,
        output                  OVF
    );    

    wire [3:0] Carry_Out; //a 4 bit carry out signal, to insert one cla's output carry to others input


    //these are the declarations of our 4 bit cla's. Directly taken from lecture slides. Modified the first cin as the mode signal,
    //as it is mandatory to not have a minus 1 in subtraction operation

    CLA_4bit CLA_1 (.C(A[3:0]), .D(B[3:0]), .Cin(mode), .mode(mode), .RES(S[3:0]), .Carry(Carry_Out[0]));
    CLA_4bit CLA_2 (.C(A[7:4]), .D(B[7:4]), .Cin(Carry_Out[0]), .mode(mode), .RES(S[7:4]), .Carry(Carry_Out[1]));
    CLA_4bit CLA_3 (.C(A[11:8]), .D(B[11:8]), .Cin(Carry_Out[1]), .mode(mode), .RES(S[11:8]), .Carry(Carry_Out[2]));
    CLA_4bit CLA_4 (.C(A[15:12]), .D(B[15:12]), .Cin(Carry_Out[2]), .mode(mode), .RES(S[15:12]), .Carry(Carry_Out[3]));

    assign Cout = Carry_Out[3]; //assigning the last carry to our cout signal.

    //the overflow detection is tried to be implemented according to the overflow detection page in the lecture slides page 51, i used the second approach
    //since i don't wanted to use if-else statements, i used ternary operator, if the circuit acts as an adder, first part is executed, else the right part.
    
    assign OVF = (mode == 0) ? ((A[15] & B[15] & ~S[15]) | (~A[15] & ~B[15] & S[15])) : ((A[15] & ~B[15] & ~S[15]) | (~A[15] & B[15] & S[15]));


        

 
endmodule 