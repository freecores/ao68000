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

/*! \file microcode_params.v
 * \brief Definitions of microcode operations.
 */

`define EA_REG_IDLE				3'd0
`define EA_REG_IR_2_0			3'd1
`define EA_REG_IR_11_9			3'd2
`define EA_REG_MOVEM_REG_2_0	3'd3
`define EA_REG_3b111			3'd4
`define EA_REG_3b100			3'd5

`define EA_MOD_IDLE				4'd0
`define EA_MOD_IR_5_3			4'd1
`define EA_MOD_MOVEM_MOD_5_3	4'd2
`define EA_MOD_IR_8_6			4'd3
`define EA_MOD_PREDEC			4'd4	// predecrement:	-(An)
`define EA_MOD_3b111			4'd5	// extended mod
`define EA_MOD_DN_PREDEC		4'd6	// MOD.DN_PREDEC: Dn 3'b000 (ir[3] == 1'b0), -(An) 3'b100 (ir[3] == 1'b1)
`define EA_MOD_DN_AN_EXG		4'd7	// MOD.DN_AN_EXG: Dn 3'b000 (ir[7:3] == 5'b01000 or 5'b10001), An 3'b001 (ir[7:3] == 5'b01001)
`define EA_MOD_POSTINC			4'd8	// MOD.POSTINC: postincrement (An)+ 3'b011
`define EA_MOD_AN				4'd9	// MOD.AN: An 3'b001, saved result is sign-extended
`define EA_MOD_DN				4'd10	// MOD.DN: Dn 3'b000
`define EA_MOD_INDIRECTOFFSET	4'd11	// MOD.INDIRECTOFFSET: (d16, An) 3'b101

