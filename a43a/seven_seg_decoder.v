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
