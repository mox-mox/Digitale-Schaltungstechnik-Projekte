module seven_seg_controller (input clk,
                             input [15:0] digits,
                             input [3:0] decimal_points,
							 output [7:0] segments,
							 output reg[3:0] anodes);

	// For some silly reason verilog will not allow arrays as ports so this limbo is nessesary
	wire [4:0] digits_array [0:3]; // Using an Array allows Multiplexing by index
	assign digits_array[3] = digits[15:12];
	assign digits_array[2] = digits[11:8];
	assign digits_array[1] = digits[7:4];
	assign digits_array[0] = digits[3:0];

	wire [1:0] digit_index; // Which digit to drive
	counter #(.width(2)) my_counter(.clk(clk), .increment(1), .count(digit_index));
	wire [3:0] digit;
	assign digit = digits_array[digit_index];
	assign segments[7] = decimal_points[digit_index];

	seven_seg_decoder mydecoder(.digit(digit), .segs(segments[6:0]));


	always @(posedge clk)
	begin
		anodes = 4'b1111;
		anodes[digit_index] = 0;
	end
endmodule




module seven_seg_decoder(input [3:0] digit, output reg [6:0] segs);

always @(digit)
begin
	segs = 0;

	case (digit[3:0])
		0	: segs[6:0] = 7'b1000000;
		1	: segs[6:0] = 7'b1111001;
		2	: segs[6:0] = 7'b0100100;
		3	: segs[6:0] = 7'b0110000;
		4	: segs[6:0] = 7'b0011001;
		5	: segs[6:0] = 7'b0010010;
		6	: segs[6:0] = 7'b0000010;
		7	: segs[6:0] = 7'b1111000;
		8	: segs[6:0] = 7'b0000000;
		9	: segs[6:0] = 7'b0010000;
		10	: segs[6:0] = 7'b0001000;
		11	: segs[6:0] = 7'b0000011;
		12	: segs[6:0] = 7'b1000110;
		13	: segs[6:0] = 7'b0100001;
		14	: segs[6:0] = 7'b0000110;
		15	: segs[6:0] = 7'b0001110;
		default: segs[6:0] = 0;	// Turn off the display when no valid digit is applied
	endcase

end
endmodule
