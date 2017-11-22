/***************************
* File: SR Flip Flop       *
* Project: Permission Read *
* Author: Spencer Voiss    *
* Date: 11 October 2017    *
***************************/

module sr_flip_flop(clk,set,reset,out);
	output reg out;
	input set, reset, clk;

	initial 
	begin
		out=1'b0;
	end

	always @(posedge clk)
	begin
		case({set,reset})
			{1'b0,1'b0}:
			begin
				out=out;
			end
			{1'b0,1'b1}: 
			begin
				out=1'b0;
			end
			{1'b1,1'b0}:
			begin
				out=1'b1;
			end
			{1'b1,1'b1}:
			begin
				out=1'bx;
			end
		endcase
	end
endmodule
