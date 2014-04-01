module a71(input clk, input dcf_digital, output clk78_0, output clk78_90, output led);

assign led=dcf_digital;
gen_78_125_khz dcf_clock(.clk(clk), .clk_78_0(clk78_0), .clk_78_90(clk78_90));


endmodule
