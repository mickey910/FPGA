/*part3  4-bit counter using verilog statment Q<=Q+1*/
module part3(KEY, SW, HEX3,HEX2, HEX1, HEX0);
input [3:0] KEY;
input [9:0] SW;
output [6:0] HEX3,HEX2, HEX1, HEX0;
wire clk, enable, reset, out, T0, T1, T2, T3;
reg [3:0] Q ;

assign clk = KEY[0];
assign reset = SW[0];
assign enable = SW[1];
reg [6:0] a, b, c, d;
assign HEX0 = a;
assign HEX1 = b;
assign HEX2 = c;
assign HEX3 = d;
	
always@ (posedge clk)begin //flipflop
	if (~reset)
		Q <= 4'b0;
	else if(enable)
		Q <= Q +1;
	else 
		Q <= Q;
end
always@ (*)begin;//display
	if(Q[0])
		a = 7'b1111001;
	else
		a = 7'b1000000;
	if(Q[1])
		b = 7'b1111001;
	else
		b = 7'b1000000;
	if(Q[2])
		c = 7'b1111001;
	else
		c = 7'b1000000;
	if(Q[3])
		d = 7'b1111001;
	else
		d = 7'b1000000;
end
endmodule