module membus(clk, rst, RB1_A, RB1_rd, RB1_D, RB2_A, RB2_wr, RB2_D, done);
input		clk, rst;
output	[4:0]	RB1_A;
output		RB1_rd;
input	[7:0]	RB1_D;
output	[4:0]	RB2_A;
output		RB2_wr;
output	[7:0]	RB2_D;
output		done;







endmodule
