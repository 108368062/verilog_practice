module fa (a,b,ci,cout, sum);
input a,b,ci;
output sum,cout;

//method 1
//assign {cout, sum} = a + b + ci; 

//method 2
wire x,y,z;
ha s1 (a, b , x, z); 
ha s2 (ci, x , sum, y); 
or s3 (cout, z, y);

endmodule
