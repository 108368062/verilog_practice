/********************************************************************
 * Model of RAM Memory - Verilog Training Course.
 *********************************************************************/

`timescale 1ns / 1ns

module mem(data,addr,read,write);
  inout [7:0] data;
  input [4:0] addr;
  input       read, write;

reg [7:0]mem[31:0];


always@(posedge write)
begin
    mem[addr] = data;
end 

assign data = (read)? mem[addr] : 1'bz;

endmodule
