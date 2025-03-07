module noblocking(IN, A, B, C, clk);
input IN, clk;
output reg A,B,C;

always@(posedge clk)begin
	A <= IN;
	B <= A;
	C <= B;	
end

endmodule