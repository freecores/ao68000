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

/* This file contains only Doxygen documentation.
*/
 
/*! \file documentation.v
 * \brief ao68000 Doxygen documentation.
 */
 
/*! \mainpage
 *                                                      <table border=0 width=100%><tr><td>
 * OpenCores ao68000 IP Core.
 * \author Aleksander Osman, <alfik@poczta.fm>
 * \date 28.03.2010
 * \version 1.0
 *                                                      </td><td>
 * \image html ./doc/img/opencores.jpg
 *                                                      </td></tr></table>
 *
 *                                                      <table border=0 width=100%><tr><td>
 * <b>Contents:</b>
 *   - <a href="./../../specification.pdf">Specification</a>, automatically generated from:
 *      - \subpage page_spec_revisions,
 *      - \subpage page_spec_introduction,
 *      - \subpage page_spec_architecture,
 *      - \subpage page_spec_operation,
 *      - \subpage page_spec_registers,
 *      - \subpage page_spec_clocks,
 *      - \subpage page_spec_ports,
 *      - \subpage page_spec_references.
 *   - \subpage page_directory,
 *   - \subpage page_tool,
 *   - \subpage page_verification,
 *   - \subpage page_mc68000,
 *   - \subpage page_old_notes,
 *   - \subpage page_microcode_compilation,
 *   - \subpage page_microcode_operations,
 *   - \subpage page_microcode,
 *   - \subpage page_soc_linux.
 *                                                      </td><td>
 * \image html ./doc/img/wishbone_compatible.png
 *                                                      </td></tr></table>
 *
 * <b>Structure Diagram:</b>
 * \image html structure.png
 */


