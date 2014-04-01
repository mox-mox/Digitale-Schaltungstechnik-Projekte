module gen_ce_1Hz(input clk, input [9:0] sync_count, output reg ce_1Hz);

reg [1:0] edge_detector;
initial edge_detoctor=0;
wire ce_1024Hz;
gen_ce_1024Hz my_ce_1024Hz(.clk(clk), .ocr(sync_count), .ocr_match(ce_1024Hz));

always @(posedge clk)
begin
	edge_detector[1] = edge_detector[0];
	edge_detector[0] = ce_1024Hz;
	if(edge_detector = 2'b01)
		ce_1Hz=1;
	else
		ce_1Hz=0;
end
endmodule
