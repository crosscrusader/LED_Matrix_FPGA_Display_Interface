SRC=$(wildcard *.v)
SRC += $(wildcard ../*.v)

all: build/top.rpt build/top.bin

build/top.json: $(SRC)
	mkdir -p build
	yosys -p 'read_verilog -Dice40 $^; synth_ice40 -top top -json $@'

build/top.asc: build/top.json top.pcf
	nextpnr-ice40 --hx8k --json $< --pcf top.pcf --asc $@

#top.asc: temp.asc
	#icebram rom.hex rom.hex < temp.asc > top.asc

build/top.bin: build/top.asc
	icepack $< $@

build/top.rpt: build/top.asc
	icetime -d hx8k -p top.pcf -r $@ -c 100 $<

prog: build/top.bin
	iceprog -S $<

sim: tob_tb.v top.v rom.v bufferTopHalf.v comm.v
	iverilog -o sim $^
	vvp sim
clean: 
	rm build/top.asc build/top.bin build/top.rpt build/top.json
