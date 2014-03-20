module a51(input clk, input [3:0] buttons, output [7:0] seg, output [3:0] an);

wire [15:0] counts;



wire [3:0] debounced_buttons;
genvar i;
generate for (i =0; i<4; i=i+1)
begin: loop1
	debouncer my_debouncer(.clk(clk), .button(buttons[i]), .state(debounced_buttons[i]));
end
endgenerate


generate for (i =0; i<4; i=i+1)
begin: loop2
	bounce_counter my_bounce_counter(.clk(clk), .button(debounced_buttons[i]), .count(counts[i*4+3:i*4]));
end
endgenerate


wire [15:0] scaled_clk;
counter #(.width(16)) clock_scaler(.clk(clk), .increment(1), .count(scaled_clk));
seven_seg_controller my_display(.clk(scaled_clk[15]), .digits(counts), .decimal_points(0), .segments(seg), .anodes(an));

endmodule
