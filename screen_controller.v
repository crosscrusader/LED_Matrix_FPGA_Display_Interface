module screen_controller(
	//input
	input clk_in,

	//output
	////Display Top Half
	output R1_data,
	output G1_data,
	output B1_data,

	//Display Top Half
	output R2_data,
	output G2_data,
	output B2_data,
	
	//Adress Bus
	output A, output B, output C, output D, output E,

	//Operating Signals
	output clk_out,
	output done,
	output LAT,
	output OE_N);
	
//Declarations and Assignments
	//Should support up to 64x64 sized displays
	reg [4:0] row;
	reg [4:0] column;
	assign {E,D,C,B,A} = row;

	//assign states
	reg [1:0] state;
	assign clk_out  = ((state == SDI)&&(clk_in))? 1:0;
	assign OE_N = (state != OUTPUTTING)? 1:0;
	assign LAT = (state == LATCHING)? 1:0;

	//assign colors
	assign R1_data = ((row == 0)&&(column == 0))? 1:0;
	assign G1_data = ((row == 1)&&(column == 1))? 1:0;
	assign B1_data = ((row == 2)&&(column == 2))? 1:0;

	assign R2_data = ((row == 0)&&(column == 0))? 1:0;
	assign G2_data = ((row == 1)&&(column == 1))? 1:0;
	assign B2_data = ((row == 2)&&(column == 2))? 1:0;

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

initial begin
row <= 0;
state <= 0;
end

always @(posedge clk_in) begin
	if(row == SCREEN_DEPTH - 1)
		begin
			row <= 0;
		end
	else
		begin
			row <= row + 1;
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
							state <= SDI;
						end
				end
			endcase
		end // end else
	end //always block

endmodule //screen_controller
