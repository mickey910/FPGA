/*part2
module lab1 (SW, LEDR);
input [17:0]SW;
output [17:0] LEDR;
assign LEDR = SW;
endmodule*/

/*part3: 2-1 multiplexer
module lab1 (SW,LEDR);
input [9:0] SW;
output [9:0] LEDR;
assign LEDR[3] = (~SW[9] & SW[3]) | (SW[9] & SW[7]); 
assign LEDR[2] = (~SW[9] & SW[2]) | (SW[9] & SW[6]); 
assign LEDR[1] = (~SW[9] & SW[1]) | (SW[9] & SW[5]);
assign LEDR[0] = (~SW[9] & SW[0]) | (SW[9] & SW[4]);  
endmodule*/
/*problem: LEDR9~4 light half??
sol: output [3:0] LEDR =>output [9:0] LEDR*/

/*part4: 7-segment display
module lab1 (SW,HEX0);
input [3:0] SW;
output [6:0] HEX0;

assign a = SW[3];
assign b = SW[2];
assign c = SW[1];
assign d = SW[0];
//HEX is common anode configuration 
assign HEX0[6] = ~((~a && b && ~c) || (a && ~b &&~c) || (~a && ~b &&c) || (~a && c && ~d));
assign HEX0[5] = ~((~a && ~c && ~d) || (~a && b && ~c) ||(a &&~b && ~c) ||(~a && b && c && ~d));
assign HEX0[4] = ~((~b && ~c && ~d) || (~a && c &&~d));
assign HEX0[3] = ~((~a && ~b && ~c && ~d) || (~a && b && ~c && d) || (a && ~b && ~c) || (~a && ~b && c) || (~a && c && ~d));
assign HEX0[2] = ~((~a && ~b && ~c) || (~a && b) || (a && ~b && ~c) || (~a && c && d));
assign HEX0[1] = ~((~a && ~b) || (a && ~b && ~c) || (~a && ~c && ~d) || (~a && c && d));
assign HEX0[0] = ~((~a && ~b && ~c && ~d) || (a && ~b && ~c) || (~a && b && d) || (~a && c && ~d ) || (~a && ~b && c));
endmodule*/

/*part5: BCD binary coded decimal
module lab1 (SW,HEX1,HEX0);
input [3:0] SW;
output [6:0] HEX1, HEX0;

assign a = SW[3];
assign b = SW[2];
assign c = SW[1];
assign d = SW[0];
//HEX is common anode configuration 
assign HEX0[6] = ~((b && ~c) || (b &&~d) || (a && ~c) || (a && b) || (~a && ~b && c));
assign HEX0[5] = ~((~a && ~c && ~d) || (~a && b && ~c) || (~a && b && ~d) || (a && ~b && ~c) || (a && ~b && ~d) || (a && b && c));
assign HEX0[4] = ~((~b && ~d) || (~a && c && ~d) || (a && ~c && ~d));
assign HEX0[3] = ~((~b && ~d) || (a && ~c) || (~a && ~b && c) || (~a && c && ~d) || (b && ~c && d) || (a && b && d));
assign HEX0[2] = ~((d) || (~a && ~c) || (b && c) || (a && ~b));
assign HEX0[1] = ~((~b) || (~c && ~d) || (a &&~c) || (a &&~d) || (~a && c && d));
assign HEX0[0] = ~((~b && ~d) || (~a && c) || (b && d) || (a && ~c));

assign HEX1[6] = ~(0);
assign HEX1[5] = ~((~a) || (~b && ~c));
assign HEX1[4] = ~((~a) || (~b && ~c));
assign HEX1[3] = ~((~a) || (~b && ~c));
assign HEX1[2] = ~(1);
assign HEX1[1] = ~(1);
assign HEX1[0] = ~((~a) || (~b && ~c));
endmodule*/

