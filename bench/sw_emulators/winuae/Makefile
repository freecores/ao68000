all: ao.o cpustbl.o cpuemu_11.o table68k.o readcpu.o
	gcc -o ao ao.o cpustbl.o cpuemu_11.o table68k.o readcpu.o

cpustbl.c: gencpu
	./gencpu

cpuemu_11.c: gencpu

gencpu: gencpu.o readcpu.o table68k.o
	gcc -o gencpu gencpu.o readcpu.o table68k.o

table68k.c: table68k build68k
	./build68k < $< > table68k.c

build68k: build68k.o
	gcc -o build68k build68k.o

%.o: %.c
	gcc -DCPUEMU_68000_ONLY -DCPUEMU_11 -I$(VPATH) -c $<

clean:
	rm -f *.o
	rm -f ao
	rm -f gencpu
	rm -f build68k
	rm -f cpuemu_*.c
	rm -f table68k.c
	rm -f cputbl.h
	rm -f cpustbl.c
