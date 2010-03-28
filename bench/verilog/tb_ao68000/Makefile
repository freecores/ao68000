ifndef AO68000_BASE
AO68000_BASE := $(CURDIR)/../../..
endif

all: tb_ao68000.v
ifndef QUARTUS_ROOTDIR
	@echo "Environment variable QUARTUS_ROOTDIR not set. Please set it to point to Altera Quartus II rootdir."
	@exit 1
endif
	ln -s -f $(QUARTUS_ROOTDIR)/eda/sim_lib/altera_mf.v altsyncram.v
	ln -s -f $(QUARTUS_ROOTDIR)/eda/sim_lib/220model.v lpm_mult.v
	ln -s -f $(QUARTUS_ROOTDIR)/eda/sim_lib/220model.v lpm_divide.v
	iverilog -y. -y$(AO68000_BASE)/rtl/verilog/ao68000 -y$(AO68000_BASE)/rtl/verilog/ao68000/altera_specific -I$(AO68000_BASE)/rtl/verilog/ao68000 -o tb_ao68000 $<

clean:
	rm -f tb_ao68000
	rm -f altsyncram.v
	rm -f lpm_mult.v
	rm -f lpm_divide.v

