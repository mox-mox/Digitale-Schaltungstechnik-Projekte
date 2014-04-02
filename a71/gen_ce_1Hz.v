module gen_ce_1Hz(input clk, input dcf_digital, output reg ce_1Hz); // generate a 1Hz clock syncronised to the dcf signal

wire ce_1024Hz;						// get 1024Hz clock
gen_ce_1024Hz my_ce_1024Hz(.clk(clk), .ce_1024Hz(ce_1024Hz));

wire dcf_clean;
debouncer debounce_dcf_digital(.clk(clk), .button(dcf_digital), .state(dcf_clean));
wire negedge_dcf_clean;				// get the edges of the dcf signal
edge_detector #(.detect_posedge(0)) my_edge_detect(.clk(clk), .signal(dcf_clean), .is_edge(negedge_dcf_clean));

reg [9:0] gen_1Hz_counter;			// count to generate a 1Hz timebase
initial gen_1Hz_counter=0;

reg [9:0] sync_count;				// Shift the strobe of the 1Hz timebase to sync to the dcf signal
initial sync_count=0;


reg signed [9:0] count_delta[0:1];	// allow negative values
reg signed [10:0] count_adjust;
always @(posedge clk)
begin
	// TODO: delete from here
	if(ce_1024Hz) // count and generate the 1Hz clock
		gen_1Hz_counter=gen_1Hz_counter+1;
	if(gen_1Hz_counter==sync_count)
		ce_1Hz=1;
	else
		ce_1Hz=0;
	//TODO: to here

//	if(ce_1024Hz) // count and generate the 1Hz clock
//	begin
//		gen_1Hz_counter=gen_1Hz_counter+1;
//		if(gen_1Hz_counter==sync_count)
//			ce_1Hz=1;
//		else
//			ce_1Hz=0;
//	end
//	else
//	begin
//		ce_1Hz=0;
//	end

	// sync the 1Hz clock to the dcf signal
	if (negedge_dcf_clean)
	begin
		count_delta[1]=count_delta[0];
		count_delta[0]=sync_count+41-gen_1Hz_counter;
		count_adjust=((count_delta[1]+count_delta[0])>>1);

		//count_adjust=((count_delta[2]+count_delta[1])>>>1);	// average of last 2 deltas, shift with sign extension
		//if((count_adjust+10 > count_delta[0]) && (count_adjust-10 < count_delta[0])) // if the deviation is not too much
		//begin
			if(count_adjust<0)
				sync_count <= sync_count - count_adjust;			// add it to the syncronisation register
			else
				sync_count <= sync_count + count_adjust;			// add it to the syncronisation register
		//end
	end
end
endmodule


//sync_count <= sync_count + (count_adjust[9:0]>>>1);	// 




//		if(count_delta<0)
	//		begin
	//			sync_count <= sync_count + (count_adjust[9:0]>>>1);
	//		end
	//		else if(count_delta>0)
		//		begin
		//			sync_count <= sync_count + (count_adjust[9:0]>>>1); // maybe the + has to be a -
		//		end
