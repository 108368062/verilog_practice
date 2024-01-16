module ha(a, b , sum, cout);
input a, b;
output sum, cout;

//method 1
//assign {cout, sum} = a + b;

//method 2
and u1 (cout, a, b);
xor u2 (sum, a, b);

endmodule
