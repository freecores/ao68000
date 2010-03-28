AO68000_BASE := $(CURDIR)/../../..
export AO68000_BASE

DEST_DIR := $(AO68000_BASE)/sim/rtl_sw_compare/run

START_IR_DEC := 0
END_IR_DEC := 65536
TERM_PROGRAM := xterm
COUNT := 2
COUNT_LIST := $(wordlist 1,$(COUNT),0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19)

STEP = `expr \( $(END_IR_DEC) - $(START_IR_DEC) \) / $(COUNT)`

help:
	@echo -e "Select RTL-SW comparison profile. Type 'make' followed by the name of the profile."
	@echo
	@echo -e "Available profiles:"
	@echo -e "tb_ao68000_with_winuae \t- compare tb_ao68000 RTL project with winuae software project."
	@echo
	@exit 0

tb_ao68000_with_winuae:
	$(foreach i,$(COUNT_LIST), mkdir -p $(DEST_DIR)/tb_ao68000_$(i); )
	$(foreach i,$(COUNT_LIST), mkdir -p $(DEST_DIR)/tb_ao68000_$(i)/microcode; )
	$(foreach i,$(COUNT_LIST), mkdir -p $(DEST_DIR)/tb_ao68000_$(i)/bin; )
	$(foreach i,$(COUNT_LIST), mkdir -p $(DEST_DIR)/tb_ao68000_$(i)/vcd; )
	$(foreach i,$(COUNT_LIST), cp $(AO68000_BASE)/rtl/verilog/ao68000/microcode/microcode.mif $(DEST_DIR)/tb_ao68000_$(i)/microcode; )
	$(foreach i,$(COUNT_LIST), echo -e "#!/bin/bash\n$(AO68000_BASE)/sim/rtl_sim/run/tb_ao68000/tb_ao68000 \$$@" \
		> $(DEST_DIR)/tb_ao68000_$(i)/bin/run.sh; \
	)
	$(foreach i,$(COUNT_LIST), chmod +x $(DEST_DIR)/tb_ao68000_$(i)/bin/run.sh; )
	$(foreach i,$(COUNT_LIST), $(TERM_PROGRAM) -e java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar test \
		$(AO68000_BASE)/sim/sw_emulators/run/winuae/ao \
		$(DEST_DIR)/tb_ao68000_$(i)/bin/run.sh \
		`expr $(i) \* \( \( $(END_IR_DEC) - $(START_IR_DEC) \) / $(COUNT) \)` \
		`expr \( $(i) + 1 \) \* \( \( $(END_IR_DEC) - $(START_IR_DEC) \) / $(COUNT) \)` \
		& \
	)

clean:
	rm -f -R $(DEST_DIR)/tb_ao68000_*

