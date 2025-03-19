/*posedge clk*/
module posedge_clk(a, clk, b);

input clk, a;
output b;
reg q;
assign b = q;

always@ (posedge clk)begin
	q = a;
end	

endmodule