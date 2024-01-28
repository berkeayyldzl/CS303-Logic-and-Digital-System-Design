module DigiHockey_tb();


// Do not worry too much about these parameter statements, they are here to ease your work
parameter HP = 5;       // Half period of our clock signal
parameter FP = (2*HP);  // Full period of our clock signal

reg clk, rst, START;
reg [1:0] DIRECTION;
reg [2:0] INIT_Y_POS;


wire [2:0] X_COORD, Y_COORD;

// Our design-under-test is the DigiHockey module
DigiHockey dut(clk, rst, START, DIRECTION, INIT_Y_POS, X_COORD, Y_COORD);

// This always statement automatically cycles between clock high and clock low in HP (Half Period) time. Makes writing test-benches easier.
always #HP clk = ~clk;

initial begin
    $dumpfile("DigiHockey.vcd"); //  * Our waveform is saved under this file.
    $dumpvars(0,DigiHockey_tb); // * Get the variables from the module.
    
    $display("Simulation started.");

    // * Initialize the testbench variables
    clk = 0; // Set clock low (we won't have to write clk = 1 again, thanks to those parameter and always statements we gave you)
    rst = 0;
    START = 0;
    DIRECTION = 0;
    INIT_Y_POS = 0;
    
	// Here, you are asked to write your test scenario.
	// The test scenario must cover all possible cases (moving directions and bouncings)
	
	#FP rst = 1; // Set reset initially
    
    
    // moving right
    INIT_Y_POS = 2;
    START = 1;
    #FP;
    START = 0;

    // moving left
    INIT_Y_POS = 1;
    START = 1;
    #FP;
    START = 0;

    // top-right corner
    INIT_Y_POS = 4;
    START = 1;
    DIRECTION = 2'b01;
    #FP;
    START = 0;

    // bottom-left corner
    INIT_Y_POS = 0;
    START = 1;
    DIRECTION = 2'b10;
    #FP;
    START = 0;

    // top-edge movement
    INIT_Y_POS = 0;
    START = 1;
    DIRECTION = 2'b01;
    #FP;
    START = 0;

    // bottom-edge movement
    INIT_Y_POS = 4;
    START = 1;
    DIRECTION = 2'b10;
    #FP;
    START = 0;
	
    $display("Simulation finished.");
    $finish(); // Finish simulation.
end



endmodule