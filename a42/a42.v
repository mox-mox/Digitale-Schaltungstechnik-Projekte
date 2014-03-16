module a42(input clk, input dir, input reset, input [7:0] switches, output [7:0] led);

	wire [31:0] full_count;
	counter #(.width(32)) my_counter(.clk(clk), .increment(switches), .count(full_count));

	shift_register #(.width(8)) my_shift_register(.clk(full_count[28]), .dir(dir), .reset(reset), .register_value(led));


endmodule
