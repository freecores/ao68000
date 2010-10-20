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

/*! \file alu_mult_div.v
 * \brief Altera-specific multiplication and division modules.
 */
 
/*! \brief Multiplication and division modules.
 *
 * Currently this module contains <em>lpm_divide</em> and <em>lpm_mult</em> instantiations
 * from Altera Megafunction/LPM library.
 *
 * There are separate modules for:
 *  - unsigned multiplication,
 *  - signed multiplication,
 *  - unsigned division,
 *  - singed division.
 */
module alu_mult_div(
	input clock,

	input [31:0] operand1,
	input [31:0] operand2,

	output [31:0] divu_quotient,
	output [15:0] divu_remainder,

	output [31:0] divs_quotient,
	output [15:0] divs_remainder,

	output [31:0] mulu_result,
	output [31:0] muls_result
);

// DIVU: 32-bit operand1 unsigned / 16-bit operand2 unsigned = {16-bit remainer unsigned, 16-bit quotient unsigned}
// DIVU: division by 0: trap, 	overflow when quotient > 16-bit signed integer, operands not affected
lpm_divide divu(
	.clock(clock),
	.numer(operand1[31:0]),
	.denom(operand2[15:0]),
	.quotient(divu_quotient),
	.remain(divu_remainder)
);
defparam divu.lpm_widthn = 32;
defparam divu.lpm_widthd = 16;
defparam divu.lpm_nrepresentation = "UNSIGNED";
defparam divu.lpm_drepresentation = "UNSIGNED";
defparam divs.lpm_hint = "LPM_REMAINDERPOSITIVE=TRUE";
defparam divu.lpm_pipeline = 30;

// DIVS: 32-bit operand1 signed / 16-bit operand2 signed = {16-bit remainer signed = sign of dividend, 16-bit quotient signed}
// DIVS: division by 0: trap, 	overflow when quotient > 16-bit signed integer, operands not affected
lpm_divide divs(
	.clock(clock),
	.numer(operand1[31:0]),
	.denom(operand2[15:0]),
	.quotient(divs_quotient),
	.remain(divs_remainder)
);
defparam divs.lpm_widthn = 32;
defparam divs.lpm_widthd = 16;
defparam divs.lpm_nrepresentation = "SIGNED";
defparam divs.lpm_drepresentation = "SIGNED";
defparam divs.lpm_hint = "LPM_REMAINDERPOSITIVE=FALSE";
defparam divs.lpm_pipeline = 30;

// MULU: 16-bit operand1[15:0] unsigned * 16-bit operand2 unsigned = 32-bit result unsigned
lpm_mult mulu(
	.clock(clock),
	.dataa(operand1[15:0]),
	.datab(operand2[15:0]),
	.result(mulu_result)
);
defparam mulu.lpm_widtha = 16;
defparam mulu.lpm_widthb = 16;
defparam mulu.lpm_widthp = 32;
defparam mulu.lpm_representation = "UNSIGNED";
defparam mulu.lpm_pipeline = 18;

// MULS: 16-bit operand1[15:0] signed * 16-bit operand2 signed = 32-bit result signed
lpm_mult muls(
	.clock(clock),
	.dataa(operand1[15:0]),
	.datab(operand2[15:0]),
	.result(muls_result)
);
defparam muls.lpm_widtha = 16;
defparam muls.lpm_widthb = 16;
defparam muls.lpm_widthp = 32;
defparam muls.lpm_representation = "SIGNED";
defparam muls.lpm_pipeline = 18;

endmodule
