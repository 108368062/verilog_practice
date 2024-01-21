`timescale 1ns/10ps
`define CYCLE      10.0          	  // Modify your clock period here
`define End_CYCLE  100000000              // Modify cycle times once your design need more cycle times!

`define RB1_STI        "./memdata.dat"     

 

module testfixture;


reg	[7:0] 	RB1	[0:31];
reg	[7:0] 	RB2	[0:31];
reg	[7:0]	RB2_EXP	[0:31];

integer 	p;
integer 	err_cnt;

reg	clk, rst;
wire	[4:0]	RB1_A, RB2_A;
wire		RB1_rd, RB2_wr;
reg	[7:0]	RB1_D;
wire	[7:0]	RB2_D;

membus u_membus(
			.clk(clk),
			.rst(rst),
			.RB1_A(RB1_A),
			.RB1_rd(RB1_rd),
			.RB1_D(RB1_D),
			.RB2_A(RB2_A),
			.RB2_wr(RB2_wr),
			.RB2_D(RB2_D),
			.done(done)
			);
			


always begin #(`CYCLE/2) clk = ~clk; end


initial begin  // global control
	err_cnt = 0;
	clk = 0;
	$display("-----------------------------------------------------\n");
 	$display("START!!! Simulation Start .....\n");
 	$display("-----------------------------------------------------\n");
	@(negedge clk); #1; rst = 1'b1;  
   	#(`CYCLE*3);  #1;   rst = 1'b0;  
   	wait(done == 1); #1; 
	for (p = 0; p <= 31; p = p + 1) begin
		if(RB2[p] !== RB2_EXP[p]) begin
			err_cnt = err_cnt + 1;
			$display("RB2 Address %d is fail, expected data is %h, but the real data is %h", p, RB2_EXP[p], RB2[p]);
		end
	end
	if (err_cnt == 0) $display(" \n Simulation PASS !!! \n");
	else $display(" \n Simulation FAIL !!! \n");
	$finish;
end

initial begin // initial pattern and expected result
	wait(rst==1);
	wait (done ==0 ) begin
		$readmemh(`RB1_STI, RB1);
		$readmemh(`RB1_STI, RB2_EXP);
	end
		
end

always@(posedge clk) begin
	if(rst == 0) begin
	if (RB1_rd == 1) begin
			RB1_D <= RB1[RB1_A] ;
	end
	end
end

always@(posedge clk) begin 
	if(rst == 0) begin
	if (RB2_wr == 1) begin
			 RB2[RB2_A] <= RB2_D; 
	end
	end
end


initial begin
$fsdbDumpfile("membus.fsdb");
$fsdbDumpvars;
$fsdbDumpMDA;
end




   
endmodule


