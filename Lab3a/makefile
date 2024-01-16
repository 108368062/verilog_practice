all:
	iverilog -o alu_wave alu_test.v alu.v
	vvp alu_wave

wave:
	gtkwave alu_wave.vcd
clean:
	del *.vcd
	del *.vvp