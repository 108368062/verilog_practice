all:
	iverilog -o fsm_wave fsm_test.v fsm_bspd.v
	vvp fsm_wave
all_2:
	iverilog -o fsm_wave fsm_test.v fsm_bspd_2.v
	vvp fsm_wave
wave:
	gtkwave fsm_wave.vcd
clean:
	del *.vcd
	del *.vvp
help:
	@echo "make all, all_2, wave or clean"