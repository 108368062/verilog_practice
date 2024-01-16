module alu(alu_out, accum, data, opcode, zero, clk, reset);
input 		clk, reset;
input 	[7:0] 	accum, data;
input 	[2:0] 	opcode;
output 	reg [7:0] 	 alu_out;
output 		zero;

always@(posedge clk)
begin
    if(reset) alu_out <= 0;
    else
    begin
        case(opcode)
            3'b000: alu_out <= accum;
            3'b001: alu_out <= accum + data;
            3'b010: alu_out <= accum - data;
            3'b011: alu_out <= accum & data;
            3'b100: alu_out <= accum ^ data;
            3'b101: alu_out <= ~accum + 1;
            3'b110: alu_out <= accum*5 + (accum>>3);
            3'b111: alu_out <= (accum >= 8'd32) ? data : ~data;//1's complement 
            default:
            alu_out <= 8'b0;
        endcase
    end
end

assign zero = (accum  == 0 ) ? 1 : 0;//when accum equal 0, zero =1, else zero =0

endmodule
