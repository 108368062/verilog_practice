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
clean_2:
	rm $(TEMP)
	rm $(TARGET)	

wave:
	gtkwave $(TARGET)

help:
	@echo "make all, all_nowave, iver, $(TARGET), clean, clean_2(for ubuntu), wave"
	@echo "make detect is on development please not use!
detect:
	@echo "$(OS)"
	@echo "$(uname)"