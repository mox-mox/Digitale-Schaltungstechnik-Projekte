module a43(input clk, input [7:0] switches, output [6:0] seg, output dp, output [3:0] an);

wire [11:0] full_count;
reg [4:0] numbers [0:3];
counter #(.width(12)) my_counter(.clk(clk), .increment(switches), .count(full_count));

seven_seg_controller my_display(.clk(full_count[11]), .digits0(numbers[0]), .digits1(numbers[1]), .digits2(numbers[2]), .digits3(numbers[3]), .segments(seg), .point(dp), .anodes(an));

initial
begin
	numbers[0] = {0, 4'h0};
	numbers[1] = {0, 4'h1};
	numbers[2] = {0, 4'h2};
	numbers[3] = {1, 4'h3};
end

endmodule




//	seven_seg_decoder my_decoder(.digit(0), .segments(seg));
//
//	assign an = 4'b0111;
//	assign dp = 1;
//	//assign seg = 7'b1000000;
//
//endmodule










