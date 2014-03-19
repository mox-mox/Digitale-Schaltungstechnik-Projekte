`timescale 1ns / 1ps
module counter #(parameter width=32) (input clk, input [7:0] increment, output reg [width-1:0] count);

	initial begin
		count = 0;
	end

	always @( posedge clk)begin
		count <= count+increment;
	end
endmodule
