module shift_register #(parameter width=32) (input clk, input toggle_dir, input reset, output reg [width-1:0] register_value);

	reg dir = 0;

	//always @(posedge toggle_dir) // this would probably be the correct way,
	//byt it causes errors within the design flow...
	//begin
	//	dir <= ~dir;
	//end

	always @(posedge clk)
	begin
		if(reset)
			if(dir)
				register_value = { {width-1{1'b0}}, 1 };		// 1 at lowest position
			else
				register_value = { 1, {width-1{1'b0}} };		// 1 at highest position
		else
			if(dir)
				if(register_value == { 1, {width-1{1'b0}} })
					register_value = { {width-1{1'b0}}, 1 };
				else
					register_value = (register_value << 1);

			else
				if(register_value == { {width-1{1'b0}}, 1 })
					register_value = { 1, {width-1{1'b0}} };
				else
					register_value = (register_value >> 1);

		if(toggle_dir) // ... so use this as an albeit not very good alternative
			dir=~dir;
	end
endmodule
