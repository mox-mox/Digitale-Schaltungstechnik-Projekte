module a41(input clk, input [7:0] switches, output [7:0] led);

wire [31:0] full_count;

counter #(.width(32)) my_counter(.clk(clk), .increment(switches), .count(full_count));

assign led[7:0] = full_count[29:22];

endmodule
















//module a41 ( input clk, input [7:0] sw, output [7:0] led);
//
//reg [29:0] counter;
//
//assign led[7:0] = counter[29:22];
//
//always @(posedge clk) begin
//	counter <= counter + sw;
//end
//
//endmodule

//module counter #(parameter width=32) (input clk, output reg [width-1:0] count);
//
//	initial begin
//		count = 0;
//	end
//
//	always @( posedge clk)begin
//		count <= count+1;
//	end
//endmodule
