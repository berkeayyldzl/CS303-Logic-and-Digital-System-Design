module CLA_16bit_tb();

reg  [15:0]         A, B; // Inputs
reg                 mode;  // mode (add or subtract)
wire [15:0]         S; // result
wire                Ovf;   // Outputs are wires.
wire                Cout;

CLA_16bit_top dut(A, B, mode, S, Cout ,Ovf); // Our design-under-test.

initial begin
    //  * Our waveform is saved under this file.
    
    $dumpfile("CLA_16bit_top.vcd"); 
    
    // * Get the variables from the module.

    $dumpvars(0,CLA_16bit_tb);

    $display("Simulation started.");

    
    //Case 1, addition without a carry and without an overflow:

    A = 16'd25;
    B = 16'd10;
    mode = 1'b0;
    #10;

    //Case 2, addition without a carry and with an overflow:

    A = 16'd32760;
    B = 16'd50;
    mode = 1'b0;
    #10;

    //Case 3, addition with a carry and without an overflow:

    A = 16'd32000;
    B = 16'd16000;
    mode = 1'b0;
    #10;

    //Case 4, addition with a carry and with an overflow:

    A = 16'd32767;
    B = 16'd2;
    mode = 1'b0;
    #10;

    //Case 5, subtraction without a carry and without an overflow:

    A = 16'd40;
    B = 16'd10;
    mode = 1'b1;
    #10;

    //Case 6, subtraction without a carry and with an overflow:

    A = 16'd10;
    B = 16'd20;
    mode = 1'b1;
    #10;

    //Case 7, subtraction with a carry and without an overflow:

    A = 16'd500;
    B = 16'd100;
    mode = 1'b1;
    #10;

    //Case 8, subtraction with a carry and with an overflow:

    A = 16'd20;
    B = 16'd50;
    mode = 1'b1;
    #10;
    
    $display("Simulation finished.");
    $finish(); // Finish simulation.
end

endmodule