/*! \page page_spec_introduction Introduction
 * 
 * The OpenCores ao68000 IP Core is a Motorola MC68000 compatible processor. 
 *
 * <h3>Features</h3>
 *  - CISC processor with microcode,
 *  - WISHBONE revision B.3 compatible MASTER interface,
 *  - not cycle exact with the MC68000, some instructions take more cycles to complete, some less,
 *  - Uses about 7500 LE on Altera Cyclone II and about 45000 bits of RAM for microcode,
 *  - Tested against the WinUAE M68000 software emulator. Every 16-bit instruction was tested with random register contents and RAM contents
 *    (\ref page_verification). The result of execution was compared,
 *  - Runs Linux kernel version 2.6.33.1 up to init process lookup (\ref page_soc_linux),
 *  - Contains a simple prefetch which is capable of holding up to 5 16-bit instruction words,
 *  - Document generated by Doxygen (www.doxygen.org) with doxverilog patch (http://developer.berlios.de/projects/doxverilog/). The specification
 *    is automatically extracted from the Doxygen HTML output.
 *
 * <h3>WISHBONE compatibility</h3>
 *  - Version: WISHBONE specification Revision B.3,
 *  - General description: 32-bit WISHBONE Master interface,
 *  - WISHBONE signals described in \ref page_spec_ports,
 *  - Supported cycles: Master Read/Write, Master Block Read/Write, Master Read-Modify-Write for TAS instruction,
 *    Register Feedback Bus Cycles as described in chapter 4 of the WISHBONE specification,
 *  - Use of ERR_I: on memory access – bus error, on interrupt acknowledge: spurious interrupt,
 *  - Use of RTY_I: on memory access – repeat access, on interrupt acknowledge: generate auto-vector,
 *  - WISHBONE data port size: 32-bit,
 *  - Data port granularity: 8-bits,
 *  - Data port maximum operand size: 32-bits,
 *  - Data transfer ordering: BIG ENDIAN,
 *  - Data transfer sequencing: UNDEFINED, 
 *  - Constraints on <tt>CLK_I</tt> signal: described in \ref page_spec_clocks, maximum frequency: about 70 MHz.
 *
 * <h3>Use</h3>
 * The ao68000 can be used as an processor in a System-on-Chip booting Linux kernel up to <tt>init</tt> program lookup (\ref page_soc_linux).
 *
 * <h3>Similar projects</h3>
 * Other free soft-core implementations of M68000 microprocessor include:
 *  - OpenCores TG68 (http://www.opencores.org/project,tg68) - runs Amiga software, used as part of the Minimig Core,
 *  - Suska Atari VHDL WF_68K00_IP Core (http://www.experiment-s.de/en) - runs Atari software,
 *  - OpenCores K68 (http://www.opencores.org/project,k68) - no user and supervisor modes distinction, executes most instructions, but not all.
 *  - OpenCores ae68 (http://www.opencores.org/project,ae68) - no files uploaded as of 27.03.2010.
 *
 * <h3>Limitations</h3>
 *  - microcode not optimized: some instructions take more cycles to execute than the original MC68000,
 *  - TRACE not tested,
 *  - the core is large compared to other implementations.
 *
 * <h3>TODO</h3> 
 *  - optimize the microcode and count the exact cycle count for every instruction,
 *  - test TRACE,
 *  - run WISHBONE verification models,
 *  - more documentation of the ao68000 module: signal description, operation, FSM in <tt>bus_control</tt>,
 *  - describe changes done in WinUAE sources (copy from ao.c),
 *  - describe microcode words and subprocedures,
 *  - document the <tt>full_system</tt> modules,
 *  - prepare scripts for VATS: run_sim -r -> regresion test,
 *  - use memories from OpenCore common.
 *
 * <h3>Status</h3>
 *  - Tested with WinUAE software MC68000 emulator,
 *  - Booted Linux kernel up to <tt>init</tt> process lookup.
 *
 * <h3>Requirements</h3>
 *  - Icarus Verilog simulator (http://www.icarus.com/eda/verilog/) is required to compile the <tt>tb_ao68000</tt> testbench,
 *  - Access to Altera Quartus II instalation directory (directory eda/sim_lib/) is required to compile the <tt>tb_ao68000</tt> testbench,
 *  - GCC (http://gcc.gnu.org) is required to compile the WinUAE MC68000 software emulator,
 *  - Java runtime (http://java.sun.com) is required to run the <tt>ao68000_tool</tt> (\ref page_tool),
 *  - Java SDK (http://java.sun.com) is required to compile the <tt>ao68000_tool</tt> (\ref page_tool),
 *  - Apache Ant (http://ant.apache.org) is required to compile the <tt>ao68000_tool</tt> (\ref page_tool),
 *  - Altera Quartus II synthesis tool (http://www.altera.com) is required to synthesise the <tt>full_system</tt> System-on-Chip
 *    (\ref page_soc_linux).
 *
 * <h3>Glossary</h3>
 *  - <b>ao68000</b> - the ao68000 IP Core processor,
 *  - <b>MC68000</b> - the original Motorola MC68000 processor.
 */

/*! \page page_spec_revisions Revision History
 * <table width=100%>
 * <tr style="background: #CCCCCC; font-weight: bold;">
 *     <td>Rev.     </td><td>Date       </td><td>Author             </td><td>Description        </td></tr>
 * <tr><td>1.0      </td><td>28.03.2010 </td><td>Aleksander Osman   </td><td>First Draft        </td></tr>
 * </table>
 */

/*! \page page_directory Directory structure
 * The ao68000 project consists of the following directories:
 *
 * \verbinclude ./doc/src/directory.txt
 */

