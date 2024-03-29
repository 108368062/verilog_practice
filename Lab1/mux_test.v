`timescale 1ns / 100ps
module mux_test;

// Signal declaration
	reg a, b, sel;

// MUX instance
	mux mux (out, a, b, sel);

// Apply Stimulus

initial
begin
  // ** Add stimulus here **
  	#10 begin a = 0; b = 0; sel = 0;  end
	#10 begin a = 1; b = 0; sel = 1;  end
	#10 begin a = 1; b = 1; sel = 0; end
	#10 begin a = 0; b = 1; sel = 1;end
	#10 begin a = 0; b = 1; sel = 0;end
	#10 begin a = 1; b = 0; sel = 0;end
	#10 begin a = 0; b = 0; sel = 1;end
	#10 begin a = 1; b = 1; sel = 1;end
  	#20 $finish;
  // ** Add stimulus here **
end


// Display Results
 
initial  // print all changes to all signal values
  $monitor($time, "  a = %b,  b = %b,  sel = %b,   out = %b", a,b,sel,out);



//  Waveform Record  
initial
begin
    //$fsdbDumpfile("mux.fsdb"); // The FSDB Database
    //$fsdbDumpvars;

    //$shm_open("lab1.shm");  // The SHM Database
    //$shm_probe("AC");
    
    $dumpfile("lab1.vcd");   // The VCD Database
	//$dumpfile("mux_wave.vcd");   // The VCD Database
    $dumpvars;

end



endmodule
