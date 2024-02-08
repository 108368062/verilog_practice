test=alu_test.v
source=alu.v
output=alu_wave
open=1
all:
	iverilog -o $(output).vvp $(test) $(source)
	vvp $(output).vvp
wave:
	gtkwave $(output).vcd
clean:
	del *.vcd
	del *.vvp
clean_2:
	rm *.vcd
	rm *.vvp	
help:
	@echo "make all, wave"
	@echo "clean file: make clean(for windows), make clean_2(for linux, ubuntu etc. )"