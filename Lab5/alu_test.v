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
//golden signal or test signal
wire [7:0] opcode_0_golden;
wire [7:0] opcode_1_golden;
wire [7:0] opcode_2_golden;
wire [7:0] opcode_3_golden;
wire [7:0] opcode_4_golden;
wire [7:0] opcode_5_golden;
wire [7:0] opcode_6_golden;
wire [7:0] opcode_7_golden;
wire zero_golden;
integer err_cnt;//error cnt
integer pass_cnt;//pass cnt
integer i;
assign zero_golden = (alu_out === 8'd0) ? 1:0;
assign opcode_0_golden = accum;

alu test_u1 (.clk(clk), .reset(reset), .data(data), .accum(accum), .opcode(opcode),
    .zero(zero), .alu_out(alu_out));
//clk
always #10 clk = ~clk;

//simulation process
initial
begin
    $display("start simulation!!!");
    #30
    clk = 0;
    reset = 1;
    err_cnt = 0;
    pass_cnt = 0;
    i=0;
    #40
    reset = 0;
    //----------opcode 3'b000 check--------------
    opcode = 3'b000;
    for (i = 0; i < 10;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_0_golden & zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_0_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //-----------------------------
    $display("simulation finish!!!");
    if (err_cnt > 0)
        $display("funcion fail, please check!");
    else
        $display("funcion pass, congratulations!");
    $display("Total error:%d", err_cnt);
    $display("Total pass:%d", pass_cnt);
    $display("pass rate(percentage):%d", pass_cnt/(pass_cnt+err_cnt)*100);
    #3000 $finish;
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
