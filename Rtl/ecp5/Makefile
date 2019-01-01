PROJ=top
SRC=$(wildcard *.v)
SRC += $(wildcard ../*.v)

all: build/${PROJ}.svf

build/${PROJ}.json: $(SRC)
	mkdir -p build
	yosys -p 'read_verilog -Decp5 $^; synth_ecp5 -top ${PROJ} -json $@'

build/${PROJ}_out.config: build/${PROJ}.json
	nextpnr-ecp5 -q --json $< --basecfg configs/empty_lfe5um5g-85f.config --textcfg $@ --um5g-85k --package CABGA381 --lpf ${PROJ}.lpf

build/${PROJ}.bit: build/${PROJ}_out.config
	ecppack --svf build/${PROJ}.svf $< $@

build/${PROJ}.svf : build/${PROJ}.bit

prog: build/${PROJ}.svf
	openocd -f configs/ecp5-evn.cfg -c "transport select jtag; init; svf $<; exit" -l build/prog.log

clean:
	rm -f build/*.svf build/*.bit build/*.config build/*.json

.PHONY: prog clean
