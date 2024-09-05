module LBP ( clk, reset, gray_addr, gray_req, gray_data, lbp_addr, lbp_write, lbp_data, finish);
input   	clk;
input   	reset;
output  [5:0] 	gray_addr;
output         	gray_req;
input   [7:0] 	gray_data;
output  [5:0] 	lbp_addr;
output  	lbp_write;
output  [7:0] 	lbp_data;
output  	finish;

//wire declaration

//register declaration
reg [2:0] cur_st, next_st;
reg [7:0] mem [8:0];//9x8bit memory
reg [5:0] p_cnt_pre; //gray mem counter
reg [5:0] p_cnt; //gray mem counter
reg [3:0] r_cnt;//read counter
reg finish;
reg gray_req;
reg [5:0]   gray_addr;
reg [5:0] 	lbp_addr;
reg      	lbp_write;
reg [7:0] 	lbp_data;
reg [5:0]   pixel_addr;
reg [7:0]   result;

parameter SIZE   = 6'd8;
//state 
parameter IDLE   = 3'b000;//not use!!
parameter STR    = 3'b001;//start read
parameter READ   = 3'b010;
parameter EDRD   = 3'b011;
parameter CALC   = 3'b100;
parameter WRITE  = 3'b101;
parameter OUT    = 3'b110;

always@(posedge clk or posedge reset) begin
    if (reset)
       cur_st <= STR;
    else
       cur_st <= next_st;   
end

always@(*) begin
    case(cur_st)  
    STR: begin
       finish = 1'b0;
       gray_req = 1'b1;
	   gray_addr = pixel_addr;
      lbp_write = 1'b0;
      lbp_data = 8'h00;
    end
   READ: begin
       finish = 1'b0;
       gray_req = 1'b1;
	    gray_addr = pixel_addr;
      lbp_write = 1'b0;
       lbp_data = 8'h00;
    end
     CALC: begin
      finish = 1'b0;
       gray_req = 1'b0;
	    gray_addr = 6'd0;
      lbp_write = 1'b0;
      lbp_data = 8'h00;
      result = 1*(mem[0]>=mem[4])+2*(mem[1]>=mem[4])+4*(mem[2]>=mem[4])+
               8*(mem[3]>=mem[4])+16*(mem[5]>=mem[4])+
               32*(mem[6]>=mem[4])+64*(mem[7]>=mem[4])+128*(mem[8]>=mem[4]);
    end
    WRITE: begin
       lbp_addr = (p_cnt/6)*8 + (p_cnt%6) + 6'd9;
       lbp_write = 1'b1;
       lbp_data = result;
    end
    OUT:
       finish = 1'b1;
    default: begin
       finish = 1'b0;
       gray_req = 1'b0;
       lbp_write = 1'b0;
    end   
    endcase
end

always@(*) begin
    case(cur_st)
	STR:
	    next_st = READ;
    READ: begin
       if(r_cnt < 4'd8)
            next_st = READ;
        else
            next_st = EDRD;
      end
     EDRD:
	    next_st = CALC;
    CALC:
            next_st = WRITE;
    WRITE: begin
        if(p_cnt <6'd36)
            next_st = STR;
        else
            next_st = OUT;
    end    
    default:
       next_st = STR;
    endcase
end

//read count for read 9 data
// 0 1 2
// 3 4 5
// 6 7 8
always@(posedge clk or posedge reset) begin
    if (reset)
       r_cnt <= 4'd0;
    else if((cur_st == READ | cur_st == STR )& r_cnt < 4'd8)
       r_cnt <= r_cnt + 4'd1;
   else if(cur_st == WRITE)
      r_cnt <=4'd0;
    else 
       r_cnt <=r_cnt;
end

//pixle count for read all memory
// 0 1 2 4 5 6 7 8
// ...
// ...           63
//6x6=36
always@(posedge clk or posedge reset) begin
    if (reset)
       p_cnt_pre <= 6'd0;
    else if(r_cnt == 8'd8 && cur_st == CALC)
       p_cnt_pre <= p_cnt_pre + 6'd1;
    else 
       p_cnt_pre <= p_cnt_pre;
end
always@(posedge clk or posedge reset) begin
    if (reset)
       p_cnt <= 6'd0;
    else if(cur_st == WRITE)
       p_cnt <= p_cnt_pre;
    else 
       p_cnt <= p_cnt;
end

always@(posedge clk or posedge reset) begin
   if (reset)
      for(integer i=0;i<9;i=i+1)
       mem[i] =8'd0;
   else if(cur_st == STR | cur_st == READ | cur_st == EDRD)
       mem[r_cnt]= gray_data;
   else
      for(integer i=0;i<9;i=i+1)
        mem[i] =mem[i];
end

//decode to 3x3 adddress
always@(*) begin
    case(r_cnt)
	4'd0:pixel_addr= (p_cnt/6)*8 + (p_cnt%6);
   4'd1:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd1;
	4'd2:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd2;
	4'd3:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd8;
	4'd4:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd9;
	4'd5:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd10;
	4'd6:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd16;
	4'd7:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd17;
	4'd8:pixel_addr= (p_cnt/6)*8 + (p_cnt%6) + 6'd18;
	default: pixel_addr = 6'd0;
	endcase
end
//for debug use only
wire [7:0]debug_mem0;
wire [7:0]debug_mem1;
wire [7:0]debug_mem2;
wire [7:0]debug_mem3;
wire [7:0]debug_mem4;
wire [7:0]debug_mem5;
wire [7:0]debug_mem6;
wire [7:0]debug_mem7;
wire [7:0]debug_mem8;
assign debug_mem0 = mem[0];
assign debug_mem1 = mem[1];
assign debug_mem2 = mem[2];
assign debug_mem3 = mem[3];
assign debug_mem4 = mem[4];
assign debug_mem5 = mem[5];
assign debug_mem6 = mem[6];
assign debug_mem7 = mem[7];
assign debug_mem8 = mem[8];

endmodule
