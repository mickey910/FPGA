/*part2-2 16-bitcounter using Tflip-flop module*/
module part2_2(KEY, SW, HEX3,HEX2, HEX1, HEX0);
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

assign T0 = enable;
assign T1 = Q[0] & T0;
assign T2 = Q[1] & T1;
assign T3 = Q[2] & T2;

always@ (posedge clk)begin //flipflop0
	if(T0)
		Q[0] = ~Q[0];
//flipflop1
	if(T1)
		Q[1] = ~Q[1];
//flipflop2
	if(T2)
		Q[2] = ~Q[2];
//flipflop3
	if(T3)
		Q[3] = ~Q[3];
//reset
	if(~reset)
		Q[3:0] = 4'b0;

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