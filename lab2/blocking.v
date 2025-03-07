module blocking(in, a, b, c, clk);
input in, clk;
output reg a,b,c;

always@(posedge clk)begin
	a = in;
	b = a;
	c = b;	
end

endmodule