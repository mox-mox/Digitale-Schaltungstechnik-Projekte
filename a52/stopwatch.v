module stopwatch(input clk, input start, input stop, input split, input zero, output [12:0] displayed_time, output led);

reg running;
reg time_split;
reg [12:0] real_count;
reg [12:0] split_count;

initial running = 0;
initial time_split = 0;
initial real_count = 0;


assign displayed_time = (time_split == 1)? split_count : real_count;

always @(posedge clk)
begin
	if(start == 1)
		running = 1;
	if(stop == 1)
		running = 0;
	if(split==1)
	begin
		split_count <= real_count;
		time_split = ~time_split;
	end
end

wire clk_10Hz;
assign led=clk_10Hz;
gen_10Hz my_clock_divider(.clk(clk), .enable(running), .zero(zero), .clk_10Hz(clk_10Hz));
//gen_10Hz my_clock_divider(.clk(clk), .enable(1), .zero(zero), .clk_10Hz(clk_10Hz));

always @(posedge clk_10Hz or posedge zero)
begin
	if(zero)
		real_count <= 0;
	else
	if(running)
		real_count <= real_count+1;
end
endmodule