`define EA_TYPE_IDLE					4'd0
`define EA_TYPE_ALL						4'd1		// TYPE.ALL: all
`define EA_TYPE_CONTROL_POSTINC			4'd2		// TYPE.CONTROL_POSTINC: control or postincrement
`define EA_TYPE_CONTROLALTER_PREDEC		4'd3		// TYPE.CONTROLALTER_PREDEC: control alter or predecrement
`define EA_TYPE_CONTROL					4'd4		// TYPE.CONTROL: control
`define EA_TYPE_DATAALTER				4'd5		// TYPE.DATAALTER: data alter
`define EA_TYPE_DN_AN					4'd6		// TYPE.DN_AN: Dn, An
`define EA_TYPE_MEMORYALTER				4'd7		// TYPE.MEMORYALTER: memory alter
`define EA_TYPE_DATA					4'd8		// TYPE.DATA: data

`define OP1_IDLE						4'd0
`define OP1_FROM_OP2					4'd1		// move from operand2
`define OP1_FROM_ADDRESS				4'd2		// move from address
`define OP1_FROM_DATA					4'd3		// move from data, sign extend
`define OP1_FROM_IMMEDIATE				4'd4		// move immediate, sign extend
`define OP1_FROM_RESULT					4'd5		// move from result
`define OP1_MOVEQ						4'd6		// move moveq: { 24{ir[7]}, ir[7:0] }
`define OP1_FROM_PC						4'd7		// move from PC
`define OP1_LOAD_ZEROS					4'd8		// load zeros: 	32'b0
`define OP1_LOAD_ONES					4'd9		// load ones:	32'hFFFFFFFF
`define OP1_FROM_SR						4'd10		// move from SR
`define OP1_FROM_USP					4'd11		// move from USP
`define OP1_FROM_AN						4'd12		// move from An, 32 bits
`define OP1_FROM_DN						4'd13		// move from Dn, sign extend
`define OP1_FROM_IR						4'd14		// move from ir[15:0]
`define OP1_FROM_FAULT_ADDRESS			4'd15		// move from fault_address

`define OP2_IDLE						3'd0
`define OP2_FROM_OP1					3'd1		// move from operand1
`define OP2_LOAD_1						3'd2		// load: 32'b1
`define OP2_LOAD_COUNT					3'd3		// load count
`define OP2_ADDQ_SUBQ					3'd4		// load addq_subq
`define OP2_MOVE_OFFSET					3'd5		// move offset
`define OP2_MOVE_ADDRESS_BUS_INFO		3'd6		// move address_bus_info
`define OP2_DECR_BY_1					3'd7		// decrement by 1

`define ADDRESS_IDLE					4'd0
`define ADDRESS_INCR_BY_SIZE			4'd1		// increment by size
`define ADDRESS_DECR_BY_SIZE			4'd2		// decrement by size
`define ADDRESS_INCR_BY_2				4'd3		// increment by 2
`define ADDRESS_FROM_AN_OUTPUT			4'd4		// move from An output
`define ADDRESS_FROM_BASE_INDEX_OFFSET	4'd5		// move from base+index+offset
`define ADDRESS_FROM_IMM_16				4'd6		// move from {16{ir1[15]}, ir1[15:0]}
`define ADDRESS_FROM_IMM_32				4'd7		// move from {ir1[15:0], ir2[15:0]}
`define ADDRESS_FROM_PC_INDEX_OFFSET	4'd8		// move from pc+index+offset
`define ADDRESS_FROM_TRAP				4'd9		// move trap {22'b0, trap[7:0], 2'b0}

`define SIZE_IDLE						4'd0
`define SIZE_BYTE						4'd1		// load byte: 2'b00
`define SIZE_WORD						4'd2		// load word: 2'b01
`define SIZE_LONG						4'd3		// load long: 2'b10
`define SIZE_1							4'd4		// SIZE.1: word ( ir[7:6] == 2'b00 ), long ( ir[7:6] == 2'b01 )
`define SIZE_1_PLUS						4'd5		// SIZE.1+: word ( ir[7:6] == 2'b10 ), long ( ir[7:6] == 2'b11 )
`define SIZE_2							4'd6		// SIZE.2: word ( ir[6] == 1'b0 ), long ( ir[6] == 1'b1 )
`define SIZE_3							4'd7		// SIZE.3: byte ( ir[7:6] == 2'b00 ), word ( ir[7:6] == 2'b01 ), long ( ir[7:6] == 2'b10 )
`define SIZE_4							4'd8		// SIZE.4: byte ( ir[13:12] == 2'b01 ), word( ir[13:12] == 2'b11 ), long ( ir[13:12] == 2'b10 )
`define SIZE_5							4'd9		// SIZE.5: word ( ir[8] == 1'b0 ), long ( ir[8] == 1'b1 )
`define SIZE_6							4'd10		// SIZE.6: byte ( ir[5:3] != 3'b000 ), long ( ir[5:3] == 3'b000 )

`define MOVEM_MODREG_IDLE				3'd0
`define MOVEM_MODREG_LOAD_0				3'd1		// load 6'b0
`define MOVEM_MODREG_LOAD_6b001111		3'd2		// load 6'b001111
`define MOVEM_MODREG_INCR_BY_1			3'd3		// increment by 1
`define MOVEM_MODREG_DECR_BY_1			3'd4		// decrement by 1

`define MOVEM_LOOP_IDLE					2'd0
`define MOVEM_LOOP_LOAD_0				2'd1		// load 4'b0
`define MOVEM_LOOP_INCR_BY_1			2'd2		// increment by 1

`define MOVEM_REG_IDLE					2'd0
`define MOVEM_REG_FROM_OP1				2'd1		// load from operand1[15:0]
`define MOVEM_REG_SHIFT_RIGHT			2'd2		// shift right

`define IR_IDLE							2'd0
`define IR_LOAD_WHEN_PREFETCH_VALID		2'd1		// load from prefetch_ir[79:64]

`define PC_IDLE							3'd0
`define PC_FROM_RESULT					3'd1		// move from result
`define PC_INCR_BY_2					3'd2		// increment by 2
`define PC_INCR_BY_4					3'd3		// increment by 4
`define PC_INCR_BY_SIZE					3'd4		// increment by size: 2 (size == 2'b00 || size == 2'b01), 4 (size == 2'b10)
`define PC_FROM_PREFETCH_IR				3'd5		// move from prefetch_ir
`define PC_INCR_BY_2_IN_MAIN_LOOP		3'd6		// increment by 2, in main loop, when valid prefetch and valid instruction

`define TRAP_IDLE						4'd0
`define TRAP_ILLEGAL_INSTR				4'd1		// move illegal_instr: 	8'd4
`define TRAP_DIV_BY_ZERO				4'd2		// move divide_by_zero:	8'd5
`define TRAP_CHK						4'd3		// move chk:			8'd6
`define TRAP_TRAPV						4'd4		// move trapv:			8'd7
`define TRAP_PRIVIL_VIOLAT				4'd5		// move priv_viol:		8'd8
`define TRAP_TRACE						4'd6		// move trace:			8'd9
`define TRAP_TRAP						4'd7		// move trap:			{ 3'b0, 1'b1, ir[3:0] }
`define TRAP_FROM_DECODER				4'd8		// move from decoder_trap
`define TRAP_FROM_INTERRUPT				4'd9		// move from interrupt_trap

