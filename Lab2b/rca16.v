module rca16(sum, c_out, a, b, c_in);

input [15:0] a, b;
input c_in;
output [15:0] sum;
output c_out;
wire c_in4;
wire c_in8;
wire c_in12;
//assign {c_out, sum} = a + b + c_in;//for debug use only
rca4 s1 ( .sum(sum[3:0]),   .c_out(c_in4),  .a(a[3:0]),  .b(b[3:0]),   .c_in(c_in));
rca4 s2 ( .sum(sum[7:4]),   .c_out(c_in8),  .a(a[7:4]),  .b(b[7:4]),   .c_in(c_in4));
rca4 s3 ( .sum(sum[11:8]),  .c_out(c_in12), .a(a[11:8]), .b(b[11:8]),  .c_in(c_in8));
rca4 s4 ( .sum(sum[15:12]), .c_out(c_out),  .a(a[15:12]),.b(b[15:12]), .c_in(c_in12));

endmodule

//-----------------------//

module rca4(sum, c_out, a, b, c_in);

input [3:0] a, b;
input c_in;
output [3:0] sum;
output c_out;
wire c_in1;
wire c_in2;
wire c_in3;
//assign {c_out, sum} = a + b + c_in;//for debug use only
fa s1 ( .sum(sum[0]), .cout(c_in1),  .a(a[0]),  .b(b[0]),   .ci(c_in));
fa s2 ( .sum(sum[1]), .cout(c_in2),  .a(a[1]),  .b(b[1]),   .ci(c_in1));
fa s3 ( .sum(sum[2]), .cout(c_in3),  .a(a[2]),  .b(b[2]),   .ci(c_in2));
fa s4 ( .sum(sum[3]), .cout(c_out),  .a(a[3]),  .b(b[3]),   .ci(c_in3));

endmodule

//-----------------------//

module fa (a,b,ci,cout, sum);
input a,b,ci;
output sum,cout;

//assign {cout, sum} = a + b + ci;//for debug use only
wire x,y,z;
ha s1 (a, b , x, z); 
ha s2 (ci, x , sum, y); 
or s3 (cout, z, y);

endmodule

//-----------------------//

module ha(a, b , sum, cout);
input a, b;
output sum, cout;

//assign {cout, sum} = a + b;//for debug use only

and u1 (cout, a, b);
xor u2 (sum, a, b);

endmodule