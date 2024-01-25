all:
	iverilog -o mem_wave.vvp mem_test.v mem.v
	vvp mem_wave.vvp
wave:
	gtkwave mem_wave.vcd
clean:
	del *.vcd
	del *.vvp
help:
	@echo "make all, wave or clean"