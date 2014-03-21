module a51(input clk, input [3:0] buttons, output [7:0] seg, output [3:0] an, output led);
//module a51(input clk, output led);

wire [3:0] debounced_buttons;
genvar i;
generate for(i=0; i<4; i=i+1)
begin: debounce_loop
	debouncer debounce(.clk(clk), .button(buttons[i]), .state(debounced_buttons[i]));
end
endgenerate



wire [15:0] displayed_time;
stopwatch my_watch(.clk(clk), .start(debounced_buttons[3]), .stop(debounced_buttons[2]), .split(debounced_buttons[1]), .zero(debounced_buttons[0]), .displayed_time(displayed_time), .led(led));


wire [15:0] scaled_clk;
counter #(.width(16)) clock_scaler(.clk(clk), .increment(1), .count(scaled_clk));
seven_seg_controller my_display(.clk(scaled_clk[15]), .digits(displayed_time), .decimal_points(15), .segments(seg), .anodes(an));

endmodule
