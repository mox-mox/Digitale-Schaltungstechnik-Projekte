module edge_detect(input clk, input button, output reg strobe);

wire debounced_button;
debouncer my_debouncer(.clk(clk), .button(button), .state(debounced_button));

reg [1:0] detector;
initial detector=0;

always @(posedge clk)
begin
	detector[1]=detector[0];
	detector[0]=debounced_button;
	if(detector==2'b01)
		strobe=1;
	else
		strobe=0;
end
endmodule
