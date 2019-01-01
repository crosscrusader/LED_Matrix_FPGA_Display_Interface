module screen_controller_tb;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		A;			// From uut of screen_controller.v
    wire		B;			// From uut of screen_controller.v
    wire		B1_data;		// From uut of screen_controller.v
    wire		B2_data;		// From uut of screen_controller.v
    wire		C;			// From uut of screen_controller.v
    wire		D;			// From uut of screen_controller.v
    wire		E;			// From uut of screen_controller.v
    wire		G1_data;		// From uut of screen_controller.v
    wire		G2_data;		// From uut of screen_controller.v
    wire		LAT;			// From uut of screen_controller.v
    wire		OE_N;			// From uut of screen_controller.v
    wire		R1_data;		// From uut of screen_controller.v
    wire		R2_data;		// From uut of screen_controller.v
    wire		clk_out;		// From uut of screen_controller.v
    wire		done;			// From uut of screen_controller.v
    // End of automatics
    /*AUTOREGINPUT*/
    // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
    reg			clk_in;			// To uut of screen_controller.v
    reg			locked;			// To uut of screen_controller.v
    // End of automatics

    screen_controller uut(/*AUTOINST*/
			  // Outputs
			  .R1_data		(R1_data),
			  .G1_data		(G1_data),
			  .B1_data		(B1_data),
			  .R2_data		(R2_data),
			  .G2_data		(G2_data),
			  .B2_data		(B2_data),
			  .A			(A),
			  .B			(B),
			  .C			(C),
			  .D			(D),
			  .E			(E),
			  .clk_out		(clk_out),
			  .done			(done),
			  .LAT			(LAT),
			  .OE_N			(OE_N),
			  // Inputs
			  .clk_in		(clk_in));

    initial begin
	clk_in <= 0;
	locked <= 1;
	$dumpfile("dump.vcd");
	$dumpvars;
	#10000 $finish;
    end

    always #5 clk_in <= ~clk_in;
	  


endmodule // screen_controller_tb


// Local Variables:
// verilog-library-flags:("-y ../Rtl")
// End:
