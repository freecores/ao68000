ifndef BROWSER
BROWSER := firefox
endif

ifndef AO68000_BASE
AO68000_BASE := $(CURDIR)/..
endif

help:
	@echo -e "Select operation to perform. Type 'make' followed by the name of the operation."
	@echo
	@echo -e "Available operations:"
	@echo -e "unpack       \t- unpack generated doxygen HTML documentation."
	@echo -e "doxygen      \t- run the doxygen tool on the ao68000 project."
	@echo -e "             \t- Doxverilog version required."
	@echo -e "view         \t- open generated doxygen HTML documentation in a browser."
	@echo -e "spec_extract \t- generate the specification.odt file from the HTML docs."
	@echo
	@exit 0

unpack:
	tar -x -z -f doxygen_generated.tar.gz

doxygen: doxygen.cfg ./doxygen
ifndef DOXVERILOG
	@echo "DOXVERILOG environment variable not set. Set it to a Doxverilog executable."
	@exit 1
endif
	$(DOXVERILOG) doxygen.cfg

view: doxygen
	$(BROWSER) ./doxygen/html/index.html &

spec_extract: ./doxygen
	mkdir -p ./out/spec_extract
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_references.html $(AO68000_BASE)/doc/out/spec_extract/references.html
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_ports.html $(AO68000_BASE)/doc/out/spec_extract/ports.html
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_clocks.html $(AO68000_BASE)/doc/out/spec_extract/clocks.html
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_registers.html $(AO68000_BASE)/doc/out/spec_extract/registers.html
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_operation.html $(AO68000_BASE)/doc/out/spec_extract/operation.html
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_architecture.html $(AO68000_BASE)/doc/out/spec_extract/architecture.html
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_introduction.html $(AO68000_BASE)/doc/out/spec_extract/introduction.html
	java -jar $(AO68000_BASE)/sw/ao68000_tool/dist/ao68000_tool.jar spec_extract $(AO68000_BASE)/doc/doxygen/html/page_spec_revisions.html $(AO68000_BASE)/doc/out/spec_extract/revisions.html
	
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/src/specification_template.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<REFERENCES>,file://$(AO68000_BASE)/doc/out/spec_extract/references.html,True)"
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<PORTS>,file://$(AO68000_BASE)/doc/out/spec_extract/ports.html,True)"
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<CLOCKS>,file://$(AO68000_BASE)/doc/out/spec_extract/clocks.html,True)"
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<REGISTERS>,file://$(AO68000_BASE)/doc/out/spec_extract/registers.html,True)"
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<OPERATION>,file://$(AO68000_BASE)/doc/out/spec_extract/operation.html,True)"
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<ARCHITECTURE>,file://$(AO68000_BASE)/doc/out/spec_extract/architecture.html,True)"
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<INTRODUCTION>,file://$(AO68000_BASE)/doc/out/spec_extract/introduction.html,True)"
	soffice "macro:///Standard.Module1.Main(file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,file://$(AO68000_BASE)/doc/out/spec_extract/specification.odt,<REVISIONS>,file://$(AO68000_BASE)/doc/out/spec_extract/revisions.html,False)"

clean:
	rm -R -f ./doxygen
	rm -R -f ./out/spec_extract

