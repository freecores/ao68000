ifndef AO68000_BASE
AO68000_BASE := $(CURDIR)/../..
endif

AO68000_RTL := $(AO68000_BASE)/rtl/verilog/ao68000

help:
	@echo -e "Select operation to perform. Type 'make' followed by the name of the operation."
	@echo
	@echo -e "Available operations:"
	@echo -e "microcode    \t- compile microcode for the ao68000."
	@echo -e "compile_tool \t- compile the ao68000_tool. Ant tool required."
	@echo
	@exit 0

./dist/ao68000_tool.jar:
	ant jar

microcode: ./dist/ao68000_tool.jar
	java -jar ./dist/ao68000_tool.jar parser $(AO68000_RTL)/microcode_params.v ./src/ao68000_tool/Parser.java
	java -jar ./dist/ao68000_tool.jar microcode $(AO68000_RTL)/microcode_params.v $(AO68000_RTL)/microcode/microcode.mif $(AO68000_RTL)/microcode/microcode_locations.v
