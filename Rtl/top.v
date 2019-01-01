module top(
	//system
	input osc_clk_in,

	`ifdef ice40
	output locked,
	`endif

	`ifdef ecp5
	output GND1, GND2, GND3,
	`endif

	//screen_controller
	output R1_data, G1_data,B1_data,
	output R2_data, G2_data, B2_data,
	output A, B, C, D, E,
	output clk_out, done, LAT, OE_N
	);
	
	//pll
	wire sys_clk;

	`ifdef ecp5
	//ecp5
	assign GND1 = 0;
	assign GND2 = 0;
	assign GND3 = 0;
	`endif

	screen_controller screen_controller_instantiation(
	`ifdef ice40	
		.locked		(locked),
	`endif
		.clk_in		(sys_clk),
		.R1_data	(R1_data),
		.G1_data	(G1_data),
		.B1_data	(B1_data),
		.R2_data	(R2_data),
		.G2_data	(G2_data),
		.B2_data	(B2_data),
			.A	(A) ,
			.B	(B) ,
			.C	(C) ,
			.D	(D) ,
			.E	(E) ,
		.clk_out	(clk_out),
		.done	(done),
		.LAT	(LAT),
		.OE_N	(OE_N)
	);

	pll	pll_instantiation(
		.clock_in	(osc_clk_in),
		.clock_out	(sys_clk),
	`ifdef ice40
		.locked		(locked)
	`endif
		);

endmodule
