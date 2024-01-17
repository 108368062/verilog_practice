all:
	iverilog -o fsm_wave.vvp fsm_test.v fsm_bspd.v
	vvp fsm_wave.vvp
all_2:
	iverilog -o fsm_wave.vvp fsm_test.v fsm_bspd_2.v
	vvp fsm_wave.vvp
all_3:
	iverilog -o fsm_wave.vvp fsm_test.v fsm_bspd_3.v
	vvp fsm_wave.vvp
all_other:
	iverilog -o fsm_wave.vvp fsm_test.v fsm_bspd_other_method.v
	vvp fsm_wave.vvp
wave:
	gtkwave fsm_wave.vcd
clean:
	del *.vcd
	del *.vvp
help:
	@echo "make all, all_2, wave or clean"