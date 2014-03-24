module gen_10Hz(input clk, input enable, input zero, output reg clk_10Hz);

reg [22:0] count;

initial count=0;

always @(posedge clk)
begin
	if(zero == 1)
		count <= 0;
	if(enable == 1)
	begin
		case(count)
			0:
			begin
				count <= count+1;
				clk_10Hz <= 0;
			end
			2500000:
			begin
				count <= count+1;
				clk_10Hz <= 1;
			end
			5000000:	count <= 0;
			default:	count <= count + 1;
		endcase
	end
end

endmodule

