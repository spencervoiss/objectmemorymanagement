/***************************
* File: Input Buffer       *
* Project: Permission Read *
* Author: Spencer Voiss    *
* Date: 11 October 2017    *
***************************/
`include "write_enabled_register.v"
`include "sr_flip_flop.v"

module protected_read_core_input_buffer(
	clk,
	ff_set,
	ff_reset,
	write_e,
	internal_index_register_in,
	process_token_register_in,
	permission_level_send_register_in,
	permission_level_object_register_in,
	ff_out,
	internal_index_register_out,
	process_token_register_out,
	permission_level_send_register_out,
	permission_level_object_register_out);

	parameter internal_index_register_width = 8;
	parameter process_token_register_width = 160;
	parameter permission_level_send_register_width = 2;
	parameter permission_level_object_register_width = 2;

	input clk,ff_set,ff_reset,write_e;
	input [internal_index_register_width-1:0] internal_index_register_in;
	input [process_token_register_width-1:0] process_token_register_in;
	input [permission_level_send_register_width-1:0] permission_level_send_register_in;
        input [permission_level_object_register_width-1:0] permission_level_object_register_in;

	output ff_out;
	output [internal_index_register_width-1:0] internal_index_register_out;
        output [159:0] process_token_register_out;
	output [1:0] permission_level_send_register_out;
	output [1:0] permission_level_object_register_out;

	sr_flip_flop status_of_input_data_ff(ff_set,ff_reset,ff_out);
	write_enabled_register internal_index(clk,write_e,internal_inded_register_in,internal_index_register_out);
	defparam internal_index.width=internal_index_register_width;
	write_enabled_register process_token(clk,write_e,process_token_register_in,process_token_register_out);
	defparam process_token.width=process_token_register_width;
	write_enabled_register permission_level_sender(clk,write_e,permission_level_send_register_in,permission_level_send_register_out);
	defparam permission_level_sender.width=permission_level_send_register_width;
	write_enabled_register permission_level_object(clk,write_e,permission_leve_object_register_in,permission_level_object_register_out);
	defparam permission_level_object.width=permission_level_object_register_width;
endmodule

module protected_read_input_buffer(
	clk,
	ff_set,
	ff_reset,
	write_e,
	internal_index_register_in,
	process_token_register_in,
	permission_level_send_register_in,
	permission_level_object_register_in,
	ff_out,
	internal_index_register_out,
	process_token_register_out,
	adder_fixed_value,
	adder_out,
	comparator_out);

	parameter internal_index_register_width = 8;
	parameter process_token_register_width = 160;
	parameter permission_level_send_register_width = 2;
	parameter permission_level_object_register_width = 2;
	parameter add_fixed_value_width = 8;

	input clk,ff_set,ff_reset,write_e;
	input [internal_index_register_width-1:0] internal_index_register_in;
	input [process_token_register_width-1:0] process_token_register_in;
	input [permission_level_send_register_width-1:0] permission_level_send_register_in;
	input [permission_level_object_register_width-1:0] permission_level_object_register_in;
	input [add_fixed_value_width-1:0] add_fixed_value;

	output [process_token_register_width-1:0] process_token_register_out;
	output [internal_index_register_width-1:0] internal_index_register_out;
	output [add_fixed_value_width-1:0] adder_out;
	output comparator_out;
	output ff_out;

	wire [internal_index_register_width-1:0] internal_index_register_direct_out;
	wire [permission_level_object_register_width-1:0] permission_level_object_register_out;
	wire [permission_level_send_register_width-1:0] permission_level_send_register_out;

	protected_read_core_input_buffer input_buffer(
		clk,
		ff_set,
		ff_reset,
		write_e,
		internal_index_register_in,
		process_token_register_in,
		permission_level_send_register_in,
		permission_level_object_register_in,
		ff_out,
		internal_index_register_direct_out,
		process_token_register_out,
		permission_level_send_register_out,
		permission_level_object_register_out);
	defparam protected_read_core_input_buffer.internal_index_register_width=internal_index_register_width;
	defparam protected_read_core_input_buffer.process_token_register_width=process_token_register_width;
	defparam protected_read_core_input_buffer.permission_level_send_register_width=permission_level_send_register_width;
	defparam protected_read_core_input_buffer.permission_level_object_register_width=premission_level_object_register_width;

	assign internal_index_register_out=internal_index_register_direct_out;

	assign adder_out=add_fixed_value+internal_index_register_direct_out;

	assign comparator_out = (permission_level_sender_register_out > permission_level_object_register_out) ? 1 : 0; 


endmodule