/*! \page page_verification Processor verification
 * The ao68000 IP Core is verified with the WinUAE MC68000 software emulator.
 * The verification is based on the idea that given the same contents of:
 *  - every register in the processor,
 *  - all memory locations that are read during execution,
 *
 * the result of execution, that is the contents of:
 *  - every register in the processor,
 *  - all memory locations written during execution,
 *
 * should be the same for the IP Core and the software emulator.
 *
 * <h3>Verification procedure</h3>
 * The verification is performed in the following way:
 *  - the WinUAE MC68000 software emulator is compiled. The sources of the emulator are located at: <tt>./bench/sw_emulators/winuae/</tt>.
 *    The makefile with instructions to compile the emulator are located at: <tt>./sim/sw_emulators/bin/Makefile</tt>.
 *    The compiled binary is located at: <tt>./sim/sw_emulators/run/winuae/ao</tt>.
 *  - the ao68000 testbench is compiled. The sources of the testbench are located at: <tt>./bench/verilog/tb_ao68000/</tt>.
 *    The makefile with instructions to compile the testbench are located at: <tt>./sim/rtl_sim/bin/Makefile</tt>.
 *    The compiled Icarus Verilog script is located at: <tt>./sim/rtl_sim/run/tb_ao68000/tb_ao68000</tt>.
 *  - Both of the above executable programs accept arguments that specify the values of:
 *      - memory locations that are read during execution,
 *      - the contents of every register in the processor.
 *  - The result of executing both of the programs is the contents of:
 *      - memory locations written during execution,
 *      - the contents of every register in the processor after execution.
 *  - The tool <tt>./sw/ao68000_tool/dist/ao68000_tool.jar</tt> (\ref page_tool) is used to run both of the executable programs and
 *    compare the result of execution. The tool is capable of executing multiple concurrent simulations in order to utilize current
 *    multicore processors. The makefile containing instructions to run the tool is located in: <tt>./sim/rtl_sw_compare/bin/Makefile</tt>.
 *
 * <h3>Requirements</h3>
 *  - Icarus Verilog simulator (http://www.icarus.com/eda/verilog/) is required to compile the <tt>tb_ao68000</tt> testbench,
 *  - Access to Altera Quartus II instalation (directory eda/sim_lib/) is required to compile the <tt>tb_ao68000</tt> testbench,
 *  - GCC (http://gcc.gnu.org) is required to compile the WinUAE MC68000 software emulator,
 *  - Java runtime (http://java.sun.com) is required to run the <tt>ao68000_tool</tt> (\ref page_tool).
 */
/*! \page page_tool ao68000_tool documentation
 * 
 * The ao68000_tool is used to:
 * - generate a microcode operations Java file, which contains all available microcode operations (\ref page_microcode_operations):
 *   <tt>./sw/ao68000_tool/src/ao68000_tool/Parser.java</tt>. It is generated from <tt>./rtl/verilog/ao68000/microcode_params.v</tt>,
 * - generate microcode for ao680000 (\ref page_microcode_compilation) with microcode locations. The microcode
 *   is generated and stored into an Altera MIF format file located at:
 *   <tt>./sw/ao68000_tool/microcode.mif</tt>. The microcode locations are
 *   save at:<tt>./rtl/verilog/ao68000/microcode/microcode_locations.v</tt>,
 * - run and compare the results of ao68000 RTL simulation of
 *   ao68000/sim/rtl_sim/run/tb_ao68000/tb_ao68000 with the software MC68000
 *   emulation of ao68000/sim/sw_emulators/winuae/ao (\ref page_verification),
 * - extract the specification contents from Doxygen HTML output, to generate the specification ODT file.
 *
 * The tool is located at: <tt>./sw/ao68000_tool/dist/ao68000_tool.jar</tt>. The makefile containing instructions to compile
 * the tool is available at: <tt>./sw/ao68000_tool/Makefile</tt>. To recompile the tool, ant (http://ant.apache.org) is required.
 */

/*! \page page_mc68000 MC68000 notes
 * \verbinclude ./doc/src/mc68000.txt
 */

/*! \page page_old_notes Old ao68000 notes
 * \verbinclude ./doc/src/old_notes.txt
 */

