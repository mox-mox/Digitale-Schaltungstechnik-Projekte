module a43(input clk, input [7:0] switches, output [7:0] seg, output [3:0] an);

wire [15:0] full_count;
reg [3:0] numbers [0:3];
reg [3:0] points;
counter #(.width(16)) my_counter(.clk(clk), .increment(switches), .count(full_count));

seven_seg_controller my_display(.clk(full_count[15]), .digits({numbers[3], numbers[2], numbers[1], numbers[0]}), .decimal_points(points), .segments({dp,seg}), .anodes(an));

initial
begin
	numbers[0] = {4'ha};
	numbers[1] = {4'hb};
	numbers[2] = {4'hc};
	numbers[3] = {4'hd};

	points = 4'b1111;
end

endmodule
