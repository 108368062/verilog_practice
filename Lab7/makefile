all:
	iverilog -o lbp_wave.vvp testfixture.v LBP.v
	vvp lbp_wave.vvp
wave:
	gtkwave LBP_wave.vcd
clean:
	del *.vcd
	del *.vvp
help:
	@echo "make all, wave or clean"