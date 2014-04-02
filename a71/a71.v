module a71(input clk, input dcf_digital, output clk78_0, output clk78_90, output led_dcf, output led_1Hz);

assign led_dcf=dcf_digital;
gen_78_125_khz dcf_clock(.clk(clk), .clk_78_0(clk78_0), .clk_78_90(clk78_90));

gen_ce_1Hz my_1Hz_generator(.clk(clk), .dcf_digital(dcf_digital), .ce_1Hz(led_1Hz));

endmodule
