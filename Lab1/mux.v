`define dly_and 0.5
`define dly_or 0.3
`define dly_not 0.4
module mux (out,a,b,sel);
input a, b, sel;
output out;

/*
//method 1
output reg out;

always@(*)
begin
    if(sel)
        out = b;
    else
        out = a; 
end
*/
//method 2
and #`dly_and u1 (a1, a, sel_);
not #`dly_not u2 (sel_, sel);
and #`dly_and u3 (b1, sel, b);
or  #`dly_or  u4 (out, a1, b1);

endmodule
