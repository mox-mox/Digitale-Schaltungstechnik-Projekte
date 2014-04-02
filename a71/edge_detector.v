module edge_detector #(parameter detect_posedge=1)(input clk, input signal, output reg is_edge);

reg [1:0] edge_detect;
initial edge_detect=0;

always @(posedge clk)
begin
	edge_detect[1]=edge_detect[0];
	edge_detect[0]=signal;
	if(detect_posedge)
		if(edge_detect==2'b01)
			is_edge=1;
		else
			is_edge=0;
	else
		if(edge_detect==2'b10)
			is_edge=1;
		else
			is_edge=0;
end
endmodule

