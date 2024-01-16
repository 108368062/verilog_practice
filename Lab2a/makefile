all:
	iverilog -o fa fa_test.v fa.v ha.v
	vvp fa

wave:
	gtkwave fa.vcd
clean:
	del *.vcd
	del *.vvp