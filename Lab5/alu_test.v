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

parameter total_run=3;//check all function times
parameter func_run=10;//check one opcode how may times
parameter zero_run=3;//check zero output how may times

//golden signal or test signal
wire [7:0] opcode_0_golden;
wire [7:0] opcode_1_golden;
wire [7:0] opcode_2_golden;
wire [7:0] opcode_3_golden;
wire [7:0] opcode_4_golden;
wire [7:0] opcode_5_golden;
wire [7:0] opcode_6_golden;
wire [7:0] opcode_7_golden;
wire [7:0] opcode_other_golden;
wire zero_golden;
integer err_cnt;//error cnt
integer pass_cnt;//pass cnt
integer i;
integer j;
integer ze;//zero check only
//-------golden answer------
assign zero_golden = (accum === 8'd0) ? 1:0;
assign opcode_0_golden = accum;
assign opcode_1_golden = accum + data;
assign opcode_2_golden = accum - data;
assign opcode_3_golden = accum & data;
assign opcode_4_golden = accum ^ data;
assign opcode_5_golden = ~accum + 8'd1 ;
assign opcode_6_golden = accum*5 + accum/8;
assign opcode_7_golden = (accum>=8'd32)?data:~data;
assign opcode_other_golden = 8'd0;
//------------------------------

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
    for (j=0;j<total_run;j=j+1)begin
    //----------opcode 3'b000 check--------------
    opcode = 3'b000;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_0_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_0_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'b001 check--------------
    opcode = 3'b001;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_1_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_1_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'b010 check--------------
    opcode = 3'b010;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_2_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_2_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'b011 check--------------
    opcode = 3'b011;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_3_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_3_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'b100 check--------------
    opcode = 3'b100;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_4_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_4_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'b101 check--------------
    opcode = 3'b101;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_5_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_5_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'b110 check--------------
    opcode = 3'b110;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_6_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_6_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'b111 check--------------
    opcode = 3'b111;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_7_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_7_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'bxxx check--------------
    opcode = 3'bxxx;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_other_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_other_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'bxzx check--------------
    opcode = 3'bxzx;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_other_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_other_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------opcode 3'bxzx check--------------
    opcode = 3'bzzz;
    for (i = 0; i < func_run;i = i + 1)
    begin
        @(negedge clk)begin 
        accum = $random%256; data = $random%256;
        end
        @(posedge clk)begin
        #1
        if (alu_out !== opcode_other_golden | zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: alu_out=%b, zero=%d", opcode_other_golden, zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
        end
    end
    //----------zero check only--------------
    
    for (ze = 0; ze < 8*zero_run;ze = ze + 1)
    begin
    @(negedge clk)begin
        opcode = ze;
        accum = 0; data = $random%256;
    end
    @(posedge clk)begin
    #1
        if (zero_golden !== zero) begin
            err_cnt = err_cnt + 1;
            $display("zero check function!");
            $display("err_cnt:%d",err_cnt);
            $display("error at opcode=%b,accum=%b, data=%b", opcode, accum, data);
            $display("expected output: zero=%d", zero_golden);
        end
        else pass_cnt = pass_cnt + 1;
    end
    end
    //-----------------------------
    end
    //for end
    $display("simulation finish!!!");
    if (err_cnt > 0)
        $display("funcion fail, please check!");
    else
        $display("funcion pass, congratulations!");
    $display("Total error:%d", err_cnt);
    $display("Total pass:%d", pass_cnt);
    $display("pass rate(percentage):%d", (pass_cnt*100/(pass_cnt+err_cnt)));
    #200 $finish;
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