/*! \page page_microcode_compilation Microcode compilation
 * The ao68000 microcode is represented as an Java program. Execution of this program results in generating the binary
 * microcode. 
 *
 * <h3>Microcode operations</h3>
 * All possible microcode operations are described in microcode_params.v.
 * The locations of:
 *  - each operation in the microcode word,
 *  - every procedure in the microcode
 *
 * are defined in the auto-generated microcode_locations.v file. All the available operation are also represented as Java functions and
 * saved in an auto-generated file, located at <tt>./sw/ao68000_tool/src/ao68000_tool/Parser.java</tt> (\ref page_microcode_operations).
 * These two auto-generated files are generated by the tool <tt>ao68000_tool.jar</tt> (\ref page_tool).
 *
 * <h3>Microcode compilation</h3>
 * The source for the microcode is located at <tt>./sw/ao68000_tool/src/ao68000_tool/Microcode.java</tt> (\ref page_microcode).
 *
 * The compiled microcode, in Altera MIF format, is located at <tt>./rtl/verilog/ao68000/microcode/microcode.mif</tt>.
 *
 * The tool <tt>ao68000_tool.jar</tt> (\ref page_tool) is used to compile the microcode source and transform it into a MIF file.
 * The makefile containing instructions for performing the compilation is located at <tt>./sw/ao68000_tool/Makefile</tt>.
 */


/*! \page page_microcode_operations Microcode operations
 * The listing below represents operations available in the \ref page_microcode. It is taken from:
 * <tt>./sw/ao68000_tool/src/ao68000_tool/Parser.java</tt>. More information about the microcode structure and compilation is available at
 * \ref page_microcode_compilation.
 *
 * \include ./sw/ao68000_tool/src/ao68000_tool/Parser.java
 */

/*! \page page_microcode Microcode
 * The listing below represents the microcode.
 * It is taken from <tt>./sw/ao68000_tool/src/ao68000_tool/Microcode.java</tt>. More information about the microcode structure and
 * compilation is available at \ref page_microcode_compilation.
 *
 * \include ./sw/ao68000_tool/src/ao68000_tool/Microcode.java
 */
 
/*! \page page_spec_architecture Architecture
 *                                                          <table border=0 align=center><tr><td>
 * \image html ./doc/img/architecture.png
 *                                                              <caption>
 * <b>Figure 1:</b> Simplified block diagram of ao68000 top module.
 *                                                              </caption>
 *                                                          </td></tr></table>
 * <h3>ao68000</h3>
 * \copydoc ao68000
 *
 * <h3>bus_control</h3>
 * \copydoc bus_control
 *
 * <h3>registers</h3>
 * \copydoc registers
 *
 * <h3>memory_registers</h3>
 * \copydoc memory_registers
 *
 * <h3>decoder</h3>
 * \copydoc decoder
 *
 * <h3>condition</h3>
 * \copydoc condition
 *
 * <h3>alu</h3>
 * \copydoc alu
 *
 * <h3>microcode_branch</h3>
 * \copydoc microcode_branch
 */

