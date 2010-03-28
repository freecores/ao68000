AO68000_BASE := $(CURDIR)/../../..
export AO68000_BASE

SRC_DIR := $(AO68000_BASE)/bench/verilog
DEST_DIR := $(AO68000_BASE)/sim/rtl_sim/run

help:
	@echo -e "Select RTL simulation to compile. Type 'make' followed by the name of the project."
	@echo
	@echo -e "Available projects:"
	@echo -e "tb_ao68000 \t- testbench for ao68000."
	@echo
	@exit 0

tb_ao68000:
	mkdir -p $(DEST_DIR)/tb_ao68000
	cp $(SRC_DIR)/tb_ao68000/Makefile $(DEST_DIR)/tb_ao68000
	$(MAKE) -C $(DEST_DIR)/tb_ao68000 VPATH=$(SRC_DIR)/tb_ao68000

clean:
	rm -f -R $(DEST_DIR)/tb_ao68000
