module a41(input clk, input [7:0] switches, output [7:0] led);

	wire [31:0] full_count;
	counter #(.width(32)) my_counter(.clk(clk), .increment(switches), .count(full_count));
	assign led[7:0] = full_count[29:22];

endmodule
