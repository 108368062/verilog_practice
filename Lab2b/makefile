all:
	iverilog -o rca16_wave rca16_test.v rca16.v
	vvp rca16_wave

wave:
	gtkwave rca16_wave.vcd
clean:
	del *.vcd
	del *.vvp