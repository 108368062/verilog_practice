module FIR_mem (Dout, Din, clk, reset, mem_copy1, mem_copy2, mem_copy3, mem_copy4, mem_copy5, mem_copy6, mem_copy7, mem_copy8);

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

reg [3:0] mem [7:0];

//for vcd check value
output reg [7:0] mem_copy1;
output reg [7:0] mem_copy2;
output reg [7:0] mem_copy3;
output reg [7:0] mem_copy4;
output reg [7:0] mem_copy5;
output reg [7:0] mem_copy6;
output reg [7:0] mem_copy7;
output reg [7:0] mem_copy8;

always@(posedge clk)
begin
    if(reset)
    begin
        mem[0] <= 8'd0;
        mem[1] <= 8'd0;
        mem[2] <= 8'd0;
        mem[3] <= 8'd0;
        mem[4] <= 8'd0;
        mem[5] <= 8'd0;
        mem[6] <= 8'd0;
        mem[7] <= 8'd0;
    end
    else
    begin
        mem[0] <= Din;
        mem[1] <= mem[0];
        mem[2] <= mem[1];
        mem[3] <= mem[2];
        mem[4] <= mem[3];
        mem[5] <= mem[4];
        mem[6] <= mem[5];
        mem[7] <= mem[6];
    end
end

assign Dout = Din*b0 + mem[0]*b1 + mem[1]*b2 + mem[2]*b3 + mem[3]*b4
 + mem[4]*b5 + mem[5]*b6 + mem[6]*b7 + mem[7]*b8;// no need to synchronous with clk


always@(*)
begin
    mem_copy1 = mem[0];
    mem_copy2 = mem[1];
    mem_copy3 = mem[2];
    mem_copy4 = mem[3];
    mem_copy5 = mem[4];
    mem_copy6 = mem[5];
    mem_copy7 = mem[6];
    mem_copy8 = mem[7];
end

endmodule
