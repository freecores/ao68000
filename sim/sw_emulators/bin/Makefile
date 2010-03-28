AO68000_BASE := $(CURDIR)/../../..
export AO68000_BASE

SRC_DIR := $(AO68000_BASE)/bench/sw_emulators
DEST_DIR := $(AO68000_BASE)/sim/sw_emulators/run

help:
	@echo -e "Select software MC68000 emulator to compile. Type 'make' followed by the name of the project."
	@echo
	@echo -e "Available projects:"
	@echo -e "winuae \t- MC68000 emulator from the WinUAE project (www.winuae.net)."
	@echo
	@exit 0

winuae:
	mkdir -p $(DEST_DIR)/winuae
	cp $(SRC_DIR)/winuae/Makefile $(DEST_DIR)/winuae
	$(MAKE) -C $(DEST_DIR)/winuae VPATH=$(SRC_DIR)/winuae

clean:
	rm -f -R $(DEST_DIR)/winuae

