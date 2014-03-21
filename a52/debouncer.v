module debouncer(input clk, input button, output reg state);

reg [15:0] count;


initial state=0;
initial count=0;

always @(posedge clk)
begin
	if(button != state)
		count = count+1;
	else
		count = 0;

	if(count == 65535)
	begin
		state=button;
		count = 0;
	end
end
endmodule