/*part6: Full Adder
module lab1 (SW, LEDR);
input [17:0]SW;
output [17:0] LEDR;
wire Cin, Cout;
wire[3:0] A, B, S;
wire [3:1] C;

assign {Cin, B, A} = SW [8:0];
assign  LEDR[4:0] = {Cout, S};

assign S[0] = ((Cin)^(A[0] ^ B[0]));
assign C[1] = (~(A[0] ^ B[0]) & B[0]) | ((A[0] ^ B[0]) & Cin);
assign S[1] = ((C[1])^(A[1] ^ B[1]));
assign C[2] = (~(A[1] ^ B[1]) & B[1]) | ((A[1] ^ B[1]) & C[1]);
assign S[2] = ((C[2])^(A[2] ^ B[2]));
assign C[3] = (~(A[2] ^ B[2]) & B[2]) | ((A[2] ^ B[2]) & C[2]);
assign S[3] = ((C[3])^(A[3] ^ B[3]));
assign Cout = (~(A[3] ^ B[3]) & B[3]) | ((A[3] ^ B[3]) & C[3]);
endmodule*/

/*part7: Add two 1-digit BCD numbers*/
module lab1(SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
input [9:0] SW;
output [9:0] LEDR;
output [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

wire Cin, Cout;
wire[3:0] A, B, S;
wire [3:1] C;
//Full Adder
assign A = SW [7:4];
assign B = SW [3:0];
assign Cin = SW[8];

assign S[0] = ((Cin)^(A[0] ^ B[0]));
assign C[1] = (~(A[0] ^ B[0]) & B[0]) | ((A[0] ^ B[0]) & Cin);
assign S[1] = ((C[1])^(A[1] ^ B[1]));
assign C[2] = (~(A[1] ^ B[1]) & B[1]) | ((A[1] ^ B[1]) & C[1]);
assign S[2] = ((C[2])^(A[2] ^ B[2]));
assign C[3] = (~(A[2] ^ B[2]) & B[2]) | ((A[2] ^ B[2]) & C[2]);
assign S[3] = ((C[3])^(A[3] ^ B[3]));
assign Cout = (~(A[3] ^ B[3]) & B[3]) | ((A[3] ^ B[3]) & C[3]);
//BCD
//HEX1~0
wire a,b,c,d;
assign a = SW[3];
assign b = SW[2];
assign c = SW[1];
assign d = SW[0];

assign HEX0[6] = ~((b && ~c) || (b &&~d) || (a && ~c) || (a && b) || (~a && ~b && c));
assign HEX0[5] = ~((~a && ~c && ~d) || (~a && b && ~c) || (~a && b && ~d) || (a && ~b && ~c) || (a && ~b && ~d) || (a && b && c));
assign HEX0[4] = ~((~b && ~d) || (~a && c && ~d) || (a && ~c && ~d));
assign HEX0[3] = ~((~b && ~d) || (a && ~c) || (~a && ~b && c) || (~a && c && ~d) || (b && ~c && d) || (a && b && d));
assign HEX0[2] = ~((d) || (~a && ~c) || (b && c) || (a && ~b));
assign HEX0[1] = ~((~b) || (~c && ~d) || (a &&~c) || (a &&~d) || (~a && c && d));
assign HEX0[0] = ~((~b && ~d) || (~a && c) || (b && d) || (a && ~c));

assign HEX1[6] = ~(0);
assign HEX1[5] = ~((~a) || (~b && ~c));
assign HEX1[4] = ~((~a) || (~b && ~c));
assign HEX1[3] = ~((~a) || (~b && ~c));
assign HEX1[2] = ~(1);
assign HEX1[1] = ~(1);
assign HEX1[0] = ~((~a) || (~b && ~c));

//HEX3~2
wire a2,b2,c2,d2;
assign a2 = SW[7];
assign b2 = SW[6];
assign c2 = SW[5];
assign d2 = SW[4];

assign HEX2[6] = ~((b2 && ~c2) || (b2 && ~d2) || (a2 && ~c2) || (a2 && b2) || (~a2 && ~b2 && c2));
assign HEX2[5] = ~((~a2 && ~c2 && ~d2) || (~a2 && b2 && ~c2) || (~a2 && b2 && ~d2) || (a2 && ~b2 && ~c2) || (a2 && ~b2 && ~d2) || (a2 && b2 && c2));
assign HEX2[4] = ~((~b2 && ~d2) || (~a2 && c2 && ~d2) || (a2 && ~c2 && ~d2));
assign HEX2[3] = ~((~b2 && ~d2) || (a2 && ~c2) || (~a2 && ~b2 && c2) || (~a2 && c2 && ~d2) || (b2 && ~c2 && d2) || (a2 && b2 && d2));
assign HEX2[2] = ~((d2) || (~a2 && ~c2) || (b2 && c2) || (a2 && ~b2));
assign HEX2[1] = ~((~b2) || (~c2 && ~d2) || (a2 &&~c2) || (a2 &&~d2) || (~a2 && c2 && d2));
assign HEX2[0] = ~((~b2 && ~d2) || (~a2 && c2) || (b2 && d2) || (a2 && ~c2));

assign HEX3[6] = ~(0);
assign HEX3[5] = ~((~a2) || (~b2 && ~c2));
assign HEX3[4] = ~((~a2) || (~b2 && ~c2));
assign HEX3[3] = ~((~a2) || (~b2 && ~c2));
assign HEX3[2] = ~(1);
assign HEX3[1] = ~(1);
assign HEX3[0] = ~((~a2) || (~b2 && ~c2));

//HEX5~4 5bit-BCD
wire a3,b3,c3,d3;
assign a3 = Cout;
assign b3 = S[3];
assign c3 = S[2];
assign d3 = S[1];
assign e3 = S[0];

assign HEX4[6] = ~((b3 & ~d3) | (~b3 & ~c3 & d3) | (~b3 & d3 & ~e3) | (~a3 & c3 & ~d3) | (~a3 & b3 & c3) | (a3 & ~c3 & ~e3) | (a3 & ~b3 & d3));
assign HEX4[5] = ~((~b3 & ~d3 & ~e3) | (b3 & ~c3 & ~d3) | (b3 & d3 & ~e3) | (a3 & b3 & ~d3) | (~a3 & ~b3 & c3 & ~d3) | (~a3 & ~b3 & c3 & ~e3) | (~a3 & b3 & c3 & d3) | (a3 & ~b3 & ~c3 & d3));
assign HEX4[4] = ~((~b3 & ~c3 & ~e3) | (~b3 & d3 & ~e3) | (~c3 & d3 & ~e3) | (a3 & c3 & ~e3) | (~a3 & b3 & ~d3 & ~e3));
assign HEX4[3] = ~((~a3 & ~c3 & ~e3) | (~b3 & ~c3 & d3) | (~b3 & d3 & ~e3) | (b3 & ~d3 & e3) | (b3 & c3 & ~d3) | (a3 & ~b3 & ~e3) | (a3 & ~b3 & d3) | (a3 & d3 & ~e3) | (~a3 & c3 & ~d3 & e3) | (~a3 & b3 & c3 & e3));
assign HEX4[2] = ~(e3 | (~c3 & ~d3) | (b3 & d3) | (a3 & ~c3) | (a3 & ~d3) | (~a3 & ~b3 & c3));
assign HEX4[1] = ~((a3 & c3) | (~a3 & ~d3 & ~e3) | (~b3 & ~c3 & e3) | (~b3 & ~c3 & d3) | (~b3 & d3 & e3) |(~c3 & d3 & e3) | (~a3 & b3 & ~d3) | (~a3 & b3 & ~e3) | (b3 & ~d3 & ~e3));
assign HEX4[0] = ~((~b3 & d3) | (~a3 & ~c3 & ~e3) | (~a3 & c3 & e3) | (~a3 & b3 & ~d3) | (b3 & c3 & ~d3) | (a3 & ~b3 & ~e3) | (a3 & ~c3 & e3) | (a3 & d3 & ~e3)); 

assign HEX5[6] = ~((a3 & c3) | (a3 & b3));
assign HEX5[5] = ~((~a3 & ~b3) | (~a3 & ~c3 & ~d3));
assign HEX5[4] = ~((~a3 & ~b3) | (~b3 & c3) | (~a3 & ~c3 & ~d3) | (a3 & c3 & ~d3) | (a3 & b3 & ~c3));
assign HEX5[3] = ~((~a3 & ~b3) | (~b3 & c3) | (a3 & b3) | (~a3 & ~c3 & ~d3));
assign HEX5[2] = ~(~a3 | (~b3 & ~c3) | (b3 & c3 & d3));
assign HEX5[1] = ~(1);
assign HEX5[0] = ~((~a3 & ~b3) | (~b3 & c3) | (a3 & b3) | (~a3 & ~c3 & ~d3));

//ERROR LEDR[9]

assign LEDR[9] = ((a & c) | (a & b)) | ((a2 & c2) | (a2 & b2));
endmodule