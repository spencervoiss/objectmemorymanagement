/*******************************
* File: Write-Enabled Register *
* Project: Permission Read     *
* Author: Spencer Voiss        *
* Date: 18 October 2017        *
*******************************/

module write_enabled_register(clk,write_enable,in,out);

	parameter width = 8;
	
	input clk, write_enable;
	input [width-1:0] in;
	output [width-1:0] out;
	reg [width-1:0] data;
	
	assign out=data;

	always@(posedge clk)
	begin
		if (write_enable) data=in;
	end
endmodule
