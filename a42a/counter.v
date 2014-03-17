`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Uni Heidelberg
// Engineer: Mox
//
// Create Date:			19:38:42 01/06/2014
// Design Name:			Some counter for Schaltungstechnik-Lecture in WS13/14
// Module Name:			counter
// Project Name:		a41
// Target Devices: 		Digilent Nexys 2, maybe others
// Tool versions: 		Foobar
// Description: 		Just some stuff to learn how to programm stuff
//
// Dependencies: 		None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module counter #(parameter width=32) (input clk, input [7:0] increment, output reg [width-1:0] count);

	initial begin
		count = 0;
	end

	always @( posedge clk)begin
		count <= count+increment;
	end
endmodule
