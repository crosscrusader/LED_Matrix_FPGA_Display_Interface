SRCS:= screen_controller_tb.v ../Rtl/screen_controller.v

dump.vcd: tb
	./tb
tb: $(SRCS)
	iverilog -o $@ $^