/*! \page page_spec_operation Operation
 * The ao68000 IP Core is designed to operate in a similar way as the original MC68000. The most import differences are:
 *  - the core IO ports are compatible with the WISHBONE specification,
 *  - the execution of instructions in the ao68000 core is not cycle-exact with the original MC68000 and usually takes a few cycles longer.
 *
 * <h3>Setting up the core</h3>
 * The ao68000 IP Core has an WISHBONE MASTER interface. All standard memory access bus cycles conform to the WISHBONE specification.
 * These cycles include:
 *  - instruction fetch,
 *  - data read,
 *  - data write.
 *
 * The cycles are either Single, Block or Read-Modify-Write (for the TAS instruction). When waiting to finish a bus cycle
 * the ao68000 reacts on the following input signals:
 *  - ACK_I: the cycle is completed successfully,
 *  - RTY_I: the cycle is immediately repeated, the processor does not continue its operation before the current bus cycle is finished.
 *    In case of the Read-Modify-Write cycle - only the current bus cycle is repeated: either the read or write.
 *  - ERR_I: the cycle is terminated and a bus error is processed. In case of double bus error the processor enters the blocked state.
 *
 * There is also a special bus cycle: the interrupt acknowledge cycle. This cycle is a reaction on receiving a external interrupt from
 * the ipl_i inputs. The processor only samples the ipl_i lines after processing an instruction, so the interrupt lines have to be asserted
 * for some time before the core reacts. The interrupt acknowledge cycle is performed in the following way:
 *  - ADR_O is set to { 27'b111_1111_1111_1111_1111_1111_1111, 3 bits indicating the interrupt priority level for this cycle },
 *  - SEL_O is set to 4'b1111,
 *  - fc_o is set to 3'b111 to indicate a CPU Cycle as in the original MC68000.
 *
 * The ao68000 reacts on the following signals when waiting to finish a interrupt acknowledge bus cycle:
 *  - ACK_I: the cycle is completed successfully and the interrupt vector is read from DAT_I[7:0],
 *  - RTY_I: the cycle is completed successfully and the processor generates a auto-vector internally,
 *  - ERR_I: the cycle is terminated and the processor starts processing a spurious interrupt exception.
 * 
 * Every bus cycle is supplemented with output tags:
 *  - WISHBONE standard tags: SGL_O, BLK_O, RMW_O, CTI_O, BTE_O,
 *  - ao68000 custom tag: fc_o that operates like the Function Code of the original MC68000.
 * 
 * The ao68000 core has two additional outputs that are used to indicate the state of the processor:
 *  - reset_o is a external device reset signal. It is asserted when processing the RESET instruction. It is asserted for 124 bus cycles.
 *    After that the processor returns to normal instruction processing.
 *  - blocked_o is an output that indicates that the processor is blocked after a double bus error. When this output line is asserted
 *    the processor is blocked and does not process any instructions. The only way to continue processing instructions is to reset
 *    the core.
 *
 * <h3>Resetting the core</h3>
 * The ao68000 core is reset with a standard synchronous WISHBONE RST_I input. One clock cycle with RST_I asserted is enough to reset
 * the core. After deasserting the signal, the core starts its standard startup sequence, which is similar to the one performed
 * by the original MC68000:
 *  - the value of the SSP register is read from address 0,
 *  - the value of the PC is read from address 1.
 * 
 * An identical sequence is performed when powering up the core for the first time.
 *
 * <h3>Processor modes</h3>
 * The ao68000 core has two modes of operation - exactly like the original MC68000:
 *  - Supervisor mode
 *  - User mode.
 *
 * Performing a privileged instruction when running in user mode results in a privilege exception, just like in MC68000.
 *
 * <h3>Processor states</h3>
 * The ao68000 core can be in one of the following states:
 *  - instruction processing, which includes group 2 exception processing,
 *  - group 0 and group 1 exception processing,
 *  - external device reset state when processing the RESET instruction,
 *  - blocked state after a double bus error.
 */

/*! \page page_spec_registers Registers
 * The ao68000 IP Core is a WISHBONE Master and does not contain any registers available for reading or writing from outside of the core.
 */

/*! \page page_spec_clocks Clocks
 * <table width=100%>
 * <caption><b>Table 1:</b> List of clocks.</caption>
 * <tr style="background: #CCCCCC; font-weight: bold;">
 *     <td rowspan=2>Name</td><td rowspan=2>Source</td><td colspan=3>Rates (MHz)</td><td rowspan=2>Remarks</td><td rowspan=2>Description</td></tr>
 * <tr style="background: #CCCCCC; font-weight: bold;">
 *     <td>Max</td><td>Min</td><td>Resolution</td></tr>
 *
 * <tr><td>CLK_I</td><td>Input Port</td><td>70</td><td>-</td><td>-</td><td>-</td><td>System clock.</td></tr>
 * </table>
 */

