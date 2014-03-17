module a42(input clk, input dir, input reset, input [7:0] switches, output reg [7:0] led);

	wire [31:0] full_count;
	counter #(.width(32)) my_counter(.clk(clk), .increment(switches), .count(full_count));

	always @(posedge full_count[28]) // decode which leds to ignite directly from the counter output
	begin
		case (full_count[31:29])
			0 : led[7:0] <= 1;
			1 : led[7:0] <= 2;
			2 : led[7:0] <= 4;
			3 : led[7:0] <= 8;
			4 : led[7:0] <= 16;
			5 : led[7:0] <= 32;
			6 : led[7:0] <= 64;
			7 : led[7:0] <= 128;
			default : led[7:0] <= 0;
		endcase
	end

	//shift_register #(.width(8)) my_shift_register(.clk(full_count[28]), .toggle_dir(dir), .reset(reset), .register_value(led));


endmodule
