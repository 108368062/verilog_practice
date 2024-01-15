VERILOG = iverilog
TEMP = lab1.vvp
TARGET = lab1.vcd

all:
	make iver
	make $(TARGET) 
	gtkwave $(TARGET)

all_nowave:
	make iver
	make $(TARGET)

iver: mux_test.v mux.v
	$(VERILOG) -o $(TEMP) mux_test.v mux.v

$(TARGET) : $(TEMP)
	vvp $(TEMP)

clean:
	del *vvp
	del *vcd

wave:
	gtkwave $(TARGET)

help:
	@echo "make all, all_nowave, iver, $(TARGET), clean, wave"