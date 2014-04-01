module gen_ce_1024Hz(input clk, input [9:0] ocr, output reg ocr_match);

reg [15:0] gen_1024Hz_counter;
initial gen_1024Hz_counter = 0;

reg [9:0] ce_1024Hz_counter;
initial ce_1024Hz_counter=0;



always @(posedge clk)
begin
	if(gen_1024Hz_counter == 48828)
	begin
		gen_1024Hz_counter=0;
		ce_1024Hz_counter=ce_1024Hz_counter+1;
	end
	else
		gen_1024Hz_counter=gen_1024Hz_counter+1;

	if(ce_1024Hz_counter == ocr)
		ocr_match=1;
	else
		0cr_match=0;
end
endmodule
