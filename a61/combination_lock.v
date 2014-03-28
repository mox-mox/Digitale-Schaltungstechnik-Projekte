module combination_lock(input clk, input [3:0] buttons, output reg [15:0] display, output reg [3:0] points, output reg [3:0] enable_digits);

reg [4:0] state;
initial state=0;

reg [2:0] combination[0:3];
initial
begin
	combination[0] = 3'b001;
	combination[1] = 3'b010;
	combination[2] = 3'b100;
	combination[3] = 3'b001;
end

reg [2:0] new_combination[0:3];
initial
begin
	new_combination[0] = 3'b000;
	new_combination[1] = 3'b000;
	new_combination[2] = 3'b000;
	new_combination[3] = 3'b000;
end

always @(posedge clk)
begin
	casex(state)
		0, 1, 2, 3:
			if(buttons != 0)
				if(buttons[3])
					state<=0;
				else
				if(buttons == combination[state])
					state <= state+1;
				else
					state <= 0;
		4:
			if(buttons != 0)
				if(buttons[3])
					state<=0;
				else
				begin
					new_combination[state-4]=buttons[2:0];
					state <= state+1;
				end
			else
				state<=state;
		5, 6, 7:
			if(buttons != 0)
				if(buttons[3])
					state<=4;
				else
				begin
					new_combination[state-4]=buttons[2:0];
					state <= state+1;
				end
			else
				state<=state;
		8:
			if(buttons != 0)
				if(buttons[3])
					state<=4;
				else
				begin
					combination[0]=new_combination[0];
					combination[1]=new_combination[1];
					combination[2]=new_combination[2];
					combination[3]=new_combination[3];
					state<=4;
				end
			else
				state<=state;


		default: state<=state;
	endcase
end

function [3:0] get_binary_key;
	input [2:0] one_hot_key;
	if(one_hot_key == 3'b100)
		get_binary_key = 2;
	else if(one_hot_key == 3'b010)
		get_binary_key = 1;
	else if(one_hot_key == 3'b001)
		get_binary_key = 0;
	else
		get_binary_key = 4'h3;
endfunction


always @(state)
begin
	points = 4'b1111;
	enable_digits=4'b1111;
	case(state)
		0, 1, 2, 3:
		begin
			display <= 16'h8888;
			points[state-1] = 0;
		end
		4:
		begin
			display <= 16'h0000;
			points = 4'b0000;
		end
		5:
		begin
			display<={get_binary_key(new_combination[0]),12'b000000000000};
			enable_digits=4'b1000;
			points = 4'b0000;
		end
		6:
		begin
			display<={get_binary_key(new_combination[0]),get_binary_key(new_combination[1]),8'bzzzzzzzz};
			enable_digits=4'b1100;
			points = 4'b0000;
		end
		7:
		begin
			display<={get_binary_key(new_combination[0]),get_binary_key(new_combination[1]),get_binary_key(new_combination[2]),4'bzzzz};
			enable_digits=4'b1110;
			points = 4'b0000;
		end
		8:
		begin
			display<={get_binary_key(new_combination[0]),get_binary_key(new_combination[1]),get_binary_key(new_combination[2]),get_binary_key(new_combination[2])};
			enable_digits=4'b1111;
			points = 4'b0000;
		end
	endcase
end
endmodule
