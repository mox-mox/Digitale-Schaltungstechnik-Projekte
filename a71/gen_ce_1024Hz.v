module gen_ce_1024Hz(input clk, output reg ce_1024Hz); // generate a 1024Hz clock

reg [15:0] gen_1024Hz_counter;
initial gen_1024Hz_counter = 0;

always @(posedge clk)
begin
	if(gen_1024Hz_counter == 48828)
	begin
		gen_1024Hz_counter=0;
		ce_1024Hz=1;
	end
	else
	begin
		gen_1024Hz_counter=gen_1024Hz_counter+1;
		ce_1024Hz=0;
	end
end
endmodule
