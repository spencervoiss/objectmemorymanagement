/****************************************
* File: Read- & Write-Enabled Registers *
* Project: Permission Read             *
* Author: Spencer Voiss               *
* Date: 18 October 2017              *
************************************/

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

module read_write_enabled_register(clk,read_enable,write_enable,in,out);
	
	parameter width = 8;

	input clk, write_enable, read_enable;
	input [width-1:0] in;
	output [width-1:0] out;
	wire [width-1:0] data;

	write_enabled_register data_register(clk,write_enable,in,data);
	defparam data_register.width = width;
	
	always@(posedge clk)
	begin
		if(read_enable) out=data;
		// else out = width'bZ;
		else out = {width{1'bZ}};
	end
endmodule
