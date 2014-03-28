module a61(input clk, input [3:0] buttons, output [7:0] seg, output [3:0] an, output led);

wire [3:0] button_strobes;
genvar i;
generate for(i=0; i<4; i=i+1)
begin: debounce_loop
	edge_detect my_detector(.clk(clk), .button(buttons[i]), .strobe(button_strobes[i]));
end
endgenerate



wire [15:0] display;
wire [3:0] d_points;
wire [3:0] enable_digits;
combination_lock my_lock(.clk(clk), .buttons(button_strobes[3:0]), .display(display), .points(d_points), .enable_digits(enable_digits));


wire [15:0] scaled_clk;
counter #(.width(16)) clock_scaler(.clk(clk), .increment(1), .count(scaled_clk));
seven_seg_controller my_display(.clk(scaled_clk[15]), .digits(display), .decimal_points(d_points), .enables(enable_digits), .segments(seg), .anodes(an));

endmodule
