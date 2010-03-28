help:
	@echo -e "Select project to synthesise. Type 'make' followed by the name of the project."
	@echo
	@echo -e "Available projects:"
	@echo -e "full_system \t- system for Terasic DE2-70 board, consists of:"
	@echo -e "\t\t  ao68000 processor core,"
	@echo -e "\t\t  SSRAM controller,"
	@echo -e "\t\t  SDHC controller,"
	@echo -e "\t\t  serial output,"
	@echo -e "\t\t  boot controller."
	@echo
	@exit 0

full_system:
	mkdir -p ./../out/full_system
	cp ./../run/full_system/* ./../out/full_system/
	cp ./../../../rtl/verilog/full_system/* ./../out/full_system/
	cp -R ./../../../rtl/verilog/ao68000/* ./../out/full_system/
	cd ./../out/full_system && quartus_sh --flow compile full_system

clean:
	rm -f -R ./../out/full_system
