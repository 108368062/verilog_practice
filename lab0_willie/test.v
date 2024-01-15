`timescale 1ps/1ps
module test();
reg A;
reg B;
wire [1:0] out;

adder u1 (.A(A), .B(B), .out(out));

initial
begin
    #150 $finish;
end  

initial
begin
    #10 A = 0; B = 0;
    #10 A = 0; B = 1;
    #10 A = 1; B = 0;
    #10 A = 1; B = 1;
    #10 A = 0; B = 0;
    #10 A = 1; B = 1;
    #10 A = 1; B = 0;
    #10 A = 0; B = 0;
    #10 A = 0; B = 1;
    #10 A = 1'bz; B = 1'bz;
end 

initial
begin
    $monitor("A=%b, B=%b, out=%b", A, B, out);
    $dumpfile("adder.vcd");
    $dumpvars(0, test);
end
endmodule
