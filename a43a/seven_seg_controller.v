module seven_seg_controller (input clk,
                             input [4:0] digits0,
                             input [4:0] digits1,
                             input [4:0] digits2,
                             input [4:0] digits3,
							 output [7:0] segments,
							 output reg[3:0] anodes);

	// For some silly reason verilog will not allow arrays as ports so this
	// limbo is nessesary
	wire [4:0] digits [0:3]; // Using an Array allows Multiplexing by index
	assign digits[0] = digits0; assign digits[1] = digits1; assign digits[2] = digits2; assign digits[3] = digits3;

	wire [1:0] digit_index; // Which digit to drive
	counter #(.width(2)) my_counter(.clk(clk), .increment(1), .count(digit_index));

	wire [3:0] digit;
	seven_seg_decoder mydecoder(.digit(digit), .segs(segments[6:0]));

	assign {segments[7], digit} = digits[digit_index]; // segments[7] is the decimal point, which does not need any decoding

	always @(posedge clk)
	begin
		anodes = 4'b1111;
		anodes[digit_index] = 0;
	end
endmodule
