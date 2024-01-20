all:
	iverilog -o SDAM_wave.vvp testbench.v SDAM.v
	vvp SDAM_wave.vvp
wave:
	gtkwave SDAM_wave.vcd
clean:
	del *.vcd
	del *.vvp
help:
	@echo "make all, wave or clean"