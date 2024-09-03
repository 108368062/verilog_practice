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

//register declaration
reg [2:0] cur_st, next_st;
reg [7:0] mem [8:0];//9x8bit memory
reg [5:0] p_cnt; //gray mem counter
reg [3:0] r_cnt;//read counter
reg finish;
reg gray_req;

//state 
parameter IDLE   = 3'b000;
parameter READ   = 3'b001;
parameter CALC   = 3'b010;
parameter WRITE  = 3'b011;
parameter OUT    = 3'b100;

always@(posedge clk or posedge reset) begin
    if (reset)
       cur_st <= IDLE;
    else
       cur_st <= next_st;   
end

always@(*) begin
    case(cur_st)
    IDLE: begin
       finish = 1'b0;
       gray_req = 1'b0;
    end   
    READ: begin
       finish = 1'b0;
       gray_req = 1'b1;
    end
    WRITE: begin
       lbp_addr = p_cnt;
       lbp_write = 1'b1;
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
    IDLE:
       next_st = READ;
    READ: begin
       if(r_cnt < 4'd8)
            next_st = READ;
        else
            next_st = CALC;
    end
    CALC: begin
            next_st = READ;
    end    
    default:
       next_st = WRITE;
    endcase
end

//read count for read 9 data
// 0 1 2
// 3 4 5
// 6 7 8
always@(posedge clk or posedge reset) begin
    if (reset)
       r_cnt <= 4'd0;
    else if(cur_st == READ)
       r_cnt <= r_cnt + 4'd1;
    else 
       r_cnt <=4'd0;
end

//pixle count for read all memory
// 0 1 2 4 5 6 7 8
// ...
// ...           63
always@(posedge clk or posedge reset) begin
    if (reset)
       p_cnt <= 6'd0;
    else if(r_cnt == 8'd8)
       p_cnt <= p_cnt + 6'd1;
    else 
       p_cnt <= p_cnt;
end

endmodule
