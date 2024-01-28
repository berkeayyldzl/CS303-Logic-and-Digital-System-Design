module CLA_4bit 
  (
   input  [3:0]           C,
   input  [3:0]           D,
   input                  Cin,
   input                  mode, // 0 --> addition , 1 --> subtraction          
   output [3:0]           RES,
   output                 Carry
   );

  wire [3:0] P,G; //for the generate and propogate
  wire [4:0] CarryOut; // for each of the carries including cin i.e c0

  //the logic behind the operation below is coming from the lecture slides, "Subtractor" part, while assigning G and P, we take one input's 
  //xor with mode value

  assign G[0] = C[0] & ( D[0] ^ mode ); //and operation is used for the generate signal
  assign G[1] = C[1] & ( D[1] ^ mode );
  assign G[2] = C[2] & ( D[2] ^ mode );
  assign G[3] = C[3] & ( D[3] ^ mode );

  assign P[0] = C[0] ^ ( D[0] ^ mode ); //xor operation is used for the propogate signal
  assign P[1] = C[1] ^ ( D[1] ^ mode );
  assign P[2] = C[2] ^ ( D[2] ^ mode );
  assign P[3] = C[3] ^ ( D[3] ^ mode );

  assign CarryOut[0] = Cin; //C0 is inputted

  //these are the simplified operations of each carry out signal

  assign CarryOut[1] = G[0] | (Cin & P[0]);           //G0 + (P0·C0) 
  assign CarryOut[2] = G[1] | (P[1] & CarryOut[1]);   //G1 + (P1·C1)
  assign CarryOut[3] = G[2] | (P[2] & CarryOut[2]);   //G2 + (P2·C2)
  assign CarryOut[4] = G[3] | (P[3] & CarryOut[3]);   //G3 + (P3·C3)

  assign Carry = CarryOut[4]; //we assign the last adder's carry to our main output carry

  assign RES[0] = P[0] ^ CarryOut[0]; //then we assign each bit of the result with the xor of propogate and carry
  assign RES[1] = P[1] ^ CarryOut[1];
  assign RES[2] = P[2] ^ CarryOut[2];
  assign RES[3] = P[3] ^ CarryOut[3];

endmodule 