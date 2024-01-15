module adder(
input A,
input B,
output reg [1:0] out
);

always@(*)
begin
    out = A + B;
end

endmodule