/*! \page page_spec_ports IO Ports
 * <h3>WISHBONE IO Ports</h3>
 * <table width=100%>
 * <caption><b>Table 1:</b> List of WISHBONE IO ports.</b></caption>
 * <tr style="background: #CCCCCC; font-weight: bold;">
 *     <td>Port     </td><td>Width  </td><td>Direction  </td><td>Description    </td></tr>
 * <tr><td>CLK_I    </td><td>1      </td><td>Input      </td><td>\copydoc CLK_I </td></tr>
 * <tr><td>RST_I    </td><td>1      </td><td>Input      </td><td>\copydoc RST_I </td></tr>
 * <tr><td>CYC_O    </td><td>1      </td><td>Output     </td><td>\copydoc CYC_O </td></tr>
 * <tr><td>ADR_O    </td><td>30     </td><td>Output     </td><td>\copydoc ADR_O </td></tr>
 * <tr><td>DAT_O    </td><td>32     </td><td>Output     </td><td>\copydoc DAT_O </td></tr>
 * <tr><td>DAT_I    </td><td>32     </td><td>Input      </td><td>\copydoc DAT_I </td></tr>
 * <tr><td>SEL_O    </td><td>4      </td><td>Output     </td><td>\copydoc SEL_O </td></tr>
 * <tr><td>STB_O    </td><td>1      </td><td>Output     </td><td>\copydoc STB_O </td></tr>
 * <tr><td>WE_O     </td><td>1      </td><td>Output     </td><td>\copydoc WE_O  </td></tr>
 * <tr><td>ACK_I    </td><td>1      </td><td>Input      </td><td>\copydoc ACK_I </td></tr>
 * <tr><td>ERR_I    </td><td>1      </td><td>Input      </td><td>\copydoc ERR_I </td></tr>
 * <tr><td>RTY_I    </td><td>1      </td><td>Input      </td><td>\copydoc RTY_I </td></tr>
 * <tr><td>SGL_O    </td><td>1      </td><td>Output     </td><td>\copydoc SGL_O </td></tr>
 * <tr><td>BLK_O    </td><td>1      </td><td>Output     </td><td>\copydoc BLK_O </td></tr>
 * <tr><td>RMW_O    </td><td>1      </td><td>Output     </td><td>\copydoc RMW_O </td></tr>
 * <tr><td>CTI_O    </td><td>3      </td><td>Output     </td><td>\copydoc CTI_O </td></tr>
 * <tr><td>BTE_O    </td><td>2      </td><td>Output     </td><td>\copydoc BTE_O </td></tr>
 * <tr><td>fc_o     </td><td>3      </td><td>Output     </td><td>\copydoc fc_o  </td></tr>
 * </table>
 *
 * <h3>Other IO Ports</h3>
 * <table width=100%>
 * <caption><b>Table 2:</b> List of Other IO ports.</caption>
 * <tr style="background: #CCCCCC; font-weight: bold;">
 *     <td>Port     </td><td>Width  </td><td>Direction  </td><td>Description        </td></tr>
 * <tr><td>ipl_i    </td><td>3      </td><td>Input      </td><td>\copydoc ipl_i     </td></tr>
 * <tr><td>reset_o  </td><td>1      </td><td>Output     </td><td>\copydoc reset_o   </td></tr>
 * <tr><td>blocked_o</td><td>1      </td><td>Output     </td><td>\copydoc blocked_o </td></tr>
 * </table>
 */

/*! \addtogroup CLK_I CLK_I Port
 * WISHBONE Clock Input
 */
/*! \addtogroup RST_I RST_I Port
 * WISHBONE Reset Input
 */
/*! \addtogroup CYC_O CYC_O Port
 * WISHBONE Master Cycle Output
 */
/*! \addtogroup ADR_O ADR_O Port
 * WISHBONE Master Address Output
 */
/*! \addtogroup DAT_O DAT_O Port
 * WISHBONE Master Data Output
 */
/*! \addtogroup DAT_I DAT_I Port
 * WISHBONE Master Data Input
 */
/*! \addtogroup SEL_O SEL_O Port
 * WISHBONE Master Byte Select
 */
/*! \addtogroup STB_O STB_O Port
 * WISHBONE Master Strobe Output
 */
/*! \addtogroup WE_O WE_O Port
 * WISHBONE Master Write Enable Output
 */
/*! \addtogroup ACK_I ACK_I Port
 * WISHBONE Master Acknowledge Input:
 *  - on normal cycle: acknowledge,
 *  - on interrupt acknowledge cycle: external vector provided on DAT_I[7:0].
 */
