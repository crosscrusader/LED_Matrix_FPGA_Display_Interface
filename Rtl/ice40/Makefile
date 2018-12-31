SRC=$(wildcard *.v)
SRC += $(wildcard ../*.v)

all: ../build_ice40/top.rpt ../build_ice40/top.bin

../build_ice40/top.json: $(SRC)
	mkdir -p ../build_ice40
	yosys -p 'synth_ice40 -top top -json $@' $^

../build_ice40/top.asc: ../build_ice40/top.json top.pcf
	nextpnr-ice40 --hx8k --json $< --pcf top.pcf --asc $@

#top.asc: temp.asc
	#icebram rom.hex rom.hex < temp.asc > top.asc

../build_ice40/top.bin: ../build_ice40/top.asc
	icepack $< $@

../build_ice40/top.rpt: ../build_ice40/top.asc
	icetime -d hx8k -p top.pcf -r $@ -c 100 $<

prog: ../build_ice40/top.bin
	iceprog -S $<

lint: $(SRC)
	verilator --lint-only $^

sim: tob_tb.v top.v rom.v bufferTopHalf.v comm.v
	iverilog -o sim $^
	vvp sim
clean: 
	rm ../build_ice40/top.asc ../build_ice40/top.bin ../build_ice40/top.rpt ../build_ice40/top.json
