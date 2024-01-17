// Serial Input BitStream Pattern Detector
module fsm_bspd(clk, reset, bit_in, det_out);
input 	clk, reset, bit_in;
output 	det_out;

//not finite state machine method

reg [3:0] temp;
always@(posedge clk)
begin
    if(reset)
        temp <= 3'd0;
    else
    begin
        //mem[0] <= bit_in;
        temp[1] <= temp[0];
        temp[2] <= temp[1];
        temp[3] <= temp[2];
    end
end

always@(*)
begin
    temp[0] = bit_in;
end
assign det_out = (temp == 4'b0010)? 1: 0; 

endmodule