`define OFFSET_IDLE						2'd0
`define OFFSET_IMM_8					2'd1		// { 24{ir1[7]}, ir1[7:0] }
`define OFFSET_IMM_16					2'd2		// { 16{ir1[15]}, ir1[15:0] }

`define INDEX_IDLE						2'd0
`define INDEX_0							2'd1		// 32'b0
`define INDEX_LOAD_EXTENDED				2'd2		// load from extended instruction word

`define STOP_FLAG_IDLE					2'd0
`define STOP_FLAG_SET					2'd1		// set, continue when: trace,interrupt or reset
`define STOP_FLAG_CLEAR					2'd2		// clear

`define TRACE_FLAG_IDLE					2'd0
`define TRACE_FLAG_COPY_WHEN_NO_STOP	2'd1		// remember trace bit, move from sr[15]

`define GROUP_0_FLAG_IDLE						2'd0
`define GROUP_0_FLAG_SET						2'd1	// set, processing group zero exception
`define GROUP_0_FLAG_CLEAR_WHEN_VALID_PREFETCH	2'd2	// clear

`define INSTRUCTION_FLAG_IDLE					2'd0
`define INSTRUCTION_FLAG_SET					2'd1	// set, processing instruction
`define INSTRUCTION_FLAG_CLEAR_IN_MAIN_LOOP		2'd2	// clear, in main loop, when valid prefetch and valid instruction

`define READ_MODIFY_WRITE_FLAG_IDLE		2'd0
`define READ_MODIFY_WRITE_FLAG_SET		2'd1		// set, execute a RMW cycle
`define READ_MODIFY_WRITE_FLAG_CLEAR	2'd2		// clear

`define DO_RESET_FLAG_IDLE				2'd0
`define DO_RESET_FLAG_SET				2'd1		// set, signal reset
`define DO_RESET_FLAG_CLEAR				2'd2		// clear

`define DO_INTERRUPT_FLAG_IDLE			2'd0
`define DO_INTERRUPT_FLAG_SET_IF_ACTIVE	2'd1		// set if interrupt active
`define DO_INTERRUPT_FLAG_CLEAR			2'd2		// clear

`define DO_READ_FLAG_IDLE				2'd0
`define DO_READ_FLAG_SET				2'd1		// set, perform read operation
`define DO_READ_FLAG_CLEAR				2'd2		// clear

`define DO_WRITE_FLAG_IDLE				2'd0
`define DO_WRITE_FLAG_SET				2'd1		// set, perform write operation
`define DO_WRITE_FLAG_CLEAR				2'd2		// clear

`define DO_BLOCKED_FLAG_IDLE			2'd0
`define DO_BLOCKED_FLAG_SET				2'd1		// set, block processor

`define DATA_WRITE_IDLE					2'd0
`define DATA_WRITE_FROM_RESULT			2'd1		// load data write register from result register

`define AN_ADDRESS_IDLE					2'd0		// load from ea_reg, user or supervisor
`define AN_ADDRESS_FROM_EXTENDED		2'd1		// load from extended instruction word: ir1[14:12], user or supervisor
`define AN_ADDRESS_USP					2'd2		// load USP address
`define AN_ADDRESS_SSP					2'd3		// load SSP address

`define AN_WRITE_ENABLE_IDLE			1'd0
`define AN_WRITE_ENABLE_SET				1'd1		// set write enable on An register