/*! \addtogroup ERR_I ERR_I Port
 * WISHBONE Master Error Input
 *  - on normal cycle: bus error,
 *  - on interrupt acknowledge cycle: spurious interrupt.
 */
/*! \addtogroup RTY_I RTY_I Port
 * WISHBONE Master Retry Input
 *  - on normal cycle: retry bus cycle,
 *  - on interrupt acknowledge: use auto-vector.
 */
/*! \addtogroup SGL_O SGL_O Port
 * WISHBONE Cycle Tag, TAG_TYPE: TGC_O, Single Bus Cycle.
 */
/*! \addtogroup BLK_O BLK_O Port
 * WISHBONE Cycle Tag, TAG_TYPE: TGC_O, Block Bus Cycle.
 */
/*! \addtogroup RMW_O RMW_O Port
 * WISHBONE Cycle Tag, TAG_TYPE: TGC_O, Read-Modify-Write Cycle.
 */
/*! \addtogroup CTI_O CTI_O Port
 * WISHBONE Address Tag, TAG_TYPE: TGA_O, Cycle Type Identifier,
 * Incrementing Bus Cycle or End-of-Burst Cycle.
 */
/*! \addtogroup BTE_O BTE_O Port
 * WISHBONE Address Tag, TAG_TYPE: TGA_O, Burst Type Extension,
 * always Linear Burst.
 */
/*! \addtogroup fc_o fc_o Port
 * Custom TAG_TYPE: TGC_O, Cycle Tag,
 * Processor Function Code:
 *  - 1 - user data,
 *  - 2 - user program,
 *  - 5 - supervisor data : all exception vector entries except reset,
 *  - 6 - supervisor program : exception vector for reset,
 *  - 7 - cpu space: interrupt acknowledge.
 */
/*! \addtogroup ipl_i ipl_i Port
 * Interrupt Priority Level 
 * Interrupt acknowledge cycle: 
 *  - ACK_I: interrupt vector on DAT_I[7:0],
 *  - ERR_I: spurious interrupt,
 *  - RTY_I: auto-vector.
 */
/*! \addtogroup reset_o reset_o Port
 * External device reset. Output high when processing the RESET instruction.
 */
/*! \addtogroup blocked_o blocked_o Port
 * Processor blocked indicator. The processor is blocked after a double bus error.
 */

/*! \page page_spec_references References
 *                                                                      <ol><li>
 * <em>Specification for the: WISHBONE System-on-Chip (SoC) Interconnection Architecture for Portable IP Cores.</em><br/>
 * Revision: B.3.<br/>
 * Released: September 7, 2002.<br/>
 * Available from: http://www.opencores.org. <br/>&nbsp;
 *                                                                      </li><li> 
 * <em>M68000 8-/16-/32-Bit Microprocessors User’s Manual.</em><br/>
 * Ninth Edition.<br/>
 * Freescale Semiconductor, Inc.<br/>
 * Available from: http://www.freescale.com. <br/>&nbsp;
 *                                                                      </li><li>
 * <em>MOTOROLA M68000 FAMILY Programmer’s Reference Manual (Includes CPU32 Instructions).</em><br/>
 * MOTOROLA INC., 1992. M68000PM/AD REV.1.<br/>
 * Available form: http://www.freescale.com. <br/>&nbsp;
 *                                                                      </li><li> 
 * <em>ao68000 Doxygen(Design) Documentation.</em><br/>&nbsp;
 *                                                                      </li></ol>
 */

