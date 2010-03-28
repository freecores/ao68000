/* 
 * Copyright 2010, Aleksander Osman, alfik@poczta.fm. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice, this list of
 *     conditions and the following disclaimer.
 *
 *  2. Redistributions in binary form must reproduce the above copyright notice, this list
 *     of conditions and the following disclaimer in the documentation and/or other materials
 *     provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*! \file register_ram.v
 * \brief Altera-specific register set implemented as RAM.
 */

/*! \brief Register set implemented as RAM.
 *
 * Currently this module contains a <em>altsyncram</em> instantiation
 * from Altera Megafunction/LPM library.
 */
module register_ram(
	input clock,
	
	input [2:0] address,
	input [3:0] byte_enable,
	input write_enable,
	input [31:0] data_input,
	output [31:0] data_output
);

altsyncram ram(
	.clock0(clock),

	.address_a(address),	
	.byteena_a(byte_enable),
	.wren_a(write_enable),
	.data_a(data_input),
	.q_a(data_output)
);
defparam ram.operation_mode = "SINGLE_PORT";
defparam ram.width_a = 32;
defparam ram.widthad_a = 3;
defparam ram.outdata_reg_a = "UNREGISTERED";
defparam ram.width_byteena_a = 4;

endmodule