`define AN_INPUT_IDLE					2'd0		// load from result
`define AN_INPUT_FROM_ADDRESS			2'd1		// load from address
`define AN_INPUT_FROM_PREFETCH_IR		2'd2		// load from prefetch_ir, for reset, for SSP

`define DN_ADDRESS_IDLE					1'd0		// load from ea_reg
`define DN_ADDRESS_FROM_EXTENDED		1'd1		// load from extended instruction word: ir1[14:12]

`define DN_WRITE_ENABLE_IDLE			1'd0
`define DN_WRITE_ENABLE_SET				1'd1		// set write enable on Dn register

`define ALU_IDLE											5'd0
`define ALU_SR_SET_INTERRUPT								5'd1
`define ALU_SR_SET_TRAP										5'd2
`define ALU_MOVEP_M2R_1										5'd3
`define ALU_MOVEP_M2R_2										5'd4
`define ALU_MOVEP_M2R_3										5'd5
`define ALU_MOVEP_M2R_4										5'd6
`define ALU_MOVEP_R2M_1										5'd7
`define ALU_MOVEP_R2M_2										5'd8
`define ALU_MOVEP_R2M_3										5'd9
`define ALU_MOVEP_R2M_4										5'd10
`define ALU_SIGN_EXTEND										5'd11
`define ALU_ARITHMETIC_LOGIC								5'd12
`define ALU_ABCD_SBCD_ADDX_SUBX								5'd13
`define ALU_ASL_LSL_ROL_ROXL_ASR_LSR_ROR_ROXR_prepare		5'd14
`define ALU_ASL_LSL_ROL_ROXL_ASR_LSR_ROR_ROXR				5'd15
`define ALU_MOVE											5'd16
`define ALU_ADDA_SUBA_CMPA_ADDQ_SUBQ						5'd17
`define ALU_CHK												5'd18
`define ALU_MULS_MULU_DIVS_DIVU								5'd19
`define ALU_BCHG_BCLR_BSET_BTST								5'd20
`define ALU_TAS												5'd21
`define ALU_NEGX_CLR_NEG_NOT_NBCD_SWAP_EXT					5'd22
`define ALU_SIMPLE_LONG_ADD									5'd23
`define ALU_SIMPLE_LONG_SUB									5'd24
`define ALU_MOVE_TO_CCR_SR_RTE_RTR_STOP_LOGIC_TO_CCR_SR		5'd25
`define ALU_SIMPLE_MOVE										5'd26
`define ALU_LINK_MOVE										5'd27

`define BRANCH_IDLE						4'd0
`define BRANCH_movem_loop				4'd1	// BRANCH(movem_loop == 4'b1000)
`define BRANCH_movem_reg				4'd2	// BRANCH(movem_reg[0] == 0)
`define BRANCH_operand2					4'd3	// BRANCH(operand2[5:0] == 6'b0)
`define BRANCH_special_01				4'd4	// BRANCH(special != 2'b01)
`define BRANCH_special_10				4'd5	// BRANCH(special == 2'b10)
`define BRANCH_condition_0				4'd6	// BRANCH(condition == 1'b0)
`define BRANCH_condition_1				4'd7	// BRANCH(condition == 1'b1)
`define BRANCH_result					4'd8	// BRANCH(result[15:0] == 16'hFFFF)
`define BRANCH_V						4'd9	// BRANCH(V == 1'b0)
`define BRANCH_movep_16					4'd10	// BRANCH(ir[6] == 0)
`define BRANCH_stop_flag_wait_ir_decode	4'd11	// BRANCH(stop_flag == 1'b1) if no branch: wait for prefetch ir valid and decode instruction
`define BRANCH_ir						4'd12	// BRANCH(ir[7:0] != 8'b0)
`define BRANCH_trace_flag_and_interrupt	4'd13	// BRANCH(trace_flag == 1'b0 && interrupt_mask != 3'b000) if no branch: jump to main loop
`define BRANCH_group_0_flag				4'd14	// BRANCH(group_0_flag == 0)
`define BRANCH_procedure				4'd15	// call procedure, return from procedure

`define PROCEDURE_IDLE                  	4'd0
`define PROCEDURE_call_load_ea				4'd1	// load ea
`define PROCEDURE_call_perform_ea_read		4'd2	// perform_ea_read
`define PROCEDURE_call_perform_ea_write		4'd3	// perform_ea_write
`define PROCEDURE_call_save_ea				4'd4	// save ea
`define PROCEDURE_return					4'd5	// return from procedure
`define PROCEDURE_wait_finished				4'd6	// wait for finished signal from bus controler
`define PROCEDURE_wait_prefetch_valid		4'd7	// wait for prefetch ir valid, 64 bits
`define PROCEDURE_wait_prefetch_valid_32	4'd8	// wait for prefetch ir valid, 32 bits
`define PROCEDURE_jump_to_main_loop			4'd9	// jump to main loop
`define PROCEDURE_push_micropc				4'd10	// save current micro_pc
`define PROCEDURE_call_trap					4'd11	// call trap service procedure
`define PROCEDURE_pop_micropc				4'd12	// pop most recent micro_pc and forget
`define PROCEDURE_interrupt_mask			4'd13	// if interrupt active continue, else jump to main loop
`define PROCEDURE_call_read					4'd14	// load_ea + perform_ea_read
`define PROCEDURE_call_write				4'd15	// perform_ea_write + save_ea + return

