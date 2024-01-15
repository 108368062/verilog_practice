VERILOG = iverilog
TEMP = adder.vvp
TARGET = adder.vcd

all:
	make iver
	make $(TARGET)
	gtkwave $(TARGET)

all_nowave:
	make iver
	make $(TARGET)

iver: test.v adder.v
	$(VERILOG) -o $(TEMP) test.v adder.v

$(TARGET) : $(TEMP)
	vvp $(TEMP)

clean:
	del $(TEMP)
	del $(TARGET)

wave:
	gtkwave $(TARGET)

help:
	@echo "make all, all_nowave, iver, $(TARGET), clean, wave"