module bounce_counter(input clk, input button, output reg [3:0] count);

reg [1:0] edge_detect=0;

initial count = 0;


always @(posedge clk)
	begin
		edge_detect[1] = edge_detect[0];
		edge_detect[0] = button;

		if(edge_detect[1:0] == 2'b01)
			count = count+1;
	end
endmodule

