module FIR(Dout, Din, clk, reset);

parameter b0=7;
parameter b1=17;
parameter b2=32;
parameter b3=46;
parameter b4=52;
parameter b5=46;
parameter b6=32;
parameter b7=17;
parameter b8=7;

output	[17:0]	Dout;
input 	[7:0] 	Din;
input 		clk, reset;

reg [7:0] s1_reg;
reg [7:0] s2_reg;
reg [7:0] s3_reg;
reg [7:0] s4_reg;
reg [7:0] s5_reg;
reg [7:0] s6_reg;
reg [7:0] s7_reg;
reg [7:0] s8_reg;

always@(posedge clk)
begin
    if(reset)
    begin
        s1_reg <= 8'd0;
        s2_reg <= 8'd0;
        s3_reg <= 8'd0;
        s4_reg <= 8'd0;
        s5_reg <= 8'd0;
        s6_reg <= 8'd0;
        s7_reg <= 8'd0;
        s8_reg <= 8'd0;
    end
    else
    begin
        s1_reg <= Din;
        s2_reg <= s1_reg;
        s3_reg <= s2_reg;
        s4_reg <= s3_reg;
        s5_reg <= s4_reg;
        s6_reg <= s5_reg;
        s7_reg <= s6_reg;
        s8_reg <= s7_reg;
    end
end

assign Dout = Din*b0 + s1_reg*b1 + s2_reg*b2 + s3_reg*b3 + s4_reg*b4
 + s5_reg*b5 + s6_reg*b6 + s7_reg*b7 + s8_reg*b8;// no need to synchronous with clk


endmodule
