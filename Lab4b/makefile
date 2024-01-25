all:
	iverilog -o SDAM_wave.vvp testbench.v SDAM.v
	vvp SDAM_wave.vvp
all_2:
	iverilog -o SDAM_wave.vvp testbench.v SDAM_2.v
	vvp SDAM_wave.vvp
wave:
	gtkwave SDAM_wave.vcd
clean:
	del *.vcd
	del *.vvp
help:
	@echo "make all, all_2, wave or clean"