
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
parameter RD        = 3'd4;//read (not use state)
parameter OUT       = 3'd5;//output result

reg [3:0]  addr_cnt;//address counter
reg [4:0]  data_cnt;//data counter
reg [2:0]  c_t, n_t;
reg [7:0]  address;
reg [15:0] data;
//CS
always@(posedge scl)
begin
	if(~reset_n)
		c_t <= IDLE;
	else
		c_t <= n_t;
end
//NS
always@(*)
begin
	case(c_t)
	IDLE   : n_t = (sda)? IDLE:STR;
	STR    : n_t = (sda)? WR_ADDR:RD;//1:write, 0:read(not use state)
	WR_ADDR: n_t = (addr_cnt == 4'd7)? WR_DAT:WR_ADDR; //get 8bit address from sda
	WR_DAT : n_t = (data_cnt == 5'd15)? OUT:WR_DAT; //get 16bit data from sda
	OUT    : n_t = IDLE;
	default:
		n_t = IDLE;
	endcase
end
//OL
always@(*)
begin
	case(c_t)
	WR_ADDR: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'd0;
		dout = 16'd0;
		address[addr_cnt] = sda;
	end
	WR_DAT: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'd0;
		dout = 16'd0;
		data[data_cnt] = sda;
	end
	OUT: begin
		avalid = 1'b1;
		dvalid = 1'b1;
		aout = address;
		dout = data;
	end
	default:
	begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'd0;
		dout = 16'd0;
		address = 8'd0;
		data = 16'd0;
	end
	endcase
end		
//(for counter)
always@(posedge scl)
begin
	case(c_t)
	WR_ADDR: begin
		addr_cnt <= addr_cnt +4'd1;
		data_cnt <= 5'd0;
	end
	WR_DAT: begin
		addr_cnt <= 4'd0;
		data_cnt <= data_cnt+ 5'd1;
	end
	default:
	begin
		addr_cnt <= 4'd0;
		data_cnt <= 5'd0;
	end
	endcase
end

endmodule
