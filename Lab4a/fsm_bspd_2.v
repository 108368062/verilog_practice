// Serial Input BitStream Pattern Detector
module fsm_bspd(clk, reset, bit_in, det_out);
input 	clk, reset, bit_in;
output 	reg det_out;

parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;

//c_t = current state
//n_t = next state
reg [1:0] c_t, n_t;//n_t declare is not used
//CS and NS
always@(posedge clk)
begin
    if(reset)
        c_t <= s0;
    else
    begin
        case(c_t)
        s0: c_t = bit_in? s0 : s1;
        s1: c_t = bit_in? s0 : s2;
        s2: c_t = bit_in? s3 : s2;
        s3: c_t = bit_in? s0 : s1;
        default:
            n_t = s0;
        endcase
    end   
end

//OL
 always@(*)
begin
    case(c_t)
    s0: det_out = bit_in? 1'b0 : 1'b0;
    s1: det_out = bit_in? 1'b0 : 1'b0;
    s2: det_out = bit_in? 1'b0 : 1'b0;
    s3: det_out = bit_in? 1'b0 : 1'b1;
    default:
        det_out = 0;
    endcase
end

endmodule

