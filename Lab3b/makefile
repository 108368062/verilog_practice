all:
	iverilog -o FIR_wave.vvp FIR_test.v FIR.v
	vvp FIR_wave.vvp

all_mem:
	iverilog -o FIR_wave.vvp FIR_test_mem.v FIR_mem.v
	vvp FIR_wave.vvp

wave:
	gtkwave FIR_wave.vcd
clean:
	del *.vcd
	del *.vvp