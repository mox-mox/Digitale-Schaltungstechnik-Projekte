module seven_seg_controller (input clk,
                             input [4:0] digits0,
                             input [4:0] digits1,
                             input [4:0] digits2,
                             input [4:0] digits3,
							 output [6:0] segments,
							 output reg point,
							 output reg[3:0] anodes);

	wire [1:0] full_count;
	reg [3:0] digit;
	counter #(.width(2)) my_counter(.clk(clk), .increment(1), .count(full_count));
	seven_seg_decoder mydecoder(.digit(digit), .segs(segments));

	always @(posedge clk)
	begin
		case (full_count)
			0 :	begin
					{point, digit[3:0]} <= (digits0);
					anodes <= 4'b1110;
				end
			1 :	begin
					{point, digit[3:0]} <= (digits1);
					anodes <= 4'b1101;
				end
			2 :	begin
					{point, digit[3:0]} <= (digits2);
					anodes <= 4'b1011;
				end
			3 :	begin
					{point, digit[3:0]} <= (digits3);
					anodes <= 4'b0111;
				end
			default : begin
					{point, digit[3:0]} <= 5'b11111;
					anodes <= 4'b1111;
				end
		endcase
	end
endmodule
