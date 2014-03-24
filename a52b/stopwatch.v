module stopwatch(input clk, input start, input stop, input split, input zero, output [15:0] displayed_time, output led);

reg running;
reg time_split;
reg [15:0] real_count;
reg [15:0] split_count;

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

always @(posedge clk_10Hz or posedge zero)
begin
	if(zero)
		real_count <= 0;
	else
	begin
		if(running)
		begin
			if(real_count[3:0] < 9)
				real_count[3:0] <= real_count[3:0]+1;
			else
			begin
				real_count[3:0] <= 0;
				if(real_count[7:4] < 9)
					real_count[7:4] <= real_count[7:4]+1;
				else
				begin
					real_count[7:4] <= 0;
					if(real_count[11:8] < 5)
						real_count[11:8] <= real_count[11:8]+1;
					else
					begin
						real_count[11:8] <= 0;
						if(real_count[15:12] < 9)
							real_count[15:12] <= real_count[15:12]+1;
						else
							real_count[15:0] <= 0;
					end
				end
			end
		end
	end
end











endmodule
