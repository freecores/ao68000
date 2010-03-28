AO68000_BASE := $(CURDIR)
export AO68000_BASE

help:
	@echo -e "Select operation to perform. Type 'make' followed by the name of the operation."
	@echo
	@echo -e "Available operations:"
	@echo -e "synthesise \t- synthesise full_system SoC with ao68000 processor."
	@echo -e "compare    \t- run RTL-Software comparison."
	@echo -e "docs       \t- unpack Doxygen documentation."
	@echo -e "clean      \t- clean all."
	@echo -e "commit     \t- commit project to SVN repository."
	@echo
	@exit 0

synthesise:
	$(MAKE) -C $(AO68000_BASE)/syn/altera/bin full_system

docs:
	$(MAKE) -C $(AO68000_BASE)/doc unpack

compare:
	$(MAKE) -C $(AO68000_BASE)/sw/ao68000_tool microcode
	$(MAKE) -C $(AO68000_BASE)/sim/rtl_sim/bin tb_ao68000
	$(MAKE) -C $(AO68000_BASE)/sim/sw_emulators/bin winuae
	$(MAKE) -C $(AO68000_BASE)/sim/rtl_sw_compare/bin tb_ao68000_with_winuae

clean:
	$(MAKE) -C $(AO68000_BASE)/bench/sw_emulators/winuae clean
	$(MAKE) -C $(AO68000_BASE)/bench/verilog/tb_ao68000 clean
	$(MAKE) -C $(AO68000_BASE)/doc clean
	$(MAKE) -C $(AO68000_BASE)/sim/rtl_sim/bin clean
	$(MAKE) -C $(AO68000_BASE)/sim/rtl_sw_compare/bin clean
	$(MAKE) -C $(AO68000_BASE)/sim/sw_emulators/bin clean
	$(MAKE) -C $(AO68000_BASE)/syn/altera/bin clean

commit: clean
	svn commit
