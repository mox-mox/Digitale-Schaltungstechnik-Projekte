module gen_78_125_khz(input clk, output reg clk_78_0, output reg clk_78_90);

reg [8:0] counter;

initial
begin
	counter=0;
	clk_78_0=0;
	clk_78_90=1;
end

always @(posedge clk)
begin
	if(counter==0)
		clk_78_0 = ~clk_78_0;
	if(counter==160)
		clk_78_90=~clk_78_90;
	if(counter==320)
		counter=0;
	else
		counter=counter+1;
end
endmodule
