//note: this code is on development, please be carefull to use

module SDAM( reset_n, scl, sda, avalid, aout, dvalid, dout);
input       reset_n;
input       scl;  
input       sda;

output	avalid, dvalid;
output	[7:0]	aout;
output	[15:0]	dout;



// ===== Coding your RTL below here ================================= 

reg     	avalid, dvalid;
reg	[7:0]	aout;
reg	[15:0]	dout;

parameter IDLE      = 3'd0;
parameter STR       = 3'd1;//start mode
parameter WR_ADDR   = 3'd2;//write address mode
parameter WR_DAT   = 3'd3;//write data mode
parameter RD        = 3'd4;//read (not use)
parameter OUT       = 3'd5;//output result

reg [3:0] addr_cnt;//counter
reg [3:0] data_cnt;//counter
reg [2:0] c_t,n_t;

always@(posedge scl)
begin
	if(~reset_n)
		c_t <= IDLE;
	else
		c_t <= n_t;
end

always@(*)
begin
	case(c_t)
	IDLE:    n_t = (sda)? IDLE:STR;
	STR:     n_t = (sda)? WR_ADDR:RD;//1:write, 0:read
	WR_ADDR: n_t = (addr_cnt == 4'd8)? STR:WR_ADDR; 
	default:
		n_t = IDLE;
	endcase
end

always@(*)
begin
	case(c_t)
	IDLE: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'h0;
		dout = 16'h00;
		addr_cnt = 4'd0;
		data_cnt = 4'd0;
	end
	WR_ADDR: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'h0;
		dout = 16'h00;
		addr_cnt = addr_cnt +4'd1;
		data_cnt = 4'd0;
	end
	default:
	begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'h0;
		dout = 16'h00;
		addr_cnt = 4'd0;
		data_cnt = 4'd0;
	end
	endcase
end		


endmodule
