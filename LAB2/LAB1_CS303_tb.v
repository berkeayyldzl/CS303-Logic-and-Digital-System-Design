module LAB1_CS303_tb();

reg x3,x2,x1,x0;  // Inputs are registers.
wire out;   // Outputs are wires.

LAB1_CS303 dut(x3, x2, x1, x0, out); // Our design-under-test.

initial begin
    //  * Our waveform is saved under this file.
    
    $dumpfile("LAB1_CS303.vcd"); 
    
    // * Get the variables from the module.

    $dumpvars(0,LAB1_CS303_tb);

    $display("Simulation started.");
     
    x0 = 0;  //1.case
    x1 = 0;
    x2 = 0;
    x3 = 0;

    #10;

    x0 = 1;  //2.case
    x1 = 0;
    x2 = 0;
    x3 = 0;
    
    #10;

    x0 = 0;  //3.case
    x1 = 1;
    x2 = 0;
    x3 = 0;
    
    #10;

    x0 = 1;  //4.case
    x1 = 1;
    x2 = 0;
    x3 = 0;
    
    #10;

    x0 = 0;  //5.case
    x1 = 0;
    x2 = 1;
    x3 = 0;
    
    #10;

    x0 = 1;  //6.case
    x1 = 0;
    x2 = 1;
    x3 = 0;

    #10;

    x0 = 0;  //7.case
    x1 = 1;
    x2 = 1;
    x3 = 0;
     
    #10; 

    x0 = 1;  //8.case
    x1 = 1;
    x2 = 1;
    x3 = 0;
     
    #10; 

    x0 = 0;  //9.case
    x1 = 0;
    x2 = 0;
    x3 = 1;
     
    #10; 

    x0 = 1;  //10.case
    x1 = 0;
    x2 = 0;
    x3 = 1;
     
    #10; 

    x0 = 0;  //11.case
    x1 = 1;
    x2 = 0;
    x3 = 1;
     
    #10; 

    x0 = 1;  //12.case
    x1 = 1;
    x2 = 0;
    x3 = 1;
     
    #10; 

    x0 = 0;  //13.case
    x1 = 0;
    x2 = 1;
    x3 = 1;
     
    #10; 

    x0 = 1;  //14.case
    x1 = 0;
    x2 = 1;
    x3 = 1;
     
    #10; 

    x0 = 0;  //15.case
    x1 = 1;
    x2 = 1;
    x3 = 1;
     
    #10; 

    x0 = 1;  //16.case
    x1 = 1;
    x2 = 1;
    x3 = 1;
    
    #10;
     
    
    $display("Simulation finished.");
    $finish(); // Finish simulation.
end

endmodule