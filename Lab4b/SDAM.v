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
	STR    : n_t = (sda)? WR_ADDR:RD;//1:write, 0:read
	WR_ADDR: n_t = (addr_cnt == 4'd8)? WR_DAT:WR_ADDR; 
	WR_DAT : n_t = (data_cnt == 5'd16)? OUT:WR_DAT; 
	OUT    : n_t = IDLE;
	default:
		n_t = IDLE;
	endcase
end
//OL-1
always@(*)
begin
	case(c_t)
	IDLE: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'h0;
		dout = 16'h00;
		address = 8'd0;
		data = 16'd0;
	end
	STR: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'h0;
		dout = 16'h00;
		address = 8'd0;
		data = 16'd0;
	end
	WR_ADDR: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'h0;
		dout = 16'h00;
		case(addr_cnt)
		4'd1:address[0] = sda;
		4'd2:address[1] = sda;
		4'd3:address[2] = sda;
		4'd4:address[3] = sda;
		4'd5:address[4] = sda;
		4'd6:address[5] = sda;
		4'd7:address[6] = sda;
		4'd8:address[7] = sda;
		default:
			address = 8'd0;
		endcase
	end
	WR_DAT: begin
		avalid = 1'b0;
		dvalid = 1'b0;
		aout = 8'h0;
		dout = 16'h00;
		case(data_cnt)
		4'd1:data[0] = sda;
		4'd2:data[1] = sda;
		4'd3:data[2] = sda;
		4'd4:data[3] = sda;
		4'd5:data[4] = sda;
		4'd6:data[5] = sda;
		4'd7:data[6] = sda;
		4'd8:data[7] = sda;
		4'd9:data[8] = sda;
		4'd10:data[9] = sda;
		4'd11:data[10] = sda;
		4'd12:data[11] = sda;
		4'd13:data[12] = sda;
		4'd14:data[13] = sda;
		4'd15:data[14] = sda;
		4'd16:data[14] = sda;
		default:
			data = 16'd0;
		endcase
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
		aout = 8'h0;
		dout = 16'h00;
	end
	endcase
end		
//OL-2 (for counter)
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
