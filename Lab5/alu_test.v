/*********************************************************************
 * Stimulus for the ALU design - Verilog Training Course
 *********************************************************************/
`timescale 1ns / 1ns
module alu_test;

reg [7:0] data, accum;
reg clk, reset;
reg [2:0] opcode;
wire zero;
wire [7:0] alu_out;

alu test_u1 (.clk(clk), .reset(reset), .data(data), .accum(accum), .opcode(opcode),
    .zero(zero), .alu_out(alu_out));
//clk
always #10 clk = ~clk;

//simulation process
initial
begin
    #30
    clk = 0;
    reset = 0;
    #40
    reset = 1;
    $display("start simulation!!!");
    #3000 $finish;
    $display("simulation finish!!!");
end
//dump waveform
initial 
begin
    //$fsdbDumpfile("fsm_wave.fsdb");
    //$fsdbDumpvars();
    $dumpfile("alu_wave.vcd");
    $dumpvars;
end

endmodule
