module debouncer #(parameter width=20, parameter top=1000000) (input clk, input button, output reg state);

reg [width-1:0] count;


initial state=0;
initial count=0;

always @(posedge clk)
begin
	if(button != state)
		count = count+1;
	else
		count = 0;

	if(count == top)
	begin
		state=button;
		count = 0;
	end
end
endmodule


