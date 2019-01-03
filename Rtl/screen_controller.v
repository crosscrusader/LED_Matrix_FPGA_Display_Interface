module screen_controller(
	//input
	input clk_in, 

	`ifdef ice40
	input locked,
	`endif

	//output
	////Display Top Half
	output R1_data, G1_data,B1_data,

	//Display Bottom Half
	output R2_data, G2_data, B2_data,
	
	//Adress Bus
	output A, B, C, D, E,

	//Operating Signals
	output clk_out, done, LAT, OE_N
	);
	
//Declarations and Assignments
	//Should support up to 64x64 sized displays
	reg [5:0] row = 0;
	reg [5:0] column = 0;
	assign {E,D,C,B,A} = row[4:0];

	//assign states
	reg [1:0] state = 0;
	assign clk_out  = ((state == SDI)&&(clk_divided))? 1:0;
	assign OE_N = (state != OUTPUTTING)? 1:0;
	assign LAT = (state == LATCHING)? 1:0;

	//assign colors
	assign R1_data = ((row == 0)&&(column == 0)&&(state == SDI))? 1:0;
	assign G1_data = ((row == 1)&&(column == 1)&&(state == SDI))? 1:0;
	assign B1_data = ((row == 2)&&(column == 2)&&(state == SDI))? 1:0;

	assign R2_data = ((row == 0)&&(column == 0)&&(state == SDI))? 1:0;
	assign G2_data = ((row == 1)&&(column == 1)&&(state == SDI))? 1:0;
	assign B2_data = ((row == 2)&&(column == 2)&&(state == SDI))? 1:0;

//Parameters
	parameter 
		//default screen size is 32x16 unless changed
		//should probably change in the top module with
		//defparam if necessary
		SCREEN_WIDTH = 32,
		SCREEN_DEPTH = 16;

	localparam
		//control states
		SDI = 0,
		LATCHING = 1,
		OUTPUTTING = 2,

		//Even picture brightness
		//accomplished by allowing the output 
		//to stay on for a duration of time equal
		//to the time required to shift in 
		//data and latch it
		OUTPUT_DELAY = SCREEN_WIDTH + 1;
reg [31:0] counter = 0;
reg clk_divided = 0;

always @(posedge clk_in) begin
	counter <= counter + 1;
	if(counter == 4)
	begin
	clk_divided <= ~clk_divided;
	counter <= 0;
	end
end

always @(posedge clk_divided) begin
	`ifdef ice40
	if(locked)
	begin
	else
	`endif
				begin
					case(state)
					SDI:
						begin
							column <= column + 1;

							if(column == SCREEN_WIDTH - 1)
								begin
									state <= LATCHING;
									column <= 0;
								end
						end

					LATCHING:
						begin
							state <= OUTPUTTING;
						end

					OUTPUTTING:
						begin
							column <= column + 1;
							
							if(column == OUTPUT_DELAY)
								begin
									column <= 0;
									if(row == SCREEN_DEPTH/2)
											row <= 0;
									else
											row <= row + 1;
									state <= SDI;
								end
						end
					endcase
				end // end else
		`ifdef ice40
		end // locked block
		`endif
	end //always block

endmodule //screen_controller
