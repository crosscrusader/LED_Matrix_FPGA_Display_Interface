PROJ=blinky

all: ${PROJ}.bit

%.json: %.v
	yosys -q -p "synth_ecp5 -nomux -json $@" $<

%_out.config: %.json
	nextpnr-ecp5 -q --json $< --basecfg configs/empty_lfe5um5g-85f.config --textcfg $@ --um5g-85k --package CABGA381 --lpf ecp5evn.lpf

%.bit: %_out.config
	ecppack --svf ${PROJ}.svf $< $@

${PROJ}.svf : ${PROJ}.bit

prog: ${PROJ}.svf
	openocd -f configs/ecp5-evn.cfg -c "transport select jtag; init; svf $<; exit" -l prog.log

clean:
	rm -f *.svf *.bit *.config *.json

.PHONY: prog clean
