/***************************
* File: Output Buffer      *
* Project: Permission Read *
* Author: Spencer Voiss    *
* Date: 25 October 2017    *
***************************/
`include "sr_flip_flop.v"
// sr_flip_flop(clk,set,reset,out)
`include "read_write_enabled_register.v"
// write_enabled_register(clk,write_enable,in,out)
// read_write_enabled_register(clk,read_enable,write_enable,in,out)

module protected_read_output_buffer(
	clk,
	write_enable,
	read_enable,
	process_token_register_in,
	data_found_register_in,
	success_of_execution_ff_in,
	status_of_input_data_ff_set,
	status_of_input_data_ff_reset,
	process_token_register_out,
	data_found_register_out,
	success_of_execution_ff_out,
	status_of_input_data_ff_out);

	parameter process_token_register_width=160;	
	parameter data_found_register_width = 8;

    input clk, write_enable, read_enable;
    input success_of_execution_ff_in;
    input status_of_input_data_ff_set, status_of_input_data_ff_reset;
	input [process_token_register_width-1:0] process_token_register_in;
	input [data_found_register_width-1:0] data_found_register_in;

    output [process_token_register_width-1:0] process_token_register_out;
    output [data_found_register_width-1:0] data_found_register_out;
    output success_of_execution_ff_out, status_of_input_data_ff_out;

	read_write_enabled_register process_token_register(clk,read_enable,write_enable,process_token_register_in,process_token_register_out);
	defparam process_token_register.width = process_token_register_width;

	read_write_enabled_register data_found_register(clk,read_enable,write_enable,data_found_register_in,data_found_register_out);
	defparam data_found_register.width = data_found_register_width;

	write_enabled_register success_of_execution_ff(clk,write_enable,success_of_execution_ff_out);
	defparam success_of_exdcution_ff.width = 1;

	sr_flip_flop status_of_input_data_ff(clk,status_of_input_data_set,status_of_input_data_reset,status_of_input_data_ff_out);

endmodule