/*! \page page_soc_linux System-on-Chip example with ao68000 running Linux
 * The ao68000 IP Core is capable of booting the Linux kernel (http://www.kernel.org) up to the <tt>init</tt> program search.
 *
 * <h3>Requirements</h3>
 *  - Linux kernel sources (http://www.kernel.org), tested with version 2.6.33.1,
 *  - a MC68000 toolchain (http://www.gnu.org), tested with binutils-2.20 and gcc-core-4.4.3,
 *  - a development board to run the system, tested with Terasic DE2-70 board (http://www.terasic.com.tw),
 *  - a SDHC card,
 *  - a serial cable to view the output of kernel execution on a serial terminal program.
 *
 * <h3>System-on-Chip</h3>
 * In order to test the ao68000 processor by booting the Linux kernel, a System-on-Chip is prepared and located at:
 * <tt>./rtl/verilog/full_system/</tt>. The system consists of:
 *  - an early boot state machine: early_boot.v,
 *  - a SDHC card controller: sd.v,
 *  - a serial line transmitter: serial_txd.v,
 *  - a SSRAM controller: ssram.v,
 *  - a simple timer: timer.v,
 *  - a top level module, that instantiates the above modules and the ao68000 processor: full_system.v.
 *
 * <h3>Step-by-step instruction to prepare the system</h3>
 *  - download the Linux kernel (linux-2.6.33.1.tar.bz2),
 *  - download the toolchain (binutils-2.20.tar.bz2, gcc-core-4.4.3.tar.bz2),
 *  - configure and make Binutils: <br/>
 *    <code>./configure --prefix=(build prefix) --target=m68knommu-none-linux</code> <br/>
 *    <code>make</code> <br/>
 *    <code>make install</code> <br/>
 *  - configure and make GCC:
 *    <code>./../gcc-4.4.3/configure --prefix=(build prefix) --target=m68knommu-none-linux
 *          --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libiberty --disable-zlib --disable-libgomp</code>
 *          <br/>
 *    <code>make</code> <br/>
 *    <code>make install</code> <br/>
 *  - patch the Linux kernel sources by copying the contents of the directory <tt>./sw/linux/linux-2.6.33.1-ao68000/</tt> into the Linux kernel
 *    sources directory,
 *  - configure and make the Linux kernel: <br/>
 *    <code>make menuconfig ARCH=m68knommu CROSS_COMPILE=(build prefix)/bin/m68knommu-none-linux-</code> <br/>
 *    <code>make ARCH=m68knommu CROSS_COMPILE=(build prefix)/bin/m68knommu-none-linux-</code> <br/>
 *  - convert the Linux kernel binary in ELF format into a flat binary format:
 *    <code>(build prefix)//bin/m68knommu-none-linux-objcopy -O binary vmlinux vmlinux.bin</code> <br/>
 *  - synthesise the <tt>full_system</tt> with the Altera Quartus II tool. The instructions to perform the synthesis are located in the makefile
 *    located at: <tt>./syn/altera/bin/Makefile</tt>,
 *  - prepare a SDHC card with the software:
 *      - copy the first 8 bytes of memory form the file <tt>./sw/linux/sector0.dat</tt>: <br/>
 *        <code>dd if=sector0.dat of=/dev/(SD card device)</code>
 *        This file contains the SSP and PC values read by the ao68000 processor after booting.
 *      - copy the Linux kernel flat binary, at offset 1024: <br/>
 *        <code>dd if=vmlinux.bin of=/dev/(SD card device) bs=1024 seek=1</code> <br/>
 *  - insert the SDHC card into the reader in the Terasic DE2-70 board,
 *  - load the synthesised SOF file into the FPGA
 *  - look at the output of the kernel console by opening a serial terminal application and reading the output of the board.
 * 
 * <h3>Notes</h3>
 *  - the SLOB allocator and not the default SLAB allocator had to be selected because of a problem in the kernel sources
 *    (in_interrupt() check in ./kernel/slab.c:2109 before enabling the interrupts),
 *  - the source file in the Linux kernel: <tt>./init/initramfs.c</tt> compiled with the GCC option <tt>-m68000</tt> contains illegal code
 *    to execute on a MC68000 (copy a long word from an unaligned address). Even after correcting this problem, the kernel did not want to boot
 *    reliably (sometimes it booted and found the init program, sometimes not).
 *
 * <h3>Linux console output</h3>
 * The output of the running kernel is presented below:
 * \verbinclude ./doc/src/linux_booting.txt
 */

