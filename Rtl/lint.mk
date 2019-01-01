SRC=$(wildcard *.v)
SRC=$(wildcard */*.v)

lint: $(SRC)
	verilator --lint-only $^
