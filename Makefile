all: top.rpt top.bin

top.json: top.v rom.v bufferTopHalf.v comm.v
	yosys -p 'synth_ice40 -top top -json $@' $^

top.asc: top.json top.pcf
	nextpnr-ice40 --hx8k --json $< --pcf top.pcf --asc $@

#top.asc: temp.asc
	#icebram rom.hex rom.hex < temp.asc > top.asc

top.bin: top.asc
	icepack $< $@

top.rpt: top.asc
	icetime -d hx8k -p top.pcf -r $@ -c 100 $<

prog: top.bin
	iceprog -S $<
sim: tob_tb.v top.v rom.v bufferTopHalf.v comm.v
	iverilog -o sim $^
	vvp sim
clean: 
	rm top.asc top.bin top.rpt top.json
