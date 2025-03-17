/*part1 Adder 8bit sign number */
module part1(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
input [9:0] SW;
input [3:0] KEY;

output [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

wire [7:0] A0,B0,A1,B1,S0,S1,overflow,Overflow;
reg [7:0] reg_A,reg_B;
assign A0 = reg_A;
assign B0 = reg_B;
assign rest = KEY[0];
assign clk = KEY[1];
assign select = SW[8];

always@(posedge clk)begin
	if(SW[8] == 0 && KEY[0] == 1 )
		reg_A = SW[7:0];
	else if(SW[8] == 1 && KEY[0] == 1 )
		reg_B = SW[7:0];
	else begin
		reg_A = 0;
		reg_B = 0;
	end	
end
//ff
FF f1(
	.clock(clk),
	.R(A0),
	.Q(A1)
);
FF f2(
	.clock(clk),
	.R(B0),
	.Q(B1)
);
FF f3(
	.clock(clk),
	.R(S0),
	.Q(S1)
);
FF f4(
	.clock(clk),
	.R(overflow),
	.Q(Overflow)
);
//full adder
full_adder fd(
	.v1(A1),
	.v2(B1),
	.Cin(0), 
	.Cout(overflow), 
	.OUT(S0)
);
assign LEDR = {Overflow, S1};
endmodule
/*================== SUBMODULE ============================*/
//flip-flpop
module FF(clock, R, Q);
input clock;
input [7:0] R;
output reg[7:0] Q;

always @(posedge clock)
		Q <= R;
endmodule		


//full adder
module full_adder (v1, v2, Cin, Cout, OUT);
input [7:0] v1, v2;
input Cin;
output [7:0] OUT;
output Cout;

wire[7:0] A, B, S;
wire [7:1] C;

assign A = v1;
assign B = v2;
assign S[0] = ((Cin)^(A[0] ^ B[0]));
assign C[1] = (~(A[0] ^ B[0]) & B[0]) | ((A[0] ^ B[0]) & Cin);
assign S[1] = ((C[1])^(A[1] ^ B[1]));
assign C[2] = (~(A[1] ^ B[1]) & B[1]) | ((A[1] ^ B[1]) & C[1]);
assign S[2] = ((C[2])^(A[2] ^ B[2]));
assign C[3] = (~(A[2] ^ B[2]) & B[2]) | ((A[2] ^ B[2]) & C[2]);
assign S[3] = ((C[3])^(A[3] ^ B[3]));
assign C[4] = (~(A[3] ^ B[3]) & B[3]) | ((A[3] ^ B[3]) & C[3]);
assign S[4] = ((C[4])^(A[4] ^ B[4]));
assign C[5] = (~(A[4] ^ B[4]) & B[4]) | ((A[4] ^ B[4]) & C[4]);
assign S[5] = ((C[5])^(A[5] ^ B[5]));
assign C[6] = (~(A[5] ^ B[5]) & B[5]) | ((A[5] ^ B[5]) & C[5]);
assign S[6] = ((C[6])^(A[6] ^ B[6]));
assign C[7] = (~(A[6] ^ B[6]) & B[6]) | ((A[6] ^ B[6]) & C[6]);
assign S[7] = ((C[7])^(A[7] ^ B[7]));
assign Cout = (~(A[7] ^ B[7]) & B[7]) | ((A[7] ^ B[7]) & C[7]);
assign OUT = S;
endmodule