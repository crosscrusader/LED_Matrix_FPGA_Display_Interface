module top(
	//system
	input osc_clk_in,

	//pll
	output sys_clk,
	output locked,

	//screen_controller
	output R1_data, G1_data,B1_data,
	output R2_data, G2_data, B2_data,
	output A, B, C, D, E,
	output clk_out, done, LAT, OE_N
	);

	screen_controller screen_controller_instantiation(
		.locked		(locked),
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
		.locked		(locked)
		);

endmodule
